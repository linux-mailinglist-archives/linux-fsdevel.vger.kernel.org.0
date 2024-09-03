Return-Path: <linux-fsdevel+bounces-28434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC896A379
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CFFB251EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19960188A1B;
	Tue,  3 Sep 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lw3KCidL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V7PwuQAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1B188900;
	Tue,  3 Sep 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379187; cv=fail; b=TtZTdPOJybSFPVJXbAtmiVkvYVBvL1rUusr+lwxzEaA8P8S64RK6BIlBia+NAC4tqsW0ZNCR0nFMtcpj75RFzuNhi/4w5InIbDALF6F8SFJeQKnee9k3AYEnMzFzMjprQVsgRzj+ze07SDtu6d21SQcKU99QgjjLq0o3TuLhRh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379187; c=relaxed/simple;
	bh=U/OKxObH4NuOguT5jXpxOa9Hd9UbpJMG9X4w6ndpcFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hptwasiP/b16+gB4oOD/ZmuebUlPpXP/4f2hxU5mg4jIWF2N4W8yIaKRRGLBJjW8FPAftuwzwTLXFMcoQnYSIDIJy0qHtNkv8cXozd+g6YeF9+756o7JdJZrrx6jjQf8r95KpIJ/5h/vOCkMlbQbjm7Cqi9px32UrtIIfEG73ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lw3KCidL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V7PwuQAk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Ee9qQ008145;
	Tue, 3 Sep 2024 15:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=U/OKxObH4NuOguT5jXpxOa9Hd9UbpJMG9X4w6ndpc
	FE=; b=Lw3KCidLO+bXK1sHrNlC90eRZAy0izd9fdsyRp+XrrmSk7lQ0G2emQ2o2
	slKXQu8jE9M7DORISKa8hd3oJDyyc5gZU+tJAuF45izn37G6WAccTD+WdGtFJkq8
	2xm2R26WGEBhW+OWtRSLdxQDG4cPLBUx1/Acd657sXV9OcecKV/lca6LSulKajML
	l+srzOR+NvAsn5hfCy3ri3ufqQlhJLRPY3J0m3JZXTBpUiUtciMp2z8RtILv7jwC
	NC0AbJdryFCSCdYg/fcrI2Sxh1jHUlbjgKE6lKnH3I6bpvQ5/pv+fZG6q8STxPwG
	USFTkBKnMqdfuDSNMfKU61bm95C0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duyj1b5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 15:59:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483Fg2qK036727;
	Tue, 3 Sep 2024 15:59:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8wauw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 15:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5fhxXq+SKtVkMe2ufgGty9Fy4qZEtUXWbDGEX8qa5AyIddmaNpe0pfHQ6UDBKEhnkfUI49mkE6oh3XbUCKiKWog5RQHh9SlStqC+7u3zo7YTyZ1aVqQAjXGQeHyoniuoqGVDFu/DtU+LbLB2EvAXj/z66xLlNxe2w30TEvk2z32DhbZ0HqZjl2FNSf/nE3rsIoF6GbN3wrIDGfyshExuy5MlvaDq4BP8C+JIJxVkcOvXHIS67kRmHD7TmBpQkcriFLDnwcBYEzSNbMtgIbjxIVLT6kiGdrbXlJTe8Fl0KaL4BczqhmdVWdsXHHXuUYBlewQytUfl2ErviYeag5E3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/OKxObH4NuOguT5jXpxOa9Hd9UbpJMG9X4w6ndpcFE=;
 b=GMyOqx5D+2iYoiwl9fedxWcOS1i0miC1J+Yo7+Nt7CKW5lK9L7rCFxVFMeaBV9Xh8N1xFqaFfuHjRnz0gyyHI3bwF2tUlTMyjkW9rd0gOMn/EyBa3+wEbArloFQIIilM8pwVzEhvLEX6EwW5RWavHUOlAP4AUrcTU7Cz/UBNqFG9SZiRe16PhK7s/ZlR3Jd80RWvLNZbdOKngktQB1HZ7wQ7LYtrYcg/pLFePw/iNLDEF/3pxu5F+pgHQQmmQ70zS24wB6/gyYMIgwxsrkDJAT0kgMmfPKu7kNEqrpDZ3JSmTRlNFr21A0S7ujSQDJM9SczrRRgfZQx/+eyls4m98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/OKxObH4NuOguT5jXpxOa9Hd9UbpJMG9X4w6ndpcFE=;
 b=V7PwuQAku6sKWeb2QPinqbhfH+bK3b60E0bpx1mhbmvEivWaHXyt9oESFnvP0j5CtpfauZg0cLgNxFpPaJKcQN6yf+/kGGsjxSsPy9tqk3jbBQc1xVd0RO5+9zne1TX2tXzc9uRwYoSYxpFxFbvHT7cNViWkUekRs8e1FMghx6A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7625.namprd10.prod.outlook.com (2603:10b6:930:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Tue, 3 Sep
 2024 15:59:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Tue, 3 Sep 2024
 15:59:31 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Topic: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Index:
 AQHa+/Z8NjJpiHCGJkyIBxPv6nO2sLJGJLQAgAABzwCAAAV7gIAABX6AgAACqoCAAAhmAA==
Date: Tue, 3 Sep 2024 15:59:31 +0000
Message-ID: <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <20240831223755.8569-17-snitzer@kernel.org>
 <ZtceWJE5mJ9ayf2y@tissot.1015granger.net>
 <cd02bbdc0059afaff52d0aab1da0ecf91d101a0a.camel@kernel.org>
 <ZtckdSIT6a3N-VTU@kernel.org>
 <981320f318d23fe02ed7597a56d13227f7cea31e.camel@kernel.org>
 <ZtcrTYLq90xIt4UK@kernel.org>
In-Reply-To: <ZtcrTYLq90xIt4UK@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CYYPR10MB7625:EE_
x-ms-office365-filtering-correlation-id: 311a37db-ea6a-4095-6cfa-08dccc3165cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnZKeG1yZGxzUkVHUWVnemM4UE05OEdydExFZzBwdG9LZW1KU1gyc2tyMlhm?=
 =?utf-8?B?RTdPMmJ3cUZsSnh3dUh5UUNsU3MwZE5oWjVtMnZUUGtWL1d4Z21BeEthdG95?=
 =?utf-8?B?ZUtLMXNxM1FuUjMxUHp0c0xyRFNqZ3JUaE41KzdVcmwva1JaNUFNenFUemxS?=
 =?utf-8?B?RkJiR3NobUd4WGdGV3NIaUJtZWZpS1RVa0RCVUhaSDl1bWVvalNwNHMxNHN1?=
 =?utf-8?B?TFNPVTRRQ3JwcGpRK09jcTBnc0U4dHd2Ujd0YnZweG9NMGpRRCtsV0VoaHBT?=
 =?utf-8?B?Vld4MUFSa1UxVkRjOEFvNU5HWDZOUHgrdWR5V2JxVE9MQk5RcHg4WnlhUDBX?=
 =?utf-8?B?VFlMRlQ5OHp2TXkrZDQ3OEp2Y2FRRE9mT3cweWRFOW85WnhRbERyWW1LcHYv?=
 =?utf-8?B?a2YzZHcybW00cWZlNnl4TG9FbWJMQit3RElDRkRLR0ZJcVZYbXVXaXFkVWdU?=
 =?utf-8?B?a0UvWVV2NGZpdWdSZ0RadnRSRkhyVkdRMThpc1M0RlRtM3NRYzNFdVl1aDRv?=
 =?utf-8?B?OHp6ZDlxUXF6eHVHQ1B4NEt0a05tNjZNT1cyY3lRaU43aHZ4aWdablpEdWJ3?=
 =?utf-8?B?V09YeVBxRlJQMjE5TmtFM2hLZERtMVRDd2FpT2t1MUpVYzZXR0Rsckx5THlq?=
 =?utf-8?B?ZTZ3UnpteDgxQUVndkNvUm50ZlhaL2ZYeUNIRkM0VFBNSHMrS3ptcHpBZGJE?=
 =?utf-8?B?MVIvTk5vRG83aUNvQnIwWWV1OWRKY1hjcHJuRlN3bTlyOEhGNHQxZE9aNnN5?=
 =?utf-8?B?dGdvelVPR2ZsOHhpbVFEc25EQ1YwOTBDVlpDZWZlck03dXF3dUdURVdiS1BH?=
 =?utf-8?B?WVFmZElkSTJuVnlwbnp5b3liSU15SXpwMFAyTXNkWVh3QlBsU2pUd3cvSWNI?=
 =?utf-8?B?aTRBZ0RCUEE2cHNteE56Y1ZDU1QvRjJNZGNQSVZodXRjQUt0MG1JVTA5TUp4?=
 =?utf-8?B?eWVjSm1McGtUYUcyZkFUbDl1aExySGFrRzdYTEdCdUxVZjJoYjAzOTZNc1dW?=
 =?utf-8?B?ODcrazV4T1dBTnlvYSt4b2Y2NGJseGZWd2c5b0YzVWl1VkRIRlZtcUtlODBN?=
 =?utf-8?B?U2ppVENqc05KTDNPb0MzcmpnaHpyZkk1MWlNcnJ6WVlkb0Q5WDFFS2t4cyts?=
 =?utf-8?B?ZGRicDBIVWw5M1hsVTRENS9DWnBGajEwaHp5TFFoc3BrUGVMUDV5Nk0rc3Rq?=
 =?utf-8?B?Ky9mOHFWMlA0T3JYSFR3SU1ONmlZd2puSnB2dFlnZGxQSXkzNW0zTWFQVTBL?=
 =?utf-8?B?cUd2QVZCVkV6WUp1NXorQkRsVm1lWlRiMWVOYkgwUllxdE1iSjVmYkNISHhP?=
 =?utf-8?B?eXZXMFdwbDlQUjhaZHdjNFF0ZmNxRUIwTFU1MTUwNmtHQWI5Zk9UV3hJangy?=
 =?utf-8?B?SGtPbWRRQWY2d2lFZzFXOGg3NGdqYjdZa1hqbnlhcUlPMytRbUtPcHFtVHlB?=
 =?utf-8?B?OUF0MVFwU1hSYnUxNSt4bUhKV2toKzNpUWVFMVVTbGswQWZSbDV3K2NnOVFX?=
 =?utf-8?B?S0RVNDBzQ2lPU1FIOTh0UEJ5SXNUcS83SWUrTVlTQXQveURBZmN1dHk4K01h?=
 =?utf-8?B?bFpuMldvZ1FnZ0JNNXQ3c2R0ajZBQkpGdjV3NW5vRjJINE9wYmVBMStKdCtI?=
 =?utf-8?B?SVBlSzF4eTEwQnVOVk1yNm1ENVpjaWYrQVcxS3RPTE1ENHBDMFhYYVFDUlF0?=
 =?utf-8?B?WE12ejlFd3hxQjZSUWlYTFhTN1VZS21IWlpvZVQrZitVeDdPS21KSmxWZDhM?=
 =?utf-8?B?R2hlbmlzZ2xmckovZmlLelZGa0p2UGF6NGd0c05nYytEL3J0TENvNnJOaDB6?=
 =?utf-8?B?ZkVxUzhsVmRQeFJTYmRydThCQURJd2dKRFlCdW5mL0Y3ODZOakc4bEF5TlNi?=
 =?utf-8?B?SmJVR3lxV1BFVDVEM1hvTkRDUUpzQVFGN2FkVWF4Y3lqWmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGlIcFBsSmF3S0Q1NXR2bVNRQ1BTZU1MWTRDN09IdzViSUQxeUZBTUI2aXQ0?=
 =?utf-8?B?MDdld05qUFVMZXh5bEdmSG94QUw0NHVJR2JQZ282SlVxZS8zSUFJa1JmUy9i?=
 =?utf-8?B?VDJ1QzljUXg5U05KMTgydEMzMFVVQnBHQXdXMW9nSnkrRFB0aXJRSGh1eldX?=
 =?utf-8?B?ditkZUUwUTVUbXF6OTN2WGFmVXVONjlEWGNHNWtXUEY0WlU1alpQUjFsd2Zi?=
 =?utf-8?B?M2dlT0kwdTQ3ZGxHbHRuQk1RQzZtUDJ3YzFWOWdlbzBBZXc5d2ViT3d1NW5l?=
 =?utf-8?B?ZVhWVG16SmN6Sk9LV1dueG5IQnFnSjF3VHJxRTAyWUErUnRvUnhFYVlXR3lV?=
 =?utf-8?B?U1lhdWtDWEdUdlJPZmtEZjZib0JOZDIxSHVLQ2dXK2M3RDFFR1ZXTnZiVzJG?=
 =?utf-8?B?Zm9hbkhKaUk3NjFWSHBlSUFuUk9USUVuLzJDTjZ1c25QYm9nQWtzOElmcFpW?=
 =?utf-8?B?eWd2K1RzRzlpMEsrcVRPTFREQlhmSVQ2WXJ2cUt4QjNLc1YwNDA4OFVVV1Fj?=
 =?utf-8?B?cE9rYnE2dHpHcE9wbzVoVGU1aXNWWU1XZnJVNGFnaHdqVnhCTDN1YmZWa3lE?=
 =?utf-8?B?NXVZS2RxajhzWmdjSElKRU9wOFFSVXNHUWlrWFN1a1NKOFdtN1lSMTZLNEdy?=
 =?utf-8?B?VlhHR1B1azdUSEtIYW5FbmNMT1Q5Szc4Q3ZJK3FadGhtd3pncFRvWUVBTkc1?=
 =?utf-8?B?YS94SG5ndTlweHRTelJoV0JMQTkrNVBnQ3ByVWZUQ3JJc3hmRUZEU3VkbnJJ?=
 =?utf-8?B?WjVPWjYzaTYvS04vY1dJSjZMb1dybGJscURkZU4xRG05NTl1bWRVVHh4Znc3?=
 =?utf-8?B?TGpSNUFqK1NJRE5iNXVtYlRJOFU1MnVGYi8vVHpYTUxXQ1EzanFZK1lyRnJ0?=
 =?utf-8?B?N05pN2x5Y05Jd0ZYbzR6V0ZIYklUVDFaU3BRVTdHemw2V20rMDF4UDVuTkVT?=
 =?utf-8?B?aHgyM2R0TmlHZUJ1R0RMYndUbEVwWEQ5ZTI4blk5Vy9SMk1mdGpGQXhXb0F0?=
 =?utf-8?B?bjlRVVdSb0poZGY3VWJsREFuTUU5dTFwZkEwS3R3RnlQcndNZFpMUEdQWGJ2?=
 =?utf-8?B?Mk9aNzNwaVRIUGgxUlVCNTErUm0yd2NRTExoSVozVURVMGV3SmNBR05MK0R4?=
 =?utf-8?B?U2NPZ0NGaHIrR2xJVWY4VzNxeElPdkhsYTBlU0dtcERDUmdtVXIrb0t3akZ1?=
 =?utf-8?B?S05oY3NML200eld5dmhHVDZTbHZHcUNvSzl6MDhKbnd5cWViRk92QTRjRTlQ?=
 =?utf-8?B?cG5xWjg3OXlwK1Yza0xTdlBCelkxQmdvdWhEcURCSlptYWEzWkxlSnl0OUt1?=
 =?utf-8?B?bEF0d0lpemFPbWpqejU2VGNFaktIWnJzK09KdVV1NWJRZkZESUpWaWoyMWJS?=
 =?utf-8?B?Z0YzSHBpZk9scjQ1VWlqTlVOSmdXQVZzb1pSVlN4OXc1aEpQM3lYNW5ZZVN6?=
 =?utf-8?B?UlphUXM3emRjM0c4blVNbzJ6U3VLNC9Wa2JyMzFsUGtkRWZYSE1kSFVpd1Jw?=
 =?utf-8?B?UURwMloxRVdxQ2xiMVJmYTV6ZC9raWR2UW1qeHpwK2J3MDRGOUkva2djOENy?=
 =?utf-8?B?NXlXcHdTNFp3N2t2dzBTNHhYK1htZW12TDVwYUZENXN4eGN1b1h0WmRGZHVQ?=
 =?utf-8?B?eWdZeDZISXN5T05DaEw0Vi8wZjZXcEhFR1NLVFFUcU9xWEkxSnhVcEsxZXcr?=
 =?utf-8?B?MFVxOTRqT3BHY1Z1RkUvaGsxVDlzVlh1UlBVODUveTZabWEraGtZay9VbjNY?=
 =?utf-8?B?bS9qSnZXMWJIb1pDZStncGVOMVlOUTJCbXpEK3hyK1JZN1JGSWVGVWhGc0Nt?=
 =?utf-8?B?RVdlVTZXYmNsamJiSDdFRURQMWNaSFZhczBIZ2Q0SG1ZWmVrL1Zaa3g0QVJt?=
 =?utf-8?B?WjZwSlZ5SjRObExaajRLNyswUEN0VnpJR2dFd0VuQ204SXFhYkFWelg5c3Vp?=
 =?utf-8?B?VFhlcWlweHJlYWZrMEdtYjZxZnNuSWk0b1B6ZjN1V29QT2MrbC9ZT1NRTGgv?=
 =?utf-8?B?Nys1VVlQMmJrNDBWeEt4M0FlQjJmTWRXVzY4YkZOamxQNTc3SlFOcTJGck02?=
 =?utf-8?B?NzJoVytZa0RJdGNCaWM5QzlNdkdrb3lxSzNIU1VmUG5OdXVuQWlRZ0tDUUEw?=
 =?utf-8?B?eFZRODlYNnRsaHJ2S1huc1VmQVlRV3NyQ3lRV2FZdUlDb3N6bnUvRWhpdzVs?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <376284A1E11DB04F8110D294405A5E45@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a/1vj3JjhLv9yuD7OKgUKxAs3kdEtNucaZUtIbYHOgNGxxzbDX69ekDAKZVAnfcPRxw6kynfRfPRkjVE6RRY0fo75u33MaosirfnJuyFH+FLlNbtd39PDaB1j29HrHQPm6EykTb4lZ+supq59ST+T+Q6sUK96DAtxMwJRRuctKTnZbZkDqShx/9eSig3E2mglaG/CslnmBUzMe1Zpoom6yvhroQ6ZZs8mZzdYtgcdKZl7BIyzks1q3ibpGjb+IEMUVfvo0HayPJi3sJI7dNiejPyXCCkTXVqMav3FmptnUhS/qWDCY93Yxa+bGcY9KH4a5SAcOO6kOszW5rK2D+zPmb6qTWdeb8Kgu25EO7Dbu5aNyweDCU8dqcw90IPsoo49h7LbZE3R0GwT0MYizTLm1p1NtWN7IA2FkI3J2EaZ6bFoW67Q1vArP3o2+TdUq+4yXLDZUAUIY+R0/GPAWPshtgJVpOaTisySN4ZdLn4OVd2x74QCB6zhrfgHg61eP9Kcs8Nz5baUpsAGwgQFJ3gWWFNkCafgB+s8PH7lNMOBwFCnvcMIcEtyO9LBEepy82fRX1Qu7zcSAMcwVy6fU0a/6W7Ds7e8Z8fGvBLZSWtli0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311a37db-ea6a-4095-6cfa-08dccc3165cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 15:59:31.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAPaJQjm6HpomC20FvUuAsA588kxdyAHAWiI1UvKNaYKL8skfR0MeN7rlXaKXGY9JQgMT405P/6vAps8zc5fbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_03,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030130
X-Proofpoint-GUID: iGvq4YErVBTQpbBPT7tFWRNy9BbCWAXD
X-Proofpoint-ORIG-GUID: iGvq4YErVBTQpbBPT7tFWRNy9BbCWAXD

DQoNCj4gT24gU2VwIDMsIDIwMjQsIGF0IDExOjI54oCvQU0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgU2VwIDAzLCAyMDI0IGF0IDExOjE5
OjQ1QU0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4gT24gVHVlLCAyMDI0LTA5LTAzIGF0
IDExOjAwIC0wNDAwLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+Pj4gT24gVHVlLCBTZXAgMDMsIDIw
MjQgYXQgMTA6NDA6MjhBTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+Pj4+IE9uIFR1ZSwg
MjAyNC0wOS0wMyBhdCAxMDozNCAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4+PiBPbiBT
YXQsIEF1ZyAzMSwgMjAyNCBhdCAwNjozNzozNlBNIC0wNDAwLCBNaWtlIFNuaXR6ZXIgd3JvdGU6
DQo+Pj4+Pj4gRnJvbTogV2VzdG9uIEFuZHJvcyBBZGFtc29uIDxkcm9zQHByaW1hcnlkYXRhLmNv
bT4NCj4+Pj4+PiANCj4+Pj4+PiBBZGQgc2VydmVyIHN1cHBvcnQgZm9yIGJ5cGFzc2luZyBORlMg
Zm9yIGxvY2FsaG9zdCByZWFkcywgd3JpdGVzLCBhbmQNCj4+Pj4+PiBjb21taXRzLiBUaGlzIGlz
IG9ubHkgdXNlZnVsIHdoZW4gYm90aCB0aGUgY2xpZW50IGFuZCBzZXJ2ZXIgYXJlDQo+Pj4+Pj4g
cnVubmluZyBvbiB0aGUgc2FtZSBob3N0Lg0KPj4+Pj4+IA0KPj4+Pj4+IElmIG5mc2Rfb3Blbl9s
b2NhbF9maCgpIGZhaWxzIHRoZW4gdGhlIE5GUyBjbGllbnQgd2lsbCBib3RoIHJldHJ5IGFuZA0K
Pj4+Pj4+IGZhbGxiYWNrIHRvIG5vcm1hbCBuZXR3b3JrLWJhc2VkIHJlYWQsIHdyaXRlIGFuZCBj
b21taXQgb3BlcmF0aW9ucyBpZg0KPj4+Pj4+IGxvY2FsaW8gaXMgbm8gbG9uZ2VyIHN1cHBvcnRl
ZC4NCj4+Pj4+PiANCj4+Pj4+PiBDYXJlIGlzIHRha2VuIHRvIGVuc3VyZSB0aGUgc2FtZSBORlMg
c2VjdXJpdHkgbWVjaGFuaXNtcyBhcmUgdXNlZA0KPj4+Pj4+IChhdXRoZW50aWNhdGlvbiwgZXRj
KSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgbG9jYWxpbyBvciByZWd1bGFyIE5GUw0KPj4+Pj4+IGFj
Y2VzcyBpcyB1c2VkLiAgVGhlIGF1dGhfZG9tYWluIGVzdGFibGlzaGVkIGFzIHBhcnQgb2YgdGhl
IHRyYWRpdGlvbmFsDQo+Pj4+Pj4gTkZTIGNsaWVudCBhY2Nlc3MgdG8gdGhlIE5GUyBzZXJ2ZXIg
aXMgYWxzbyB1c2VkIGZvciBsb2NhbGlvLiAgU3RvcmUNCj4+Pj4+PiBhdXRoX2RvbWFpbiBmb3Ig
bG9jYWxpbyBpbiBuZnNkX3V1aWRfdCBhbmQgdHJhbnNmZXIgaXQgdG8gdGhlIGNsaWVudA0KPj4+
Pj4+IGlmIGl0IGlzIGxvY2FsIHRvIHRoZSBzZXJ2ZXIuDQo+Pj4+Pj4gDQo+Pj4+Pj4gUmVsYXRp
dmUgdG8gY29udGFpbmVycywgbG9jYWxpbyBnaXZlcyB0aGUgY2xpZW50IGFjY2VzcyB0byB0aGUg
bmV0d29yaw0KPj4+Pj4+IG5hbWVzcGFjZSB0aGUgc2VydmVyIGhhcy4gIFRoaXMgaXMgcmVxdWly
ZWQgdG8gYWxsb3cgdGhlIGNsaWVudCB0bw0KPj4+Pj4+IGFjY2VzcyB0aGUgc2VydmVyJ3MgcGVy
LW5hbWVzcGFjZSBuZnNkX25ldCBzdHJ1Y3QuDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhpcyBjb21taXQg
YWxzbyBpbnRyb2R1Y2VzIHRoZSB1c2Ugb2YgTkZTRCdzIHBlcmNwdV9yZWYgdG8gaW50ZXJsb2Nr
DQo+Pj4+Pj4gbmZzZF9kZXN0cm95X3NlcnYgYW5kIG5mc2Rfb3Blbl9sb2NhbF9maCwgdG8gZW5z
dXJlIG5uLT5uZnNkX3NlcnYgaXMNCj4+Pj4+PiBub3QgZGVzdHJveWVkIHdoaWxlIGluIHVzZSBi
eSBuZnNkX29wZW5fbG9jYWxfZmggYW5kIG90aGVyIExPQ0FMSU8NCj4+Pj4+PiBjbGllbnQgY29k
ZS4NCj4+Pj4+PiANCj4+Pj4+PiBDT05GSUdfTkZTX0xPQ0FMSU8gZW5hYmxlcyBORlMgc2VydmVy
IHN1cHBvcnQgZm9yIExPQ0FMSU8uDQo+Pj4+Pj4gDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogV2Vz
dG9uIEFuZHJvcyBBZGFtc29uIDxkcm9zQHByaW1hcnlkYXRhLmNvbT4NCj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+
DQo+Pj4+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJAa2VybmVsLm9y
Zz4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJAa2VybmVsLm9y
Zz4NCj4+Pj4+PiBDby1kZXZlbG9wZWQtYnk6IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4NCj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+DQo+Pj4+Pj4gDQo+
Pj4+Pj4gTm90LUFja2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4N
Cj4+Pj4+PiBOb3QtUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+
DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gZnMvbmZzZC9NYWtlZmlsZSAgICAgICAgICAgfCAgIDEgKw0K
Pj4+Pj4+IGZzL25mc2QvZmlsZWNhY2hlLmMgICAgICAgIHwgICAyICstDQo+Pj4+Pj4gZnMvbmZz
ZC9sb2NhbGlvLmMgICAgICAgICAgfCAxMTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+Pj4+IGZzL25mc2QvbmV0bnMuaCAgICAgICAgICAgIHwgICA0ICsrDQo+Pj4+
Pj4gZnMvbmZzZC9uZnNjdGwuYyAgICAgICAgICAgfCAgMjUgKysrKysrKystDQo+Pj4+Pj4gZnMv
bmZzZC90cmFjZS5oICAgICAgICAgICAgfCAgIDMgKy0NCj4+Pj4+PiBmcy9uZnNkL3Zmcy5oICAg
ICAgICAgICAgICB8ICAgMiArDQo+Pj4+Pj4gaW5jbHVkZS9saW51eC9uZnNsb2NhbGlvLmggfCAg
IDggKysrDQo+Pj4+Pj4gOCBmaWxlcyBjaGFuZ2VkLCAxNTQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4+Pj4+PiBjcmVhdGUgbW9kZSAxMDA2NDQgZnMvbmZzZC9sb2NhbGlvLmMNCj4+
Pj4+PiANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9NYWtlZmlsZSBiL2ZzL25mc2QvTWFr
ZWZpbGUNCj4+Pj4+PiBpbmRleCBiODczNmE4MmU1N2MuLjE4Y2JkM2ZhNzY5MSAxMDA2NDQNCj4+
Pj4+PiAtLS0gYS9mcy9uZnNkL01ha2VmaWxlDQo+Pj4+Pj4gKysrIGIvZnMvbmZzZC9NYWtlZmls
ZQ0KPj4+Pj4+IEBAIC0yMywzICsyMyw0IEBAIG5mc2QtJChDT05GSUdfTkZTRF9QTkZTKSArPSBu
ZnM0bGF5b3V0cy5vDQo+Pj4+Pj4gbmZzZC0kKENPTkZJR19ORlNEX0JMT0NLTEFZT1VUKSArPSBi
bG9ja2xheW91dC5vIGJsb2NrbGF5b3V0eGRyLm8NCj4+Pj4+PiBuZnNkLSQoQ09ORklHX05GU0Rf
U0NTSUxBWU9VVCkgKz0gYmxvY2tsYXlvdXQubyBibG9ja2xheW91dHhkci5vDQo+Pj4+Pj4gbmZz
ZC0kKENPTkZJR19ORlNEX0ZMRVhGSUxFTEFZT1VUKSArPSBmbGV4ZmlsZWxheW91dC5vIGZsZXhm
aWxlbGF5b3V0eGRyLm8NCj4+Pj4+PiArbmZzZC0kKENPTkZJR19ORlNfTE9DQUxJTykgKz0gbG9j
YWxpby5vDQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvZmlsZWNhY2hlLmMgYi9mcy9uZnNk
L2ZpbGVjYWNoZS5jDQo+Pj4+Pj4gaW5kZXggODlmZjM4MGVjMzFlLi4zNDhjMWI5NzA5MmUgMTAw
NjQ0DQo+Pj4+Pj4gLS0tIGEvZnMvbmZzZC9maWxlY2FjaGUuYw0KPj4+Pj4+ICsrKyBiL2ZzL25m
c2QvZmlsZWNhY2hlLmMNCj4+Pj4+PiBAQCAtNTIsNyArNTIsNyBAQA0KPj4+Pj4+ICNkZWZpbmUg
TkZTRF9GSUxFX0NBQ0hFX1VQICAgICAgKDApDQo+Pj4+Pj4gDQo+Pj4+Pj4gLyogV2Ugb25seSBj
YXJlIGFib3V0IE5GU0RfTUFZX1JFQUQvV1JJVEUgZm9yIHRoaXMgY2FjaGUgKi8NCj4+Pj4+PiAt
I2RlZmluZSBORlNEX0ZJTEVfTUFZX01BU0sgKE5GU0RfTUFZX1JFQUR8TkZTRF9NQVlfV1JJVEUp
DQo+Pj4+Pj4gKyNkZWZpbmUgTkZTRF9GSUxFX01BWV9NQVNLIChORlNEX01BWV9SRUFEfE5GU0Rf
TUFZX1dSSVRFfE5GU0RfTUFZX0xPQ0FMSU8pDQo+Pj4+Pj4gDQo+Pj4+Pj4gc3RhdGljIERFRklO
RV9QRVJfQ1BVKHVuc2lnbmVkIGxvbmcsIG5mc2RfZmlsZV9jYWNoZV9oaXRzKTsNCj4+Pj4+PiBz
dGF0aWMgREVGSU5FX1BFUl9DUFUodW5zaWduZWQgbG9uZywgbmZzZF9maWxlX2FjcXVpc2l0aW9u
cyk7DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvbG9jYWxpby5jIGIvZnMvbmZzZC9sb2Nh
bGlvLmMNCj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+Pj4+IGluZGV4IDAwMDAwMDAw
MDAwMC4uNzVkZjcwOWM2OTAzDQo+Pj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+Pj4+ICsrKyBiL2Zz
L25mc2QvbG9jYWxpby5jDQo+Pj4+Pj4gQEAgLTAsMCArMSwxMTIgQEANCj4+Pj4+PiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPj4+Pj4+ICsvKg0KPj4+Pj4+ICsg
KiBORlMgc2VydmVyIHN1cHBvcnQgZm9yIGxvY2FsIGNsaWVudHMgdG8gYnlwYXNzIG5ldHdvcmsg
c3RhY2sNCj4+Pj4+PiArICoNCj4+Pj4+PiArICogQ29weXJpZ2h0IChDKSAyMDE0IFdlc3RvbiBB
bmRyb3MgQWRhbXNvbiA8ZHJvc0BwcmltYXJ5ZGF0YS5jb20+DQo+Pj4+Pj4gKyAqIENvcHlyaWdo
dCAoQykgMjAxOSBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20+DQo+Pj4+Pj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJA
aGFtbWVyc3BhY2UuY29tPg0KPj4+Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgTmVpbEJyb3du
IDxuZWlsYkBzdXNlLmRlPg0KPj4+Pj4+ICsgKi8NCj4+Pj4+PiArDQo+Pj4+Pj4gKyNpbmNsdWRl
IDxsaW51eC9leHBvcnRmcy5oPg0KPj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvc3VucnBjL3N2Y2F1
dGguaD4NCj4+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L3N1bnJwYy9jbG50Lmg+DQo+Pj4+Pj4gKyNp
bmNsdWRlIDxsaW51eC9uZnMuaD4NCj4+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L25mc19jb21tb24u
aD4NCj4+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L25mc2xvY2FsaW8uaD4NCj4+Pj4+PiArI2luY2x1
ZGUgPGxpbnV4L3N0cmluZy5oPg0KPj4+Pj4+ICsNCj4+Pj4+PiArI2luY2x1ZGUgIm5mc2QuaCIN
Cj4+Pj4+PiArI2luY2x1ZGUgInZmcy5oIg0KPj4+Pj4+ICsjaW5jbHVkZSAibmV0bnMuaCINCj4+
Pj4+PiArI2luY2x1ZGUgImZpbGVjYWNoZS5oIg0KPj4+Pj4+ICsNCj4+Pj4+PiArc3RhdGljIGNv
bnN0IHN0cnVjdCBuZnNkX2xvY2FsaW9fb3BlcmF0aW9ucyBuZnNkX2xvY2FsaW9fb3BzID0gew0K
Pj4+Pj4+ICsgLm5mc2Rfb3Blbl9sb2NhbF9maCA9IG5mc2Rfb3Blbl9sb2NhbF9maCwNCj4+Pj4+
PiArIC5uZnNkX2ZpbGVfcHV0X2xvY2FsID0gbmZzZF9maWxlX3B1dF9sb2NhbCwNCj4+Pj4+PiAr
IC5uZnNkX2ZpbGVfZmlsZSA9IG5mc2RfZmlsZV9maWxlLA0KPj4+Pj4+ICt9Ow0KPj4+Pj4+ICsN
Cj4+Pj4+PiArdm9pZCBuZnNkX2xvY2FsaW9fb3BzX2luaXQodm9pZCkNCj4+Pj4+PiArew0KPj4+
Pj4+ICsgbWVtY3B5KCZuZnNfdG8sICZuZnNkX2xvY2FsaW9fb3BzLCBzaXplb2YobmZzZF9sb2Nh
bGlvX29wcykpOw0KPj4+Pj4+ICt9DQo+Pj4+PiANCj4+Pj4+IFNhbWUgY29tbWVudCBhcyBOZWls
OiB0aGlzIHNob3VsZCBzdXJmYWNlIGEgcG9pbnRlciB0byB0aGUNCj4+Pj4+IGxvY2FsaW9fb3Bz
IHN0cnVjdC4gQ29weWluZyB0aGUgd2hvbGUgc2V0IG9mIGZ1bmN0aW9uIHBvaW50ZXJzIGlzDQo+
Pj4+PiBnZW5lcmFsbHkgdW5uZWNlc3NhcnkuDQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+ICsNCj4+
Pj4+PiArLyoqDQo+Pj4+Pj4gKyAqIG5mc2Rfb3Blbl9sb2NhbF9maCAtIGxvb2t1cCBhIGxvY2Fs
IGZpbGVoYW5kbGUgQG5mc19maCBhbmQgbWFwIHRvIG5mc2RfZmlsZQ0KPj4+Pj4+ICsgKg0KPj4+
Pj4+ICsgKiBAdXVpZDogbmZzX3V1aWRfdCB3aGljaCBwcm92aWRlcyB0aGUgJ3N0cnVjdCBuZXQn
IHRvIGdldCB0aGUgcHJvcGVyIG5mc2RfbmV0DQo+Pj4+Pj4gKyAqICAgICAgICBhbmQgdGhlICdz
dHJ1Y3QgYXV0aF9kb21haW4nIHJlcXVpcmVkIGZvciBMT0NBTElPIGFjY2Vzcw0KPj4+Pj4+ICsg
KiBAcnBjX2NsbnQ6IHJwY19jbG50IHRoYXQgdGhlIGNsaWVudCBlc3RhYmxpc2hlZCwgdXNlZCBm
b3Igc29ja2FkZHIgYW5kIGNyZWQNCj4+Pj4+PiArICogQGNyZWQ6IGNyZWQgdGhhdCB0aGUgY2xp
ZW50IGVzdGFibGlzaGVkDQo+Pj4+Pj4gKyAqIEBuZnNfZmg6IGZpbGVoYW5kbGUgdG8gbG9va3Vw
DQo+Pj4+Pj4gKyAqIEBmbW9kZTogZm1vZGVfdCB0byB1c2UgZm9yIG9wZW4NCj4+Pj4+PiArICoN
Cj4+Pj4+PiArICogVGhpcyBmdW5jdGlvbiBtYXBzIGEgbG9jYWwgZmggdG8gYSBwYXRoIG9uIGEg
bG9jYWwgZmlsZXN5c3RlbS4NCj4+Pj4+PiArICogVGhpcyBpcyB1c2VmdWwgd2hlbiB0aGUgbmZz
IGNsaWVudCBoYXMgdGhlIGxvY2FsIHNlcnZlciBtb3VudGVkIC0gaXQgY2FuDQo+Pj4+Pj4gKyAq
IGF2b2lkIGFsbCB0aGUgTkZTIG92ZXJoZWFkIHdpdGggcmVhZHMsIHdyaXRlcyBhbmQgY29tbWl0
cy4NCj4+Pj4+PiArICoNCj4+Pj4+PiArICogT24gc3VjY2Vzc2Z1bCByZXR1cm4sIHJldHVybmVk
IG5mc2RfZmlsZSB3aWxsIGhhdmUgaXRzIG5mX25ldCBtZW1iZXINCj4+Pj4+PiArICogc2V0LiBD
YWxsZXIgKE5GUyBjbGllbnQpIGlzIHJlc3BvbnNpYmxlIGZvciBjYWxsaW5nIG5mc2Rfc2Vydl9w
dXQgYW5kDQo+Pj4+Pj4gKyAqIG5mc2RfZmlsZV9wdXQgKHZpYSBuZnNfdG8ubmZzZF9maWxlX3B1
dF9sb2NhbCkuDQo+Pj4+Pj4gKyAqLw0KPj4+Pj4+ICtzdHJ1Y3QgbmZzZF9maWxlICoNCj4+Pj4+
PiArbmZzZF9vcGVuX2xvY2FsX2ZoKG5mc191dWlkX3QgKnV1aWQsDQo+Pj4+Pj4gKyAgICBzdHJ1
Y3QgcnBjX2NsbnQgKnJwY19jbG50LCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCwNCj4+Pj4+PiAr
ICAgIGNvbnN0IHN0cnVjdCBuZnNfZmggKm5mc19maCwgY29uc3QgZm1vZGVfdCBmbW9kZSkNCj4+
Pj4+PiArIF9fbXVzdF9ob2xkKHJjdSkNCj4+Pj4+PiArew0KPj4+Pj4+ICsgaW50IG1heWZsYWdz
ID0gTkZTRF9NQVlfTE9DQUxJTzsNCj4+Pj4+PiArIHN0cnVjdCBuZnNkX25ldCAqbm4gPSBOVUxM
Ow0KPj4+Pj4+ICsgc3RydWN0IG5ldCAqbmV0Ow0KPj4+Pj4+ICsgc3RydWN0IHN2Y19jcmVkIHJx
X2NyZWQ7DQo+Pj4+Pj4gKyBzdHJ1Y3Qgc3ZjX2ZoIGZoOw0KPj4+Pj4+ICsgc3RydWN0IG5mc2Rf
ZmlsZSAqbG9jYWxpbzsNCj4+Pj4+PiArIF9fYmUzMiBiZXJlczsNCj4+Pj4+PiArDQo+Pj4+Pj4g
KyBpZiAobmZzX2ZoLT5zaXplID4gTkZTNF9GSFNJWkUpDQo+Pj4+Pj4gKyByZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAvKg0KPj4+Pj4+ICsgICogTm90IHJ1bm5p
bmcgaW4gbmZzZCBjb250ZXh0LCBzbyBtdXN0IHNhZmVseSBnZXQgcmVmZXJlbmNlIG9uIG5mc2Rf
c2Vydi4NCj4+Pj4+PiArICAqIEJ1dCB0aGUgc2VydmVyIG1heSBhbHJlYWR5IGJlIHNodXR0aW5n
IGRvd24sIGlmIHNvIGRpc2FsbG93IG5ldyBsb2NhbGlvLg0KPj4+Pj4+ICsgICogdXVpZC0+bmV0
IGlzIE5PVCBhIGNvdW50ZWQgcmVmZXJlbmNlLCBidXQgY2FsbGVyJ3MgcmN1X3JlYWRfbG9jaygp
IGVuc3VyZXMNCj4+Pj4+PiArICAqIHRoYXQgaWYgdXVpZC0+bmV0IGlzIG5vdCBOVUxMLCB0aGVu
IGNhbGxpbmcgbmZzZF9zZXJ2X3RyeV9nZXQoKSBpcyBzYWZlDQo+Pj4+Pj4gKyAgKiBhbmQgaWYg
aXQgc3VjY2VlZHMgd2Ugd2lsbCBoYXZlIGFuIGltcGxpZWQgcmVmZXJlbmNlIHRvIHRoZSBuZXQu
DQo+Pj4+Pj4gKyAgKi8NCj4+Pj4+PiArIG5ldCA9IHJjdV9kZXJlZmVyZW5jZSh1dWlkLT5uZXQp
Ow0KPj4+Pj4+ICsgaWYgKG5ldCkNCj4+Pj4+PiArIG5uID0gbmV0X2dlbmVyaWMobmV0LCBuZnNk
X25ldF9pZCk7DQo+Pj4+Pj4gKyBpZiAodW5saWtlbHkoIW5uIHx8ICFuZnNkX3NlcnZfdHJ5X2dl
dChubikpKQ0KPj4+Pj4+ICsgcmV0dXJuIEVSUl9QVFIoLUVOWElPKTsNCj4+Pj4+PiArDQo+Pj4+
Pj4gKyAvKiBEcm9wIHRoZSByY3UgbG9jayBmb3IgbmZzZF9maWxlX2FjcXVpcmVfbG9jYWwoKSAq
Lw0KPj4+Pj4+ICsgcmN1X3JlYWRfdW5sb2NrKCk7DQo+Pj4+PiANCj4+Pj4+IEknbSBzdHJ1Z2ds
aW5nIHdpdGggdGhlIGxvY2tpbmcgbG9naXN0aWNzLiBDYWxsZXIgdGFrZXMgdGhlIFJDVSByZWFk
DQo+Pj4+PiBsb2NrLCB0aGlzIGZ1bmN0aW9uIGRyb3BzIHRoZSBsb2NrLCB0aGVuIHRha2VzIGl0
IGFnYWluLiBTbzoNCj4+Pj4+IA0KPj4+Pj4gLSBBIGNhbGxlciBtaWdodCByZWx5IG9uIHRoZSBs
b2NrIGJlaW5nIGhlbGQgY29udGludW91c2x5LCBidXQNCj4+Pj4+IC0gVGhlIEFQSSBjb250cmFj
dCBkb2N1bWVudGVkIGFib3ZlIGRvZXNuJ3QgaW5kaWNhdGUgdGhhdCB0aGlzDQo+Pj4+PiAgIGZ1
bmN0aW9uIGRyb3BzIHRoYXQgbG9jaw0KPj4+Pj4gLSBUaGUgX19tdXN0X2hvbGQocmN1KSBhbm5v
dGF0aW9uIGRvZXNuJ3QgaW5kaWNhdGUgdGhhdCB0aGlzDQo+Pj4+PiAgIGZ1bmN0aW9uIGRyb3Bz
IHRoYXQgbG9jaywgSUlVQw0KPj4+Pj4gDQo+Pj4+PiBEcm9wcGluZyBhbmQgcmV0YWtpbmcgdGhl
IGxvY2sgaW4gaGVyZSBpcyBhbiBhbnRpLXBhdHRlcm4gdGhhdA0KPj4+Pj4gc2hvdWxkIGJlIGF2
b2lkZWQuIEkgc3VnZ2VzdCB3ZSBhcmUgYmV0dGVyIG9mZiBpbiB0aGUgbG9uZyBydW4gaWYNCj4+
Pj4+IHRoZSBjYWxsZXIgZG9lcyBub3QgbmVlZCB0byB0YWtlIHRoZSBSQ1UgcmVhZCBsb2NrLCBi
dXQgaW5zdGVhZCwNCj4+Pj4+IG5mc2Rfb3Blbl9sb2NhbF9maCB0YWtlcyBpdCByaWdodCBoZXJl
IGp1c3QgZm9yIHRoZSByY3VfZGVyZWZlcmVuY2UuDQo+Pj4gDQo+Pj4gSSB0aG91Z2h0IHNvIHRv
byB3aGVuIEkgZmlyc3Qgc2F3IGhvdyBOZWlsIGFwcHJvYWNoZWQgZml4aW5nIHRoaXMgdG8NCj4+
PiBiZSBzYWZlLiAgSXQgd2FzIG9ubHkgYWZ0ZXIgcHV0dGluZyBmdXJ0aGVyIHRpbWUgdG8gaXQg
KGFuZCBoYXZpbmcgdGhlDQo+Pj4gYmVuZWZpdCBvZiBiZWluZyBzbyBjbG9zZSB0byBhbGwgdGhp
cykgdGhhdCBJIHJlYWxpemVkIHRoZSBudWFuY2UgYXQNCj4+PiBwbGF5IChwbGVhc2Ugc2VlIG15
IHJlcGx5IHRvIEplZmYgYmVsb3cgZm9yIHRoZSBudWFuY2UgSSdtIHNwZWFraW5nDQo+Pj4gb2Yp
LiANCj4+PiANCj4+Pj4+IA0KPj4+Pj4gT1RPSCwgV2h5IGRyb3AgdGhlIGxvY2sgYmVmb3JlIGNh
bGxpbmcgbmZzZF9maWxlX2FjcXVpcmVfbG9jYWwoKT8NCj4+Pj4+IFRoZSBSQ1UgcmVhZCBsb2Nr
IGNhbiBzYWZlbHkgYmUgdGFrZW4gbW9yZSB0aGFuIG9uY2UgaW4gc3VjY2Vzc2lvbi4NCj4+Pj4+
IA0KPj4+Pj4gTGV0J3MgcmV0aGluayB0aGUgbG9ja2luZyBzdHJhdGVneS4NCj4+Pj4+IA0KPj4+
IA0KPj4+IFllcywgX3RoYXRfIGlzIGEgdmVyeSB2YWxpZCBwb2ludC4gIEkgZGlkIHdvbmRlciB0
aGUgc2FtZTogaXQgc2VlbXMNCj4+PiBwZXJmZWN0bHkgZmluZSB0byBzaW1wbHkgcmV0YWluIHRo
ZSBSQ1UgdGhyb3VnaG91dCB0aGUgZW50aXJldHkgb2YNCj4+PiBuZnNkX29wZW5fbG9jYWxfZmgo
KS4NCj4+PiANCj4+IA0KPj4gTm9wZS4gbmZzZF9maWxlX2RvX2FjcXVpcmUgY2FuIGFsbG9jYXRl
LCBzbyB5b3UgY2FuJ3QgaG9sZCB0aGUNCj4+IHJjdV9yZWFkX2xvY2sgb3ZlciB0aGUgd2hvbGUg
dGhpbmcuDQo+IA0KPiBBaCwgeWVhcC4uIHNvcnJ5LCBJIGtuZXcgdGhhdCA7KQ0KPiANCj4+Pj4g
QWdyZWVkLiBUaGUgb25seSBjYWxsZXIgZG9lcyB0aGlzOg0KPj4+PiANCj4+Pj4gICAgICAgIHJj
dV9yZWFkX2xvY2soKTsNCj4+Pj4gICAgICAgIGlmICghcmN1X2FjY2Vzc19wb2ludGVyKHV1aWQt
Pm5ldCkpIHsNCj4+Pj4gICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7DQo+Pj4+ICAg
ICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTlhJTyk7DQo+Pj4+ICAgICAgICB9DQo+Pj4+
ICAgICAgICBsb2NhbGlvID0gbmZzX3RvLm5mc2Rfb3Blbl9sb2NhbF9maCh1dWlkLCBycGNfY2xu
dCwgY3JlZCwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG5mc19maCwgZm1vZGUpOw0KPj4+PiAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7DQo+Pj4+IA0K
Pj4+PiBNYXliZSBqdXN0IG1vdmUgdGhlIGNoZWNrIGZvciB1dWlkLT5uZXQgZG93biBpbnRvIG5m
c2Rfb3Blbl9sb2NhbF9maCwNCj4+Pj4gYW5kIGl0IGNhbiBhY3F1aXJlIHRoZSByY3VfcmVhZF9s
b2NrIGZvciBpdHNlbGY/DQo+Pj4gDQo+Pj4gTm8sIHNvcnJ5IHdlIGNhbm5vdC4gIFRoZSBjYWxs
IHRvIG5mc190by5uZnNkX29wZW5fbG9jYWxfZmggKHdoaWNoIGlzDQo+Pj4gYSBzeW1ib2wgcHJv
dmlkZWQgYnkgbmZzZCkgaXMgb25seSBzYWZlIGlmIHRoZSBSQ1UgcHJvdGVjdGVkIHByZS1jaGVj
aw0KPj4+IHNob3dzIHRoZSB1dWlkLT5uZXQgdmFsaWQuDQo+PiANCj4+IE91Y2gsIG9rLg0KPiAN
Cj4gSSBoYWQgdG8gZG91YmxlIGNoZWNrIGJ1dCBJIGRpZCBhZGQgYSBjb21tZW50IHRoYXQgc3Bl
YWtzIGRpcmVjdGx5IHRvDQo+IHRoaXMgIm51YW5jZSIgYWJvdmUgdGhlIGNvZGUgeW91IHF1b3Rl
ZDoNCj4gDQo+ICAgICAgICAvKg0KPiAgICAgICAgICogdXVpZC0+bmV0IG11c3Qgbm90IGJlIE5V
TEwsIG90aGVyd2lzZSBORlMgbWF5IG5vdCBoYXZlIHJlZg0KPiAgICAgICAgICogb24gTkZTRCBh
bmQgdGhlcmVmb3JlIGNhbm5vdCBzYWZlbHkgbWFrZSAnbmZzX3RvJyBjYWxscy4NCj4gICAgICAg
ICAqLw0KPiANCj4gU28geWVhaCwgdGhpcyBjb2RlIG5lZWRzIHRvIHN0YXkgbGlrZSB0aGlzLiAg
VGhlIF9fbXVzdF9ob2xkKHJjdSkganVzdA0KPiBlbnN1cmVzIHRoZSBSQ1UgaXMgaGVsZCBvbiBl
bnRyeSBhbmQgZXhpdC4uIHRoZSBib3VuY2luZyBvZiBSQ1UNCj4gKGRyb3BwaW5nIGFuZCByZXRh
a2luZykgaXNuJ3Qgb2YgaW1tZWRpYXRlIGNvbmNlcm4gaXMgaXQ/ICBXaGlsZSBJDQo+IGFncmVl
IGl0IGlzbid0IGlkZWFsLCBpdCBpcyB3aGF0IGl0IGlzIGdpdmVuOg0KPiAxKSBORlMgY2FsbGVy
IG9mIE5GU0Qgc3ltYm9sIGlzIG9ubHkgc2FmZSBpZiBpdCBoYXMgUkNVIGFtZCB2ZXJpZmllZA0K
PiAgIHV1aWQtPm5ldCB2YWxpZA0KPiAyKSBuZnNkX2ZpbGVfZG9fYWNxdWlyZSgpIGNhbiBhbGxv
Y2F0ZS4NCg0KT0ssIHVuZGVyc3Rvb2QsIGJ1dCB0aGUgYW5ub3RhdGlvbiBpcyBzdGlsbCB3cm9u
Zy4gVGhlIGxvY2sNCmlzIGRyb3BwZWQgaGVyZSBzbyBJIHRoaW5rIHlvdSBuZWVkIF9fcmVsZWFz
ZXMgYW5kIF9fYWNxdWlyZXMNCmluIHRoYXQgY2FzZS4gSG93ZXZlci4uLg0KDQpMZXQncyB3YWl0
IGZvciBOZWlsJ3MgY29tbWVudHMsIGJ1dCBJIHRoaW5rIHRoaXMgbmVlZHMgdG8gYmUNCnByb3Bl
cmx5IGFkZHJlc3NlZCBiZWZvcmUgbWVyZ2luZy4gVGhlIGNvbW1lbnRzIGFyZSBub3QgZ29pbmcN
CnRvIGJlIGVub3VnaCBJTU8uDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

