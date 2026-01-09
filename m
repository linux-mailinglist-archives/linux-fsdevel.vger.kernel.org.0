Return-Path: <linux-fsdevel+bounces-73093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 743F7D0C347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 21:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE9543010D50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50747368284;
	Fri,  9 Jan 2026 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hIAn9cNW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD423382CB
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991409; cv=fail; b=QZscUXjCPx1OXWvwjrHR+vFvxLp2AjaY6910KjhLMMfXRencXAhrDdROm1SZK1GUg7RytOAA1G9NMbnihV13iuFqtPSvcmHf+vL4gC1XnDedw5enSmRQljG440STUPLGotcpshQ57ZtKPKuEa89LKz73far8lH1umbgKq7nL7Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991409; c=relaxed/simple;
	bh=Njnh7AshO5SzH7+Lup0qvy07lAwBhqC703/Y2em3RMA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=U/ZCxmnYEP5Tv9qDnv2qAdja/mMcsaRj4DoDMz9j1KDo2ViKm2u/gSYvePue1bh1Ce9bNQ1qfCuYzVQ6FMEVaCAMF9SPYpSPkcP5jo1NinsAkHdZc22dSTEbgepHZ4s+gFIOdJKG308o2Hauns1ZPOLXFnNFjq8xfixZbOTrW7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hIAn9cNW; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 609IwJlQ022322
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Jan 2026 20:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=MtK3313zwlHZ8XfdZj6KDylsEw5+n0QW06cQvU9nNS8=; b=hIAn9cNW
	UfheR8oYWfshZ1m3ctvJe4khly4vNU07jPuugQjrRmBqsS5r22qCDAYMIoRaF6OF
	YaHtiOQHHzpcLCI1RIBCDiZSa9ujQ0f/0XOb0CWsH1DY6D25F0QDCAKZRhhqEGdU
	+ugeExmbqEHT8RcceytP9DshQ58wAtsuldC7Tj/GDhYQE0Gd033mXV2k3CvBXWkX
	D5E3ViQfyXBXIph+lD1fuWaNMYBKrqhYd9EE2UwkvYqwkYF2zGE9McCoUEDB004A
	PAdMTPv5lTVTwvIqpiwvaQBQO3sTgHlt6Uhe2JoDQ3qiMAW4hE/AKgr0ZOYTLnQV
	FaapUzgQw/iibg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkky2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 20:43:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 609KWLTJ021522
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Jan 2026 20:43:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkky26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 20:43:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 609KhOOE007924;
	Fri, 9 Jan 2026 20:43:24 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkky21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 20:43:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQsfMBBljjQCzpBf5VbWFhe12w9NLbnRemEGrqwUsOS4MSbrVpqNs50bQdIpYswvhyqA6EyT5kgdGZxj5e0OtVWxbr/saLufcUD/IrRHAUdhrt0KxrkfKFpsjdXwOM215yZ0ppKFdrLtMsP5lRZrXGdXB65LZwZTF7i639yYKJ8Xp4yaOAilXuEopTi1S5fiYgCkrPYRR0vkUJv1OthRXC39qDlwg6o/84/Rs9mq4HKwvxLj8OSJctWaKyRQLQ2A7rbYu2Lnotd1KGvfbVhytCYOAzgLDs+LKPN5GRpxOe2oxz+nNMTlSyZUQDvWg3gxz+aAIB72NI8V56dO1KPnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+S9+HaOffFhDynvdpC1y3vziniE4fnh81FNqNyp4ic=;
 b=DCEBYSJiDAxCX8zCRwKEQwRHzAt2jG/gcRp0RIqvdlYlh0Dx5eUOi2iCegYyI6wImP/fzmGGqWXduuoIY/kxnSIlhvx0btdysgg4LlsVYjLNQPerGWCSC9yubjocVJApPsX5pMkrMti6dsM41hd9GYQO0DBbFu8RBBYH3E/v612nt3NeIgLbhEy3Kna2ogfoORX2oosfDq/eXcbmO9MyhuoToM5yV8sjJM3r4uMmuNbsAtU88xKlSCCBWW7jkgpaAYkgQPSnsgBNqBPF4n//ANLoKXdz+6FHPgcxBrLpYBVd+1oR6lJLEenIA8qNuyQxbuUGPB500H+w7CCE1nHX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB6845.namprd15.prod.outlook.com (2603:10b6:510:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 20:43:22 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 20:43:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>
