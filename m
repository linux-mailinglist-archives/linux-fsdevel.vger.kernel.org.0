Return-Path: <linux-fsdevel+bounces-47346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797AA9C5A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D231888C36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D739239594;
	Fri, 25 Apr 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W+mNov+r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nl9u6930"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974919D8A7;
	Fri, 25 Apr 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577336; cv=fail; b=iW4v0EpdtkBQ2Hfyr4LMVTtbZdNCee2cyD2mMsvCUgxuiBZDkgT6CIb/tAO0qNdZqWUfdU6wiod5b1ouUwUMgXcZ3M2zPBXivpZpmNUi196X1WvP59eMzJMGeOZ9WXyD0OIQPqHXAnPY6JAcp1J0x6woa7HR3IBa7Og3IEMtzbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577336; c=relaxed/simple;
	bh=f0O3OCrBsGt7GBsCTkBWCnLB+ZzwKkmE/2qDXtOj0jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ILbhvgFq3L4a1lWgaHT4MSgkWh1Q67ww7AbNhCKW9jalQHXAAXawZJTFyTpM4TGvF0tYmpAmppJq3OvoQhLXAbDSSllIBnGG45g3h5goNVHroqZUWfxNMFGSVHdWBAs+LpN8lmsroFmbQ5x6lA1i1DrrDYbOK+EbEQ92xxjc9ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W+mNov+r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nl9u6930; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA8LKe012968;
	Fri, 25 Apr 2025 10:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=f0O3OCrBsGt7GBsCTk
	BWCnLB+ZzwKkmE/2qDXtOj0jc=; b=W+mNov+rCoVq9b/Cp4+PlUuRP/VDUseWsm
	CMOTE9J6nIZoVlQotmf3nkU2mHSI1hALWRU4ZiFCzKMd8KvXGh0uKHtrecaN1OSQ
	F5Cicb+wtBNi1QvMNKtsqke5R2q0e7TR4tk8JJMjx1Llo8/s8Il58Z3NPLj52Ajx
	kXI/5tsgMIAKPQmHt3w3GLRqzcNXBmap1wpSlx4maVWk6kQKSKTPg2o0J8C7yQex
	a62q14pEO+USI3dEa38G37pjLsYG01hxWf/Lc1gxO2XF2350+UCJQnkzKOP/ZDzb
	EfeIHlisCMEXQBuCU8HErz0nJepvVC5xzErsliKqIn2+4FdCJ40A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4688bv01a3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:35:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9Xuc8018123;
	Fri, 25 Apr 2025 10:17:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvhpgb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:17:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbKzpmDoIfkorCP8D3qKhE0IBYq2Vsq7ESrmDaswxzdo5WU1jJvMVfFiCN5xFc3xjc3Zw8e1yfwQex16nFRKTmrF3k6jrFJ/tXMOxQxTdtV111akpOtjUXZtyTr01aOzCxgg3J63F6cc5/4QJaluBPtxqFX3qZ5ef/rWrIxil1/TYsUDw7EZmhep1Bqrk6GhA+XAGzhCtQLI8+hYI+eCRvBZ696kJ/+bIZwjJ9JGhgTIrw2NcUftNoqifmTrHEOdkZ/fr0f4GdWcr2ImK9FLdZj6XUYhPoPurFM7YGeBQco8QgWpxX2J6Sk/n+SM/YNcRI0meepfpEtDthXEoGP1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0O3OCrBsGt7GBsCTkBWCnLB+ZzwKkmE/2qDXtOj0jc=;
 b=sQuvVvYZNMIqlPjXw3o7D9k0+LyAUEcIHFmrRA0P6mMc5PK/m3XUeGD74dbW5W8iw1naoBY1QF9Y/Xjw+wuF1eJ9mLvPraRMXJl9Vl61zYrgkWl9LPi5hhw4HwG3kS6rHKLFVD+euhOAyfab1MUdRp1zzUzChY39gC3y1Lqql4gEkJA8JChrHvLJMLDsWIJPo9LW+4Hly50xO86l+fGMZ6cvpdyR2m4dbdHEK7Ua2v9VLT8KP6rLlmFkn15HfwNSq0W1OlKXT0M9OvvNp/Y7OJ9IJKW4er21joe8mHCGAjXzqpzwY/yjxJqfywjeMiZ1EWyJjgvXe6CmBoF5uD/AZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0O3OCrBsGt7GBsCTkBWCnLB+ZzwKkmE/2qDXtOj0jc=;
 b=nl9u6930YaxBn+y+0+ZD7ygMzI6e/vLZxsDM2bqhwD8g2X85UeOMotBF8o55k9THwGr9BEh1+JG9C+0QEPqcVFjNFwk5piC2OorSx5/7gTRPcbSkJDyki+4VwWg+efxz+amS/TCMaCMBdYdkEykNeN9QxD1a56nq9piAbEpYc+g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:17:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:17:03 +0000
