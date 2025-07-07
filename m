Return-Path: <linux-fsdevel+bounces-54082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AAEAFB14E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C178217FB3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46A293C7A;
	Mon,  7 Jul 2025 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQhwtua/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="twRSPSxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A51D5CD1;
	Mon,  7 Jul 2025 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884516; cv=fail; b=lCKQXnRHBFoLyXmCONEe41+BvI2xdb8M1wjXq7ksSRnB1L8KKRPhcSNYUKWTp2mQD1z/XNRSnlA7E6GGNBhl5vlwG5A77tQZaLVwznYNLFRyWiNtP7cTOfsEXfBmN5W7uEhJqvkteYBdmnI98PROe5NQ+nAsDlMWK0DYQYnm7GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884516; c=relaxed/simple;
	bh=u/EX1MKhqqo1crsV8CE0IYTD7mlyuzKFAQyHI6qXvtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sbYN4kWd1nJOPHXWiZwJpuwz+1J7x2qUljIW8N04z9mCxzMz7+mJU1ewrQQKuNvcrJ2PoGecvaUf0PDSur0nNL4LbCL6juOHaF5JvUej0a8IjtbcBqWNbVqV+a0yoK81OVdR2GQe9N6brj2fd7cozrNM4Ibud4qy+wptfbcQXAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQhwtua/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=twRSPSxT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567AWHOY020331;
	Mon, 7 Jul 2025 10:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JJWv86Jva+E5ga9HO8
	G46zrhfHdTe2tvQtXQFyPaTUE=; b=RQhwtua/hPE9cgfl8UWQT6Mjmr7Op/Bsc/
	pyzVnGLBJHVMamVUoydiQBSY8hprzfei/jbUX+NuvxKzUVZVAAGIduUkbcGfVH6J
	xPu//CNFrD7xi+cxGFROGUHSLTgDgwSuI4MsivVlaf0t+NhGXz2e3N7tB57ExZwG
	YdVMzxLbP7oMQDyFErmlKFCZeVbmHqNtXwkMKnJjZAuG6aLLw9JsxHe9vuT6+sMd
	/UmYyKU9lB+1qneaWvWoug9USaln8DVRrXHcCEJnhBjfKi8JpOK0ZOT4MMAx17UE
	qz8P87H/EX/ef7m8JDleHhSgonz5+M77dotdHKzunK5Ht5wZzyWw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rcjm8032-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 10:34:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5678FD07023541;
	Mon, 7 Jul 2025 10:34:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8b8ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 10:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csMvWDkdPzihC/TbCLDKXx2nxNjQDqpYdOyyhzfijFX4KpwB9RnFwHvE8gUAWESLkrC6UZK0IFex1RsPxTq01sQRZ88zsAvwTnXtZdOsOk2y9nqL5im+DXKtAQ9ax832b5YX90HzSWwZFgO3stE4d92ezsRJsguaajzd5n9efPlECFW8L1faRhpSIHAIIrIOz+7hMG7gd3bG4w5QQqnN+2Ak2KwTdS2L1kWJRBjoXViVX4iz6M7WmSCFgTnGeM73EnWRYNxuCwg6NU9naMLSBMV8C3ulMlMn29WFFVkNPICI83JAu6SlJtmAFkBMPpDz81JjmhQe4AjOF4bzFI0Hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJWv86Jva+E5ga9HO8G46zrhfHdTe2tvQtXQFyPaTUE=;
 b=BCC1J0+2i8enwP9hxc5dDXbVPQxG2sQmPEbdGI3SY7fBM8HIQPHuxPJc3X0nEqC+Mv3pTjlcJEnaR2cKe81W8OgSqbFmeXcMam4DrEQoq63lC6oZx28Z9HV2ETEAjM0aeTV7onnUy7Qi3P6qPflj9hxLFcWlsJFFlH7ytYVcknShsvihLzuKqF969l+V6Z8d6aH9tF5v6MghPWrYncoLm2yuS5ICdkTMRCaWJaHBQJpnyFaQRNxFsgDSF2KJ8zRChGxNM5eIa/6BXSOfCQ6QqUJCSmUyyLirY7s0XfEv5GKmEurzF3h9OxNJ4jvhUEIaf8bqy9q8yMkLroNrEejs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJWv86Jva+E5ga9HO8G46zrhfHdTe2tvQtXQFyPaTUE=;
 b=twRSPSxTvhYANHlDSqlJMVAHR17YsK3qmHrnxOA5YKmocx4IR7b2bPaQ4AuE4RaMwpg5qEPp00082IOBO5au9EUKPSdjpIyYVunLgdOh/RONbWX8vnfj1HoKRLZJ9U1ZYu5Hgxh/zPGmKOPkZ8HpacNnu8GEKkKaOrvb90QJHlk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BLAPR10MB5012.namprd10.prod.outlook.com (2603:10b6:208:334::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 10:34:36 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 10:34:36 +0000
Date: Mon, 7 Jul 2025 11:34:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 00/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <6b3f63a2-b39c-4c0e-9531-0f271a0eca6e@lucifer.local>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BLAPR10MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e350dc3-3113-4b3e-bd60-08ddbd41dd92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mhlNCVnZNxpXL7Bs2JMz2LfsTbqx8ejnBz4qf5RqjmQeKe4D1gpEw4UoLK04?=
 =?us-ascii?Q?BShVOSNDlIeGF6KktZCLZx6CY1tAPqrcUgI6YCImXS17UaRqQkasF7Hyd5HU?=
 =?us-ascii?Q?s5eUJJt+bKYoQF9QxuGNldpN1QZd6Ls7Vzss1EsQkOVI4Mv9bAwp3Am8431M?=
 =?us-ascii?Q?kTv8YNyJUUJ+3XFUvFW3Eq8YmX19t/pxsQS9V9rJCHMm+g3wmcUcft1EQQEY?=
 =?us-ascii?Q?hA8ZwNPS6WYXqiF54QXgWXarLbnb9ZzK6fycGNLHhQdkJbPRkHtxmsK1eO7r?=
 =?us-ascii?Q?0C20uxfp3n7QObdIrJ1LHNPmwZ0WWBkYSc6gH+Hi/w+By5EnpHbxu8D/Wxal?=
 =?us-ascii?Q?EWx4IESafP5/92ddm9KPX5KrN53+ZLVHxnLChoVU0yA46TTSRqvKkCIMssv4?=
 =?us-ascii?Q?0FUmgcw7uz1RiWaZQ3nqv1PFm6VyigTHkx1P/GbU8kVxu1IwZ98MIrc6ODgP?=
 =?us-ascii?Q?NtlUeIoLBx8+g8TowDKN/IRCa9neYPV+ZHQYbmYHDvq58nKpfKCXGRIAkhF8?=
 =?us-ascii?Q?Ml0WsJob1GtH0M2cb+PdR4fBb8hBfBONjWYXUBb7qpCxUn9AA/i3b0NNi8xS?=
 =?us-ascii?Q?yWYGWCWNF6DiKCGeDhlFKoAVxiZm1FkEp+NoWPBh1EGZE2E+YaRH9ZZYyo5m?=
 =?us-ascii?Q?VRA0qrZ8Vh/x1qkJgkaDS+HOiBmDEcdNmsIu+aEOMaAuBq0IAxNeC2MaTnyM?=
 =?us-ascii?Q?fbGOtgVTWFgKRFLtkefiuoyBeH+riI4rjSmDWWtPQf5c6X0/OVA33uNBk5Ey?=
 =?us-ascii?Q?SBWduraaQfqtz7s7AHUlZI6vJn7Rvgyw3gYpBLOX+wMlt8FqJeRrsqboRLAH?=
 =?us-ascii?Q?aqy60y8PeUNkZ4PQLbSfYG7cMeHW2p7Y3O6dKMqcIZRogSsO4Vx8aV/+C2yG?=
 =?us-ascii?Q?7B9SANlhg9VGmB7FzegtMng3jPctsT173LpytNYoDC7s/CeDAdZkpdiRkr04?=
 =?us-ascii?Q?Nr2gdVMVo//aixviIvrNuevYJAnsh0ongNFgE6iXSYVa2dQEm4wNetinsofx?=
 =?us-ascii?Q?zUHu6xLwgs3im2L0k0CXqS74RExwE/Uq9AUr5HnuRnsXT7RuZsP1KBiarfoE?=
 =?us-ascii?Q?Wzxx16h7KkZN/hqfSDmRtbHI09WQmp0g+vG3WycoFR9HJbFYuJkRCX49uHMc?=
 =?us-ascii?Q?qVa3qm6OV/fwuvTZFlO9xxtPRN2iTPO0Olviz8OXe1loN5Y9LdsdWTcAAumf?=
 =?us-ascii?Q?buTQgr7fcCyNVutf06mQGbc/hS6sKP7REtGg/HBILTg4ltrGdOXmYihmwWNt?=
 =?us-ascii?Q?S0Np4kF98bFWhhJ6WeJbBQCN9xVoH1OztR3uuHbtDhR03T2lGoIGjWWQ2RYA?=
 =?us-ascii?Q?Ro+wFFOVLs6acli2q2KmyZT5xH5lEbBeIrzVuzIIlnrzX1FcU7o1arbJWUWO?=
 =?us-ascii?Q?aEXShLqTdJntwWiZzHzjDM2wPByYt2STHwuOdtt+VYM68xvIpyeYhtcVJG68?=
 =?us-ascii?Q?bxat0nbYJSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VsR/sRyJr4vA/LBkFgP3+rEbBj1Yika8t/0SEJod0lbF5ku7rJP5pzQsE+6j?=
 =?us-ascii?Q?4ZTbImdJhFHZLwSbCZCr2UAD4fi0R1gRaUEl9BHTao72/7eQLZ/G0BLjIfYE?=
 =?us-ascii?Q?vMnUe8tT86ULW4KLRTRqcYoHT1MwUFDYVKqqmrsjGwxYpsfnV0Bm0eOKP1wL?=
 =?us-ascii?Q?LswcCldJbwi33bN+DGkwQ4khLMRS8heiYPq3QLNdyx/2q89EtnnhZZ+Ka/b6?=
 =?us-ascii?Q?IZ14VtBXcdjtUijsrXKtHCjxBLnLpg6J+ocwV1lWRQn3WdNSmcWRaNtMMDuS?=
 =?us-ascii?Q?46hx+LopXKYtH6R4R2kiXIekQL5gpkcURNuiBxPbqZo+LkuNOqveZvlZWTEy?=
 =?us-ascii?Q?nNQtQIvxnIfQNDmn/5fzCYKIL27CSSlZIc4AEpXOURP/nhKKiP4/w0O2m8Gj?=
 =?us-ascii?Q?XIYZJZKyNNQcHkVDjqDBq9MegJCVasMHudkrV+OUcmMmpeMcyVM8JKZegNRL?=
 =?us-ascii?Q?ybi/kB7JSbKc1Cco3ubY0lAJ1J3HGnHAs6/+XYCkofRAseD3WJntT+FiIT1n?=
 =?us-ascii?Q?tV1aqxUtF9eyZaspEFEAoKC7GvXVv4v5vv88zJeeqEm4pZnUzUxC6IqgGnpw?=
 =?us-ascii?Q?UBZEsO/vxPxC4GwXN4G9tnoz6lvleDAFSmXC6kGVZ6dcmUP0xhlrWYBjhI5z?=
 =?us-ascii?Q?U+e8TgILliCG5kGXAjnpF2dwo+4p5z3aPhHOlzfvSqbc2tw9GdL0QeLkPWgR?=
 =?us-ascii?Q?L2ZjD4VcYkIk5PBf6U4rWAWJNBncctW5n699tQVRR1XP3vxU35C/0kP92wgP?=
 =?us-ascii?Q?ezlDAI7yrWNHKuXL5kepqEP7A4OoJdNpvf3QkwvjCddxmZbHLODl5eDGERA9?=
 =?us-ascii?Q?V5gGdmER8sGwyHTRCNklC/KFFWGyy1ki2W1vpv+1FZQdvuPqvg169y7KdPSO?=
 =?us-ascii?Q?UwVfyUcKmsD4EqLwbqFG8qTe+IQn+f7k5voCuWi7ojmbiicwPakTBmHEA3N+?=
 =?us-ascii?Q?KNE4U08IwitA3F05CM1ASQJdy/RltG+xgMZ+rNnkWgPzcTq4oZNUEcvca2Lv?=
 =?us-ascii?Q?T4bKRqgKVqC5LHpS+7wsGyZOHtDclL0l/i3Wlg/3IbvhYEjwBD5PoZiC/Sl0?=
 =?us-ascii?Q?m7yk1MIyNrw/QBEk7eWNDfoNqKKnwg4jF5HePM/uAOdKMuusBJzopCpMTfIV?=
 =?us-ascii?Q?Y0EIAl16gXfjCt4SxqmnPX6HOxpnZO1Uoe3gaoefN2IOAWI1fm1qyFGp2GJg?=
 =?us-ascii?Q?rUdVQ1c3bmB4wiPASPO96hJVrVJj8nAFZWsy9I2m3I0qIcJlmIK/JXU3GR7z?=
 =?us-ascii?Q?8ONkDm6o+fvs+PgmnIkHdLbpmkzKog860thDKYMEswdDLn97gabBOarqWxS+?=
 =?us-ascii?Q?Xui2MV+zoM2i/BxDo0MrW68UMI92xQDEelu07fk30ouXEQMXXXJxphhvoE5X?=
 =?us-ascii?Q?7RDZTc2EsTGY/AoK24NeV9YK2PNduGLS9s/M7Npb1PjKlsYlV7cA3vxq7KAo?=
 =?us-ascii?Q?j5nnH4cy3uUtXoJCLCwPmitf66R/bPKmngYxxVXc3nL0TdrnByvFxvFC74fo?=
 =?us-ascii?Q?ujCkt1q7o7nhcj2Ba7U9JZ42UfPBrtMk+KGsdELta0R27V65LYA9h0xzSB7a?=
 =?us-ascii?Q?YbbD+ynuWd9p1K8PNcljzwQWHJ9AFvGbg3jSXpji8zAhvxWR80+tg3je0ugJ?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CLiQYd4SD7uCRpAEeDvR0Uip6UgYZ9jRZpZzvlnBvXrhcflUr618BMTRTgk4HhgJd9e5d1G1iU5Ib/krTdoNWuKXVL2rAKirI6mbayOTnhCIaidVrAp9H8A8/7bv6ceIxwy/gLnX7PBfMC+q8HDwWzNDdcW7huU8gaYELcL1Ee+XvksEtO9XOLQu7MzGWa4wtT954mtNbVnbuYgEvGiJB89PHJngj6KjLdCjpHAq2s8zj5bGJsLeYskZWnXA3L3lfojG/xjZw5dyxE0tp1D5Uk7C+LWuH8XBCeCmi752AbkwZcFWaZ9n0YmwEZvWeYxIbKGrk/R+ENYAMZ+AImJaDUJBaZj0nm3PX1n4Mg7tQzrJFuv/kVl6D3DwNtDOHZhBoczoNj06F6RFpjasBEGRJ4HR7ddkzsAmHG75I3ISlOWJp1ovyV8B3YREtap7p4wpgg3ufy6359oJunrNPdY/B58pjD0zBwtUMd5ypCKLWswizwdGPntyguyREMG9wwBq82yiv8N8wIxixnS1WMLeSBCeOJEl/NDqW63REzslgtHubz3WsK9UxztoXx7o0TDO/Zsmut4eIBtq76iObUh3uB2JRXMQL927whZZIiDKN5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e350dc3-3113-4b3e-bd60-08ddbd41dd92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:34:36.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96KyO3UYe6q8vtxfYpw854uYImL7mQ6ol0Al5VMIxP5Lrau06O1a2BStprPzwBqlq1qWjz+tmSqI3bQj07kF4pNuJ2iTVvzhilIpG/Gjti4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070061
X-Proofpoint-ORIG-GUID: V2vnlIMvLb3TZ5udksBfSw7NjC6lMmy3
X-Authority-Analysis: v=2.4 cv=dqDbC0g4 c=1 sm=1 tr=0 ts=686ba2bf b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=m4-WtICvbMxs3CMxUkUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: V2vnlIMvLb3TZ5udksBfSw7NjC6lMmy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA2MSBTYWx0ZWRfX9afoHijh3lQr BaBTBgoTzIRiu36ZzZi0gPzGIuL5bbrMX1wKjElhd56P3PqhlHIzWZwMffFyAfNqzc03+kghXWf +cE6Lt4v1wzbtpSkV/cRtikfeDUTJB6ApCzsYfwI17RhTeZrECSJ7WVK4FWHTH6kAZVrcRUCJh/
 Up/kyqqic9i6l0dnB+4gMpguU1qATJIYKK9LTj90NfPOMaoWb9W/GsadVC2oyUxr/fqdBsXizln kzPXoPg8/lXWtC1OU+TbfuiVL9h0p1CUkEtUlvlGVSipp67dXIrwPfPQH8kPYc2HZ72GCn/EXDc ESgwBICPCY1QovR9xb14yzqnbW7UXGoq0ATYzy3pm9ZwVYYKXj+JCNhn3bWVl2EaoTIoxf+i+ml
 JsKhRSbNrcF9Uw5WrkMJnKoyDDf0fhrMTUGl44N4ZJ7iNHP1Al81ABhoEI5V3LlRPy3y1+2M

+cc linux-api, FYI - apologies I intended to cc from the start, was simply
an oversight. All future respins will cc.

This series changes mremap() semantics (I will update the manpage
accordingly of course).

Cheers, Lorenzo

On Mon, Jul 07, 2025 at 06:27:43AM +0100, Lorenzo Stoakes wrote:
> Historically we've made it a uAPI requirement that mremap() may only
> operate on a single VMA at a time.
>
> For instances where VMAs need to be resized, this makes sense, as it
> becomes very difficult to determine what a user actually wants should they
> indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> Adjust sizes individually? Some other strategy?).
>
> However, in instances where a user is moving VMAs, it is restrictive to
> disallow this.
>
> This is especially the case when anonymous mapping remap may or may not be
> mergeable depending on whether VMAs have or have not been faulted due to
> anon_vma assignment and folio index alignment with vma->vm_pgoff.
>
> Often this can result in surprising impact where a moved region is faulted,
> then moved back and a user fails to observe a merge from otherwise
> compatible, adjacent VMAs.
>
> This change allows such cases to work without the user having to be
> cognizant of whether a prior mremap() move or other VMA operations has
> resulted in VMA fragmentation.
>
> In order to do this, this series performs a large amount of refactoring,
> most pertinently - grouping sanity checks together, separately those that
> check input parameters and those relating to VMAs.
>
> we also simplify the post-mmap lock drop processing for uffd and mlock()'d
> VMAs.
>
> With this done, we can then fairly straightforwardly implement this
> functionality.
>
> This works exclusively for mremap() invocations which specify
> MREMAP_FIXED. It is not compatible with VMAs which use userfaultfd, as the
> notification of the userland fault handler would require us to drop the
> mmap lock.
>
> The input and output addresses ranges must not overlap. We carefully
> account for moves which would result in VMA merges or would otherwise
> result in VMA iterator invalidation.
>
> Lorenzo Stoakes (10):
>   mm/mremap: perform some simple cleanups
>   mm/mremap: refactor initial parameter sanity checks
>   mm/mremap: put VMA check and prep logic into helper function
>   mm/mremap: cleanup post-processing stage of mremap
>   mm/mremap: use an explicit uffd failure path for mremap
>   mm/mremap: check remap conditions earlier
>   mm/mremap: move remap_is_valid() into check_prep_vma()
>   mm/mremap: clean up mlock populate behaviour
>   mm/mremap: permit mremap() move of multiple VMAs
>   tools/testing/selftests: extend mremap_test to test multi-VMA mremap
>
>  fs/userfaultfd.c                         |  15 +-
>  include/linux/userfaultfd_k.h            |   1 +
>  mm/mremap.c                              | 502 ++++++++++++++---------
>  tools/testing/selftests/mm/mremap_test.c | 145 ++++++-
>  4 files changed, 462 insertions(+), 201 deletions(-)
>
> --
> 2.50.0

