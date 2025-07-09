Return-Path: <linux-fsdevel+bounces-54403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47101AFF4E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388B93A9BA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCDE248889;
	Wed,  9 Jul 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NM7sk61T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1718A801;
	Wed,  9 Jul 2025 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100891; cv=fail; b=mmbK342QFgMt8b5OkW/u+QVucJNe7V/wILerI+myMdPbFnpzB79wppmL+bCZbFIrWBwkt9FSPM/d8U4f+IizAPGonf2+tS1zuzgYcTNMIqagecTy28uMcO4Iy236RZFtvxtI5hk5DH7ZY7axWr1sqiD0g3/5tEyXgQvs0vtVsfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100891; c=relaxed/simple;
	bh=9UNvtnIovzsc4H1yCuGWLYHIxjo9TyHRDBNbeFwqCPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pZxp7jkiG99jvYnv5IWcswmts2EncoOKA5JYeSSMFCs1uwHWc8V5IKsu8kBtf041x56cPcAKIrMqkhl0oYftK9JFhjf93g4gik4FZBmnB92cq6EUuaWrMyubDJr0fmQekmX5OLiCMkArl0+BSUrL4rueJiAwfI7OjhhfSX2i85k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NM7sk61T; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569MOHj2009988;
	Wed, 9 Jul 2025 15:41:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=9UNvtnIovzsc4H1yCuGWLYHIxjo9TyHRDBNbeFwqCPM=; b=
	NM7sk61Tf3MA/5YLjSeYQO7F917cPL5Qh0faJUcGOnlryr2eGGCO+/Coq9iKCb1q
	lUxYZdegS+b6qaUBzayZIxzrecStE6GYOC4UgUC27B4nguGkcaBbCpzw/vDhYWIV
	TL12AGsf9lb/805za54r09zSsCcAYTykDvgqibgVAB65cZc7EzTe0y37UsBxoXnr
	e9bKzZ+agv/+jx4mDmMRvVByWolBHg/9VJnEKlDqDnUFNKJnUam2CSdXX4OZHe/9
	1pR+Zs1USZ+091ehacF72R6YqAu41Dj5wVKFcqheLKg/GkPu52eNo2ByCc4u8FLD
	a7omxrFuUEnCtZEKITgwfQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47t16dr33g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 15:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIUMpfTm0wPVkyRdwEgX2cdnyQi3q8MHxPHRcURTuLizAMzMkWt1kVvqax5KcD55/qXeFJdPgqg3BE0zOE8Z1YtHDEzFUY4khgpCKkpKaBzH1wHjfsYuMgqpbyraW6qjz0uy+4WdEdYpIR9Ett3/v1sksnj24Jbt8YH+M/6s2dbTlvK+DxSiEvMhUNKsSv4P3jVagv1F1rLjJKB+gQ2TcZSNJAY0UxcCh7Q1wOPNr0pc4IxtnQVRU7gHAqxMad16xy9+V94L3kyiGZ9Vi/CHHtdkTagdOClCHo8iRsEAocmHImsf9EfmUi09qABWGx5CHOiKDys9LeTEQhtfKP1+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UNvtnIovzsc4H1yCuGWLYHIxjo9TyHRDBNbeFwqCPM=;
 b=wGC6tEk/MhQdiv/UqD35cVRfBGCjrjzLmzahctPS6DG5FV5+E9k+EIIfXUhW2v/ijoLC+Iak2l5iVOcrfvuDioGvxUuOdm+/+WZSEM75yhA3M+KZYQ48WWUqP75CeCi/7UR4zQsu5OP2ogb3C0+zZz8MEx9ErGMhZYE78w8YDvcQRcuq9cc6jqEpk2JEB6+OerufCTZijbdAR8UJYQWHm5OFVjJBJ/Y3UoE0kRSf11ufTxYGjA+cFJqWXHWblDAs2lFxY0qFQwRe/DPCXGqpwZJFApgJrTgji46kmsG9Lt6fdP+7Q6nzG/YthbtMFl73K2J/3yDcQNtfKRfCYS3lVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY1PR15MB6198.namprd15.prod.outlook.com (2603:10b6:a03:527::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 22:41:07 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 22:41:07 +0000
From: Song Liu <songliubraving@meta.com>
To: NeilBrown <neil@brown.name>
CC: Christian Brauner <brauner@kernel.org>, Tingmao Wang <m@maowtm.org>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Song Liu
	<song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiAgACMg4CAEH8tgIAACIOAgAB+hYCAA125gIAAB3cA
Date: Wed, 9 Jul 2025 22:41:06 +0000
Message-ID: <A4F6961B-452E-4B0E-B7AC-866B27FA732A@meta.com>
References: <40D24586-5EC7-462A-9940-425182F2972A@meta.com>
 <175209925346.2234665.15385484299365186166@noble.neil.brown.name>
In-Reply-To: <175209925346.2234665.15385484299365186166@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BY1PR15MB6198:EE_
x-ms-office365-filtering-correlation-id: f8819bfc-7cd9-4dec-16f6-08ddbf39b19c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmlpMEdrdnkzdVQ2NnFlU0E0R0docUlzdEFvVllmWXczZHp3ZGJwVXFaN05I?=
 =?utf-8?B?UGw5aVNOci93NVE1TVA1S2VaTDFLQ2pvaDZ0TUNUU2RRdkNhclJEK2taZGNn?=
 =?utf-8?B?RExSTXd5ZmdUUk5XZVNnZUFFSkE2YzB4Yk9kejArQ1ZqMkFVbmoxRDR6L3Bs?=
 =?utf-8?B?VURKc2d5WFRxS1Z0Zi9jZmkwR3lTNmt0ZTFCM3ZvODdMc3RyVmlkdVk5aWNI?=
 =?utf-8?B?d1ltNngxQ1A2dURpRUhRLytLeHU4UDhGT1JoLzdMMU5GaS9PRXBIdFhtbHRV?=
 =?utf-8?B?aEFVSmxLSmpnZjBtd3ViOXNaR2RrSUNXeDVUaHlGMGNhZDBJdkJUenQ1VU5G?=
 =?utf-8?B?UE40VHlSYTFlVVZOSERNRXJIVkFMbUVIYWNSK0lLMlB3UkFSQVpqKyt5TEhV?=
 =?utf-8?B?MnIxbnFoditRRjJ1ZCs2R2VPRTJ3SWx3Q3prTXZ2Q1g3T3U2VUtjUlVsWjk3?=
 =?utf-8?B?UzVZMTRUQ0Z4TWFadTZFZXFtVXNZTmd2VnU0L2tCeFhScGN5K0VNMHFtaWhl?=
 =?utf-8?B?d1lPQVRTMk01d1V5NUZzaGNjUkJsUWl0cVhnZVdiQlpmenZtN3FUUnhQUmRw?=
 =?utf-8?B?MzBPVWFWRkNGZUlvcHVJaVhmMVN5dzZ6c0k1ckZrb3VGeWV0anZYUWt0V2xt?=
 =?utf-8?B?dGlVeTZBVkY2ajJPSmkzNEtJZmV1Uk5GbGJ4NlU3eW1seG44emRtcTB4SHBm?=
 =?utf-8?B?NmtkNzNxNUdHbHVsUGt3eGVPSkJWSkdqU2JYNWlkeUUzQ2syTE44NUszRWRm?=
 =?utf-8?B?MkIxdGtVYU02cFNVRjhLeTVKa2wwYTZiVkpUbC9tZW1FRjhaOEIycXltV3Jx?=
 =?utf-8?B?TXVaQ2QvRFhMVVZtMzdzeDhUc0dZbTkyK1h0b0pEUGNLaHhiYXZSSWxnYnBJ?=
 =?utf-8?B?K3FQN3B3OVlFYWpGNmVxcE00Q2R1ZmppK29WUWVaT2hWVkhxbGVLNWNydDVm?=
 =?utf-8?B?dG5vRG9jZnVTU2dJOWhVdUxnMGpxQnl2V1Vwb0FLQ1VxQXRLNmdwTTAxVGo1?=
 =?utf-8?B?cThHRDVCaEJLaEVhRVlROVJtM1JqTzMvK0NPQ3cvS21VN0RXUDhva1FoTXJx?=
 =?utf-8?B?YStObElBZFV2U2tNUDRNWEpiNTdaV1lKZURWWlFwa3dYcFo4ZytMUE1QcHRq?=
 =?utf-8?B?S3hiOHhseWZ6UlpHMnlINmZncXVQVHl3TG9JNnc5UGoyaHMxQmpRR3dBeFdI?=
 =?utf-8?B?VlBiTHp6ODhwRjZmVlFjYWEvTW5oL2JzU0UzUnR0NEk0cjYvTzd5eHlwWTF3?=
 =?utf-8?B?Qi91MlYxS0N2WFFWZTNTS0ZLM1ljMFNBam5DV1ZSa0ZwZWhyWVI3VENXanFx?=
 =?utf-8?B?RlY0VE1wWWdwaFRQZjVHUVgrRXNDOEhKb0VTSEhFM0lKZEVhUENMZXVjZk14?=
 =?utf-8?B?V1pydUg3MXdBRE1XNWRVR1UvWi96VzB2bWg0bDkwSVZpL3p4TFJqdkNOT3cx?=
 =?utf-8?B?QVNXallsVjRESWNISkRGTUc5RVFsU2ZDcklmc2JOZXRIU3VHalRIU0hVYXRs?=
 =?utf-8?B?K1hVZTJHMUR0TDBkOXUvQkNjVmRXWWdMWFpYWFBHZk1Nb3Azb3hNSis2aDlD?=
 =?utf-8?B?K3E2b1ZjR0R1bVcvcG5VL1FoV1I1a25JN2doWHdsN0RLaTcxU3lhSmJjc1pS?=
 =?utf-8?B?YnJRQWhRRmJTV1pTRXRkeGdPUmkrSUNZbWxNVEtFSjhyUUFqdEE2SXJsQ0Zn?=
 =?utf-8?B?aHJKR0JoMzhJQzN1ZExYK3A1T0gzVlovQU5KUUNnMzNndjVXVlJGQ3MrdWVQ?=
 =?utf-8?B?L0VDY3NXMXFXcWc0andLVjRMNE9kKzM4NE5BWWZYTzRlNTNNSUJJbHZyc3pX?=
 =?utf-8?B?b1lJZHlqVHBlcTdlLzRYWSt0LytLckt3RHEwSzNxQmRxUGszazZsdkdZajJH?=
 =?utf-8?B?empGUVVPaitwZ2tMMk9MSzJZZ1ZSdEVrakVubGpCK2gydTFHZlVzWG1nKzFZ?=
 =?utf-8?B?RG1vOExpVDBZd0RkU2pWOEJ6cWdKUkN5ZFlwL3R5MW1zcEZydUw5VTUvemJ3?=
 =?utf-8?Q?Q/CUfa3wrcNoU+pl0DBdjGMoNQSsdw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y09WZU1VN0IzVnhBRUpCUWVuR0FPWXJUSU1WUE44d2RBQitaVE0xbWdPUkpu?=
 =?utf-8?B?WmVUbTg5c3pScm0yWHpXRnkxMGNKd2ZsVklLcVFsT0JLc3FZOUdpTTlERWg0?=
 =?utf-8?B?TXNtVUN0RlZDZGhEeTNYNDNUMFhiclNBeUlLRTk4N09NNDZvRjlNQXUwWGpR?=
 =?utf-8?B?Qy9WRStVVzBFeGM2NEpFZ2Q4aTNodzJmUUIxVFBEblE0WFcwOVU2eXlXaU8w?=
 =?utf-8?B?Ny83aXF4U3NrK0U2RFZoRUl2bDhKUHZGMXM3bktUWXdzVk53VGp5amlVOGRJ?=
 =?utf-8?B?M2MrUlh0L1Y4YVJvbHQvQnJLa3p5Mzl3ZGd0Z0VNamhWbHlRYkNRMHhJU2R1?=
 =?utf-8?B?MGhoRGd2QzZ6K29CVExWVC8vcUgveUNlMnl0eDF0YTZheW11Vlc2R1JGYmtw?=
 =?utf-8?B?SGxEOTRqZDA3NGJkUXhnWDNCUTF2S0cxa2Z6bnRZNVBDVjBBaXRwb2FMRnJw?=
 =?utf-8?B?azFFZFhQaUxoUHFHeC9oSm5kUmp2SEhqaXFXQm5wVmFDN3RuV2VSSHhCUTBr?=
 =?utf-8?B?VDVQRWg4Qm0reG8zQmNUejlYZCtJdlhXMElBVkpWaDlPNzlPT3VadDdWaHlv?=
 =?utf-8?B?U0wva2JDbFlIRTg0VWQ0OXVaVFdpYk5PSkFTaW1aUXNjL2hCOU9JQjlRZVRN?=
 =?utf-8?B?OWdYT1Jva1VNc0gxd2RCcG1JM0dTQkVRdHBHdnFiTnZCMSt5QUo0b29rb1lx?=
 =?utf-8?B?ZWlYd3lVZmJGbjN5RTMyQVUyV0pxV0crUjRZcmJiUmdFZWs5ZlJMMXliWDFm?=
 =?utf-8?B?ZFV5Q2FURTFwWnc4OHByRXFDR0JQYjQzTXZ3OW1RdmhWTkRwa0FwbVN1N1Qx?=
 =?utf-8?B?MFZ6bks3cVNVWEoyQmQxMmx4emVPTEw5UzRrQXpFci9xbkRmYU0wUFdGMGpI?=
 =?utf-8?B?emRhaDRldTNXSWpNQmwvSGVkS0haV0NuTVd5T3FTMzEreUszc3NGQU5TS1Ji?=
 =?utf-8?B?NDFiUzVTbEc1OE8yUHc0bmY4QmhtVDJrRzA2L3l0MTZ0MDFFb2hZak95UkFR?=
 =?utf-8?B?dWxVSmRWYWduSkcxbmI5SkJhNG5Tb05ySXZzQ1AwV2dHOC9tL0tPVElGZ3dp?=
 =?utf-8?B?SncrWTk5T1BVUW4xUnk3YlpWL2tLSVQ4d1d5bjNsVzJOLzdvZzlwNFpjbzlN?=
 =?utf-8?B?d3hIYS9uZDlDL2FMb0drS1NkSXVxYjJia09iclB4V3pUY2pWVlhXZVpoZy9w?=
 =?utf-8?B?ZWtsKzlIdGhzRC9LbS9SakJKWUppdUtvekt4alBjUVhXa2xVR2NHU09VTjlP?=
 =?utf-8?B?aHk5SkFTak1UQ21valN2NERVSHdkWDNnSmVJdlp4VEorb2sxTUsrWDN4eUNL?=
 =?utf-8?B?NFJyYmJsOEpVTmloQi8vTE11a1pNOGZTbUVoYlIxaS91N29GazRKZFJYbHJL?=
 =?utf-8?B?S3JOcWhUUk5QNk5PSHFNV2NadDR6UDZjcjE4cUdxME5BM2JtWDYzeWVLOGt6?=
 =?utf-8?B?V3p0anBKWGRLNVF6bEUrTlFmK2lqOEpDOWFSL0NMOWxjQS9MWExoMk1WUmh1?=
 =?utf-8?B?akpDNVJkdFZ3T2VucWpFcUd6WVFWd2hqY3pQUWE0RFNmdU81a25rRWVCY1Zl?=
 =?utf-8?B?T0M0OG41RWJPRU13b3VkY3VLUFloSzhYZmhKU0lXNEluQ3o1dHhtRUJOSmlr?=
 =?utf-8?B?SldvSzB2RXNJZHJ2cjBOUG91eC96ci8rRWsvUWFSWUxXMUtwcGh5bUpnRlZN?=
 =?utf-8?B?eUZWcXNhVjZITlpvSTFrSWlucFB4eUkveXZDSzVzbUZzUXk5QVpsZ05jcmVt?=
 =?utf-8?B?WXJDbThWZVc2RXZmdVRXR08xQmpERHRCd2pkMmJ6VkRrODB1NThqbTY5ZzJx?=
 =?utf-8?B?VGpRRGVEMUZZTitaZG9yUFovY0Z1ZTJBaXF6RVhsNnJQOC9pdjJ3OUFNbEZa?=
 =?utf-8?B?Q09hWWZTRVE2Nkt0L3IyV2EzdmZhN0JNSFFjZGpOOU5VYUludGUwVjJGbW11?=
 =?utf-8?B?Z2txS0cwKzRYalFJM2hHVkNBeU5FN2hCR0YxSVBpVkdqNXdpWFNhcDgvbzFq?=
 =?utf-8?B?N3dZVEZRMmdVMXBSejVuWDZsVzdXWmh2Q085eldWcWQ5aWFDeU5IUnhCV2E5?=
 =?utf-8?B?TXRBN3c0bTFhV1lWcUtqVWdrREVub1FsTFV3SlZvZGlFTkQwNFR2dHduaXR5?=
 =?utf-8?B?alN5eHlQbFNvTmR5d001elNiV1hLQlExM0QyMFIxVlcvTVNmVTVOUTBXRUxm?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA0C70A0B377F7409E7D51FBA7E23A1D@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8819bfc-7cd9-4dec-16f6-08ddbf39b19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 22:41:06.9828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpUkFXmdUvp7r3D3XfLP5fZbfhXbChPUjz0Lvjic6e803jZYy4atSPa8N8pMLterEtIsYzkswjUw70vHOcxQjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6198
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDIwNCBTYWx0ZWRfX1XOO49HgY6uP 97DRDbz0FfbuC2u8+ZK5fu4DYPkj6I1jaJ8e5FjzDNCLx83YW8UgxGsZTo0qAXSI89fjpqHuB+D UAAsQ6GOz7SFC4T2HvvjCUe/rBy1LxC7nUbwJXA48WDdzfGxwTcxK+I8u68EyrCDjDA6Aa+F4Mx
 6fPQMfMx0tGUGF79SpAzGUhY0i1RDKE4l/dULTRYsgXqfk86iw2Wl5pgvQC+L9PeFEIdKlUfNdl KLMriYwZYo/uRZ7KNGUY4dPdO1kfLasdCArlhwGQI7DGaEEWGgRiKiPIjqER22o68RAPKGv9jOU +XymzvtgvbPTdjWPQ5OQl8w91vFyar6X6Wd4GQ7ZXnTb2xIA2n7wuC4NZLaEQEimXXGphuSbruc
 YxpEbzHi/qcCSxE6LGVfQsRJj346p7M4A0RfcNlm5l57LmyftbHXAxGx48uAlv6eMRL85+A5
X-Proofpoint-GUID: t0QwmcFKBb7NtuSKKj9kyRyCr3lXtI64
X-Proofpoint-ORIG-GUID: t0QwmcFKBb7NtuSKKj9kyRyCr3lXtI64
X-Authority-Analysis: v=2.4 cv=GIMIEvNK c=1 sm=1 tr=0 ts=686ef019 cx=c_pps a=D86mVN5QjxDervWfrEYqpw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=7f7GhY9J6SuzEkmtdcMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01

DQoNCj4gT24gSnVsIDksIDIwMjUsIGF0IDM6MTTigK9QTSwgTmVpbEJyb3duIDxuZWlsQGJyb3du
Lm5hbWU+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAwOCBKdWwgMjAyNSwgU29uZyBMaXUgd3JvdGU6
DQo+PiBIaSBDaHJpc3RpYW4sIA0KPj4gDQo+PiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMhIA0K
Pj4gDQo+Pj4gT24gSnVsIDcsIDIwMjUsIGF0IDQ6MTfigK9BTSwgQ2hyaXN0aWFuIEJyYXVuZXIg
PGJyYXVuZXJAa2VybmVsLm9yZz4gd3JvdGU6DQo+PiANCj4+IFsuLi5dDQo+PiANCj4+Pj4+IDMv
IEV4dGVuZCB2ZnNfd2Fsa19hbmNlc3RvcnMoKSB0byBwYXNzIGEgIm1heSBzbGVlcCIgZmxhZyB0
byB0aGUgY2FsbGJhY2suDQo+Pj4+IA0KPj4+PiBJIHRoaW5rIHRoYXQncyBmaW5lLg0KPj4+IA0K
Pj4+IE9rLCBzb3JyeSBmb3IgdGhlIGRlbGF5IGJ1dCB0aGVyZSdzIGEgbG90IG9mIGRpZmZlcmVu
dCB0aGluZ3MgZ29pbmcgb24NCj4+PiByaWdodCBub3cgYW5kIHRoaXMgb25lIGlzbid0IGV4YWN0
bHkgYW4gZWFzeSB0aGluZyB0byBzb2x2ZS4NCj4+PiANCj4+PiBJIG1lbnRpb25lZCB0aGlzIGJl
Zm9yZSBhbmQgc28gZGlkIE5laWw6IHRoZSBsb29rdXAgaW1wbGVtZW50YXRpb24NCj4+PiBzdXBw
b3J0cyB0d28gbW9kZXMgc2xlZXBpbmcgYW5kIG5vbi1zbGVlcGluZy4gVGhhdCBhcGkgaXMgYWJz
dHJhY3RlZA0KPj4+IGF3YXkgYXMgaGVhdmlseSBhcyBwb3NzaWJsZSBieSB0aGUgVkZTIHNvIHRo
YXQgbm9uLWNvcmUgY29kZSB3aWxsIG5vdCBiZQ0KPj4+IGV4cG9zZWQgdG8gaXQgb3RoZXIgdGhh
biBpbiBleGNlcHRpb25hbCBjaXJjdW1zdGFuY2VzIGFuZCBkb2Vzbid0IGhhdmUNCj4+PiB0byBj
YXJlIGFib3V0IGl0Lg0KPj4+IA0KPj4+IEl0IGlzIGEgY29uY2VwdHVhbCBkZWFkLWVuZCB0byBl
eHBvc2UgdGhlc2UgdHdvIG1vZGVzIHZpYSBzZXBhcmF0ZSBBUElzDQo+Pj4gYW5kIGxlYWsgdGhp
cyBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgaW50byBub24tY29yZSBjb2RlLiBJdCB3aWxsIG5vdA0K
Pj4+IGhhcHBlbiBhcyBmYXIgYXMgSSdtIGNvbmNlcm5lZC4NCj4+PiANCj4+PiBJIHZlcnkgbXVj
aCB1bmRlcnN0YW5kIHRoZSB1cmdlIHRvIGdldCB0aGUgcmVmY291bnQgc3RlcC1ieS1zdGVwIHRo
aW5nDQo+Pj4gbWVyZ2VkIGFzYXAuIEV2ZXJ5b25lIHdhbnRzIHRoZWlyIEFQSXMgbWVyZ2VkIGZh
c3QuIEFuZCBpZiBpdCdzDQo+Pj4gcmVhc29uYWJsZSB0byBtb3ZlIGZhc3Qgd2Ugd2lsbCAoc2Vl
IHRoZSBrZXJuZnMgeGF0dHIgdGhpbmcpLg0KPj4+IA0KPj4+IEJ1dCBoZXJlIGFyZSB0d28gdXNl
LWNhc2VzIHRoYXQgYXNrIGZvciB0aGUgc2FtZSB0aGluZyB3aXRoIGRpZmZlcmVudA0KPj4+IGNv
bnN0cmFpbnRzIHRoYXQgY2xvc2VseSBtaXJyb3Igb3VyIHVuaWZpZWQgYXBwcm9hY2guIE1lcmdp
bmcgb25lDQo+Pj4gcXVpY2tseSBqdXN0IHRvIGhhdmUgc29tZXRoaW5nIGFuZCB0aGVuIGxhdGVy
IGJvbHRpbmcgdGhlIG90aGVyIG9uZSBvbg0KPj4+IHRvcCwgYXVnbWVudGluZywgb3IgcmVwbGFj
aW5nLCBwb3NzaWJsZSBoYXZpbmcgdG8gZGVwcmVjYXRlIHRoZSBvbGQgQVBJDQo+Pj4gaXMganVz
dCBvYmplY3RpdmVseSBudXRzLiBUaGF0J3MgaG93IHdlIGVuZCB1cCB3aXRoIGEgc3BhZ2hldHRo
aSBoZWxwZXINCj4+PiBjb2xsZWN0aW9uLiBXZSB3YW50IGFzIGxpdHRsZSBoZWxwZXIgZnJhZ21l
bnRhdGlvbiBhcyBwb3NzaWJsZS4NCj4+PiANCj4+PiBXZSBuZWVkIGEgdW5pZmllZCBBUEkgdGhh
dCBzZXJ2ZXMgYm90aCB1c2UtY2FzZXMuIEkgZGlzbGlrZQ0KPj4+IGNhbGxiYWNrLWJhc2VkIEFQ
SXMgZ2VuZXJhbGx5IGJ1dCB3ZSBoYXZlIHByZWNlZGVudCBpbiB0aGUgVkZTIGZvciB0aGlzDQo+
Pj4gZm9yIGNhc2VzIHdoZXJlIHRoZSBpbnRlcm5hbCBzdGF0ZSBoYW5kbGluZyBpcyBkZWxpY2F0
ZSBlbm91Z2ggdGhhdCBpdA0KPj4+IHNob3VsZCBub3QgYmUgZXhwb3NlZCAoc2VlIF9faXRlcmF0
ZV9zdXBlcnMoKSB3aGljaCBkb2VzIGV4YWN0bHkgd29yaw0KPj4+IGxpa2UgTmVpbCBzdWdnZXN0
ZWQgZG93biB0byB0aGUgZmxhZyBhcmd1bWVudCBpdHNlbGYgSSBhZGRlZCkuDQo+Pj4gDQo+Pj4g
U28gSSdtIG9wZW4gdG8gdGhlIGNhbGxiYWNrIHNvbHV0aW9uLg0KPj4+IA0KPj4+IChOb3RlIGZv
ciByZWFsbHkgYWJzdXJkIHBlcmYgcmVxdWlyZW1lbnRzIHlvdSBjb3VsZCBldmVuIG1ha2UgaXQg
d29yaw0KPj4+IHdpdGggc3RhdGljIGNhbGxzIEknbSBwcmV0dHkgc3VyZS4pDQo+PiANCj4+IEkg
Z3Vlc3Mgd2Ugd2lsbCBnbyB3aXRoIE1pY2thw6ts4oCZcyBpZGVhOg0KPj4gDQo+Pj4gaW50IHZm
c193YWxrX2FuY2VzdG9ycyhzdHJ1Y3QgcGF0aCAqcGF0aCwNCj4+PiAgICAgICAgICAgICAgICAg
ICAgICBib29sICgqd2Fsa19jYikoY29uc3Qgc3RydWN0IHBhdGggKmFuY2VzdG9yLCB2b2lkICpk
YXRhKSwNCj4+PiAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRhLCBpbnQgZmxhZ3MpDQo+
Pj4gDQo+Pj4gVGhlIHdhbGsgY29udGludWUgd2hpbGUgd2Fsa19jYigpIHJldHVybnMgdHJ1ZS4g
IHdhbGtfY2IoKSBjYW4gdGhlbg0KPj4+IGNoZWNrIGlmIEBhbmNlc3RvciBpcyBlcXVhbCB0byBh
IEByb290LCBvciBvdGhlciBwcm9wZXJ0aWVzLiAgVGhlDQo+Pj4gd2Fsa19jYigpIHJldHVybiB2
YWx1ZSAoaWYgbm90IGJvb2wpIHNob3VsZCBub3QgYmUgcmV0dXJuZWQgYnkNCj4+PiB2ZnNfd2Fs
a19hbmNlc3RvcnMoKSBiZWNhdXNlIGEgd2FsayBzdG9wIGRvZXNuJ3QgbWVhbiBhbiBlcnJvci4N
Cj4+IA0KPj4gSWYgbmVjZXNzYXJ5LCB3ZSBoaWRlIOKAnHJvb3QiIGluc2lkZSBAZGF0YS4gVGhp
cyBpcyBnb29kLiANCj4+IA0KPj4+IEBwYXRoIHdvdWxkIGJlIHVwZGF0ZWQgd2l0aCBsYXRlc3Qg
YW5jZXN0b3IgcGF0aCAoZS5nLiBAcm9vdCkuDQo+PiANCj4+IFVwZGF0ZSBAcGF0aCB0byB0aGUg
bGFzdCBhbmNlc3RvciBhbmQgaG9sZCBwcm9wZXIgcmVmZXJlbmNlcy4gDQo+PiBJIG1pc3NlZCB0
aGlzIHBhcnQgZWFybGllci4gV2l0aCB0aGlzIGZlYXR1cmUsIHZmc193YWxrX2FuY2VzdG9ycyAN
Cj4+IHNob3VsZCB3b3JrIHVzYWJsZSB3aXRoIG9wZW4tY29kZWVkIGJwZiBwYXRoIGl0ZXJhdG9y
Lg0KPiANCj4gSSBkb24ndCB0aGluayBwYXRoIHNob3VsZCBiZSB1cGRhdGVkLiAgVGhhdCBhZGRz
IGNvbXBsZXhpdHkgd2hpY2ggbWlnaHQNCj4gbm90IGJlIG5lZWRlZC4gIFRoZSBvcmlnaW5hbCAo
bGFuZGxvY2spIHJlcXVpcmVtZW50cyB3ZXJlIG9ubHkgdG8gbG9vaw0KPiBhdCBlYWNoIGFuY2Vz
dG9yLCBub3QgdG8gdGFrZSBhIHJlZmVyZW5jZSB0byBhbnkgb2YgdGhlbS4NCg0KSSB0aGluayB0
aGlzIGlzIHRoZSBpZGVhbCBjYXNlIHRoYXQgbGFuZGxvY2sgd2FudHMgaW4gdGhlIGxvbmcgdGVy
bS4gDQpCdXQgd2UgbWF5IG5lZWQgdG8gdGFrZSByZWZlcmVuY2VzIHdoZW4gdGhlIGF0dGVtcHQg
ZmFpbHMuIEFsc28sIA0KY3VycmVudCBsYW5kbG9jayBjb2RlIHRha2VzIHJlZmVyZW5jZSBhdCBl
YWNoIHN0ZXAuIA0KDQo+IElmIHRoZSBjYWxsZXIgbmVlZHMgYSByZWZlcmVuY2UgdG8gYW55IG9m
IHRoZSBhbmNlc3RvcnMgSSB0aGluayB0aGF0DQo+IHdhbGtfY2IoKSBuZWVkcyB0byB0YWtlIHRo
YXQgcmVmZXJlbmNlIGFuZCBzdG9yZSBpdCBpbiBkYXRhLg0KPiBOb3RlIHRoYXQgYXR0ZW1wdGlu
ZyB0byB0YWtlIHRoZSByZWZlcmVuY2UgbWlnaHQgZmFpbC4gIFNlZQ0KPiBsZWdpdGltaXplX3Bh
dGgoKSBpbiBmcy9uYW1laS5jLg0KPiANCj4gSXQgaXNuJ3QgeWV0IGNsZWFyIHRvIG1lIHdoYXQg
d291bGQgYmUgYSBnb29kIEFQSSBmb3IgcmVxdWVzdGluZyB0aGUNCj4gcmVmZXJlbmNlLg0KPiBP
bmUgb3B0aW9uIHdvdWxkIGJlIGZvciB2ZnNfd2Fsa19hbmNlc3RvcnMoKSB0byBwYXNzIGFub3Ro
ZXIgdm9pZCogdG8NCj4gd2Fsa19jYigpLCBhbmQgaXQgcGFzc2VkIGl0IG9uIHRvIHZmc19sZWdp
dGltaXplX3BhdGgoKSB3aGljaCBleHRyYWN0cw0KPiB0aGUgc2VxIG51bWJlcnMgZnJvbSB0aGVy
ZS4NCj4gQW5vdGhlciBtaWdodCBiZSB0aGF0IHRoZSBwYXRoIHBhc3NlZCB0byB3YWxrX2NiIGlz
IGFsd2F5cw0KPiBuYW1laWRhdGEucGF0aCwgYW5kIHNvIHdoZW4gdGhhdCBpcyBwYXNzZWQgdG8g
dmZzX2xlZ2l0aW1pemVfcGF0aCgpIHBhdGgNCj4gaXQgY2FuIHVzZSBjb250YWluZXJfb2YoKSB0
byBmaW5kIHRoZSBzZXEgbnVtYmVycy4NCg0KTGV0dGluZyB3YWxrX2NiKCkgY2FsbCB2ZnNfbGVn
aXRpbWl6ZV9wYXRoKCkgc2VlbXMgc3Vib3B0aW1hbCB0byBtZS4gDQpJIHRoaW5rIHRoZSBvcmln
aW5hbCBnb2FsIGlzIHRvIGhhdmUgdmZzX3dhbGtfYW5jZXN0b3JzKCkgdG86DQogIDEuIFRyeSB0
byB3YWxrIHRoZSBhbmNlc3RvcnMgd2l0aG91dCB0YWtpbmcgYW55IHJlZmVyZW5jZXM7DQogIDIu
IERldGVjdCB3aGVuIHRoZSBub3QtdGFraW5nLXJlZmVyZW5jZSB3YWxrIGlzIG5vdCByZWxpYWJs
ZTsNCiAgMy4gTWF5YmUsIHJldHJ5IHRoZSB3YWxrIGZyb20gYmVnaW5uaW5nLCBidXQgdGFrZXMg
cmVmZXJlbmNlcyBvbiANCiAgICAgZWFjaCBzdGVwLiANCg0KV2l0aCB3YWxrX2NiKCkgY2FsbGlu
ZyB2ZnNfbGVnaXRpbWl6ZV9wYXRoKCksIHdlIGFyZSBtb3ZpbmcgIzIgYWJvdmUgDQp0byB3YWxr
X2NiKCkuIEkgdGhpbmsgdGhpcyBpcyBub3Qgd2hhdCB3ZSB3YW50PyANCg0KPiBJZiB2ZnNfbGVn
aXRpbWl6ZV9wYXRoKCkgZmFpbCwgd2Fsa19jYigpIG1pZ2h0IHdhbnQgdG8gYXNrIGZvciB0aGUg
d2Fsaw0KPiB0byBiZSByZXN0YXJ0ZWQuDQo+IA0KPj4gDQo+PiBJIGhhdmUgYSBxdWVzdGlvbiBh
Ym91dCB0aGlzIGJlaGF2aW9yIHdpdGggUkNVIHdhbGsuIElJVUMsIFJDVSANCj4+IHdhbGsgZG9l
cyBub3QgaG9sZCByZWZlcmVuY2UgdG8gQGFuY2VzdG9yIHdoZW4gY2FsbGluZyB3YWxrX2NiKCku
DQo+PiBJZiB3YWxrX2NiKCkgcmV0dXJucyBmYWxzZSwgc2hhbGwgdmZzX3dhbGtfYW5jZXN0b3Jz
KCkgdGhlbg0KPj4gZ3JhYiBhIHJlZmVyZW5jZSBvbiBAYW5jZXN0b3I/IFRoaXMgZmVlbHMgYSBi
aXQgd2VpcmQgdG8gbWUuIA0KPj4gTWF5YmUg4oCcdXBkYXRpbmcgQHBhdGggdG8gdGhlIGxhc3Qg
YW5jZXN0b3LigJ0gc2hvdWxkIG9ubHkgYXBwbHkgdG8NCj4+IExPT0tVUF9SQ1U9PWZhbHNlIGNh
c2U/IA0KPj4gDQo+Pj4gQGZsYWdzIGNvdWxkIGNvbnRhaW4gTE9PS1VQX1JDVSBvciBub3QsIHdo
aWNoIGVuYWJsZXMgdXMgdG8gaGF2ZQ0KPj4+IHdhbGtfY2IoKSBub3QtUkNVIGNvbXBhdGlibGUu
DQo+Pj4gDQo+Pj4gV2hlbiBwYXNzaW5nIExPT0tVUF9SQ1UsIGlmIHRoZSBmaXJzdCBjYWxsIHRv
IHZmc193YWxrX2FuY2VzdG9ycygpDQo+Pj4gZmFpbGVkIHdpdGggLUVDSElMRCwgdGhlIGNhbGxl
ciBjYW4gcmVzdGFydCB0aGUgd2FsayBieSBjYWxsaW5nDQo+Pj4gdmZzX3dhbGtfYW5jZXN0b3Jz
KCkgYWdhaW4gYnV0IHdpdGhvdXQgTE9PS1VQX1JDVS4NCj4+IA0KPj4gDQo+PiBHaXZlbiB3ZSB3
YW50IGNhbGxlcnMgdG8gaGFuZGxlIC1FQ0hJTEQgYW5kIGNhbGwgdmZzX3dhbGtfYW5jZXN0b3Jz
DQo+PiBhZ2FpbiB3aXRob3V0IExPT0tVUF9SQ1UsIEkgdGhpbmsgd2Ugc2hvdWxkIGtlZXAgQHBh
dGggbm90IGNoYW5nZWQNCj4+IFdpdGggTE9PS1VQX1JDVT09dHJ1ZSwgYW5kIG9ubHkgdXBkYXRl
IGl0IHRvIHRoZSBsYXN0IGFuY2VzdG9yIA0KPj4gd2hlbiBMT09LVVBfUkNVPT1mYWxzZS4NCj4g
DQo+IE5vLCB3ZSByZWFsbHkgZG9uJ3Qgd2FudCB0byBwYXNzIGEgTE9PS1VQX1JDVSgpIGZsYWcg
dG8NCj4gdmZzX3dhbGtfYW5jZXN0b3JzKCkuDQo+IHZmc193YWxrX2FuY2VzdG9ycygpIG1pZ2h0
IGNob29zZSB0byBwYXNzIHRoYXQgZmxhZyB0byB3YWxrX2NiKCkuDQoNCkluIHRoaXMgY2FzZSwg
d2Ugd2lsbCBuZWVkIHZmc193YWxrX2FuY2VzdG9ycyB0byBoYW5kbGUgIzMgYWJvdmUuIA0KDQpU
aGFua3MsDQpTb25nDQoNCg==