CC: Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        Kotresh
 Hiremath Ravishankar <khiremat@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcgYqBrVghEKLMSke4cAKVr89dELVKThmA
Date: Fri, 9 Jan 2026 20:43:22 +0000
Message-ID: <03d862404f1a64f1ca16aa863bd4d4a6d0cdf830.camel@ibm.com>
References: <20260108223453.907929-2-slava@dubeyko.com>
	 <CA+2bHPZ9WiTnJXFgoRveHchOm0j=A1qeKt+T59QJpfMkrPX0Mw@mail.gmail.com>
In-Reply-To:
 <CA+2bHPZ9WiTnJXFgoRveHchOm0j=A1qeKt+T59QJpfMkrPX0Mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB6845:EE_
x-ms-office365-filtering-correlation-id: 54951169-1202-4f98-7946-08de4fbfba9c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzN3aHd1dWQxL0dHYlA4K0FEaEFROVlTTW8ySWF1SnRYU0FHSUFmOVE3SmdX?=
 =?utf-8?B?MXJtdFltSXNhc3BnUGxkWXBGZnVWR0VOcy9qcUR0Z3hPZm04cm5MbWE2K0Rz?=
 =?utf-8?B?dDh1Z3I5MjNIc3V5UUZnekpPZVIxWEc1TlVVQjBrM1BCNE40d1loQ3pReU0z?=
 =?utf-8?B?TTNST1pRdG9lcWZraWQxWVZwa3dnN3RQajBTamNpWlIxOXdIa1N6TDQvaDhn?=
 =?utf-8?B?MlBhOElPTWZPZ1VuYmdpdXRZa2s4RXNVQlFQQ3ZKdUt4ZXQzTDMzdXRLT2Ry?=
 =?utf-8?B?cmRLY2hCS0FwNlBsRHljTXNoN1NKbTF3SWNsejM4RlJ4K2NlQ0E4YjMxTzZF?=
 =?utf-8?B?SExNbFRNU2Y5UURXR25Ld3Zaa3R0NlVKaUw3dkVQRzZNQVdiVkU4OUVrTm56?=
 =?utf-8?B?SWx5N0dMOHVNc0J3NXBES2dxVE5BZG5CMC92ODc2UWlmYlJPb1p3TUlkeTFX?=
 =?utf-8?B?WENPTUJGMGNRNXBGMkd3ZUxIMnBqSkwwQlo3NmdJdFRxdHg2TWNucVhGT3Fk?=
 =?utf-8?B?R0hvZklVTkVRL3hBbHVyUzgvSFpWR2VjZ0dzNEFZaVltb21oN2FkZ1pZQkhF?=
 =?utf-8?B?ck1qZzFLeVlXQ0R5d01oQVBHK0UvSUVjMHB2bE54NGtYbm4rNVF2d0hyNVM1?=
 =?utf-8?B?b1YvZkIzWDVKRDdqZUkzbWY4YXpmQWpqRW9aSDF6OWtNV1dzMW1uMDlua3FO?=
 =?utf-8?B?WXVvQURPbVk3aWgxQzRBVFNGc1pQNG52RVc5TVBzajJkTUZxYWpJV0RaQ1Rq?=
 =?utf-8?B?bzgwZE10TkF0UjRWVDZVblE1eEpPbHpOMW13UEh4YmZjMFBXd01QdnR2b2hN?=
 =?utf-8?B?UXlVNCtteVcvcVpNTWV6eFRndlRpQS9kSnYyS2VPalRTb2VYYjRpQzdqdnlx?=
 =?utf-8?B?YXlLaEpkN2lJQzlVeWlqVHFFZDVJaWJRbE41OTQ3aTlzdXdMMDZ0ZGVka2hq?=
 =?utf-8?B?VU1yNVd3OGZnYm9YVS9OL09EcUxqM2FaQkFZVUY2MEtQQXpQTVo0MjVZems0?=
 =?utf-8?B?NS9jQ3pvOThaMDZvVVZoTDMxV245YnZ4eEVpTWhjR0VBcWcvRkJoSExRYXJR?=
 =?utf-8?B?UVd6Rmw4MHAwUkxId3I4RUhxM1hKK3FSSHNCTyt5R093K0c1OGd6VkdCalJw?=
 =?utf-8?B?ZVJncnY5U1hVN3p5NU5kWVFQWlpBVzJkL3FueTNLVEJDYjU1RXk1c2FQcGda?=
 =?utf-8?B?NWNEVlJBclBrdU9aRHIxOHdZemdFU0lXSllxcVpza3RWSGg2bjh4clF0L3Q2?=
 =?utf-8?B?dnludU1hTkdtV2NvV2w1M3NRa0xvdml3MHV1OFpWK04rd3Z6SHZtTzlwNE5H?=
 =?utf-8?B?K2RQVG5QRTNtTngrK05iYlN5QVl3amdMYmJDQkE5MzMrK2lRTEUrenRQem8r?=
 =?utf-8?B?dEZHRi9Cd0ExV05qREMvYlQ2L05aS09hYmg0Qjl4eVJ3WnAxS2tOZHhRQWRM?=
 =?utf-8?B?SXU3SFRsc0QwcVZ4bWp6TEdyVlZoUzVtRnVaS1VKZjluazdjazNvSkl1elAy?=
 =?utf-8?B?OExZSTZvQlJwbjh2TGNUL3RFVVFDT29WRWJvQndvbGYrRVFiSm1Id1c3djIw?=
 =?utf-8?B?R0REVElDeisxV1dpcmk1bkNBdlVGTjNxTVlCcnNmS0x0eGwxdmdVbWFWdkVi?=
 =?utf-8?B?aENNb011REhVSm90RVNVNi9GaWdPVzhmQWNFeDNuMGZqejE1L0dDcVdyNmhH?=
 =?utf-8?B?bjhxeDJoYnRjb3RRaWw2WjQzbFZScHVVSVJFZjl3WjNZeGFjdXZEVHZDeVVk?=
 =?utf-8?B?ZjAwNXN0aHNRY0pBS1VPYzVYK1o4ZTErNjkrWHNRY1EzUk1EUGM4aUM1MXVj?=
 =?utf-8?B?Y1JNOStBTlNlNFJpN2J4TFVTUCt4b2hiVWgzZit3YVl0bXJKRFMwVWlHK1U5?=
 =?utf-8?B?SlFrSDl6RTNISU53ZkhhTVhsYnJHSDJmMG9mNy9MUHpBKy9jNFZTanJFVUJv?=
 =?utf-8?B?OHVUUk5mOW1xeEtKSzI1T0FzRnB2WnVDTUF1Nm14YlhjUlJja3hROUc2UHY0?=
 =?utf-8?B?eEU1MW56dlFyMGpwWFhsQk9qZWtsVTN3UTVzRno4RkR2L1J1Yy9iTndvNldT?=
 =?utf-8?Q?wCqpbm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N25GZ2RXT3czWFUydFpqcEIyN3BlRGZ0cXA3dk1BQWlkZDFMc1dpcHp0VTZv?=
 =?utf-8?B?RUZKMUFWZzByMTBTdWo5bXlJaWwxZkYwL1BBM25LYzlFcFdjMWlrOVFBYmJC?=
 =?utf-8?B?WjNkUjI5bHcyYklFb016TFNVY0lZNXNHMW05QUdGR2s2dTUyTUtyeUNYelZw?=
 =?utf-8?B?WHBkNjNvaVdyOERoWTNzcDlleTF2YjdkMktkRUVWNGVsemVQS1BGdG91ekRC?=
 =?utf-8?B?dlNXSXFNdjQ1UE5sOVlEZjRjNUE0Q0oyemlpQ0h6d2U4ZnRxc1VkVHBOMkcv?=
 =?utf-8?B?UWowc3RPTDdOUmJ0dDJPK2RXZjRMVThEOW90RmJrUnVpZWJOcEtrSkU2UmNo?=
 =?utf-8?B?bytwRk82cFpZZ0ZiREE5S2Y1RzU4cUR3UG9lZCtONGFKYWtzSTdpcHI3czF2?=
 =?utf-8?B?NGNjcG5nczFMMUNqUjYrd1pZQks3TVhGYW83cDRucmcrTHk4SlBCby9IcG51?=
 =?utf-8?B?eE5IdDgzTlhmUStuTERKMlZOckMvQmNZUThyL2d0aTlpMFlsYUg3VDM4emdO?=
 =?utf-8?B?aWxDc20vYngzT3ZPU0FKc3VWTU9vZzFzOTNPUDJuc1htZjM4RG9UNjRiV0FI?=
 =?utf-8?B?b1dLcWViL2dTQ0NhWGZIV3NldlRsM3luRHRNT2tBQitITXErNjRaSjRBeEtK?=
 =?utf-8?B?VHk2ZU9vZ1hXTDZJdmdNamhOMm9ueGRCam83WktCRERxMU5WZlcvbTh5QXIv?=
 =?utf-8?B?bjZyWmxPbzMwSEM2ZlRqVVNVbXZDWDFYK2ZMQ2Y0UlRESFR2bVR4V2pQVmUy?=
 =?utf-8?B?U0JqZTRRWENkK2x3akZwekxaY21JdWx4ZCtSK294cFlWYXBrUm5jVUk3YWpL?=
 =?utf-8?B?Z0NmYnB1K3BITEJxcnFYM21jVkVaMWpxOXJDRVhjYkZQOW8xMjk5WHpTYU55?=
 =?utf-8?B?SVAzOEFrOWRsTFRQT3hpSjRjUXRTQkNKamw3RDEvcEZFZStnVGJ5QnVtc295?=
 =?utf-8?B?TWZHZEw4bFAwVDJlVG1oWlJ2b2NzR0RQbmw5OXZtck04aU1YUHBUQm5INGFm?=
 =?utf-8?B?KzRDMDFPRy9pMWtYSGVoOS80ZzJEbHdvSURnTzRDTE9OU0ZjejNsRnRFRW9l?=
 =?utf-8?B?bHJZNkh6UG9rcXE0UTFPOGVISDlSQlRqamMxWGRnN3FzMUZabGFkWXRlSHoz?=
 =?utf-8?B?NmIwdHJ3MUxMazBaYnNtTW0vZGRhVW1XTkNHeFlkZENqN0lSY1ZiS1pIZmov?=
 =?utf-8?B?bzRWR2c3ZnlSdFhVYUkyY0RsQ2tHd1YzS2hKcDFWQVJCazZsVlE5NE85cGFX?=
 =?utf-8?B?em0xZGdyZWEwZndGbWJhSUU1SXdEdUE4dGdPbVBQdTM1SldDazZUV3BDeWlV?=
 =?utf-8?B?ZTByZG5YZVlYRnlwUWRqM0xKOFI3azlvQjdjM1VGcklMdXUrVE9DVW1HME1C?=
 =?utf-8?B?NkhJL3F1ZW8rU3EyTWhPWnc2UDljNFZJNFNRb1RYMDJ4UTgxMXF5eGpHMS9l?=
 =?utf-8?B?TmR5TndzOXVNU29wY1k0ajRNQVJNQm9PbHhQSmM1L0VmMVljZU1ScytBcVEz?=
 =?utf-8?B?ZHJyclMzNjM1eDF6SFArcXh1bFAzK3d4WVRHakV0SmNBMlJBdVZYdzNMOWcr?=
 =?utf-8?B?czdPSTRpY1kwVFB2ZmtJTkJPRDNPbmRqNnRFUlpLMG5NK2FFd1p2R3BwTWpm?=
 =?utf-8?B?ZWdlUlVCb0xlSHZJOEZaSGVLQTVEbmE2S29mcGtZcXkzQjRlV0Eyek9HdTM4?=
 =?utf-8?B?Ull5bDFEOGRaYzFDd0Z1Y3dBWHNMVW1xWjJmZjAwRWtBUDFzOCsyc0ZPSlIw?=
 =?utf-8?B?dWE3VHZrdkxrY1JJdCtuaWdPWHlBWXJXMk1jNlI1eDdDL0dKREdOVWg5aFlO?=
 =?utf-8?B?amhVY2JFSWFTZnlVdnFYZ2pqRU9lRWxtaE5JZ3FFd1djVDBmRzltbTRXamhL?=
 =?utf-8?B?MHVYa0d5dUVSTzhNeGNoWW4zamlzQXZDMG9OMW9yc010Y0JmWVlhSktsbXhU?=
 =?utf-8?B?dHRZK21YeUpEMzE1elV2Vmp6TnlSdjU5NU5oc1pOMzZnOGl6amozRDF0Rk83?=
 =?utf-8?B?YnNUd3UrSjdQQWEvY0RIaXpzWjg1OUFJUG9pK3EvWGt3VWU3dmpzM3ZQR24z?=
 =?utf-8?B?TExKSFN2RkhnSHUxUDNmWlpVenIzS2RQa25VcmV1TlozY0syMm5CQm1jbndw?=
 =?utf-8?B?OGpxYTdNeUloM3hOSXhWd25YdURIWmljb2o0NzVkck1FVFE1amo0ZjNVaDly?=
 =?utf-8?B?MFNvL1dObDJaRlpmN2phTFJBdDJuSTVPTUpXc3dRYWxjTXU0Sncwb2dPVEp5?=
 =?utf-8?B?elg1OE96dVJkMGg2U1ExZUYyRW44WXZuR2NHMnd6dy9mWi95NTgrNG9RaTVm?=
 =?utf-8?B?aTV0UGlxSUtFNmdBQjJoZ3dnS2lBT2czUEdtSDk3TnZNK1Npdm5hMHFmcmJZ?=
 =?utf-8?Q?S7D3/lFeYeLgDgBzvWdV1qNr9hAMDTik4A9H0?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54951169-1202-4f98-7946-08de4fbfba9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 20:43:22.1113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kkazsb2HArv1r7faDRoZUxnYXB2FMzRNyLJrIZpkH98nXjLr7B5Yr0fgYcp+4vQJIQ9OqxznefhUiF9LBgzhkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB6845
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=6961686c cx=c_pps
 a=fIWvqWWOoOps8dVAlNTpGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=4u6H09k7AAAA:8
 a=wCmvBT1CAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=RIwtDGM1fP35bAoETxUA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=5yerskEF2kbSkDMynNst:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: y9zSriV02-g79XqsYPk1SEjfSokAKX9o
