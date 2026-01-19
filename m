Return-Path: <linux-fsdevel+bounces-74546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F1D3B9D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453C6306380D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113E2FC011;
	Mon, 19 Jan 2026 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FcKBIe13";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v/7MSR8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D843002B6;
	Mon, 19 Jan 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857658; cv=fail; b=YJVYhRvlXB49Oi6OPt/XzRvd/hZsyERqhcli/s78mq91xKdk4eEfXTdp0t9qrnNNzA/2LT7SBy3vda7XSCyUUFS4otu5drhi+M+blzqKL8mIzGzXU3jruCzcNCtt6TAgror6A2bdQruYTAosfMjnAjAYdyFrWnlyoa39Ebda4QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857658; c=relaxed/simple;
	bh=RrL1YrF/ydes71YpxmYFXa8H0pgSTyb6/z4K1mPDVcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDVBaKYzm48C2TuuF+1zs/s1MraEZJRcFYq+Ylmlyv32mcWpp/f5TfVvT89GcOPZrZAUdp6Wvf3bjJqyOTNdTANHxQjoV7X0QFIRzI49rZb0pEvOAc+QwriyMbhE3IMbFhTyVvK7aCKr8zn7rGe+zNuM40MTkGnj9H44hr1lLcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FcKBIe13; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v/7MSR8Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDOdM1429446;
	Mon, 19 Jan 2026 21:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AUq4K8VjVwumf5bgAiUwX+geBnUo1Z0iL8F0UQgwhbo=; b=
	FcKBIe135Q/48o+t0387X4MQbdAezVGqsyJUXkwvXM4dXRPFY5iV/gWyVf2zebXB
	2GOB+ZF7Q1T+N4Da3aHiKM/yElTMozPsnnQ1X4pphq5UGDPlZIi8RbOaZL0+Apyy
	L+7ZguhL6UJlebnS7vgR1MjViFzYLnKbNkIl2Ki+O6G+S5uQyuUvvGIQib5vfmxu
	hXqjspHDGdHIoGKdXkGDuUfPGnsEMsiCMTwbdodB6dpMBbKm8O+4AcyYCMxAqhAj
	Ub5r/FVfUHI8gtPh0lTp6I89r7LcxpZIsS1W7Eg9k0yLiLHwtCsX4IDWypYUKPuo
	purSh45J51Dymrz7bsMSnA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5jpg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JIQNgQ017988;
	Mon, 19 Jan 2026 21:19:47 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8sb8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esty+AzbMa1NFxtCnB79++ndb1VKdSXM0L9SQgEmVKwQMvYChlxuTZBdwr/Pgxica4qY2ezuZBMSbpoXJ+6NHtY/piGO07orXtwpS4s8ekXh6DEY7bWyjS+QoaJBDAghvDkw06NONmZLMLd3yLdWg70ajMErSG/EZOM4t/OAl744AtX3zC5fMj8qhjP1b70x14y6UCB8UsHPi3QBmVXC3UWPSw9V3rK+5jULNkTzuGwa1QThlgVoL8/bekqM5OUnudvonx5/MwKBkWVqmjcB+R42c/GG3avqexTn/vmANykeb3AVs7ljDJ/q+A/wvnRQi9aKh6lSG6abj0Ku2HxN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUq4K8VjVwumf5bgAiUwX+geBnUo1Z0iL8F0UQgwhbo=;
 b=gFe+P45YRH7kfXH5sGCHsfKaS4kbRlf0NKPe1VOfGQHn2TaZXElgnycILjMoUO5qUJy/o/if0Mxe8kQ3ctM0UgjyR9gJe15IAs1DaQkH12mc+Y4Mf4bMCqYYGPQzANa06CTaRUYydFHVzgWGGUPj4p4bxBc4kWyxoPXOlCmgSNs8+gssXnu4qf+BOR0gT/0efJvE2jOZ4gvwcfyGGdMw6xAfSplq82kYpfg1exV9CiTLwaJ9mvsD+5CIZfodwRN/8P2RBVxNvOhAk8hk4RCyjklx8Atk4xzyXZXlIxK0mrEYXI7MQC+ikNGDBxV1QZy1Bx8Ruqu74bDyQQ0wi5+Tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUq4K8VjVwumf5bgAiUwX+geBnUo1Z0iL8F0UQgwhbo=;
 b=v/7MSR8Ywb+RvkgjQGBIjL/ZiDw/F0sSQvdi3z5J3y3wPSrG0vjnfrTfhmD9vvMFelKfAbhhrRHQLgqy46QbQ8YEJv52MfNDwYnBFjWNeEBNLA452whZu5rwJFQB6yDuYF5u/nvcW8GM4E40YKt1aOl6IlpFeSeMZzAshi9iowg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:39 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH RESEND 08/12] mm: update all remaining mmap_prepare users to use vma_flags_t
