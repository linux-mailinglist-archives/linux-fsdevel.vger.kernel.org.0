Return-Path: <linux-fsdevel+bounces-43266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DEAA502F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D35B1652EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45B24E01A;
	Wed,  5 Mar 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N1MK/53i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rse3bnRV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEA24394F;
	Wed,  5 Mar 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186550; cv=fail; b=l6l5eDB7iPz4iKL1PJk7r3VwkNMVBy/+fx+6koskxjQSiXJtvnsBZ9pbHBUYiqq9o+ADavPEaZ9Hc+nfTowRjhij1Q5j8VhETCNQKz1ukpXu3BSk8H/uJUPRbJs+m4QwwCRGL0iQG9f9r8Xr3L0g5nadNlYg6nYnGdhVAmnpVSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186550; c=relaxed/simple;
	bh=g9xXsDWmtS/3DgrEEHFWSucKQOuag0BAb38zMXZhR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fc+sQDxgsHTZcvnc2c+1AXLg+NEO+azn1OS+11+/YRMaAXaaS4O45uOdQuRqlsg+w4RFo/n5/goUogDqQFgCqE7w1+Q2EtT8etx6tChRnlgHnO9Y2WXXr65JctsyBo7geUdspsLJplIZirXzuq+67gBOfqJqhmFdqY+kEVDmwhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N1MK/53i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rse3bnRV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525C3smF021001;
	Wed, 5 Mar 2025 14:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=1gVVy+/zoBzLbQXg
	AV9mf4bdkA11rmz/sJ3NMWvOBj8=; b=N1MK/53iq3fpi5Dpiq1ZfgYBXX7/Vove
	0OHWOtNJdPZ8TR1uMeEYTdnTRJ++jz8ylsWYzBNRrgyxO9OAJoEWhGxksz1QPeAR
	9woGtP00vWZRckzzFZ577KQamuFSW3KGyF7L2MUIJ1ksdTtjXt9TV0KN5aHVj7za
	4NRz+pzrekbB747/g4e2CQqC0Si+BoERWtNiMJ/PrBxrcoVqPdp+dfretsaO+gxf
	/+718EJZfQE5wYVonq1g0qa2aZGFq7yY/CI6i/gNVB5xEYdKK3X9O34KWCUGropm
	yprQT3fSvPQtV5AqbhKpj7xUVWAdNTl7W9hKa+e6wncpSMLVwA0OpQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86qsm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:55:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525DfD1L011064;
	Wed, 5 Mar 2025 14:55:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpc24k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ok7BoP03QwA5+5tIZzDCkbKBU0gkOclZYmSHyMIQ+VovAYARl323eCqeWSaQwc1gj3FD1bbbNY8fZl1Tyw6FHfsJY/Q46vapi6uhC8CQ2nmNDm76bWpkGdPz8mhbBUXbq1o9tHZ0IZ0rZAl8aIBB2M26VYuw7Itf3yFYkn1o63SvsyJvXgEnfwX3geCQKlHCN2nqR486bUq2/E+U/K8MfPae04hXe4TmZn6NqGMc3eQ3HgHn5fox2m/xpre+4ud1j7dNqLO59IKaKrAvT4PNR5dwyuS/P2HR6NjBIiRgiYUKqO2N3Jl7OlYZ5fyXajRfPI2SODaT4q0jNC75gLVFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gVVy+/zoBzLbQXgAV9mf4bdkA11rmz/sJ3NMWvOBj8=;
 b=Bg6T6OGz4h4ZiFa3/GAu8mCTU6izZNuf11petMKtWY3VnBo14oZO36bFQ/V9xNRm+06e0G5Mo+xIG+t/vRUNzE+LsYAJ7nPzFlPv0geIYwVfuyLN2UE7M0VDHMlnZMT0Js9Offmq8XBmrub5fiyaN/OKbFqsMEPhgHSOkqVVj3Sx9qpL7s4nwAl7ppKg1hh0r/8h0eL6ROEOxH7Tspp45UojjPJ4G2NbjxQqRrl9KtKqAc3raDDuUQ5bqBu1U4Ttaf/7GEACyGs8iBCMq/GGdTphES+1uOob9tcRaf9PU2np9J5ghsqS34He/UJ7VZKNQ0vhnOINH3vUgh67wW4XUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gVVy+/zoBzLbQXgAV9mf4bdkA11rmz/sJ3NMWvOBj8=;
 b=rse3bnRVBxv9pwh67x495/c2DGOuvzTb5C3SRGNKtlyIbAzim+i3ZC8O2/cUZUJtd0Ljcu83u2z1gQZdLf+0Oe1VbuVwtT9sjLvZKzGoG8+ZcAEYT6FGWjvYV0DlSSbQ6v2FfSltigPtxpJkNea6OHC2q4wJ9w7x83cNtHVh7kE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 14:55:23 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 14:55:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [RFC PATCH 0/2] mm: introduce anon_vma flags, reduce kernel allocs
