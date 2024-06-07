Return-Path: <linux-fsdevel+bounces-21207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA9890066F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1297B28C42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD569197501;
	Fri,  7 Jun 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ovhIzsxc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BDcLzC3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5B54660;
	Fri,  7 Jun 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770363; cv=fail; b=uiZF6IXEUOscmbp+MLzwlgzI7WZ6AaXd1JXv1lwBvbjcZRn5s/wIoPxydLrMv+Qpe8RkyfFbRJ/Ln0R369TxGuPh/Vp7tnhrl85AkDUowj/JIYZyHldc0EpdHkoWpF1qhnqrZxXvp2VUbnxxIfuTLe8JuPkFGkKnRMETrAUP4rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770363; c=relaxed/simple;
	bh=niYuNHzy1RQ7htfequnHZ7OKxvKa4T6Ji5o7kq6gPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ic/ijiT/NZYiTk2tJw7oFlr3Ptr7oOx1fDUFFxUr6ST4V9gN1sSeYAgGZDmI5mpKlb+D0de47x976eNvpcExoXA2NaLSWCHTdWskhi8mihB5AwnrKH0Ks0BquML05ReSp0MEtrSTwgrCiETakcHyPS9PWmCKxmUQauYcGMhmBik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ovhIzsxc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BDcLzC3C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuhXF009446;
	Fri, 7 Jun 2024 14:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=JAcaAUEGb6jaXM4sybKpTRldfgMtDQy4cmg44VXMJPE=;
 b=ovhIzsxcl0LKRwha4zojfz/N6PhMbQRvOQt0oW0FBp34RUb2IUGmLi2EQNnziFgof7aT
 hrI3z2V5yEM1RjsV+g1K705naAWPINZ3kAj3hHHW3//u7uS2Nw9PqpjgarrU1oL2yDzB
 ZCs2Uo0JjfupV2eyiFd/3YWHKoUmL4WwFNaUkbPmWltpI9lSSgHSkD85BMBufJFe7Syi
 /7A55ekB0weiGox5VRO60TKx/WCLXg/TplY28rBoXpSsmRQ5GmwxUQE0QmhrEv2xGk5L
 E6XugGRPrqrh2rgOgwmQlIysh9BFPUdUDd33Yy8XK3ZRPmIuJFoBced/HauK4d1HJJ5h 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwdrn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:25:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457D4hNt023943;
	Fri, 7 Jun 2024 14:25:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr29vd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K61OJZUgwo7zLYPqpxvsi5TsbFQ2k82qyOn/VzHes6kBtVcjHHB+JVmVVUSshW59Fu5H8n68JxmdrxjWYeNUPACpAOh6WmXID5y1PdWGJViP4GkU9uOuHF+aMBGR+BWsqPWiJMgjaGIIFffLbRfl0X0uCagMNXhXhhjvNWkCMuBsvTDT4QCqC/EUyEPJzMZ88+qele6wosZ+gGixii/t3Qunq+4p/h9MpiHp93ArbHHPqCdR3EMQbo3tuwgg3oB5oiLLmj3N/gS+TYe9gNAyZniXvBENZ/xLXmhpCoV7yMiP8U63BUS5CL/kZbt4ottuTcOjDjIOMpR84A89kXR1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAcaAUEGb6jaXM4sybKpTRldfgMtDQy4cmg44VXMJPE=;
 b=dQF0SAmIu3x9NOR9vgINJd6QieU31n74QetSt3DValGzwEailJp/UyBJ+aDbyJa9H1BvTpw26HaTdLu09Yr19hDmQHwXhcfeNyqV0jwDuCpNCvGzCiljmn/w4HQq9ICCqkLtamR1xsooeUorcjtLv1qv1AUXlo4GHABYVNpVjMuZpFkoAkMWafQx9+NHeCk0V35OmhaFqPstjHpBe794LABPFMxotx5TgipZ0sIjNShnyxAy3bNs08p2jQSXiJy3ezMHAIka+bn+gLPprvjlMInbtHeJxznIJeWG3lVIxl6ceH7V8MzGK5yrrU+R6LUqm/rA8ZbO0amtGboPHREHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAcaAUEGb6jaXM4sybKpTRldfgMtDQy4cmg44VXMJPE=;
 b=BDcLzC3CLt+v0m5oNv+RnbB4x6zYqGwa+D/N7TnbqFfklMgjjZM/oL+YuSoUfPKeFYzcrBcTZQRFtYm8tXU2SX4BLmMURbMnPkukVlwu7WJetZ48woG8Xs4FbDm4X5IiIbqu3i32A4QUG+mZtEuKpjIuEMaJCn5MvVgCVv7gwHg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW4PR10MB6322.namprd10.prod.outlook.com (2603:10b6:303:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:25:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:25:32 +0000
Date: Fri, 7 Jun 2024 10:25:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm/mmap: Correctly position vma_iterator in
 __split_vma()
Message-ID: <mg2orzdqididfjexb7mj7gep3guehtdzamjn2v5a5vce7cd2ch@uvjjc2xzv7ao>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
 <20240531163217.1584450-2-Liam.Howlett@oracle.com>
 <CAJuCfpHqDNGM=6+TX4xE-YY91fETSM+r70ZdgxUyw=9X+3qQCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpHqDNGM=6+TX4xE-YY91fETSM+r70ZdgxUyw=9X+3qQCQ@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW4PR10MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: a460b2e1-0d5d-428e-ec6e-08dc86fdb09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dG03S0JHNWhJKzl0RG90Y2tBcXhrRzg3V011TEJDYjdONzRwVmhzMkg2UkN2?=
 =?utf-8?B?M3NaR0MvYy9xcWR1NEtJa3RhNmNOWW8rT0h1TnQ0N1N6Z1VyWGtqMFBSTGw3?=
 =?utf-8?B?d2RiOXdMRnVhaGx6RGRtU1RFWlNmaUFkWVpWRjRFb016UTVLOERGSjFUblFM?=
 =?utf-8?B?dmpoMFFkNDgxODNjZTAzRStKM3BhbTBxcFJQQlkzenN3L2I5RG1BN0Z1bHpB?=
 =?utf-8?B?bWt5VUdyckFpbU1YVngvTkdRSGIvUEZkbGRwdTU0K1hzSXZRS2N2VElKSmwy?=
 =?utf-8?B?QThoMU5tK3NRSW0zSkVkYUJZbVhoelBTN1NnMnpTczcrd3NkME1jYm9STUgz?=
 =?utf-8?B?WWVBM21QMGpFYm1Lc2w0ZTBjRFRSVDR6UlpBRkVBamZJZXNGTFhYdmJ5NlNQ?=
 =?utf-8?B?cG5WdzBwWmR4Qk9SY2NLUk10WElzTUhjYXVRSzJWandSVG0vY3IyZi9ub2lu?=
 =?utf-8?B?ZXdvOWh3a205SjIwclorRHJBV0hmZ3QyOFNhZldYYURkamJBdzM5NFp2cXBx?=
 =?utf-8?B?MUl5WXNYOGphbGg5QzJRbmRaOUR1bXNqcUs4WWtoREZEbTh0ZFBCNXkzazgz?=
 =?utf-8?B?MERXSVZYK01mQzF3dzNHTnFKc1l2ZUloemkweWd5bXk0SkFNbCtYRU9ZSFpY?=
 =?utf-8?B?bGhoeDA5YncrVk9mTkFkMmlIb1c2bCtlZ0xqTlREUlhsbHZqZTdtVVJEODNv?=
 =?utf-8?B?Y1pvNDVzeEhFNkIzSHp5LzlLUEt6VUhnTW93ejVnWlRKTi9Ba3dUK3ZvbDZ0?=
 =?utf-8?B?ZGlLcmZycE1YMzhZTmxpdStyN1cvaUN4RFlQWDhWcjQ4eFBReTBTelFDdlVa?=
 =?utf-8?B?dmUzY2hmL1hrKzVqYTV2ZWQwUkYyaGx2b2tsQWQzdjdGTDBhSkZSSURuNzR4?=
 =?utf-8?B?TGcvZ2lMVGFBK2RBb1o2UFQvUW5ieGZwTDc4dWJhYTVTRWZ0STgrYVhPYmM0?=
 =?utf-8?B?M3B6dU01UHNDZVRHdWJDamJadlRkSWUwMXVleks4RUl3UE90WmdEb2UyOUdj?=
 =?utf-8?B?Z2N2cHdzNDUzcFFhQVRRMVZyWEIya1FrQlIyTlhjQjlGaXc1d1hMUmF2eVJH?=
 =?utf-8?B?T2xKYno3TzE4ajJEMzVtNEVmd3NhOHg1NFpBMlF3YXFkQlZMZllobW1pWXM4?=
 =?utf-8?B?Vnd6dTc3VmQydGdBVkhHMEE0NnVhTDliQTdmM3drZ2NZR09ZVFBUOVl6c3Rh?=
 =?utf-8?B?WUVnbmdFa2JhbDQzMkt4bXZ2VHFTTWtGRTlCMFZwMEI3R3JrM25aNjlqN1dv?=
 =?utf-8?B?UWlqTmYvQWtNT1cvUERDRVRDYjF4RnQ2eWpPMjMva040MlBZUVJBd1p1Z0h1?=
 =?utf-8?B?SG5yU1JwWWl4QmNNM2I0cmxCZ2VIZmMzTHlpalAwNjdWWFloNDY5M1cvSlBo?=
 =?utf-8?B?b1NTRi9nODY1N0MwQ2dOTnRTMUNseHd1bk9FNFJhY0d3QURpb2RvZ0U2TTNi?=
 =?utf-8?B?cjdaajdRWE9rZDFTazZiUWx4TDZkWU9BeitOcWhCbjRkUTRjWWlkTXB4SmFC?=
 =?utf-8?B?TVI4N2F3T2o5M2NmWUhKa2FkMUhMeVpQRmI5Z3BnNHNsb1UxaVhTYlZ1S2lG?=
 =?utf-8?B?Y2ZXWFNVc2NmQnhwM1RTR0tDczloODVvZU91WlBMc29maGRpTkNOVk9GTXNS?=
 =?utf-8?B?RnZLOUVGQlQ3NnhsbWVpeU1XQ1B1T1RGTVl3UncxWTFVU1Y4ZHJ6N3dEVkM2?=
 =?utf-8?B?dHhhcWo5Tk12M0o1ZzMyT3hScVI3N3NFQzNnZ1crS1UzYmY0bXdMRHk1L0dJ?=
 =?utf-8?Q?0fcrLW5mcUlxPyRO69OB8OPiSrJnsms6hlpUndi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?di9IZ1U1ald0SklNekNBNm9nMGtCT21SQUhoRDZ0UjFEOHovMkk1TkhrYTE1?=
 =?utf-8?B?S1lZRDZla1Zza3NTRm52bXh2RlZXVjdqWG1GSDBMR1ArNGVuRmNtbms5MzdQ?=
 =?utf-8?B?cnFCUlNlaWNDVHNPT3pub0ZoL3V0MW1TWERxL3BUS3Vkb3NWY1dDb3RZOTJF?=
 =?utf-8?B?RVh2TFg2ZSt2WUUxT2d0aytVUkwxcEtmb0JTNklSMFBGMEZqYWNtemNXblBx?=
 =?utf-8?B?Yko2TVJNU00vSGNqejhxeHFUeFVLS3ZSdVFkaGo1bUd1RlM0c3FKTkJRbkIy?=
 =?utf-8?B?L3F3aWJLNGZ4MVBsVzRaclI3RG1YSi9NenBUbkpQQXRYemh4WnhZN1YvQnpT?=
 =?utf-8?B?QUx4V3VFaWdiU3RjODFyemFzYmtMRWUra3NxdkRZWVE3Q28wd3FjK1pLTlpl?=
 =?utf-8?B?M2tvcjUzbE80aUhCK0ZPY3owRUxZbEZGM0JDNy9mVkdSbkxmOTAzZmJGOGNN?=
 =?utf-8?B?YTNWY1V5eWlVM2tQclliMDJic09ncENhNkY0Nk8zVFhUZ0wvN3Y0ZFBOanVq?=
 =?utf-8?B?N1lLNXBYTVJvcFpJVDdNZllYa0h4d3Vtd2RHV2k1d2s2Y2ZOTjFyNzRZZ1RB?=
 =?utf-8?B?TGRKYlpSQlkwdTNwQWp3cWxLYWp5bC94UkEwOTJjSVltVVZucGdWL2Z4ayt2?=
 =?utf-8?B?OWNZZFl2d09aS1NJTjZncTdJS0x4RlhtdU80dWIzQU9xWDRieVFtdHpTWHR4?=
 =?utf-8?B?M2prU2pJdDU4R3ZqR1A4VjdqY0pKNmFDOXZPSDVxQnhJU3JCQ09KNURXTzhZ?=
 =?utf-8?B?djFlMlNOVzJvTjcyK3RuSUhTQkl1R0dBd0NNRDZPSTdZL3gyRENuL2VwWFo0?=
 =?utf-8?B?VDNTVDVQaTlGQWhidkMwRXliMVQ2cWRuQnk5bTZyZHk2SkNXSWM3NEE0VzNY?=
 =?utf-8?B?blZUTFArNnJ3bkFkaW1YUWFrclhkL1NrVG1hUmN1QmQwNVpPdWNXdkZqVS9t?=
 =?utf-8?B?c05kRjBTOGFVRjJQRVFUQkxVMWVSZVdML0s5eSs2ZWtwTUFCYXl0U1ZraVNs?=
 =?utf-8?B?V2JCeFFJQnNGOHJFMDI4YXQ0dHdNZDNTRGFLZ1NEUllyOWFZYWxCWm1XbkR2?=
 =?utf-8?B?d3NMY2dGTnd1OVIzNXRpYnFLd1RpQmpMdXBTWmNtTnphcW1qSGRnUkdMVHNq?=
 =?utf-8?B?NVNLVGU4cmwrbU1YWWIzL1MxT0NPeURjaWhMeDJCbkZpamZVKzV1QVpHaVo5?=
 =?utf-8?B?M0d2T09XK1N4bUhXOWliUU1DQTBqdzVRWlFkT2xmaW1xRjMrTVc5RXFld0xV?=
 =?utf-8?B?S1pVdHhoaWtlNXdtRUtlRGZzSDhnNUpScmdMRzNOVDNIanFFK1MvRFpnckpU?=
 =?utf-8?B?MFQrZGl4RFQydmU0Nk95V3ZCL2o2WE9aVlFzNXZhcG1VTU9xQ3ZUNjNzQU5I?=
 =?utf-8?B?aXBHcjNFVE9laEJhZEdEbVNKODNrWjdUUW5hNnY4aWtYOCt5MmlqdUIydHhO?=
 =?utf-8?B?eU92N3Zyc0VtMTZndW9rc29tUVhhdlJRYmFXTThsUFViRXBKU0RTS3hTZXFM?=
 =?utf-8?B?b00vTkRtZzd6TVJiS1ErUG5ZVENRcFdIcldOQ0lPVVg0bFJRS2dvZUJNUlFY?=
 =?utf-8?B?N24wWU9KRTlxNWllZGxWaG93bFJKclFzSEhnRDFCamxNSDBNalM5NDN2aEFk?=
 =?utf-8?B?MFhTR3RqRy9XSHNzRjh6R0RsSkFDbHd6aFh0SVlCM1RJTkhMY2tNbGFSZnhT?=
 =?utf-8?B?U3JiY25TSDg3YXM0RDd2Mmh6STkrVXUza2JaMWpLM1RDbW5KOERrcTUyUGUv?=
 =?utf-8?B?bTRGMDFXSEE4TngwRVljVlIvTkZQMUYzeHVNZks0ek55UHdIZHNkaUlTaFJ1?=
 =?utf-8?B?NEdqWmpSNXNGMVdmRmNaT0pUampweWMwbzM3K1ZJMlJUa2VEUm1BZkNTenMz?=
 =?utf-8?B?ay9SU2NXNzV2eVBwSG43Y0pXcXc2R0hRc0JuSDI4YVk0WE9tbWFKMmhVR255?=
 =?utf-8?B?WE9Mb3ZJTG9IK3lqSnh3bkNGQ3RYcU9UczFSbGdXa3pGSTgvd2l1MnJRTTlR?=
 =?utf-8?B?d0h0WUlMdy9kaGFsaDJLdnRiMGo1RkIvekdoaVdyQVUyR09OejZEUGc1YUtn?=
 =?utf-8?B?VVlrc0Mwem82M0NGSTl4cVRscng2YkJ0MlVUbTBJamZsT1QrVXBqM29uZEJB?=
 =?utf-8?B?MzVBVGZHODk5QW1FZkdBakg1aDJtNmx3aVJkZEhtRzZ2b2Q2ZzlyTm9wNC9k?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1bXywavaln7YrtRjLY48w3gahtFKyGVk4t4QkzPUGhtGOUM2027jFdqyiafvTuqJ+kFGOi/kRRjfUUWvxyIfOrUjqcGzQUIbpwJLA4XeebDDZ8pC6aGkn7itwGpG7UljjXSDobWnCnz66wMERPG6oM3IzVtwtJVkvxnTnBdgtfczfwhyje+bDMtPr2LX6aQtKS9HKyQ60g4Hf7GzUM0hcDzS40SKSnd2KBHZ3CcUvowAxAMv/XF3hG+0RCWjWBlHIVv+kDSl4lLrtN7er9RdKT0g+JnEfaa4RC6ifBiDK7ia4+GRVPTn3EwBbEYVVXwlZs7f1RmmHbeZKw5cPyDBdNPn+Kcn52RGlSvJXJMN4VwciTYvpjc2qS0L/XuP/jXcPvLXA4kKq5mXm7Evoo4oN/hd5LQGizOasuixLA5suiQpSIvo+aNv3tzaQRqPqX/gqHzDaT+koFZJBEhmT5Opgdh+HH29G8ItFnKcJoJQQhKKWTHiUJjVRFujARwGNOZr+EoahahGeuCkbbOXZzTCPKpeSZyfzQUVxop5Rt/lswRKN7yLIQDmyC/OqvxmmmfUTROYCjrkOm/dZ9TeXyRs/xPCkEHmYD4+nbnEsjDo0kM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a460b2e1-0d5d-428e-ec6e-08dc86fdb09f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:25:32.9246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJC/jt1FM/q26+188xqITZeeEg1JfbET7JTf1RG80h4TtjeRCVzxdEVQWgZaWRBpicxhp95OyzZcRlRPF439KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070106
X-Proofpoint-GUID: nw2OJqLpBeOjwzld31BTMxdbKR1RzeGd
X-Proofpoint-ORIG-GUID: nw2OJqLpBeOjwzld31BTMxdbKR1RzeGd

* Suren Baghdasaryan <surenb@google.com> [240605 20:51]:
> On Fri, May 31, 2024 at 9:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > The vma iterator may be left pointing to the newly created vma.  This
> > happens when inserting the new vma at the end of the old vma
> > (!new_below).
> >
> > The incorrect position in the vma iterator is not exposed currently
> > since the vma iterator is repositioned in the munmap path and is not
> > reused in any of the other paths.
> >
> > This has limited impact in the current code, but is required for future
> > changes.
> >
> > Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 83b4682ec85c..31d464e6a656 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2442,6 +2442,9 @@ static int __split_vma(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> >         /* Success. */
> >         if (new_below)
> >                 vma_next(vmi);
> > +       else
> > +               vma_prev(vmi);
> > +
>=20
> IIUC the goal is to always point vmi to the old (original) vma? If so,
> then change LGTM.

Yes, we need the iterator to keep pointing to the original VMAs, I think
this makes sense.  I will update the function comment in the next
revision to state as much.

>=20
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>=20
> >         return 0;
> >
> >  out_free_mpol:
> > --
> > 2.43.0
> >

