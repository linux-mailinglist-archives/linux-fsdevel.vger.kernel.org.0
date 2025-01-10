Return-Path: <linux-fsdevel+bounces-38907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F5A09C04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 20:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3718164541
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 19:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADA7214A91;
	Fri, 10 Jan 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J6tRAoN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2A212B10;
	Fri, 10 Jan 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736538357; cv=fail; b=S9vSNF8+7RrHw5GYJUqhwwZ11h66o1fN+Zqdtvi73W4JdBFz0boeXSt33jmiV8JmkH+/2kYOc8yQ/MO5zpkpCNx3A3BgBZzagT0uMmkYkvgr82EGGpl5COwTqy0zuU/QSCB7zRRwkWsYKjmRT8ek1NKECSeUihYV9KT2zr5LHpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736538357; c=relaxed/simple;
	bh=GYqPUxdFpkD7b4gHeOBviaPk11cRujNLNTeAV8xtyNk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sTmM5U+8EkLp1HIOcTg0SndrRBFSFW/4x3FPj/F0vcJegjNN3sf4jqI8r3OE3rCTe8WA/gyfLTRsalARosxGdZSSbaonrir67YX1pGSAJfZjA3/LtrnV8Iz5i1WqHF46Km8yokqYxtuzDsXd/wHxhEkdcaS8+GG/AtZz6k6UCNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J6tRAoN4; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ACmOZo019227;
	Fri, 10 Jan 2025 19:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=GYqPUxdFpkD7b4gHeOBviaPk11cRujNLNTeAV8xtyNk=; b=J6tRAoN4
	Q9/N6qagBwCxHpQd5db2GMaVqf1XGUkns26FRpK9qQfOtnJKS8vU0TmDDloeBw3l
	JPDkrHsYzVlbU8aKK8FrKixaGd18kJMI5x+o6mDCDpDaO5SlT41EcfmXyfvPbKid
	qf6BJNj/KJDR+3CEO4JGR5Y6x6uzCtsuLVBjM4Z62IuH+vGRl2M4k/mPoKRHCakI
	zNqEIDqXyri5c4gjQQCDH9a88Xurk3rECiz4Il70SSdSn0vyYbivDLtn0SHsrkFx
	3Xu56sSMfniUGgSeGasa++YfE4T08evKoZQWFtXIGjQ4OMusI7VTk9/LOjIFxlgw
	XdwltqC53MFf7w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442r9avedc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:45:48 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50AJhaw7003474;
	Fri, 10 Jan 2025 19:45:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442r9aved8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:45:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1d8j9+mFuquO/Xsemws/ZpqB6LQAcmFZ6kIjMOVvLptqoaYtUba0kmICav5eoZGnoJNcouwasIs75Rwg3cr/0lal7MqBZI9/7O6kPTDHqoFAlnZK4G4QI5z2k349Qco5YYHhoGp4ZbG4qLNXo0z4p9vnvveCrrG9KhEU05YIusVL5wuMSLKKlEHq0ak0OYYsFwwVOOP2UbRONrx0XE5CKbC1LEUSu3cm+5tp6iAOHBPMvAiPThwamNZ5YiYKjgGhUQPDsz0TVQXbxpBOPBzPABbkHea42Keg8miZzvmudwgU/RHJpc03AuwSxlFtuDo1uOC1bhi6sJyY/VsrS83Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYqPUxdFpkD7b4gHeOBviaPk11cRujNLNTeAV8xtyNk=;
 b=zU3GOo5kJKBZGdjWLgj/2vL2v1gWhcitZT39AnhEigHHttjNYx1v7+FGZc7LrE1k6sIGXuKAjs2uBJ7TymPsT6gLql8sS3TnZV2x3lrrZGt8I/4NguyiMkFZHx6r6EOR6BkTzSEHfKVs79mTqcPtBgAuryIHp0HAqHvN5WP7r+0Sk45rpmSAAtFQFQDaqYKH+9ra+cfICCs2yp09y8EaZKeZ55LVjTnd812GH8/57qGoah+2K0D/xaJlc8caYU6l5XIJt4+jyuH9exuKdUm+w3IWEak6dnVcfVtfiSGZBm4Na0Yiy3SvGcgaJbTPI4qioxTBRc+ujZWbz7RimPiomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO6PR15MB4163.namprd15.prod.outlook.com (2603:10b6:5:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 19:45:45 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 19:45:45 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "jack@suse.cz" <jack@suse.cz>,
        "hubcap@omnibond.com"
	<hubcap@omnibond.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        David
 Howells <dhowells@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>,
        "krisman@kernel.org" <krisman@kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 09/20] ceph_d_revalidate(): use stable parent
 inode passed by caller
