Return-Path: <linux-fsdevel+bounces-29264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA699775B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CD7284637
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F71C2DD5;
	Thu, 12 Sep 2024 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ckt2oNX7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ruJlumkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15F192D89;
	Thu, 12 Sep 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726184563; cv=fail; b=c2RHacXl3UvTHAUzW3rvkCFhtHQRdDkVBFlTNVZsqlQNVInvEP2b9Yh+Zu1EBVpl3Aao1UoICLyYt5nglr8aG0TkKEKQxdq7C7ND9W2ouNI/WyYS+8Dk+/g/U0lRfoGcZ0Kv3eGVlqVRQZgdZhljfACt+XN+mpkot5mnF+GMb8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726184563; c=relaxed/simple;
	bh=Jo2j+7DEkQAdPM2cxl4blC4oICm0xgeK4y45XNXRGbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DlgcksVfIpaX8eITb9e6MR3ePnw7a9wj8vhq+p2KEw5s1dZtqlJbA8lhLy7s/do3DAXHcwaEz7HlODoCnV8BuSzz7thc95eVbznvuo544c7X/K96ZQsFSf+I6B3KVDwN16jMQ8A2xva72p/ldKKX1xFvg5h0DAh7P4fxb0Nmjbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ckt2oNX7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ruJlumkd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMC8L0028124;
	Thu, 12 Sep 2024 23:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Jo2j+7DEkQAdPM2cxl4blC4oICm0xgeK4y45XNXRG
	bs=; b=Ckt2oNX7L8o1/vpZc7wkqmOH9ZXTw+3fSiGqCX4Jbf4DUfjmsH1BceA/n
	ENWvmNWj15BbJP4LsXZf58c9IKrdunliOxM4nfteozr3Wx7/XY+TJK++QlLloIrd
	m7hiD34NrSf8XxWsAvn27D+TmTH/BbHUe+64+vXn76qRvz9L/dcrCnpq1lrqsxpu
	6tTMDN2b7dDMhruJUrwnGUgA5v3BYuylcWZTYevd7nFbfxCJiNkMtiOtTfoJ83vw
	tlspcQBFBC81nReNNxukDtJwpPg/pCuEgCq7+yPiPbj21agtPLd2Z5CtE9lhWpyw
	OTXcGNueTIO/hvvVAFGV2opeVC7cA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2v7d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 23:42:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMsftW032402;
	Thu, 12 Sep 2024 23:42:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9j94gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 23:42:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ihzbm63i89JWNSPmZjCedI38BSVXZIEhgQGXea3O4Pu/E5/7x3WNhD9aEh06QfouMsJ7B143qNOYw17GEXSqZr3Z7o0TbWJxUCPLHQqgAR0esRtV+FipWz/He1g6gV1D5b3bCYuDoLpYxlEpBl+wqGqMn4cZ7PB3Uq+p19FHmOvWAA4qUKPyNA5vtmR/ELCSU3UaVaJJO/MxaEfX/JWp095v+NDfU20YEFXyCVq57wJNvAuAE1s67ihT3LWYarGfM2pD2jZZcyTguoBkzfuwGQejqKKbaqcUzaxrV0YCthQgw0ZdS0ZqFvI0q7URS8ZN45afEx2reJ29Krz0XPgO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo2j+7DEkQAdPM2cxl4blC4oICm0xgeK4y45XNXRGbs=;
 b=EzUCmWeKyKDwNtPFRmWzmO0C7uTgyCcRZJlTusrIr64hEN6mI/rcgrRSQF88dFJ66fqSIdMDlnIO4qEDFstVmDf1NHGt86f6j11iAdbIfilvsVPPiI3s5jYUf7WOdUK3j5Lnn6cQnCfur6hhd7tKzJZKw0Wwjx1WaiHuj5qeUgnPkKTSwd5lh9bsxjxPElnPDh0eVc07qnNfR3weRciBGxg4LLZzYSTcgKYA3UsfTclAi4hJmmDEXxuT8AjwcucnDkYWgTozt3OvQMgHYo5CKiqMUtCa4oIlTV/s3ovQSV6qbimBqEOeAcy0jD/j/+3eglRZZCVdFM6CjQ4biPxFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo2j+7DEkQAdPM2cxl4blC4oICm0xgeK4y45XNXRGbs=;
 b=ruJlumkdiM4VKarY44A6JYe1oOZHU4DsoN7Ay/2Kj24R1YreDRpmQts2iOfReyd+9y577vN/2k2fV5QhPDtXGmPpmpjMa0L0o278AoizenigaXBSiomHQA1n8SXPt1IswvKh1jIJesRm3/SFETZ1jjCHQlvYXvxogvKIU3QVzwY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Thu, 12 Sep
 2024 23:42:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.003; Thu, 12 Sep 2024
 23:42:29 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>, Anna Schumaker <anna.schumaker@oracle.com>,
        Mike Snitzer <snitzer@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Thread-Topic: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Thread-Index: AQHa+/Z3Mom0zo7SI0muKVdY2xT3QLJLLt+AgAaglICAAQC8AIACD6cAgAADCwA=
