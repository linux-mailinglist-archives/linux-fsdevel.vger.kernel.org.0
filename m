Return-Path: <linux-fsdevel+bounces-47698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C9DAA437B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 09:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E471B670DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C581EDA0E;
	Wed, 30 Apr 2025 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hc2JsJba";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qSzfUF5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4C10F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745996467; cv=fail; b=Nch6MQ6GbwyvMptVuDb1DtlizNyHTi0nkmln0XkOzkK1JDIn/QBtJiRgrz+to1L/BpuN7YlPgJqVJMskENx4X0fS1+GqDdqNoSkco/oK0ZQn1lYUEA+sYtoeKC0OuAYN7wCMQ2ztJPh6lwnu3EZj8o2OhZC8t5NxPKVjxBANaYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745996467; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4SoNLOj5XzZQYU7mtHIngHWZ0Zotj14PEWzdUQGpRLTU5S9o1d/JQR3spJMfqfIHB4kdal9nC3IZSm9tIcKhoXBZCPP788M0Mpbb4C717lDcQddMw6vfxMHFB12g9xKXTWDSrVIlPebgFbPPWZIVGK0tJMBsQwLllV0dNuyz/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Hc2JsJba; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qSzfUF5q; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745996461; x=1777532461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Hc2JsJbaYddasZxQ621oNHJOV/ADdumZMHaE58ScLQ5F82unP5mj0atv
   otZcZA99Mjer+tAlY1pm1iiID8+5HbrkzWCTb+Rp0j9iK2AduGfnz821R
   /0x2ZjWniS4OfVt3Y/QLWLaoghzlF6iI4Rt0IiWIw2Rhqc8mujGXaaOZx
   5vIwNBg1WVOniUSiwAy8ZATbsZdUt6iWpeIZiirA9f5ZkB2BOejvwenmu
   nviHDXLQTjPQkg/dRpoo03PMix6zN2XUQdu6RLtja0TrgoOqpBh/nzl/P
   DrgeSh4UAoNWk6sr+fhATSZ+rRIgB1JXW3xvWgFhUEDQrev2d4lqmBkUy
   A==;