Date: Fri, 25 Apr 2025 11:17:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <6f09e708-7926-49d6-968e-99242ee05cc1@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
X-ClientProxiedBy: LO2P265CA0499.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a8bafc-f302-4b26-9298-08dd83e252b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMPgcDeBL0R+dgu3hlJ1xhsCrbtq7JQ+AsTPq1w+BSP+G22nnVywFqNElJUf?=
 =?us-ascii?Q?kufRJY2HGjhOmTp6b5Q5Wh6nLaoFhEDR64f+ilUNabdeK5rWXhlNVUgEHiiz?=
 =?us-ascii?Q?AXUy8dCFiDliC2TWp38tc/6yzKL2C4wflaJAff7nU/MEXUih6lh2SRqOUNMT?=
 =?us-ascii?Q?l8ssfAzBSX+4JyJurFVahzl1eENWm5c89gpaoHVcnwvoF78Xt6/cmtK9Kteq?=
 =?us-ascii?Q?CFm+zh3uCjKU/NOp4IzLbuJks0JUOxKQ4D5guqx2cEZeBTv/lALTVJNdnh6F?=
 =?us-ascii?Q?uFAonvIzf4HAn3yRn9j5cokUxX/ksnUyfEKn4bWBMtZO09JvL0VworFG6Jxa?=
 =?us-ascii?Q?NR4x6AMVeRtJ2p58EugQm+LBz9GZkljw7rxan+eGNNalEgUjlyl1SLPCr4Nj?=
 =?us-ascii?Q?IT1fIVjQ17oRbksQ1WRMmPWyms/c5s6KdkaWf2+CXoHSktzmsedkc2SGbI8s?=
 =?us-ascii?Q?GSDjSEXdeH/mTGRcRdbfuOw2N3hh5k6+z0Jjd1fdIA/oIrWGJk617uVVe4u1?=
 =?us-ascii?Q?pVLJ+CK0cV/TNsMKc0mwtheYUarQTuaftQWKXk1lBGANY8qyE7JNaltULDYf?=
 =?us-ascii?Q?cbB7HV2jxc3V6TTuH8PGnvuWyKRxhx6nXlZXdZ+53e5N6EnNv7ggmqZCDvbu?=
 =?us-ascii?Q?UaRd2LucnRHX8W5H8YVSodEvQRqVEBMff7CoKg39zQXZJjk72DxbiybjHJ12?=
 =?us-ascii?Q?XdeMShO3SVjkkBLHSEfrkoE6k38DpC3xilItGYYVgcjbF8hU5J8JLnLwpHjX?=
 =?us-ascii?Q?jqlXKYla2myLU5TUdJP81RZObkocnUqpKt1fdO7v/2ndfsp2yJNDYJVQQ033?=
 =?us-ascii?Q?HsGvBxdBm/pR7/rOzN8LWeeEo0SkmI+hg5ilXnL/WuOyXypK0QyEe2uTWX1O?=
 =?us-ascii?Q?/DP35l+FgunuXaRyhnwAB7xJL4D6tMKgwsRJQloazLPAhbfYAMhcEDEI5fFw?=
 =?us-ascii?Q?FLh0cHiBiwgK/enIdxdi4xX1g9p7iTxQbuMktoH3xT/IFGtkAxyvaBkBzS5u?=
 =?us-ascii?Q?Ss1ee81JQkbH0Nm1rCFTgL0JqKgo0XzqWa2g0igh0pkJg7NRKkQZIwG1quUA?=
 =?us-ascii?Q?Wg1yghYrBHWqSAxIeP4mjQYxPXXY1K0mWEfO0iiboucywX2y4PXzAPQviOre?=
 =?us-ascii?Q?xqU9CKKSUagQcKaDxqsSm/pQ11ptIYsZLldOqGs8i6o0xZvrSK/ECx/kPO9g?=
 =?us-ascii?Q?jCddOst3AYLqWaDcmq6uUgWKv3cNczwvWzAvEhvLgxsiByC0UgywQomRXL2k?=
 =?us-ascii?Q?KPeIpOMVuuKOKRhz1g3OJ5Z/M2kYTe2GvA2kLUPVDWe+2CPXC4gw/cAVMSPk?=
 =?us-ascii?Q?RLsprdu6jvO1Of5vaV0RXYU05Dye+OI57OQKX8RHnpomoCb3h6/f3jXKzj23?=
 =?us-ascii?Q?A4KZ75sYzz06mZ1+zrjoCub4y21LM6aa0XGVVC/XrXIkG+B3UA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?my+3OeJuEyIwWr92dPa913RLxqhd+oBk0H5EY2QXzKxuvD6QDfrERk3NmZu6?=
 =?us-ascii?Q?VsNEE3FFm3ynFMNfkC/IumgOWOZWDkqVOMUgrroyUvpd14IDMg6oO2qk8EzR?=
 =?us-ascii?Q?HJKVvW/O7EPKJCgmcoBuAl0Z6hnIpSJhMI29SxRXu83ZqjlpGcov/HTO2x6W?=
 =?us-ascii?Q?/5+KHKe86Z5nDniHKbIHrTfJCtmN0oAdCfML7CLhfFtzKGbcD1ygJYOl3I4R?=
 =?us-ascii?Q?xGN0YKVIuw8mgwJZxIalT0ezdskZdoStKvO46xWZJQ+/xz5lNnSbeTrwEdVJ?=
 =?us-ascii?Q?9BKf9CybQCrh4O9+gSRSpugQZOhZZjAs+IKACt/spCIe6K08QwliSjQ+XjWO?=
 =?us-ascii?Q?DmQBjHKB2s2j8pAzrvLrpsjqbtjcTjaIRhphjns6Z9mc81g4a0G5nqmzQo0+?=
 =?us-ascii?Q?rqrnxanSWBh71OfJQ7sS59LUwVswLCQxfctv++R/0Dm4VhUrRVyr5W4LtxCj?=
 =?us-ascii?Q?TSYxM92Mx3JT4mUw5CydEyy+jBX6o3mvoQJwerdYMItFTxEIAaVAwTORuj0u?=
 =?us-ascii?Q?KYXtx1LUUvb3UJeWRXqhMiE2a1LnavYtosdyTPHlzYEQIRs1jRmDN1vzaTCc?=
 =?us-ascii?Q?PxGaR1/fHj2mcIuZW4nRvj64yJ+v/0mNK3C5j3teTHVdO2zXk6nv7GGitJJ+?=
 =?us-ascii?Q?wBXZcpWZiYHKAcYUFmraVFy3bt0+cT2z+OHKKSdvNCKMu/GYpKfcC4gW0+0d?=
 =?us-ascii?Q?q2ZrWRwNfugvheirc6nFEhoSPm5Oar40YSM1kXWvK01AVcR5sB+r3jxaLSuO?=
 =?us-ascii?Q?Vl/62TRdn5O2jxek1D/XOetc0KkSI2rLEj61bDJbsrB8TOnb/4Y21Fi3Qp5v?=
 =?us-ascii?Q?gwiSTEezi/uHXK+91lrV/2tM0oBROuV5R0UHFICaDydgFV+XdbEQB4HGEde0?=
 =?us-ascii?Q?C/pyFZ04e04CfKGyVrf8ArBu7xyOKPSt5iGdF0I8xB6EKaH+e5036dBspk34?=
 =?us-ascii?Q?VR8SNaiz54m3ckoCUxuXGrIVPccVddylceOlIbWdoXNpOkWswAzO8QZ5WxCs?=
 =?us-ascii?Q?mIWuEzEFxdc8bbnrj7tOF5FM5riItURlo/sXoISXyViSPrL/McZbniY8RP4q?=
 =?us-ascii?Q?WJOdnDyENAGysSI7wTrf61RSE1zA+6Z0kIigFZt0ZBvPunjjmbB5z2dtroF1?=
 =?us-ascii?Q?gMrSbnQnxBHd+QtUmPyr4vRy8WTmG+W/0zREw1GuA5W83QKPicfhDhTZqmE5?=
 =?us-ascii?Q?KmiSbrjnU3J7VSeLnfXz6IvWAx5lMDUe5GeV0yL/a7+iVbsoCbBG4v1KFnxp?=
 =?us-ascii?Q?NrMnqUrd7u81fJ4TM+h07iT7dyJicY5YBmIs1GLjWeBndRJz3wIeyHsAAqMw?=
 =?us-ascii?Q?a1sgM76ysyv7eRQBwPwMAR7ANpo2RWzJvMdi/KvpL85ZjR4QW4kbdVqaHjB4?=
 =?us-ascii?Q?6vt6W92fa6qk/dt3bIn7DPdFWo31ZClYe8w0U/6zCQvOFLiVZ4zCE6A8GU7i?=
 =?us-ascii?Q?12cTKusJ19YWSfng5qTXR5giHmE3ZhMa0VHKOgTcTCzvdPOXTW5gMzYa4O7f?=
 =?us-ascii?Q?qE2nhrsRHMHF3Iv77S8JB6w/yZlAjV6SU6AksC7+yxuEy0i0O/NP+7a6z8GI?=
 =?us-ascii?Q?zY+QrGnUMcGL7GWL4AN+AH8moGuoPwhQStu/JXl9S7pIM5NsD3iM4lb/m50Z?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uuTJJ7TRWrM3aRnRYEW/VFQjjErrQipP8z2BM93DO4ZpvP6UK6aCMskfQwig2wHpODSY2AYNXLdPAgCpcZVrsIqtyH3nSVyJLOCpiZSS7QvmEpxiZetA/YmXGCyCT2aX0ff+olqyDP+Q8NWXvZHbWQFUbLGXKvAor6qyWI5myWX5+KFkCqCn3jxeM9KvdJjF0rl7QbgVhEpFxT63VyRitNN8S5q1ULe1DHnXr7D+SBwTK4/2TMxisHllYELEzeRZocir3b/upb3LF3Mg5yc+SoMZp8HhD0AS5cWALBBottj7eK9Pmu9Sw5qRXCYytBM9mX6RuLf+86g9y/tldYaiAc/CZqvDxlDDJH1SaiS4PkXqAr2aB2whxkkWp9N0I9Qesd0D5Yu78dd+avIQLnxf1hoNusRULlbR96T2sCC0Afo/RjJDwa3QphWA/OqQqE+IS2cx5pUKtFMgRROJe3Mv7duIusbZMQ5POYz8o3IN4d0O6IRmrtxu5WQZpNeOQL5CHgyhwuAfwyihochgXlZxr0WdjCAK89I8FQnv8EnF1OSvp6MpVABaZ4Q6zW+CCnzwOfCJycSAvzX7aupRqlFJg4Mt20wqkCo6aj+2kcF/o70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a8bafc-f302-4b26-9298-08dd83e252b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:17:03.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys8tag1shXj49o4Gr362UtUpFrzQlRavYRCyycB+z4ZezzJLIgyFUGVWeju5AwuElUGvsmnZYppeIFP0sKc76FKp29LbpiXDKPdGJ42jTh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=957 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250074
