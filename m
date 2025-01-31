Return-Path: <linux-fsdevel+bounces-40485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAED9A23C24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 11:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997153A9B8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3E1AA7A6;
	Fri, 31 Jan 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q/JjQXDU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E3gdgiQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CDEED8;
	Fri, 31 Jan 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318920; cv=fail; b=e0kX7z27F1fmjSNh9g2A3MlYs27nJURC/LFxViRsztfQiACqhk5h8ctutegz6HnaB/PY/KoL1s//6ZCekPqcxTpyDffOmi9CAOy5t2FRsHO7gDM6pUXLEQGsKOsNwBhWnHqLm7GZ2biMrrZ8Olr3MFE/i+CoUJHRfaAHCdj7rVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318920; c=relaxed/simple;
	bh=RKJhSQhABXSmeK3N37WEApOzqOHcD/4WAtmPqxQyidk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFaf3GsGHRX5V5hksRiA+5kAy9vXXyhfMedXUugKoMAqALIBhy5IKGtrgqOgKfB3s5oc5IbNv0dhCz0anrLl/2ajlQCEQg0e1Sf2KGgraWtTFBZjsh28vsMYZMHRVwllF5iz5xo9tbbAZgATlxKwiwPznNUTZfFYRjbeKoAErqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q/JjQXDU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E3gdgiQq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V96heS016230;
	Fri, 31 Jan 2025 10:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dvnoD+6M/m3gGFJBck5/j6Qp1XW0K1slJIDQ9Lt42tc=; b=
	Q/JjQXDUIsEylwuBoyl0nwXNcoVBGUXZbVqJCxAv6ksk9J2NePmeW+koiPiMDXzR
	YlICD9RtB0LO3cC2mJQaduwd7yHpZEWIjbzmSnBGZMoCwpKBMY3H9W7GbRPsBmnJ
	4d3kx6Gmv64PNHDWZ5tpKK5ZbLx8lX+I76C/NMkBuwtoV4W3I7akuDkUL3UA15oi
	1W7dUoXaZIeUQkUUnaXF2hk2CZqD6PWhC0w5zIu4TeJZvxm2Y80Vn4YvoBSKJTI6
	QUXmX3rFL8KTY8+VRQOqEsSmDWTESyZskKkozFs9PPFu12sC5BVr2P6DQyJtvBUD
	TaIrtPaps7mGvmGEsptD8A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gukb84gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 10:21:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50VA1g6n022375;
	Fri, 31 Jan 2025 10:21:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44gf930veg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 10:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoGxRfMcsMZk2BKr7vmLUoL/ID3O7wwhGIKaz2NuRpTYpEJdXv5gJMGnsi3Zs6TX88/FC1M0rhRrzn+edKCEEUXkvt9gKY6k4ZjYt6MWzhYTb24mA8h9JqWhfBkN1JOnqii8rEYNjLL8uFFBIcuPoMUvAL+FPqviuzAWmECRP6bgRjwMH6a2Mt+QPYY3lgSL9b5HyhLsJSKSO32YYQfZ0oD1DOtNODxsXrzElZ+sk03jNGycPFIFyHqdqjmrqWfsw6jS/yKyS87ERMPKAjE42Q/kKlpK18/+cvDqxpbLldk369RBkqwEhKSz34Nz2WwsSv+OjXjQ+IbkQa76sYff9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvnoD+6M/m3gGFJBck5/j6Qp1XW0K1slJIDQ9Lt42tc=;
 b=sTAcjaA1HoJUfQDwB2P4gwV1NEkm+iwELhK1K4wSiSjdEr/b2Cmx0QaCzxpI7MZQCsVvSTWXWGl03OIEf2XFlgaF8muGO/tEq6rHMrTuN29p3o6zzQ4BJ4iaWfdFgxc/r2u9qmBum5/uem9/CWDvxIBlrHcWUC/R4ARKre5FAoUX+95NGgETC9wvD1s7DdW6agRD4u4RjSmOAniGW4BBk080VpLfIYwMysHglE8nGzslGCESZtPp5H+hA3WYDSPA37yXWpTCdYYLVoZ8yoSKMCCnqTL0e4ni8bcjDcmZngc8ZanVuQIn2bD6Kmmz5EnLujFqRKrmi4QPGMZbWg/HIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvnoD+6M/m3gGFJBck5/j6Qp1XW0K1slJIDQ9Lt42tc=;
 b=E3gdgiQqp5vj3VlBextzmlbHXAy1Kjjiau3QL5g82z1PUSLAqBHL2lZxMofjeHxhPVFhrzBrahPlBNcidCgPcLHApzuNeaPlttqlR8CHnPtey0y9EnXuhT9QdlvH/mxoUW9jvx3gCpQ0P1SCufA/KzqXsRSienWT2T6ucLi6Xxk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6255.namprd10.prod.outlook.com (2603:10b6:8:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 10:21:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 10:21:35 +0000
Date: Fri, 31 Jan 2025 10:21:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Message-ID: <7519b85a-cd04-4ae9-a8c8-3d16fb20582e@lucifer.local>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <20250130143754.1b8bb87bfb15175dd434529b@linux-foundation.org>
 <b396487f-b906-410d-9ff4-6956d99e2771@lucifer.local>
 <CAKbZUD3w4_4MjrME-0mgRL01eFggb7et2BLa6012tzQX78KK9w@mail.gmail.com>
 <20250130153236.198664b9a19ccfcdb24f888b@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250130153236.198664b9a19ccfcdb24f888b@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: c86fd1a6-1b30-4b6a-5e14-08dd41e10a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmpMY1pLTFlWNzZadWtVL1NhQkt3K0djYXlNeExGOVU1STlCekhKVlFhL2pt?=
 =?utf-8?B?bUNHRFdnZkJ1RXk1ekNRdVFOUm1TZENkSE10NU1tUWszK2Y3SkVwTzNTa01h?=
 =?utf-8?B?MmpoV0tTbzFpUHpqTGh2a2R3OUYyY09BMWpNdmYwOXlUL2MrSmJIcWlHRU9P?=
 =?utf-8?B?V1FidUYwakdCaGVYTW1UOTd2TnlGdTNocUdhZm1mMXBFQlZnWVpUeTBrQjVF?=
 =?utf-8?B?T2JXdzB5Q1p6MXc2aWVQZjQ0VmY2M2hVK3IvUm0zV0ZjdW5ZUm00bGlBeFl2?=
 =?utf-8?B?V1dnMXdiVlVmSTJOUDJrVE1UNTJCNWIrMWRUb1FBOGFPWERlUUM0Z2tZYUVJ?=
 =?utf-8?B?bEFmd3FMMkxVYmlNcWZITDRoeGdnVWo1eTR1RmMwaGpGQmFBa2UwWWlUWFRM?=
 =?utf-8?B?MDFCMEtkTWhncnliYUQvYWlENFBhUklob3dGMFZPMHZaSWszM1czQThscVhG?=
 =?utf-8?B?MC93VG5GWStzUGRnUWU5RlN3TWk1TFNOdFoxYko5R2VqMXpXV2h1NWI3Wno3?=
 =?utf-8?B?Qi9VY0ViOVNsQlduUnJPaXRRWDdnYXQ0SjRLcUg5T2ZzUkt2SHpZQjNkTCtT?=
 =?utf-8?B?OFBuTUoyM2pGRFZYYWkwc25PUXV6Sko3b0RKaDJlNkJKSzloa2szMWM4VTVU?=
 =?utf-8?B?ZysrMEpkZlpWUzVBU0dqQlQ0RG9vQ1JOajlLWTVWRE14TVFWRUJsRVNZZEli?=
 =?utf-8?B?aitDc241MnI2VVJJdTl0RllLenBOVFpCK3YzcnJOSFEyZmlUMW9CZE01VXBU?=
 =?utf-8?B?Z05hY1NOaTlOZGN5bkJTYUUrcDNMK3pBTnpJajhyMWpOMVczbFhOK2d2dXJl?=
 =?utf-8?B?Q05oaG9hbDBRMTRBUU9SbjFvUWFHdXozbGhPSGFFSmdhcDhiS2ptRzFrZytC?=
 =?utf-8?B?bnhibnkwU2hoQW1tRCtaYkorZ09FckZLenJYTGhPUm1VdC9hYzFOZU95YWxs?=
 =?utf-8?B?bmNOdmRlbWxidWRRL0xPZmt3bTlMYkhZcWt4ZUlOelpBQS9ueXZsaXRoL2F2?=
 =?utf-8?B?QWhLSEhUWG5ZUlozMGF0aERQMFl3SHhCT2x2bGlMbUk0OUxqdlBHMFpVZFdY?=
 =?utf-8?B?RVVsdHVQM3lBYXRlaGsyVmE0ZkdUUUsrdHNnMUtYOGM2dlBnWTRPdUlOcTlS?=
 =?utf-8?B?UTdUVjhtNzNwaEUxdENDSzVkeWs0RFFaMGo0MjEyZndMNHR2VWlzejNJNVIr?=
 =?utf-8?B?YVlQa0REZU5pcDNKd3grc1JyRnBVR0IvVGxLNk9qYjZFcjdBUXNDMWJWUFRl?=
 =?utf-8?B?RE9ZVUxsWW43bDJZeU1JcVZ4ekdUeWlGMkhQMngzbzBNbC9pSjlXaHRGSm1X?=
 =?utf-8?B?YXZMUlB4Y0FPTEY1QnVUeGExeWhPb3RObmd3TEMzMlRuaFN2czBrRllTRDFr?=
 =?utf-8?B?SkNybVc1VGlpSWpBOWRGZnd0L0c4d3UxdVFhcDdmczN2ZnpnbEtsVGlrRmxw?=
 =?utf-8?B?Q3IycnFRM0FsOENxWHJkbWJXdHJYRmMwQkFja05JK2VwV29IWUJLMEViOGph?=
 =?utf-8?B?UW5tSVU3V0k2b1AzekN3b2FtSGluZCtJbU5od2ZvUHBadHVmeGFJd2hYRXdI?=
 =?utf-8?B?aHlhUW1LMnRwM2ZUams2emt1Tk8vY3AzR1Y1azN2U1NKa2hySk1rTElwU1li?=
 =?utf-8?B?U2dRaktCSFdZWUFvbm9idExTWGZ1RmtMbWJabHlmMTB5dDloaFVyQ3lBSmhu?=
 =?utf-8?B?YnpXWFowcndzRVVJUUlKRDRHaUZVM1IyTzhvVUhDalFXY0k1b1ppNUFFd0Ir?=
 =?utf-8?B?a1FkSi94N2Y5MTI3Yk9sN1A5WTBhM0F3ODBsKzZqckcyeTBLbUNQNThEZVJE?=
 =?utf-8?B?bUNLRkk5ZUk3NFE5MCtMQ3V4VExEblE5c3RCUUJ3RkpBMFE0cjV4TitibkFT?=
 =?utf-8?Q?T1fnh/+YWC6YC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1V1NDAvckxzVDJlSkxFYytxcFNSSjgzZWhIQjY3SGE3dVJJRVN2cDdRRVJR?=
 =?utf-8?B?dmtYUWdSZzdWRzVPWnkwL3psTjUrQmFWVHIxWmtUQjV1UVRkaEhLaERPKzds?=
 =?utf-8?B?Ykd3VnpHaGV2NmNUWnRmcWo2ODRmZHd3K1lwbFJRWTZQT3pQVTBzNUJlQkt5?=
 =?utf-8?B?cjBOdU8vWjdmRVVqc2VNQkQ4d2RTQ2JROENoYTMrYjFZeE1zcGMrZGUzYkU5?=
 =?utf-8?B?OWg0SGRKNUhtZTZHZXNlT2hvMXZ1YWZKZ1JqOW03NmtON1lYNWlUU0RtYmJh?=
 =?utf-8?B?OTk4S1l1TVJta0RVOWRBclAyem5iMTdKbTNHL2pWc0tabWZsTzRFb0FINFhj?=
 =?utf-8?B?L0dXVzBmblIzNTBFdSt5ejFuVGRRZUJaSzU2R1V3MmF2RW9qN3J6aFNNSkFt?=
 =?utf-8?B?cjNOcVk0VFVVazNEbGJkbzk1Y2pQMTBZYWl1ZGluS1JqYStKOU9NaUlTVXdQ?=
 =?utf-8?B?M2YwVTdvOEpWWDBKZ2NhVGhtT1Vja1h5WlczOEJST2hyQkYrcTBQS0JRd3lJ?=
 =?utf-8?B?SC9QTDU0UGh0KzBIeENWck5UUG94L2ZFUXJ1ZDh5bjdUZ2dQeXlqVk9CakZr?=
 =?utf-8?B?Tjc5MnNKUGs2Tk1oVVlXeUd5WnNCWWdUY0RBRThGSE1wRytVU0RocUg4djV2?=
 =?utf-8?B?MDBIbDhqbXR5SnozQW1UZ0lQRjJicGZlY0h2ZzlldWdwdTRzd1k4cEFGVDho?=
 =?utf-8?B?V2VhQ1NsdUpVaVl6UlBMUXVvR3dQYmJOVjVlaUhMcVJET21TUUVSdm00RGYv?=
 =?utf-8?B?RE5UZzNFWm1OU0VzQnROZFJnMWVGemt5VnZTLzZJSGNvWWN3bHlNa3ZpR0sw?=
 =?utf-8?B?OEErbVlJNkMyVVZRRjVHMHZhWGNxTkNXeTd2d2prNHUyVHdOcjVlelIxR0h2?=
 =?utf-8?B?L1BZcU9jRjZvWjFqcWxoOEMwV3pIdmpqMy9kbmZycWh1R2dneC9pdmwvV2JV?=
 =?utf-8?B?UVBScmF1cGlWYmw1ZmJodkNDd1hWaGd1WXVUZWRpblAxRk55ZUhySDI2dnR2?=
 =?utf-8?B?ckdLOUNVU0ZJajFrUDBvN29vdHdQNVUvUnVFbDVVeVRFeHBKeHFWd1BEK2or?=
 =?utf-8?B?ZXFVbmFkMng4ZllLSGd4OWxhVUdiRjFPMFVJbFJyeEsyZDRURjQ2SVRNSzdR?=
 =?utf-8?B?UmhmMzNoYm4vcWlPUmRXYURSSWx5dVE4RkdFRTZERlI4emlkNlMrOVdtSm5K?=
 =?utf-8?B?djhzWUd2NTJsU1RDcGJra3ZITU8vLzA0bGtORlBWVWx2RUx4SU5EOVIyR0VC?=
 =?utf-8?B?YWxVc1ZvajYvZGIya29SNEhhQjJVWHhaRGFlWG9MM3hBcTE4WVo2aU1GM0RX?=
 =?utf-8?B?Wk1DUFBNWW9jNWxMbnk1TlQ5bnAxRUViQ2RKYUd4dGUrMXpaaENjZW8vVWJo?=
 =?utf-8?B?WTJ5L2VnOGJjTVBSR3RudFRTcTA2SHVVWC9BaGwwZEw4cEtueURFc1lwdGRZ?=
 =?utf-8?B?WURNQk5DYTJzTWxtS0Rad0Mva1RiRDhhR2RIZlJ2U1laTXZMMXBoLzVNQkJv?=
 =?utf-8?B?Y1pEckFyM1BWQVVZd2FNUENKMXFsb05ncE1aNGRhMkIwYXhPeGxkMURYcGk3?=
 =?utf-8?B?QUw4ODRBMVI4anEyZWVUcnF6YVVtSWd2eTg1OWZkU2kyQ2oxVk9WbjBQSlRV?=
 =?utf-8?B?Y2VLRVJ6OWtqaXlzaUxXTlNRejlhS0NQZ0lXNUV4WUNrOFBmWnZuTkh1cWVa?=
 =?utf-8?B?S2FNTzdqYUI0QmQ1WC9pNStmdTZyOGRFVFFONitGRnFsTDB6Q0Q3dnRGcm9W?=
 =?utf-8?B?elNzVUtBbGJ0OXg5NG5CaXZFeGNSdHl2N0xvZEpzVUlMdC9ORjZ3OXpUR2lj?=
 =?utf-8?B?azFSTWN2QlJjZk9BRzh4YXJhSnkxWlJ2bTBpME9jSnU2cXB2dEsvcTZKd3o1?=
 =?utf-8?B?cytLdUo5OGVVVlFYRmc4QThFT2p6cFRPQUFmTWdQWHEyY1RKTWIzdXJDWk1W?=
 =?utf-8?B?b2VhVS9lKzVwUCtBQ28raFY0VnNBQlE5SjhGcG9valUxcTd5eUR6Q3ZidkJP?=
 =?utf-8?B?VmNRUFNLWGNKVnB2ZTJMZnVMNzgveVVubnpXbFJVQThPMTBkV0h0cHNEK3BY?=
 =?utf-8?B?dnlHTi8vNWcxWEFVUGMvT0NVeXp0NGZIaTFTd0xua01yUVJEeW5LNjJNV2NB?=
 =?utf-8?B?UXlYYXYzakJGYVVVQVZWMHFSYkwzaWFRVVUrZktHRnNZalZ0ZnV2T3BvNWhE?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/9kPBmjjtHn/0m7O76u7uWcs0x3wgR720uI3jN8nK6u8MuPp5aV8bRqptFRW8WYG7dsQg6SGR+oDEF6q5iHvtPefV5FTpvGkBMo+CwVIW0j+K8a103Ja8jLpzlbn3GT2DIoyszf6RmvOYNIVhCjtPoAYearkz6d0WGJzzF9N/D1aPD2X00A+HZm0IJoEzlhUv/ek6HRntg7DFnm4+slxlpxiTZrn4XX+h6Ur5Y6AfK1NHvV0nf7aTkCeIBpVDYVhwprfOPn9CWcoVZkUzxeaZnuDXyqR+l2pQQMiQ37oe/BJf++AzeyLXYx7lOfIg2cL2+8fQEzh5JhqRgC/DyPeNpsBoQ7i29zbLxhUkxRes4lHYgiYvmGxBVcg95yU9Vr2EHyqxBEm2pL+5gCLsXan25rXmyoauWYU1R9IGzaxdg9AA8wrs+d9+diQp2UIb66/7qccEjBRTFbvFHbb37b6ALDumR9IRPQpq9zSfj1p/t9T0TW2k9M4m8XaFJqfT5GT4IAOIXw+2vsTZ66d5h7WAIwjGlRBdMuFEjaSU30Tb5N0YJjYgyjPILc0iav0tDmmmdppE/5cT1k1fYBLxx9xiDCtvkCubLJO17+BN2ANzS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86fd1a6-1b30-4b6a-5e14-08dd41e10a85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 10:21:35.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFhCHf3rb0YxNlLrEB6RUySPuqZLY7yRCkURVk5fKvpfHrZ13Xe4vYsRqlD7dnnc7HZeGrIMxzbi/hzgndkx8akBfyI/OadHqMiJ+3MdlbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=742 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2501310077
X-Proofpoint-ORIG-GUID: _-qGuGrlVnFYkBN_4FXbaQiL84KDv23P
X-Proofpoint-GUID: _-qGuGrlVnFYkBN_4FXbaQiL84KDv23P

On Thu, Jan 30, 2025 at 03:32:36PM -0800, Andrew Morton wrote:
> On Thu, 30 Jan 2025 23:10:53 +0000 Pedro Falcato <pedro.falcato@gmail.com> wrote:
>
> > On Thu, Jan 30, 2025 at 10:53 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > > The above code sequence doesn't seem at all onerous.  I'm not
> > > > understanding why it's worth altering the kernel to permit this little
> > > > shortcut?
> > >
> > > In practice it adds quite a bit of overhead for something that whatever
> > > mechanism is using the pidfd can avoid.
> > >
> > > It was specifically intended for a real case of utilising
> > > process_madvise(), using the newly extended ability to batch _any_
> > > madvise() operations for the current process, like:
> > >
> > >         if (process_madvise(PIDFD_SELF, iovec, 10, MADV_GUARD_INSTALL, 0)) {
> > >             ... error handling ...
> > >         }
> > >
> > > vs.
> > >
> > >         pid_t pid = getpid();
> > >         int pidfd = pidfd_open(pid, PIDFD_THREAD);
> > >
> > >         if (pidfd < 0) {
> > >            ... error handling ...
> > >         }
> > >
> > >         if (process_madvise(PIDFD_SELF, iovec, 10, MADV_GUARD_INSTALL, 0)) {
> > >            ... cleanup pidfd ...
> > >            ... error handling ...
> > >         }
> > >
> > >         ...
> > >
> > >         ... cleanup pidfd ...
> > >
> > > So in practice, it's actually a lot more ceremony and noise. Suren has been
> > > working with this code in practice and found this to be useful.
> >
> > It's also nice to add that people on the libc/allocator side should
> > also appreciate skipping pidfd_open's reliability concerns (mostly,
> > that RLIMIT_NOFILE Should Not(tm) ever affect thread spawning or a
> > malloc[1]). Besides the big syscall reduction and nice speedup, that
> > is.
> >
> > [1] whether this is the already case is an exercise left to the
> > reader, but at the very least we should not add onto existing problems
>
> Thanks.
>
> Could we please get all the above spelled out much more thoroughly in
> the [0/n] description (aka Patch Series Sales Brochure)?

Ack, will expand if there's a respin, or Christian - perhaps you could fold
the above explanation into the cover letter?

Intent is for Christian to take this in his tree (if he so wishes) to be
clear!

Cheers