Thread-Index: AQHbYwlvvAIUQvpDEkyMuyuBKS5pqbMQamYA
Date: Fri, 10 Jan 2025 19:45:45 +0000
Message-ID: <ae36bc60fc7f670dfb72e958a3faeaf72afb6c3a.camel@ibm.com>
References: <20250110023854.GS1977892@ZenIV>
	 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
	 <20250110024303.4157645-9-viro@zeniv.linux.org.uk>
In-Reply-To: <20250110024303.4157645-9-viro@zeniv.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO6PR15MB4163:EE_
x-ms-office365-filtering-correlation-id: c510196a-2b52-44f3-4524-08dd31af5fc5
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHJhcUFpNTJ0UWkveW5pWjd3cDFpQit5WEg4RjM3amJrR1RPMEVUUjJvSHJ4?=
 =?utf-8?B?c1ZsUDExNDYyQk5VSjhKTnlGRlY3YzZCejBybDNoclN4dDZFUjBHQW41QmR6?=
 =?utf-8?B?SjdnYjAyMzg4YitSUEN4VVVQT1hTQ0wzTjdtRmhvams2MFhnZ0taNi9ibjk1?=
 =?utf-8?B?VGFVZXFqcFY1eWc0R21UMnQ3SlNVU3cwOGNKV1lDUjFoRWx3YXAyYmtIa3dp?=
 =?utf-8?B?eDBGdnM5VHB6cWZJRkRPckZJU1NFUkN6MnpFV3EvVHVRYnhucExyRFRQZ3RE?=
 =?utf-8?B?SXdKalJLRDI0MElibGxCYTBaZHJwZ2kzQjRKbTg2YzNWeUdKY1RmbjMzOGJN?=
 =?utf-8?B?bnJCTjFBcVMxVUhFNzEvSnJrYW5jZHllZTJYdlY3K1Byenh6a1ZWQm5JaTZD?=
 =?utf-8?B?UExpL0gxak1XMVFuKzIrQUs2NFdWZGdzU0JnTEw5V3UwZElNOVFMVG9tSW91?=
 =?utf-8?B?MFBnSks1RzIwcE42S1YyWlJ2c1RENjFFeStLbHBiaUFEdFJDbnIxMGRjU0ZY?=
 =?utf-8?B?RUVnUU9rQStZM1hjWFhBY1crV3JHeUhuTlJjNnVxL1lwcTFIUFFRTDBqS3Z6?=
 =?utf-8?B?dk8wVHFxZXI0c250RDYzT1lMcWZHUnlGanc0aDNpeFVWMmlOZzJzRTRrWnBs?=
 =?utf-8?B?NXQ2T3lkR1h6MUNuWnJUTFNCYzN1VmFnLy9wckRXNmQ4RTg5enNOQ0M1U3pm?=
 =?utf-8?B?ZWdXVitUdTFJcUJvcDY1UVhVcFlBUW1rVk0vT1pxNUdpM3hVaGVEbVVTN1Jx?=
 =?utf-8?B?TUJaZUR2K200MVZaWktoeStXcFc0akx5bXRDRW1xeXJkK2ZvN1l6RUJScmU1?=
 =?utf-8?B?ck05ZkpLS2ZpTEtOWnhhK0U0dTY5cnVPNGdhbXlJVjhLcFpnaFM0SDJXb3hx?=
 =?utf-8?B?a2lSL0twYnZsQmlGQnNiMHYya2JsazNZZ256VnlQN3BLL095RVlOWTRXZkZZ?=
 =?utf-8?B?cURKdGxTbDlhN1Y5aFQ3dExSQk9tK1o1NmZnYUQxRERlLzFLOHdUUWQ5RW1B?=
 =?utf-8?B?QWxtVFpmZ1ZyaDRDOFZncitpUkpxMklUNVdFOHNKSDZwZXRYUE9FRzNuTXBt?=
 =?utf-8?B?STNHTlFUR3pDQk91b1hHTVdKU0Zsam9jSXJsRnYxWjlOdHRZWEhMd0xwZUUr?=
 =?utf-8?B?VjJlQWs0NG5YNiszS2VXb1YrKzY5RE1yMmhMaXZUZ3U3TXpTL0F4MTgyMkJJ?=
 =?utf-8?B?T3B4d3MrN1hhYlNudEswdW1JWFNYdFVsSkJhNEsydENEUGlnenRWOFZWQXdE?=
 =?utf-8?B?dkJVWkR6NG81Mm1RN3Y3N1RZSE94WDBTOXkrTzVZWHFVSVpjanJzSnc4bDJZ?=
 =?utf-8?B?alVSTmJldWErbnlLaCs2OGxwZXF4LytqZGtQMVcwQXdxTjZaUDk4MWdNamJ1?=
 =?utf-8?B?SlNVTUVlTkloTStKa0E3bU1lai9HMWhQVE5LUWF6bzB4YTB5cHNRNzdxWDhL?=
 =?utf-8?B?QjhQT0JRY3FRemZPc3RTZkU1anJIWWdxOHd3ZURsSmFkSU83Vkk0K0FRVFE4?=
 =?utf-8?B?eTRzQWxEOCtqYXYvVW1BTjNBcFlBOCsybnJrZUt1YkZGcEp0V2tDaE9LYW9o?=
 =?utf-8?B?Y2Uxd0srT0trb1lRNlBRMDlIYWVLTUE4NlpWTnlUMzEwbW5ub05CTmlwTmlZ?=
 =?utf-8?B?TFhSR3lMSnJ6ZDZyUng1c2ZMbC9CQVlWVzRRMk5idG8rQkE3YjNaNy9LaWpl?=
 =?utf-8?B?VStpNU1WZmFVZXJRWjFRV3JzMDUzdlJZSGtoOXBFSzA5TjFqeHhHTllQc0NP?=
 =?utf-8?B?Z3pOZldrT05SMHFMSzZXSDd3UDgxMllvdERpRGhmNCszbTV5Wk40eG5BdmNj?=
 =?utf-8?B?TythZVRSRzdLZ294UlQ5VXFHTlBXMlZrSHhzdnNqc21iVHM5RVVZaW5oQm9k?=
 =?utf-8?B?dHU1N2ZmVG14TXB6NEhyOTBrSFFmMjJNS0RKVVFLTVR5bm9HUUFBb2w3R2Uy?=
 =?utf-8?Q?cS0MLMjol/DG1Je5ZtGlcuvmRSxgv3hQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkZyNjNMMDh1Nm1UeVAyMVhSSlVMbkFpZ2RkVXlsOS9RMnBuWlJaeG04SkJG?=
 =?utf-8?B?MWZ1SzhHM3NHUDNyQnlRV0xsRlN0bVl4bmlKOU5uSmg3a1M4Y1k5cXpBbE44?=
 =?utf-8?B?QStNU2oyQS9Bck1GNWVMaE90Z0VCeGtadWFLbG52Y2ZJQ2h1WkJYTEpmL3k1?=
 =?utf-8?B?UTlZVm9HQThwL1l4T3cwUE42a0hOS2JYaGRNdWpDUTZpMG85ejNhOWtlTUJx?=
 =?utf-8?B?K0VBTDBuZHkvZzV2Q1RRRFpNbCtPQ0dxc254ZC80WEErOTFQaVVMcDkxeVF1?=
 =?utf-8?B?QytoaGV0MG81bUVvSzViWDdWQ05neU12MDc0ei9EcnU1S0hRMFNkYkZxTllE?=
 =?utf-8?B?am9CTGF5Y0JERjNTTUlSOFZOUEFyQXBKVDFkRmhrcW9ieHhJU2VGZzdaZHho?=
 =?utf-8?B?UWNKWDZ5TG9PRFBXVHJwSzdSYmlwaDV1R3VTK0ovanBLTSs3dVc5RFFtMDR4?=
 =?utf-8?B?Vk1DbDBPQTVQejJaVi9BN1RvVUtxUDE3dlpQOW95YSt1SWhrdjFxdlBxYnRR?=
 =?utf-8?B?RUJTMDFKVU9Yalk2Tm5GVk1zNVhra0V0OGl4WkI3WUJNd3VjY1BlWElZL1h4?=
 =?utf-8?B?ekYvYXNtSzIwWjREbTdtWUxVLzU3UTU3V2t1bFBFb0ZXdXZqem1OWXA3R0Vp?=
 =?utf-8?B?RWhkTTAvaUhBc09iZU8rbTNsc3pIR3NpWWJEVjJLK1JFLytoZ0R5c0l4dzc0?=
 =?utf-8?B?dHdOSWt4dzdmTWljRjBJUFExcW53UEpIdG1Rb21KV2ZING1ueWh0Rkd0cDNJ?=
 =?utf-8?B?RVQrRzRsRmo0RzdHY0tsM2xBeWExMjlFbm9SMlIwU2hWM0ZxT25qdmJTOW9o?=
 =?utf-8?B?MmtTa0FDOE5HTTl5RUJGM3BVOHo2ZDlqR1hKcHZGYm9DWkRqRnB3dkNTVUpq?=
 =?utf-8?B?RUJneUdseHZzNDYxb0F4Rmg0SlZFdnQ3R2xCVG5BZ0U2bjlaVUp6bkdlMWh6?=
 =?utf-8?B?eUc0NHNTSkJScXdoMEYwUitIVFp3WGpZbmpDOUl6VExQdUtkQ1BHYnZ2T3hK?=
 =?utf-8?B?c0lPR2ZEQVpLaEszekVaQXIyWXJZTHpBeWJGTm51Qm5INm5BWUQzYjd1a0wr?=
 =?utf-8?B?L21ib2ZxZ3ozK3VkNWRrNk1Wamd3dDc1aStPNlZMSHZsMEhDdXJsQ09Da0h1?=
 =?utf-8?B?YkJ0OERGOGl3LzhDWmtXN1JHdVpPdU9OOGpOZkJQTm5acGFlQTNmczJYTnpB?=
 =?utf-8?B?bDllWkJPWUgvVEdpRjFJc21Gay9wODVaTE9VZC9wY0lGdDB5QnFXWllLOC9I?=
 =?utf-8?B?eU80MmVaQmtEc0lObGpXZ3I2aXdMaWJlVEF2Sk5ZK3JvdWFheU9IM3RkUC9v?=
 =?utf-8?B?Y2FDVk15T2M4SXhVeXBXMXVrQ3dqK0VOT1RubEU3YnFiaXFhYzhrOXhhL1Nv?=
 =?utf-8?B?bkVnWnlwZDJKR29EUVBDK0syZDZKa3o2N3Z4Tm9NNmY4VDdLSWFkSjcwTkxG?=
 =?utf-8?B?NmIxUkp0NUdFUlUzNXZrOGNFcmVhcGVFaTgxNlN0bnhKRXRyZkNuU0ppay9u?=
 =?utf-8?B?TjdHMFU3QkFMM0J4NmpNZDVTb2V5RmJ2b2lUNUtjNURZYXFwWkVQRnVQZC9l?=
 =?utf-8?B?eTZMbDVsMXNqR0QwOS95eXdlcG5QcU5VeXNRUFdDUG1zMXFtUHJJKzIvaHph?=
 =?utf-8?B?SEpLNGo2dW56a1p2TnhTVjVnOGdweFF6Rm9wYjVCTGxXdVRtSmxueEU4ZjB4?=
 =?utf-8?B?WnA3bXI0OW96OGY5MzRjY29wTENiVGVLYnB3dnBweTg2Z25HdmdVYU9jNDB4?=
 =?utf-8?B?NjZTdndKRmRodjhjSmtDUTNrQjZoNlNUamFPRGxQYTNsSFdPVmJxenZCYnRL?=
 =?utf-8?B?aGI5Q3UvU01WcHNIOXJNUHJHQ0lwenBwYXQ1Y3pjaUFabVlSM0xzRDlBNHA0?=
 =?utf-8?B?bGE2WEtIN3gvR0FaU0c1N0lBQTk1SHcwTlV6Tm0vY21YcytNMjBEMUNLVm5Z?=
 =?utf-8?B?S3NTS3BMR1dzZG1zWDNwMlZvZmE2VTBwSE8zVzBMSzNlZGE0ZGFSZnVYWnEr?=
 =?utf-8?B?SjBDREUwSWRvVEtWdlNsZk9YMkRsRkRKSUVjemI2TDE4eXRkbmNiSURJNVhV?=
 =?utf-8?B?WDMzRFpoeGozbHlwYTZsdGthMHpTZXM4Qmc1UlNiRUpaVkZpdFdhZkZGeTlp?=
 =?utf-8?B?QW0vWGgreHFsZlNBUGYyTlJrd1dFUmkwWjhOcWxpemJqRldmbC9tWUlibGFL?=
 =?utf-8?Q?It6p+DS5eWPUARs+6twAZN0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FC23C940EC88641A24E1359999F71B8@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c510196a-2b52-44f3-4524-08dd31af5fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 19:45:45.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hD4bGsWIeHRs2vtPyIKhdcbkHFUsqKb6+HlptDk7qBVEslGjLqLTrrLSO68Pr3831TNIxd1RH9K+xDx73amGRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4163
