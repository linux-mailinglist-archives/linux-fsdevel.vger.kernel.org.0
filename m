Return-Path: <linux-fsdevel+bounces-75706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDm5KmPZeWlI0AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 10:39:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 451E59EEDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A100305148A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF534A3D6;
	Wed, 28 Jan 2026 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FtKnUzRh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WC9CzKkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5B33E372;
	Wed, 28 Jan 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592904; cv=fail; b=fuTRryUh+l2n415HonN+ftoV7nR3+Lve4wvuGoTG7GAZ+9eVFznwgVzDLGZctSpqxH5zm2QLbApjynZDINqXR1teBLkdfptFBajCTl6uOOvuhRa7zIRWdRlvFKWBlXNLa8A3Zf7uTb/KCk4dtk74OifJysa0IHWmyr3dtCXOdyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592904; c=relaxed/simple;
	bh=fo8ElMStxz/1rtWcnjhH9vpLVNeNgDWlra6IEAND4AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NxLhzQiJfSYj6pPaQW4hUeO6kzLIAd5Gr5/0zFr7TiULs0QcM4l0iLaSYFqxrJBZqqDr/C4g6FyIkFiavmsxQ0bZ8LYfVXOH6Cu0kSbY52HdhifZwSMwjgXERguyHZSyQaS8tFh/MJYudSz5ALAoH6ayWn/mAEJkK8CptUZiwg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FtKnUzRh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WC9CzKkh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4BtD51337279;
	Wed, 28 Jan 2026 09:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YGHjczY3H5CEif50pc
	+MC7/vwrWwAUAaoZhCq6xg1Gg=; b=FtKnUzRhFMeURcvcrPcWVC4vKL0dcZ+HII
	xHtM046EQCXGHHTKQTUJq1aEO8YuiA3UBnfIiEo91lMObJOg8wkVph9xqODbjrXH
	t6W+eXeO50MoKH5+bNnlhhBUP7r+yEYm/nl+x/rTUfGz3T/kJ5fwRBnlB/usVV+9
	JENl43c57ZMMC3ytnFJ5noUsSQJrvalqyS5h2SB7vB6q8t4MkoihyUmqgFFUbKXc
	OR26AY5Uj18qz+2XOGo2sjfgWWcMcbIx1VuX0EDSMOkxdy7IlhreM2kQZSeKFMsT
	eNyzjItgFJAkhu84ieBoxKixO11OUQj3k8QrF8yqj2orTtBex2Tw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09hpnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 09:34:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S8Abxt019753;
	Wed, 28 Jan 2026 09:33:59 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhfyvq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 09:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twkzIcLBiaYgYHuGWJgf+I3pbOUqHbc4vtH5yqsaxecAk3tL90WsJXHg8dLNSK7pb0adhgPYuozyYuwcupM2/H9KPjiv5dwpBdZTg269OUEQZpZ4rETJa21WMYlBf/9LNSdoiyo+gIjDjBMTBcpExmA5FA388DjrXw3f1P+d6knQ2hzeC+H2Xvj9sVrj1Aauk5KcUGGoVuMlwN68iQIZVr80ROYXuS7S7dpQrhRltx91lMSC4lUQbEP+Fx7ec4v8n+7OZv5pwmJMd7l2iJUG6ieDr+fFJL9HB/MWRKCd9kuuqvVmMPvYa7y1w3a+qrXhoOf3Q1TDkUWsocgMeRO0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGHjczY3H5CEif50pc+MC7/vwrWwAUAaoZhCq6xg1Gg=;
 b=CPtZvLz/ucSGhkYi3GYE9kbIRlyxETLhumXOrYAWUTohnBWo9ESdk5v4DOhskD9nA47HoyoRZN7bGRi7ZeOEf61BW/3lOryizxztn1KdSGGYk+Wa6KfvGOiASqsLV2hjQUJRzuuodTCFPSbAZgRXWV7ydc2M1AHABPu53+KyNzIUo7ZAa4Fg9GRtJqXwh30L67DxFs/A/LtvoWsDTptfqaK6txm6s5DwicB6dcjJKV6bG6RIjrt/VXBjNJf+js2JiPmSY8hE+XLnKgcegVHZiGjQBi8Bw2dTz4Hb1uZ0RzPapZmeQwPrIOxBj7SMHgK+C8oH9VQPxgS/q+BtgKf2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGHjczY3H5CEif50pc+MC7/vwrWwAUAaoZhCq6xg1Gg=;
 b=WC9CzKkh0EOdH1BV0BNCFU7kW7TO5CrxXbMLKx8c1G+I2IEcP2uqmDSS47w/kLZtQnHwEq+DrGmvSRFKn0ZboWA0r+7TyQcaLc57MHPTAws47PV8TvrLSUSV5hv1bSIYuTHxyoucqqaOJLVK0K8ZNnQfghs/kCkj2LqdMs5Gkw8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 09:33:49 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 09:33:49 +0000
