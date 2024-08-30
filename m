Return-Path: <linux-fsdevel+bounces-28052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8970D966377
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DD0281DAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05EF1B013F;
	Fri, 30 Aug 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fHb9r2Sa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mQSSIhZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440FD165F05;
	Fri, 30 Aug 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026109; cv=fail; b=FRQ/4HIgS1xKMm7WAdL9IcuXVThBiCFVaKBl3onsD0ArySiqmVRtOQte7pWsLLYEzJqSUUUZ3ALbGtTJcgFIWwaYYRj3RFmNp6TtoaZHFTNxTYDnTFnzB4X4x8O6WRHozWaPimq4tj3H6K/nMDBFvrBegffKk/oOruiuZhe8ByA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026109; c=relaxed/simple;
	bh=/ETsZw2gmYx/nBhgKVI96A4RdllwgqAytG4YWcg8lpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h67FsGxrCYxub8YdL7zfFv6YrMkJE3qxzlnRXWwYeevjYKTag/otMrGPiJFmzldaBjZxGVN0fUgZE9SFO/8z+emmVKtjI7I3dgB8KlBHP9kn56qDkVfTUanFnqXVm0dnTuwQBtm/14iEHCh5PBo2WiYrIQdgyA6PLjVRm2EkCwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fHb9r2Sa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mQSSIhZX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UDoWTF005536;
	Fri, 30 Aug 2024 13:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=/ETsZw2gmYx/nBhgKVI96A4RdllwgqAytG4YWcg8l
	po=; b=fHb9r2SaovWmwAiNMuTO+0PGeQyQc5uu7LTkh3hvz1jw0QAfnl5/3f7dP
	mCMB0mh1qnQg3VvjFiGoItLu1/6QzajdjHl3yqjq/JSIcfcma+uB1ZOzXJUYeOsk
	RJkbRASs3B5MXqrobemrKiNwczesHn2bEa4byXECyKQ8Ldt7jCO29ulwGAntfdz1
	oLTkRYoqti7WPiej3yIcY5OJ4ay08QKda2yMDKHvdMTeb0qoo1Iws6NN+L+8dW1S
	PgR7fm9DsKbUPSvlNwtVWLTiFYrpH69wJj3/WyclvfEWV73kFqepCOjcvtEFK0zo
	moAsatoY13XVzTjgX5di9Sl74HQsg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bd110am0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 13:54:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UDm3M6020318;
	Fri, 30 Aug 2024 13:54:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8rumpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 13:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pb1qT7DghkWQdj6cxvTKnY9xCMpR1nQMs5WP6ADJ77VmrWmWx5kc4tzsUdcBShtxMEHcPIZZZSOSrUPW5nkU6hJhjWbTy5Ac3dLTKty2K7c6C0xZ4BjvEPNwrZ+CoKymX6946dqxadTiSndoJSM6Z+kIS8sb+MvEi/aaHYgTrtE67Bl2+OiMsX7JGgONKtsYs7wxQ1wkJEjX8FENaBkbHPLVspk30Y1OygDAekKXEHRwXnsfBAkxgAVqWQ36Vp3xT4cUJPKa724Hm9dSTk7KE0dw358ta9ddB0Nj5IFk+rOlcIJEI8bAqVeY52hLhaORFwAsQXc9GmbsDYvxGwwj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ETsZw2gmYx/nBhgKVI96A4RdllwgqAytG4YWcg8lpo=;
 b=JW5+9XPvafIlGP0c1Z+p5s8+vygefyT0cShOtsd90myOdB0JrlbsFucXpPYX6Vuhzi49+xk8HYqkbXh2qY5TXCKXNLlH+v3ctupX6aG3pIzwPCk4mV5dHl7M1Hg+fjH7QDg0jt7bNP90Cb71zQggph4VABR/yYtjZ4o+fPIEtvtY1rgtq4M/Xz2T5RDh3BDNqfepoap40UsnRmfFVD/Zmi72ouXQTUlM0hHTCzU9sAn71qj2saAXus+tKVai6QTcg0Nkn//Uv5wo84hbjEcgByo8sP6bk/wb/lP1SPgtrk3fCe+9IRQZxcwzRfrYGm+i3FsDXcSN8i+vFbvflCqWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ETsZw2gmYx/nBhgKVI96A4RdllwgqAytG4YWcg8lpo=;
 b=mQSSIhZXkmfjNCTpVu8FGMJRUxlBPbkX4nbGLGsLmMkop29TBiJlYxjGbylHbecqQ9v82A4esY+1PCXMR19QRvGe0furK/4XNnVFPjCCLq3TieaQfqIZ9hkadKPz3/Pdei5fB7B+QP5BNkhgIwm4NDu4VMnfsPro2bqL39NCqXw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:54:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Fri, 30 Aug 2024
 13:54:44 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker
	<anna@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>,
        Al Viro
	<viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Tom Haynes
	<loghyr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 01/13] nfsd: fix nfsd4_deleg_getattr_conflict in
 presence of third party lease
