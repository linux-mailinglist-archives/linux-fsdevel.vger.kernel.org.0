Return-Path: <linux-fsdevel+bounces-75957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLRNECH0fGk5PgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 19:10:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CAFBD9B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 19:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89FCE300EAA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D036C5A6;
	Fri, 30 Jan 2026 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G2GVCAtP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1836C0B2;
	Fri, 30 Jan 2026 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769796622; cv=fail; b=qhg3QeqvMbPI5kDICBALFnvjlgcEczqxDEDhsK6WkEyLRUsTmY2z/QkS5n1UEgEO2YLdEWRNueNgMryUd9e4Am/ipum2Kcvhq1G9Sk+Jf1qF85+ldpapqV0Me8+hz1+bmDmf9eu0yaaeTdR3f747u3S8pbBA+AXypbY++rtqxEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769796622; c=relaxed/simple;
	bh=UQeHLuDMHATezf+HB17MT9JhCR1lGaNoGLZa2n+LiQ8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=t7qGHj8mZpLuDbS4lA8FkmmME2vA4C2x8zwyTW95c26P1uxZLN/+0oSgIHG+sajzB1mWdnyJK6bGlxBm5ytpvzvTJAsFZOjrjNq9Hjge0VoGbl4gz+UNAixTa178Jr0RBvUUPag3FwUeQGKLMhvv4ZLaxipsIAemPh39jYpQKpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G2GVCAtP; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60UGnweH011250;
	Fri, 30 Jan 2026 18:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=UQeHLuDMHATezf+HB17MT9JhCR1lGaNoGLZa2n+LiQ8=; b=G2GVCAtP
	1w/+eB2uwJWL62rA4abcJrdibq/M1BgaHGssRiUWMF4TBZgJrCme+Vrc7b0Z8iSh
	k9bI2EbZstbl+ybkgFWryQ5/ewuZmKk9j1IH1B5QjK1jaPmo8JUGgnK7QSKByDLr
	q8BwmwR8TJOPffAp1J6ytLeCeiyGdQaKWYxs7AYQcd/kdoxNBKcdPgxpI+NuB5hE
	DNjWcAnURU0oahm80G+TruY/3Qfb4CXsZLwPW5s1rsrM32Wqq2ni+4LkQV96vPSn
	Zl3i4r2Ensp6sNYksfTQRuAuiETHt40RT6L/uWeNX2t/DCtvdJJDuzIsdb/Rp+E2
	LD2ThTYDcAyvsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmggc3xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:10:13 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60UIADUk014205;
	Fri, 30 Jan 2026 18:10:13 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmggc3x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:10:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HodsJigw9bbBZ8bjRlIoqoCobCubllO29Q7GyyBIFiXY0nee/u5qzeLeSyhJmBpOUweQk9E4kbty1AIkTvHvWeIlWrACQRhS8zdhF+QMv0Ig0iTNbnD6q4D/wXCGMae4J//0MTFSXTEQXWjkApP6aQpsg72PXlPOQTwvbhjLw56jCRQmRzxa5VmIBIdENfsbF8zVZGD+OOh3PsrCzRFr64REH/ImvXEPkJVEHyN+v9bGycEMF/vIUgt0XReWWPXPo2odyVBXK2mpyZzlunkB5h3Zc1Sy4PrpW0MOVLH7aFYoOMpersDdUiodghLufVVpu1/V6ox0wqxHlKAY5kgmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQeHLuDMHATezf+HB17MT9JhCR1lGaNoGLZa2n+LiQ8=;
 b=y2/OxTH23WsfAxdIMjKf6pWhXc3UPsdh7l1bYzktp1nxGF2kKj3bwzKHiaX0mC+bL+vwXyhoqa6m2aHbwQEkxo0RrCQeuOSh6uUK9ZuPyWGTTCHw6M6E01eOYHRr/2gcbBsrQAaOGxaoEEMRladdZAc6JHM1Pzvy2F9SN/o/HY68++3Q8+3auGqfT003PpsWcsdvV0X5L5fE0vGNlfUBPTjEm94KXscfzizg8kaco7yzNVyOzjFH1/UNey+5h8bFdv6ZXkfUHKuc7eyuay6bzDaPtyY1tNDSz2n0YWvAI/yEnoaf40eJd8ayspT1aBm/r0J6nM5638rekwaPfoQhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PR15MB7052.namprd15.prod.outlook.com (2603:10b6:8:2fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 18:10:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 18:10:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>,
        "janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH v2] hfsplus: validate btree bitmap during
 mount and handle corruption gracefully
Thread-Index: AQHckczigkDKg2JCNkuQIKuMBdb0CLVrA7qA
Date: Fri, 30 Jan 2026 18:10:09 +0000
Message-ID: <b78c1e380a17186b73bc8641b139eca56a8de964.camel@ibm.com>
References: <20260125030733.1384703-1-shardul.b@mpiricsoftware.com>
		 <11c93c90c986ab0bc52d19c0e81463cbba004657.camel@ibm.com>
	 <2283988f9edee66e648e257c303d5e4d77925402.camel@mpiricsoftware.com>
In-Reply-To:
 <2283988f9edee66e648e257c303d5e4d77925402.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PR15MB7052:EE_
x-ms-office365-filtering-correlation-id: c404d76d-7299-4c72-3eeb-08de602ace16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTVjSWpDYjVzbitneGVoWGtuVmhFV05HdHFtaDBIYnQ3SzZhU2l0ZkdHcnY0?=
 =?utf-8?B?OU1MVUVYWk9uZmFFdVZRS0ljcFU0YjJuTDB2eTc0bTlZblVjRldTdkRNOWhq?=
 =?utf-8?B?MUhsU3dmSUUyZTV0OG1PbmFOTm5CRHRsM0wxNWhwckE2bHF1MFFSM2NlTnJa?=
 =?utf-8?B?OFlxMmFranlRa1Z5c25CV2Z2S2V6VERkVW9veEdldG1uWVBwb00xczJIOXFJ?=
 =?utf-8?B?NG0vWEJSZDliUmNVenc2VzZpdjdHWU9razJVaGFXZFJ6U0UzR2pSbUZpSjQ4?=
 =?utf-8?B?aDFmWWk1TU02WXhtU0pwOXNPemN2Q0YyVmhQMERqc3c1MER0SHFPVFhRWHMv?=
 =?utf-8?B?MXBkb3pNelp4V2NVTXRubHBnVDRvNlBFRGZGM2F2bzNhM3dkWk4zQkpwYVNi?=
 =?utf-8?B?NVAzVTU3elZjNzQ1Wm1aeE83eUxNRCt1NTczSlkySzhoeU16VXVBbllCZ09S?=
 =?utf-8?B?K3orWC96YUxybXRwalJJL3M5cDJsVXVMOWttSGYxT1dpUDFWYW9VaXJIcG1H?=
 =?utf-8?B?SWMwWWUvek9JYktCb25FcVF1VGxVYTdlZi8yUFlOc0pqeCtaUjBkd3dUemI0?=
 =?utf-8?B?bkxnUzk4aFdCai9LRkJPNmRhWHZBM0ZyOXJQU2o4alRnRW95RFpOUzBzb1Iv?=
 =?utf-8?B?WndpYVZvdElENVRyM05vb1FPSXQra0l3NTBuUkNwYnp2VzVJQ3ZVZGFpcTFX?=
 =?utf-8?B?Q1BIZ2Q2eENaVFVZWXFEcFhtenZxbFBEdUs1d2luVVdYSDFnWHVjUnA2ZzVJ?=
 =?utf-8?B?VHpLemdKT1lMRklFSzBoVDd3c3pPK3hPOWNqRGRUaUNyOVIyeEoxZ24vUFFD?=
 =?utf-8?B?cEFhUVZ3aTVmbzZMY1FKOTJackN0ZHFKTjhpU0ZHNzFHYVhub0lGODRwVjdp?=
 =?utf-8?B?ejNPQ2theFZDVW12d01ac2paTnpoTXYvc3hid1BRQUYyVCtxRWlVZ1pkNElm?=
 =?utf-8?B?M1ppR2cwVXRRcjVOR3lNbTY2aGVqYU9pOHBVSy9OWVQ1TVIxRjJ5QTlyaGEv?=
 =?utf-8?B?Vk92cVlBekEwQTA5NktxZW1KSVFsaTduQ1JaQ045eGFZOGJDV2FReGdKZUdx?=
 =?utf-8?B?SFV5ZHVDVnF0akNmVnd4aE9ON2kxT3JLQ1VoZEVHSnUvNkg2eUJPNVVNTjFs?=
 =?utf-8?B?WHppQStUTCtjQXp5NzJjTm50c0R4dC9haC83TGtZdnRlZHA1WmdjcE1qVTdx?=
 =?utf-8?B?UWpQcDFwUDMvZzNxRWI2cWVkeGppK2RVVmkyUCtKb0VOa2dtdjBjRlRDZVRC?=
 =?utf-8?B?dStIakN0MUxJQm01NHVNNm16MmtGSHd2YlRHaC9JQ1cyUEgxQnpmanhHVUky?=
 =?utf-8?B?NWNaR0R1dXhhMkM1V1R1S0ZhaFBWWHpYbThUMXFvR0pEU2d1eG91SGZ5Zzg0?=
 =?utf-8?B?VmV6UWNRbytUQXU4MURxd2xQSFBKV05MdSs4bURSbmtBb1FHNHgwRVIxYmFC?=
 =?utf-8?B?bkVhT3gvbDRSYm03bFFDcGNIcy9vUHo0dTZ1RHVITjlqRmN3QjBZeEpOb1B6?=
 =?utf-8?B?VWR6YUh3MmR6OTFSaVdFVnBLeFdJcnVZZmcvTWZUOWFPTjNvZ2gzNVlxTGFO?=
 =?utf-8?B?NHdvaEtyYTMzMUhjMWhjQzlnYXFmMDFCSnZKWHd6bGNyMUVlOGNYTHIzTSt2?=
 =?utf-8?B?Ylc1aEVaaEk5MFJzdk5LV01JY0l1dE03MndYOWJEVWVvcm5EN1p3M1ZNbHor?=
 =?utf-8?B?UjBKRFN0VWVwZzh0YTZrUU9JbHdYYzlsNU9nYWhmYXE0Ry9LUUhiR05Cd2pB?=
 =?utf-8?B?b0NkMWJ4bU9TY0t2V0d1bXBKNFhLOE9HNVFibnlicUdOc1FKNUNWZDk2NTJy?=
 =?utf-8?B?aUdsQ29wT3NBV2Q1bW1iaSttSW5adWJxajVmSEt2dXl0NWNjQ1U1S1V2ampr?=
 =?utf-8?B?QnUxVGdYYWJYSWVYTllyMVVISXVOUGw2V3Z0aHJ2SW1UZGJnTjh5SGJ0T0FY?=
 =?utf-8?B?Ty9zbjVSY0oxS1lyL1pTOS92T2JJQXR4cmFRclY1anhvemtqQUdHYzF0QVU5?=
 =?utf-8?B?WS82ejBkNER6RWpVY1lHb2c0R2d3MWJ6cnB4QkpkM0Ywem9GUlYwejR1QTM3?=
 =?utf-8?B?N21xT1I0S0JrcGttc0sweGYyRDVjNk1ERktWQVZYSDNIMXNubEgreGdESkxv?=
 =?utf-8?B?ZDhsZlVWSE9ZQmpGdjRxY21kQWZmbFI0ZiswL2pyb1IrUGY1QTN6clllRWtx?=
 =?utf-8?Q?AgU/balFBk7dWjb3XMC0mUo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW9ZUWRtYWNpdVBrYUNFZ1ZhYzQ1c1V5a3B5T2hIYlBwc3MvRURYK25EcHlV?=
 =?utf-8?B?VlF3czQvTTJzZEttR2V2bEx1aDBhWmlVMXBPTWpKaURWYkMwVFBPWkV5SWxl?=
 =?utf-8?B?MERYZU0wQ2xqQlNhbS9iK3dVZmdDOWdTUFBpdzBTbXZhenlENDYwSUQzckxy?=
 =?utf-8?B?dG5Uc01ZVjZZUWVkeU53bjVhME0wYzZkRTh6b2RYaTN0QzJkVklNUmlOZnla?=
 =?utf-8?B?cEQzV0lKRm1VUG05MDFTbmx1NGhBTys4ZW9wQ3BmNXJuclNiT2M1M2N5ck1v?=
 =?utf-8?B?dXNBalc2enFIaUJ5Zi9lcVNGSURFY1U1NFRoMmVoMjRkS1VXUU1kUWQ4QVZJ?=
 =?utf-8?B?ZUptUkVRMmNYS1I0bWFaZ1JkU3p6bnNvK1U4Mm0zUU1XbTVmdmhXSmhVcEhW?=
 =?utf-8?B?UG5JWkhUN1kyQURtRE1LYy9NMk93N1liLzNqRTNoK3R3NEozUHl4SkFyVklv?=
 =?utf-8?B?MkJJOFgva1ppZkE5QUJ2MHIyWk9tUTdFVGJsNEZmM2VFR1Z4YmFPK2xXa2NB?=
 =?utf-8?B?aVpDUjhmVzVHanRzVitXRXB4aWlJeFhpWm1FQ0hBV1BLcDl5aXF1MVRYT1A1?=
 =?utf-8?B?QzFxSnFUTlhVd0xJQkZyVVFPRGg0dEZCQS9WalZVajI5WHNmYXUzWWo0U29S?=
 =?utf-8?B?bjlyWVo5MXloeUJYM3dmQnRPZ3R1OWxtMUZEejdXYy9MN2pra1RqUmMxSnpK?=
 =?utf-8?B?T3lhQkZXdGZOTkRtUFUwMkY3YnBMbk44YjBOZEZ4Q1R6V0hTTEQvUzFwYk56?=
 =?utf-8?B?SVA5MXZ1cTlDVTRUQmM0SnQrUjYraVFNUFBPQ21VNzJpZlh3Y1ZDSC81RXd1?=
 =?utf-8?B?bGNYTStWSFlqQ1JuWkVVUXhzZk50UEpKNXc4UDV1eWMxWUJkSUpodFFDZjBY?=
 =?utf-8?B?RVlKcFVOSzRCcmduSG1wSFp4VXFJY0RhN21ZUXJDMTRwMnF5ZzR3aXpsVmdD?=
 =?utf-8?B?QVRrVW00TTJoTFo0ZHNUUklha254MjgrTmlPbU5SREhFT2lVTzQ4WDI4a0JL?=
 =?utf-8?B?S0ZEZ1JLQjUweGR3OXBFUlp1NlFGeEdvM1pwM0ljbk1vSjVwcW9hRFFtS3FM?=
 =?utf-8?B?QVRsWThlSG9wUUhJdllUeHpwMFF1Z2E1V2hTSGRoWTl6a0c3TEVLWlNzNVFJ?=
 =?utf-8?B?RlBoeGxwWi9FT1lOMFkyc3g3akdQbmhQNW5Fem5Odkh1ZHRJUlhDcEdjWGdI?=
 =?utf-8?B?VThIT0lRNVBVRTYzNjY5Q3cvSXhXbk01ak9BWDhucTZ2dHBibkVueExiQkNk?=
 =?utf-8?B?bk1mb1VCZ2x0czgyU21Bd3FoWUxuMlUvSnIrRU9lYTJ0MXovV3R4QlhWL1g2?=
 =?utf-8?B?S2FQZ3B2Uk1lL29kMWNtLzJ2RDNORzBQMzl1QVFVNXpWZHQ1djFpaEtKZGtD?=
 =?utf-8?B?UE1lYWl3NGloMzdMYlFtS0ZGYmNQYW94NHgzMEVydWNSK1ZxR2J0Nnl4MmF1?=
 =?utf-8?B?czBIVmhnSVlUWG4vQTJOL0VzbHY1djN3bmFTa0RvMldibzNLZFF1SGRkcnpV?=
 =?utf-8?B?VEkyWmRUQnk5cXFIUXo1b00xOERVbWRud1I2cVZ0WW1WRElDZkhFNThMUkhO?=
 =?utf-8?B?ckVVNytDdW5GQnVRREdwektWcUcxZUJNUExKQ3hyaGIrN2hyN3FORStIN08y?=
 =?utf-8?B?Y2paMElyRkxUWDFvQzNoVUhOd2hmaS9QN3Ztem9XQU8vUFYxRDVwYTh4ZHZI?=
 =?utf-8?B?SmVmeEs5bU85Qy9WYUErbjVUODdYQkpKQkJHbEFGQjFoUXAyQkJLUUpwb21L?=
 =?utf-8?B?YXdFOWZ0cEtqMEtDRENyNzQ4OWpFOFhQUTYvdkZkSzIzcDIyRW52cFZyWkFz?=
 =?utf-8?B?aE5WZ3UwUlJhTTZvVGQ2TG1xaGk2L2NRWGluZjlKSzkrWlFtVXlXN0wwb2ty?=
 =?utf-8?B?ZCtkRHZPK00yMkN0NUFqKzFVQnhHUEt4VHlEejJQZ2tJNHk4NGg0MVkrRUJV?=
 =?utf-8?B?b1VHcURCVGtZQUxqRk9mQnFNMXBCRitzTndRN01KRFp4S1laOHk2Wm9EYVlm?=
 =?utf-8?B?Vm5JWDhGcmxFbjFVUENFSm1zVGFrOTZDMjZROTRUaUVlN1Q1MWNDaDRKSGUr?=
 =?utf-8?B?T2g5SFdKRnl6a2lEQXQ1dVVsU3hRWGpoaFEycmF1dG1iS1RnemxSS0p6WllI?=
 =?utf-8?B?dmZRWXhKdUpZR3o0RHFpK3J0ZGkwWFY0R1F1c01EU1hoYU8xMjJEWGJsdEdB?=
 =?utf-8?B?NnNJTVcrcENFakNLcjlBN3NpbktVdmh5eFdDWnR5VEtBb2J4dW4yeDFHM0w5?=
 =?utf-8?B?TjBzcHp4QUFvS2pWZldWTTZka0FwYmQ3dVVDRGt4UldxUHJpZ21JVCtSTDNJ?=
 =?utf-8?B?M0VhVUhGSTBHVjlWcmM0VW41VS9idG5jdzltSW1kbEYvKzFnc1h0Z2RpWklB?=
 =?utf-8?Q?pN9kGXEezCVFcX60ej4rJgT1YlsR7KmuLicQs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D32C7C3EFD4464C96984E8DFF04CAB3@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c404d76d-7299-4c72-3eeb-08de602ace16
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 18:10:09.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptYvn+yaL7dLQnm6ziP9tKgvsK2+zoZWuI97/IA3PgXN+70cB4Hb09ediyfajjd2kPzxE41v6qkb5OQfbGiVkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR15MB7052
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697cf405 cx=c_pps
 a=cexuP6Tr12ZHfMaaS00NHg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=3s8EF_wRBIBpWJQdpjwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IhpqsSjDZYxEUKZbW4WR695IozoCp69J
X-Proofpoint-ORIG-GUID: K0q_eexI0LsErqBDSE3-q3ZKLT6OZtyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE0NiBTYWx0ZWRfX5TxLrs4pVBBT
 MKcABg5di3FokO5lzRZ5h7M2iwxQtN66Ol4rlDsND2AOg4MrPBUznjflIBP8q5TGR8rU+U3obox
 n/ImudpXX0GyAcTLTZgzS+36BAr1vsZxIS5O7C7AI67BGZbQ+yOCmX7gFSclLWq/ygjkNpEL1Hy
 LOuXlfIGsvflVrARXSILzcKTRM+YUErwWcGlwDssXEnSAuXTbExlMG7C+rIvYS5I9tJbsEf3xQy
 MC4je2nnI/VEneDiQgI5xdrPavj1HvzTaQR2BFo70uBoFJLKC9FtX0DwAKhNKGvmjwA/jqByUlG
 K3M4OcwS31jeRHXul/YcEQEvO+FV95JtXBEFOT/LVGaHUg0xCCddEDB4ee6lSh/K8ooi8UFVUP5
 yiwDjqOoSjMoRvPq8ksPubyF9AaS6Tbe5lge0imB4mAsraBmlX5SKxHNpx+jxlb7Oe4tna4rj61
 LahkDTiiOWFce4PWevQ==
Subject: RE:  [PATCH v2] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601300146
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75957-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 97CAFBD9B6
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAxLTMwIGF0IDE1OjEzICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gT24gTW9uLCAyMDI2LTAxLTI2IGF0IDIyOjQyICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gU3VuLCAyMDI2LTAxLTI1IGF0IDA4OjM3ICswNTMwLCBTaGFyZHVsIEJh
bmthciB3cm90ZToNCj4gPiA+IA0KPiA+ID4gQEAgLTE3Niw2ICsyMzgsMTMgQEAgc3RydWN0IGhm
c19idHJlZSAqaGZzX2J0cmVlX29wZW4oc3RydWN0DQo+ID4gPiBzdXBlcl9ibG9jayAqc2IsIHUz
MiBpZCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB0cmVlLT5tYXhfa2V5X2xlbiA9IGJlMTZfdG9f
Y3B1KGhlYWQtPm1heF9rZXlfbGVuKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB0cmVlLT5kZXB0
aCA9IGJlMTZfdG9fY3B1KGhlYWQtPmRlcHRoKTsNCj4gPiA+IMKgDQo+ID4gPiArwqDCoMKgwqDC
oMKgwqAvKiBWYWxpZGF0ZSBiaXRtYXA6IG5vZGUgMCBtdXN0IGJlIG1hcmtlZCBhbGxvY2F0ZWQg
Ki8NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChoZnNwbHVzX3ZhbGlkYXRlX2J0cmVlX2JpdG1h
cCh0cmVlLCBoZWFkKSkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBoZnNwbHVzX3NiX2luZm8gKnNiaSA9IEhGU1BMVVNfU0Ioc2IpOw0KPiA+ID4gKw0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNiaS0+YnRyZWVfYml0bWFwX2NvcnJ1
cHRlZCA9IHRydWU7DQo+ID4gDQo+ID4gUGxlYXNlLCBzZWUgbXkgY29tbWVudCBhYm91dCB0aGlz
IGZpZWxkLg0KPiA+IA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gKw0KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoC8qIFZlcmlmeSB0aGUgdHJlZSBhbmQgc2V0IHRoZSBjb3JyZWN0IGNvbXBh
cmUgZnVuY3Rpb24gKi8NCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGlkKSB7DQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBIRlNQTFVTX0VYVF9DTklEOg0KPiA+ID4gZGlmZiAtLWdp
dCBhL2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5oIGIvZnMvaGZzcGx1cy9oZnNwbHVzX2ZzLmgNCj4g
PiA+IGluZGV4IDQ1ZmUzYTEyZWNiYS4uYjkyNTg3ODMzM2Q0IDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZnMvaGZzcGx1cy9oZnNwbHVzX2ZzLmgNCj4gPiA+ICsrKyBiL2ZzL2hmc3BsdXMvaGZzcGx1c19m
cy5oDQo+ID4gPiBAQCAtMTU0LDYgKzE1NCw3IEBAIHN0cnVjdCBoZnNwbHVzX3NiX2luZm8gew0K
PiA+ID4gwqANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcGFydCwgc2Vzc2lvbjsNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ID4gK8KgwqDCoMKgwqDC
oMKgYm9vbCBidHJlZV9iaXRtYXBfY29ycnVwdGVkO8KgwqDCoMKgLyogQml0bWFwIGNvcnJ1cHRp
b24NCj4gPiA+IGRldGVjdGVkIGR1cmluZyBidHJlZSBvcGVuICovDQo+ID4gDQo+ID4gVGhpcyBm
aWVsZCBpcyBjb21wbGV0ZWx5IHVubmVjZXNzYXJ5LiBUaGUgaGZzX2J0cmVlX29wZW4oKSBjYW4g
cmV0dXJuDQo+ID4gLUVST0ZTDQo+ID4gZXJyb3IgY29kZSBhbmQgaGZzcGx1c19maWxsX3N1cGVy
KCkgY2FuIHByb2Nlc3MgaXQuDQo+ID4gwqAgDQo+IEhpIFNsYXZhLA0KPiANCj4gVGhhbmtzIGZv
ciB0aGUgcmV2aWV3Lg0KPiANCj4gUmVnYXJkaW5nIHRoZSBzdWdnZXN0aW9uIHRvIGNvbnZlcnQg
aGZzX2J0cmVlX29wZW4oKSB0byByZXR1cm4NCj4gRVJSX1BUUigtRVJPRlMpOg0KPiANCj4gSSBy
ZXZpZXdlZCB0aGlzLCBidXQgSSBjYW5ub3QgdXNlIEVSUl9QVFIgZm9yIHRoZSBjb3JydXB0aW9u
IGNhc2UNCj4gYmVjYXVzZSBpdCB3b3VsZCBkZWZlYXQgYSBwdXJwb3NlIG9mIHRoZSBwYXRjaCAo
ZGF0YSByZWNvdmVyeSkuDQo+IA0KPiBJZiBoZnNfYnRyZWVfb3BlbigpIHJldHVybnMgLUVST0ZT
LCB0aGUgY2FsbGVyIGhmc3BsdXNfZmlsbF9zdXBlcigpDQo+IHdvdWxkIHJlY2VpdmUgdGhlIGVy
cm9yIGNvZGUgYnV0IHdvdWxkIGhhdmUgbm8gdHJlZSBvYmplY3QgdG8gd29yaw0KPiB3aXRoLiBX
aXRob3V0IHRoZSBCLXRyZWUgc3RydWN0dXJlLCB3ZSBjYW5ub3QgbW91bnQgdGhlIGZpbGVzeXN0
ZW0tZXZlbg0KPiByZWFkLW9ubHktbWFraW5nIGRhdGEgcmVjb3ZlcnkgaW1wb3NzaWJsZS4NCj4g
DQo+IFRvIHN1cHBvcnQgcmVjb3ZlcnksIGhmc19idHJlZV9vcGVuKCkgbXVzdCByZXR1cm4gYSB2
YWxpZCB0cmVlIHBvaW50ZXINCj4gZXZlbiB3aGVuIGNvcnJ1cHRpb24gaXMgZGV0ZWN0ZWQuDQoN
ClllYWgsIEkgbWlzc2VkIHRoaXMgcG9pbnQuIFlvdSBhcmUgY29ycmVjdCBoZXJlLg0KDQo+IA0K
PiBUaGVyZWZvcmUsIGZvciB2MywgSSBwbGFuIHRvOg0KPiANCj4gICAgIC1LZWVwIHRoZSByZXR1
cm4gdHlwZSBhcy1pcyB0byBhdm9pZCBzY29wZSBjcmVlcCBhbmQgZW5zdXJlIGVhc3kNCj4gYmFj
a3BvcnRpbmcuDQo+IA0KPiAgICAgLVVzZSBzYi0+c19mbGFncyB8PSBTQl9SRE9OTFkgaW5zaWRl
IGhmc19idHJlZV9vcGVuKCkgdG8gZmxhZyB0aGUNCj4gc2FmZXR5IGlzc3VlLg0KDQpTb3VuZHMg
bGlrZSBhIGJldHRlciBvcHRpb24uDQoNCj4gDQo+ICAgICAtRHJvcCB0aGUgYm9vbCBmbGFnIEkg
YWRkZWQgaW4gdjIgKGFzIHlvdSByZXF1ZXN0ZWQpIGFuZCBzaW1wbHkNCj4gY2hlY2sgc2JfcmRv
bmx5KHNiKSBpbiBmaWxsX3N1cGVyIHRvIHByaW50IHRoZSB3YXJuaW5nLg0KDQpTb3VuZHMgZ29v
ZC4NCg0KPiANCj4gSSB3aWxsLCBvZiBjb3Vyc2UsIGFkZHJlc3MgeW91ciBvdGhlciBjb21tZW50
cyByZWdhcmRpbmcgbmFtZWQNCj4gY29uc3RhbnRzIGFuZCBwb2ludGVyIGFyaXRobWV0aWMgaW4g
djMuDQo+IA0KPiBEb2VzIHRoaXMgc291bmQgYWNjZXB0YWJsZT8NCg0KWWVzLCBpdCBzb3VuZHMg
cmVhc29uYWJseSB3ZWxsLiBJIGxpa2UgeW91ciBzdWdnZXN0aW9ucy4NCg0KVGhhbmtzLA0KU2xh
dmEuDQo=

