Return-Path: <linux-fsdevel+bounces-66725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65AAC2AD2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 10:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797DE1892EB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B432F3C21;
	Mon,  3 Nov 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zd8Jl5cw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wYN+wCB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336442F291D;
	Mon,  3 Nov 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163016; cv=fail; b=ix16TVXnqptgq6hHNCo6fJcn+nVXnb/VaafxDKnoOjErUGiP33l5D6TjfM7IVbMxCEwmJ4FY71f/TzK7LpYK24MnvAXvY0y1AI2z40avaKr8bDxseC6O/8OlH1NrLZq927KlRb3i1BWhxA+nsomStSzcY+q5vnVu5quCTZ0wyDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163016; c=relaxed/simple;
	bh=C7gFJ+/I71HnYsaNhx+12vNKNG5I+cyEjTe5YOmxH+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uohJZjw3+BNFw1zDLSuNhc31lUandESh6eLEhm4/GxcgKjavl/lJZ2XgKQY7kf6MCziwFHcuvxWiTlbGfKMdZw903sy77+Z9GzC7QVHe+DFTfny51w9FvXvQam/7YWjKu8nqAPFnUZnmvuxtdnRBSkytzDZGjsmBe9/icEH0Tk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zd8Jl5cw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wYN+wCB+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A39dTWr026864;
	Mon, 3 Nov 2025 09:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=C7gFJ+/I71HnYsaNhx
	+12vNKNG5I+cyEjTe5YOmxH+s=; b=Zd8Jl5cwrOks9cl7SmWHY+zl0S02f+ORYv
	KbDBDhuSgi1NeF5fktdDf59ha89uyAPmVnpX3IsZb9ijTUdHS3EaukbuEaDWoM2N
	NWN1G9I1D72ovccC7/h1VVrJEYvtxqEox9pSIURoUZI3j3Ev2fUm25hHB3uG/OI7
	A8KcZb+FxloKkOhZHZ/ZSyvMlrDNSvHXABpGZWPajaxc+NjIq+wFZM/44L+dt7+u
	hyoHNMDkl4CkQsOo7CceDityt3pDDFsh17HnwBy+NKnEVpDqJHsFGqbmEJ+a53WR
	pcdKFOi5Z6aOb6n0I8jqPvg9Dg1CxsK5cuGRH5xrrhs9fO9Cm71A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6sxyr09a-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 09:43:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A37oVSO021132;
	Mon, 3 Nov 2025 09:34:39 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n7w87r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 09:34:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhFCnAeT3Zo3gCpaE7uiP2ayZq3Bxu6FC8/VnYXlWUh5JnYUp+EG5f/y5rzCIWLbB8OsvdcVRykbGdCAWUbdpnBoFBlD6+8S6bmIDyGUVhsAv9FYPvEHQGqsP0oLoKxNY79JUflN4eBvzEaC6w9cib4n82rQaz4H3msbL25qa5Px06gGwSS7emsqePd6rSMxPTX4a5J2F6RE8M0B86aIbHUu5HABLCBzzGHccObW+ypBSWoNCh6y+JrPpXUFVLtymtk1rrMN+uBvxd+gsFbc7fB5dzT1vzQ7ghXHu4ngmCvg+qJuRcly866AEl8Wt/W3wWXXTblExipMG9N6jKTckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7gFJ+/I71HnYsaNhx+12vNKNG5I+cyEjTe5YOmxH+s=;
 b=XVdCccsrjfc2Xfna6+yRfPLU9HwaVCjIN4/CkbauTBDfGwjgDFFg/38tm2LiigRdcJtUxxXCBpC4y8bwslvrx6CAAxo973QENoOkuGfMoM/ZJPg9x5uG2+4sSWFr5Jzhjve73eI7pNl7BH3lGBV0KACyPHJNhCTBQK0TPiIf7WJJHO9mkvfBkvxJuTWEnpcll8gDAp9/DnzXyjdlEMCXG7rD1b7F/qS1wWGPyiPwTou4vE5cz3levfvImPAtjwVjpw0bC4CCTndvl+RNg/dMaMgz/pRS8P192JLBDoA2mATrqYQX6zk8LkdqoTf5WXIZvFf+sq3bEXzWh3PFIxCtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7gFJ+/I71HnYsaNhx+12vNKNG5I+cyEjTe5YOmxH+s=;
 b=wYN+wCB+wDrTX0Vs/zIZsIVYcSa2J1h11swgY+R/fhpeas/hvUZ6j8CZDRIzUSOq+LaiwmZ20Io5R5zHLIdKuI/4vz/UcucdNu9aQQ3cApPJbUY2QUcxnnjRSNGupvBcqlWLN7wj6/BdJAQBYaYp1QLKT7g6b3AhIpqY+txOe4Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6463.namprd10.prod.outlook.com (2603:10b6:303:220::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 09:34:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 09:34:35 +0000
Date: Mon, 3 Nov 2025 09:34:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <15d3b854-a2f2-42a3-b2ab-3a8c822dae9f@lucifer.local>
References: <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
 <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
 <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local>
 <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
 <3ae457cd-6c18-4870-a617-7f937b107cb4@suse.cz>
 <88b72728-fa3f-4a70-9ea2-40ff50673047@lucifer.local>
 <a3bcac19-78b7-4918-81b3-641a65a19a9d@suse.cz>
 <CAJuCfpEs1JTywfZNPrVmeTHUUyK+7waCU9fqfur2Q_xxx7hacw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEs1JTywfZNPrVmeTHUUyK+7waCU9fqfur2Q_xxx7hacw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0651.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3761ee7c-265e-4efe-0196-08de1abc33a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VqMvMqK+F9u00CfPNq4L4xxF7rck2VEMw5gHmHfHu4AhCIAC/h9xn8kH9kAX?=
 =?us-ascii?Q?7ag0HnKIoT1s55JjEPcsE5fRPs5UycZyC/dNL6ZDVcrKwLrA85vDFkqIABf8?=
 =?us-ascii?Q?OeFvXYOs0zyLTDvvk+CCourKglOxB3RbC5UBalHMMdcl/WBJtSVdFf2P4j85?=
 =?us-ascii?Q?pu7JKizPtuh9ora44i/CO6PVhsErA1LpPmG8jxtfTrA6w60bp9bXSZKCDkqu?=
 =?us-ascii?Q?FG2rxHsKNy0Igb9/E/6+YXaPlLebZrD9oHSkxhHh0FkhespjatKYPRJttPqA?=
 =?us-ascii?Q?INW90RKhruSdPZGg0TqPcYhAeUW94svjpwIxqbhCqorKLgkibqCHOLLY+Krd?=
 =?us-ascii?Q?vLm1rs4vk9phRHhPOP6uyPz0GdfEeWpNDEkhVHRqNSf7Csw6WU/uEGpRJKF1?=
 =?us-ascii?Q?I+yKX5dOro4UgYq2RJFC/Cu8KTaJfGJG6vkTmxokrI4PP2+ZjA9WVOklipes?=
 =?us-ascii?Q?eX69UL52c/ikTVjOVJ64RY/bRL4P2Lm0sMp8hirIqsdd0PhlTTXQ7hMbv/2s?=
 =?us-ascii?Q?le2FZmN7Yh97UQCwXyjN0ZL16Dg9G6bCnuMOHk0GmxqewylOdLRCZwz4wuG+?=
 =?us-ascii?Q?YrghX8o854+9HGC4Z+v/EMUxuGsmQWQKqUg26u1arA3ek3TALzjHcvgxUgMv?=
 =?us-ascii?Q?HstArPjdwX7lRlS9ZPzl8ecm4Wh6OKJHfBF8UrCOkdvmbaCY22lsaF8CbyMD?=
 =?us-ascii?Q?0zZi4wRE4L2VTi0ifMvyI5kk7KWfAnxUJkBafXMWmVNf5bEhcweWDuIIZigf?=
 =?us-ascii?Q?e3LUX/GZ8vDe12kC1dYrHOrYPQlCzVb91Hf2bdq1sFpg7CZ1J9RZnuxff/Fk?=
 =?us-ascii?Q?EGQvnZrtiEkCJX3Ea73s5oC7bMyU6Ihez6H0w5PYKg/i9A4R/Xc/twKf7O6j?=
 =?us-ascii?Q?t7fwzsaXS3QjMj/mHyTxBD8dfZOTrPwPphnR11tbLmUVZDGewzJYmR6URQSp?=
 =?us-ascii?Q?r+tTQi7laHTq5Rl2qX+m1laAjqqIEr0L5wjt15rWlyk0XtEXJwoFeSoQo0Qh?=
 =?us-ascii?Q?iPXBw+AUvzt9+zWuk0wDmE1DpClOOuhlow7HSBUbxRyyrYLv0+PKxDxd3OVe?=
 =?us-ascii?Q?/A/EASvvZYgyNaqjEUh3ixQlU3kKjTyd/RtEHOVGhuzo+biNUClrtjb79zrv?=
 =?us-ascii?Q?EYISMUJu8GiHto0OaLsoP+g5KE1paEdTmvGz3fI0qbQpKMKOMttpi3zMKp7t?=
 =?us-ascii?Q?LZ5F1jvcf4Rb7ZpV9uPFnC1J24TIB1mF313P5XWQknxtS3x9LZQpOk+nGi3B?=
 =?us-ascii?Q?ahgpUbGT/YxLATDFtPQ7gQvhU/vlZ2/ILO02o9NI7ula1vz1X6OyWTJ5aOTW?=
 =?us-ascii?Q?GtESAXlu0UsozctFqWPUQXLwiksfhS+84VgZzB8K2zyj2C8xgMjMHVWG6f/T?=
 =?us-ascii?Q?WE1u9aTpV1tmZ4VDC6D3d/wn+Hjm15LY7NbMHO8Ku0gNavPJR8ts0qZ2q+du?=
 =?us-ascii?Q?wLWMcq/2UtwH9R9TMy9Abk3PfY/wEhBU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZgk2lPyhd+HHUWaGITkeFb60HzUkCSWjVigld/mGZgsW2oMSLRoZ8h53O+J?=
 =?us-ascii?Q?mtbaWdwJZQ3mo1ETPSzcftiEnhjwpflyy6I6hf3kbMlmo0OvlPKbCKK+vqXY?=
 =?us-ascii?Q?qsFXY/4t0J/zs19rFL45WrlGIFjwoZUrd3wOVwAjO6EzyZcQs0DN5JX8LRNF?=
 =?us-ascii?Q?gZcjEhmvm5bB3BJrR+YuQ8nC3CsTTXak20booh3kjQ8EIPqLQLWvM+SiKnPP?=
 =?us-ascii?Q?WAQd7QUH+PaVZctsTJlLozcCOqCuAdk/lHY2Vz/mYoW1Qy5i++9tzVwTdUd4?=
 =?us-ascii?Q?oBZcyfl/BJcgRPrZfjkq6ZbM3XSx0j4Bx1t+x98RnCG/PZDB1KB6XXaD00H4?=
 =?us-ascii?Q?OM/hrIaPYOTPTJj0u+FuOzEhasMdG0MKCgPcx7NZNlE8sVjt8hxlDy/OAGjx?=
 =?us-ascii?Q?PjjROabmgtsJCjiiYNyb0pPNaq4vP5JHsdZAc6Di9NTWS+YD1SwPwjayv9O1?=
 =?us-ascii?Q?b/b/HABKwIsSjk9M8l9dIyVlUpv/XcQ0TIbiSxaDsiW20DP44l/zPIpIIp59?=
 =?us-ascii?Q?0Hn8LLwOygTFnsHYv5fsbcOThBAujnQ5lX76kW+Kos9GqPPtfIxNTUGyxVzz?=
 =?us-ascii?Q?VUR3SmsNcdqWbKprba31oOv34xlQcLNaexBA94+Yb/qIW0DcnMgpvLsjxYz4?=
 =?us-ascii?Q?JQ8hjsRZJgg9y4p6s51KLgBSsLMR0w+hQZgLjvUqIHfvKyyeOF8+5+S3tv7w?=
 =?us-ascii?Q?woM5dLKcEVqg0ytSGKuLjWpnDjf4pUxlDnAW4Ia11s6qUWnA5ilT6BrB23ue?=
 =?us-ascii?Q?ZJbpNTNoWFMe+SDhVPLdKW/gLA9/HQuB3C7Q5OZblwH6CbuQACxpCcR3zmU8?=
 =?us-ascii?Q?V+uLf214zFOe5pE/LsN2lC7TwSAMNtaxyXX0CICzKPOUFQPU7QUmuZ0eExWv?=
 =?us-ascii?Q?M0K8GuhIV7NegoA1SLfGODgEnCdF6aLarhfNQtDh2gN0sGbA82LyB0xe7HtB?=
 =?us-ascii?Q?ftJMgU2JDAODLEqXsdMAg49Gy3fMU6iaL0S5f+1EHV7tlHbOZSrmxFR+p84E?=
 =?us-ascii?Q?qfLStZFNbYoddSpZs8D13jh7s0fFFmwd8tSlap9uMmVo/9D/45onQDOclKng?=
 =?us-ascii?Q?R8CrEJYXClNhHD4jWg8+Xtt3mlcLEi+f+echyAs4qumnLDZOFlfkDgY5q+fg?=
 =?us-ascii?Q?/UT6LjEBXw6UvdiWXV5k3sYEzRgUE2J0CK1ejBvLuqHrtYZ0UbkgG5uLFKLv?=
 =?us-ascii?Q?qJHwALCW6Qrc2NlOVlvuFuTQ5xV68BXP9Tsp2vHMC6wElKFihk7HWk09cFW7?=
 =?us-ascii?Q?rf7K4SUFJ4kyeIZKJXkhmuD9s5UZZ34Mg9EScomaovB0QnITx4gAUBVw+6nW?=
 =?us-ascii?Q?EqvHzfNeTmpmz4PNgGV2qCPByaYKhOCBNYiwYrwCOa1aLf4w5chh80mbnANa?=
 =?us-ascii?Q?7lUBTdtQgTz+y1sfCGajPfg6/XxYgL2+H5E7whizVNstDOo3/S0hHAeOtQy7?=
 =?us-ascii?Q?jnPvrKmTRJxkvCQqYD4P6MBBpRqQQhqBRMaXS7J8HQ62xKV6/29pkAthf6n/?=
 =?us-ascii?Q?7wfRpegH6cQmoVYUDZBHu2J7W0ixkYOZ5yARPss/+5pP0clZVc60QC1QQx4Z?=
 =?us-ascii?Q?TBxhdeVHK1+1nenv8yhvsY5WbSwBYkwSWb0ir187jwahtBNKC5KxcVTuZ4Kj?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jW8gdFSjLkGB5nLeFY/5bZXFvqHfWlUMd+JRgu3YIaX5AJcT7POZWID2rdkc39Fo3Ay1Tfgma86Me+X9V1hWlMR4Vo/KwfB1R8zsKC2ENLGSfR+/KBynWvVwxFB4F/X2q2rwGN7JMXWwqwVi/4rIY0ENuUzK4ob+MudHjwbkLGeyPGih/nEQVQXC8oX5M0d0HT5jhXMM9ABovRHFrNb9oL7JJfbkqyfoz9b/GN8yYb3a8X2yG09wH3pDLJMmyL22sZQpfr/xNkfPnUUlLE2ShW6loM9e/N4T59Wr6q+IJHr1sxyB4vdrcHqnHpk4+B58xdzf4QSn/5cHOevnKupsrr48q0eEkRcqcUpOzMEWipHgoffMzbzQ0BIHT0+wWeizB92wWOzNYF3BMJmxU3XMSwhgbe/S8bTHXl/AtnzM5DoNuOS0bNhAxsL418swJ4QCIcgy7HJQr/jySO6Zn1e9xOD1yqBHODBxTWW48myKb5B1GZ3iMU/CrGw1x/6ehc89nh0cxN731RliGv7pnHEMQO5gVGsbJvJLTcrdgsuSrNhTgpaIde/vomxnN23L063OkXOPodfG5Xuc6X8KqnE3ohLkV56ozGN7jxvb/9zheTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3761ee7c-265e-4efe-0196-08de1abc33a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:34:35.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K7VY2NbpgO6f9AxNowL1x0nwC+Y8NmuD3QB2UenBK0Quwgki5LOXAi3qn6gOKU7KvGSYzNCsa3KqWiAVimwGOcKY4pEumMwvq8fXL+zRUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA4OCBTYWx0ZWRfXy1e/UZp6EGrH
 swi18UZYmxYNYBJ8W3B73SzHm0ISYc2ef30Q0mwOSdQbPLvDSKbUxtTK/SPmQ3lHOiyAH2Df6+W
 dSnMjp5IqzmCkBepGiSig7+ETiX+C94GK7afaWrZJpKmmg8PxoOSfIRBn0OvJy7nfGhxlr9FyKT
 4ybsSt7KOAf8Le57dyoattFhsvh/uSK19+/VUU0OfW9L7w02t31Bv2FqQTCjfeG1aKGogehjT2t
 j53Fc1oMPR+8UVp+EWbRJk/xYQNd6+M8zPhfonu26qsYdVLPsJ72VWMWDyKHKTprNrkE9tbYvtT
 W6H3MbgjT9l8ID/CgfrEGLdr/1UWi22BZq0GVKRkm9/hMgV4xgykJVHscb24rZJ+KQOS9h5yb0s
 W1uT/xpMsDqMHCFCyTCgeBwYSqn1Bw==
X-Proofpoint-GUID: b0FqTh1Nz-EdxcxEIPxobtuBdC5xUa4d
X-Proofpoint-ORIG-GUID: b0FqTh1Nz-EdxcxEIPxobtuBdC5xUa4d
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=69087931 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fo-iZTF6wNp17FOTv8gA:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22

On Fri, Oct 31, 2025 at 04:12:51PM -0700, Suren Baghdasaryan wrote:
>
> Overall, I think it should be possible to set this flag atomically
> under VMA read-lock. However, if you introduce new vm_flags
> manipulation functions, please make sure they can't be used for other
> vm_flags. In Android I've seen several "interesting" attempts to
> update vm_flags under a read-lock (specifically in the page-fault
> path) and had to explain why that's a bad idea.

Yeah agreed, so the idea would be to absolutely ring-fence any flag we do
this with entirely. Probably a VM_WARN_ON_ONCE() for anybody trying it with
other flags so bots can catch anybody being naughty.

That kind of 'interesting' stuff is another reason I prefer to really limit
what drivers can do btw ;)

Will have a respin with this idea applied relatively soon hopefully.

Cheers, Lorenzo