X-CSE-ConnectionGUID: rG8/ghqiQqCBsKYAASpwGA==
X-CSE-MsgGUID: w6t1yzLRTQSe0gsnmE09mQ==
X-IronPort-AV: E=Sophos;i="6.15,251,1739808000"; 
   d="scan'208";a="83803085"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2025 15:00:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2/AW9ohmyhULr7EwbXYPC56xg3gOsd8s6I8JAsLOMhu9PCiv4WeeNRr/l/PcO3IUA5Qf+r+pW2vrxFLDnrDGfsOwNqlG7L1H5o695i7l3FYXcWJAipX8YgEwlN9TSTkdkZgn3O5vCgwPIcxNcNAJwQJtOQca5M9svgNIpjLkzQM1eka1q2ysvq0MQQod0VkCbkEMGgKON0uJyePm0rseokfeHeFiv3qVSjiwg2Hu2rfGszBUYV+Sompd1tAmjfXjeDztOWj2wne8pRVvNBu3RXmnj2UkaXr0npoN9Dl0QstUxkdwOrE466VP5Rlnt+km6fyrsLI1uaUrPUpdc7yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=UppaohywROnTn5JrFCpAtrCRIsNDrvqJZNYqKFqXktFF37BmTNBZKOBMU6oSq43qgtX16AqytauSVaxSOshjnK2m/1BpCe0fkSPKRTYNkzgMvbnXIMJ+UayBbH3VFx831T+t2mbq71ue+GLuKS6LIIvHwZ5y10RC9uyLNzz8GBDLR81cT1h7QEQMPUOGJVyyXKrFKio/4NzwNqrOIL9gz12a/Dcn4kOggEhP2MfgElMcURpkEoKG1y2CZL+fxAJbuFNuu3M4VP7Dk1tNC/wiRA8tpMUTOuah92ucOkOjr/c2zu84A8vbpKAr7DhPjmgkR897CgW1Zll7wZ9FD2lI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=qSzfUF5qvR+YTOlMlL2MC+7+FPh9PLzBmwO2IvIeZOeIs7zAIGCiaAT+6GYfmNttHMc3L72JtbApemXiUrAJfgc1OA40Nu1g66LBo3HyuXyhoxxvvGnCoItsbeDk1FQFemBa/Qeuk+A5hhxe5LcX/rn/buHWQoRaT2gPNhC4+8k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8946.namprd04.prod.outlook.com (2603:10b6:510:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 30 Apr
 2025 07:00:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Wed, 30 Apr 2025
 07:00:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>
CC: "Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] hfs: fix not erasing deleted b-tree node issue
Thread-Topic: [PATCH v2] hfs: fix not erasing deleted b-tree node issue
Thread-Index: AQHbuWSKOcNxf5vddEqadJJSu6baLrO7yG8A
Date: Wed, 30 Apr 2025 07:00:53 +0000
Message-ID: <de17461c-0c2d-4440-b910-5d55556afa1d@wdc.com>
References: <20250430001211.1912533-1-slava@dubeyko.com>
In-Reply-To: <20250430001211.1912533-1-slava@dubeyko.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8946:EE_
x-ms-office365-filtering-correlation-id: 4cee09d7-a1a4-4e21-dc16-08dd87b4bf6b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SU4zUlZMSVdFbWZ3Mlp2SGl5WE40K1NZMnpLUzhCbGJSVlNFdEJ5S29XYjRa?=
 =?utf-8?B?UlFlbDZ1dnZEekdqMDMyNHltWHk4dzJNaUVEb0lzbXVKMkhBcWNkS29yZzN1?=
 =?utf-8?B?ai9wNmdQZzlWSG02cjFGeU0xUDRhcFBYa3VuYnRPcTRucWZMMkg3WStlUm9F?=
 =?utf-8?B?Sm5HY2R2WUhBdDkvT0VTdFdZb2tyR0NHLzNLWlpMSnhYelNYZVF4S0U2RUMr?=
 =?utf-8?B?UkJmeEwwMmlUaE1tYzQ0YWw0bFBkaTdKYk1YQTg4T3l1NHNmaEI5YVc5K21a?=
 =?utf-8?B?Z3d4c2NRK3VHS3FZbzRvNmlSQWRJb3UzRk5JRWdsTmZTTXZYTWcrdHNKVVpz?=
 =?utf-8?B?R2tCZC8yOWg4R3BxVDhkbytndC9tRmc1WW5FcWV0MUxBamwwbzhvSlJtWFR0?=
 =?utf-8?B?elJUK01Eb29zME5TOFA3V0ZxWjR0cnNDUlprVkJLa09yZjZ3dlJUTEpGMnVJ?=
 =?utf-8?B?QUk2UDgyMGQzRGlmT00vbm1IR1JTQ295TFJlQ1d2VmdBdjJ1L2dydnNBSHFS?=
 =?utf-8?B?citheWVmQkVGY1VCa1dkR3AvdFRTeWlmSHF3d1FkTjlYMnVVK3M2WTVQNDZC?=
 =?utf-8?B?QzM3dFdUZzIvYmZhdGx4dlZFK0xjMTAyOEphZFZIM1B1MzMvMVRSK0tNeXBT?=
 =?utf-8?B?bFQ5THllT0U2VTZkYUFIS0ZCTldRa2dpWVJtMG9mQUxYRlN4YXM0N1JIeU95?=
 =?utf-8?B?S2o5a2JyRURYYW5GaStEdE9mczdva0tKQis3V2tQMmdWbnVrQjlrTnMvRWk4?=
 =?utf-8?B?RG5yeHpSdFFFTGFUeDFDTlAyazBUc3BzdGFMQnVvdDlqQkI5VU9TcEIvbGJH?=
 =?utf-8?B?akdVdFppVzJ5TThlYisxV2d4eGtxQzV3QVdLWWlWem9xUW15NHBVQ3grZHVm?=
 =?utf-8?B?dStNQ0xrdG9MQVl2Qkt3YWxzcE5JeFkrYlVRK01EMjJuTWVyZVpXcHNXM21y?=
 =?utf-8?B?TGw0eXFIVDFUcnNHOXMwVXp4S2RFajlvRWRnYndWV01MMlNYUkZDVGdBN0ZK?=
 =?utf-8?B?Z2ZOakl2SG5GTUtmMyt2My9JODZyRW5IMURsZWdDQ05LelpPRk1kNFh4ZHlz?=
 =?utf-8?B?Vlhqd0FpNkhLdEFkZTMxc0tSWUUvY1Fzb2FBbWVsL2ttR0RoSFU3cEtBUnov?=
 =?utf-8?B?cUVzSnpOam1SWkxHSHBSaWJuVyt0Z1cvRml6Y21ESUxPUmd3RjcweW1Vdkl1?=
 =?utf-8?B?Sm1XeHBENXI3ZVg5Zmt6Mno4Qkk2RmMwOTZEM0xyUXo4allrKzlSNlMzRzA4?=
 =?utf-8?B?anhtYVFYWWRJV2ZzVWkzYlhncW9UN0hmUWFpNVExZG82OWxLQjI5SHhRUENY?=
 =?utf-8?B?TE1XRjZ4YUF0R3FNZ0UrbUxFb3lzbVhUOCtZOUVVM25IVis4TGtuZ05SdStM?=
 =?utf-8?B?cWI4cEU3c2JGazhUVGsyN0hwUGlvN3lKRGRvS1pWZ0lJUWxTU0FGVTlabnNn?=
 =?utf-8?B?UFFzZ05MeVkrMDhBUFpaTlVXaGRnTlRudlppUVpVbXprbUlJRXNZYUlQR3JT?=
 =?utf-8?B?MkdtcEdmSm9LTHYrNFBFZXg5bFU5K0x3bExORW9jVWdwaEZHeXBnUzlGcE94?=
 =?utf-8?B?Um9QeUF3OU5mU29GQjdsdWhCSmhsaG5PNnhGWGVFTjYwSjd1bXFPaE0zY2Zr?=
 =?utf-8?B?UEtHbG4zMTBRZ3BaWnBxNXhuTnkxRFd2TkpXcVpLeDQ0UHpTZ1V2a2J2b2VU?=
 =?utf-8?B?K2w1U3l5SGREaXhDSEhiUDFJcTVQalZuNmsxayszOTZIZTd6ekNVZXFMNk9I?=
 =?utf-8?B?Yk5EYjJwNEVqOEU5eHdMYjM1KzcxV1pCQ3NLeVl5cXplMVBhYXF4T0pvclI5?=
 =?utf-8?B?aUZZN2JENHRsamhBY0hSeHlzTmVCa1FGeWdiVjFLN29kT3JYVHM0RGtoM0Vz?=
 =?utf-8?B?dlZBcnE5RFZPaWxhRDMvKzUrZjBpQUxoaFdFLzhZV1krbnBPeW5ETGk3RXFP?=
 =?utf-8?B?TW1Uei9oNnJRU3crQVc3bUh0K3lXOWlNczFWVC9FZUZxR2w3T2c4V2JrUDRa?=
 =?utf-8?B?ODVEVEpCbGJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVpldUJUakswKzNZTzdNOW8xYVNyUkQ2TktjbDZuQ1ZCSllpZXNxYXhDdFpG?=
 =?utf-8?B?dDFLa29GamFDbUQ5dEgzUUFzZFFZWTZNcXZhZmZnb1djOVFMWkFrZFgwZWF4?=
 =?utf-8?B?QVd1aGtFb09oOVFWYkdtV3FtbWFQaWZydFBCZ2RzTWU1MHFJTHdHdXIyZDhr?=
 =?utf-8?B?eWlmbmFjK05WZ1liNnUreHozT1JBeW5pbFhWM0JZbVQxclZXZFZKVytTUWhC?=
 =?utf-8?B?N3JUQWFZTmxzbGdSemZhOWE0SXF4RCsyMUN2T1JCWW5YTGJRa2RiWS9iRmt2?=
 =?utf-8?B?ZWhsZ201ZFVpM3JGNlQwcU8wUW9xUUN2emtKYlloT3cyaGVINWxCZ0dzL2NT?=
 =?utf-8?B?SkM4RmlKN2lsZFJiRC9CRTBOZTh1OEo2aWpDWnJnRUw3WGk1ZGI3dUxSNnBS?=
 =?utf-8?B?NDRUSnV3N0tjRkhaUmpjZHBhY3ljZm1ZZDVPdmNwVEpyWXQ2bGkxbzNOTmFo?=
 =?utf-8?B?akhUWndpbzYzK2g3cWVHVnRUSkZwZjZrWlhpZlpDRW0ydjczN2MyYjN4Rnc0?=
 =?utf-8?B?ZHpZUFBIc1JrS2tMY0dSSEZDdXhlY0lzVUlBV3c2dmJ4Ynd0emVoakZRZjVo?=
 =?utf-8?B?L2NuZ1dtcmdZYVhBeUxYOExpTVBDU0pWQU5EQWk0Mm1FVzV0S25YdGdkdSsr?=
 =?utf-8?B?RHVnSHhjNDNvaXJkMUtJVmxURWZORzRhWU1yWGZkNU1XZ3ZOZFpGQVRMbloz?=
 =?utf-8?B?Vm9FM25iVy81SXVISEtEdnZGNVppc1Z4QmF1Tm83bHhreS9Sd0piQUl1OVdO?=
 =?utf-8?B?TGo3UG5tZlRqa1N3VGZReVN2c1VXcXlwUnZNVTl6Y3V4NjVZRzcwdGZLUjNQ?=
 =?utf-8?B?OElaYkJlNENuZFpGaDhwTW5HS3NZZVBtRlhNcXQ0VVRyblVBN3JWQ00wSkpI?=
 =?utf-8?B?cVFvVHc0WUlEeUxyeU9hWUx2bElMWWdFZlZBN21IWkdDUnRtYzAvS0tDNmxw?=
 =?utf-8?B?YmtaYUF2SVBwZjhyYndHTUhzWk96UU5FTDg1MnJ6QXp3K3c5OE5kZEhnc2Ru?=
 =?utf-8?B?QkllK2xvY3JHYjlZMGQ1ajZ1bkNIMFZ3d1ZhNW1DSFdrUnhMd1U2QWF4OWpn?=
 =?utf-8?B?Q0ZqYVR2SFJaQlBvRUxYNitoSTJBUXN4QkhuYnhleWlQbWZQZ21kT25rRlpT?=
 =?utf-8?B?czlOU0JOWldOc0xqR0hIdm1IaXk2Y0Z0bXR1K3RIWnNTa044Q0pIOExtTDFt?=
 =?utf-8?B?R0I1cTE5eS9SWGhoYVV5SHVtanZUR2ZJSHExdERzeHhRd0hXOHBUbHl4TTMw?=
 =?utf-8?B?dzZqM2tyN2FXWUZPYTlrM3dDTlk0WXRRTG00bktOaW81RFZIN0tuZjNqVzls?=
 =?utf-8?B?MFE3ZGJLWTFOZHpucXo0NVowT2Mvd1lLaHJmZU1vRHM1c3pEU3RUb0sxRGxS?=
 =?utf-8?B?T1dwKzVZcFVFMGExTktra2ZGNTJmZ3FsNlFWb0hnbFA1NWRTZ2lsVEgyRlBF?=
 =?utf-8?B?d0ErUlBHUXhlL0xyc0VXTnprYXlHSzcwcUM5NnlNcy8rWS84SktKeVFBVHpJ?=
 =?utf-8?B?dzRyb3ZSbnQyaXNMZFd5V1NiYXo2Z3N3VklpSWQ1VkdXL3ozYzUreWVVeTNN?=
 =?utf-8?B?TjgreVZtaTQ4NE4wUzdoT0xxdFJvcG9CWG51THZ0b2VNNHJOMEx6bVFiNjhz?=
 =?utf-8?B?enE1NUtYaGo4UFhmYXNuVFNsZ3k1TWNOYmlxNmtpQk1ybVpzc05wT3lCaXVC?=
 =?utf-8?B?d1ZDUjljMnhJSEhiU201QzRrc2xjWjZ6RG85OUhmRHJ3WklNRm96ZFdEZGNU?=
 =?utf-8?B?Y0pzanRNZlY3WDRKa1FmQy9NRHptSVFvY3pXU292YjdNMlF1SDUxaW5XN3VV?=
 =?utf-8?B?eGFOdmFvNVZzWDFzMnlWTGxJZ0RmOWdIVXBzVENZcDZtY2RlN3N1TnNiOExZ?=
 =?utf-8?B?eWM5Yit3bnNoNjYrSlA0MzFqSktpRDBCODFOd0tmNnplVG9QaWZ2MHVZc00x?=
 =?utf-8?B?cDNrTEhsdUhuNHFiWVBhVG9xcEllaWJyTTk3Yno1bCs0ekhkNkZBOTlVV1BH?=
 =?utf-8?B?bGIyTzFtUUwwZEYvTjIvU0RDeTNpd3RlSzNoZTMzbUpFUjVxQXRXMTBlL1B1?=
 =?utf-8?B?SU5ZRDc4TXBoNHozaUI1WW55MVVBanNlem1hKzRkaFQwQXBJcXBKaldPUWtO?=
 =?utf-8?B?a3ZQekhkMmNXT09BSnJJZE1MaG9iWSs2Rmc5ait2R0sxaXpqWkVOZ0hWcENH?=
 =?utf-8?B?d0FCa29Xb0JCUXVhSWUwZm4rS2RwN0IrbU5BdXd3cDNYbW5vUUd5UU0xVDZY?=
 =?utf-8?B?UTF1V0FueC9hMXN5NlgwdDBVeGt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86684A796DE0E34E91BF135EFE033205@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6R2ZUwvcJFQ1ekNesZi//hGZzXurRyShCZtIGiz8oIEEh7H4tJ1IqqKEoZK7kqq7BSOyNv0YQY1wJvDgu2WKljtnAGuTLh/5GT3mXjToaVhySUp8nqcDd3ALm9kN/X3C8zxAxWdFpxYtcaPRAgYHzxmKEUnUXuqC36vvzY37ek2KhRhnxSWFESbNwEPGs9J2GOsV4YoP8ZGX+93CqnEZLrD9qhL+TDr29N/LfAd1KJRk4ZqkPFCaFmrbale/Lo8vuZLfG9Gb4jBTqrMmX7kuLcjcyYGvMCVAq2SBy4kCxLVXKRTw41lkQrFuajul9ZPmV9KQv6Rame0XUGjw8ld7kzB3Yi/9DpG6p6sTdSoMc6X+rUoc6N2u1rp4S9ZV0XAgWqe5FplylsmpMnILq8zlVf0RjL+5DxoOaxlpZPS0GhK4drxVGnV6/gy4bZONy92OmHkF58zlQJNtcOck/oW3KIHqi82A7wuDJYAn11ifpibAD56t7I1kONB8OOUAC8couTHzZPijROtHZEU9ThU7XUMHNUzsns0YsqMeO4ojRvGWNQQeWYyfCEeasfB/i0+ik+FZfEI6F0pYufyYt0gkt1nfme3m4cUNG5ivT6DJIXwqqiiOFpEkG0zhXTZP8t61
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cee09d7-a1a4-4e21-dc16-08dd87b4bf6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 07:00:53.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uGsvZ6/RE9cD0EkELCYBuQoHkUbHfH5mXdV71+sV8thzvoC0s/pHgf4c1USW1qWCEK5SPpKSfBHaOvn7q75jZqjX9sUo0Qul+QnuC7SSpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8946

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

