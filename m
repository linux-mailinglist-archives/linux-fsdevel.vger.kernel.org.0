Return-Path: <linux-fsdevel+bounces-74502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4DD3B328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1933030C0226
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D83009D4;
	Mon, 19 Jan 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EVvp6y8p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x2CH6qUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F017AE11;
	Mon, 19 Jan 2026 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841592; cv=fail; b=l/KsbJ6UO9PaBBIQJIoHFUi69mj9EsOnH5lFYGpNRUsfkgGYKOkKpopCP9tscKzPPeTu5BbbPEnp58RcrokzJYMrnsugzNNtLBYHnBVPoItH4qkESgJ0SLlhFzopb4/AupGjLenRKSG43ZZ9261RNW64Vcwv7qlsY4UIUd4XbTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841592; c=relaxed/simple;
	bh=nt5o8DJJiPgY3YOUBsCIyzyTNknjcmt1VBCrFUde2ac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qXLJPD+tNvbDbQdB8+lqWOAfot1seg8E5rCvvDKDEvDat7ac/ki2nBTDF0yZhL76zuC7EnppPshsimRvDA5oII1u9LEu8i6Or162jR5oAH2+eJe/531tNdcA/EGXloK5GB5WZ1ubv+G8z0Y2OH8K+ideeDoLsq6/YCwevwbu6hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EVvp6y8p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x2CH6qUz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDPlN1341814;
	Mon, 19 Jan 2026 16:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OELvrGJwOqeDf8e/Wkg7kXRXlB8hxtTi+pYr/JsU7tQ=; b=
	EVvp6y8pkphL8faysyhI/wKJIrJe+GaOm303XNoYlsYsHEsQWKCp8jL3gAgAC1v5
	eqEat3hQGzM1DCBZO3hwRjsJWVL/XAnrdvYDwGZ22JvMSfqc7UK2M/mYN0sxNStV
	agfn128+2xRDO5mMEpJFgY7XuMekUurziJZUH8CVXjHI85UEvI5SGbLZuOELH+Ny
	HenUKeWuU6jfy3AC9mDPMAZQexbx4ZrGxHrFsemRbcMwzx9FIv3OAqjVpWHDr3bI
	sA+Ybnouj7psUpitCwfJsYw0KOxhRgtlu2Q7vBB9NaXd7d0ZRDOwKJmv5Lcb6yji
	xIaz8oxn0L9Icp7K3MbRvw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br170ajss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 16:52:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JG6fDt018321;
	Mon, 19 Jan 2026 16:52:13 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8jua7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 16:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdzzggupJwhC5faUbtmImqdoMpj2HwD/nuWFnpnfOjRJRLMm9fd7LArBqlNgmCEVyqU+nE8FFLUj/ugfdRSivmuucFAI96vfvaxNrsbLKjGb13u78z/NCg0OYytsm5XdlGHaPFeRq3I6E18EScbsLVXr2E9RVrYvemUD88mY/pZK7+J7fWcWl3aR0kuQLRG7V9YtiCUDQn327huUU/e98snRRbnANyHyih1j7zW+O+VWNt4ajMs0glgApArLy231YTatOKpU8X+JzdoLXMDmTBh1cziL8WI2Abet0GnGZq+BJJPIGCdB/x468wdfmHasRZ223tmgPF6qhTYPHlntIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OELvrGJwOqeDf8e/Wkg7kXRXlB8hxtTi+pYr/JsU7tQ=;
 b=anqxF1nq9WhwAeOI/1ekNPl0QU/j/+8/MYQNxmRMkJ2DGi/yGfUavi4GHwP2upKlZ4aNeWMgUoGl1pnkWqX54ISdMqlUTE7AxBCdRfuHZ6AhQo25tFCDJlVTtSBX25FLB9VBH0CUKvmrWRBxBd36FYlP9g8Hab1zduI4Y0D1seCzdmxRi9UDs2dz3W1qyvYdiqHbebhrFKZOcEg2fg/KKcVd5k7iAD3MD5jDyXV6510fQQ3HfOiTxAMx4VVR0PXu2+04YL1W1MDzcjCHRRUgPJEKR2deMPcinBcec0Dn9Pykp4G3mITh2rVsk/+LdSWwNbUaBIS1KDPUsAkMDjt3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OELvrGJwOqeDf8e/Wkg7kXRXlB8hxtTi+pYr/JsU7tQ=;
 b=x2CH6qUzTD8aUV5kvHIZicM0UAcTlRglXGJekj+6SYuOjr3fCqekwyvsRr85wSGu4WiDmarFqc5+V9B5d2N2vmuguCH1jEEAXHO9cJaLh/EgPW24OHYQgCrvtjbUH8var4fWlEakRSyTajDRqY4CBGJMwlL1JoCVFJuMxlVJ5hg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 16:52:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 16:52:07 +0000