Thread-Topic: [PATCH v3 01/13] nfsd: fix nfsd4_deleg_getattr_conflict in
 presence of third party lease
Thread-Index: AQHa+hcjYwakyZewUkqnKDMpbRr66rI+WQSAgAD2+oCAAIQogA==
Date: Fri, 30 Aug 2024 13:54:44 +0000
Message-ID: <278CB444-BBAE-411D-9B8A-A6C68FE29567@oracle.com>
References: <ZtCRGfPRayPPDXRM@tissot.1015granger.net>
 <172499770304.4433.15669416955311925812@noble.neil.brown.name>
In-Reply-To: <172499770304.4433.15669416955311925812@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7308:EE_
x-ms-office365-filtering-correlation-id: 55b84751-a807-49a0-d6ee-08dcc8fb4de7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHZqczhoR29jNzA3NElvTHNPa1hCNy9YQ3QxWlVZajVoOHQ4U2VJN3ArUUFO?=
 =?utf-8?B?OWFvNFhxMk54RkdiWERPeDFKV0FJUXFtTmMyL2JUN0psMWw5d1FhVmhVU295?=
 =?utf-8?B?WEFKNlpid0gxK0pDZXNYVWIrRGRPdnorVXA0NDhucDJ0aXN0SlVrNmtBbHdN?=
 =?utf-8?B?L3dWaUg2VjlLMFd6bEVLbFY4TFFWNTZCTWFtak92RmVOZFFUNzZlRnRydEp2?=
 =?utf-8?B?aWtVSklNWmw0V29rcFlUTEVHOE5ZUmtobE5zTE5zdW5NUE9sNlJWUTlvVlUr?=
 =?utf-8?B?KytRRmZJNmVEYm0rdzh0dUFWQlFzU2ZIQjI3UCsxUnJWY2ZtYVh4NklPYjQw?=
 =?utf-8?B?c2RKdWJwWDVEZjBsWHVJaGJWb1hHTjNUVXlpWHR1Q3pYb290TXo4OHl0WlBm?=
 =?utf-8?B?ZnVWSE5pZTdsOGpmT2YyYk9lbGRpdlJUWVpJYlUwUGl2OW5yZUZNQ3ZJaGhy?=
 =?utf-8?B?SHZyZU15R21JZmpVVkloa3BJMUhFVFhVdzAvNkM5YUM2MHBKaDdDbS9EdWFC?=
 =?utf-8?B?S0pBTkNTU2pMVTlyNlRJQkRPYm1oTjkzRWhEZTMvd2dGdlRRRG1PWDJZWkJK?=
 =?utf-8?B?MU0vN3VXSk54czBNd2VVVmlkWDExbE9PVmZXWHpqTFlGaXlKaURJWkYvV0xM?=
 =?utf-8?B?NGFNMm5DV1g3elJDbWhwL2ZkSVRhc202a3VSODErTVRzUzYrZ1p3eUs3dEhK?=
 =?utf-8?B?elFvczVrakc4cWlVTmgzWlJxRmRBNjdsdUl0RUU5VzRWa3pQaXkrMzd2M3N3?=
 =?utf-8?B?M2gxaklDQnFvUGQrS3N3QUJSeW9icktKdzJUZWdEREg2Y0oydUxKY3J0a3RV?=
 =?utf-8?B?SDVBZytjZjJNY3NJcnlDVk9zUEhITnZocHZxbzk2SWg2VlBHeUhvVzBzT2tr?=
 =?utf-8?B?cTY3OE1EYlVxcVJQaSsxMXVmaEZrSElFdkQ0dmlTN1Y5MlpPS3dhMjg4YVp4?=
 =?utf-8?B?T080TWVUd2dpNU5YMUtlUWd4RmdrNC91aG5CbzdVbC9pMEticVBZU2VIWUxv?=
 =?utf-8?B?Ukd2RHNySjAvbktZRmtpWmdXYjMxNW9qUnZRaFpxRTBhTnBYSUNOcUVYWFpB?=
 =?utf-8?B?elR4Y2d2Y1NoeDRzdFBSaUxuRVZvNFY5TUprZWQ2T21acG5NWlhXUnRVeW1N?=
 =?utf-8?B?NmlUZ0FLYUxjdHZmcG9rb29nazVscVZYdVMrOFlVM2x5SG9qY0FHclJkc1di?=
 =?utf-8?B?VXBjUGRXYTVlQVhyQ2tyNEZRenhUWWh3d2xjNVROL28vRGZXUnZJaWkzYmV5?=
 =?utf-8?B?bEttQk01NkVVNHV1cHAyam14eDRNNXRXN25SWVdEMGNYMHp0eFl1WUJOUFQx?=
 =?utf-8?B?cGpjY21GT1h6a1BhRHdNUUVQY3pWcXlNaFRWZERqa28xNUlQQ3poT0ZteU15?=
 =?utf-8?B?MnBXVVc0VVVBL3BxSFdDcUpEZkJ0MDlvK1pWRG5FRDBxRm15QzI4L3pzQ1pI?=
 =?utf-8?B?RXBlU3ErN25JR1c1Vm9Sem1BNmJYM0EzQnAwaHUwSzRvWEtQNUhYTktqdzU1?=
 =?utf-8?B?MWdrOWpRdUc1Z0w0QVppSmVuQkJmQXVZNVBWcTdQcC9mZVNxc0hMbmZWeThw?=
 =?utf-8?B?QzhJNHRKcldjY21pK3BaaTNKMDR1MmFldlJaT3ptd1gzNTRBUXRpZVF4NXp4?=
 =?utf-8?B?QVk0QnhybFM5eGRyM05rUldkK1JweXJISHhNTEl2RlhwVG05c1RrdGdvSDZq?=
 =?utf-8?B?UmdyY3FucVplNzk4M240cWt3L0VsZ2JBUnBHNEtNZExMQmFmWnN3VFMvM2Fr?=
 =?utf-8?B?ZUdQWFRzaUUzUHpVbTBRdW5IU0ppZXFSNy9UQk1hUzVuaWZreXFZbkl1QXhi?=
 =?utf-8?B?czlWdHk1T2hCWklSUU84UjZvWFVyNkVOWEowYzIzY0FNTDdiQlRvMU0zcVVu?=
 =?utf-8?B?L2xvdEJkK09qSStMd0NnWTE4MFZTS2FoWHRBT1EwU3pBaHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnFtQ2NJV2xOalN5QkhMZUM0c3A1NCt2SXJDQTlaanpWZ1BVUTRBMTJ4SjdL?=
 =?utf-8?B?dHgzWDNuVDJhVWEvaXFVUkxtWTdQdDVwby9uMGRkSTVRa3NUTjRLRTFQcEJj?=
 =?utf-8?B?V1dPTHpIRzVuR2tkLzJESjN5dDJiQXJVWFVleDFBbkRzVmdFeGlBLzRRZ0pS?=
 =?utf-8?B?ejBtcXUxRS9ZdWpNeXJKNVVCMFpMNkRuU3lSQnEzRTMrSG5nWVNHdnJ0WGEr?=
 =?utf-8?B?SzdnRzV3NW1DeTd1VVlidFZXUzA1YlpVU093VUxWT2JRZm1nNER4MnpIWFB1?=
 =?utf-8?B?VVZycTdlSmw4K0Y5Z1lBS2oxMWwrOWxrU1pnVWhpY3ZUU2VzOUUwcnR5Y3VY?=
 =?utf-8?B?eXBYc3dBMGI4bldNQ0tJSjJ3b0VWc1NhS3p6M1ZXWUhmUGM2WXYrR2E0RzVh?=
 =?utf-8?B?UlRtTWx1SHpBRWc0NVBMaUZtK1M4TXljYnMwd2RjUkhac0dWM2pMZW9pdFlC?=
 =?utf-8?B?dHBYb3ZaMW1FSE40S1lVdFZNMDk5bXdKdU5zeEhDQ0tZZVk2c2QzYkswbGk5?=
 =?utf-8?B?NzUzMnR4L1Z6ODkrU1E1ckgvQ3U2MFBlYjNtSlFCcHR0M2puZ1hqQXBkd3No?=
 =?utf-8?B?SWlzVTRRY3NMd2xXR1Jra25Uak4rV3o0MlQ4WWRaNTRTeGxqRE5FM21TTjE5?=
 =?utf-8?B?Zk9BWjlkT0NXZjlVQVZOZWRjR0JQSUtOcURvbEpuTGlhODRHSy9UbklQaDd3?=
 =?utf-8?B?VEEvcFBzcTJDNElMWG14b3hpSVBQb3lqVXkycUF3ZGVzODV5MnVJY2lZazFH?=
 =?utf-8?B?S1RueUdQLzcxM1NYbHdSNnJaUW9qb3BlRyt5d3V6aFVudTBHS1pjMlhHWGpE?=
 =?utf-8?B?dWNRTUtaS2tPUlBqRXlKb0l4WU9PUHh0TzMrNGlwWjBvQlptekxGcXRQbTFa?=
 =?utf-8?B?dkNKb0RibHJ1dG84VlJXR0tpcTRXWFBqK0pKWENSZDVZbW1WeG9kNmUzRkJk?=
 =?utf-8?B?TWZNbXhCcFplMUw5bS95YjlFUjRnRzZ4c0x1MGYvTHluc1NCcDJ6RmFQZ2xV?=
 =?utf-8?B?Yy80TjQwOFhwaG5DMDZLMmdqblUzaXl4d1hJN29obEMzbWFTUnBPVjBYZkRq?=
 =?utf-8?B?TUZqSU1TN2FBYVFtZDRBWWJtaWNBRm4wYm9MVTB2c0FaT0Zhc1NlZDY4SU02?=
 =?utf-8?B?NWducEFCK2JXM0UxOXRuNkFQTU53Q1hGRUtnQUU0eGNYQkczakZ4Y3BVOGNw?=
 =?utf-8?B?bUdIQVBiKzBCcDZpRlBoTG9jWDNBdlVmQ1ErcUJ2UW5ONGlvZ0t2MGpmL0JI?=
 =?utf-8?B?V1dSdnRtenFqVllxZXhhV1JYendFYm5yWmpMcjhwYWJ2LzVXVG1yU0ZEMTVQ?=
 =?utf-8?B?VzdOMHpyM20vbXhlSGVVUW41cCs0VVlnSXVTSzlveTBjajlPTDZQOFJ4NFhJ?=
 =?utf-8?B?aElUNktKRVNJWTFBQ1dNMUxDTWk3MHZPTHg3b3pnKzYyNEJSUE5kMEZpejZ0?=
 =?utf-8?B?cVhkb3NJUENPZE9scmVyUE5oUmFOeU1nSEVpRWNrT2RhSVpMNm02Vnp0eTF0?=
 =?utf-8?B?eVhoRExxWGZUMkovWWpMTW5OeUsycDAydy9ZMHV2ci91TTFDTnd6ZFpSQlpr?=
 =?utf-8?B?eHJJeUF5R09DT1JSRjRkQzZQWFFzYk1FOUUvWDFYdjlMazFHRzJnd3JJK3Fl?=
 =?utf-8?B?c1FaeVA5RnBFWmVyMlNHbTRvRldQU1lVcVlQV1E1QWVYMFFJUGtwYnNsckRL?=
 =?utf-8?B?Y085RGV6c21hQTFEUkZLMHFrWkV1R0pDNmlZcy9ZTytBTTlmNk53NnNtc1NH?=
 =?utf-8?B?OWo2bWtPdnU0VXB6OC8zaTJLblZTQ1lvVUhTdCtwbDhaRXRPWHdveUtoN0tu?=
 =?utf-8?B?WmlOY0RCYnlNYm9nRDVhMVE0WlhqVXY4dThLN3FzcmJHZWJXa0pCeSsvOWRi?=
 =?utf-8?B?V2JmUXQyelF5TjBlMzFZL2FERlRwT2hyb0h3SU9wRVlyS2dGYVMzNStUMFRq?=
 =?utf-8?B?b2pzcjRNYlV0c2ZpcWZtV1lNcnQyVHVHU1Z5ZWg0MUh4emhkZ2R0ZEdDWmY0?=
 =?utf-8?B?OERYMGdvbWhQU1ZLcEJtM0xuczJYU3RNVVdFNXlJRG9TSHNtQlNQK1E1TDJ5?=
 =?utf-8?B?RFpVYmMxN0RnUzJ6UUJnek16ZEtaei92WTBQTXlKZ3hBWjI4RVkyRDVKS2F4?=
 =?utf-8?B?bStGZjh2SmlBN0N2azJvQUxjRkZNRmljelVEVmZrZEF6dFQ4VHFyeDRHYU1S?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FD4FBBE43E42F47B129947866301DED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jQK++avwhaw4lsseckA9UMYAzltYjHn1ILMCLnF+QT83j7RNBPj3uUSGCKuMRxMWdoav2srhkLFbxnpAxYSdak40oOQ+46piWmiWUat21eFNIi93f+kN01eZmtXE2SP0DXDt4Qt5IBt8cSUctCdPUwhlPrcOybLaY/1Dm5WKCC+8OlzvNQkMAFgJGEFqb/JYrHkfC9OQPXgu00ojwr23i7FryFQgEGMaewMxAVYjSRjYOJJU/seuD+tpqypOQ/HXRwF9VW5rod6nYXev6qVXk4eFTBmH11DDz9s5FSPKxIUwUJ1GcEeuonpXeAIqGw0DR/IqVGKa/tZrq3/s4M9pY75xgewaBPl6ZRsvhyyU35LcajbNFt/+v9yRXP2uxBf01KiOiCKs0b4B0nUA2E8X/GmpIWq2VlJh6T4aWpv6JQrwnLg3c64XePOmII2TNEmGr72jhxNDNCIwr3CPr3z00vgQA2ZV5zeF578EvpSs9pXOkQjtxu9rAJVktLXn444QGtcUA807sPTxdYONeF14m70eC+G8K9W2IMktwVroJCrXBf1BEEIkTY0TFRStM1DcCSV7xTixmbWSOB/E5Fn41IYaI8FPwT+yIMG0Ged/FgQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b84751-a807-49a0-d6ee-08dcc8fb4de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 13:54:44.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWo5b0t5azxm01YIBf4tIoi4cfj/cOi6y1z/dGxq3wVu4NV1pRCJitImpUJ1EyJDvgvX/KnqMzUf0MpFsdfwMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_08,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=893
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300106
X-Proofpoint-GUID: wkDBJHLXrVOhqkfbitrrs0WycUvKgock
X-Proofpoint-ORIG-GUID: wkDBJHLXrVOhqkfbitrrs0WycUvKgock

