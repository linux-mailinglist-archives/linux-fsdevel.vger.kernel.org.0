Return-Path: <linux-fsdevel+bounces-64093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C149BD7E00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D507D4F9D5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C62D8393;
	Tue, 14 Oct 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IXtySd0Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IUE992VZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E041DFDA1
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426713; cv=fail; b=WvNkUUzjY93fTGBMFKT81WdZFv2lkiEJFtb2lU38Piqik4s7RaltwTzWBP/NP2nNfJtNolUp0oZI3xBhG+TG83ajaMcjLDSDDXz7gt7TP9J7N7Ald0OqZh4dDYeDlQW69fLvv5Et/wunHhJ/Vwd1UpPv0vzgEowrlsH1SUtln+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426713; c=relaxed/simple;
	bh=6fc+OEft38s2/oALt7HslzwR2OjLCUJr7+DpjE2rRxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ErBeYofLkcw+Zyr+9HUjpRiVWoL8sgg7DKb4FxOsyeoK4wAkkX+jUSF2sv5dkiiOYN3Csf0TF+yQf8KUhpnKZlKYPwgcp8U6vDPYR734Y2fIPtSU3oH9tKnVIdn9dS+h4MTUBB3uhc+UzTjwrg3AIBgsHkQ4Y4CrUu9/plIiPkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IXtySd0Q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IUE992VZ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760426709; x=1791962709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6fc+OEft38s2/oALt7HslzwR2OjLCUJr7+DpjE2rRxk=;
  b=IXtySd0Q0AyHXHdu3erns+nhfRvWAcMC6VdmfO/YEoD3k3D0DRpDaUBV
   VNeRXjwfPJ/e7U90xYX7hfILNIn8QehS3yA0f948N6kxfHjrq3wRldQxo
   GMDzYvZfmHuA/vw1K1c6xYp4eCtlXtPwzMdWrvoAvzuRe3GIrcND7FJ1A
   my+4zzbXtd9OE9x+gUD7/BMJCViCDiAece3GZcry2KAOmf387kMaoQ2po
   ek27vtYKzeZmZetnStXrvjFvqRZAI0SSvrlksTSCGaZeLw2e8CnWgJjc0
   uVmeklBZCE+qfIP6R7dooDQJ4HyZt0gtN7TBzmpQZLKML7BYMP88Z4E15
   w==;
X-CSE-ConnectionGUID: 5rI3ElkwScSKr/Xohn5Z8g==
X-CSE-MsgGUID: 2bPjS082QaimvwB0fsL8gg==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="133065237"
Received: from mail-southcentralusazon11012044.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.44])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 15:25:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9yrYt1eTa7SfkpfxuxGuxMLP5nrF9OgEstGHm25S74ju7v6TECcAB+Uk7tUD1oKGL7xd3Khn3BrhYRiVXbWh9pebfS2jmcIcqEuts23cWyGT0ZMEs2zqAqZlqadEunn1ClG1O6v+Bbt1BgWlebZhS3lYIy9XRX7/Cd7KnB/OEFW/UuLbpvL6kJOElSPM7y4RFpygghPLDuXgEJeBC6IS4OjfWPxdDQKQPM08utI0fgGRcWOfXG0PRieJNA/BZKmT/dxHopmxYbk6JNfzJ5V5INDk3UhJB1UyA9xGS7T8WiQYBw15yxhYBlojCk7LXFZh2QjnbZyZ9Yvqo1xogRXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fc+OEft38s2/oALt7HslzwR2OjLCUJr7+DpjE2rRxk=;
 b=nx+U9gT7THrYctF84dCUK91CuABKkUHvj76xJC9Kuh7OyNhWKGHLFz6p7jI16ocCVhELiRfUhW6Gwjwn7pUXWXwsnKbuPkV+MinfJ8YzrZNLNpD2B0kZHPjv5cDIhW8xTLLyRzjX95Q+KTY6KhSg7XGQbmLxl2B8rd8AXQZYqrhWaW0iEeaZyA6dd6EuUGtHg8CB460rwyPjc+RR9+TOF7xAKEFZBBXDpJUqWN7HYt8XJTDwMgVeXG9xILWqNQqfHKHcJnAKxKRgA6nPXAgPLz93Vm3HA9DTDWBJHMBJ4bqBuRQ4rffCXqk0IVnFHvCCpgOde/Alp8wN34VOfyKu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fc+OEft38s2/oALt7HslzwR2OjLCUJr7+DpjE2rRxk=;
 b=IUE992VZtwsygshENtk7BNjz4cmGuFjBxbRdUI/quYgPf5Ia9kUiVk/ce6EJgTcWoiASHFRiYuHI9Z5MXnPKR22TFZGy6OhEPCa8UZe//qiViTlvjgml4/nBDddfS+4dzx863b0mPG8UVcOjdnk/S5GTTF6eKX8lEi++CG8weiY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9656.namprd04.prod.outlook.com (2603:10b6:8:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 07:25:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 07:25:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