Message-ID: <d078e70f-33f0-4f9d-8489-c39815d0641b@oracle.com>
Date: Mon, 19 Jan 2026 11:51:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/31] nfsd: only allow filesystems that set
 EXPORT_OP_STABLE_HANDLES
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
 <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM
 <bharathsm@microsoft.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg
 <martin@omnibond.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: David Laight <david.laight.linux@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
        ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
        linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
 <20260119-exportfs-nfsd-v2-30-d93368f903bd@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260119-exportfs-nfsd-v2-30-d93368f903bd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:610:20::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 9000baee-ef21-447d-3dd9-08de577b14ab
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MGtwK3BpRTE0bllVS0VwZDY1SllVeDU2N2xzdkp1RCtUTnlQUk4ybFdFdjBt?=
 =?utf-8?B?SEVKZ2hSN1NLMzZOUHVqb1c1d29nOEVSME5nb05CV0xLeDZBZzlVUkRDSG8r?=
 =?utf-8?B?TmRKcnE0bWJHT243RGFtZkhqemttd0lSdnJTSXVSbkFPVFV1a2U5dmdrRHBB?=
 =?utf-8?B?M25xOVFPS29DdHRrdkovZmd5eXdJS0FJY2dpVjNIMy9ITk1Vc1NIMGI5TSt0?=
 =?utf-8?B?a2dXL2VqV0ZzaElMTGZWZzhYbzR4bVlXTGlrWEcyaEIrdGZwUm9WbGpWc0c2?=
 =?utf-8?B?TkpGb2MwNGxmdzA4T3NKcU9rbmY0YjZFUjVXakl6OTd1NjhZenU1UEM2NHY1?=
 =?utf-8?B?dzN0aUJkUHpnYXNxbmJJK1NSd2gzZXYwY09HU1hHQVh3MldLc1J3T1RnYWVV?=
 =?utf-8?B?VmRCRmFKQmo2cks0K3lIR1Rjd2JwdVVYL2E5VjdsSTVYVC9vejAzZit6L2ZW?=
 =?utf-8?B?Z1pLaTZneG4rYmhiWm5VdE9nSnlTWWUvT3habFc2amZxOGtRWVRYVmF4dm5O?=
 =?utf-8?B?Y1ErZXJadmQxcGVQQ3NZR0JaQ0V6NmR2VmMvaEFlZEMyeW5CQmxJV2ozRm85?=
 =?utf-8?B?cXIzN1dJMURCVUgwRFlTSEV5RzZNT0g2WElTN2lNN1NZREkxU0RhUlk1azJX?=
 =?utf-8?B?UldhZ0ZmMXdZb2JRcUxyUndoU1BNZHFGUDd5OWVQVnpEQmdSQVVQUk5XV0xL?=
 =?utf-8?B?L1pwMVVJOFFaMGZ4b0tUWFZvVUZQMldCTkI5VVFQL2dodldBZERpMnJiL21W?=
 =?utf-8?B?b1pzb0hERnpsVHhxYVNxKyt1cG9EWCtGWm1RTXZhNkdsWWowR0RSdUFTVHVV?=
 =?utf-8?B?VkZTSWlkeEs5QldJcllJN08zMUZuYWhPaVlpYlNOeXVUVlZ2RGFPNDg4OHRY?=
 =?utf-8?B?MkdqMjd4VEpJVkNXSWI3RnhXZGpMSmcyOVNDTWRteXkvaEh2dUVyckZpUnBR?=
 =?utf-8?B?ZXQ3dlVIdFdudTR4ZGhmbWlTQlBiN0w1Y1RWbWR2NjFVREgwK0ZPZlViY2NH?=
 =?utf-8?B?VzhXN25kZ2VzTURCM1JYMTNXNzdKd245QlI4V3Q3RU8yeitLOU5QU2wxdmRz?=
 =?utf-8?B?VkEzTy9NQytaY2tVRHhLRlZIKy9HOFV2LzBqcjJacENEanJpWk1pRXMrellR?=
 =?utf-8?B?dDY0ZGZOT1JsUnRaV1hVZm1VSTllOG40bHQvZitsZHVnSFpQRzQyUmthOG1u?=
 =?utf-8?B?c2VJWUpOSTBTRjZEamZGMGtKejk2bkVHTzBieDU1TmdGRkp6WGs2empwaEVZ?=
 =?utf-8?B?dEJOQVRrcDREVXZRWC91blQzVkJGOUFaWmRETmVJQ21NcC96dmRnNHFLUnl1?=
 =?utf-8?B?QlRNeS93bVhNWkRjMk1SYys2U0duZlkxR0hzWWFyNjdSUlhxdEVkVi9qZExs?=
 =?utf-8?B?Zy9FNmlmN1IwZWRuZEJwWWtPU2hzekM5Mm9XQ1A2VUttd3VZVWR4MUdjOUxh?=
 =?utf-8?B?czdBbHpvVzZOOThnQlF4aW9URFFYVjFwOUFFdENwUXdLYmZGK2VqdXRVQ2Nq?=
 =?utf-8?B?RmVjQm5KbDJoS2dvZWZaUmdhaVZhZFJCREhEbTFLdEk0MjNoWTF3VVlaaU1s?=
 =?utf-8?B?TEZOQk5ya2lhTXcwb1dlZFU2anZ1aHpYTE81SkloRjVPY1RLSG5qMnpNQWJH?=
 =?utf-8?B?RVFpVlZzWHJ3ZjFJa3ZaQjA5TmhTdFoxRTlEVG5qUUljZkxSNHJhdGloenlK?=
 =?utf-8?B?TU1VUmxGMVhlZTR4ZnNyelROWXpNV3VsWWliZU9RdkQ5SlQ0eE5iSFZpaUhw?=
 =?utf-8?B?QXVocW5aaUM0NDV6OWJsaGg5cUs1ME5VQzNadXEyR0s2c0RtZGdwdTJSc05Q?=
 =?utf-8?B?WWxoS3puWU5kKzgySGNINjM0RjhDYWUrZ2xqOVFDNEtMTGV2QThmN3I4WmJa?=
 =?utf-8?B?RG5GYVNjUHF3a0c4cWMrODdVcDVNRXA1a2thZUR6Vkwrd09rZVpnV0hpRG4v?=
 =?utf-8?B?Y2NyT05FREJEbkZCbDNSQ0VEZTFneWFtWjZUQ3I0ek42ZzR0QTFXTkhVRVMw?=
 =?utf-8?B?SlU0dWd2RjRlNUczOHlJbWxEUXVwWHMwWjFTcHNhRXU4NzdmdUh4aWoxMm9m?=
 =?utf-8?B?U1Z4cmJHUlhCR3diREN3dzVvZHcvV2V0T2RzdWVQbEpRNVdCa243eVByS0Vv?=
 =?utf-8?B?ektNN0hFSXFYa3F0OXFPRmtHT0RYQzZlL0Z3MjVVeU1TRmJYQS9Za0tRdlhi?=
 =?utf-8?B?U3c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eGZEQnlIU3g4eWFCTkthZVRuYjEwbEZVN3U3M1JBZEJMbUlxV1lwelEvbVFo?=
 =?utf-8?B?WHh0dkhKMStHazdsN0R3bVRUekRScHBnOXNmV3pvNVZkdXphYTlXQTl5Uk9E?=
 =?utf-8?B?UHBOWmV4TFlxUzI4VDJ6QlBEWWNkQmo0eENWeExSVTdNTkJZWkZJZ3cxc0Zm?=
 =?utf-8?B?SlBYUkxFMzlFSVpqQXJoaGlXbUszYUYzc2F0bXV3RFFQM1Ztb21VQ05OeHly?=
 =?utf-8?B?N1JpSWl5Y0VhZ3QyMEZ5cGozcmhEMHdCc3A3aGY2dnBEVDU2T0llU2phYzVy?=
 =?utf-8?B?QlJnaEE5MFZKMk5MWlFDV2UvMDBPSForRVdPSGRIanlibHVteTM4cExnYjlX?=
 =?utf-8?B?VmErR3pFdjBHdlVIYmtYdzFvUXdXN0diejNkeVdtVUkwWEVET2s0QTdESVV1?=
 =?utf-8?B?dUVOMTRVV0MvZjl2Qnl5OVV0NEFocTFDbEVvWGZvNVJoWHNFRlNyRzFLTFBk?=
 =?utf-8?B?d0U5ejZKYmdGKytpVWVhZEZta0JHSnE0alpUSzZqc0NuMWFkT0ozNnNCTTlM?=
 =?utf-8?B?N3N6RktpZU1ia01GU2ZjKzhJR2IwNXk0a1ZaR25jeVF2RkV3R3gybk5kTzda?=
 =?utf-8?B?cmoxMXE0MzI4Yk9EQ3cyQUhXWkN1Nlp5S2trN0IxOGJvUmo4dUJnclA1OTlO?=
 =?utf-8?B?ZDlVOWd6YmFacGNtOUNmUTlvOUNWdWs2enVPYVN6ZWxGeFpqbVk5T2trd0lR?=
 =?utf-8?B?bEtvaXNUd2cvMGNzMytXektYTEltYzdRMjZ2b1ZpcWF0a0dva3FvSlFEOEw5?=
 =?utf-8?B?RGxHZDRYM2JDSnZzWXYzSjh5RXlwbFVGem1FVnN4aUJJaGFXNmtDMUpkcUs2?=
 =?utf-8?B?RkVXWWdDaXhlUkVqdGMvYnN6Q3R0VldDbG9xOFRnNEtsSUcxbklwQmcwSGcz?=
 =?utf-8?B?YmdpRFkwZXJ2ekcxYmJneUVSbnQzL1dIRGhDSmROd1I0cTFJd2ZSRXZHUkJN?=
 =?utf-8?B?b0RJRHBPRmZjaldRdkw3Y3JTOHBVUFhvbFNzQkg4c1JLKzhJK29Ob3V2ZGpW?=
 =?utf-8?B?NGhic1huYUxFWWhNQUhCdlNKL3l0WEhUcEpsVjR6eFRQVUdjbi8reWZWL29L?=
 =?utf-8?B?cE9aMWphZzZLU3NHVFVsQi9JL2xDSFJDZW5qb0J2MEJHNWlpM1gvQmI0cjJN?=
 =?utf-8?B?ZkVqTnRTbXFBL1R2UzY4WEg0cG5yY2RleGNtckpCbDVLbEF3Z2JFdlFMUUY0?=
 =?utf-8?B?RlRsbWVQcEVjTnJNeXd2NHlxUmpCYitQdytrZ01HYjNWeUhGSlBrWDU5Tnd4?=
 =?utf-8?B?WHJ3SjRtbWNPSE1nL2ozT0NWeVNJbEY1M2krZHZxQXd2NDFGZ21uWnk5RU9y?=
 =?utf-8?B?WFVjVjhBUS9aTFFZRFJxU1ZRMGNRR2xpWjNOUXp4eHFzOHNzVlhXQXVKNnQz?=
 =?utf-8?B?aVVQWHh3UEVXdWZzejErcW9LOUVkeVRsMmNXdThKVXMrcHpzc3I0ZXkrWTRM?=
 =?utf-8?B?WU9abDdvOWcxNnluTEs1MGJidmNnVFUrVTRzM2lwUld5WmhBTFVRcHhzSmdL?=
 =?utf-8?B?N1R5MFNQY0FKcjdTdEg2WVR6QWJzN0JIOVVoeHNXVVhWUGpTUDhYQVlWOFFP?=
 =?utf-8?B?a1paTldodTI4THNlL2FqMnd2NG1rUjdUd1VpeVY0clRJWm12Q2gxTS9FOW11?=
 =?utf-8?B?QWFvbVkzYXRSUThtODFtTDBPT2V3T3JLS29VRFFTbjk1alMxL21FYkZ4TGYx?=
 =?utf-8?B?SUxmV3I5ZXh4WlA4NU5GVVN3SHNKcldDczBoMktlOFJKTFNHOWNDYmtZS25F?=
 =?utf-8?B?dzZSalhXT3RjRnlLRVpUYzlMTU9GZmJKR2JaLzc1SEtWUjBnVWRmc2ZIbFcv?=
 =?utf-8?B?QnRZNmNOUmpvVEFDZjc0MHUvd2xMOTErUFk0dUVSUzZwbVRJL2k4UEdiN1VH?=
 =?utf-8?B?L21LbHowcGU5cVF6TXQ1Nk9BSXB6LzdnMU05b0xZMEovaWU4V2U2Q2UyYStZ?=
 =?utf-8?B?ZkhVTHN2WWhEWEk2MDhqUGVIVytpNDZXdUEvYXBZcmt0YnZ2ZTRJcVVKVmlv?=
 =?utf-8?B?eGhXWnB5aGU5aXcweVNqTEZZZVUySFp6NjFqVCtocmZzQTlJRWhSRTBRL2N5?=
 =?utf-8?B?b2VrTTJvRDM4MUtxS0I3VVI3U1RQMzlpWmxXamNsNW8ycytRWXpqUWVuekl1?=
 =?utf-8?B?TkhYQzZZcnk2VzUvQU1VWjA5RHFsRFM5WnBPV1RUem9GU1FSdkVhRlVhSER5?=
 =?utf-8?B?VWJCbGt1MXpZUE1nTE8xbXBDZFlNeWZ3OUZobDVTT1hkVDVrS3U0WTlpS3BN?=
 =?utf-8?B?UHU2UnNISm1BKzJ5b2pzZE1oQzVGb01HNjRoWkpYcFdpdGRCTUM2RkRDNW10?=
 =?utf-8?B?dDYvQjJHNDJiL01kTjNVYUs4OWVzMkQ3VXRWY043a1VrdjQ2QnRkQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E6INt8fXoFOrvcuDHCUbyH774j2mWLFXybhRPh0SuxpmEi4m45MFNI7Q2ZBGQTuyb7AGPd3O4K8aBjs4Eb3nMhOP/EVoXTrdJjmXCUetBaL6SkGPvJKlgUK9nLaJqK9C645pYVzfIGiXTC9aOxZxVVZaYkuc5MLCJRf5Wbi/J+UjA+E6LgyWxxX9e+muwuz1q5fI6KsCcrAAfyKUvY3aAQS2ENlZ+VAhSg3JzT7JzMJNkoSBuHclnKfLJhSCu+XsfQVPKpfBo6LpVOp4urVywA2cAj4tW3kilspmwGSfGC/FD/SIyuuwjhJJnYU04niL/VkLQfJEETCaKXS1OMRxX0fvlCDyyURJ3wqlTO6Wq9fA0A+WbKhD78igKx3RxfJggOczsotNNb52kxW2NBcRCgYi9dZsbkX0rwLePsgJF/BijZBiqMj25EF4pX2/z2k7WhIcpUS0vhxNRBevifrOIJyg/AT+Fw5G1L/yfhbEZ35H6xtiz+xtDNreAAvytsCm4OoWL38aiOkBJaxWMhwRWiqJPcHFicfUsP/Q/8MyhOmUqv7vbAfegaNfNY+YMvmlDh+GE40N9DuFeBqPga5aqBjnrqniwCRY2dhJ+1R0W4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9000baee-ef21-447d-3dd9-08de577b14ab
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 16:52:07.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p52c4K9TPQ9dc5Qarl26XpikyFMJOnqUl/QvOX2EzAN+/wM8Fbd3W+BWHYmvewg0xho461ALtxEDWgrjtMiU4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190140
X-Proofpoint-ORIG-GUID: XD46C4D3AFhpDp7vxGDyCUZXWI13o3fj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MSBTYWx0ZWRfX83cpMBI4rufG
 BFEFdx0RCxRDPOojBgaQOrGS6A2pO+MLgv3LeOCtDU2kuobjea7mP3CApXcAKFxgK3nxVtYRYwz
 JHe2gyHXZv6MIkaCtHddFCIdHvC5l2ty3V7LOBw6n7QAcZBQLtgG4jQNp9zTtzEUHbwaG2Fvtda
 ogMxQkc1bk4VwNy0jkcNGv5tjuxO4Kpxahj9Rh4GBZ1OWeFIvBia/+XM99UCGO3gMPpTL2RcO2K
 dypVGqTfjT7+J5s4dZJqJe0R9f4mjE0tVhEqFmqLPtKPdZ2hYiQcc5kVAIxTtX0XhAi3l//ErND
 UNGPKu8rgPqwLi7l5RKDq1c+G6TiUXMEB2FSrjVqj0/q1r0miZaWfK2JhCunbIZrVvVko4IBEHp
 NvUPmYz4VEH6KoWvtzS6jX3aWIpMWtQzsHNAGIgmyNMBwpWa2NGe1jqj6TBFHV5aAX7hPsJ5Zhn
 vc29lNMRGQzPRErrBQg==