Date: Thu, 12 Sep 2024 23:42:28 +0000
Message-ID: <2A6AA1A5-9498-4783-A23C-C25500AB6D88@oracle.com>
References: <A8A5876A-4C8A-4630-AED3-7AED4FF121AB@oracle.com>
 <172618388461.17050.3025025482727199332@noble.neil.brown.name>
In-Reply-To: <172618388461.17050.3025025482727199332@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5982:EE_
x-ms-office365-filtering-correlation-id: ad567540-a656-4b12-2be9-08dcd384904b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkRPM2FQZzRFekpTV2t0YkpITVdhMnFZdldqbjJxZWRnb1lSditHWTkxSEk5?=
 =?utf-8?B?WDRrWDdrcEpIUU1PYzdBVHhYc1FGZThva3pnSXJycTVGNmpQRDI0MHNoMGtq?=
 =?utf-8?B?emZLTllNU3ZWaEJ5a0pzTkxjOGZ6K1g1YUVqYkdnYXEwWVROaWYwekl6Z3ls?=
 =?utf-8?B?Mjl2cTVPRlp2TjFzY3JNdHg1MTRVajlGWUgwT2o4MXp4b0E0VXF4bkFDUWV3?=
 =?utf-8?B?Qkx5UDZJSmFBQXlxME1FK0FiT3g4T0FlQUxlbnpVZjN0aGJ5VHBjcXlCMkll?=
 =?utf-8?B?alZBS0JMNVpndnE4SnpvNTZrRDVacEI0WmE0cTdmamlkSlNJdmI5QnVRbmN2?=
 =?utf-8?B?QmErZDR0TSs1anJzWE9LbEhuNXBDNmQ2bk1yK3JuRTlHUUJsYU44QmtKamVh?=
 =?utf-8?B?OStBdG5pOVplZzh5N0g2MEVSVVBjSXRxUEw0VTBtZmV6bnhCTVVEQ3ZZSm1B?=
 =?utf-8?B?b1l3aUlTRnFmclAwU0ZQT29MU3k2bWx0WUpwMU1FQkVoWTY3SHBsUitpOHBl?=
 =?utf-8?B?eG5BZlFFMy9hemM4R1BzWHJCd0dVVHpnM1NLWGdFNnJNVXJ4Y0pVMWJ4Z1BD?=
 =?utf-8?B?Y21FOHhoT25NQWZEOE1OMjl0a29OOG1IQ09NSlNTRjg2TjJRRjhoRnNnR1RL?=
 =?utf-8?B?aW5rZGlZMG0xN1BWaU1GWkdBcHI4Rmdyb1pXN1l1Uy9KK2hVLzMyRkNBbDdq?=
 =?utf-8?B?M1NpalF5ZmRTY2t2LzN5NVVhWjBCTnIzZU8rdEdNRnRIUDFsRUdKT3BRbE9O?=
 =?utf-8?B?V3E2QmJtUWhjYTB6WVQwU3pSdTZyOHNRM2V0MWdLcmkzRXJmZ2xrYmRSSkoy?=
 =?utf-8?B?NzdYaUs0SGNuZG1JenIwOURMNWlpa1VCelphYkNMeEJZYWljWHdYUFdxb2NN?=
 =?utf-8?B?YjA0TjNhTmlnWkNhRW5XdHNBUklTU0RhSkhHeUtxRlZDTzJtZWlFaHRMc1J2?=
 =?utf-8?B?NHIvWGNiK0l0WWpTY2FsckNMcXRTNnZaOW1RQmxEbFdnTXlIOTJuNTNPY0Z5?=
 =?utf-8?B?akozdEQrTnYyL0ViYVlxeUlwMnFhU1F4K1BhblRwOTF5OHYrMXVMNTV0aWhJ?=
 =?utf-8?B?NHlXeXkvSFA3aEFnZysrSkdSZXdjMllmSUt0Mnd0M0Nmc3NoeUpwcUtheTFC?=
 =?utf-8?B?UzA3RVlDL1lTV2xpdGRud2h1dmlhOUdzR2xzU2FaSTdLazNrYnFWenhLcURl?=
 =?utf-8?B?ZHdvR2VCQjk0Um1yWDRWRExnL1dnUnY4MXREZEZqSm5UNUE1QzlxdFJQOC9K?=
 =?utf-8?B?NzZuV3lqZHkvMGx2Sm9wUHd1YkhYN2FvUGlMQnNNL20yTXF4d0dmUU5Wb2ow?=
 =?utf-8?B?cGllNXRBY0hEVkJweGZnb3ZPdm1HU2F6R1dxcU8zbFR4L0tZWW5GQjRDRXRV?=
 =?utf-8?B?OVZ3aWNLZkJxZW9ZMk5yazZoUzF2UWt0NTlOU05pWUNhMWliR1F1Y09BS0VI?=
 =?utf-8?B?ektzVFd3NHk0ZlpjYmtacnVqR3h1OFhKa2pUMHFSZTNZc2JwYVNFY3RQOWxm?=
 =?utf-8?B?UkNUU1g3Si9nbjFrR2oxb2c4M0E1SndqRlJCVzVLMlBwRUxISnNFeDJ3ZXdo?=
 =?utf-8?B?Kzc1Q0lWKzZxZm82Zk9nYWE1SkpURFdJY2tCenozN05oendEQStQMUdqRDRm?=
 =?utf-8?B?L0xPVjBKaUF6dHhSOUJCSlh5RFRScDh5RVVvNUlDdmRIeTZRMFdnZlAySXRu?=
 =?utf-8?B?TmVjR2hPSHVud2NieXpSUlp5aFVIVWNJOW1SNTM1VTBLZnp6TnlvMkc1eDVj?=
 =?utf-8?B?Mi9UNUJidFh6SDBib0F6ZUNYaDVFNEE5RjRFUVJMS0tENzhhSDhpWFo4cjM1?=
 =?utf-8?B?YXdPTXJQQXNOTS9sbnlzZjhKOXZiQzg0OW5KWlpuc0tGUGxvQjJMK0hrS0dm?=
 =?utf-8?B?anpFSEJvazJjejlMU1NrWmFRbEVReE51QjZyZjYxc1E1Mmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXZReEVDa1BsaCs2emRBYmtLNTJZMzBudkpuenBPM29sRE5sU01DWGdlY1p5?=
 =?utf-8?B?bVp0Sk1zUndBQWNocjE1cWI3Z2w5N1dGWThuSDlhYm5jWG9MYmdSMy8yQkdt?=
 =?utf-8?B?NUswSVRVaG5RbURvb1hrYkF4eE92bXgxWEhBc3BKOTkvRHcrdDdKVFNZbkZD?=
 =?utf-8?B?TGJyV0RGRm8zb1pLNHlaWlZRYWwrbDdQLy9HTndwRlA2Rm0yWE93SDk3QnVx?=
 =?utf-8?B?OTJVMURyUzUxRldwaXVSYWQyU3RkdnJDUHZvL2F3TW5wUzE5ajVqaFl4RVpQ?=
 =?utf-8?B?UDZOazBQdDlkRmI3bmZpbWtzTWpxNldTeTNwWDBTakZRYzFPblU2b1laMjVi?=
 =?utf-8?B?eDI4Y0VXSWVGMm1vR3NhRE1sS1drYzFBNGFYUzlDM2tETGZLVExCU0dvUEww?=
 =?utf-8?B?QlNzeHpTY1hHZDcwU0R6ZHlQVE1oZ0tHeFZPKzZKcUZZREloQU84VHh5Rmdq?=
 =?utf-8?B?SzlNbURHVGtjck1XUHZXYjBrS1FtRDB0OVp1cDhpZzM4KzdlVnpiclNrV3lN?=
 =?utf-8?B?eUUxM1RkMzN5aWRCS1lNc2dwMHd6WEVTbGg3OUQxNUJSWXdNUmxGaUlrY3B5?=
 =?utf-8?B?ZGVzYVlyb3Q1aFRTSFN4SWNXREpXRFFxd2YxQ2ttVUU4bUZPeUljMWVZL3FO?=
 =?utf-8?B?WXdLNHpkSEVXcFRMRmxHUnVxUkpzYVIxT2RuZFNocGZCMTdFaFYyd1M1Y1N1?=
 =?utf-8?B?SEFIcjJ4T2JuY2dNTkxETFNMcGdQQS8rZjZwZldKUGZzRFJUNmxqblpzdGNs?=
 =?utf-8?B?b3ozVy9WaUZYRWlUSzFwaWNwc2dWRHZzMUlFUjB6NEcwSjFjRktVMTkxSHIz?=
 =?utf-8?B?R1JVcUZsV0pyRHc1Uk1KQURjcnRmMWJ3bm9sVFdyOFV0cGJscy9CZWNsUStE?=
 =?utf-8?B?OEg3V0xUWnJqRTUyVGpSN01hRFZhVExMS3huYjJpRUtmKzBtaE91ZUF5NThu?=
 =?utf-8?B?VkhGbGdHN0E3eTBla054OVZ0TU04ZENzR3FYb1Z0U2g3akJiNllXQmRxNGth?=
 =?utf-8?B?VW1qQlF2eWNhbjJTM05kU0NZZ1E5ai9VeDlnYTl1d2Y1ZmZ0ZGFVdkM3M3pt?=
 =?utf-8?B?UTZJUC9VN1dxazJjVU1CUDVDdkxocTlNY1oyTUoxS1pXcTJaSG9VcEhXN1Vh?=
 =?utf-8?B?WlVZL0Q0Y2pEcm9QMHorN0M5TVBrQjdnalkwTGtvYk1nT1l0OHd4cTA5enA0?=
 =?utf-8?B?emJ0cGUxcHpzM014Z1c0eVNCU3ZGd0lOR203eHFCb0NpbFJSOEJjaVRORVVN?=
 =?utf-8?B?TExRWWdFWmJ1K2lUbVNEUk5wY0RiQkYxZlhTSkIyVURGMmhHOVB1L3NZSlAy?=
 =?utf-8?B?bDY4R2dXVWlzYWtGczR1UzR5bmo3NFZZbmg3RVdvT0Y1clFsRy9Wb0hYTTl0?=
 =?utf-8?B?Q2k1c1lWZ29wZHdkWnhoTk9NSDAzMjR6WngrTm10SWlWNmpxZFNDV0lzKzJC?=
 =?utf-8?B?RGVQVE8yNDFSZU9nekFQU2dzalVaOUVVek84YmI2djFnV3hUZDFCRVNxVitQ?=
 =?utf-8?B?eW9PL1l5aVBuTFp3MndFcjVUQ3BVTnNIOUJPRS96SFBxLzJPQThmT2hxQXA2?=
 =?utf-8?B?anVvcU9hMUZtNFR4ZkswUHRBbWVJekg2eUtOc3gydWJrUTladGlMclIwdlIw?=
 =?utf-8?B?WlowVkhlNzRHSVdneTZWQ2l3KytkYzhGOVhBQmdOeW90UFV3V3Q5OTVDaVJV?=
 =?utf-8?B?NURKa0o5K1YyTTFxekpFeGVPMElRMWY1cWdYU29tSmFiZGREZUVaNnd0Mm5t?=
 =?utf-8?B?eW1FbmdPWURFb1BRNGpVRWlCWnpiVDJIQVc4V2FDV3ZZamd6ZGUxL3pYMVZG?=
 =?utf-8?B?ZmdLeEVRQkZGdjIzYXcyaUd5WGc5TW5XNWJGZXRBS0lnN1JaMlV0MHVQUFdM?=
 =?utf-8?B?My94VTBaWW1MZVZDSkdSUlc3d0VTZGhYUlA2UXprWkRpTzBuNHY1M1JDTWVS?=
 =?utf-8?B?ZVZGQktYa3o1blZVQkhvRlV4aDdmZ1oyZ3puMDFaSGdRZ1hjemFoZDVxQVY5?=
 =?utf-8?B?NzJaczAzSXRVQlFCUWFINFhDR2g4czZ0OWJacmxpRmtubnd0QzNzd21LOTA2?=
 =?utf-8?B?TzkxZnNUZ3k2aFRBUENSQU1GNll6RXprSmhvYWFPUTBIU0N1bE5oMG4rWnNV?=
 =?utf-8?B?VTdqQlJ5N0hGUWZobnFiSjNudHA5UHBYWWh4VU1nYjNtV0NPTi95djhGWERt?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFBF0DA42B6BC04C92024E9330F44EFB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SI2NJlkA7aRAICGcMjv+RO97/pxNuBFYE8uAXUO1X/cPoyzAFo/oR1DwGrKjU59nu+c2lRnqUkdmtqtaXqCw5go6hiEe9Utjd+UAG3WpOzmKMjGQMVcuEyQUqdXJCl0oMYaPqJ7yTXJbiPnTNIz4EZm7zvwpmXkYtWrCYyrEj3/XcZBG8ozggVnPVr4hCUd3UbbdIxbll+uxjbilm3np5+xexiMSi/zBrjP6IVcTRPTvgNgarZ11GBvboI7u4gVZC3mV0Yj06RHQfV7HKur9bA7r2ll453aoqsXKT6LIBEDOLC7BqUEqPAdR4Fj558939hrir5QCdbVb3gpHDCPbdSLzCjgRGD6W8fIQBBeKBST/rLaUAWAnKyyIYasmN7k1F+L1dptCMrbZZKTsO+vKk5Gdz8K9A2g25nN7rNgeTgitjWF50CgDX2yVk+VIE4U9wVt6ZChf8zgiKl0/VJlx31j5DVnwIoqWf42yrXOr1jkCRwd0hboTFkVBT6tVQh+wYLsVKnVSVOdDA0SzTzuGZyE1XZRFU+Y3TV2VFuH45tx2+VVm3BsLWoI3itT4cu5oSHNz5NXnJ+lG+2ZADoVRqbbcRTQKxI/JKinvehkRph0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad567540-a656-4b12-2be9-08dcd384904b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 23:42:28.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elzirGTJeBXyFGlICPEl3c0n2p8sERIbDOFxoE88J++E8ZPaIsdKDqVp/u+EzVqWqtIHuTMnpQoGerq4f8Qjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_09,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120170
