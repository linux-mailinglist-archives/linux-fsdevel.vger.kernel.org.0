Return-Path: <linux-fsdevel+bounces-20047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D438CD183
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48FC1F21CD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5713BAFB;
	Thu, 23 May 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FWYl+69i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DzMhdq25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB213307B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464957; cv=fail; b=SA9mYP67frt09/CAM5+sRH//fvYP5pY0xpwJY02MNGUcz5P2nlq19CXHQnXXTLX7yv6ZpxVAFuplMnZL2y7g92/zWQTbPkqTZ7G5F/v9XURChFdmL9HGIjcJ44n02MIjo3uB7Tvb54BjDX5ov4W4h2+Jb3wKyetGCDqtaPisJfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464957; c=relaxed/simple;
	bh=bhUaItM0ho4i+iNP77SSVoch3bBzMdePAfuIKlmTOrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNXyMrrydYkEBX9+Qn6Dlj/T54trAb8E4pp43PNpHISxWpGWLKfpqup9crdstQarJsrmH1aF/KWROYerM9MKS582M8FtxkJ1CyXYAXSUL4fxV6k9Bq1QJ24uqSFD9ByjZM1Y23x+HaTgllkyVPZMtL3LlTWadjpJAMWQU+Q/Iq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FWYl+69i; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DzMhdq25; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716464956; x=1748000956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bhUaItM0ho4i+iNP77SSVoch3bBzMdePAfuIKlmTOrg=;
  b=FWYl+69inVWazEOdNvVGbo+LIBMYzdF6AzLPstVaDvfKjjF5hxEPQixx
   o2GZ9rlT3wNWpueFlMIjKxb0DrFgo3gtguyR/yeGl6deTilkZcFKSLmof
   vEyepa2Ql+DFSz9QukzxeG/10ZtLcZlQ2N6uHOzm4ed6SfCyJzXsBEFN4
   NE1VSWtKI7cziHOaTaNM/BxV63/vFmZCU7o1Tg5hBy/6SH+3YiZyjhMuk
   SiheGPv1HFeZSVdCtCUtOiJc33vEj+d49VPyHmLi8sp9aTE4CDKgeNem+
   Uo0g1pLzjqzi+ZIBnyP0CYAijXBaDIK3AYhnhDApsHzic4ffR8w0Bt38j
   Q==;