Date: Wed,  5 Mar 2025 14:55:06 +0000
Message-ID: <cover.1741185865.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0035.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::23)
 To MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd7d161-f975-4747-1387-08dd5bf5c1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7J+Hd4zRQdEHm6vEwrOd3rgGf1fsW0wp660QrvjYHAYV3eZpaTWjzVrtaNl7?=
 =?us-ascii?Q?hbaQwlNW29aR853eDAmArt0eri0rt0FU6WSNsOQ8kyzRXaLA4SAxiMnXcx8C?=
 =?us-ascii?Q?2h8X/cvfv0ofYLS/bxnZaseb68QFdXUHdJJAnBOiE5MLpHsvKvbnd4onYXod?=
 =?us-ascii?Q?mrdWM2/HVCv/DTZeISxQ/C0kuY6CTisYkQjL3ZFW0pPYORNELwUY21iQMO8j?=
 =?us-ascii?Q?T0GgtQmCmOmP8JoTMOyS1qMfgkqOwqndUqa5nfDFJ8gYv6wTmqQOo9tuTE53?=
 =?us-ascii?Q?4cz+7RDBs0zv2T0PDfvpJj/kn0kneT9sGo1KvQlCQ1k6CqUFM5YgQ933qygZ?=
 =?us-ascii?Q?Dod7T4z+fpgVt/7Gw3yl3V4jCTEpiL9TCfX2/ccCTx3uqmI10vc8kUhz3kjk?=
 =?us-ascii?Q?Z5r3GS+3q2DiPRK+44BAf127oBIvqYRBH3ULPrIE138/D6NvIG1mzz33z+Sc?=
 =?us-ascii?Q?wQRULlO79JWzI2xUC+AU1TD4SyDfZDljx2QkZfgBXL8wKFgXyKV+TcMM+I5j?=
 =?us-ascii?Q?GAJGuzl27Vo0PBD0l6CNpTgdjDEpDWC++s67G4034YHikesGunhLi4bYG5ix?=
 =?us-ascii?Q?3aOS/iajPlk7OfTs1ozUIa2OY8/gPXzUOylDDx24arhQ3K4E3LJmGAoZ1fUd?=
 =?us-ascii?Q?4h+O2l6K2bXWDgJVXFJKuhj/5Rz00nZEW6uPAvQdnoMxoHbFwv7TrW6dwNqu?=
 =?us-ascii?Q?5ED+Csghm3+P6o1aj8d3d20EDxXM2inTzmxPpEc258lt4rNDsCAH2yS+TADU?=
 =?us-ascii?Q?cpOsMyyyiwKPcYV+mk7rDkckMvL7XaQFCdsmGMXmWkRrcnJ0ULf0PiEYuIWn?=
 =?us-ascii?Q?kT1ZxD38fMcTrnDN1DIw32U2gmSOUpw5vh6vjSHk9ifYiNaw3u15SXtdkY84?=
 =?us-ascii?Q?2rc+7FmLVNuYTU5qiLpM/Hc1H/NbruNfjTTNGsHOj1NAUktwxrajNJHPUPkG?=
 =?us-ascii?Q?ASYxzHFzYq8LsjEe3ajNrD34IrlsjXl6GM+dXPxeXNL6J483gU2/xMLt1jn1?=
 =?us-ascii?Q?c/yjKDwU5T59z33fEMQjMXkW9VAiG3M2rT/HFrK7czQLWsVRTjmNI3v1eu0Z?=
 =?us-ascii?Q?csOs3xYhkz6FZVz0RwOtHIwPdZ35waSajOHADMc9KF6DLHeVrJ62Y8by/1Mo?=
 =?us-ascii?Q?fbiVtFd7oT22u3hBmYHTukcfpsztPd9i0vk7QsFlg/qNfxtt7F1KT8YtQB4M?=
 =?us-ascii?Q?lr/lfwX/jD3Exe8THnngAzoIUBqH4OUchx8gzh6Ip7BvDXiyirXfr5PNdhZV?=
 =?us-ascii?Q?BS0LaPH6da/7IRtM5u73rcgwhSFGa2rES1Anai/iYW41VNhyOmUFf3SMawiX?=
 =?us-ascii?Q?LhH44dx+hYLbGltIPSBnogKpLZX3gjD7ak47WJvYwlBR4G2SuLHMre+Kvce1?=
 =?us-ascii?Q?kCitIuUfhy3aJaxW+KET+r82Yauy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iA8DgMqlZ4CTwSGa1fhiOeMeNHMCzUJEjL3DrvTWadvPZGKPIgLh1221E1Og?=
 =?us-ascii?Q?uHJNiOxZZpv+BQ1woEsSDfQxV+XFBzntUK6Y9+Bm/6KpjlRvcKHFwpQq2jbQ?=
 =?us-ascii?Q?ytAX0VCy0w8js+64MrvVvpiH6Yjy7cSdRd8lxdhdg+8a/Swr7bT3hs6t/Kxg?=
 =?us-ascii?Q?UAHJruKfYZu+E3rcSwPgk2WFEyKKAo6s7U+S9gGL9M3VTS64R7dq53qN6jPr?=
 =?us-ascii?Q?xjXjRD9KK5NvK8tQPr5t+XsamzhkOfnmwWZSpVvxH78kUQoUUBXfs/totmfO?=
 =?us-ascii?Q?gHE6gbNiv9KrA0LM67uBUqvddx15auX9cIG28n4nVGQaVTKwZq2MrC6Y2I/A?=
 =?us-ascii?Q?xgUuwCprD857yKtWzVCXUJd8Z55PkPrQF30M1GBeWvXejltx0DltyE8o3/nl?=
 =?us-ascii?Q?tbbcWyYfPVZ1GR5e8xBZ1kwj3JEs05LyXLn17NkA4xYVbNO1kOYSvClZF/kL?=
 =?us-ascii?Q?LAitqDu0fEVbiKLcl2/5YfJ01Y8lUylMB6h46hBOBUETGriUUxENQdvfRB89?=
 =?us-ascii?Q?cXJnyEFMtsIIdVOtubZejiDbcT76DN5BJYEncJ3X41JMEz0GDaZs7KwnESrD?=
 =?us-ascii?Q?clPBQCCMvnfUb7/OTGIgxO478GXTXdw4St+KMdKOR4A35p7bwyV7NU6T1KA0?=
 =?us-ascii?Q?XA5lnEccxJA/9wUMmq4328z8JhqBQa0GLMgrWNlaVLiC5Hb5Q2xfbAMJ7VPV?=
 =?us-ascii?Q?xjOpS/6KQYDyujY5O/mRggT2TPpJ4ZBavLFRwdXTgoLsxx3c/ao3zBUBoiuM?=
 =?us-ascii?Q?QHz3pYXElxCakCGSP1LpUWHGdbjUoYBNo+niJCFH1WNPLrOAh38bA9fQaWDt?=
 =?us-ascii?Q?lQVxKvv12am/NcN1d+/t+JTOmduCA3TinMs9WpeonDm4VqAk5s4s6cu52t28?=
 =?us-ascii?Q?LHZD007L0tbhnqo0Vu79IY7IaUJvIGdDDdsvSmI5ixsmwko0f1CS09QKqHEz?=
 =?us-ascii?Q?MLHwSgEmKhhOPjnJn8MR1sI0RCOV8jnwSI5zg/Q6lhS2cqgqN5Q7FXMU5Cz+?=
 =?us-ascii?Q?z62zPZj4HtKBlW6LBvmjBk6JopXzYmoxSuRTxEkYMQ2jd6DAHSvKbcSwwqS4?=
 =?us-ascii?Q?KOF/M6kCZViwBqQ1bdk6/erx45LBOZO5HOWqUIbglzq2c6k1RixY94XbxUP4?=
 =?us-ascii?Q?cFMBPMFLJnBYm7UkNfHwcAYmArXH942YRpXZpcAgHeO+Z9u68/VcZ/ovZ7nV?=
 =?us-ascii?Q?6u3QdrxFu1PhWeGYk2WKvWGRcg2yB9Qx4gIDao3vPd8lJ4L/2xByi+oGKmsp?=
 =?us-ascii?Q?t3XPQFEPXTb4rmMeK+U1ANItWJz9hCG8CUelUEEKYOqMQPwmVRYoULfiZudd?=
 =?us-ascii?Q?Ch+zh19vwgPOoEwEnwYVEjCFFjQ+G32x4qMKvOIIfhPkBGxSxgvQuBJ1IeEO?=
 =?us-ascii?Q?dI84o34H3IvijiG8xU0VtqWSNYsN++XhFIRMx/9Zd7Cu6J0aaMICDjIXBBLJ?=
 =?us-ascii?Q?+D6fwYyf7bbsfzf7XR3R1wrrSaZGst3PItkpQWgZ2B2uPgLnnB8jT+Kho+sj?=
 =?us-ascii?Q?KlLha4ZxRBPgbsQdrNQGkQvtqRF6lFy7SCpjz4R/MMsttOVc8xboDppylm3v?=
 =?us-ascii?Q?WzENmAh7LehE3ZN5Qmayboac2p3Lta3cH3E3AxEGxN7egeacrjLCQeT3jd3l?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bPqrRee74FzX++psfr8q5gsjG2nOayBCLXKExl0ShLqnQVGJmsn4LzTsyOE6aZOA0tyzhDEVCAVmfLJ4spASY0swiik5R4w8vh53a1MS449MI0RgiygZ7yBNCu+ktRvyWj0RtoAMr7HdmZBZi4Y+lIIRmseQqGrD22+GqOQJMcV/kYOGJEK7q1X9GkHryf8A2cWSAPQCbTn7183/Ec/RV6Jm0XppoVZ4lHG7UsgW4JzyhwWbcLHnKD5JFe/muBEL1cPmaTVMnbfsy+Y19pxwiNMBYmyi2DV4dh6tvfpx1EzTKv5PhA88bTqgRd55RqpKe9izKcxm9FWJQJKKf9tcsPfvt4d169etQ/AYKw4lRAQ7MzhdpH2oewK6eiR31DStVqSAD5+UmvYo2rkBR+J8fyF6XX9/a43T6SNYuL5uV2oVFsq8UszJ8Dmno835ji7/dVMAqz4hY8KVdo+22dpgirB3ZTTgZDCoNZt+jpjf35pvZYtUKP5wTVJihKN8r08RsYKPE9iEzmZYOcbK04lSZw2Xs/c/ohNpGzTQtBzfcUbZHKqe9zyJSYHQFsFwgjs81NaEA7QPvbVcst920t38/nU0329vONeVgMjPNOOvbtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd7d161-f975-4747-1387-08dd5bf5c1c2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:55:23.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwIdQivv9gQicykSRk3qYCqiPhSbjgaLBWPJWrrcoicXL57ZScaPfS54zwLuzPdT5vmKIk9wYI6XmNEr26dUQncEDzJ8ur7UNAuBU9C6jB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=714 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=88 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050116