Date: Wed, 28 Jan 2026 09:33:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
Subject: Re: [PATCH v2 00/13] mm: add bitmap VMA flag helpers and convert all
 mmap_prepare to use them
Message-ID: <c7452c5f-e42f-4595-8680-bd1d5726be38@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <aXjDaN4pwEyyBy-I@yury>
 <5f764622-fd45-4c49-8ecb-7dc4d1fa48d6@lucifer.local>
 <aXkv7DSUbdY-RD5d@yury>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXkv7DSUbdY-RD5d@yury>
X-ClientProxiedBy: LO0P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::13) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BY5PR10MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 214672fe-b46d-4168-a64f-08de5e505795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L25IBWIsZSWv+3ZnqvAd9ay15cawbeqOk/s3kCFaXgD/qra1ruIQ0PeV3fAj?=
 =?us-ascii?Q?SjWE+q/I9txSOW2enfFujt6l3Aqpj+kpDnyrteWhsjhhGMAkd4yzREdnkNGW?=
 =?us-ascii?Q?MXS8X6/FdOtRk4hJPsnA0kuua1afa56nrCMIaTKvX3pyEWoUUlH8EUSUpgTd?=
 =?us-ascii?Q?U5dmT+fBPmPibb6+ypAfj7kMg0tsRJXCcTSlnIaAB5tu7lcybK8qEOAIeyDX?=
 =?us-ascii?Q?WEPr+S2/wKcqCDw7SFkGn+WNZix65eblWfB8FXDFEaXFWPuoWHp/bxAR+RCv?=
 =?us-ascii?Q?OOmVPfE+l50unKO4YA6Gf/odHTHpe94PXfW5qBNwIBvh1PzzvgO/YEa+lOkC?=
 =?us-ascii?Q?+k4Ax7S4Q3ia+t/6aG5LQ/61UNWtES+L3vZzjjb1LzUQjBIKbsSu0L46sZbv?=
 =?us-ascii?Q?rlG15QxWqryr2Ezd76lWL2xfmJe9KTVB9OcP95KjeRYNlPkef3MPw5WN2VZs?=
 =?us-ascii?Q?vSIvlndXgG9eq1KCpfdN60SeSOyFmEYvXvcdXSpKg8JLV7Y0Z2ltXPjWEQP/?=
 =?us-ascii?Q?VcxLt0UwVvW3gY7S8yNgtQLx3KLvQgJeUAe+PiMnv6lrqXfQ54SwZgAjhMfD?=
 =?us-ascii?Q?XpBYt+YZluMq7sbAejImMZWfXfNAz1yEOvhsnr8KOa08tuHJNNVuZ2yxh6YG?=
 =?us-ascii?Q?WbNJvHvB2tgqMir8jMHomYeOcS3E7Xh6lPolmHvZbp8HZUBH5T4yCZmrBXHt?=
 =?us-ascii?Q?QX2QuSNtlXVu7WyPEHCLg0oxYK+d+X8r3icKCrnGFRNaT+kNCRgz0cyK8m1d?=
 =?us-ascii?Q?eD/LdW7U4wrq7cGN129YXC9khxC7+FdZn+GwKQ61u87jZsEEkS+Qa5Ngyx8z?=
 =?us-ascii?Q?D4/ZAFJTSI0x3wHuXnmYbhMlvGctI+alx/iUEuceKVetc+b+7OKnOkfSxMBw?=
 =?us-ascii?Q?4pLaxY4G1BBJJ79ZQ3oYAS5AkfoOZb2xjdKYz0Ua+SvOQ1hPEf4CpoZJOO43?=
 =?us-ascii?Q?62NLGSXZJkYZk8WzUuIXGj5uxHm/Gxezlv8o92K2ebVK+nP8g4gn3OWT4cUN?=
 =?us-ascii?Q?No4bk0k+l8rJEQlE80SmqkKDgYP/hisatl1epGTmogXsTZ+/yZgdcO/v4QRW?=
 =?us-ascii?Q?qCNeIEVv4e5ojSQ+LTTTHMvexmQNOzJeZpjEaqNWZF1gNAJHgOQJWWC9VAFR?=
 =?us-ascii?Q?wzEPQKAKdr0OQv7D6yjW4Vn7ULIxJ3LDcDvhd/Th0kKII9qVLZ3bMJH3f2Y/?=
 =?us-ascii?Q?Toz88GZGy7Ai7pAiCipUHbsQhKeIFhakT3R9G3MKcbwXgnlJw+lcZuMALHUQ?=
 =?us-ascii?Q?Uq32aCDdKtZ+o+FSUWAAJ59agUnwDI5OKI64Cd5zZG4wAcS3vnNNnwbxebFl?=
 =?us-ascii?Q?baC6CGYDShw6CD8pq6uXpaGJj7npZMMRPFy3CgyHAO/kBqgVyQKTyPLBj0LH?=
 =?us-ascii?Q?zDgxDNi276lChY1cTvuRhtzkjl0DH1knJ4igv3SKm0O5p4dTR71vhtvU0i+t?=
 =?us-ascii?Q?hb6PzshtRjwOaEdZhN4kYZLoKKMFzWXoY+DS3Oa819ru8vqevifdXy2jOo7P?=
 =?us-ascii?Q?QZdI/NHszEBEkPyFBfhGJY+uivxL4uv+6JX0mvGEmfJjnkZ1DfOdDWz9Nm9o?=
 =?us-ascii?Q?G5RLukNUiIoTMUQIVuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00y1c5fjRL0s7pYvk8P8bsIOeVEql0Z5KJgWRdDAUS9SslXkc46uxfNUCGqY?=
 =?us-ascii?Q?1gOUaGrF6Qtxfb7My3jMyBM4DVfskiyb7si1g9hFUK/hwEYqH8GlTMS2DXzw?=
 =?us-ascii?Q?mTvXzgn9wJR49hjAKvDhsjlsaKe3JdyE9vJUw4MfHnmUSFYjJmmXniUbNdEi?=
 =?us-ascii?Q?y2y4r+P1cwPdAzDuZIF+kQD3dq4J/pHJq48LhtnIxvDUoluQJlZUDrxwW7KB?=
 =?us-ascii?Q?iSrB/arbmdsbl8HbINPr8LhW7CFEY7DG5V/191i6FxIYfIg9eLgtRPYaXFDI?=
 =?us-ascii?Q?ye98IkVIQoc1aT/tIfVHK4x5TqlZ62ucOU/Qn5mENp+xN0ICpHfD2J1L2vrn?=
 =?us-ascii?Q?Fe2KflNI6F5IWYjjttQXkGLc72VRLF3YQwBKtoo/HSEtSazLAHwXKKO5MyWZ?=
 =?us-ascii?Q?sWyaumyVP8cdEKjb9Ia7zDFSnOITfZFXaFRhDyP9gUsUlXVisQvCx/efPx5L?=
 =?us-ascii?Q?AktPPHf7VdREVH1fzR+PLpO6izX7CyuCDb5lsqoRw89T2UQ9HTcuH1DDT2jX?=
 =?us-ascii?Q?twqmEfdYnaKY2vmHsoUBprWmURo5Cjrf1IlOFlFdt0cZjax6uRAZ2EtUFjXI?=
 =?us-ascii?Q?UtwgUHPjLuvdmvBkx5aD26OS4VB3La6LWLIeelRq09LsoKTY8kQJ2kwO7VOZ?=
 =?us-ascii?Q?s2xbg4ioeiqVr0ZMPMlJOg6/dy/Zawx8C6RQf27/QlTYmtVmzz23YTXwglz6?=
 =?us-ascii?Q?u32xRTj3d6mqvssLNfkGPvIeChdZRr3TzPKyFkiLLTfiQn84TFMyA6orKAmx?=
 =?us-ascii?Q?7HRBu7X4Wz1azepc51aiLC2/cyWJ982vuY7XWYgEJS5lPqLOHX4UoC21cTtH?=
 =?us-ascii?Q?ALVIr1Dv5OXR5F+GUulNwUCWB5mcjE3NaDA+w/2gjK22k9cEZOa29PyGCxHi?=
 =?us-ascii?Q?uWAHDwbEdSV4Q89pJz+AFpFWZgKUtVijvxY//pOA2ulihNRhUKOuuf4TJuXL?=
 =?us-ascii?Q?gmKQd5sYcZc/eDuTSSJkts8/+u7pjdtuT8I9/JzldVYwmttkOaiGAgh1IhTO?=
 =?us-ascii?Q?/U4ul05jFWb/NVrLM1TmnZeRAKKF+4NYzsYSBKWM34f98jB63eyE9GiQnKxr?=
 =?us-ascii?Q?AVFGShfnATGrE1jaGx59zAqqmsIt7apA8vqxaJhPdUmzFAgkFIIJhW2n7wfE?=
 =?us-ascii?Q?dhu2qqj3W/yeHN7Iqu+zwOaDVwbg2tlEV3FPhcUe5HNwvtrtE+6AFJiWNN6C?=
 =?us-ascii?Q?+GOhITo8Z+DteZWCXL1TUbB/KZjXHS4w5gpttyvxu+QP/naQ7baAEhOZQAbZ?=
 =?us-ascii?Q?bQRNnYBvp2EONQleyCD1y/ECDHwMCbk1t3sjY6McxLiyi4uwJzatxp0mV/7g?=
 =?us-ascii?Q?w6P8m/Hf65rGMrUkb0KPQ7lq9MU4a6tHWHOhG4sDe/MA3bWGdb4qruwEvKfv?=
 =?us-ascii?Q?9zNrr1TPCGnlB9JHWHk66mxYRM2ofEkwmHjqQAJCj//nXrh/q83u3bj6Q+i3?=
 =?us-ascii?Q?fnLFBTUt0jB6PK9NsN9LQTkoHKM1r9Az4zyJzUHPduUmh+zodQ8DYCJUMj6W?=
 =?us-ascii?Q?UIDpaNfeRRbVavx1LKxVZ3Y+2SmE70zA5C9WIZZtTPHfJI76njnOnk86vW0K?=
 =?us-ascii?Q?lI2O6jVQVhydpKbr756Ujt80s5YttYVZwLQxvcYwo+hY2q1kHv488wE/WPR3?=
 =?us-ascii?Q?nh1wNx/IL2NNnPwDsF1N41/ySwhHE8zUu4sFRCuAYtWllMVv+MCqYNs5YFWQ?=
 =?us-ascii?Q?GmX1y/rR07EoFuoZ8caBtkFIu6XtKgd8xyHBroJ+jMNsecFcstDXM+10Hq3h?=
 =?us-ascii?Q?/moosZQQ68lQGV3cuOmr6D6q2f4ZR9U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KFA2258vIh1pAe7XoB8GmVcUSyswXNQlTu2ZAWdCe9bHUcIE1vsnYWhjwDUlc9gpvUPUIdPI2vN5vdTZwF6gluQJXjBfUCo2m6db5zuFxdK7OR1ECmYzFoOruy41BcXx157b8Y6Pe7eBahe7eEpDQ3c1t49g7KmMDzDUK5cLm6kS1rnHF9LAY/gLIo8qs6R1bxs+7hhZkkWeDbkU8z/n4j6uechej7Z7EVO4a048+IOW192yQd2nI8onPrKTsNScmsvQ3sCAvQGLffepG19uZKBEQZyy9VL1KYAUvT5FgziPb3E50numQMQ9OOQLPFP5JwltOFqKwxJ5HBJTUgu/1cXxP2P/WDlFhrBalW2aSFxNSdIAxmt5n/IrcT4erf+a66oGP/yykf9Gq09e6BfsuJ7cWFJh293rm3Y4fN9VgiaNGT6Q1haeUOQVbaaPOCHTF5qaaDVb2qDokZHOuCeis4IrOXavJ7O8UMxnK5f4v5sdS1OHha6KgEj//IobWszymqlJmKkRT8D+w4yu7Je7ojmKPVEplLa63YBdEDo6M3nvmIDMMLHT0pNQI5w0T/qMBr3uYjxQoW9cTgo6YH1Xef3anBjpczgWSQlzyNeBeiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214672fe-b46d-4168-a64f-08de5e505795
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 09:33:49.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Za9wKJvEWm+K8X0qobDuyA4K8HHfDrVfIz/fiqyMOO1EOWfvjn6A08VC2xOsT9/BDedD5wVzEmxMqXTRONsD4fO+iiT2U/cUayE7PR+52Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280077
X-Proofpoint-ORIG-GUID: UXOB_BB_oE_fU6-tgljYg8ZDKO5ERHoc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA3NyBTYWx0ZWRfX/PTDi2hS1sda
 XDJ4FeVYLPvyTR7E9YTFLt7TDT9zHyfxHB1+55eQIrMuzIz2sAW5e8ZYNXcVtkEK7f9cQfJ5yhh
 MvoptgQHHZ9fx9Nw1ZD/SVcW597FwJ9PvBoBY28xeJrzTfUJviiLMidyo2EFkQ5Xle6cSVmRqOj
 KMRusb9YHtvOsQ19gbSR/7o59hgiml2ZTJsYZ4xaclhG/Cf8tOxgqmvtUjRg/9C5DdC8MYnQzI3
 lK5fmrTSp0r5sk6EGf2c7tiH35vS8s1sgfXCwWVb1seMhUPUebfl9bha0Jzbevq50gBGYbXoOlN
 0Ew42v2XuRcrj10YXPK585D3gr1mr3qannOA8urwlA9RZD0V0u2tWWgHFxkO7fdfuv8wFb/VNMy
 AKMsgxiT30AWqF0dHXdnGRbhMF0lhYOY8PXPntD8B7XhYGvQ4hQ1KPCx1KedpP7Ox/BiR9Oa2I9
 1kbJDooBmvGLEizeigWombfuO6DCMttDrIaXANaA=
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=6979d808 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=b4LDLZbEAAAA:8 a=kr0W4OSOdv0uQwKPaNgA:9 a=CjuIK1q_8ugA:10 a=4QWRX4Vq8IEA:10
 a=hslRQ5L8Sz4A:10 a=20T61YgZp4ItGotXEy2O:22 cc=ntf awl=host:12103
