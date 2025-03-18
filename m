Return-Path: <linux-fsdevel+bounces-44351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219BA67D33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDBB189D366
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890BC1F5851;
	Tue, 18 Mar 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H11ON9ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC720322;
	Tue, 18 Mar 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326700; cv=fail; b=HWtOJxH5volKd0q55uEWxk3lHTk34CNMR22Fvdzov81BIsVexORG/ehivUnbTLOx04SeKA5iF9CrogyESUEZJEGVSKecppcKjnu04Uagm/s2DG2z4yGuqE5lofT5ZgQh8BtlKhVqa/51WWtF6nK1oihF3/R2tYzp4QAwE2i50PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326700; c=relaxed/simple;
	bh=g1ZQ575osJ8REAAbRqZygWhFDGiae8x4lLTbk0i+qZU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lLuPpleCCWloSjxop4SSSPWAaasEwQg2X2YI5+Q7skbBxYgEphhNLWfnEyeViCcRGTwP+0QGrQ29D5Fo+oZKzpDr2IWcYqgG7uk4xps8URV+nI9QYsJ4HT0EH7lXFUtkGovUtqKQ5BVG7ltWAOBinGUYJI/zyGILMNvn7oFoF1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H11ON9ln; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IE3BGW027846;
	Tue, 18 Mar 2025 19:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=g1ZQ575osJ8REAAbRqZygWhFDGiae8x4lLTbk0i+qZU=; b=H11ON9ln
	p1Ti6mVYwKEW0P3qzJdZCUr/UfcX7Aq9ajssKKJuvNa64F1ulOHSz5r2eDoC2ajW
	HnHirl9G/3SZdjLYifVW3e9PPOek/RiEub3rfb/cfNmc+o9Xs85LaoMxSRRtOL2a
	gHXPGfw/5NK9gejZ3/oIFxV+cFCoGlAWS/YFpoNlNq1G4XdPObMNzsa2J/VB+z7c
	hb8wyhGn7lUtht0Bd+cfSYGUY72xvW6CySkV7nJTpP2VoW6bLl2p9bsS6CQ0rOt5
	/psSmXZLY29BUo5e+BspRtEe9zvZCYT+WBzFEN73tCgj7vuaJgvI+9m9qgukocUm
	9U5Mr7GpFo/hMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fa8p9rx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 19:38:06 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52IJc53A020373;
	Tue, 18 Mar 2025 19:38:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fa8p9rww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 19:38:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqENfgGXxYvC4Pou/vfK1WHh9bFGUhIcU05Eh9sREAht3TOm+Q8/mjuzjADmPMt5TOELaV3BAON6VCHAhC4Y8/YYbUBpC2MEQVfoDHS6pwQBNr9vFbR0v4mSisVDpwfhiJjPIRwltUIWN3duZ6WqrHY20IyjIhZXmqf2L9QXnRPzngCEHL2lJ2/4zqvMZstCd8qL2Wuu/8ejsmJ5dNTD9Ht1uFerXIE0pxmTd555OT3wWHROs/Y5fA9GDZT/JPJld7iUStiefucuQRbz4s0Fnw6hKEBOh0rY7ot+9vtRuIiiwIibog4DGb9Q82wztwzl6zG3gnljwF6BTo3kiJW0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1ZQ575osJ8REAAbRqZygWhFDGiae8x4lLTbk0i+qZU=;
 b=vPyzuh0xzb/W8L+XEIQsW4BLaYKFxRh1eot1Wmt3o4YsBLL8tKnuGYkD9VG74HypWxsQQYH1+Qzq49xYKyfHBg9Db8EK+LYmPC88r1/uhDNXlwfTpAdF8rSZvowcb+8OEYybrs545yN8RHKCZgvClAnvZfzbHzYFBomct8HCDvDmI6PLVdiCnQdloGRkADb9s2+BYeZHt8m5pIeDn+GMSiiCK35W9TogGl3bEU9YoGV4yj+p6iu/XMfqRmmJBzH7oJChpuH+QBEmJl3dVs0VZ6K8qYCewWuVngJA4I6ynxnoU3wc2XB0PAFIWr+Y1S1RT2obqMGs5t0tHKWKdLJ/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV8PR15MB6711.namprd15.prod.outlook.com (2603:10b6:408:259::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:38:03 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 19:38:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        David Howells <dhowells@redhat.com>
CC: "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
        Xiubo Li
	<xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Thread-Topic: [EXTERNAL] [RFC PATCH 13/35] rbd: Switch from using bvec_iter to
 iov_iter
Thread-Index: AQHblHEJIZBNOssYXEusWrgVYEtHQrN5UaMA
Date: Tue, 18 Mar 2025 19:38:02 +0000
Message-ID: <639bd030acc938dc3ef1d11fe630c03e3effd24d.camel@ibm.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
	 <20250313233341.1675324-14-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-14-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV8PR15MB6711:EE_
x-ms-office365-filtering-correlation-id: 95b5779c-77fd-4cb5-cdee-08dd665465e7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUxrdllQQ1RDR2h3eVBNVDJ1TUkxTy9KQzh3VTJSQ09WSk5UNzdnSTJSaEti?=
 =?utf-8?B?azdJNTZzdW9ON3hvNU5kL0s1eGs2YmdCemJsWE5RN0JhTUZXSnFNOXg1VGxE?=
 =?utf-8?B?RHM1ZjU1Sll5aitzVXE1VjFtVlFIeERsUFBBMUtQTThMcDlGVzQvQzNSVTln?=
 =?utf-8?B?M2hic2IxTXhUdUZPMm95RlBxQjVPUmRlVUFDdHhDdGJLU3JyRmtlZEl6Vklu?=
 =?utf-8?B?eHJiQTd4blowanpqMTd1cC9wakRmT3o3eW5GSHo2anVBMzRhZFkwd0lNcGcv?=
 =?utf-8?B?YVhFRUNWSXFOMzg1aTQ4eFU1QXRudVRjTXloOSswSU1NVUwrOG4zN1Z3Q1FT?=
 =?utf-8?B?NUhkTS9iamNET3V4UmJaWDVidlJOd21PZFE3OGN4d3UzZ1NZRHlQOXhQUzB6?=
 =?utf-8?B?b2VtdG5wMVBRVUFJMFZrNGdvaWlGeGxyMnpFS3ZyOHg5dDBGVmJ6ZS90TjJh?=
 =?utf-8?B?SDBPRlZCbTJzdmxVYkg2a2tFQ2kwZ2pPbDlqdjVEWE1rczFoMnY4bG9oWXIz?=
 =?utf-8?B?aW8vY0g3bFh1UGJzdldYYzl0MUhHZU01SjFQM2lLbGNhbkd6SVFHRmRsSFBV?=
 =?utf-8?B?RUJmdkkvTHUxQS9Wa2prZnZUenRJcnNQSE1KLzJNYWgxS0xadjlTUExGN3VH?=
 =?utf-8?B?TWxzNFQ4REFNdlNwYysvWmxvekpQdmkvdzhhaTZ4SitJbWxWRjdBWlRnYVEw?=
 =?utf-8?B?eTBURkordjRqRm4rSTRla2hENkhuLzM4KzVEOW9CTHp5UXdyeldwVmlrVTlB?=
 =?utf-8?B?ZWYyMWNwYXVBV1FkVlFEa2RwZG5XQ21TcUw1REtwUTgwU3NDRmc0Rldicyty?=
 =?utf-8?B?SXE4RFJWMjMwa0VUUms5NXhGUEJvSDFPQW9hTW9SLytVZWhTUzNjWEd0RmlG?=
 =?utf-8?B?K0xiY2hRcFN1Z29Ja0svRWlHVnlrNVlHbGtyWS9VekF5dWJZN0Myd2VGN0tH?=
 =?utf-8?B?Sm85NTJkemNZdVA1bm93N0N1YkZmdCtRT2hndStkRW1ROU1FTWNJem93eGVu?=
 =?utf-8?B?UTFRUUtrZFdTOGJiNnFmZjZEeDhZZnpZWFpIVVI2ak9mM1pVc3Jja0x3SS83?=
 =?utf-8?B?QkRVbXZqanRhNVhrY3drRE5VU1d2V2IyQjhnUEtXZndDT1NkRUxmRE5YbnZq?=
 =?utf-8?B?cW1haDhMTVB3OUJVZjVCWDE5QkNXcWltMTM5NWZUcXNTeHhrVHpuL3k3YTFt?=
 =?utf-8?B?QnY4ODVwNGtUUFFXOVpPeGVvZ1JNTE5TZGxWSkd4NmF3aUZTOU1qZmw1Mms1?=
 =?utf-8?B?UHFDSnNTQU9aRVNvTU04aTBLWWRaQTBXeDdnem1hTE01S2pneDBHOElwK0c4?=
 =?utf-8?B?ZlR0WDJTTVBqdU1ySEwrQTZ2UnlVQ01FZVJXaUpGbEpQSG1rdDM5NkRkem9J?=
 =?utf-8?B?N1NWeUJWYUZNekcwYW5MbytDWmdxL0h4NVU2eXJldjZwUjc5N0xxU1Zham1Z?=
 =?utf-8?B?Y3BuT0NFUWorenFISVFRODRndm5qSUh4ZWdxWEpXMERyQ3RDa3BSVTNmZ2pM?=
 =?utf-8?B?Q0s4d3JDdjhsM3d0cDVYWUFIbkpYK25TeDJYVVdmWHVqNkpPcVBoanhHbHdo?=
 =?utf-8?B?NGJFajhDaWF6NjhHeVRlSFRZNDg3MUhpSlpvRThGM3FCTHplSEZwRFJmQ0Zk?=
 =?utf-8?B?SloxeW4vSGZCTDZZYVMwRFBhNUVEVnFTQUErdjQ5VVZNNE8zM3gyeHd3YlVz?=
 =?utf-8?B?S2sxdGw3VmUycGVWM3AxdzR6TzZHSTNtVUlKZ2ZpMEF2Y2lKK2FFY0FxNS9q?=
 =?utf-8?B?V3hiT1NLMzVwNEpTRk9GTE83TWpuZW82ak1xOUU2UGxhSUE3OGZBWEFnNWJM?=
 =?utf-8?B?NkU0b2ZEdi9jK1Q1MkNzVzc0NFdaMnliQi9RM2VPTExheXdiU2p3NlNKZ3Vk?=
 =?utf-8?B?SXVheDVMR1YrL3BKaUJyQVdEcHIvU3pURUdqL2VnZW82TXRYRmtJSUpseHlx?=
 =?utf-8?Q?aLlG8XpA1/irBi7Cqs3ebSgiqRC/LUSV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUg1enVMTHl2Wjc0WjF6QjdpRUpnT1ZlQUdPUzAyak84WjFZblJia2RjUGty?=
 =?utf-8?B?N1RtRWNPN0RSYndjU2xWQmJxMk1DQ0pkUTV2M01NMHAwdjVRVi9MMCtlZzVK?=
 =?utf-8?B?RnhOeGNHSFlnVGZiRzFENjNNUHBOMldXb3c3SlkvMkthYVZjbENITkhSZ0JB?=
 =?utf-8?B?ZUs1ZjRCWG55Q25rOHZRVW1oRE9lV1ozMWtCVUxLN1lCaVB5MUFWVzIxV3Zl?=
 =?utf-8?B?OUJuRUpkVmVSZE1kTjNtZnR3Nk8zU2NYY3VoTUFMd1hOQjUxOTAvZnF2TnBH?=
 =?utf-8?B?YUhndWxFTExIVXQxUDFVaC9nZG1pRzhLa2Z4eUYzNzlqNUo2WFBQYlg2VTFK?=
 =?utf-8?B?a2V4cDdIOEVGZGZIVi96Q0g4blF1OUFTRkc3QkUwa05xUFA1VitJMzVNQ1VY?=
 =?utf-8?B?dURvUmZqNlFTc1RubytJallDeEpyUVhWeUhBaCtHeHorOGU3S0VOUmZucWtM?=
 =?utf-8?B?ajBldEw2Q3dQcFZUa3pqNURqd3JoaG4xd2lrdmErbGMzdXNUZFZsbjZXRjBI?=
 =?utf-8?B?SWxEL2NzcUlKR0l1YVZsU2tvbG5SNU53OWlxWkhPMGxSaHBLOTlINnBZTUFY?=
 =?utf-8?B?cS80S1pSZmVzQ3dJUTdZRUJ1QmwreFY2WDdmLzF6YlErUzg0S09GQWc3ZXVr?=
 =?utf-8?B?WlF1dVFkUlBRSVBlNGJ4ZG5VTFZZdU9iMUltck5UcVMydE40TGN6RjAwU2Fm?=
 =?utf-8?B?TUxnb3VuYVczMWcyTCtqNzE0Q2hycDU5M24xOHhYUjJLNjdGMFNXZVRKR2ZU?=
 =?utf-8?B?K2R3bVdPY2lLTVpDOVpnMHhEdzJBQXpGQ2FDV3JkNm5YaC9uSFdRczh1QjNF?=
 =?utf-8?B?MXBPRzBNUEgrcWdOb1ZoUjg0Z1J4OHNtOWpWRE1tS1ZVT3hMNWZnNUk0cDhn?=
 =?utf-8?B?QTVRakJOQkt4QTRhQmdKaGFlQStoR2ZabG5yZ3JtQ0FMRVdwcUhpM0xOT1I2?=
 =?utf-8?B?TTJ0cVI4ckdvT1Z6M1JHUjU5SXFSbU5kVVVGMVBURG5rb0RrcEdKMll1QnJY?=
 =?utf-8?B?cjFzK2dmK0x0a3doTFRyUFZ4VDd6a0RoR2EvQ09SeG5tRDAyWmJoMG5UemV1?=
 =?utf-8?B?bE42cW9naVgwZWpob2pwTFVWRkJQbnVjY3JDQXBWTU95RVhCODdZekFLbmZy?=
 =?utf-8?B?RFlWSDdENUozMWlNdTE5SXZETGNuL3ZCOTZkckFjOTNYeHUvREx3YnU5cURq?=
 =?utf-8?B?WGhQandHRDlLMm5URmZEdlUzRjFmdTBPNCtJamlEZTZlc1V5Zmxhdmtzb3VP?=
 =?utf-8?B?S1dNSXR6QjZxbVV3MVRsd1lUQTRVT0EwTnZ1aGhTV3oxVW9YeEp3SVk1UU1s?=
 =?utf-8?B?ZCt3MDZVdGJHVGtCNVZRUnU5bCtUTjJ2ekZTdmgyalY2R3hWa21Ka2FGOXFI?=
 =?utf-8?B?RGJMZWZRWm9wRzZTUmluM1g1ZnpDbUpnV1NOdXBHeGJtVUg1OUJyMkVjUkpM?=
 =?utf-8?B?a1JnUkJxLzd2dWtSMnJmQnVYVzhjVXNjL29YeExGajdCdHFQWktsenEyUk9E?=
 =?utf-8?B?cFV2RUFpMmRvbEpBMUNER1RGVEVYZ0lVbnh0R1ZOSVNhczRTVU50amNXY1J1?=
 =?utf-8?B?TXFTQXFCSGM0Q0Z1MTBRZ2loQWRBek5mQkMrcGlBdlZCbExyQ1JsTWtoeEUz?=
 =?utf-8?B?N1NqZmJlRE84WXU0RjFEc0hYV1RkSjB1YUpzN091d1lWZmRlUjloRjFCZjdR?=
 =?utf-8?B?ejYxSmY3RExVVTR1UG5pZTRGNklLU2N2RXZmV2dxQUpNWlp1Y2prTHVJeUJS?=
 =?utf-8?B?clcyUUp0RlhyVUVhM1BIaVJkMndRK2NHS1NjVGx3VHRRTXlBTzlMc2FtZzMy?=
 =?utf-8?B?MzN5NWFDcFpvTDBLaXRuZXJqc2l0K2tLVUVJNzRVNjJ0NldLRGNSakE4RnYz?=
 =?utf-8?B?U2NjQlN1dk9KN011Vms4Tk9McGFZWWsrWS9TemtJU1NsUWVYblJta2lnT1Bw?=
 =?utf-8?B?dUtjZEF1eFBuMlc2Q3hpVjcwaTQ1QUg5RUJ6SlIzODNFWDFRSHE3SURTZ3Ba?=
 =?utf-8?B?TTIyODRiWnYyV2ZLMGFvM3lOOCtpbE9admxlSkpEYXoyZ0hPYU02TDY1bTZ5?=
 =?utf-8?B?ZmZ5dExYWWs1L1BaSGdnb28vdmdVRW1XZDU3SnN6azlPYUJsWkRjeEs1MVNk?=
 =?utf-8?B?anRRV052VVJGNGhmelZFUHNBZEVJU29OemtLMnUzNG1KdEwxL2NsdmN6UzIz?=
 =?utf-8?Q?ixKr+kAZBV8VmBMYYVoJQSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66CCFB4D6986044C925631C8B6166673@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b5779c-77fd-4cb5-cdee-08dd665465e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 19:38:02.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6pD4XfISv5Ltq89IyoJATSI0B2wIV/ybsJxaGzuvldQ4hxLjKa7zyFd7I18POS12fNfi95yp1gR8MaeemtYvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6711
X-Proofpoint-GUID: JqpqhPx0t8JDYXAFRFH4iQUBYNbHi9uS
X-Proofpoint-ORIG-GUID: mzvVyZ10PGmQxyg0YlWMomC0-e0R3Rxq
Subject: Re:  [RFC PATCH 13/35] rbd: Switch from using bvec_iter to iov_iter
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180140

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjMzICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBTd2l0Y2ggZnJvbSB1c2luZyBhIGNlcGhfYmlvX2l0ZXIvY2VwaF9idmVjX2l0ZXIgZm9yIGl0
ZXJhdGluZyBvdmVyIHRoZQ0KPiBiaW9fdmVjcyBhdHRhY2hlZCB0byB0aGUgcmVxdWVzdCB0byB1
c2luZyBhIGNlcGhfZGF0YWJ1ZiB3aXRoIHRoZSBiaW9fdmVjcw0KPiB0cmFuc3NjcmliZWQgZnJv
bSB0aGUgYmlvIGxpc3QuICBUaGlzIGFsbG93cyB0aGUgZW50aXJlIGJpbyBidmVjW10gc2V0IHRv
DQo+IGJlIHBhc3NlZCBkb3duIHRvIHRoZSBzb2NrZXQgKGlmIHVuZW5jcnlwdGVkKS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+DQo+IGNj
OiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KPiBjYzogQWxleCBNYXJr
dXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0KPiBjYzogSWx5YSBEcnlvbW92IDxpZHJ5b21vdkBn
bWFpbC5jb20+DQo+IGNjOiBYaXVibyBMaSA8eGl1YmxpQHJlZGhhdC5jb20+DQo+IGNjOiBsaW51
eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvYmxvY2svcmJkLmMg
ICAgICAgICAgfCA2NDIgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGlu
Y2x1ZGUvbGludXgvY2VwaC9kYXRhYnVmLmggfCAgMjIgKysNCj4gIGluY2x1ZGUvbGludXgvY2Vw
aC9zdHJpcGVyLmggfCAgNTggKysrLQ0KPiAgbmV0L2NlcGgvc3RyaXBlci5jICAgICAgICAgICB8
ICA1MyAtLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMzMxIGluc2VydGlvbnMoKyksIDQ0NCBkZWxl
dGlvbnMoLSkNCj4gDQo+IA0KDQo8c2tpcHBlZD4NCg0KPiArDQo+ICAjZW5kaWYgLyogX19GU19D
RVBIX0RBVEFCVUZfSCAqLw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jZXBoL3N0cmlw
ZXIuaCBiL2luY2x1ZGUvbGludXgvY2VwaC9zdHJpcGVyLmgNCj4gaW5kZXggMzQ4NjYzNmMwZTZl
Li41MGJjMWI4OGM1YzQgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvY2VwaC9zdHJpcGVy
LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9jZXBoL3N0cmlwZXIuaA0KPiBAQCAtNCw2ICs0LDcg
QEANCj4gIA0KPiAgI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gICNpbmNsdWRlIDxsaW51eC90
eXBlcy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPg0KPiAgDQo+ICBzdHJ1Y3QgY2VwaF9m
aWxlX2xheW91dDsNCj4gIA0KPiBAQCAtMzksMTAgKzQwLDYgQEAgaW50IGNlcGhfZmlsZV90b19l
eHRlbnRzKHN0cnVjdCBjZXBoX2ZpbGVfbGF5b3V0ICpsLCB1NjQgb2ZmLCB1NjQgbGVuLA0KPiAg
CQkJIHZvaWQgKmFsbG9jX2FyZywNCj4gIAkJCSBjZXBoX29iamVjdF9leHRlbnRfZm5fdCBhY3Rp
b25fZm4sDQo+ICAJCQkgdm9pZCAqYWN0aW9uX2FyZyk7DQo+IC1pbnQgY2VwaF9pdGVyYXRlX2V4
dGVudHMoc3RydWN0IGNlcGhfZmlsZV9sYXlvdXQgKmwsIHU2NCBvZmYsIHU2NCBsZW4sDQo+IC0J
CQkgc3RydWN0IGxpc3RfaGVhZCAqb2JqZWN0X2V4dGVudHMsDQo+IC0JCQkgY2VwaF9vYmplY3Rf
ZXh0ZW50X2ZuX3QgYWN0aW9uX2ZuLA0KPiAtCQkJIHZvaWQgKmFjdGlvbl9hcmcpOw0KPiAgDQo+
ICBzdHJ1Y3QgY2VwaF9maWxlX2V4dGVudCB7DQo+ICAJdTY0IGZlX29mZjsNCj4gQEAgLTY4LDQg
KzY1LDU3IEBAIGludCBjZXBoX2V4dGVudF90b19maWxlKHN0cnVjdCBjZXBoX2ZpbGVfbGF5b3V0
ICpsLA0KPiAgDQo+ICB1NjQgY2VwaF9nZXRfbnVtX29iamVjdHMoc3RydWN0IGNlcGhfZmlsZV9s
YXlvdXQgKmwsIHU2NCBzaXplKTsNCj4gIA0KPiArc3RhdGljIF9fYWx3YXlzX2lubGluZQ0KPiAr
c3RydWN0IGNlcGhfb2JqZWN0X2V4dGVudCAqY2VwaF9sb29rdXBfY29udGFpbmluZyhzdHJ1Y3Qg
bGlzdF9oZWFkICpvYmplY3RfZXh0ZW50cywNCj4gKwkJCQkJCSAgdTY0IG9iam5vLCB1NjQgb2Jq
b2ZmLCB1MzIgeGxlbikNCj4gK3sNCj4gKwlzdHJ1Y3QgY2VwaF9vYmplY3RfZXh0ZW50ICpleDsN
Cj4gKw0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoZXgsIG9iamVjdF9leHRlbnRzLCBvZV9pdGVt
KSB7DQo+ICsJCWlmIChleC0+b2Vfb2Jqbm8gPT0gb2Jqbm8gJiYNCg0KT0suIEkgc2VlIHRoZSBw
b2ludCB0aGF0IG9iam5vIHNob3VsZCBiZSB0aGUgc2FtZS4NCg0KPiArCQkgICAgZXgtPm9lX29m
ZiA8PSBvYmpvZmYgJiYNCg0KQnV0IHdoeSBleC0+b2Vfb2ZmIGNvdWxkIGJlIGxlc3NlciB0aGFu
IG9iam9mZj8gVGhlIG9iam9mZiBjb3VsZCBiZSBub3QgZXhhY3RseQ0KdGhlIHNhbWU/DQoNCj4g
KwkJICAgIGV4LT5vZV9vZmYgKyBleC0+b2VfbGVuID49IG9iam9mZiArIHhsZW4pIC8qIHBhcmFu
b2lhICovDQoNCkRvIHdlIHJlYWxseSBuZWVkIGluIHRoaXMgY29tbWVudD8gOikNCg0KSSBhbSBz
dGlsbCBndWVzc2luZyB3aHkgZXgtPm9lX29mZiArIGV4LT5vZV9sZW4gY291bGQgYmUgYmlnZ2Vy
IHRoYW4gb2Jqb2ZmICsNCnhsZW4uIElzIGl0IHBvc3NpYmxlIHRoYXQgb2JqZWN0IHNpemUgb3Ig
b2Zmc2V0IGNvdWxkIGJlIGJpZ2dlcj8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gKwkJCXJldHVy
biBleDsNCj4gKw0KPiArCQlpZiAoZXgtPm9lX29iam5vID4gb2Jqbm8pDQo+ICsJCQlicmVhazsN
Cj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gTlVMTDsNCj4gK30NCj4gKw0KDQo=