Date: Mon, 19 Jan 2026 21:19:10 +0000
Message-ID: <24317e6f6b71e8b439e672893da8d268880f7ada.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: a15ecde2-412d-40bf-3441-08de57a07459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S54u6PSc6fY9Bs+7kiMheUmXC40BxVysar73/hut9rWTVGX4you5oM3Cu1zv?=
 =?us-ascii?Q?EDjJwg+Lx1fAocXxMmTJk/LSYQqvXfdAGMs2UVzodGhcsfEAUuvsAGKdqDPU?=
 =?us-ascii?Q?7EbIRKQcn0Vmo3RejO6T4No3qNTnfXOvmW7daR2A9KQCY/udW1y/H9+kUsJM?=
 =?us-ascii?Q?BN7EPNNgwVUurLHVrxUp4uF7Oks8GsHoiyzm9vsvQ+5CY09fja6m/OuGVucU?=
 =?us-ascii?Q?kobwwIYK3IIWoan3/PYGS9RfI5UvmbGK35OkL6IWoKRN3UYhruh/0BYm9UsI?=
 =?us-ascii?Q?7Q1DQXpb02FzhbFjkKYytsrrOwBcM1xLPTV8cjM1b8PWONxu1Qs5eE2yogrQ?=
 =?us-ascii?Q?JeeksQ6mYkCtUO++23ARYFN8g+wMXvEFhJQjBxkenQrVgGVHeru49y5nM24s?=
 =?us-ascii?Q?iRoNGmao561XFUKYGa2yPRizu5kTGq/4Wpcu7Ky1M90udyPi2ww85MH1Qd1O?=
 =?us-ascii?Q?8HLxRSp15h8TGvvOmKK3nKaNF+fvI6pSHlc/eK+058dU5L5Wo7av/2iKHUA2?=
 =?us-ascii?Q?+2Whj22FI+XEuOoDnFlciFK1sVkRJdIXhcCDdgeinBBYDP5iWFVuhdzHzivp?=
 =?us-ascii?Q?hVnm0Wut/j0os0owtdVeQo6k+P4K9Wvbm5SB+LFGwt861wFLHjJP8myzqHuM?=
 =?us-ascii?Q?vSbDVoJnWTzZQUkVbUbFsgS2BzBij9qyWp5K7WIc8XrEG5ZMrfmuMRXP9GuE?=
 =?us-ascii?Q?5Kr0DNxbIJsjLoClkWLID0g/6pMvR8uJszjfCDzSLbZnod7F5QCa9Jngoo5G?=
 =?us-ascii?Q?tIrjhg7eOP2NpwEUD0CzSRyulveRUMaUgM5vUyHD/ijRTILRgN5YiPqmxus/?=
 =?us-ascii?Q?yYR1SpgIGsokIaoeWvfUidqBatphxwEH7YZa5mOpC4iLaROYErpiaYS5Edic?=
 =?us-ascii?Q?FZehrA4Y7QpArQEDrM4rGQjK5GTrqri3VJwHkROhohFYLwHYShp3TObQ9cQh?=
 =?us-ascii?Q?ahlXvPW7oJ5bfoq8zZ+KtrFAseA0RdODzvXjt7/DvaZCvi2od3KH/xVLoyXT?=
 =?us-ascii?Q?WCsVBS79CyDZi1DuWCBsx5Vp+9eFHhIky4e+IC9PAEFnO/FrKMh376Wc5aSB?=
 =?us-ascii?Q?YEJ9OROoenHGKnss0NtIIkHzR0dPSyp0lP90yB7MaV7FBn0z4yPhDNXdwZ8n?=
 =?us-ascii?Q?wSpaXLs0k1+Rc5LzeJNshrZTHzXMZAGXRJu+h1OFqyR09LiuSM18f7ZVV1mh?=
 =?us-ascii?Q?9adYdO/RifiaFEsV6RemZ/e6WZMd0jjMc+iMZSXV8RLabI/C4C7zz7slHgq+?=
 =?us-ascii?Q?lB0egEUowIhtT+6yzk3pt1VrgUNEJrQa6vm9FaTXWNEhkLZFJ0RWjmbF473f?=
 =?us-ascii?Q?t0zs4QDB5fB6wN+VrbOFPIqNcLCq/ADjC39YSTRGPf+nwqBhKsQcqJ/D/4EA?=
 =?us-ascii?Q?hDNrbEMWmH82yiGvoNLYupX5QNPtNy8ExAN9btt1gLfaguSWLw72ukOuTy1G?=
 =?us-ascii?Q?cEr4KfsEteaw44nW79//nOQpmG61Eim9qVBG26OAMpiJydBgJMZDQxlJAfRO?=
 =?us-ascii?Q?kh8qaCwv+wquS06FoaP+zyCjOlGACpm3IzUysk7KRZIot6kGGW9fBxwjvjsG?=
 =?us-ascii?Q?Lazo497yqsPazaAhj2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XL0HutK9y1L4geH+WyJsOG0/y/oQnWyOsB5yagPGhoQZkUrWvkcq2aGH/ONe?=
 =?us-ascii?Q?xtjjw/S6rsywh5HAcTPuIlAyoHtOxxzqX/62HFZ9mGva7/EWOfZCvqxJBZBp?=
 =?us-ascii?Q?B4Z+5tyaJp/1dG7e30XlowWeXadUNpXFiI6hZFnrsd0GGF1LancivGdA7IjA?=
 =?us-ascii?Q?GHTqzkFshBsmVkr6ujnrhXqiu4R4o7KLEH5uQTY8xqZtkgFB76n+Q+JgeaXM?=
 =?us-ascii?Q?+9YihGrfdClt2AQMJMZescTjteQtwa4//4i6vfoqA2p16gGkLzw8mopHM34D?=
 =?us-ascii?Q?waTSY1ksG+QsbxoHH2cFB2HN8a8PEsIRuG7gPA07WNqGGOhBDvIpG9d4vAi1?=
 =?us-ascii?Q?Xz7TGBGJHt/4Yg7DgDtNa0yyxb1HgLGF8rzX2Xq4UXsYjdCKVUJseM0lUgpk?=
 =?us-ascii?Q?0oprdZHr6lZUwx/4akYfi613FiP+jPp7/L4DX5X5dvSjw+XzVJXvbsHe8Bip?=
 =?us-ascii?Q?dOjZKT8SS8fy9+2MniVKgflf4Xuguo96CpU2GjODgacLrBYHpx9u3R0EM7ZB?=
 =?us-ascii?Q?CzC1LteoRA0sjQayZyKIKl/YJXidzwx0UVEP8K+JQzcJaMLBeo+nPoG6nOVR?=
 =?us-ascii?Q?v5fLz/NyjNperTjClAtxPq6pUP3qR+tMritPnQ6tv0W/xE4BuAilF4fWhAU2?=
 =?us-ascii?Q?9gYkpF70lxH3g5EuyjcvF+GnD1KaYH+NTY07mT7bt7F6JLSg+/lt5RbWT6D2?=
 =?us-ascii?Q?W/kqekUsozy6Mt7ZtPvmzBiFCipkKQK+sFtFNe5cAZW1e4VrquYbLWoqJE5f?=
 =?us-ascii?Q?Az0JKbGAjzRc/5uqxKuZGcrq1bXEwD/76eVXFFw5qj8LfBdb0VH+QjK7w9A3?=
 =?us-ascii?Q?/X0nBTMiqFnmo18IFsVBLZtUCkegaApt5TvNHwzzdRSdsp7jF2dh6SABHM4h?=
 =?us-ascii?Q?ONsk0r2su/wVPZal9NiZppKw8WrHnrf2ZolQgl9QIsyEUFIB1pz9NamrjfWq?=
 =?us-ascii?Q?peAofu302D6A/3J1FA4qSLHM9OjzyBgo97DYFrzx0x5TKL+uv9Zk35rFwtnI?=
 =?us-ascii?Q?4SrEpDdDsBr5Xf11pHKGKSNWrv8+AvC2Tmsfrb+K1V1iGKnDdowbHPk/i6ER?=
 =?us-ascii?Q?bjDijMJUhxWPpwnzNyhnYKW0TaiaDqFgy+xe41SyIMuetQTVr3uD/jKeOsle?=
 =?us-ascii?Q?YMIRKX59c+8A1Ko/6mlfhWHTwezoLygt94oPanNq8P7stYtW/gakIzJXWEBu?=
 =?us-ascii?Q?K39Fd5CYtwyzdQP/P6J51Wtq4jLK+eT1p5Jt0oxSKgW0y11YJAxziIL1094/?=
 =?us-ascii?Q?wCPfTSS/mGu0yonmh+pdaZOGGZR1y3tZMb7hK1M49aadw3F909HorUra0v9w?=
 =?us-ascii?Q?Z5/YlSyEpwK3XPrtCa0Gk2JPCDbU1ZDF9ZH9bBlg3KtmCZtEQV+IvvbcuK/v?=
 =?us-ascii?Q?cRXhAZiu4Pf0Gnx9BWtNqn+a46N7VDWtEQhmpvn3P70tcPkpTO3qMiZFVEdI?=
 =?us-ascii?Q?XICLlOI8aAhpfuWUVkAcbeYwCDmUGP0DPpCNkv/5R7EVuozBQQvoJDm6EKB+?=
 =?us-ascii?Q?cHdDmrIDscMgNg4SxYjx+uL3FLRfg7Ma4rLeqekV5Td2MWHsEMU/vYR2o9GF?=
 =?us-ascii?Q?RtFFKacqEw0ysxmcaHESCVfNWMXpKH8OJFkSHBdv3hQXXECwtRZ6QpAIwJIj?=
 =?us-ascii?Q?Q8Jp8q2KPaDsDw05BWddUX3PZFXxSSUvmZug8YfQsFqv1D0mzaCjcqz0Hxi1?=
 =?us-ascii?Q?2dqaU9iZs36jAUImMxwdWjHGFgpG98efnnlrIl9X543TurSqlq2YOrJXhYfU?=
 =?us-ascii?Q?6RvBFmPs/RK9wG+m4wE4606JG2X/0DA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WHJrer9e9Alh+zeDOKsncl1Z5TwFRxW5k/bbCEvfbyaNVmk3MDgi6UPWMyHxQ3Jdsb5Mr0Kj8qmafx5wcr8HW7ByTQ8TG2oVQtOUyNoOeWz1pRyIptp1j8gN0lwIR6xU4hJP6E7mnrBuVykTWwtLZPNF4Q5Gxvs8lk5jYYGtV/wWOVYUNqpYNOqHq26WOJaJK7R76KbFyT5rgicEHu4dTwtz2dWg9twgzuy4CzYC/Rwz7uMNQJzWKZwQ6zMJZBzjAq32WCrVZ8MX911Ke/7J5JF3QxGR0W1cNfYOA0gh3TbgV7EHKCDDa+O9VIBbv35qV+jzTdVDgpIayiqwjiBlc4nsAb2KtOoZKm0NioiLOfinnPMVpDSNxJwW9Q+pZK8ZgLheEUzIf9Xme7U/0RTkkuQ7oScQ+k1h2Or9XSvIxu0vk4W0asn3fpH1o50a1/57w7H133NDM68qw6oWYAUD617qdaoDGOlz8FLYm6l1NKCW8Lcyhd1DHDqg3KBcnjGiZFREUCo2fGl9TZZnOOoOYnCTQUVOblrUHrxjG3bx1q7dNHmWhZ8IkUaHvJyB9qe4YfCknsAu9N59ED1m3U1uhD0DcI+quAAwPt0MNFZktlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15ecde2-412d-40bf-3441-08de57a07459
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:39.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F7CTtK4spZNRm9G66Ry77MDSVa/LyP7ARt/ROZO/h+UmNCGmIWrOAmJ1V+Pfj+FHZr0rqEeplblJUeZb05xwJTBmwdU0/eM75Vp++7cRHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX/X/X1zBzoJzl
 UR/FePQQLkQdcL6EBO8XEqH6zm2Up7VCF/xZPhxIWqORHKUYqCwbvCEFPJQ6tDWaKjbgVVQBoyT
 /BiF5vFUJ07zl0OdjgxgCs4x8fBNz4/fgU5Hcq5tVYd8X/lg4ucXdmHtOQEhfmgAixtSzuXyAj4
 rVx7dETL8B0+5usH6YFz1pG8spcyROBYflNxp0K00AvyQFsHg0WL9PlVjH/qiyz6RQcLKnDCiqE
 FhMkTKKN9ROZ9BhfBD2cilPC9F+mVAu2gwg6+h0wYp7yAg/0I5uW8m3elUqvbx9dz0QA3az8NH3
 AKcvgLQJ52sYaBgHxWDkOdWwy+Rts90uzrlH2C5gjxeeQxdNM0X+aXjejDicDp9JslYoffgw+4I
 TEKic/wRJU05WWNoIfRkaPfpB7X9OsOOlGdr/48kWg+Od67atPZEwwbHGyw9SqITQqVqIcW/Elh
 olmahtlzjos7XNxNCWA==