X-Proofpoint-GUID: WgT0yF-eaczFwKEyx54VFMhMbyfSFyJP
X-Proofpoint-ORIG-GUID: WgT0yF-eaczFwKEyx54VFMhMbyfSFyJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NiBTYWx0ZWRfXz0QyuNZZB/bh rYlSP4SIQ3Kv6OoYMJyxCosP7ZRua6rWGDWLWFhT2gVQuDrcL8DvUjelxQLuO9CpJt5Y811N/PA QjDZImzpUmZsXi1/V6rEfVqgxbcIAV0z9vlV6GPImtgTk+ollMaKAhwarbMjTUsDur0IOWSt2Pv
 ICMqfj9Gi9BPKFcyf1ZufEDzsEIN6v0p2tQ6v/yimayFfJ8hrWPOYvvpC/FS89qY00Kl65ifMRs T3G8CHFEVz9fl4rrJG1IbjjjZf13ve3MkdK7rb302cxWzUxr2Wy3vMDCea8oqLdjJjweqJ8/I0X xFADfnuKZ23wwFnKK+pNJBDbmhs5QmlZIK38bWfv0mEYdSgj9YBMp0jyYzn0JR/a2zv1f43JuwK FbfBJBBv

On Thu, Apr 24, 2025 at 11:22:26PM +0200, David Hildenbrand wrote:
> On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > Right now these are performed in kernel/fork.c which is odd and a violation
> > of separation of concerns, as well as preventing us from integrating this
> > and related logic into userland VMA testing going forward, and perhaps more
> > importantly - enabling us to, in a subsequent commit, make VMA
> > allocation/freeing a purely internal mm operation.
> >
> > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > CONFIG_MMU is not set, and there is no sensible place to put these outside
> > of that, so we are put in the position of having to duplication some logic
> > here.
> >
> > This isn't ideal, but since nommu is a niche use-case, already duplicates a
> > great deal of mmu logic by its nature and we can eliminate code that is not
> > applicable to nommu, it seems a worthwhile trade-off.
> >
> > The intent is to move all this logic to vma.c in a subsequent commit,
> > rendering VMA allocation, freeing and duplication mm-internal-only and
> > userland testable.
>
> I'm pretty sure you tried it, but what's the big blocker to have patch #3
> first, so we can avoid the temporary move of the code to mmap.c ?

You know, I didn't :P it was late etc. ;)

But you're right, will rejig accordingly!

>
> --
> Cheers,
>
> David / dhildenb
>