X-Proofpoint-GUID: giXYPQRZbSvf9YSno5x_FZvNf60yvEoa
X-Proofpoint-ORIG-GUID: Vx1jI-K5itWtVdltnIYlLP5RZfwABbHD
Subject: Re:  [PATCH 09/20] ceph_d_revalidate(): use stable parent inode passed by
 caller
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100150

T24gRnJpLCAyMDI1LTAxLTEwIGF0IDAyOjQyICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBObyBu
ZWVkIHRvIG1lc3Mgd2l0aCB0aGUgYm9pbGVycGxhdGUgZm9yIG9idGFpbmluZyB3aGF0IHdlIGFs
cmVhZHkNCj4gaGF2ZS7CoCBOb3RlIHRoYXQgY2VwaCBpcyBvbmUgb2YgdGhlICJ3aWxsIHdhbnQg
YSBwYXRoIGZyb20gZmlsZXN5c3RlbQ0KPiByb290IGlmIHdlIHdhbnQgdG8gdGFsayB0byBzZXJ2
ZXIiIGNhc2VzLCBzbyB0aGUgbmFtZSBvZiB0aGUgbGFzdA0KPiBjb21wb25lbnQgaXMgb2YgbGl0
dGxlIHVzZSAtIGl0IGlzIHBhc3NlZCB0byBmc2NyeXB0X2RfcmV2YWxpZGF0ZSgpDQo+IGFuZCBp
dCdzIHVzZWQgdG8gZGVhbCB3aXRoIChhbHNvIGNyeXB0LXJlbGF0ZWQpIGNhc2UgaW4gcmVxdWVz
dA0KPiBtYXJzaGFsbGluZywgd2hlbiBlbmNyeXB0ZWQgbmFtZSB0dXJucyBvdXQgdG8gYmUgdG9v
IGxvbmcuwqAgVGhlDQo+IGZvcm1lcg0KPiBpcyBub3QgYSBwcm9ibGVtLCBidXQgdGhlIGxhdHRl
ciBpcyByYWN5OyB0aGF0IHBhcnQgd2lsbCBiZSBoYW5kbGVkDQo+IGluIHRoZSBuZXh0IGNvbW1p
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVr
Pg0KPiAtLS0NCj4gwqBmcy9jZXBoL2Rpci5jIHwgMjIgKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZGlyLmMgYi9mcy9jZXBoL2Rpci5jDQo+IGluZGV4IGM0
YzcxYzI0MjIxYi4uZGM1ZjU1YmViYWQ3IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2Rpci5jDQo+
ICsrKyBiL2ZzL2NlcGgvZGlyLmMNCj4gQEAgLTE5NDAsMzAgKzE5NDAsMTkgQEAgc3RhdGljIGlu
dCBkaXJfbGVhc2VfaXNfdmFsaWQoc3RydWN0IGlub2RlDQo+ICpkaXIsIHN0cnVjdCBkZW50cnkg
KmRlbnRyeSwNCj4gwqAvKg0KPiDCoCAqIENoZWNrIGlmIGNhY2hlZCBkZW50cnkgY2FuIGJlIHRy
dXN0ZWQuDQo+IMKgICovDQo+IC1zdGF0aWMgaW50IGNlcGhfZF9yZXZhbGlkYXRlKHN0cnVjdCBp
bm9kZSAqcGFyZW50X2RpciwgY29uc3Qgc3RydWN0DQo+IHFzdHIgKm5hbWUsDQo+ICtzdGF0aWMg
aW50IGNlcGhfZF9yZXZhbGlkYXRlKHN0cnVjdCBpbm9kZSAqZGlyLCBjb25zdCBzdHJ1Y3QgcXN0
cg0KPiAqbmFtZSwNCj4gwqAJCQnCoMKgwqDCoCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHVuc2ln
bmVkIGludA0KPiBmbGFncykNCj4gwqB7DQo+IMKgCXN0cnVjdCBjZXBoX21kc19jbGllbnQgKm1k
c2MgPSBjZXBoX3NiX3RvX2ZzX2NsaWVudChkZW50cnktDQo+ID5kX3NiKS0+bWRzYzsNCj4gwqAJ
c3RydWN0IGNlcGhfY2xpZW50ICpjbCA9IG1kc2MtPmZzYy0+Y2xpZW50Ow0KPiDCoAlpbnQgdmFs
aWQgPSAwOw0KPiAtCXN0cnVjdCBkZW50cnkgKnBhcmVudDsNCj4gLQlzdHJ1Y3QgaW5vZGUgKmRp
ciwgKmlub2RlOw0KPiArCXN0cnVjdCBpbm9kZSAqaW5vZGU7DQo+IMKgDQo+IC0JdmFsaWQgPSBm
c2NyeXB0X2RfcmV2YWxpZGF0ZShwYXJlbnRfZGlyLCBuYW1lLCBkZW50cnksDQo+IGZsYWdzKTsN
Cj4gKwl2YWxpZCA9IGZzY3J5cHRfZF9yZXZhbGlkYXRlKGRpciwgbmFtZSwgZGVudHJ5LCBmbGFn
cyk7DQo+IMKgCWlmICh2YWxpZCA8PSAwKQ0KPiDCoAkJcmV0dXJuIHZhbGlkOw0KPiDCoA0KPiAt
CWlmIChmbGFncyAmIExPT0tVUF9SQ1UpIHsNCj4gLQkJcGFyZW50ID0gUkVBRF9PTkNFKGRlbnRy
eS0+ZF9wYXJlbnQpOw0KPiAtCQlkaXIgPSBkX2lub2RlX3JjdShwYXJlbnQpOw0KPiAtCQlpZiAo
IWRpcikNCj4gLQkJCXJldHVybiAtRUNISUxEOw0KPiAtCQlpbm9kZSA9IGRfaW5vZGVfcmN1KGRl
bnRyeSk7DQo+IC0JfSBlbHNlIHsNCj4gLQkJcGFyZW50ID0gZGdldF9wYXJlbnQoZGVudHJ5KTsN
Cj4gLQkJZGlyID0gZF9pbm9kZShwYXJlbnQpOw0KPiAtCQlpbm9kZSA9IGRfaW5vZGUoZGVudHJ5
KTsNCj4gLQl9DQo+ICsJaW5vZGUgPSBkX2lub2RlX3JjdShkZW50cnkpOw0KPiDCoA0KPiDCoAlk
b3V0YyhjbCwgIiVwICclcGQnIGlub2RlICVwIG9mZnNldCAweCVsbHggbm9rZXkgJWRcbiIsDQo+
IMKgCcKgwqDCoMKgwqAgZGVudHJ5LCBkZW50cnksIGlub2RlLCBjZXBoX2RlbnRyeShkZW50cnkp
LT5vZmZzZXQsDQo+IEBAIC0yMDM5LDkgKzIwMjgsNiBAQCBzdGF0aWMgaW50IGNlcGhfZF9yZXZh
bGlkYXRlKHN0cnVjdCBpbm9kZQ0KPiAqcGFyZW50X2RpciwgY29uc3Qgc3RydWN0IHFzdHIgKm5h
bWUsDQo+IMKgCWRvdXRjKGNsLCAiJXAgJyVwZCcgJXNcbiIsIGRlbnRyeSwgZGVudHJ5LCB2YWxp
ZCA/ICJ2YWxpZCIgOg0KPiAiaW52YWxpZCIpOw0KPiDCoAlpZiAoIXZhbGlkKQ0KPiDCoAkJY2Vw
aF9kaXJfY2xlYXJfY29tcGxldGUoZGlyKTsNCj4gLQ0KPiAtCWlmICghKGZsYWdzICYgTE9PS1VQ
X1JDVSkpDQo+IC0JCWRwdXQocGFyZW50KTsNCj4gwqAJcmV0dXJuIHZhbGlkOw0KPiDCoH0NCj4g
wqANCg0KTG9va3MgbXVjaCBiZXR0ZXIgbm93Lg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBE
dWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0KDQo=

