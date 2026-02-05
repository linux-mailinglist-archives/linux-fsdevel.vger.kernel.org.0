Return-Path: <linux-fsdevel+bounces-76410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGEkBF6HhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:04:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 855F8F2316
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E82853088CB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8A3BFE4C;
	Thu,  5 Feb 2026 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zntgn4L+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qLnf2o/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FEE3ACA71;
	Thu,  5 Feb 2026 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292734; cv=fail; b=URFo5wnS7OgHbIKidZxvbzYscUCrLltLWtqYifiYM5FYSXbvd1CiSebzvwh5pjBy/3jRNmgMiQsRvZH/gyfPKp7s7hQRbUHgFDaHXZkXn68KkcGkftYc8ngXTDajSPtSIuFGcPJuoCf1J4krydlvNG39QiBUBqArzxTcJ2DPKUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292734; c=relaxed/simple;
	bh=Y9jpRVt+Dt3QU6ngoThG//orXNGW0p/IR9s1smVI80I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4YHdhxiVWg/rEnpjVh2wQNgFiqnbdMfa5xvWvnm20djQjb0ONi1S2F49FP32iJsAo5uzanrDzpM7drTJkn/PEZOmFifQkk4FdfuKo/EA/W8cuf/rZ2vbts+UeECJG1ia6jhDHIFuCFdp77ExMZ9j9FivnzrYc+Cg7pe4gOC6/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zntgn4L+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qLnf2o/p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614N7nUr1717984;
	Thu, 5 Feb 2026 11:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bsK+vqGfal5dKaAiBs
	T/7V0Q//EWgCjKKA+2bYIonkE=; b=Zntgn4L+nJTx35xNqsmLnFjYSKhJgSiDOz
	A3PMo6e+lBfND+IQpjsnEuuTS6p/uJTIhf4zugF6z2yOG/DcUn7WeiUYuJZe5uCT
	QuHcfH9/0G2KMmso0vPg4qgPjnIqGLPN1Rz6YZ4jF20HChkN7/12yWE2QO6g+usS
	P1xJSrjy3SeFALvCe6Z7/olDmz8BYjpysHyRI0Gml0ICSXfImgQxaah0VsIteQx0
	i0x7MVaC+L0gVvHuPQjcB9AQ62dvTxPpSMRBMgJAAzZWc0R7vCgGJoQv6f7r95a1
	EE1p6WQSS8kUBxro9PspK9aQ5h4jDRYp+xnVVcFXco3ke1IjIqdA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb3kfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 11:58:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615Bq5uM018685;
	Thu, 5 Feb 2026 11:58:02 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186qkuee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 11:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6vJ4xDowduCn1lFUCtEchEtUn5VXOJPdkEKTiav+2WrbUZZ8aSH8vxLA95PywVv4Df0VCJSTrOnBF1w2obZmnwXm6RJYeZFdcX/osnCaPgVZIwVRc3lXQhv30IZnOV6swdC1mAuwU+RP96X8+1Mdp0gTgvux32V9PMxoTUyAvPcG6De0q9nFLXyxaymChLBZ/bsRFPNXXEgg7LOeE9sBNeGdeIFlKIKgzqsZ08g9+oHdAjToZXbPXGHzs7wmz+SM1iOBfHVKjsdd+0LowLbzTGZvGl2fzE8Sdl3e23jGzgOdfZqobGEHInkdPjWrqlGLpw9/ma1DleTOhFX2uxyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsK+vqGfal5dKaAiBsT/7V0Q//EWgCjKKA+2bYIonkE=;
 b=sMwgwPoGGibPl//hKsEoUINfJ4YnV+1XVaUTyIqq1LDrgrn+hLhW6ZKRsKAMj6PT7P3gwZuXN3a1sbewubVSv7AdyxeXj/DB/ghkMd5J54u9d+cKfeMR8DJGmrma+tLq6Quj/bMTel8hY3kpcF1nw+6f7r2NzeqBOW+6Hvq2ST+Ihilewb0Cwu3fFEXkxdLzue2pnU17WNjTFIuZQJZw+mC/rAmW41TvGkz0f/W8aenVdChi+Oz1jWi2NpCjXAcx4tA4vfWUqmKqbLDW5T1DFVIeGx1wd1bKlCeMtHd86EmCc5jhwQHUOIHGpdGp7TzqvWbgCvxa07l9YHHxwVqdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsK+vqGfal5dKaAiBsT/7V0Q//EWgCjKKA+2bYIonkE=;
 b=qLnf2o/pXhCtVtk6oVw2rYlynMJlZuxP/o6DaamY875lezNtYa/a2VltG4y8fZiMKaYg5XRKFF6GUEjQ9tZoeYSEnKjZUFaZvkaJEJ3fJHNwfRQrfgz6s4YW2iv+UdZ0k/kBLQjyEgypcv/mCVjZ4RMJR4l0hIp8XIiIDmkiSBQ=
