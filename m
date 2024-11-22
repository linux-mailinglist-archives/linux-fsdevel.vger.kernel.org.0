Return-Path: <linux-fsdevel+bounces-35582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC01A9D604A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A077282809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF945D477;
	Fri, 22 Nov 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VhOwUgaU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FG0XRDPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39112259C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285870; cv=fail; b=nB2FdMmKIlqvnFLNAQPNl8hefK4k/x/sZCdXKot/XJZ2GSPYEXhhZqKfjspqr64U/jAFZOP4Ot3T4a6+Usudns4cMGwV+ZUXdNpCElakbOGJUa9bMW/Am62pHocq0w7bWlJe2XJJGSh3BoaGKTOgCI4haRAXk09nCAdAE485hf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285870; c=relaxed/simple;
	bh=pprfzYLfwDmcmWXmhguqOGgXcquZrels0JwvdTJDM+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N2l0u+InHuqyBbompjvd2I93wYY9Bqlm5z2xD96yOKi++BMgLmR+f0txmMiPXUCVB3sUsbZKmKdBE1DJd7MZ3FdaY1HfPMUB2C1oAJ/J+ifSHI1tEcfgW8hHiwRMGbawNDzvLSEvzM3yaPnZG506QlnjKUbqpXKfh2pN8HfVUW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VhOwUgaU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FG0XRDPw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDFKVn032145;
	Fri, 22 Nov 2024 14:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pprfzYLfwDmcmWXmhguqOGgXcquZrels0JwvdTJDM+Q=; b=
	VhOwUgaUxVFSEvrDujt/k4NQseKgpVFTiA+IRRPmDgwbnHCxVJgbKGzOpD+QsoH0
	VAqLnodDzJlLPFqYUbPyC2E6D+0mSHj14W3313VRUaW/4JuWBRNksi/0/ySCOZiB
	KOGcXhESQwItgXWk9swIWgK50VknJapVg1vzqK6XBg5p/+gELuZ//dDjN2B7Wzap
	E9Rb6gesig6kJJyte/w9ZQhuWqH0ArXOvH/LKWZ0eizPkp7GotdvHfyIJsNHw4cm
	/8RHXPbWq3JA3CvqLLX7QawH/Jw7zN84zQl6+AmNN7RoZe2XFMveSXkZKK00DU7P
	1z5DqImIC9YDNw5OPvHbnQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98ux3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 14:24:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCoR0Z008894;
	Fri, 22 Nov 2024 14:24:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuddsqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 14:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcOSZIkPoP40x2rlNYKiOLM8ncrsCreM0j6VT+57xsz3p74sE1ZFsTfsPEY+JfMfD7ocQtsD/ejMTOW8if8DCEshdnO5tl5fPJTqDDN0FrO/iyud89G0ScUZWbhpu9REtj4X0Nnkh424i+KYjYjMPvVEidbCpcdh8G0tpW5qnP4NY9lIve2kwau76YsIroMBF6BjK6mlowIoeC/ZzsP1V9NC8JtW9LKME4ledWydGXpqnEXOKRIOJs2QMkJmDFfTg0j7Gz8SMAbw9x7k+mZATXfNEk/sOnWE7M7LOKMIVH+YEkGLjMPDuzYt5q4aNWIplfacrg8J+Lwun+cokocNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pprfzYLfwDmcmWXmhguqOGgXcquZrels0JwvdTJDM+Q=;
 b=BwAv/MQYI8Ct5aS+LNodXD9WTQ1Eauc/fslUIPgUU2yynXWgEagXNit8P6dIC74NoBNWuEQMdpxETheVHjbBiDLUwSiRxHWAVkAGMAhNiD9iZfuOuIml9Sr+HUa6cTxXeq3CfDeLAGzbqR0oR/dBBuEeP/DF5yl7ZhUqx979HuFKatU0VrwCiffKHIKnbG+0x54oZGHrR6KwHXeyLoT0JQwKcGHXo9EeHxSmBb/sFiHpzHD4RJsdULMQ14NK8cCEUaS5+WheOWFwhntGN2kz7/jbwP+GSycYpff5lxNMjcwNM2tpz6hN4N2t5Ui3xx1cU0ngu9oo1d5bQZ/mjfuoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pprfzYLfwDmcmWXmhguqOGgXcquZrels0JwvdTJDM+Q=;
 b=FG0XRDPwfwB4GqNa5S6rZpCZrOYUpf4QtMDrfG5Yh6T2i7XbfmbBFisQ/8JZYbj9n3B+o4ocMleLXuO730oCsJCTRrSdfwj2WEilxDbw/KkqaANUdJDPhGK7wYi5f/D3tZxraslps06jm+DzLzhVquJNKQQwBppOictH0vhYSOs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4708.namprd10.prod.outlook.com (2603:10b6:303:90::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 14:24:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8182.018; Fri, 22 Nov 2024
 14:24:19 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        linux-mm
	<linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Daniel
 Gomez <da.gomez@samsung.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Thread-Topic: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Thread-Index:
 AQHbOTg5NlJ24GOTaUaIEolbfGmWZbK9drgAgAAP/ICAAlv8AIAAEmaAgAF4ugCAAGosAIAAa0iAgAADSwCAAL3bgIAAXYcA
Date: Fri, 22 Nov 2024 14:24:19 +0000
Message-ID: <09799E1C-345A-4A2C-A36C-EA2F291F4319@oracle.com>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
 <20241120-abzocken-senfglas-8047a54f1aba@brauner>
 <Zz36xlmSLal7cxx4@tissot.1015granger.net>
 <20241121-lesebrille-giert-ea85d2eb7637@brauner>
 <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>
 <63377879-1b25-605e-43c6-1d1512f81526@google.com>
 <Zz+mUNsraFF8B0bw@tissot.1015granger.net>
 <CAOQ4uxhFdY3Z_jS_Z8EpziHAQuQEZgi+Y1ZLyhu-OXfprjszgQ@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxhFdY3Z_jS_Z8EpziHAQuQEZgi+Y1ZLyhu-OXfprjszgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4708:EE_
x-ms-office365-filtering-correlation-id: 64eec79b-c689-41d9-b7df-08dd0b015a47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wnc5VHEwcW56bUJIZFQ0K3hMNCsvTFNUdEtqZXZHc1FHN0xMVGo0eGtRak5o?=
 =?utf-8?B?MmZNQWpsODdpVlQ0ZE0rNDJRRm1tUXZpWUNwTDZxYVZXN3FCaktyOUJacnZi?=
 =?utf-8?B?V3Y2MHBERi9HL1dxbU1XSUtzN2htY3pzNzBzWENPUVFac0RENnZQelFuRng5?=
 =?utf-8?B?YktRNkZFNzhiMVhxb2xWUExBemI1U2Q4bTlvZmJ6U21DUWordTA1NmtQSWNI?=
 =?utf-8?B?MHRHbEtNQlZCbUNDdk5BZk1QWXA5SmtjV0NwY1ZPYXN4ZFREdk5qMFY4cDJr?=
 =?utf-8?B?NHJOdmsxVjNPWDRYMFY3VytoS3JaRkRGb3o4aTdDUEgxL2pXR2ZJcDFzMmli?=
 =?utf-8?B?TEFDMU9VdTQwZGtlL3BmTXlnWTdCdTBvaGNLL1J4S3hrRGt2a202K1FxOFd2?=
 =?utf-8?B?dlhqSk1qMUZ3N2wrNjBsUlpPUU5PSUp3d3dSOEVJUmkxNzExeDlEMDdweVVM?=
 =?utf-8?B?SjNwVC8xNStJWWxhdUxxWEhwMEpnMy9LaFdXdXBiT1VPSHF2RUdMM05GMGpu?=
 =?utf-8?B?RlhGWW9Oa3N0UnRZaTVGOWRsT1lVY3pYRVFLM20xYnVCMDI5NzdzS1R2M2or?=
 =?utf-8?B?SGF5TkVIK0pPbE1mN1RJV0pqMGdYZFl3WnlRTHNRTWlkektFeE9lMFlWR2JN?=
 =?utf-8?B?YXRPUFNDenZoV3lQOVN6UHdXT3ZVZ3hmZHJmU1kzUGtvd0ZON3Z5SWxpV3Bh?=
 =?utf-8?B?d2s0YnliRzVjdVBnaWFDVkpnSDd3OUVvMWhIN3FwTEhUcTBGdUNaMkoxNWcx?=
 =?utf-8?B?ZjlKT2ZjZVVqWVdDNDk3TEVaS0pjU1dQT2phTGsxNVJTaUJyWVJwb2R3Zk9n?=
 =?utf-8?B?TnA2cEE3TkR6VlJuUzNMTUhBRHc1U2xySjdmODliaDJpTEFCb3RqYjBZM25a?=
 =?utf-8?B?dFVhR0tkbW1OSURKdit3UW9PQ0trRUxRa3ZGUWpyc0VKazhqMFRiVmQ5eFRi?=
 =?utf-8?B?TjJ5SmNWWnpGeS8xUSt4N2NmU1lhK2ZvRXJmUjVBMmV0MHlZaHFuOFVTZ3JF?=
 =?utf-8?B?Uk9zR01laVpqVmxQSHhhS1FhRjNIbGtpakVVR3EyejFGVXpYcjFCNWJGd2xV?=
 =?utf-8?B?K0h1S2JCQVlGNEZJVksyMjB1SlJjOFYyanBuNTNKOXUwZXdkcFM2eDVnTTdQ?=
 =?utf-8?B?enBqQkJFVGcxbUlxMFI1MkV3NjNOYzg5NVlYWjd5VTFWUGdNZHg2dVBrL1lw?=
 =?utf-8?B?ZFFCekdQNHZCOFlWRmROVEhzcnoxMW95NXhEWWpzdStrSW9Hc0xhM2VLM1lu?=
 =?utf-8?B?eExMNWdzTXprYnZFMm56VGFTMTVZWTVWclJzc3MrVVU5cXlFYnRXTnhvTUVl?=
 =?utf-8?B?cmcxaU9ZcW5xd3NkV0NZYXllTWhNdjltQkpRT2NJVW0zRUhOaGZVY0s2R2gr?=
 =?utf-8?B?WVdMYVAxVXozNjNYSFp3UWZySlVQeXRFSjJOVDJsV09XTjFQT2xta0pINUg3?=
 =?utf-8?B?UFZmZnBJYWpxZkNOTVg5d09JRENCK2lYUDdWYkw3cThUMVFtRHpPRFg0bmdE?=
 =?utf-8?B?MlNFOWhUcDQ5Mkl3Zm1ZY3llbG1KQ1JpaFdVV1hGczJPdjR4a3R6UFFMTkJa?=
 =?utf-8?B?NncrbGFqTnNGTitZL2FXZnF2eXY5cnpBQTNnKy9Gd3BDaE5jVC9kV1lvTDMv?=
 =?utf-8?B?eU10c09QcXZTcXBYVmFaQmlNdVNZTjdtdkxTMUdncG9lUzRoM2FJSjM1MU1o?=
 =?utf-8?B?Tys3NEM0NFg2alJUTEM2SHRuSnZpdHdOaGxhSFZaYXVvMGJ4QVFxaFBsRzNh?=
 =?utf-8?B?T3RhM1BmRmJkQlc2UTRxbXF6azFmSWozQ0VoKzR5Skt4QUs0ZDg0R2lwSk00?=
 =?utf-8?B?QU1teWpQUVVEcEd4UnllandaNUJLV1VaSzN0VFcvN2VmL1kzSGZYeUtORDZ2?=
 =?utf-8?B?REZKcGdhSVJnT2phTHF2N1Bmb3UvUE43SjNNck8yVWZpeUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3JUNUtzeEYzdzd1RTU4MngwY041UEtxYUMyUm5qR1lnVCtteW91aExYSWZI?=
 =?utf-8?B?V1V1cjhDeS83ck5rNEdJN0VXc2lzUUZraksxc2JaU3ZyaTJVOGhkSldvaHNT?=
 =?utf-8?B?aHJNZzE2ZDA5UGVxNkVFcGlOY2lOVmdhRTNCZGxVY3l4U3ViRXN0ZlZhWkxy?=
 =?utf-8?B?ODBtSnU0Q2tVdTN1LzdRNGpVQW9xeTRWcjB2KytFaG14YkdhbGZPa2NGVFk0?=
 =?utf-8?B?eC9MRHMwN0o4Y3BWa3pwYks1dUpmWUliTDhuaWlrci80SzlndzhYdlFiT3Zw?=
 =?utf-8?B?MFQrYzZ2b3dwNGlBR0VlWVVjUWp4MUZLRVY5L3RCcU9lS2hJMkZXK2JkQTNQ?=
 =?utf-8?B?S3VLRThSVUdnZGVVMW5HQitWOWFVM2dIVWI1WFViZ05SOUFibld4SnBNMnJ3?=
 =?utf-8?B?YWk0VWxsRUg5dHNyUU9tYms5cmEwQ1VhTUFJV2k4V2lpV2QzNmJWWlNmQ1Fx?=
 =?utf-8?B?SFFWaGdkWFFOWDFBelV4UDVOWVphNER0ZTJLd2tOZmJjUVNhMitibGhNV1Ur?=
 =?utf-8?B?cDZkWXB5b1ZGeTJrWjMzNW81Lys4WWg0NzV0Y1dQUzhEblloS016KzR2QXF4?=
 =?utf-8?B?U09kdStzUUZNT3M4NmIwaXlsdWVvRHJXblR5bk02TkRVOHYxL3ZiN1habzhU?=
 =?utf-8?B?eHVaN0RUdmxTVmw1ZVdlMUo5ZE9FNEwzUXA4VFZkMkNsa3lKZEJFVklQQXRz?=
 =?utf-8?B?NCs1ZEorK2xlaTBtamsvZGxSMVBPRGQwd2QrRHRaRXZKSkJZMFFSMDg3NTY3?=
 =?utf-8?B?RFB1R0ZWSXBscE1sSmFiY0tIdjZjMzJ3QXNkV1E4dnJoSXFlZGhMM1ZORXVj?=
 =?utf-8?B?cVdvMG9BaUNiOE5FNGpwNThIS2JubTlyQm5VSmpPa3hnbEkvQ0RYcTlSKzJM?=
 =?utf-8?B?QzJELzN5SDMxdjFIRjNHY1FZQnVoMEQzdHhXc2hka1l6dFF3ZWdrRVFUYnNi?=
 =?utf-8?B?QUtmaDh3RnF1TDBUMHpRWVpKaG9xY1RFdVhBUmcvclhtZnNNc1JsRjRTNi9T?=
 =?utf-8?B?dzJPSVRCMEdSd3ZFUjZVU3BNeWl6c0lJSXR6eDFvSERqMGRta2JrdEw1MmFr?=
 =?utf-8?B?cDNXV0swQ0tEeE43SHZyNkZtZHIrWmVqUjlvRTJRSExoRnNBSGFlYXoyUWd0?=
 =?utf-8?B?eVFFSUFMcjJla0VwSnpyb2RqVFhVWWNsekZWWloyaUVwVkZSTkFwZjlYbVVB?=
 =?utf-8?B?VHBXUXN1T1cvNHNsM3N5bU4ra01qZmM5S2pnVmpFZzF5ZlFndjlxN3lxMUxF?=
 =?utf-8?B?NVlnMGdHeUJoTncvUnFrTXVzRzkzc0J1VW1RZXpxdGFWT2s4aDhoendLdTZo?=
 =?utf-8?B?WmNtV0tFdmJKVnQ0Y1NoUm9nSHRNU1FVdUphWEJIa29pSWI2MWRleU9NMi9l?=
 =?utf-8?B?SXFZR0JocTlZMWFaeVIwYnZhK3g4bHl0dlJNVGtjQ2xGczhVNFdQNG42M2tp?=
 =?utf-8?B?M1NNaUtPcGoxOGdqYlUrRWFlM204aW9yUSt4ZGRjcjMxcWpXT3dlekRCUXdl?=
 =?utf-8?B?TDlWMUZ0WXpXUDI5V3U5SUR5NHFKQWdjT3I2WnU4Y3MvVE1GRmdUVkRQVHVH?=
 =?utf-8?B?ZllqaThBVTNCNW5OZjhQeFQ5S2dWd3JIZlVHVmUwbCtnRmF6dmcyRnBxajA1?=
 =?utf-8?B?bHV0dm52L1h0Mk44eVhaY09LeVlPRnVxUU9NWXA2dmIxQ3NWbDJsMTlEb2Nv?=
 =?utf-8?B?M1cvOS9tdGo2WTdhSUM2QytxdmJ0Tmp1S2ZZVlMycktuN3FtT0F5a0huY2ZV?=
 =?utf-8?B?Q3FpK2UxSmJ5TEVpNWZid1VyOGkxUGxLWGhla0dNNmR0QjlkVHB0Vi9UN3Na?=
 =?utf-8?B?T2VBYnd3TWRUblZhRVpHdUNtS2lZeWxiQWpMV0sveHNwK2drNnZSSGpFdHJv?=
 =?utf-8?B?ck42VzBLYWVwRll0cDFkS2VhWnBaTG5Ec0ZvcnUzNEJtV1BvNjAycU51YnAv?=
 =?utf-8?B?Ym1PV1hLNkhwUStvU1FSY2J6Wk5PTkJLZG1sZUpmWE52NnRuUXZ3WjRUWWdv?=
 =?utf-8?B?b0pydFUrTkEyWjJ0WTZVdG01SDZMdEZOV08rcXE2UE1LSGJmY3dVcXlNV3pM?=
 =?utf-8?B?M1dleFVqNk5aT0M3R3V2Y0I0dG9jRUFaT2M1UHdJc1dIQVptcGVKNWpIbXMz?=
 =?utf-8?B?MFdxak1qQ3l6L3ZaNkVoT0pmMWtYb2pRYTh3cTJ0TWZBKzFPYWRLR0FJNlF6?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <835BC24C18E84A4D80CC6E468805716A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y/KrdEtPcOcd7uYnmvs6N0LYqX0AiecKTQ/t5nXSoca93V33hx9jesIN3CI37wB/Ft9NMGoxK0nB6nVqQVjWTV/PJbRxxdfZf8Q9O67cO1HBo/HYJNvEBJ1O5RKU2g0Ypc8fq4/Z3mbI7tsNEv5T8dSX0iFmOX10LKFfBB357uT80W0+YDmObTVTn1YYmSACbZkxvgV0dKJHGh2xi0yRmrRaKpBE4ngyIP2ek3LF1ma4NnAbE37Ny5V3IYZmRQwuXyzaS8npucrG7v5V/67b9loSeigu6bbD+Oc3wH5ANBppSxSI6NZiJ56UZvBP7DircOrmXll+Dlabt/HOof5H3luPGwdXFGZgh8Yvo+M8ieLfth0SCuwO2JZ9oh5fsRKra+e6WlaWihfvWB50SwnKLy+asw4lJIMOf8lxx9WJ+1ZVYeSvYFLvwZowp4+0uJrNZ9o1eevZP/GNXrZOk7t0xSIDIzMsT64pp24VjWPBLV2Slo2IA3WBJEfQEJEyoaeQewykqDBWZVkEs420Q0HzJWAgWEkkXU24/Dg8UdGBA3EYQ1NbzhvOcWmqsD8lRnj9thwn+2k7qacXY6qBCYhZDQLToLV7/O3tRxsBdRMh0Fo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eec79b-c689-41d9-b7df-08dd0b015a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 14:24:19.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmCawQTd3qNl9WtSun6YYC4lUC09Ui/OAyagU8xCjFYkrJT77AHAiCfqsSvVRrlnOLUfcRfoJs9hJlQ8zJFVSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_06,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411220121
X-Proofpoint-ORIG-GUID: lEAosvifVr4CFmIhyq6r7r1lEU0lHU7c
X-Proofpoint-GUID: lEAosvifVr4CFmIhyq6r7r1lEU0lHU7c

DQoNCj4gT24gTm92IDIyLCAyMDI0LCBhdCAzOjQ54oCvQU0sIEFtaXIgR29sZHN0ZWluIDxhbWly
NzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBOb3YgMjEsIDIwMjQgYXQgMTA6
MzDigK9QTSBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IE9uIFRodSwgTm92IDIxLCAyMDI0IGF0IDAxOjE4OjA1UE0gLTA4MDAsIEh1Z2ggRGlja2lu
cyB3cm90ZToNCj4+PiBPbiBUaHUsIDIxIE5vdiAyMDI0LCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+Pj4+IA0KPj4+PiBJIHdpbGwgbm90ZSB0aGF0IHRtcGZzIGhhbmdzIGR1cmluZyBnZW5lcmlj
LzQ0OSBmb3IgbWUgMTAwJQ0KPj4+PiBvZiB0aGUgdGltZTsgdGhlIGZhaWx1cmUgYXBwZWFycyB1
bnJlbGF0ZWQgdG8gcmVuYW1lcy4gRG8geW91DQo+Pj4+IGtub3cgaWYgdGhlcmUgaXMgcmVndWxh
ciBDSSBiZWluZyBkb25lIGZvciB0bXBmcz8gSSdtIHBsYW5uaW5nDQo+Pj4+IHRvIGFkZCBpdCB0
byBteSBuaWdodGx5IHRlc3QgcmlnIG9uY2UgSSdtIGRvbmUgaGVyZS4NCj4+PiANCj4+PiBGb3Ig
bWUgZ2VuZXJpYy80NDkgZGlkIG5vdCBoYW5nLCBqdXN0IHRvb2sgYSBsb25nIHRpbWUgdG8gZGlz
Y292ZXINCj4+PiBzb21ldGhpbmcgdW5pbnRlcmVzdGluZyBhbmQgZXZlbnR1YWxseSBkZWNsYXJl
ICJub3QgcnVuIi4gIFRvb2sNCj4+PiAxNCBtaW51dGVzIHNpeCB5ZWFycyBhZ28sIHdoZW4gSSBn
YXZlIHVwIG9uIGl0IGFuZCBzaG9ydC1jaXJjdWl0ZWQNCj4+PiB0aGUgIm5vdCBydW4iIHdpdGgg
dGhlIHBhdGNoIGJlbG93Lg0KPj4+IA0KPj4+IChJIGNhcnJ5IGFib3V0IHR3ZW50eSBwYXRjaGVz
IGZvciBteSBvd24gdG1wZnMgZnN0ZXN0cyB0ZXN0aW5nOyBidXQNCj4+PiBtYW55IG9mIHRob3Nl
IGFyZSBqdXN0IGZvciBhbmNpZW50IDMyLWJpdCBlbnZpcm9ubWVudCwgb3IgdG8gc3VpdCB0aGUN
Cj4+PiAiaHVnZT1hbHdheXMiIG9wdGlvbi4gSSBuZXZlciBoYXZlIGVub3VnaCB0aW1lL3ByaW9y
aXR5IHRvIHJldmlldyBhbmQNCj4+PiBwb3N0IHRoZW0sIGJ1dCBjYW4gc2VuZCB5b3UgYSB0YXJi
YWxsIGlmIHRoZXkgbWlnaHQgb2YgdXNlIHRvIHlvdS4pDQo+Pj4gDQo+Pj4gZ2VuZXJpYy80NDkg
aXMgb25lIG9mIHRob3NlIHRlc3RzIHdoaWNoIGV4cGVjdHMgbWV0YWRhdGEgdG8gb2NjdXB5DQo+
Pj4gc3BhY2UgaW5zaWRlIHRoZSAiZGlzayIsIGluIGEgd2F5IHdoaWNoIGl0IGRvZXMgbm90IG9u
IHRtcGZzIChhbmQgYQ0KPj4+IHF1aWNrIGdsYW5jZSBhdCBpdHMgaGlzdG9yeSBzdWdnZXN0cyBi
dHJmcyBhbHNvIGhhZCBpc3N1ZXMgd2l0aCBpdCkuDQo+Pj4gDQo+Pj4gW1BBVENIXSBnZW5lcmlj
LzQ0OTogbm90IHJ1biBvbiB0bXBmcyBlYXJsaWVyDQo+Pj4gDQo+Pj4gRG8gbm90IHdhc3RlIDE0
IG1pbnV0ZXMgdG8gZGlzY292ZXIgdGhhdCB0bXBmcyBzdWNjZWVkcyBpbg0KPj4+IHNldHRpbmcg
YWNscyBkZXNwaXRlIHJ1bm5pbmcgb3V0IG9mIHNwYWNlIGZvciB1c2VyIGF0dHJzLg0KPj4+IA0K
Pj4+IFNpZ25lZC1vZmYtYnk6IEh1Z2ggRGlja2lucyA8aHVnaGRAZ29vZ2xlLmNvbT4NCj4+PiAt
LS0NCj4+PiB0ZXN0cy9nZW5lcmljLzQ0OSB8IDUgKysrKysNCj4+PiAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNDQ5
IGIvdGVzdHMvZ2VuZXJpYy80NDkNCj4+PiBpbmRleCA5Y2Y4MTRhZC4uYTUyYTk5MmIgMTAwNzU1
DQo+Pj4gLS0tIGEvdGVzdHMvZ2VuZXJpYy80NDkNCj4+PiArKysgYi90ZXN0cy9nZW5lcmljLzQ0
OQ0KPj4+IEBAIC0yMiw2ICsyMiwxMSBAQCBfcmVxdWlyZV90ZXN0DQo+Pj4gX3JlcXVpcmVfYWNs
cw0KPj4+IF9yZXF1aXJlX2F0dHJzIHRydXN0ZWQNCj4+PiANCj4+PiAraWYgWyAiJEZTVFlQIiA9
ICJ0bXBmcyIgXTsgdGhlbg0KPj4+ICsgICAgICMgRG8gbm90IHdhc3RlIDE0IG1pbnV0ZXMgdG8g
ZGlzY292ZXIgdGhpczoNCj4+PiArICAgICBfbm90cnVuICIkRlNUWVAgc3VjY2VlZHMgaW4gc2V0
dGluZyBhY2xzIGRlc3BpdGUgcnVubmluZyBvdXQgb2Ygc3BhY2UgZm9yIHVzZXIgYXR0cnMiDQo+
Pj4gK2ZpDQo+Pj4gKw0KPj4+IF9zY3JhdGNoX21rZnNfc2l6ZWQgJCgoMjU2ICogMTAyNCAqIDEw
MjQpKSA+PiAkc2VxcmVzLmZ1bGwgMj4mMQ0KPj4+IF9zY3JhdGNoX21vdW50IHx8IF9mYWlsICJt
b3VudCBmYWlsZWQiDQo+Pj4gDQo+Pj4gLS0NCj4+PiAyLjM1LjMNCj4+IA0KPj4gTXkgYXBwcm9h
Y2ggKHVudGlsIEkgY291bGQgbG9vayBpbnRvIHRoZSBmYWlsdXJlIG1vcmUpIGhhcyBiZWVuDQo+
PiBzaW1pbGFyOg0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvZ2VuZXJpYy80NDkgYi90ZXN0
cy9nZW5lcmljLzQ0OQ0KPj4gaW5kZXggOWNmODE0YWQzMjZjLi44MzA3YTQzY2U4N2YgMTAwNzU1
DQo+PiAtLS0gYS90ZXN0cy9nZW5lcmljLzQ0OQ0KPj4gKysrIGIvdGVzdHMvZ2VuZXJpYy80NDkN
Cj4+IEBAIC0yMSw2ICsyMSw3IEBAIF9yZXF1aXJlX3NjcmF0Y2gNCj4+IF9yZXF1aXJlX3Rlc3QN
Cj4+IF9yZXF1aXJlX2FjbHMNCj4+IF9yZXF1aXJlX2F0dHJzIHRydXN0ZWQNCj4+ICtfc3VwcG9y
dGVkX2ZzIF5uZnMgXm92ZXJsYXkgXnRtcGZzDQo+PiANCj4gDQo+IG5mcyBhbmQgb3ZlcmxheSBh
cmUgX25vdHJ1biBiZWNhdXNlIHRoZXkgZG8gbm90IHN1cHBvcnQgX3NjcmF0Y2hfbWtmc19zaXpl
ZA0KPiANCj4+IF9zY3JhdGNoX21rZnNfc2l6ZWQgJCgoMjU2ICogMTAyNCAqIDEwMjQpKSA+PiAk
c2VxcmVzLmZ1bGwgMj4mMQ0KPj4gX3NjcmF0Y2hfbW91bnQgfHwgX2ZhaWwgIm1vdW50IGZhaWxl
ZCINCj4+IA0KPj4gDQo+PiBJIHN0b2xlIGl0IGZyb20gc29tZXdoZXJlIGVsc2UsIHNvIGl0J3Mg
bm90IHRtcGZzLXNwZWNpZmljLg0KPiANCj4gSSB0aGluayBvcHQtb3V0IGZvciBhIGNlcnRhaW4g
ZnMgbWFrZXMgc2Vuc2UgaW4gc29tZSB0ZXN0cywgYnV0IGl0IGlzDQo+IHByZWZlcmVkIHRvIGRl
c2NyaWJlIHRoZSByZXF1aXJlbWVudCB0aGF0IGlzIGJlaGluZCB0aGUgb3B0LW91dC4NCj4gDQo+
IEZvciBleGFtcGxlLCB5b3UgdGhvdWdodCB0aGF0IG5mcyxvdmVybGF5LHRtcGZzIHNob3VsZCBh
bGwgb3B0LW91dA0KPiBmcm9tIHRoaXMgdGVzdC4gV2h5PyBXaGljaCBwcm9wZXJ0eSBkbyB0aGV5
IHNoYXJlIGluIGNvbW1vbiBhbmQNCj4gaG93IGNhbiBpdCBiZSBkZXNjcmliZWQgaW4gYSBnZW5l
cmljIHdheT8NCj4gDQo+IEkgYW0gbm90IHRhbGtpbmcgYWJvdXQgYSBwcm9wZXJ0eSB0aGF0IGNh
biBiZSBjaGVja2VkLg0KPiBTb21ldGltZXMgd2UgbmVlZCB0byBtYWtlIGdyb3VwcyBvZiBmaWxl
c3lzdGVtcyB0aGF0IHNoYXJlIGEgY29tbW9uDQo+IHByb3BlcnR5IHRoYXQgY2Fubm90IGJlIHRl
c3RlZCwgdG8gYmV0dGVyIGV4cHJlc3MgdGhlIHJlcXVpcmVtZW50cy4NCj4gDQo+IF9mc3R5cF9o
YXNfbm9uX2RlZmF1bHRfc2Vla19kYXRhX2hvbGUoKSBpcyB0aGUgb25seSBleGFtcGxlIHRoYXQN
Cj4gY29tZXMgdG8gbWluZCBidXQgdGhlcmUgY291bGQgYmUgb3RoZXJzLg0KDQpBZGRpbmcgYSBy
YXRpb25hbGUgaXMgc2Vuc2libGUuIEkgZG9uJ3QgaGF2ZSBvbmUsIGJ1dA0KaGVyZSBpcyB0aGUg
bGltaXQgb2YgbXkgdGhpbmtpbmc6DQoNCiJebmZzIiBpcyBpbiB0aGlzIG1peCBiZWNhdXNlIEkg
dGVzdCBORlNEIHdpdGggYSB0bXBmcw0KZXhwb3J0IHNlbWktcmVndWxhcmx5LCBhbmQgaXQgc3Vm
ZmVycyBmcm9tIHRoZSBzYW1lDQpwcm9ibGVtLg0KDQoiXm92ZXJsYXkiIGRvZXNuJ3QgaGF2ZSBh
bnkgcmVhc29uIHRvIGJlIGhlcmUgZXhjZXB0DQp0aGF0IGl0IHdhcyBwYXJ0IG9mIHRoZSBsaW5l
IEkgc3RvbGUgZnJvbSBlbHNld2hlcmUuDQoNCkJ1dCB0aGUgdG9wLWxldmVsIHF1ZXN0aW9uIGlz
ICJkb2VzIGl0IG1ha2Ugc2Vuc2UgdG8NCmV4Y2x1ZGUgdG1wZnMgZnJvbSBnZW5lcmljLzQ0OSwg
b3IgaXMgdGhlcmUgc29tZXRoaW5nDQp0aGF0IHNob3VsZCBiZSBmaXhlZCB0byBtYWtlIGl0IHBh
c3MgcXVpY2tseT8iDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