X-Proofpoint-GUID: XD46C4D3AFhpDp7vxGDyCUZXWI13o3fj
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=696e613e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=gVwGJOpa8nLn2RacUcwA:9 a=QEXdDO2ut3YA:10

On 1/19/26 11:26 AM, Jeff Layton wrote:
> Some filesystems have grown export operations in order to provide
> filehandles for local usage. Some of these filesystems are unsuitable
> for use with nfsd, since their filehandles are not stable across
> reboots.
> 
> In check_export(), check whether EXPORT_OP_STABLE_HANDLES is set
> and return -EINVAL if it isn't.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/export.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 2a1499f2ad196a6033787260881e451146283bdc..bc703cf58bfa210c7c57d49f22f15bc10d7cfc91 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -422,13 +422,15 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
>  	if (*flags & NFSEXP_V4ROOT)
>  		*flags |= NFSEXP_READONLY;
>  
> -	/* There are two requirements on a filesystem to be exportable.
> -	 * 1:  We must be able to identify the filesystem from a number.
> +	/* There are four requirements on a filesystem to be exportable:
> +	 * 1: We must be able to identify the filesystem from a number.
>  	 *       either a device number (so FS_REQUIRES_DEV needed)
>  	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> -	 * 2:  We must be able to find an inode from a filehandle.
> +	 * 2: We must be able to find an inode from a filehandle.
>  	 *       This means that s_export_op must be set.
> -	 * 3: We must not currently be on an idmapped mount.
> +	 * 3: It must provide stable filehandles.
> +	 *       This means that EXPORT_OP_STABLE_HANDLES is set
> +	 * 4: We must not currently be on an idmapped mount.
>  	 */

Let's avoid the royal "we" here... It seems to mean something
different in each of these rules. How about:

1. The filehandle must identify a filesystem by number

2. The filehandle must uniquely identify an inode

3. The exported filesystem must provide stable filehandles

4. The requested file must not reside on an idmapped mount


>  	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
>  	    !(*flags & NFSEXP_FSID) &&
> @@ -442,6 +444,11 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
>  		return -EINVAL;
>  	}
>  
> +	if (!(inode->i_sb->s_export_op->flags & EXPORT_OP_STABLE_HANDLES)) {
> +		dprintk("%s: fs does not provide stable filehandles!\n", __func__);
> +		return -EINVAL;
> +	}
> +
>  	if (is_idmapped_mnt(path->mnt)) {
>  		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
>  		return -EINVAL;
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