X-Proofpoint-GUID: ZKRp3X8rJNF802f_coU_Jcz5I4KLuQ0w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE1OCBTYWx0ZWRfX8qSST+GO403G
 OnLh3btI6XxU4X7pyX+7F7zdx9slCGX0p1HLTNzz/vIAhiww+dkv4DEIugb8E0pqoBHdMJ71Ol5
 0i4Kn/ifcGGvWGxaPVzl3+NLJiz4mRLWtphOB8C1himtACS6FG6IZyNBfVseVf7wn6LiF2NP+32
 XxGSsFQ2YMXPnmMn7I3DTOYGYeFpN+MiXY//2mcvSZNETbunoE/YB964asNtCoKGrvwbvx9VKlz
 3ZnYiUwOCHGq2+z4Jbj3NAgT/GTlR6BvQlh/ciLdB3O0MxEvEsGQyRLtTxGye1tg+rhmAJ14yUr
 vJQPiMX7igDT8GRaJBVl/6NAJmLAaNhyBeCJl/QqX8AJ5JPjsjIGOXW7mAVrHTKV1TsXQrJSP29
 kiD48PoOGvUgNp1PEP5pREH82v97z5mT3WVpQ1VgGFW9gNicZy0w4C5a+Ocr7cuX3O4IP1ShPbW
 ryxmnFxBmNpa8YsWCxg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3152B5F40F2664EA3D663360EDF8A3D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v4] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2601090158