X-Proofpoint-ORIG-GUID: Dn5aYXanIi6B0Q_cV6EgV2BxTBKgCP10
X-Proofpoint-GUID: Dn5aYXanIi6B0Q_cV6EgV2BxTBKgCP10

VMA resources are scarce. This is a data structure whose weight we wish to
reduce (certainly as slab allocations are unreclaimable and - for now -
unmigratable).

So adding additional fields is generally unviable, and VMA flags are
equally as contended, and prevent VMA merge, further impacting overhead.

We can however make use of the time-honoured kernel tradition of grabbing
bits where we can.

Since we can rely upon anon_vma allocations being at least system
word-aligned, we have a handful of bits in the vma->anon_vma available to
use as flags.

In this series we establish doing so, and immediately use this to solve a
problem encountered as part of the guard region feature
(MADV_GUARD_INSTALL, MADV_GUARD_REMOVE).

We absolutely must preserve guard regions over fork, however it turns out
the only reasonable means of doing so is to establish an anon_vma even if
the VMA is unfaulted.

This creates unnecessary overhead, a problem extenuated by the extension of
this functionality to file-backed regions, where such-allocated memory may
never be utilised or freed until the end of the VMA's lifetime.

We can avoid this if we have a means of indicating to fork that we wish to
copy page tables without having to have this overhead.