X-Proofpoint-GUID: yZJW5jkDq7t8BlV5DKFjCHi63E7Pb8lo
X-Proofpoint-ORIG-GUID: yZJW5jkDq7t8BlV5DKFjCHi63E7Pb8lo

DQoNCj4gT24gU2VwIDEyLCAyMDI0LCBhdCA3OjMx4oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDEyIFNlcCAyMDI0LCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIFNlcCAxMCwgMjAyNCwgYXQgODo0M+KAr1BNLCBOZWls
QnJvd24gPG5laWxiQHN1c2UuZGU+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFNhdCwgMDcgU2VwIDIw
MjQsIEFubmEgU2NodW1ha2VyIHdyb3RlOg0KPj4+PiBIaSBNaWtlLA0KPj4+PiANCj4+Pj4gT24g
OC8zMS8yNCA2OjM3IFBNLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+Pj4+PiBIaSwNCj4+Pj4+IA0K
Pj4+Pj4gSGFwcHkgTGFib3IgRGF5IHdlZWtlbmQgKFVTIGhvbGlkYXkgb24gTW9uZGF5KSEgIFNl
ZW1zIGFwcm9wb3MgdG8gc2VuZA0KPj4+Pj4gd2hhdCBJIGhvcGUgdGhlIGZpbmFsIExPQ0FMSU8g
cGF0Y2hzZXQgdGhpcyB3ZWVrZW5kOiBpdHMgbXkgYmlydGhkYXkNCj4+Pj4+IHRoaXMgY29taW5n
IFR1ZXNkYXksIHNvIF9pZl8gTE9DQUxJTyB3ZXJlIHRvIGdldCBtZXJnZWQgZm9yIDYuMTINCj4+
Pj4+IGluY2x1c2lvbiBzb21ldGltZSBuZXh0IHdlZWs6IGJlc3QgYi1kYXkgZ2lmdCBpbiBhIHdo
aWxlISA7KQ0KPj4+Pj4gDQo+Pj4+PiBBbnl3YXksIEkndmUgYmVlbiBidXN5IGluY29ycG9yYXRp
bmcgYWxsIHRoZSByZXZpZXcgZmVlZGJhY2sgZnJvbSB2MTQNCj4+Pj4+IF9hbmRfIHdvcmtpbmcg
Y2xvc2VseSB3aXRoIE5laWxCcm93biB0byBhZGRyZXNzIHNvbWUgbGluZ2VyaW5nIG5ldC1ucw0K
Pj4+Pj4gcmVmY291bnRpbmcgYW5kIG5mc2QgbW9kdWxlcyByZWZjb3VudGluZyBpc3N1ZXMsIGFu
ZCBtb3JlIChDaG5hZ2Vsb2cNCj4+Pj4+IGJlbG93KToNCj4+Pj4+IA0KPj4+PiANCj4+Pj4gSSd2
ZSBiZWVuIHJ1bm5pbmcgdGVzdHMgb24gbG9jYWxpbyB0aGlzIGFmdGVybm9vbiBhZnRlciBmaW5p
c2hpbmcgdXAgZ29pbmcgdGhyb3VnaCB2MTUgb2YgdGhlIHBhdGNoZXMgKEkgd2FzIG1vc3Qgb2Yg
dGhlIHdheSB0aHJvdWdoIHdoZW4geW91IHBvc3RlZCB2MTYsIHNvIEkgaGF2ZW4ndCB1cGRhdGVk
IHlldCEpLiBDdGhvbiB0ZXN0cyBwYXNzZWQgb24gYWxsIE5GUyB2ZXJzaW9ucywgYW5kIHhmc3Rl
c3RzIHBhc3NlZCBvbiBORlMgdjQueC4gSG93ZXZlciwgSSBzYXcgdGhpcyBjcmFzaCBmcm9tIHhm
c3Rlc3RzIHdpdGggTkZTIHYzOg0KPj4+PiANCj4+Pj4gWyAxNTAyLjQ0MDg5Nl0gcnVuIGZzdGVz
dHMgZ2VuZXJpYy82MzMgYXQgMjAyNC0wOS0wNiAxNDowNDoxNw0KPj4+PiBbIDE1MDIuNjk0MzU2
XSBwcm9jZXNzICd2ZnN0ZXN0JyBsYXVuY2hlZCAnL2Rldi9mZC80L2ZpbGUxJyB3aXRoIE5VTEwg
YXJndjogZW1wdHkgc3RyaW5nIGFkZGVkDQo+Pj4+IFsgMTUwMi42OTk1MTRdIE9vcHM6IGdlbmVy
YWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVzcyAw
eDZjNjE2ZTY5NjY1ZjYxNDA6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQ0KPj4+PiBbIDE1
MDIuNzAwOTcwXSBDUFU6IDMgVUlEOiAwIFBJRDogNTEzIENvbW06IG5mc2QgTm90IHRhaW50ZWQg
Ni4xMS4wLXJjNi1nMGM3OWE0OGNkNjRkLWRpcnR5KyAjNDIzMjMgNzBkNDE2NzNlNmNiZjhlMzQz
N2ViMjI3ZTBhOWMzYzQ2ZWQzYjI4OQ0KPj4+PiBbIDE1MDIuNzAyNTA2XSBIYXJkd2FyZSBuYW1l
OiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyB1bmtub3duIDIvMi8y
MDIyDQo+Pj4+IFsgMTUwMi43MDM1OTNdIFJJUDogMDAxMDpuZnNkX2NhY2hlX2xvb2t1cCsweDJi
My8weDg0MCBbbmZzZF0NCj4+Pj4gWyAxNTAyLjcwNDQ3NF0gQ29kZTogOGQgYmIgMzAgMDIgMDAg
MDAgYmIgMDEgMDAgMDAgMDAgZWIgMTIgNDkgOGQgNDYgMTAgNDggOGIgMDggZmYgYzMgNDggODUg
YzkgMGYgODQgOWMgMDAgMDAgMDAgNDkgODkgY2UgNGMgOGQgNjEgYzggNDEgOGIgNDUgMDAgPDNi
PiA0MSBjOCA3NSAxZiA0MSA4YiA0NSAwNCA0MSAzYiA0NiBjYyA3NCAxNSA4YiAxNSAyYyBjNiBi
OCBmMiBiZQ0KPj4+PiBbIDE1MDIuNzA2OTMxXSBSU1A6IDAwMTg6ZmZmZmMyN2FjMGEyZmQxOCBF
RkxBR1M6IDAwMDEwMjA2DQo+Pj4+IFsgMTUwMi43MDc1NDddIFJBWDogMDAwMDAwMDBiOTU2OTFm
NyBSQlg6IDAwMDAwMDAwMDAwMDAwMDIgUkNYOiA2YzYxNmU2OTY2NWY2MTc4DQo+Pj4gDQo+Pj4g
VGhpcyBkb2Vzbid0IGxvb2sgbGlrZSBjb2RlIGFueXdoZXJlIG5lYXIgdGhlIGNoYW5nZXMgdGhh
dCBMT0NBTElPDQo+Pj4gbWFrZXMuDQo+Pj4gDQo+Pj4gSSBkdWcgYXJvdW5kIGFuZCB0aGUgZmF1
bHRpbmcgaW5zdHJ1Y3Rpb24gaXMgDQo+Pj4gIGNtcCAgICAtMHgzOCglcmN4KSwlZWF4IA0KPj4+
IA0KPj4+IFRoZSAtMHgzOCBwb2ludHMgdG8gbmZzZF9jYWNoZV9pbnNlcnQoKS4gIC0weDM4IGlz
IHRoZSBpbmRleCBiYWNrDQo+Pj4gZnJvbSB0aGUgcmJub2RlIHBvaW50ZXIgdG8gY19rZXkua194
aWQuICBTbyB0aGUgcmJ0cmVlIGlzIGNvcnJ1cHQuDQo+Pj4gJXJjeCBpcyA2YzYxNmU2OTY2NWY2
MTc4IHdoaWNoIGlzICJ4YV9maW5hbCIuICBTbyB0aGF0IHJidHJlZSBub2RlIGhhcw0KPj4+IGJl
ZW4gb3Zlci13cml0dGVuIG9yIGZyZWVkIGFuZCByZS11c2VkLg0KPj4+IA0KPj4+IEl0IGxvb2tz
IGxpa2UNCj4+PiANCj4+PiBDb21taXQgYWRkMTUxMWMzODE2ICgiTkZTRDogU3RyZWFtbGluZSB0
aGUgcmFyZSAiZm91bmQiIGNhc2UiKQ0KPj4+IA0KPj4+IG1vdmVkIGEgY2FsbCB0byBuZnNkX3Jl
cGx5X2NhY2hlX2ZyZWVfbG9ja2VkKCkgdGhhdCB3YXMgaW5zaWRlIGEgcmVnaW9uDQo+Pj4gbG9j
a2VkIHdpdGggLT5jYWNoZV9sb2NrIG91dCBvZiB0aGF0IHJlZ2lvbi4NCj4+IA0KPj4gTXkgcmVh
ZGluZyBvZiB0aGUgY3VycmVudCBjb2RlIGlzIHRoYXQgY2FjaGVfbG9jayBpcyBoZWxkDQo+PiBk
dXJpbmcgdGhlIG5mc2RfcmVwbHlfY2FjaGVfZnJlZV9sb2NrZWQoKSBjYWxsLg0KPj4gDQo+PiBh
ZGQxNTExYzM4MTYgc2ltcGx5IG1vdmVkIHRoZSBjYWxsIHNpdGUgZnJvbSBiZWZvcmUgYSAiZ290
byINCj4+IHRvIGFmdGVyIHRoZSBsYWJlbCBpdCBicmFuY2hlcyB0by4gV2hhdCBhbSBJIG1pc3Np
bmc/DQo+IA0KPiBZZXMsIEkgbGV0IG15c2VsZiBnZXQgY29uZnVzZWQgYnkgdGhlIGdvdG9zLiAg
QXMgeW91IHNheSB0aGF0IHBhdGNoDQo+IGRpZG4ndCBtb3ZlIHRoZSBjYWxsIG91dCBvZiB0aGUg
bG9ja2VkIHJlZ2lvbi4gIFNvcnJ5Lg0KPiANCj4gSSBjYW4ndCBzZWUgYW55dGhpbmcgd3Jvbmcg
d2l0aCB0aGUgbG9ja2luZyBvciB0cmVlIG1hbmFnZW1lbnQgaW4NCj4gbmZzY2FjaGUuYywgeWV0
IHRoaXMgT29wcyBsb29rcyBhIGxvdCBsaWtlIGEgY29ycnVwdGVkIHJidHJlZS4NCj4gSXQgKmNv
dWxkKiBiZSBzb21ldGhpbmcgZXh0ZXJuYWwgc3RvbXBpbmcgb24gdGhlIG1lbW9yeSBidXQgSSB0
aGluaw0KPiB0aGF0IGlzIHVubGlrZWx5LiAgSSdkIHJhdGhlciBoYXZlIGEgbW9yZSBkaXJlY3Qg
ZXhwbGFuYXRpb24uLi4uICBOb3QNCj4gdG9kYXkgdGhvdWdoIGl0IHNlZW1zLg0KDQpNeSBzcGlk
ZXkgc2Vuc2UgKHdlbGwsIE9LLCBteSBQVFNEIGZyb20gd2hlbiBJJ3ZlIHdvcmtlZCBvbg0KdGhl
IERSQyBjb2RlIHByZXZpb3VzbHkpIGlzIHRoYXQgdGhlc2Uga2luZCBvZiBtZW1vcnkgb3Zlcndy
aXRlcw0KY2FuIGhhcHBlbiB3aGVuIHRoZSBYRFIgcmVjZWl2ZSBidWZmZXIgaXMgdW5leHBlY3Rl
ZGx5IHNob3J0LA0KYW5kIHRoZSBEUkMgY29kZSBlbmRzIHVwIHJlYWRpbmcgb2ZmIHRoZSBlbmQg
b2YgaXQuIFRoYXQgY29kZQ0KbWFrZXMgc29tZSBzdHVubmluZyBhc3N1bXB0aW9ucyB0aGF0IG1p
Z2h0IG5vdCBob2xkIHRydWUgaW4gdGhlDQpuZXcgTE9DQUxJTyBwYXRocy4NCg0KQW5uYS9NaWtl
LCB5b3UgbWlnaHQgdHJ5IGVuYWJsaW5nIEtBU0FOIHRvIHNlZSBpZiBpdCB3aWxsIGNhdGNoDQp3
aGljaCBpbnN0cnVjdGlvbnMgYXJlIGRvaW5nIHRoZSBkYW1hZ2UuDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