On Fri, 2026-01-09 at 12:07 -0500, Patrick Donnelly wrote:
> Hi Slava,
>=20
> On Thu, Jan 8, 2026 at 5:35=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The CephFS kernel client has regression starting from 6.18-rc1.
> >=20
> > sudo ./check -g quick
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYN=
AMIC Fri
> > Nov 14 11:26:14 PST 2025
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch
> > /mnt/cephfs/scratch
> >=20
> > Killed
> >=20
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > (2)192.168.1.213:3300 session established
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL point=
er
> > dereference, address: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read a=
ccess in
> > kernel mode
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000=
) - not-
> > present page
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] =
SMP KASAN
> > NOPTI
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 345=
3 Comm:
> > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU St=
andard PC
> > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > ceph_mds_check_access+0x348/0x1760
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > __kasan_check_write+0x14/0x30
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x=
170
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > __pfx_apparmor_file_open+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > __ceph_caps_issued_mask_metric+0xd6/0x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/=
0x10e0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x=
50a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0=
x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > __pfx_stack_trace_save+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > stack_depot_save_flags+0x28/0x8f0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0x=
e/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x=
450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+=
0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d=
/0x2b0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > __check_object_size+0x453/0x600
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0x=
e/0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0=
x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > __pfx_do_sys_openat2+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x10=
8/0x240
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > __pfx___x64_sys_openat+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > __pfx___handle_mm_fault+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0=
x2350
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0x=
d50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/=
0xd50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > count_memcg_events+0x25b/0x400
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x3=
8b/0x6a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > irqentry_exit_to_user_mode+0x2e/0x2a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/=
0x50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95=
/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145=
ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3=
d 00 00
> > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c=
 ff ff ff
> > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 =
28 64 48
> > 2b 14 25
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d3=
16d0
> > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda =
RBX:
> > 0000000000000002 RCX: 000074a85bf145ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 =
RSI:
> > 00007ffc77d32789 RDI: 00000000ffffff9c
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 =
R08:
> > 00007ffc77d31980 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 =
R11:
> > 0000000000000246 R12: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff =
R14:
> > 0000000000000180 R15: 0000000000000001
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pm=
c_core
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_v=
sec
> > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesn=
i_intel
> > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgas=
tate
> > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc p=
pdev lp
> > parport efi_pstore
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000=
000000000
> > ]---
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> >=20
> > We have issue here [1] if fs_name =3D=3D NULL:
> >=20
> > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> >     ...
> >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> >             / fsname mismatch, try next one */
> >             return 0;
> >     }
> >=20
> > v2
> > Patrick Donnelly suggested that: In summary, we should definitely start
> > decoding `fs_name` from the MDSMap and do strict authorizations checks
> > against it. Note that the `--mds_namespace` should only be used for
> > selecting the file system to mount and nothing else. It's possible
> > no mds_namespace is specified but the kernel will mount the only
> > file system that exists which may have name "foo".
> >=20
> > v3
> > The namespace_equals() logic has been generalized into
> > __namespace_equals() with the goal of using it in
> > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> >=20
> > v4
> > The __namespace_equals() now supports wildcard check.
> >=20
> > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > contains m_fs_name field that receives copy of extracted FS name
> > by ceph_extract_encoded_string(). For the case of "old" CephFS file sys=
tems,
> > it is used "cephfs" name. Also, namespace_equals() method has been
> > reworked with the goal of proper names comparison.
> >=20
> > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_clien=
t.c#L5666 =20
> > [2] https://tracker.ceph.com/issues/73886 =20
> >=20
> > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/mds_client.c         | 12 ++++----
> >  fs/ceph/mdsmap.c             | 22 +++++++++++----
> >  fs/ceph/mdsmap.h             |  1 +
> >  fs/ceph/super.h              | 54 ++++++++++++++++++++++++++++++++----
> >  include/linux/ceph/ceph_fs.h |  6 ++++
> >  5 files changed, 78 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 7e4eab824dae..339736423cae 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> >         struct ceph_client *cl =3D mdsc->fsc->client;
> > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> >         const char *spath =3D mdsc->fsc->mount_options->server_path;
> >         bool gid_matched =3D false;
> >         u32 gid, tlen, len;
> > @@ -5679,7 +5679,9 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >=20
> >         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
> >               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)=
) {
> > +
> > +       if (!__namespace_equals(auth->match.fs_name, is_wildcard_reques=
ted,
> > +                               fs_name, NULL, NAME_MAX)) {
> >                 /* fsname mismatch, try next one */
> >                 return 0;
> >         }
> > @@ -6122,7 +6124,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_clien=
t *mdsc, struct ceph_msg *msg)
> >  {
> >         struct ceph_fs_client *fsc =3D mdsc->fsc;
> >         struct ceph_client *cl =3D fsc->client;
> > -       const char *mds_namespace =3D fsc->mount_options->mds_namespace;
> >         void *p =3D msg->front.iov_base;
> >         void *end =3D p + msg->front.iov_len;
> >         u32 epoch;
> > @@ -6157,9 +6158,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_clien=
t *mdsc, struct ceph_msg *msg)
> >                 namelen =3D ceph_decode_32(&info_p);
> >                 ceph_decode_need(&info_p, info_end, namelen, bad);
> >=20
> > -               if (mds_namespace &&
> > -                   strlen(mds_namespace) =3D=3D namelen &&
> > -                   !strncmp(mds_namespace, (char *)info_p, namelen)) {
> > +               if (namespace_equals(fsc->mount_options,
> > +                                    (char *)info_p, namelen)) {
> >                         mount_fscid =3D fscid;
> >                         break;
> >                 }
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index 2c7b151a7c95..9cadf811eb4b 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -353,22 +353,31 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct cep=
h_mds_client *mdsc, void **p,
> >                 __decode_and_drop_type(p, end, u8, bad_ext);
> >         }
> >         if (mdsmap_ev >=3D 8) {
> > -               u32 fsname_len;
> > +               size_t fsname_len;
> > +
> >                 /* enabled */
> >                 ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> > +
> >                 /* fs_name */
> > -               ceph_decode_32_safe(p, end, fsname_len, bad_ext);
> > +               m->m_fs_name =3D ceph_extract_encoded_string(p, end,
> > +                                                          &fsname_len,
> > +                                                          GFP_NOFS);
> > +               if (IS_ERR(m->m_fs_name)) {
> > +                       m->m_fs_name =3D NULL;
> > +                       goto nomem;
> > +               }
> >=20
> >                 /* validate fsname against mds_namespace */
> > -               if (!namespace_equals(mdsc->fsc->mount_options, *p,
> > +               if (!namespace_equals(mdsc->fsc->mount_options, m->m_fs=
_name,
> >                                       fsname_len)) {
> >                         pr_warn_client(cl, "fsname %*pE doesn't match m=
ds_namespace %s\n",
> > -                                      (int)fsname_len, (char *)*p,
> > +                                      (int)fsname_len, m->m_fs_name,
> >                                        mdsc->fsc->mount_options->mds_na=
mespace);
> >                         goto bad;
> >                 }
> > -               /* skip fsname after validation */
> > -               ceph_decode_skip_n(p, end, fsname_len, bad);
> > +       } else {
> > +               m->m_enabled =3D false;
> > +               m->m_fs_name =3D kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
> >         }
> >         /* damaged */
> >         if (mdsmap_ev >=3D 9) {
> > @@ -430,6 +439,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
> >                 kfree(m->m_info);
> >         }
> >         kfree(m->m_data_pg_pools);
> > +       kfree(m->m_fs_name);
> >         kfree(m);
> >  }
> >=20
> > diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
> > index 1f2171dd01bf..d48d07c3516d 100644
> > --- a/fs/ceph/mdsmap.h
> > +++ b/fs/ceph/mdsmap.h
> > @@ -45,6 +45,7 @@ struct ceph_mdsmap {
> >         bool m_enabled;
> >         bool m_damaged;
> >         int m_num_laggy;
> > +       char *m_fs_name;
> >  };
> >=20
> >  static inline struct ceph_entity_addr *
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index a1f781c46b41..fe950bd72452 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -104,18 +104,62 @@ struct ceph_mount_options {
> >         struct fscrypt_dummy_policy dummy_enc_policy;
> >  };
> >=20
> > +#define CEPH_NAMESPACE_WILDCARD                "*"
> > +
> > +typedef bool (*wildcard_check_fn)(const char *name);
> > +
> > +static inline bool is_wildcard_requested(const char *name)
> > +{
> > +       if (!name)
> > +               return false;
> > +
> > +       return strcmp(name, CEPH_NAMESPACE_WILDCARD) =3D=3D 0;
> > +}
> > +
> > +static inline bool __namespace_equals(const char *name1,
> > +                                     wildcard_check_fn is_wildcard_req=
uested1,
> > +                                     const char *name2,
> > +                                     wildcard_check_fn is_wildcard_req=
uested2,
> > +                                     size_t max_len)
>=20
> I'm puzzled by this. For all callers, is_wildcard_requested1 is always
> is_wildcard_requested (why have it as a parameter at all?) and
> is_wildcard_requested2 is always NULL.
>=20

I can see your confusion. Let me explain my troubles here. For the case of
struct ceph_mount_options, we have mount options from the left:

bool namespace_equals(struct ceph_mount_options *fsopt,
+                                   const char *namespace, size_t len);

So, I can assume that I need to apply wildcard check for the left string.

However, we don't have likewise method for the case of struct ceph_mds_cap_=
auth.
Finally, if I need to consider generalized __namespace_equals() method that
operates with pure strings, then I have no idea which string needs to be ch=
ecked
for wildcard. Because, it could be as left as right string. So, this is why=
 I
have introduced the check function typedef and __namespace_equals() receive=
s the
pointer on check function as for left as for right string. And it is up to
caller to make decision which string should be checked for wildcard (left,
right, or both).

If it looks slightly complicated/confusing, then we can consider option of
introduction a method:

bool namespace_equals2(struct ceph_mds_cap_auth *auth,
+                                   const char *namespace, size_t len);

But I am not completely sure what names should be used for both checks. May=
be,
do you have better idea here?

If we have specialized methods, then we can assume that string that needs t=
o be
check for wildcard is from the left. And it can simplify the
__namespace_equals() method. So, which direction do you like more?

> Additionally, for all callers, I believe name1 and name2 should never
> be NULL? Perhaps you mean to check e.g. name1[0] =3D=3D '\0'?
>=20

I am not completely sure. I cannot rely on it and it is much better to be r=
eady
for NULL pointers.

> In any case, please comment each of these below conditions because
> it's hard to follow without doing the logic for each case manually in
> one's head.
>=20

Let's be on the same page at first. :) I can easily add comments here.

>=20
>=20
> > +       size_t len1, len2;
> > +
> > +       if (!name1 && !name2)
> > +               return true;
> > +
> > +       if (name1) {
> > +               if (is_wildcard_requested1 && is_wildcard_requested1(na=
me1))
> > +                       return true;
> > +               else if (!name2)
> > +                       return false;
> > +       }
> > +
> > +       if (name2) {
> > +               if (is_wildcard_requested2 && is_wildcard_requested2(na=
me2))
> > +                       return true;
> > +               else if (!name1)
> > +                       return true;
> > +       }
> > +
> > +       WARN_ON_ONCE(!name1 || !name2);
> > +
> > +       len1 =3D strnlen(name1, max_len);
> > +       len2 =3D strnlen(name2, max_len);
> > +
> > +       return !(len1 !=3D len2 || strncmp(name1, name2, len1));
> > +}
> > +
> >  /*
> >   * Check if the mds namespace in ceph_mount_options matches
> >   * the passed in namespace string. First time match (when
> >   * ->mds_namespace is NULL) is treated specially, since
> >   * ->mds_namespace needs to be initialized by the caller.
> >   */
> > -static inline int namespace_equals(struct ceph_mount_options *fsopt,
> > -                                  const char *namespace, size_t len)
> > +static inline bool namespace_equals(struct ceph_mount_options *fsopt,
> > +                                   const char *namespace, size_t len)
> >  {
> > -       return !(fsopt->mds_namespace &&
> > -                (strlen(fsopt->mds_namespace) !=3D len ||
> > -                 strncmp(fsopt->mds_namespace, namespace, len)));
> > +       return __namespace_equals(fsopt->mds_namespace, is_wildcard_req=
uested,
> > +                                 namespace, NULL, len);
>=20
> I think we agreed that the "*" wildcard should have _no_ special
> meaning as a glob for fsopt->mds_namespace?

Frankly speaking, I don't quite follow to your point. What do you mean here=
? :)

Thanks,
Slava.