Having flags available in vma->anon_vma allows us to do so - we can
therefore introduce a flag, ANON_VMA_UNFAULTED, which indicates that this
is the case.

We introduce wrapper functions to mask off these bits, and nearly every
part of the kernel behaves precisely the same as a result, with only the
desired change in behaviour in the forking logic.

On fault, or any operation that actually requires an established anon_vma,
the ANON_VMA_UNFAULTED flag is cleared and replaced by an actual anon_vma.

An additional advantage of having this mechanism is that we can also remove
this flag, should no 'real' anon_vma be established, and the user is
executing MADV_GUARD_REMOVE on the whole VMA, meaning we can prevent future
unneeded page table operations.

A benefit of this change, aside from saving kernel memory allocations, is
that THP page collapse is no longer impacted if we apply guard regions then
remove them in their entirety from a VMA, as otherwise the immediate
collapse of aligned page tables in retract_page_tables() cannot proceed.

Lorenzo Stoakes (2):
  mm: introduce anon_vma flags and use wrapper functions
  mm/madvise: utilise anon_vma unfaulted flag on guard region install

 fs/coredump.c                    |  2 +-
 include/linux/mm_types.h         | 67 ++++++++++++++++++++-
 include/linux/rmap.h             |  4 +-
 kernel/fork.c                    |  4 +-
 mm/debug.c                       |  6 +-
 mm/huge_memory.c                 |  4 +-
 mm/khugepaged.c                  | 12 ++--
 mm/ksm.c                         | 16 +++---
 mm/madvise.c                     | 49 ++++++++++------
 mm/memory.c                      |  6 +-
 mm/mmap.c                        |  2 +-
 mm/mprotect.c                    |  2 +-
 mm/mremap.c                      |  8 +--
 mm/rmap.c                        | 42 +++++++-------
 mm/swapfile.c                    |  2 +-
 mm/userfaultfd.c                 |  2 +-
 mm/vma.c                         | 99 +++++++++++++++++++++++++-------
 mm/vma.h                         |  6 +-
 security/selinux/hooks.c         |  2 +-
 tools/testing/vma/vma.c          | 95 +++++++++++++++---------------
 tools/testing/vma/vma_internal.h | 78 ++++++++++++++++++++++---
 21 files changed, 358 insertions(+), 150 deletions(-)

--
2.48.1