X-Proofpoint-GUID: 56QC02gE3Fxc26yZi6ZLKpeWz0SsL6Fn
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=696e9ff4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=M5D02GMWgbgMPnxmookA:9
X-Proofpoint-ORIG-GUID: 56QC02gE3Fxc26yZi6ZLKpeWz0SsL6Fn

We will be shortly removing the vm_flags_t field from vm_area_desc so we
need to update all mmap_prepare users to only use the dessc->vma_flags
field.

This patch achieves that and makes all ancillary changes required to make
this possible.

This lays the groundwork for future work to eliminate the use of vm_flags_t
in vm_area_desc altogether and more broadly throughout the kernel.

While we're here, we take the opportunity to replace VM_REMAP_FLAGS with
VMA_REMAP_FLAGS, the vma_flags_t equivalent.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/char/mem.c       |  6 +++---
 drivers/dax/device.c     | 10 +++++-----
 fs/aio.c                 |  2 +-
 fs/erofs/data.c          |  5 +++--
 fs/ext4/file.c           |  4 ++--
 fs/ntfs3/file.c          |  2 +-
 fs/orangefs/file.c       |  4 ++--
 fs/ramfs/file-nommu.c    |  2 +-
 fs/resctrl/pseudo_lock.c |  2 +-
 fs/romfs/mmap-nommu.c    |  2 +-
 fs/xfs/xfs_file.c        |  4 ++--
 fs/zonefs/file.c         |  3 ++-
 include/linux/dax.h      |  4 ++--
 include/linux/mm.h       | 24 +++++++++++++++++++-----
 kernel/relay.c           |  2 +-
 mm/memory.c              | 17 ++++++++---------
 16 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 52039fae1594..702d9595a563 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -306,7 +306,7 @@ static unsigned zero_mmap_capabilities(struct file *file)
 /* can't do an in-place private mapping if there's no MMU */
 static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(desc->vm_flags);