X-Proofpoint-GUID: UXOB_BB_oE_fU6-tgljYg8ZDKO5ERHoc
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,open-std.org:url];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75706-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[94];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 451E59EEDD
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:36:44PM -0500, Yury Norov wrote:
> On Tue, Jan 27, 2026 at 02:40:03PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Jan 27, 2026 at 08:53:44AM -0500, Yury Norov wrote:
> > > On Thu, Jan 22, 2026 at 04:06:09PM +0000, Lorenzo Stoakes wrote:
>
> ...
>
> > > Even if you expect adding more flags, u128 would double your capacity,
> > > and people will still be able to use language-supported operation on
> > > the bits in flag. Which looks simpler to me...
> >
> > u128 isn't supported on all architectures, VMA flags have to have absolutely
>
> What about big integers?
>
>         typedef unsigned _BitInt(VMA_FLAGS_COUNT) vma_flags_t

There is no use of _BitInt anywhere in the kernel. That seems to be a
C23-only feature with limited compiler support that we simply couldn't use
yet.

https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2025/p3639r0.html tells
me that it's supported in clang 16+ and gcc 14+.

We cannot put such a restriction on compilers in the kernel, obviously.

>
> > We want to be able to arbitrarily extend this as we please in the future. So
> > using u64 wouldn't buy us _anything_ except getting the 32-bit kernels in line.
>
> So enabling 32-bit arches is a big deal, even if it's a temporary
> solution. Again, how many flags in your opinion are blocked because of
> 32-bit integer limitation? How soon 64-bit capacity will get fully
> used?