Received: from DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20)
 by IA3PR10MB8515.namprd10.prod.outlook.com (2603:10b6:208:572::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 11:57:59 +0000
Received: from DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9]) by DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9%5]) with mapi id 15.20.9520.006; Thu, 5 Feb 2026
 11:57:59 +0000
Date: Thu, 5 Feb 2026 11:57:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
Message-ID: <ab63390c-9e75-4a45-9bf4-4ceb112ef07f@lucifer.local>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com>
 <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
X-ClientProxiedBy: LO4P123CA0428.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::19) To DS0PR10MB8223.namprd10.prod.outlook.com
 (2603:10b6:8:1ce::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB8223:EE_|IA3PR10MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cc7e36-0576-49da-578e-08de64adce66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7a5w/pJ3GrxK8L9X2l70Ui3Px7rUB8RV15Lfltk8Bm4rNGHvMNmFQbphmtyA?=
 =?us-ascii?Q?6WXhjumpv+a9OwsUd/QYTQ6aQjSEeDvDeDb5ICFS5B4CY1+olw1qVIkcKiZE?=
 =?us-ascii?Q?yMDk2cc2uPxdLQ6DOatrnZ2m+euimrxxn+iQUZJ54GbxaFSg8ND+P2UDX3qD?=
 =?us-ascii?Q?b7Og4rtj2LKSPfJCgo7odruyi1H+X+iJa1itebDtdYC3cb1D+dq7+wj3avi8?=
 =?us-ascii?Q?ELl6m/Lp3lmDk7AMz60wngu2ZvwWY8vQYXwNbOYIITlmcU8zjh0LmV+feHCR?=
 =?us-ascii?Q?7Teg7g9jogzqfaix28wwEFbMDzaC1MpvnQmCJiwdUS/xkaOoFJia3/mlhSPB?=
 =?us-ascii?Q?KYQFWEhV+HSzL15OcW5NpVDvlDhowAwiM8zsvDN+GDMLCSlgQXfm41aFEHX0?=
 =?us-ascii?Q?BcZhEKx9MDjtzxgCWopcdvHPrKfZ0+jjFP13zvP2/sb6d4Bfgzo4VpWgZz8G?=
 =?us-ascii?Q?qvZGqES0CTOI3lSNw+00Zz1OFtrPb4PHmAeDqRGn252ZQEmiBCpvd3yaMkbk?=
 =?us-ascii?Q?zALQ/UwV6vFk9k9Krkt+i/At1CRiJGPQMJxjcljddm425P7H15DTWiM5AreY?=
 =?us-ascii?Q?7Oj+D3YLOS4k75KQw/KA0DNDsRhz4eYfEPAM228bZfzyW4CBty+jSQcYLkkK?=
 =?us-ascii?Q?CdB+WDxKznFUUd6RbVH0fGPToEtT3M0lQuNpGhq2yoCi2Iu+GB4BEA8xS+EG?=
 =?us-ascii?Q?dxuUrrIMkJqBr2G7VFV/3hn/o10KORay8iO7gHtufhs61uDbHu2y/ThKLrC4?=
 =?us-ascii?Q?H5Gs1HzJesrgRu4kNUXfBliDttkua1e610g3rMRWUaiWIkxE3Qdv96X+Pa9V?=
 =?us-ascii?Q?8agebnHBE+RAoZ7+dIwBkKnkXJ2uva0hxfET6hnRsJC6arb9YkZkv3aDSyQw?=
 =?us-ascii?Q?S1FtDaJxxCocIgi3+7Aa/VN1TdFpOQduKBepD2TrXnBM9xaprkHin6s7XlK4?=
 =?us-ascii?Q?32FGGxkg3E++YJ//Tc96JF7TxjkIkfuDMm0+L1JZWRGeZ90bIOso/mfV2+To?=
 =?us-ascii?Q?uD95qSX4X+1Y0cmdeJ8yyikGsYcy2xB9fFFG4sYA9R2inFCLHGzDZT48s8fg?=
 =?us-ascii?Q?bgVNsUDW851Tkb90rX0IqILndlKRQUkSeac4V8YJMXzfn57+yGJ3/OMKEWTR?=
 =?us-ascii?Q?1JpD6b7q5GXgXpVkmewJDavm1FArNZ7/rjcKJC4aKcM2KZ7mgOcFyI7Thz/v?=
 =?us-ascii?Q?0bgD9LpbibNGwerv19/niIL7haIHjODP0UmeoDpMRyoFSZabizW9RYrQ3BlU?=
 =?us-ascii?Q?a5fPm/zwLp+9HekT2mUplZ/NWO6xUrJGF11wOkK3pf4ohJ9bd6rTFKYAp90t?=
 =?us-ascii?Q?LZtb+VWay8CapD2KU845gFpJXwZvZW+LfZ2wJ1q7uhzaqwPOGVyaANIZEvXe?=
 =?us-ascii?Q?iGygTAXQMZxjhx3Fb7BoQvVr6LNrmEtuB4Uu+GPvZg9vMOu9zIjA/ExR1hJF?=
 =?us-ascii?Q?gfa3PiuBwKUjocz7OcnBh2ziy0SjRjjdqU8kFnAlHPhAyjmGcPFcTDApHWSr?=
 =?us-ascii?Q?wNCW7A8WQUl32nUmKrVh+eloLkYfUVM1vwdFfZW3oDX7eIcLZbinx5XXAE6A?=
 =?us-ascii?Q?WaOamoka/8CXjUF/rKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB8223.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+km287NiOLAwrkt1Wn38TyhiVWfVps2Zxphs5PnufXP5mP36nAB50+sTiOp5?=
 =?us-ascii?Q?M3Ss4HKH0skPyYp9EyhC6hQojCzj1mvIh4w3zhftahI89Y6NcCDH4is+WyEI?=
 =?us-ascii?Q?uyyOqOzAAZWAdCRx9mE0jiwzofP+Q9W+pYNt01tyapP++8OsiroOtShPnpYN?=
 =?us-ascii?Q?iW6JnoxComvb8qyWCKhF7lWDsIcbGjFdnxChjP9qVUKZfxBH20OgFal7ZZ9n?=
 =?us-ascii?Q?yWVDXrPGwWd2gd2R+ShyVUs5VxhMtKWipz3wQgd9g1DyRJ4RJBkdQDYuJrZJ?=
 =?us-ascii?Q?AYZlpVr/cukLARsL/4ebtj5JXZutBubPj3MNUgMK299BiiBEDSiWnHHrnARy?=
 =?us-ascii?Q?yPoyjc0ASvQeqMxQYW0PXBBdCLYcJPFecXi76xSGjqFIKHzI4AjWEmN0QC79?=
 =?us-ascii?Q?iriEkxpzPKJRF1vxnS0f7AkCwVDouF+NSbp9zpJcRnpBV6H2GyPEY02gES8I?=
 =?us-ascii?Q?vQ503sxD+EyPFZpamB63SeyRaAcPacDb2/K1e8oQVidlybtvUvSLP4LTPzhx?=
 =?us-ascii?Q?wbmNmBnY4Bwrji0KdwXxa02cX6tcALHKYr+ZsIvJ/v5TeBpZewaPcpML7yCx?=
 =?us-ascii?Q?SCa72dgEA7c5SgcYRfWRMYw2qZ5zSa4/IosOCqeJmT0g0t9urEUprH+N2poe?=
 =?us-ascii?Q?AxPcBWsrHwRvEqFKQUNjQXWqMmKxJc0VWMhbmKCMyzIqd6KFqRPisbeynMde?=
 =?us-ascii?Q?Aapr/EsFJef7yCWcY4euyiN2dGvmG6CuVOsPdWLxf3Ooz0EnzT+oEm2RrHaq?=
 =?us-ascii?Q?2nIRywkmfA6sMGeTsGfI1smDimH/GT/Far93J7+I4b0Tz5hgXf+vliam84w9?=
 =?us-ascii?Q?0hvwBvUFHevTWjtBVIZqdQyzty9HqnG8Pct/Dn9a0Sruk78s7xtgSAl1y/g1?=
 =?us-ascii?Q?adZSaVJN8TvQatYmTCRiy7hOi3FfxJJGPSZ7nxlGYSo74bttHKtbSIt7ndVs?=
 =?us-ascii?Q?OBm59IvW41My7JQSF7I6a+d/gLT+81Sc6OhxddwFM7biiZrCUqTp4pTDXjy4?=
 =?us-ascii?Q?R/25lwhoxRL4j52AqOi7dBRPbhgEiCtonBFWXRcQbDxkVYfLNe+H9APwIoTi?=
 =?us-ascii?Q?l09/JtgQHuujT0oZXgO8v5a1mlOjqSIJYOXIl8piecrpq1ystIj7iEJXhvKe?=
 =?us-ascii?Q?sIEGlT7wGGN9Fwde25iZ+Dwv5+ePT+91Yr7w++/z1bTmMvAiZxD0E0iuuNH0?=
 =?us-ascii?Q?54ZDXuUV045HVUgh8yU0o32scxPj1cdfkskvBTGg7QoIjtkzE80U6wy+0Ypz?=
 =?us-ascii?Q?RpjL36MkXqIPiMEUhvtW4wSi3oQ48GvszytZfmOIXZZoye5ziQf54BZO1BZf?=
 =?us-ascii?Q?GWVjJyJDvRby8MDAU4Ni3UEOjJorINwiiJV0TYtpN0XVYsMjbGS+/LHZoN/I?=
 =?us-ascii?Q?etsLl6C1Ae5FiC0MLoY/bKOQ7jxVNTuO41aLjDdUqpXd+POlGncBHtt7pNY9?=
 =?us-ascii?Q?fXnLyqBXsnoMPRj0/Rdu1aQuJwb/zj1tvjJ1NRCzSFSTdE75di7m9NeLYjQL?=
 =?us-ascii?Q?xE4OOI5YMvjGYbj+yDcalsTzhzDqXcRtJRFUB0MGovUHbpH3oKBaBXjx5lNB?=
 =?us-ascii?Q?Qj4CPKvxU5keMx0CxvPg3oLb/qih94jPscGC4Ede7ddzkIJAKm8XspobukCl?=
 =?us-ascii?Q?pKm9/SEDN2oAljuJHvTvcf9zZgk5QyOJ7a7wmH3w6gEaoK3fSFMcG584EoUZ?=
 =?us-ascii?Q?RwnqH/M3muvnIuCC8Hx/r7piOClusd2XdrRtQu6ODVgm3fOyaAJMyXEk6jfX?=
 =?us-ascii?Q?/SPfBAbOvsiyMED1TUSPgsaHySGIP5c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i7TcqaH7/d6E+OVAW5BULfqlNYr/nSxR0HEiXgXyTcT+Id+jX74AJJdITOVcKKtHCJr5pFMQPlOIFks9KpeM8QtocUuFVk1y37bfBo7ePkaGnpjlzdooXdHDYhehPC5HMkwtGrV5AqWydL8CUgAhUD7A5AyvprB/zkAW2MYFxeTZ7S/PjhTfRsj4g+9yTuTSTf0Jx4q7nbTeN4yrMAT5FPihUYb3pM9kxt1Jd/HvMtnDYSxcp7eMXOv0zUEnHAQ9JysZkl7nxlMl2GfA5Fu37piOdLfozfnHc3NO7+pL7z/edgdaQgY++W/1RECGVTxrXAxAqIt8wqJFYCfWO5/ixdVQxB4HbFEsj8J9bjZy5B71jvOofwruxzyA5OK5IWSH+aPKoNdY7Wk6LEM5NxE5yVkO5qA0037hvpH2VT2PZdpeqk8sY9SJ6ob4yNG2zs/y7RNbpZBUPNWTHaID6DRDVjo4q4TWeVobW07E4WeqH5rDUmK/7FdZGlBsTusCmYX1+ZBfj+aFosTuO2xrBlRXFgrMLBfzCB205ytQTiIxHDrMUDrSTXCRWX1VYo1SrA3WhOX8nXwpeYlTxldASF/QyD5Fpqk+b4xQ+s/PMGWNL4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cc7e36-0576-49da-578e-08de64adce66
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB8223.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 11:57:59.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Qv+NjKnYkJ9MkeBeMGjXe36vXzmsybV4YFFfMMIKatqsaeajuOV04HXEiwBWN1zRgRuQU9zQGCSnbMJm5EB+7kOz8d7i/y+OILSOZg/Dy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4OCBTYWx0ZWRfX1AUzQdhbT81C
 pWW8Eg0MjGoazdeeq7dtbYgNLctYxi1bC8K73PQnauFPhSmB5/CkEBxWLuA8qya2llEddJ86khV
 R/WJhkFHzIIP1rawDDHk3/KdAQ1oXuSNXrGKJUkHYEaS+fJwh/oO4hhfkX8Tl5LfxlO8JaVpjJw
 3BeUGpPaRgOxuzFRJgQS3ykDpg497pPgwvl0/WuQS2VgFdhlb+g6CrO1a8+FomY5lIwGGpsXH3v
 8q/4+CNnlXZSgzHomjgi2NJTyR9qATZPzZ4ixs/brfFTSopx2PAmor+q3upgOoclbt9qjoa8iUx
 5o/K6jNPV0Kj5AIlCIwyEzQF7N6jVYHx1Aljvx0zgcgii7lOcvpMOomzUn0pq8FPPzLCU5Or2Pa
 2s/7fLpBbBWwCWFMi+zBI38NBIExZKkOaKQiATM88QGYp9Igk6pRJqrlfg0iGy/l/f832vVGvWu
 UTMknX99IsGUqiWtyqiaW2lKBee7mqic4O66JPck=
X-Proofpoint-ORIG-GUID: fR2i-jTCojGkin7yDDfhNSfFzD0rvPxT
X-Proofpoint-GUID: fR2i-jTCojGkin7yDDfhNSfFzD0rvPxT
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=698485cb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=grDJtCt9INGPdPqjOVgA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-76410-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid,oracle.onmicrosoft.com:dkim,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 855F8F2316
X-Rspamd-Action: no action

+cc Christoph for his input on exports here.

On Thu, Feb 05, 2026 at 12:43:03PM +0100, David Hildenbrand (arm) wrote:
> On 2/5/26 12:29, Lorenzo Stoakes wrote:
> > On Thu, Feb 05, 2026 at 10:51:28AM +0000, Alice Ryhl wrote:
> > > These are the functions needed by Binder's shrinker.
> > >
> > > Binder uses zap_page_range_single in the shrinker path to remove an
> > > unused page from the mmap'd region. Note that pages are only removed
> > > from the mmap'd region lazily when shrinker asks for it.
> > >
> > > Binder uses list_lru_add/del to keep track of the shrinker lru list, and
> > > it can't use _obj because the list head is not stored inline in the page
> > > actually being lru freed, so page_to_nid(virt_to_page(item)) on the list
> > > head computes the nid of the wrong page.
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >   mm/list_lru.c | 2 ++
> > >   mm/memory.c   | 1 +
> > >   2 files changed, 3 insertions(+)
> > >
> > > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > > index ec48b5dadf519a5296ac14cda035c067f9e448f8..bf95d73c9815548a19db6345f856cee9baad22e3 100644
> > > --- a/mm/list_lru.c
> > > +++ b/mm/list_lru.c
> > > @@ -179,6 +179,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
> > >   	unlock_list_lru(l, false);
> > >   	return false;
> > >   }
> > > +EXPORT_SYMBOL_GPL(list_lru_add);
> > >
> > >   bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
> > >   {
> > > @@ -216,6 +217,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
> > >   	unlock_list_lru(l, false);
> > >   	return false;
> > >   }
> > > +EXPORT_SYMBOL_GPL(list_lru_del);
> >
> > Same point as before about exporting symbols, but given the _obj variants are
> > exported already this one is more valid.
> >
> > >
> > >   bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
> > >   {
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> > >   	zap_page_range_single_batched(&tlb, vma, address, size, details);
> > >   	tlb_finish_mmu(&tlb);
> > >   }
> > > +EXPORT_SYMBOL(zap_page_range_single);
> >
> > Sorry but I don't want this exported at all.
> >
> > This is an internal implementation detail which allows fine-grained control of
> > behaviour via struct zap_details (which binder doesn't use, of course :)
>
> I don't expect anybody to set zap_details, but yeah, it could be abused.
> It could be abused right now from anywhere else in the kernel
> where we don't build as a module :)
>
> Apparently we export a similar function in rust where we just removed the last parameter.

What??

Alice - can you confirm rust isn't exporting stuff that isn't explicitly marked
EXPORT_SYMBOL*() for use by other rust modules?

It's important we keep this in sync, otherwise rust is overriding kernel policy.

>
> I think zap_page_range_single() is only called with non-NULL from mm/memory.c.
>
> So the following makes likely sense even outside of the context of this series:
>

Yeah this looks good so feel free to add a R-b from me tag when you send it
BUT...

I'm still _very_ uncomfortable with exporting this just for binder which seems
to be doing effectively mm tasks itself in a way that makes me think it needs a
rework to not be doing that and to update core mm to add functionality if it's
needed.

In any case, if we _do_ export this I think I'm going to insist on this being
EXPORT_SYMBOL_FOR_MODULES() _only_ for the binder in-tree module.

Thanks, Lorenzo


> From d2a2d20994456b9a66008b7fef12e379e76fc9f8 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (arm)" <david@kernel.org>
> Date: Thu, 5 Feb 2026 12:42:09 +0100
> Subject: [PATCH] tmp
>
> Signed-off-by: David Hildenbrand (arm) <david@kernel.org>
> ---
>  arch/s390/mm/gmap_helpers.c    |  2 +-
>  drivers/android/binder_alloc.c |  2 +-
>  include/linux/mm.h             |  4 ++--
>  kernel/bpf/arena.c             |  3 +--
>  kernel/events/core.c           |  2 +-
>  mm/memory.c                    | 15 +++++++++------
>  net/ipv4/tcp.c                 |  5 ++---
>  rust/kernel/mm/virt.rs         |  2 +-
>  8 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index d41b19925a5a..859f5570c3dc 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c
> @@ -102,7 +102,7 @@ void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, unsigned lo
>  		if (!vma)
>  			return;
>  		if (!is_vm_hugetlb_page(vma))
> -			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr, NULL);
> +			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr);
>  		vmaddr = vma->vm_end;
>  	}
>  }
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 979c96b74cad..b0201bc6893a 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1186,7 +1186,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	if (vma) {
>  		trace_binder_unmap_user_start(alloc, index);
> -		zap_page_range_single(vma, page_addr, PAGE_SIZE, NULL);
> +		zap_page_range_single(vma, page_addr, PAGE_SIZE);
>  		trace_binder_unmap_user_end(alloc, index);
>  	}
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f0d5be9dc736..b7cc6ef49917 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2621,11 +2621,11 @@ struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
>  void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  		  unsigned long size);
>  void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> -			   unsigned long size, struct zap_details *details);
> +			   unsigned long size);
>  static inline void zap_vma_pages(struct vm_area_struct *vma)
>  {
>  	zap_page_range_single(vma, vma->vm_start,
> -			      vma->vm_end - vma->vm_start, NULL);
> +			      vma->vm_end - vma->vm_start);
>  }
>  void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  		struct vm_area_struct *start_vma, unsigned long start,
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 872dc0e41c65..242c931d3740 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -503,8 +503,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>  	struct vma_list *vml;
>  	list_for_each_entry(vml, &arena->vma_list, head)
> -		zap_page_range_single(vml->vma, uaddr,
> -				      PAGE_SIZE * page_cnt, NULL);
> +		zap_page_range_single(vml->vma, uaddr, PAGE_SIZE * page_cnt);
>  }
>  static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8cca80094624..1dfb33c39c2f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6926,7 +6926,7 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
>  #ifdef CONFIG_MMU
>  	/* Clear any partial mappings on error. */
>  	if (err)
> -		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
> +		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE);
>  #endif
>  	return err;
> diff --git a/mm/memory.c b/mm/memory.c
> index da360a6eb8a4..4f8dcdcd20f3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2155,17 +2155,16 @@ void zap_page_range_single_batched(struct mmu_gather *tlb,
>   * @vma: vm_area_struct holding the applicable pages
>   * @address: starting address of pages to zap
>   * @size: number of bytes to zap
> - * @details: details of shared cache invalidation
>   *
>   * The range must fit into one VMA.
>   */
>  void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> -		unsigned long size, struct zap_details *details)
> +		unsigned long size)
>  {
>  	struct mmu_gather tlb;
>  	tlb_gather_mmu(&tlb, vma->vm_mm);
> -	zap_page_range_single_batched(&tlb, vma, address, size, details);
> +	zap_page_range_single_batched(&tlb, vma, address, size, NULL);
>  	tlb_finish_mmu(&tlb);
>  }
> @@ -2187,7 +2186,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  	    		!(vma->vm_flags & VM_PFNMAP))
>  		return;
> -	zap_page_range_single(vma, address, size, NULL);
> +	zap_page_range_single(vma, address, size);
>  }
>  EXPORT_SYMBOL_GPL(zap_vma_ptes);
> @@ -2963,7 +2962,7 @@ static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long add
>  	 * maintain page reference counts, and callers may free
>  	 * pages due to the error. So zap it early.
>  	 */
> -	zap_page_range_single(vma, addr, size, NULL);
> +	zap_page_range_single(vma, addr, size);
>  	return error;
>  }
> @@ -4187,7 +4186,11 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
>  		unsigned long start_addr, unsigned long end_addr,
>  		struct zap_details *details)
>  {
> -	zap_page_range_single(vma, start_addr, end_addr - start_addr, details);
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm);
> +	zap_page_range_single_batched(&tlb, vma, address, size, details);
> +	tlb_finish_mmu(&tlb);
>  }
>  static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d5319ebe2452..9e92c71389f3 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2052,7 +2052,7 @@ static int tcp_zerocopy_vm_insert_batch_error(struct vm_area_struct *vma,
>  		maybe_zap_len = total_bytes_to_map -  /* All bytes to map */
>  				*length + /* Mapped or pending */
>  				(pages_remaining * PAGE_SIZE); /* Failed map. */
> -		zap_page_range_single(vma, *address, maybe_zap_len, NULL);
> +		zap_page_range_single(vma, *address, maybe_zap_len);
>  		err = 0;
>  	}
> @@ -2217,8 +2217,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
>  	if (total_bytes_to_map) {
>  		if (!(zc->flags & TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT))
> -			zap_page_range_single(vma, address, total_bytes_to_map,
> -					      NULL);
> +			zap_page_range_single(vma, address, total_bytes_to_map);
>  		zc->length = total_bytes_to_map;
>  		zc->recv_skip_hint = 0;
>  	} else {
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index da21d65ccd20..b8e59e4420f3 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -124,7 +124,7 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
>          // sufficient for this method call. This method has no requirements on the vma flags. The
>          // address range is checked to be within the vma.
>          unsafe {
> -            bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
> +            bindings::zap_page_range_single(self.as_ptr(), address, size)
>          };
>      }
> --
> 2.43.0
>
>
> --
> Cheers,
>
> David