+	return is_nommu_shared_vma_flags(desc->vma_flags);
 }
 #else

@@ -360,7 +360,7 @@ static int mmap_mem_prepare(struct vm_area_desc *desc)

 	desc->vm_ops = &mmap_mem_ops;

-	/* Remap-pfn-range will mark the range VM_IO. */
+	/* Remap-pfn-range will mark the range with the I/O flag. */
 	mmap_action_remap_full(desc, desc->pgoff);
 	/* We filter remap errors to -EAGAIN. */
 	desc->action.error_hook = mmap_filter_error;
@@ -520,7 +520,7 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
-	if (desc->vm_flags & VM_SHARED)
+	if (vma_desc_test_flags(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);

 	desc->action.success_hook = mmap_zero_private_success;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 22999a402e02..4b2970d6bbee 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -13,7 +13,7 @@
 #include "dax-private.h"
 #include "bus.h"

-static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
+static int __check_vma(struct dev_dax *dev_dax, vma_flags_t flags,
 		       unsigned long start, unsigned long end, struct file *file,
 		       const char *func)
 {
@@ -24,7 +24,7 @@ static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
 		return -ENXIO;

 	/* prevent private mappings from being established */
-	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+	if (!vma_flags_test(flags, VMA_MAYSHARE_BIT)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
@@ -53,7 +53,7 @@ static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		     const char *func)
 {
-	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
+	return __check_vma(dev_dax, vma->flags, vma->vm_start, vma->vm_end,
 			   vma->vm_file, func);
 }

@@ -306,14 +306,14 @@ static int dax_mmap_prepare(struct vm_area_desc *desc)
 	 * fault time.
 	 */
 	id = dax_read_lock();
-	rc = __check_vma(dev_dax, desc->vm_flags, desc->start, desc->end, filp,
+	rc = __check_vma(dev_dax, desc->vma_flags, desc->start, desc->end, filp,
 			 __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;

 	desc->vm_ops = &dax_vm_ops;
-	desc->vm_flags |= VM_HUGEPAGE;
+	vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }

diff --git a/fs/aio.c b/fs/aio.c
index 0a23a8c0717f..59b67b8da1b2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -394,7 +394,7 @@ static const struct vm_operations_struct aio_ring_vm_ops = {

 static int aio_ring_mmap_prepare(struct vm_area_desc *desc)
 {
-	desc->vm_flags |= VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT);
 	desc->vm_ops = &aio_ring_vm_ops;
 	return 0;
 }
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb13c4cb8455..e7bc29e764c6 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -438,11 +438,12 @@ static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
 	if (!IS_DAX(file_inode(desc->file)))
 		return generic_file_readonly_mmap_prepare(desc);

-	if ((desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
+	if (vma_desc_test_flags(desc, VMA_SHARED_BIT) &&
+	    vma_desc_test_flags(desc, VMA_MAYWRITE_BIT))
 		return -EINVAL;

 	desc->vm_ops = &erofs_dax_vm_ops;
-	desc->vm_flags |= VM_HUGEPAGE;
+	vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }
 #else
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7a8b30932189..da3c208e72d1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -822,13 +822,13 @@ static int ext4_file_mmap_prepare(struct vm_area_desc *desc)
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(desc->vm_flags, file_inode(file), dax_dev))
+	if (!daxdev_mapping_supported(desc->vma_flags, file_inode(file), dax_dev))
 		return -EOPNOTSUPP;

 	file_accessed(file);
 	if (IS_DAX(file_inode(file))) {
 		desc->vm_ops = &ext4_dax_vm_ops;
-		desc->vm_flags |= VM_HUGEPAGE;
+		vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	} else {
 		desc->vm_ops = &ext4_file_vm_ops;
 	}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2e7b2e566ebe..2902fc6d9a85 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -347,7 +347,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 from = ((u64)desc->pgoff << PAGE_SHIFT);
-	bool rw = desc->vm_flags & VM_WRITE;
+	const bool rw = vma_desc_test_flags(desc, VMA_WRITE_BIT);
 	int err;

 	/* Avoid any operation if inode is bad. */
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 919f99b16834..c75aa3f419b1 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -411,8 +411,8 @@ static int orangefs_file_mmap_prepare(struct vm_area_desc *desc)
 		     "orangefs_file_mmap: called on %pD\n", file);

 	/* set the sequential readahead hint */
-	desc->vm_flags |= VM_SEQ_READ;
-	desc->vm_flags &= ~VM_RAND_READ;
+	vma_desc_set_flags(desc, VMA_SEQ_READ_BIT);
+	vma_desc_clear_flags(desc, VMA_RAND_READ_BIT);

 	file_accessed(file);
 	desc->vm_ops = &orangefs_file_vm_ops;
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 77b8ca2757e0..9b955787456e 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -264,7 +264,7 @@ static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
  */
 static int ramfs_nommu_mmap_prepare(struct vm_area_desc *desc)
 {
-	if (!is_nommu_shared_mapping(desc->vm_flags))
+	if (!is_nommu_shared_vma_flags(desc->vma_flags))
 		return -ENOSYS;

 	file_accessed(desc->file);
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 0bfc13c5b96d..e81d71abfe54 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -1044,7 +1044,7 @@ static int pseudo_lock_dev_mmap_prepare(struct vm_area_desc *desc)
 	 * Ensure changes are carried directly to the memory being mapped,
 	 * do not allow copy-on-write mapping.
 	 */
-	if (!(desc->vm_flags & VM_SHARED)) {
+	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT)) {
 		mutex_unlock(&rdtgroup_mutex);
 		return -EINVAL;
 	}
diff --git a/fs/romfs/mmap-nommu.c b/fs/romfs/mmap-nommu.c
index 4b77c6dc4418..0271bd8bf676 100644
--- a/fs/romfs/mmap-nommu.c
+++ b/fs/romfs/mmap-nommu.c
@@ -63,7 +63,7 @@ static unsigned long romfs_get_unmapped_area(struct file *file,
  */
 static int romfs_mmap_prepare(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(desc->vm_flags) ? 0 : -ENOSYS;
+	return is_nommu_shared_vma_flags(desc->vma_flags) ? 0 : -ENOSYS;
 }

 static unsigned romfs_mmap_capabilities(struct file *file)
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7874cf745af3..fabea264324a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1974,14 +1974,14 @@ xfs_file_mmap_prepare(
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(desc->vm_flags, file_inode(file),
+	if (!daxdev_mapping_supported(desc->vma_flags, file_inode(file),
 				      target->bt_daxdev))
 		return -EOPNOTSUPP;

 	file_accessed(file);
 	desc->vm_ops = &xfs_file_vm_ops;
 	if (IS_DAX(inode))
-		desc->vm_flags |= VM_HUGEPAGE;
+		vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index c1e5e30e90a0..8a7161fc49e5 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -333,7 +333,8 @@ static int zonefs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * ordering between msync() and page cache writeback.
 	 */
 	if (zonefs_inode_is_seq(file_inode(file)) &&
-	    (desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
+	    vma_desc_test_flags(desc, VMA_SHARED_BIT) &&
+	    vma_desc_test_flags(desc, VMA_MAYWRITE_BIT))
 		return -EINVAL;

 	file_accessed(file);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d624f4d9df6..162c19fe478c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -65,11 +65,11 @@ size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
-static inline bool daxdev_mapping_supported(vm_flags_t vm_flags,
+static inline bool daxdev_mapping_supported(vma_flags_t flags,
 					    const struct inode *inode,
 					    struct dax_device *dax_dev)
 {
-	if (!(vm_flags & VM_SYNC))
+	if (!vma_flags_test(flags, VMA_SYNC_BIT))
 		return true;
 	if (!IS_DAX(inode))
 		return false;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 69d8b67fe8a9..32f48d5a28ce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -550,17 +550,18 @@ enum {
 /*
  * Physically remapped pages are special. Tell the
  * rest of the world about it:
- *   VM_IO tells people not to look at these pages
+ *   IO tells people not to look at these pages
  *	(accesses can have side effects).
- *   VM_PFNMAP tells the core MM that the base pages are just
+ *   PFNMAP tells the core MM that the base pages are just
  *	raw PFN mappings, and do not have a "struct page" associated
  *	with them.
- *   VM_DONTEXPAND
+ *   DONTEXPAND
  *      Disable vma merging and expanding with mremap().
- *   VM_DONTDUMP
+ *   DONTDUMP
  *      Omit vma from core dump, even when VM_IO turned off.
  */
-#define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
+#define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,	\
+				     VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)

 /* This mask prevents VMA from being scanned with khugepaged */
 #define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
@@ -1928,6 +1929,14 @@ static inline bool is_cow_mapping(vm_flags_t flags)
 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 }

+static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
+{
+	const vma_flags_t flags = desc->vma_flags;
+
+	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
+		!vma_flags_test(flags, VMA_SHARED_BIT);
+}
+
 #ifndef CONFIG_MMU
 static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 {
@@ -1941,6 +1950,11 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 	 */
 	return flags & (VM_MAYSHARE | VM_MAYOVERLAY);
 }
+
+static inline bool is_nommu_shared_vma_flags(vma_flags_t flags)
+{
+	return vma_flags_test(flags, VMA_MAYSHARE_BIT, VMA_MAYOVERLAY_BIT);
+}
 #endif

 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
diff --git a/kernel/relay.c b/kernel/relay.c
index e36f6b926f7f..1c8e88259df0 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -92,7 +92,7 @@ static int relay_mmap_prepare_buf(struct rchan_buf *buf,
 		return -EINVAL;

 	desc->vm_ops = &relay_file_mmap_ops;
-	desc->vm_flags |= VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT);
 	desc->private_data = buf;

 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index f2e9e0538874..6e5a6fc8e69e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2897,7 +2897,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }

-static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
+static int get_remap_pgoff(bool is_cow, unsigned long addr,
 		unsigned long end, unsigned long vm_start, unsigned long vm_end,
 		unsigned long pfn, pgoff_t *vm_pgoff_p)
 {
@@ -2907,7 +2907,7 @@ static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
 	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
 	 * See vm_normal_page() for details.
 	 */
-	if (is_cow_mapping(vm_flags)) {
+	if (is_cow) {
 		if (addr != vm_start || end != vm_end)
 			return -EINVAL;
 		*vm_pgoff_p = pfn;
@@ -2928,7 +2928,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;

-	VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
+	VM_WARN_ON_ONCE(!vma_test_all_flags_mask(vma, VMA_REMAP_FLAGS));

 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
@@ -3052,9 +3052,9 @@ void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
 	 * check it again on complete and will fail there if specified addr is
 	 * invalid.
 	 */
-	get_remap_pgoff(desc->vm_flags, desc->start, desc->end,
+	get_remap_pgoff(vma_desc_is_cow_mapping(desc), desc->start, desc->end,
 			desc->start, desc->end, pfn, &desc->pgoff);
-	desc->vm_flags |= VM_REMAP_FLAGS;
+	vma_desc_set_flags_mask(desc, VMA_REMAP_FLAGS);
 }

 static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long addr,
@@ -3063,13 +3063,12 @@ static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long
 	unsigned long end = addr + PAGE_ALIGN(size);
 	int err;

-	err = get_remap_pgoff(vma->vm_flags, addr, end,
-			      vma->vm_start, vma->vm_end,
-			      pfn, &vma->vm_pgoff);
+	err = get_remap_pgoff(is_cow_mapping(vma->vm_flags), addr, end,
+			      vma->vm_start, vma->vm_end, pfn, &vma->vm_pgoff);
 	if (err)
 		return err;

-	vm_flags_set(vma, VM_REMAP_FLAGS);
+	vma_set_flags_mask(vma, VMA_REMAP_FLAGS);
 	return 0;
 }

--
2.52.0