In my opinion? I'm not sure where my opinion comes into this? There are 43 VMA
flags and 32-bits available in 32-bit kernels.

As I said to you before Yury, when adding new flags you have to add a whole
load of mess of #ifdef CONFIG_64BIT ... #endif etc. around things that have
nothing to do with 64-bit vs 32-bit architecture as a result.

It's a mess, we've run out.

Also something that might not have occurred to you - there is a chilling
effect of limited VMA flag availability - the bar to adding flags is
higher, and features that might have used VMA flags but need general kernel
support (incl. 32-bit) have to find other ways to store state like this.

>
> > Using an integral value doesn't give us any kind of type safety, nor does it
> > give us as easy a means to track what users are doing with flags - both
> > additional benefits of this change.
>
> I tried the below, and it works OK for me with i386:
>
> $ cat bi.c
> #include <stdio.h>
> #include <limits.h>
>
> int main() {
>     unsigned _BitInt(128) a = (_BitInt(128))1 << 65;
>     unsigned _BitInt(128) b = (_BitInt(128))1 << 66;
>
>     printf("a | b == %llx\n", (unsigned long long)((a | b)>>64));
>     printf("BITINT_MAXWIDTH ==  0x%x\n", BITINT_MAXWIDTH);
>
>     return 0;
> }
>
> $ clang -m32 -std=c2x bi.c
> $ ./a.out
> a | b == 6
> BITINT_MAXWIDTH == 0x800000

