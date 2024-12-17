Return-Path: <linux-fsdevel+bounces-37677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC929F5A81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 00:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF7418856B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2851FA826;
	Tue, 17 Dec 2024 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="P6byi3/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445F38F9C;
	Tue, 17 Dec 2024 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478415; cv=fail; b=gYMvHO4YNcN2+ujAAjMcV5VmaXCX55UdfQg+mLnw+3Sz9tFbEhtj5IHTskxbwxmk96J60NlEAvElB7iCgjRrdpkx+Q5U7s/uHhdWqw/6tFzqMPK6if3PChv/y6w1fAlUxV/7dk9gQ4n1gNpqK4vMRApM0a0iJsaAOKQ3fiULtqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478415; c=relaxed/simple;
	bh=RjcV14QmRmzyp2plDmSVHtGLPr36iRDBn4xNUyIQk+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sh0uhjKm9kDhJB2loHNNx2LIRYNgevn3JgbVBMxdfgu2j016Xv0tz7VB/VJNv+CZ/aHs0f0FtlFeu4VdjNX4cmsWXSRY4XeZcBZCU3VIozsOAYkoP6GmKhmxjiHk1gk0y0wZnNr87AlF4WUcY4j87OgEljmxn+Za95VChHH/Kwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=P6byi3/x; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4BHMr1Z4025573;
	Tue, 17 Dec 2024 15:33:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=RjcV14QmRmzyp2plDmSVHtGLPr36iRDBn4xNUyIQk+0=; b=
	P6byi3/xk6RLMKjZP/q/ss3pKuxE2mfgwR/6ZnXO3cqj/rQE6LusK2YdP4/R/TVs
	w5V8U6vI6s7EWtRQFUTHTDdK7vwkm9Xl4jMylhQ+Sy/GApXVbpMLckEKbNTEJto9
	o1zT+DXTIvjkYSsPSBNJqpMwMA3hm5PM4r1iroHmzDhyScnS566A4kWQTXp9YWn8
	l5CXOeEiSBEBUwQE+67P8G8cPGofrXB+/GNzaPM6tkPSqjrDGwIzgQgYQyrRrjTM
	8bGC+CP82ISKd5eOuctDkjQ1bwXnjjnUMSsurGHubRVsQ07jUonjz5gwp6pScMSM
	Gom4W8fB7HYxlxoBgB1Cfw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by m0089730.ppops.net (PPS) with ESMTPS id 43kjg0g7uu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 15:33:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNmfUm7oVZAq+5UldSBDRPwAkkQjA57kaSdZ6iLVl7HftL/YW4T3Zr4QNWoJibJ6bN0r1vVzueUl+TBRd7bCR9YHEY3lTz6PNNQKXQL1C5cWHSHV9Z5HFNh+piyvOsuPdhHULQQVDxXQTPt9cRtFKHK0KArZWoBeNBZ6CDt/PICfsMClKzJqy0fyF71YEy8atPVMVEKeqVwN3qB9YtXavHBcMNTRUgyKy1r6B0UqEYoYlRmPuKEqiU8NOhUBPrLVx4zNkQS/fefIO0n/K4muefvCEuwFPCR5/cN9zJtjOxpTeoMhuJ3B4ZdUDxDTxfPJnRD8BxURmxZswS539Nf3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjcV14QmRmzyp2plDmSVHtGLPr36iRDBn4xNUyIQk+0=;
 b=Otg6eIpIee9bbicLkeS0AcByfCfnpWB8xnuRgCoaMhckbcZ4vdG/rnFuHTQPbTjVi+71LXf8TBxF24H2R3C1DmbrRcOsUW+Tl5BgcSn/dHdWln7mWs+kuYFyf4a4Lng5gxTotSD71uuK5o6hFp54n5xWNCBI6e8g+dCSSpc4HhO/lXfut08odQKh8uD7WSnNt1DYdnatGp2lYxZA+iDESPFpM/662zGCsgnP+TaATDAW9Je55SyNBgFhbBNNtFq0dN5YPY3H2jgvUKtyi14E7QWdK4HsBbNcsO5QWEnP+EGHTdrclROPN7Wh0Dzs0qgQL0FOErTfvTtak88mmYDOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH7PR15MB5256.namprd15.prod.outlook.com (2603:10b6:510:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 23:33:29 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 23:33:29 +0000
From: Song Liu <songliubraving@meta.com>
To: Paul Moore <paul@paul-moore.com>
CC: Song Liu <songliubraving@meta.com>,
        Casey Schaufler
	<casey@schaufler-ca.com>, Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com"
	<eric.snowberg@oracle.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team <kernel-team@meta.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
Thread-Topic: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
Thread-Index:
 AQHbUMHZ/pEEoDutDkiUOsUV91UKILLq8+2AgAAIjYCAAAEqgIAADAaAgAAIRACAAASoAA==
Date: Tue, 17 Dec 2024 23:33:29 +0000
Message-ID: <6E598674-720E-40CE-B3F2-B480323C1926@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
 <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com>
 <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
 <CAHC9VhRWhbFbeM0aNhatFTxZ+q0qKVKgPGUUKq4GuZMOzR2aJw@mail.gmail.com>
In-Reply-To:
 <CAHC9VhRWhbFbeM0aNhatFTxZ+q0qKVKgPGUUKq4GuZMOzR2aJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH7PR15MB5256:EE_
x-ms-office365-filtering-correlation-id: c0f92bcb-0d22-4bf7-a9ec-08dd1ef33631
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnRKd3pVNkxYUDFQbWZTcUhQbWxNMi9rcGk2OFJvMVFSZTVnMnJmSkdZZEM5?=
 =?utf-8?B?Q0JuNjZaUnprZHlQaUdmbDl6RkRtM2lPUVZVanNRaSt4UjZXV2FFbGMvTW9a?=
 =?utf-8?B?eGZrZGtkeWwxNnIyNGt2bks2MTVUTGRkeXZDVWFnb2g4NFF5R3crcFk1Tklz?=
 =?utf-8?B?TWUrQy9uL2NLZjJibGVNVEhqbFBKNHJKc0dIRVlNNFZYUHRTM3d1ajFaQnBk?=
 =?utf-8?B?YzFuNUZ6OHNEeWNMSFVVTEpnUEJjV0NkMnBCZmp3aEdOVFpNSlRHVEhyR3Iv?=
 =?utf-8?B?NE5RbFpmK2t5WEVBTC9wZUJTdEFvVUJqd0prVlNZb3NNVHZqb2tORHJIaTNv?=
 =?utf-8?B?bWREd2ZlK1lvTnJBOXNhZVVkZFYrTWMwYTNpaUtpK0x1NWsyOWVQeEVKeVVl?=
 =?utf-8?B?WnUxL016MkVtc241SlVTWTR3QXpWakt2Snc3NVlwZzJhQjN6ZTkrZWJKYlR4?=
 =?utf-8?B?OUpqV1RBd04xQjkzZlBmQkoyVjg5eWRyd0tHSm5rd2pIVXowVWhnMmtUOEtn?=
 =?utf-8?B?N0hPSHhvQkpKYlo3ZmZUMlcyWUI5YjFsK1N6QWRYTGdTVU1ndzlDcmtEc1cx?=
 =?utf-8?B?aGxtYmVpRmJlL0Rla0wvTGczU1VvQmRCZlQ0TStlQlFGNDVKdkFCdkJ1WTZG?=
 =?utf-8?B?Z1AzMVJ0eHR2QlZVY2JLSXc5NHRsZjFRdmh4S0FqWWZGT2VCcm1SREswbGdx?=
 =?utf-8?B?VXhTUnJURVpUSGxDa2dZL0NGYllXZEl2SUN4d094cEJLeUxlZUZCV2VQeG5O?=
 =?utf-8?B?RGJLU1dlK1lKUHhvbWFQMUJ6clhPMlY5WGx0bmZ2bk40dEdybGljdE9KMVFY?=
 =?utf-8?B?ckRmSFhMaWxjTGkrMFZMSms3Mnprcy9CRUhXeXdLUDcwdTErK3A4S0dETlBH?=
 =?utf-8?B?Z1UxdHVONFdsSm0wa1ZPdzlHMjgycC9IY3Y1ZmwxRWlMZjROQzB2cG1ubm9Q?=
 =?utf-8?B?cXBmM3R6OEdZWGZMVHEzU09vNG5XV290czlSN1Fyc01yN0hGMGcrYkc1SjJi?=
 =?utf-8?B?YmNXUlBhQm1IS0RJL3VjeVYwb0JIWDNLSlF6N1haMWRSWGk0dHVXRnBEV0Zk?=
 =?utf-8?B?VmtkenVlTGVPaGZDTUN0d2ZCTXUrRjlYT2VybHM3K2VBNkdReXJYdklyOWVC?=
 =?utf-8?B?VzhLSEVGY3BaVk1Cd3dDSUxzWWtEV0RvL21TVEhNNjYvUVBWYjJWbnNDb09y?=
 =?utf-8?B?eC9HK2ZBVFdqZytJcnpTdlNLUW9jWlNrL0NzM2lkcFFUQkh2OS9IZW5GRnRS?=
 =?utf-8?B?L2YrK01VVDBjQ3ZNYXFOaEVnb1RzbW1xY3RHL3ZFaHpjajIyUThxazBxcmRJ?=
 =?utf-8?B?WElQV3k2VzlWeDNZQjJMMGd6YmdMOFBwZ1hkcVNuejJuNjVHWE9Ec1pxU0dn?=
 =?utf-8?B?Q1IzQlJiaTVKdk5lcUV0RGdLWlczRWFmbFQ1ekV6dVY5Tnpud1hiVGlSNVBz?=
 =?utf-8?B?ZWZIRGhnMUw0TTdsZlBCOC9ma1ZrRGpoZS9wUGMvUWpFOGo3V2tnN2xJSXVP?=
 =?utf-8?B?MWIvZmt6aXJDeTVxZmlrd3lwZ091TFFxaDl1UlNmUW93a1dpYlY2aEtQeWVB?=
 =?utf-8?B?eFZnNFg0Y3RQSk9JUEkwUEFObHA1K2x0eThSdTFLWUx5dnV2VFdObUo3WXAy?=
 =?utf-8?B?ZzBNRHd1Rjh5c0Y2aU42KzFtK3dob1huUWlzcnVESTIvMjJNU2RJY2Y5eTdV?=
 =?utf-8?B?c1BRRS94UG01N05kbWpnbmJKdnY3SlZSd0JWTk52ZmZSSndRMDBLK2RzZXR2?=
 =?utf-8?B?NkNtanRFUWdXNVI4ZkNDa1RWV0NhY2doUEIwQ0VYOVllbTVpZ2VMOWYwVHBC?=
 =?utf-8?B?THBTS0ZqVHlmS1paUDNydTI5V2lnL1Y3d2FGcnlHb2lqS1d2TG94dld6VkVF?=
 =?utf-8?B?RUFlRkFPbkFmdE9uOUZ4Ym1mWUdVMnJXS1QwVGhhUjRaS1FKRHNqUno5c1pu?=
 =?utf-8?Q?X5K4qCwAN0H+LDCcKn2VpPb7tiGP1Rrk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFRxWnFlVDZuRlhCY1dWaTVLTGtURHZrcG9HZ2g2bWt3dXNlOEpjRFdsUUl3?=
 =?utf-8?B?UzR6dE54STVCdkFQa2ZMbE9IS1puL2U2d1F4MzNIN0lER0hlNkNZS2FZOFJl?=
 =?utf-8?B?dG0wV1JoS3dxSUlOai83REFpWGwwa3BSNUlGNVgwa2c5bml4RUcyOElJVGtM?=
 =?utf-8?B?bnNCVEdrYlV3by9uNmNxVncySkxpWGo4L1Nzd3hBYllEUGhPOS85RTNibk1U?=
 =?utf-8?B?UkJEL0hjUHVLTDk5UWVJYnA3RTl3MGphL2lEM0w4L1JVMkJOMTlLOTNTRGVh?=
 =?utf-8?B?TzRmOUZ6bjZrd1U3eEFTYmsxeDVXU1k2M1VlVktQY1VMT2FFR1V2aFFxY3Ja?=
 =?utf-8?B?c2Frbmp3K056dFp1eDF1Smo5SHY2dXd0akNGWlFWV2hqcUlDSi9ycnB1YWpI?=
 =?utf-8?B?b3pnbmgxcXR2L2F3WHZ1M2R3dXpLZ1pQVDU3K3JlTENyWjJONFV4VlVuQ3ZN?=
 =?utf-8?B?M2R2eGdUck8xcGJPY2QySkpLd2p3L0dWSDJaKzcxdWk3R0tVbldXTEk0SU55?=
 =?utf-8?B?N3k0TEt5SjQ1R2lHVU5QVlJ1MVBseEtEek9PWnh3SXUyWXdTSnZTZWY3R2t6?=
 =?utf-8?B?ejdlM05QWXJHTUlCNVVuVUNJdzdwTlZRbDB3T25MNjVLRCtRSmxaTTBnSEpq?=
 =?utf-8?B?TDVVckt6QWZ3RitKeFZkbUhEMms1MUxodHNienBSVm4vS2V6NE1MYWFmWWQw?=
 =?utf-8?B?M2JFRFRiK3NuNkd1MnJEaVE4a3hCT1VDUkdGYjNkRnBIekNGVjZQMTIwZW9X?=
 =?utf-8?B?SFFEK2p2a21uaXhOMHgyb2J2eGkzdWZiRG5EUkhVeXJKMk1CZy9FMWtkVmFM?=
 =?utf-8?B?c2poR3lrZG96NVROcTVhOGRTRHhIR3RpVXp6QkRNZFZIZkpCdkFqTkIrWVRZ?=
 =?utf-8?B?TE13RThvTHhaNGxKaGZONWU0QXBhQU4rakt5THpXaVJieHNJR1hHTlU2ZSts?=
 =?utf-8?B?L2xGZDdUUy9yZTBBSldwNFl0OU9FSXVvWXRRQjhUSnd2Qm1OQ1JWUGhFMHlx?=
 =?utf-8?B?OEtjOW5IZStiMmltb1BuVFJleU1BbDJ1V1Z1Nkg3R3cyK1FXbERGc3JFSERu?=
 =?utf-8?B?VFprRXNEeW00SlNkOThKNkluYmxIWXZZcXFYNTdNQUtaWDlmZVdiRTlHVHpD?=
 =?utf-8?B?SGE0STVNb0xBdkhmNFFtSVZXYk1UMWxuM1l2S2dsbVEwZkNod3JEa1RIcWI0?=
 =?utf-8?B?Y2RlS25VRWI1N3d3Sk5sTXRuK1VKeEI4RHpNMjdsVTlhYXl1MXNKM0dxUlRF?=
 =?utf-8?B?MHk1aVBmNDlEa2d5Tm83RTRtVFpETktpWE1EcnFFdEFCenV2UEJJYmNiellT?=
 =?utf-8?B?RWxxVDA4UW45UU9KUXVlMmJybWQyc2dXZmEranlvdTNtT2I1V0xjNHErTE5m?=
 =?utf-8?B?UVE2RkVMbjl4bVlteTZ5RDlIa2haY0Y0UDF6Tlc1Tko3MlJJdjRLT3lMSTZh?=
 =?utf-8?B?UEticDBoWGZ1OWt2UHpIcHN6QXVvd3ZSNmdOdTdJR0xDMDYrSllFV3RRNU9l?=
 =?utf-8?B?bkQ3Y2pvSy9nZHVNdW1ZUHhoRlNFc3FXLzJrV09aWDZpV20wR0VvMnRmMXJ2?=
 =?utf-8?B?VFJJVGV6RHE4eHNjb0FlczFJc1JOU3pndVg3eU1KOVVsOXNWTnFJaEpiOWo4?=
 =?utf-8?B?aXpkK3pjK2RiYTU3RTdQMnc0YkNwZGJ2MU9ndWNBK29GNlhBL1gva2JqSm5W?=
 =?utf-8?B?NlJBY0tZOGV0T3puVXhwUjFRdDcwanFxWlE5dnVjT29UVmhlTVpMYXpMMDlR?=
 =?utf-8?B?blp4MkFYOU9zL2hQSjF4SVBqemVySEY4NXpLZ2VRWmVWNXRZc1ZiMENHbjQx?=
 =?utf-8?B?NWRKaEthNHhOZTMwVUtvYjlkdmdmWWRoMGNYSEh2VWdwMnUrMG9yUHk1RCtl?=
 =?utf-8?B?eS83aUpCRHVSRjRodlZqSVpTYTNPQ3lmQlRtcG5jOXEwY3NTK3I0Y2YzWmJD?=
 =?utf-8?B?dzRrMnM4ZWRjSS9DZlIzVHpWc05WaUJrNmFyVzF5VVg1OG00cnp4S25jc1Yv?=
 =?utf-8?B?cTNjdEJ1WUlMSTRLTTNqOWJIUHZ6ckVOZWQwVGp5Y3FVTTZFRWxYNjNpVjFv?=
 =?utf-8?B?UmJGNzRXWURTMDZTVmw0NlVCWEpsaHBZTmMrNDk4YWtrZHlYWTRBYWRwbDg2?=
 =?utf-8?B?cDNRbEREWHQzTktSYWtYUVRjcWZudnluZFBSd2pQK1Npc24wVmpGT3BQekQ0?=
 =?utf-8?Q?yRRcYKwebV6nbRoYxK428kk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02D4BACFB41CF348A6A1C2035E996AE5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f92bcb-0d22-4bf7-a9ec-08dd1ef33631
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 23:33:29.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNGPQZI4FWcanGr7lEB00bC7m/qDdvFE6zqcJXIOgMkIRKPYjdxYq/+eTOreyHt04CggiQtWszLh+0oPhoOl3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5256
X-Proofpoint-GUID: hb8_cRc6aJ8Joofi1KrWuSjMzdwik7OI
X-Proofpoint-ORIG-GUID: hb8_cRc6aJ8Joofi1KrWuSjMzdwik7OI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gRGVjIDE3LCAyMDI0LCBhdCAzOjE24oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBEZWMgMTcsIDIwMjQgYXQgNTo0N+KA
r1BNIFNvbmcgTGl1IDxzb25nbGl1YnJhdmluZ0BtZXRhLmNvbT4gd3JvdGU6DQo+PiANCj4+IElm
IHdlIHVzZSBsc209IHRvIGNvbnRyb2wgaW1hIGFuZCBldm0sIHdlIHdpbGwgbmVlZCB0aGUgZm9s
bG93aW5nDQo+PiBjaGFuZ2VzIGluIG9yZGVyZWRfbHNtX3BhcnNlKCkuIFdlIHN0aWxsIG5lZWQg
c3VwcG9ydGluZyBsb2dpYw0KPj4gaW4gaW1hIGFuZCBldm0gc2lkZSwgc28gdGhhdCBpbWEgYW5k
IGV2bSBhcmUgb25seSBpbml0aWFsaXplZA0KPj4gd2hlbiB0aGV5IGFyZSBpbiBsc209Lg0KPj4g
DQo+PiBEb2VzIHRoaXMgc291bmQgdGhlIHJpZ2h0IHdheSBmb3J3YXJkPw0KPiANCj4gSGF2ZSB5
b3UgdGVzdGVkIGl0PyAgV2hhdCBoYXBwZW5zPyAgVGhlcmUgaXMgdmFsdWUgaW4gZ29pbmcgdGhy
b3VnaA0KPiB0aGUgdGVzdGluZyBwcm9jZXNzLCBlc3BlY2lhbGx5IGlmIHlvdSBoYXZlbid0IHBs
YXllZCBtdWNoIHdpdGggdGhlDQo+IExTTSBjb2RlLg0KDQpZZXMsIEkgdGVzdGVkIGJvdGggdGhl
IG9yaWdpbmFsIHBhdGNoZXMgYW5kIHRoZSAibHNtPXh4IiB2ZXJzaW9uLiANCg0KPiANCj4gSSdk
IGFsc28gd2FudCB0byBzZWUgYSBjb21tZW50IGxpbmUgaW4gYm90aCBwbGFjZXMgZXhwbGFpbmlu
ZyB3aHkgaXQNCj4gaXMgbmVjZXNzYXJ5IHRvIG1hcmsgdGhlIExTTSBhcyBlbmFibGVkIHByaW9y
IHRvIGFjdHVhbGx5IGFkZGluZyBpdCB0bw0KPiBAb3JkZXJlZF9sc21zLiAgU29tZXRoaW5nIGFs
b25nIHRoZSBsaW5lcyBvZiBvbmx5IHBhcnNpbmcgdGhlDQo+IHBhcmFtZXRlciBvbmNlIHNob3Vs
ZCBiZSBzdWZmaWNpZW50Lg0KDQpQbGVhc2Ugc2VlIGJlbG93IGZvciB0aGUgZXhwbGFuYXRpb24u
IEkgd2lsbCBhZGQgZGlmZmVyZW50IHdvcmRzIGluIA0KdGhlIGFjdHVhbCBjb21tZW50cyBzbyB0
aGV5IG1ha2UgbW9yZSBzZW5zZSBhcyBjb21tZW50cw0KDQo+IA0KPj4gZGlmZiAtLWdpdCBpL3Nl
Y3VyaXR5L3NlY3VyaXR5LmMgdy9zZWN1cml0eS9zZWN1cml0eS5jDQo+PiBpbmRleCAwOTY2NGUw
OWZlYzkuLjAwMjcxYmUzYjBjMSAxMDA2NDQNCj4+IC0tLSBpL3NlY3VyaXR5L3NlY3VyaXR5LmMN
Cj4+ICsrKyB3L3NlY3VyaXR5L3NlY3VyaXR5LmMNCj4+IEBAIC0zNjUsNiArMzY1LDkgQEAgc3Rh
dGljIHZvaWQgX19pbml0IG9yZGVyZWRfbHNtX3BhcnNlKGNvbnN0IGNoYXIgKm9yZGVyLCBjb25z
dCBjaGFyICpvcmlnaW4pDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzdHJjbXAobHNt
LT5uYW1lLCBuYW1lKSA9PSAwKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGxzbS0+b3JkZXIgPT0gTFNNX09SREVSX01VVEFCTEUpDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhcHBlbmRfb3JkZXJlZF9sc20obHNtLCBvcmlnaW4pOw0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIGlmIChsc20tPm9yZGVyID09
IExTTV9PUkRFUl9MQVNUKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNldF9lbmFibGVkKGxzbSwgdHJ1ZSk7DQoNCldlIG5lZWQgYSBmbGFnIGhlcmUsIHNheWlu
ZyB3ZSB3YW50IHRvIGVuYWJsZSB0aGUgbHNtLiBXZSBjYW5ub3QgZG8gDQphcHBlbmRfb3JkZXJl
ZF9sc20oKSB5ZXQsIG90aGVyd2lzZSwgaXQgd2lsbCBub3QgYmUgImxhc3QiLiANCg0KPj4gKw0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvdW5kID0gdHJ1ZTsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgICAgICAgfQ0KPj4gQEAgLTM4Niw3ICsz
ODksNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb3JkZXJlZF9sc21fcGFyc2UoY29uc3QgY2hhciAq
b3JkZXIsIGNvbnN0IGNoYXIgKm9yaWdpbikNCj4+IA0KPj4gICAgICAgIC8qIExTTV9PUkRFUl9M
QVNUIGlzIGFsd2F5cyBsYXN0LiAqLw0KPj4gICAgICAgIGZvciAobHNtID0gX19zdGFydF9sc21f
aW5mbzsgbHNtIDwgX19lbmRfbHNtX2luZm87IGxzbSsrKSB7DQo+PiAtICAgICAgICAgICAgICAg
aWYgKGxzbS0+b3JkZXIgPT0gTFNNX09SREVSX0xBU1QpDQo+PiArICAgICAgICAgICAgICAgaWYg
KGxzbS0+b3JkZXIgPT0gTFNNX09SREVSX0xBU1QgJiYgaXNfZW5hYmxlZChsc20pKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICBhcHBlbmRfb3JkZXJlZF9sc20obHNtLCAiICAgbGFzdCIpOw0K
DQpCZWZvcmUgdGhpcyBjaGFuZ2UsIGxzbSB3aXRoIG9yZGVyPT1MU01fT1JERVJfTEFTVCBpcyBh
bHdheXMgY29uc2lkZXJlZA0KZW5hYmxlZCwgd2hpY2ggaXMgYSBidWcgKGlmIEkgdW5kZXJzdGFu
ZCB5b3UgYW5kIENhc2V5IGNvcnJlY3RseSkuIA0KVG8gZml4IHRoaXMsIHdlIG5lZWQgYSBmbGFn
IGZyb20gYWJvdmUgc2F5aW5nIHdlIGFjdHVhbGx5IHdhbnQgdG8gZW5hYmxlIA0KaXQuIA0KDQpJ
IHBlcnNvbmFsbHkgdGhpbmsgaXQgaXMgZmluZSB0byB1c2Ugc2V0X2VuYWJsZWQoKSB0byBzZXQg
dGhlIGZsYWcuIA0KQnV0IEkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBwcmVmZXJlbmNlLCB3ZSBjYW4g
YWRkIGEgZGlmZmVyZW50IGZsYWcuIA0KDQpEb2VzIHRoaXMgbWFrZSBzZW5zZT8NCg0KVGhhbmtz
LA0KU29uZw0KDQoNCg0K