X-CSE-ConnectionGUID: WyXpAb5zT1iYysbACUp6JA==
X-CSE-MsgGUID: RamaBnYxTWSj8KQ1ZMlx9g==
X-IronPort-AV: E=Sophos;i="6.08,182,1712592000"; 
   d="scan'208";a="16806123"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 19:49:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiRmNZraGzTZ+xihFAzmHiIMJ4KXFVtIkD+E3O4dTTuwz3sEi2F21ybx2DKPlFQcVaCw8NQ2ccBnDaXSeq+OQYaQtzTvvBxsb7LMQWrHzIN9RyYAFQRindQaWeR7Jic/DMZ9iPaM9ciFiCVG9AL25njE0kIsBzEJChCZNSE6USWRFp/2LCRz1+daKJtXj44wzhk4GZZWNkJE6ihxOmVXx02ViDxiILg89jSEJX8RR/cUhqSmyq8GiohCQgM+SjwBrm2+/2BJ1Mwr6M4zPzvOG+978OXY2cyh79wC8etV0huZKH6fSY1PKECeNr1kHusOmsqil+2dHncUI9y2SmS2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhUaItM0ho4i+iNP77SSVoch3bBzMdePAfuIKlmTOrg=;
 b=ThHy01mYHxBhLGVepAplgOASxYk0JHAmB/+yvhmYY5XxbrdsuARfWYhYOvGLjiYXhqFf6T9SSYiiXa2aFPhF02ENd9a9fhVO0R6UkYEVYnaloD9ODnJXooPhm3UCzErZIcVSYUs1/BENYhc2WNNzymMqql9y+vAChNqV+wDSIpPxPjNX+eobTgwc8OxCGGKyW8svTpK6Kou3ZTstIBwJzTNXK+dfAtBq9fusMQSJJ4T7aiFcTGlM011bZL520wcfNrlTXy6a7Y4Mt/E+VG6+afO0hqstMgsrZuMg3d1jpVaI6hpCfB+Pmtq9woFfMe0clgC+AHw4HM/UTk/w2CSCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhUaItM0ho4i+iNP77SSVoch3bBzMdePAfuIKlmTOrg=;
 b=DzMhdq252zRrTWl9Ll0YD6H1IMUG3uCfTtcysFd0IEwfrzZ+Sp/Ptamj/eOnCK1smSWM6mj+KQD87Flz4MpgCVNmGqaU7ClQy5PY1uBNn1KIMcQUp3UM/Ij3DxMIjXk+U02+CIIAVo2oF7t7ZvTv2jbPnvfLIcNEruPUAHiUyPk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8835.namprd04.prod.outlook.com (2603:10b6:208:48f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 23 May
 2024 11:49:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 11:49:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Johannes Thumshirn <jth@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
Thread-Topic: [PATCH] zonefs: move super block reading from page to folio
Thread-Index: AQHaphKEay3/HRu5skyKH+AXaWfCPLGkGJ+AgACJgQCAAB/lgIAAAEmA
Date: Thu, 23 May 2024 11:49:11 +0000
Message-ID: <ccac76a8-1f2a-4af0-bdf1-9f226aa8c7c0@wdc.com>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
 <7839c762-3e2e-4124-a42f-6c15f3d8fea4@wdc.com>
 <Zk8s-ZnFQuKTjY2R@casper.infradead.org>
In-Reply-To: <Zk8s-ZnFQuKTjY2R@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8835:EE_
x-ms-office365-filtering-correlation-id: af638731-0ace-4544-5b21-08dc7b1e5cae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWNiSDZrdTJuSjRCaUlxSkw2MHY0WmlSRzRGd3Vkc2E5S0RtRHovUDRQeHdw?=
 =?utf-8?B?c2pacGdsTE4wbERrMHVJdG9vT0ZhSXlsbEZaSGN2MUNqYzVsOVY2VEFXcW5I?=
 =?utf-8?B?SzVXck1DUHkyVmdsdkcyUXZsdkU0Zi84UTdwWU1LeEZpVTY0YzVWU3B3ck00?=
 =?utf-8?B?dlpXc1VEMmFOd3VKWnJ4ZU9YZlZXR21IWjBSYUNqdGF2UzFIazVsb2VGUnJk?=
 =?utf-8?B?S3VwUFA3b0JzRkhVbGZ3enNxLzVLSFFmQysvbWZjSitpSXdDZnhCS3RNdWtW?=
 =?utf-8?B?dE1ZM2oxRUpkQS93cU1DTncvdG9YcVFod1g5b3REdVpkOWw1Q003RTRMaW9R?=
 =?utf-8?B?c2F4VVp6blp0U1I3RVlWZmdBWHlPNnU5bEZ2bytXNll1V0ZHa0F2VThCa1hl?=
 =?utf-8?B?RDMyVkRibmluNTlLd1ZUbVIrTkpTc2dzanpvTEw3ZUw2ejBKT1M3NG9PNjAz?=
 =?utf-8?B?QjdHVXAvVjBaQnZWb0tlSlZ3VlpwV3N5UlJ6RkhPME00NHQxdzcxMEcyYVZN?=
 =?utf-8?B?MzFLbjl0SDJGQmlUMkxRakJOUzQ3ekRWYmw3M1BMVDlCb1dkbVF5bnMwWjRh?=
 =?utf-8?B?R1NlMmdhYmRRdlRzaUFMdjNqMXVDQzJBME40azdjRmtLUkIrYmp2eUJUZ2J3?=
 =?utf-8?B?WWNRdkIxMFZxemw5eVhlODdkWTFkd2ExckxlUk94eVZqMFVZWm5FSm5YTG1H?=
 =?utf-8?B?M1JHdkRGcW5PTWxkMjZiL21VWlpvcmR6RVZlQlp4SWpmcnI3eFk2R2wwQ1R2?=
 =?utf-8?B?ZHI3aGZwUFRsUUFiRmMzN3VkOStlTXNrMVJVNWRzV2RoaWd4Q1hvVFJ6aVVG?=
 =?utf-8?B?SEc5eEtqdUZEeVRoUU0vbGQ4V0o1MmdCcWl0OTJaWGVPakNzdG8xc3hCM1NK?=
 =?utf-8?B?Zmg2MUMwMFRZbzdnaWNydERWYkZhcUNlOXcrNmQzL0VnYzlGaDNTR29pUWtM?=
 =?utf-8?B?M2xwSlZpa0pQQ1FSWnVoRGx3UHlrdG1oWDJSbVZoYnJ4MHpvVG8zOHN6RDIw?=
 =?utf-8?B?a1JUZkZlZHN3dk1EbUp5dU9JaFZ6c3FpM251T3lWYlByYks0NGhvQkxEZmtD?=
 =?utf-8?B?OXlDWWJxTTZPT3FhVVJscmpITGxrdndCbWw0T0s5TGdVRGRKVERraVFEYTVv?=
 =?utf-8?B?elNaU05tVUxpQmliS1ExbEJmTkhSTnd6RSs0YjVzRHY0KzBCTlRDOGIwWTRJ?=
 =?utf-8?B?czloWmhRRkFQRXlwTjg4U1krdVluRTlsaHl3b21HNXZkVkNlQUpBYzdRUHRa?=
 =?utf-8?B?UXF1dk5oMDFLQzZkQUpyekZnakVKMUc5U0hpcGJsaVZyL1A0MSt3UnVqZFEr?=
 =?utf-8?B?dmNzMzRDRVEyb2dZekZ5TkZ6R3BHWGJPbjB3d0RkNmJscVhUZ1dXUUJ2Nnda?=
 =?utf-8?B?bmo1WUt5SDViNDlOd1RBeDg5d0t4N01UOUNhOGtYNXhUWFZvSys0M01NTC82?=
 =?utf-8?B?d1UrNWNyY3NieWxlMFV0QjNCbjRhRkhMOWYzT1BkM05UQVZuR1B6OVNTV0RV?=
 =?utf-8?B?MGNrZTNLYmlYT093MkpIYXBieFM0eER5Z0JjQnM4QWRML0RNODl6ZDcvZjlX?=
 =?utf-8?B?ckRSTEhRa1AvMEc1VHVDekdRaDZSZFpJTU1FZHdjMXlpSm1kWWtWMERNNkkv?=
 =?utf-8?B?Z1J2OWhwUk5WQTFSTG81Zlg4aWhHWjBCRlFNNy90SnJWSXUvSXdNQlBxWHRQ?=
 =?utf-8?B?NmcxOU5CaTZwc2UvN2Y2QXJZMHlOZEhtR0VsS3NCQlZINGt0dE9KZlFMcFU0?=
 =?utf-8?B?ZmlUOXdZMUJ1TGVUSkZkMEpjMVp2M1lkR0hMcm93MWRYZDlJYjlrSThyU1FR?=
 =?utf-8?B?UmJsM3VISTU4NU53Znk3QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnBoenEzRERad3ZwYzE5V3lmNnZFL1dQeU94a3k5a3c2c0U3cEFSYkVwdmE5?=
 =?utf-8?B?djRLYW9NMnB6eVJPYXhtZjArbURYNHpUSFI2bXdWVjdmLzZDRjJYaFZ1Tmwz?=
 =?utf-8?B?SW9sVVNBb3d6M3J5NXJRZDREUnpUbk12WDMyTm5hSnVtYnNIVWt3d1ZtYXFU?=
 =?utf-8?B?TVJ6L3dyZ1JsZ29vSndSZkZJalhZWXkyQ0JXTDYxWko5UTJ5YXFBbFNyQ1Yx?=
 =?utf-8?B?N2hwUlRyeUxrWnRDZWQwWTdvMzR4S0VlNy9IYkcwaU5URXBwWnRIZG9SMGVh?=
 =?utf-8?B?TUZoS3JoM0pYS3J2bEw2c0g4VHZNLzFPTWw0VXltQ29HT085bXZWTk9YR3c0?=
 =?utf-8?B?NzRMVzlrZ0dqK1FnZ0FmemlUZHNRREFSd250K05Hc3ljNkNGaEliNGhQMkJB?=
 =?utf-8?B?SmZlbDJWWFo5clM5ZmV0OFdtb1cyVzg1dGZJbXJzdmxPYlRhUTFES0ZWSUNH?=
 =?utf-8?B?OXRRSU1EeUtKTGM5eWtFOHQ3Wkx4MUFsMUJ2ZVFrNlBUMENKZHNYRmNRK05x?=
 =?utf-8?B?RkZqaSt5dEY0aERkVUk0UER3RnI1b0tHUHB3L3BuUndvZlU4ZnlWVHdCZ0Qw?=
 =?utf-8?B?MjdSQ2JJWTEyNnhyVWNCYVhtSE0yU0MyUVJhYThRR3U4MEpENXZQN3A3MC9z?=
 =?utf-8?B?bS81K0pDSVBMaktWalJPMFd0ajFlTlc5TFJlMzhRRVVJa3cyQVN0Z2drS3pG?=
 =?utf-8?B?M2RmaW1DaGxRRFZRbXlNOVpNd3I3bmdBSHNVR29mR1BvQW80QmRONGk2VUlJ?=
 =?utf-8?B?UjVudVJDa25iMy9jc04wVENRRjZPM0RMbkpBRzlCZnFQMUpRakxublZWZzhj?=
 =?utf-8?B?Q1lZTFJ0S2ZOenBCNFBoWnJXNUVSRktNVTc0ZnVDaWV2Tmh4REdHRUJxNXhB?=
 =?utf-8?B?aitFWWVWOVN4cjFCOG11b3J0VElnbTNYb3V2QnpaWWVlRThBMzhOK3MyNnp0?=
 =?utf-8?B?c280SVRtZUhjTTFZclRJd0lSTTQ2dWFnWkk3TVFieUhoSSsrYjVKc0h1Qzcr?=
 =?utf-8?B?UGswb0xrUzdQNmcwKzJZVVhWeGVoRTZRb1d4NWZ6SG0xaTAvMXN2TDFRMlNN?=
 =?utf-8?B?akdOVm14WXEyUW1GUFF4OE9lRlkwVEUvMk9WZjl4QTFsRkNMTFZjQi81WG9v?=
 =?utf-8?B?N1JXQTFOaVBZenp0VTVjQnRtTXJmNUJJdzRMQkRRSjN6NS9rWlQ4bDRGODdq?=
 =?utf-8?B?QksxZ3JDeGl4NHNCbUJoVDAwL3l3ZnpPRTZwV0paaUZjaXZUSWhLc3dza2h3?=
 =?utf-8?B?Tzk2VUFJZ2tJSTZwcnBnR0F3Tjh2UmpYTFlRNkphdkN0dVpmSEo0TTdHQ3pm?=
 =?utf-8?B?Ky95SHdaSFdnQWxYa2pINTQyNGR5elMvVG1pRFp4dWFJRmkyaTV3UVcveDhM?=
 =?utf-8?B?Y0J3ZUo1N09kUmFWb2ZZYVI1WVllYk5raDI1Mm8wY0JzV005YkFLTFRETHpG?=
 =?utf-8?B?VjdzRkEydm9iQm9tR05ZVFdSaWNoVkg4ejRDY3I2SkpmNG5zU1ZGSnJmYXVk?=
 =?utf-8?B?a3ZCNGhQNmx0bzh0eGtlWUk2WEVLMjZaaEk0SHBPcU1vbzdhTUFvK3o3cWRK?=
 =?utf-8?B?OTZyUS9UUU5EOXhXOGZQYkwrYWExVHFvWmhYd2ZLRURtajZIQmlVaDc2NURy?=
 =?utf-8?B?UThBYmNmbTNuUG0waHgvc3lnUmF0ZSt2eVVWbnhRS3lBeDVpaUVrcjNQZFZm?=
 =?utf-8?B?aVhSSXNLdmp2enVwYVVVbTMrUlg1ZEZya2JxdEFadkgzbkZjK2l6MU5mRUZo?=
 =?utf-8?B?OVZHYndNTXZvaCtKMzNMNGEwdzlRNkt1QTZrYVJJdWEreHl6Rk83b1Q4dkNu?=
 =?utf-8?B?RHZWRVFXZ3E0c2xWM05YUkRjQ2Z1VzB3S21WMWc5aFlEVXFPdGwwNjZSQWIx?=
 =?utf-8?B?WW9PcmdqWHNGcFF0ZjNDTE1oMnRkNHJjZ3hrbmFjYm1ZVnFLdFRWZ2Yxb0Zt?=
 =?utf-8?B?M1VTNkFNbVZTU0RtWS9sdjBJT1FkcXhYMU5QNmRGNmtKMmZWSGRtdVJMTzJR?=
 =?utf-8?B?ZkR6S3BSc2ZSRkYydW0zQ3RZNFdScEJ3Z3V5QW1oYWU5elZYQnpsWndSdUls?=
 =?utf-8?B?V1l0U010M3JXNGtnWjZzZk10aUdFYWNLb2NwOEMwTkwyUGlkMmRxWVJHTFNs?=
 =?utf-8?B?MkNJaGdsRHRPanZCL3Z5RFFWN3pBN21Ub2c4YXVUdjduRFA2SStWa3dnTVAy?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B5591AACD691B41BD9F57D17DFE1631@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3AySYDlEDSDwLdLzhJ/QATAcNogk9AjHpe+ymn+ZMI0lAh5orGiTp/mBFbiJzrAklsK17QzNgWfe1uoZDHDMZ0asJTBNpX/dwj0ujjXdl3TalmMdqhpWUow05wt++BI1489JJ1U8Qgom5ZzHkGWWTAx8bvWhPRL9RC0ig6l8elPpIZ0Z4jXvj0cRebIFZAaV2y6+yaRmhAfkMNO/dDyUXvg0e4pzx3LLmHDHoqbxhZQdYgEs/+wzQFiP0Wolly5KMFf7RIwNyK0CgzMYVbq3uts40Ut3B5AIkGr0tCtoo6jhydFtEWpk9uvNiG96zydPs6c9v3L1MmEKKaSNM3ZFeb8x2aMKcgeQVWA0q5R65qm7XsNYnHmTvqtH5K5O4PXqo0oYPnMlwoI2OSqgBnETqxdr0wBEWlNPPHH8EgtPnIqLeGQy8wp0NUtKdP72Bw2Jkdq179g0BUVpCWCfgy4L6CeZ8sU9vB1d1nPG+0dOFEVAkh5Vr/WtUKvjKEa31PIY+TfgKULU9JMFssJUh7ZB7SPrmhFezzK/2Jka0PmvnkbscEaEd4xbx8bl03ROnduuVXbu6XLqBH+JZfkOfTI/KewU1M9rLcBD9ZDXWhvAANxPRYrHNHbEKKDuIPCrLumi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af638731-0ace-4544-5b21-08dc7b1e5cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 11:49:11.3883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qq5vzxoRGYMFub2Ty+73TekMs6QzbzQX9KTJv9PVyWkKSD1nuYnA8JSyEbsStvbgoIiKcMuhg8R4YYk7BWRUunKFhG1HaaVtXuQwEFb609w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8835

T24gMjMuMDUuMjQgMTM6NDgsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBPbiBUaHUsIE1heSAy
MywgMjAyNCBhdCAwOTo1NDowMEFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+
PiBPbiAyMy4wNS4yNCAwMzo0MiwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+Pj4gSSB0aGluayB0
aGUgcmlnaHQgd2F5IHRvIGhhbmRsZSB0aGlzIGlzIHRvIGNhbGwgcmVhZF9tYXBwaW5nX2ZvbGlv
KCkuDQo+Pj4gVGhhdCB3aWxsIGFsbG9jYXRlIGEgZm9saW8gaW4gdGhlIHBhZ2UgY2FjaGUgZm9y
IHlvdSAob2JleWluZyB0aGUNCj4+PiBtaW5pbXVtIGZvbGlvIHNpemUpLiAgVGhlbiB5b3UgY2Fu
IGV4YW1pbmUgdGhlIGNvbnRlbnRzLiAgSXQgc2hvdWxkDQo+Pj4gYWN0dWFsbHkgcmVtb3ZlIGNv
ZGUgZnJvbSB6b25lZnMuICBEb24ndCBmb3JnZXQgdG8gY2FsbCBmb2xpb19wdXQoKQ0KPj4+IHdo
ZW4geW91J3JlIGRvbmUgd2l0aCBpdCAoZWl0aGVyIGF0IHVubW91bnQgb3IgYXQgdGhlIGVuZCBv
ZiBtb3VudCBpZg0KPj4+IHlvdSBjb3B5IHdoYXQgeW91IG5lZWQgZWxzZXdoZXJlKS4NCj4+DQo+
PiBIbW0gYnV0IHJlYWQgbWFwcGluZyBmb2xpbyBuZWVkcyBhbiBpbm9kZSBmb3IgdGhlIGFkZHJl
c3Nfc3BhY2UuIE9yIGRvZXMNCj4+IHRoZSBibG9jayBkZXZpY2UgaW5vZGUgd29yayBoZXJlPw0K
PiANCj4gU29ycnksIHllcywgc2hvdWxkIGhhdmUgYmVlbiBleHBsaWNpdC4gIFJlYWQgaXQgdXNp
bmcgdGhlIGJkZXYncw0KPiBhZGRyZXNzX3NwYWNlLg0KPiANCg0KQWggT0sgdGhlbiBpdCdzIGVh
c3kuDQo=