I'm not sure why you're replying to my points about type safety,
traceability with this program but OK?

I mean thanks for that, I wasn't aware of the c23 standard (proposal?)
_BitInt(). It's useful to know that.

We can't use it right now, but it's good to know for the future.

>
> I didn't make GCC building it, at least out of the box. So the above
> question about 64-bit capacity has a practical meaning. If we've got a
> few years to let GCC fully support big integers as clang does, we don't
> have to wish anything else.

As long as you assume that all architectures will be supported, all
compilers used by users to build the kernel will support it, and Linus will
be fine with us using this.

That could be years, that could be never.

Also - and here's a really important point - the underlying implementation
_doesn't matter_.

Right now it's bitmaps.

By abstracting the VMA flags into an opaque type and providing helper
functions we also enable the ability to _change the implementation_.

So if this time comes, we can simply switch everything over. Job done.

Your suggested 'do nothing and hope' approach achieves none of this.

>
> I'd like to put it right. I maintain bitmaps, and I like it widely
> adopted. But when it comes to flags, being able to use plain logic
> operations looks so important to me so I'd like to make sure that
> switching to bitmaps is the only working option.

I'm not sure you're making a technical argument here?

From the point of view of mm, the ability to arbitrarily manipulate VMA
flags is a bug not a feature. The other part of this series is to make
changes to the f_op->mmap_prepare feature, which was explicitly implemented
in order to avoid such arbitrarily behaviour from drivers.

It's actually hugely valueable to make this change in such a way as we can
trace, with type safety, VMA flag usage throughout the kernel, and know
that for instance - on mmap setup - we don't need to worry about VMA
stabilisation - which feeds into other work re: killable VMA locks.

In summary, this series represents a workable and sensible means of
addressing all of these issues in one fell swoop, similar to the means
through which mm flags were extended across both 32-bit and 64-bit kernels.

We can in future choose to use _BitInt(), u128, or whatever we please
underneath, and which makes sense to use should conditions change and we
choose to do so for good technical reasons.

Any argument on the basis of 'allow the flags to continue to be manipulated
as they are' is I think mistaken.

Keep in mind that bitmap VMA flags are _already_ a merged feature in the
kernel, and this series only works to add sensible helper functions to
manipulate these flags and moves mmap_prepare to using them exclusively.

If we find cases where somehow the compiler does the wrong thing, we
already have functions in mm_types.h that allow us to address the first
system-word bits of the underlying type and can restrict core flags to
being at system word count or less.

I hope that won't ever be necessary, but we have means of adressing that
should any issue arise like that.

Thanks, Lorenzo