CC: Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fuse: Wake requests on the same cpu
Thread-Topic: [PATCH] fuse: Wake requests on the same cpu
Thread-Index: AQHcPHO9UxNFVjQhmE+7a5eLFa5FkrTBPmiA
Date: Tue, 14 Oct 2025 07:25:03 +0000
Message-ID: <f2906e44-413f-4153-a378-5a87a49298d4@wdc.com>
References: <20251013-wake-same-cpu-v1-1-45d8059adde7@ddn.com>
In-Reply-To: <20251013-wake-same-cpu-v1-1-45d8059adde7@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9656:EE_
x-ms-office365-filtering-correlation-id: 849b987e-b12d-48e7-e3b7-08de0af2cb02
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|10070799003|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFlSME9MZytSUWg1MjlBdWZiamYrclROQXc2czZhQzdFNHRlRHpsK0ZUU0xD?=
 =?utf-8?B?eWd2eVR0V1E2ZEkyNk4ydjJud2thd0xCVkF5YmVDMlU2MURiaXkrSmJlYzVk?=
 =?utf-8?B?L21vUHVuRlc3MWprQThFVlV2WGJSYzBBOTlVaEFiUE5oa3dJckV3OGdiTzRT?=
 =?utf-8?B?QVVUeGV1d29wb2VycThYUEp2OTZ3ZUdwZVlLRTU2NHBnNzBTN0ZVV3gyTS9U?=
 =?utf-8?B?dGNVVTkrdDlqaEhTR085Vis1ZC91eDE4MVJldzdEdGNjdTdjSExIYXFjWmhI?=
 =?utf-8?B?S3d5VEQ2SEJqRk02ZHg2NXN3QWJjSFNsNXJFOG9mTTdoSHQzaTY5VzVJK0h3?=
 =?utf-8?B?TjNtN3BMelRueGVYNTdoMFZqMHlna3J3NlBMUExYVllRcFpTSm1ncC9LT0tk?=
 =?utf-8?B?Rkl4R2NWSkpQejRLRWJEcEhmZmJmWEdDVjJxa2wvNHBKQnVZK1RoanRqNlZq?=
 =?utf-8?B?WVJVOExaMGNTbVk1RTRkZU54N2RKcFpQREdIM2FuWU1DL25Va2NobGlTSjdZ?=
 =?utf-8?B?NkxBZnloUTJGK3ZiUE5jNnVjc21WenRIUytvUkNUZ3JOUzFlZWp1dkRXVmYz?=
 =?utf-8?B?Ukl2TXdUU28yR2pXaEt1dlprbmZNQkRKSTduZkhKUWJhV2VQa2NiRTRCRWI2?=
 =?utf-8?B?eVYxV3djVE9UK1R4bFcyaEpCa0RTdTY1VzJnMkZxbFdnVVNGcDFKbjRPaFBY?=
 =?utf-8?B?TE1zZEZReUw4K3BLMkw0NUJNVUhkUzMyaG5rOGtmeEhoU2E5M1NYeWRkS2Ux?=
 =?utf-8?B?cVdyVGMrcUhyYXYrK3Z0eklDakY1UWpNSys0QWRJbWplMU5ISEZ0TVphbG41?=
 =?utf-8?B?am9sZTJydVY0OEkvdzVOU0M1cEVaTGtuMzMvdHdIZTB2MDhMQUQ1TFdnbkxX?=
 =?utf-8?B?VkJZTitOeUJXN2JTNGNOZTdZNVl1MDd2dUUxbk1scEVlTWRHc0EzUDFVN3Fr?=
 =?utf-8?B?cEFIdEh3Y2Z0VUp4a2Vibm93dFVJd2ZVbjhXYlByQ01xbitXZVl6Uis0bzhK?=
 =?utf-8?B?OXQzUlJpNUhCZ2k0cFBtelIybCtFTU9nZlBST2FWeEczbDU3dVhMeGNBMU0w?=
 =?utf-8?B?R3crMUZGTk5Za1R6SmRpM2xPdWlyeDlxNHV0Wk5WdzUxVFB2Wi9jSjNHMVN6?=
 =?utf-8?B?bVVsMk1XSEtBYkwrZW5KVURDLzZCaTVDRHBwMU00b0tzaTV5aXQ5QnBoMm4y?=
 =?utf-8?B?TXF0cGFkdGR4NGFwM2NIM2JLUmZyL2F2YW5wTXRxU3o1V0FGZndVTEQ3bjNh?=
 =?utf-8?B?Y3VneGFZUmIwdFp5NHc1Q0JsVFY3U2RHdlhDaHVhU3dsR3pJS3l6YTJlM0FI?=
 =?utf-8?B?UC95cmxDR3A4QjZJWmpOQ3lPc3B4TDJZSUFFR2plaVdFL0pIcXZoZVNRWmNU?=
 =?utf-8?B?T3dvSHlOMDFEcEVXbzhjQkN0dXB5aHQ1R0J6aUJmaktqbWJYVnF1M3dQUWsy?=
 =?utf-8?B?cWU4NE5vdkpZN1A0V3oyQ0QyMU1xN2c1TVlObDVMaERhTjVxZmlkaC9McU9q?=
 =?utf-8?B?ay9DZkcyb1RSSjIxb0NIaHk0YWM3dkorVkRBNjFDQndJQ2Q2d3QrcnRPcTZN?=
 =?utf-8?B?aGhabmZncjN5ZTB4bFVEVG1HdTJISGI4MkpWcEUxK3ZYaGtDL09pYmEwci9F?=
 =?utf-8?B?SHJqNWtoTmJHcFEzWUhnODZRK2QwTkJnUHJyUWNKV1ZUaURLMm1vbGdiYU5R?=
 =?utf-8?B?WTJkN3dTMHRIcnRRTjR3L05weDVwbkJWZWdVZmVWNkk5alZMVGFyRk9NQkpw?=
 =?utf-8?B?aW5rTmxJRVZuak5EaXlQZ3VrK3lVT0JsdW83SXpJRTN5SWxSNlE2Ukg4anBz?=
 =?utf-8?B?b1FXQ2JaSWs0MnNoc3NGODc3bGwxc3BPSUl3TXQ1a3VCWU5uUytPMUdBYk5R?=
 =?utf-8?B?ZjFRbGJxQmNpeFZpdkN2SGFKQmc1OGFuM0NMQ0ZtZXBMVm5hcFNUQTNISnlz?=
 =?utf-8?B?a3JPRm9xMlBUQmxnM3NRYW1DTnhuKytmcHZlMkFZalczcnBkL3ZQcEJ2c1Z4?=
 =?utf-8?B?SjdGUC9DT0lVdjJqeXlmL0t4Nkp3RE5IR0d6aXBubHk0N1lVY1I1dXNYeEd0?=
 =?utf-8?B?YUVvdVBoaEdTNmVEWkZVbDNGUSs3bmx2eFoxdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(10070799003)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MCtGZ1drN09mL2tmZmdGcElyM3NuaWlXYTBXd05pd1N3VHY0dXVjSEtBRWt3?=
 =?utf-8?B?SVlDQXdRVlRjZ3VpbFJGSURrNmxFUGR4Rmx1MXJzRmp0SzJFdWE4WXhuaWlW?=
 =?utf-8?B?R2txZUpBZXlnU1VMc2trU3AzZjR6VDlBSmhBamhuaXlCUEdsQVlOdHBmc1Jz?=
 =?utf-8?B?ZEFXM1d5N1JtQ3RvRFVKdk56cjllb2l6ekt0SG5yTmd0WC9QczNVN3U5VjlH?=
 =?utf-8?B?d3pUdGo0QUpzTCs3OU5IMXY5TFQ4L3dkTWNra1JpR01Tb0FqUG02MVpGL0tP?=
 =?utf-8?B?bE9KWm5MYjdvaE0xelY0MC9iVldZclVxamhaQ21nbW1CZTVpMGlqYWFaaW9w?=
 =?utf-8?B?QXFlakthalFSYmRZTWpGdU83d0xBYlpTcUo0UElXNVlSWG5RN2hZT3FteEs3?=
 =?utf-8?B?eXVDZmJqZzJ5ZTNEQUlQdzFXekxYWXZLbEtrNkZ2YUI2bXlsZWV3WTFKVHMz?=
 =?utf-8?B?UUpwRjlYOXkyVDRGSmwrZHFkcGxrWTJzNlBWQmlVdEdUVi8xV2c4aU5rMTZT?=
 =?utf-8?B?bVRreFE2OWlvR1MyZGkwOFQ2TjhYRUlGUHkvWUpuWUtuWXV6WGhTcXNJeDJZ?=
 =?utf-8?B?M2N4cFRpL0tReDRnakVDbUN2L0lONEFmcU9CNjZJd3NKSHJMd0FJMGZnZmd5?=
 =?utf-8?B?THlkWnVybmszZys0ZU40QnNHZEhEaVlvT252S1N2L0VlUVI3VVFyTEtuMVhn?=
 =?utf-8?B?V1krYXYwaWZLWnl6bVFJcFFJc09pUEtqQ250Z2p4OVNXNFhDNjQ3MlIxSmMz?=
 =?utf-8?B?bTdFcFFOTTF4NDVyYmhla2kySDF2bFlEUWE3eXhrb0toalRrMmdEMldYSEY2?=
 =?utf-8?B?YXNJUys5UkIvYmtnS2F5dGFxYy9TNFJoSzMwblpGZUE2UlVMbHgwS0pxSFB0?=
 =?utf-8?B?RGFEMm9IamY5akVKVWdIU1Y4WExjVlIzTDhWM044M2VvUXJxcjU3NVM4ME9P?=
 =?utf-8?B?MEhSOEwvMDM1MGw1ZnA1dWJTMnZ4Wk1FeGpWdUlKbEdQb25sMWJGVWlPNFlw?=
 =?utf-8?B?TmNmbGtDbWhHOWMwRkhOVEpzREdrMmk0KzJzQUU1ajBiaitnV2NXWTZiZEdK?=
 =?utf-8?B?YzJKMkM2b2RMTTdlcU44RFpYbDYxcEwwSGcyQVpwVFZ5dUN0T3FKZllLWjl6?=
 =?utf-8?B?T0ZQaDE2U1lyenFiYnNxc3ZLUlRhT0t3M1ExRjF3dGlPdVdIeDNqaFRUdFlm?=
 =?utf-8?B?OTQvQ2xRbEpqa2lFWVE5VXBQRm1qYzVOYXN4N1Z2QnpYOFNLNVNVVkJ2TkRP?=
 =?utf-8?B?RHFpUXJSTG1MczlpVlB5cWpSQXZQeFVJOWVzeEhUby9MYjEyS2kxMGdKcEF4?=
 =?utf-8?B?NktwQTgrZTF6N05aMkN5S2w0eDVnd0JtMlF2MVErUVVSZ2tGYUt4WTROUjZP?=
 =?utf-8?B?UndXcWhuODcvUXlWM2NxYjhMOWVHZEJBT2FzQ2NLRTlHWHdGWE12RjJBRWQr?=
 =?utf-8?B?OTQ2MW90WjJQYVpGRDZyMkREQ3ltMHpVK3ZtK2hPMFFYYVRjcHNoZEUrNnM2?=
 =?utf-8?B?NGdPMXNVSXVBRW9XaXFTbnhpbnkycmVzbStrdU9xV2c0bGp5L1cvODJqbEhl?=
 =?utf-8?B?NlpzaENSaWpFT2dDK1R5OEJaVWdvWkZOZzduRE0weUNieElpS25kMTR0Z09m?=
 =?utf-8?B?bVBCbE84NTFiTzN0RUl4RTdJdWpnSzNrUEJyWFB6Wk9UVkJsQkV6TUhCckVX?=
 =?utf-8?B?S3pObUltSjE4bE10OTlJK3FwTVNhR1I5ajRsSWsvS29JRUJCQ0lKSnk3UnQ1?=
 =?utf-8?B?clJQVnUrVkNIeXBxalhDRUhpWkxmOU5Wa1BaY2RzT1MvS21zMVpHSlA5MWNQ?=
 =?utf-8?B?TzV5UlV2cGJveGhTMldWWXg4bm90cFJCbjN3Ui82TnA3eEFmeUlpdU5sUk12?=
 =?utf-8?B?U1RveXNOVEI0VFFMLzduNk1yS0k3Q0dyb2dvWTBZZGk4SFd1TDlUTXVEVVZP?=
 =?utf-8?B?aXVTbFZ1cVZDNEdMZm9neXlLNVpqbXZJZC9NUlpwaTNWR1JUMHArYU1tOGZz?=
 =?utf-8?B?cGJVSU1tYTg0QUYzUEJSUFNZNzlEUkx0c3M0WmhxajZDdFlMNjdnMWQzb0oz?=
 =?utf-8?B?YUVQb1NmYXBQL1RFZ1ljQ1dMMlhuZzJCL3F5QjhrVkxVckd5OHJzZmtpc3hF?=
 =?utf-8?B?REhIcEM0dWZwWENDeWc5dkZyMEpvd2hCNlBWVHpDRWhiaitBeUQvTkhxM1Fq?=
 =?utf-8?B?U0JFS1U3N1ptNEswME5SaDZ0dDc5bUJuU0VaQ1o4dWlJMHluc3FxVCt0RUtK?=
 =?utf-8?B?dTJRTkFrLzQ5bFIvbXNacnRLZ3F3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74AC0547A7295B4C9A0AE9A05874E209@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bYQ1IARSylrpbDJAuj5AkQr2uib8CuxkbWiiGifNncDpJXaVWJ0xIiApeCKA59zQ9I04VsRzUniZ7ZZ1f586wtwqbRbxof9vFOvgieV4czLmKiyNhKFK7vCQaAw2vty5Z8EYj3iNEWAreOs4MJdmH993iZJA/SFvrl555UkLGo7YdLYsbDsEvX8+vSx4VZHbITaaTORz0tFC4zcOdDkE7JPIIKMZcXiyq0L+IObzh+nk1FrjhKrKEHyjcEGPPVzGsjFkizDTY/ePNKLk+GqcLoDBN4fNPcq9QMBnQG7pmXKZRyWC6TWz6eOCjCMqGUrAzmlXlBUr7Ck4pI9WurFrvCq5Sga0hxXpZu9FVrDQisuhm6/phLBUuyhfajmqO0lm75SXqiVcE+JQQ8TT0hLnZDKBbMalsuc6Z6TBMapdXfTtTl8KlKXuqsg2YH8t+K5z2V7YtqZMG3vJdkesZb6ZHKDOW0bDIT0KLFM9v3QTlxjC/natMNS7zRKENpNS7bqGOyG+jLcLFwwm3AHbkgWf8cf6YEs+JtckQwyKiYJgYknMhAtkgB7sspuAaCJkdzI9LVL6aX+jtFrTlRSnn41MQ39AP3/BiniWdQ7lqbuC5gH8j/3JoE6NCM3CvNBKu5y3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849b987e-b12d-48e7-e3b7-08de0af2cb02
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:25:03.7463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWQgbt0EOFqFq4WNfOA0IR714wv/ATypNaASK+SZnSboPvjFBZZNsXPWt4IUv+1ZkdQCqNDiNnj/g6ZZGpufVZUqrIJgbdeeugOI9cTk3pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9656

T24gMTAvMTMvMjUgOTowMSBQTSwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+ICsvKioNCj4gKyAq
IF9fd2FrZV91cCAtIHdha2UgdXAgdGhyZWFkcyBibG9ja2VkIG9uIGEgd2FpdHF1ZXVlLCBvbiB0
aGUgY3VycmVudCBjcHUNClRoYXQgbmVlZHMgdG8gYmUgX193YWtlX3VwX29uX2N1cnJlbnRfY3B1
DQpbLi5dDQo+ICAgdm9pZCBfX3dha2VfdXBfb25fY3VycmVudF9jcHUoc3RydWN0IHdhaXRfcXVl
dWVfaGVhZCAqd3FfaGVhZCwgdW5zaWduZWQgaW50IG1vZGUsIHZvaWQgKmtleSkNCj4gICB7DQo+
ICAgCV9fd2FrZV91cF9jb21tb25fbG9jayh3cV9oZWFkLCBtb2RlLCAxLCBXRl9DVVJSRU5UX0NQ
VSwga2V5KTsNCj4gICB9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3dha2VfdXBfb25fY3VycmVu
dF9jcHUpOw0KDQoNCg==