DQoNCj4gT24gQXVnIDMwLCAyMDI0LCBhdCAyOjAx4oCvQU0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIDMwIEF1ZyAyMDI0LCBDaHVjayBMZXZlciB3cm90
ZToNCj4+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDA5OjI2OjM5QU0gLTA0MDAsIEplZmYgTGF5
dG9uIHdyb3RlOg0KPj4+IEZyb206IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4NCj4+PiANCj4+
PiBJdCBpcyBub3Qgc2FmZSB0byBkZXJlZmVyZW5jZSBmbC0+Yy5mbGNfb3duZXIgd2l0aG91dCBm
aXJzdCBjb25maXJtaW5nDQo+Pj4gZmwtPmZsX2xtb3BzIGlzIHRoZSBleHBlY3RlZCBtYW5hZ2Vy
LiAgbmZzZDRfZGVsZWdfZ2V0YXR0cl9jb25mbGljdCgpDQo+Pj4gdGVzdHMgZmxfbG1vcHMgYnV0
IGxhcmdlbHkgaWdub3JlcyB0aGUgcmVzdWx0IGFuZCBhc3N1bWVzIHRoYXQgZmxjX293bmVyDQo+
Pj4gaXMgYW4gbmZzNF9kZWxlZ2F0aW9uIGFueXdheS4gIFRoaXMgaXMgd3JvbmcuDQo+Pj4gDQo+
Pj4gV2l0aCB0aGlzIHBhdGNoIHdlIHJlc3RvcmUgdGhlICIhPSAmbmZzZF9sZWFzZV9tbmdfb3Bz
IiBjYXNlIHRvIGJlaGF2ZQ0KPj4+IGFzIGl0IGRpZCBiZWZvcmUgdGhlIGNoYW5nZWQgbWVudGlv
bmVkIGJlbG93LiAgVGhpcyB0aGUgc2FtZSBhcyB0aGUNCj4+PiBjdXJyZW50IGNvZGUsIGJ1dCB3
aXRob3V0IGFueSByZWZlcmVuY2UgdG8gYSBwb3NzaWJsZSBkZWxlZ2F0aW9uLg0KPj4+IA0KPj4+
IEZpeGVzOiBjNTk2NzcyMWUxMDYgKCJORlNEOiBoYW5kbGUgR0VUQVRUUiBjb25mbGljdCB3aXRo
IHdyaXRlIGRlbGVnYXRpb24iKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IE5laWxCcm93biA8bmVpbGJA
c3VzZS5kZT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwu
b3JnPg0KPj4gDQo+PiBJJ3ZlIGFscmVhZHkgYXBwbGllZCB0aGlzIHRvIG5mc2QtZml4ZXMuDQo+
PiANCj4+IElmIEkgaW5jbHVkZSB0aGlzIGNvbW1pdCBpbiBib3RoIG5mc2QtZml4ZXMgYW5kIG5m
c2QtbmV4dCB0aGVuIHRoZQ0KPj4gbGludXgtbmV4dCBtZXJnZSB3aGluZXMgYWJvdXQgZHVwbGlj
YXRlIHBhdGNoZXMuIFN0ZXBoZW4gUm90aHdlbGwNCj4+IHN1Z2dlc3RlZCBnaXQtbWVyZ2luZyBu
ZnNkLWZpeGVzIGFuZCBuZnNkLW5leHQgYnV0IEknbSBub3QgcXVpdGUNCj4+IGNvbmZpZGVudCBl
bm91Z2ggdG8gdHJ5IHRoYXQuDQo+PiANCj4+IEJhcnJpbmcgYW5vdGhlciBzb2x1dGlvbiwgbWVy
Z2luZyB0aGlzIHNlcmllcyB3aWxsIGhhdmUgdG8gd2FpdCBhDQo+PiBmZXcgZGF5cyBiZWZvcmUg
dGhlIHR3byB0cmVlcyBjYW4gc3luYyB1cC4NCj4gDQo+IEhtbW0uLi4uICBJIHdvdWxkIHByb2Jh
Ymx5IGFsd2F5cyByZWJhc2UgbmZzZC1uZXh0IG9uIG5mc2QtZml4ZXMsIHdoaWNoDQo+IEkgd291
bGQgcmViYXNlIG9uIHRoZSBtb3N0IHJlY2VudCBvZiByYzAsIHJjMSwgb3IgdGhlIGxhdGVzdCBy
YyB0bw0KPiByZWNlaXZlIG5mc2QgcGF0Y2hlcy4NCg0KVGhhdCBzdHJhaWdodGZvcndhcmQgc3Ry
YXRlZ3kgbGVhdmVzIE5GU0QgZml4ZXMgc2NhdHRlcmVkDQp0aHJvdWdob3V0IHRoZSBtZXJnZSBo
aXN0b3J5Lg0KDQoNCj4gbmZzZC1maXhlcyBpcyBjdXJyZW50bHkgYmFzZWQgb24gNi4xMC1yYzcs
IHdoaWxlIC1uZXh0IGlzIGJhc2VkIG9uDQo+IDYuMTEtcmM1Lg0KPiANCj4gV2h5IHRoZSA2LjEw
IGJhc2U/Pw0KDQpuZnNkLWZpeGVzIGV4dGVuZHMgdGhlIGJyYW5jaCBJIGluaXRpYWxseSBzdWJt
aXR0ZWQgdG8gTGludXMNCmZvciB0aGUgbGFzdCBtZXJnZSB3aW5kb3cuIFRoYXQgbWFrZXMgaXQg
ZWFzeSB0byBsb2NhdGUgdGhlDQpmdWxsIHNldCBvZiBORlNEIGNvbW1pdHMgdGhhdCBnbyBpbnRv
IGVhY2gga2VybmVsIHJlbGVhc2UNCmluIHRoZSBvcmRlciB0aGV5IHdlcmUgc3VibWl0dGVkIGFu
ZCBrZWVwcyB0aGUgbWVyZ2UNCnRvcG9sb2d5IHNpbXBsZXIuDQoNCiAgICAgIEIgLSBDIC0gRCAt
IEUgICAgICAgPDw8IG5mc2QNCiAgICAgLyAgICAgICAgIFwgICBcDQogIC0gQSAtIFggLSBZIC0g
WiAtIEFBIC0gIDw8PCBtYXN0ZXINCg0KT3IsIHRoYXQncyB0aGUgdGhlb3J5IGFueXdheS4gQW5k
IGdlbmVyYWxseSBpdCdzIG5vdCBhbg0KaXJyaXRhbnQgZXhjZXB0IGZvciByaWdodCBuZWFyIHRo
ZSBlbmQgb2YgdGhlIGRldmVsb3BtZW50DQpjeWNsZS4NCg0KSSdtIG5vdCAxMDAlIHdlZGRlZCB0
byB0aGlzIGFwcHJvYWNoLCBhbmQgSSBhbSBpbnRlcmVzdGVkDQppbiBkaXNjdXNzaW9uIGFuZCBp
bXByb3ZlbWVudC4NCg0KU3RlcGhlbiBSb3Rod2VsbCBzdWdnZXN0ZWQgdGhhdCBJIHByb3ZpZGUg
YSBzaW5nbGUgbWVyZ2VkDQpicmFuY2ggZm9yIGRldmVsb3BtZW50IGFuZCBmb3IgbGludXgtbmV4
dCB0byBwdWxsLiBJIGFsbW9zdA0KdW5kZXJzdGFuZCBob3cgdG8gZG8gdGhhdCwgYnV0IGl0J3Mg
c3RpbGwgYSBiaXQgYmV5b25kIG15DQpjdXJyZW50IGV2ZXJ5ZGF5IHRvb2xpbmcgKHN0Z2l0KS4N
Cg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

