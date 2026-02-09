Return-Path: <linux-fsdevel+bounces-76745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKdqK5M1immhIQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:29:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1A114181
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B9ED302834B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E4F423A94;
	Mon,  9 Feb 2026 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P8xcXh6D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BLMVnivA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27938A73F;
	Mon,  9 Feb 2026 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665348; cv=fail; b=Pj9iVQs1pC++oXX4/Hkp8IX/n2pyMadbwH1LcTj5NlU9JS5/XgT1d5nWIScJUWf8lue70WnMkQZoApo91M/RlCKW0zmr9xvgzb4pOdFMJvFwtel4p3KPd1u+3mKK2VTdjy7tJhHv6lD07NuZv/vFECzsu51mhTswa1y26nkyuv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665348; c=relaxed/simple;
	bh=OsFdMVzizFrbKKLcRhlU0HJzOQ25qyIqtj5ROmbzAs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFCohY3gnS8ZBB1YZE1wN7a5GVuvkyQ8d9R7LozneLyizRK/yLd5ptV72Jg8j5Pl8rCx5wrrYOnPNKpdRwr3u6KKIN7j3qP73NhuADYtDMkAxmeZtKPq3VZrPIQaHcEqFOMG/p4eXjsbuqz90l60YveSKvI+F65xn14yagZh5PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P8xcXh6D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BLMVnivA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECXda1228995;
	Mon, 9 Feb 2026 19:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=k895XRGI3mWamm9jti
	TuXb6zSnBRag7IPrPqPpJwD6I=; b=P8xcXh6DrPk80juWisyMJUUOK6t7ubyA1F
	IS87SubaTesowGLnFgg2InKtA4VorsRIfBSdytDDL6/6F78NbQQxH5fh/tQ43OcY
	LA9MC00Y9gfr7QUc9YdXqjv+mK2Ubd3NtS4YJ+wtcxMrjZ4QmA6YAZi3X778rlG7
	Rhf7y/z6J7Ot2qVzbgR2uN5KfulvWKKCegmH0R32P81UevUt0H9+O7gH9Q0mC2af
	jPDODxpKDzTMHPLZEnMHG0rM+vHPjG4WObx5QIEnmeNRGAhXYgIQqyjzXMIiVsFK
	Bv2Kc2MQ7beSd0bCBxFFOhGg/rLKT0renVpO7lmKjpWbDpSm16sg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xes2mnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:28:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619Heq8k035303;
	Mon, 9 Feb 2026 19:28:05 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu9fpk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:28:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bty547FpMXNnM7ubsZPuP8kEBWkyxu/QHqMynVL45O39WsUkpKrY3dYi6pVqQdu2lYCI7yTYYGI5qP5YjYxnxun/ixQzNjAUNAEarW0g0OESZpzBMJCJwBrXS/awryNG+eOvx182HTW+qONitPANaz5NxdjqP3qhtxQRA26Ul/CuShV+DaXKQX4Acyoa+K/i+U2P/X0c4e6UwQ2xsMqXz7RviVIlcF8qRMQuOzE971A4bouCxAmkWyzfNdftCNdrdkQ6tRL7c6gTZqEUMWrbjQfMMTdFIEJdCKu8AWZ+CvLoiouCFhaIPUH5tivapEF07a+8npvctpSn9q1sY6po5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k895XRGI3mWamm9jtiTuXb6zSnBRag7IPrPqPpJwD6I=;
 b=W9GspSXkGW+2nYV73SqvQ4oVrKwhbdS7LrJt4LJhGxm3AkvG9t2Xu8j0lvgMYdYkwACUixHX7KIPEEwl1NI1+JYWo6V8P12f6JpaC8gsBNNKTg5P3wsn5yfeT4P4JhPBjieXcMSrHAPuPZNqVUMzOx9RUCpE6qYGNX/OugWDjb5KIm9StpwQojDtQgGOB/qDiSUYndsnSPzHW4KEEDfRk5eis4Gi6DXcmC4GgyrP1D6JTlYVnvR60bxzI5BgfKXm0oFNIymv0JlSHh+N+gOUT/EUwj9lLnIMrTaYiWHwGCLArjYoZQMnKDv9iCFLFk4F4HQsQrU6o76seMVSxZJE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k895XRGI3mWamm9jtiTuXb6zSnBRag7IPrPqPpJwD6I=;
 b=BLMVnivASSuwe+7xK1s/F5g1spMuU+v70Jm8lPUzGZhP3xyBeka3m4H1TZ9Vio3s+eS9N0xxIDsVmfXd0iRI7GDCNQ3LNKzjN5izcRyfI75Fdj8FKSUH2DWDMXAC27f5+0/2IUnMPcPpS8rjasroC/iTNQB1+czVrkEFrtoIaLE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 19:27:58 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:27:58 +0000
Date: Mon, 9 Feb 2026 19:27:46 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Pedro Falcato <pfalcato@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
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
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
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
Subject: Re: [PATCH v2 09/13] mm: update all remaining mmap_prepare users to
 use vma_flags_t
Message-ID: <o5efi5bwwqapscipxhmahknjurb7rfx6vitddc7c67hgbocr2k@ndkfnucwv4k2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pedro Falcato <pfalcato@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	devel@lists.orangefs.org, linux-xfs@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <fb1f55323799f09fe6a36865b31550c9ec67c225.1769097829.git.lorenzo.stoakes@oracle.com>
 <hmc2or77xnhrdlncfzjsljljwljnp6zztqsvmgxspfilmzkyty@czxpjpdm66ov>
 <20260206113153.c443545459474cdef6dfd7ea@linux-foundation.org>
 <d55a0ba8-46a3-49d4-ba76-aa9658e1e8be@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d55a0ba8-46a3-49d4-ba76-aa9658e1e8be@lucifer.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 175b5d70-e64a-47fd-6798-08de681154e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uoJ+uNfXALKh4cUciPEF62LzRrFu50p0ZQe+BjxVhVt3qOMHFdjsMZjMlCr2?=
 =?us-ascii?Q?0az8wdLYZXfhaM4nNrG02OCLqbbH9P3XtZBJOyR5Xc4RUZSoBUAu8bs9d6WV?=
 =?us-ascii?Q?7qHdEu3fzFUnfHV0+ncPvRZl0rOgsk3IbYmDZGr67HQsumAMwU+5q6UO2E6j?=
 =?us-ascii?Q?5z/Sarw9LUq6Ax81Y0Y7UOhPqNHUuezKmuxkHGU9wQPv+CkyNSUeaqEesHGX?=
 =?us-ascii?Q?inA4ZZ66tw7pps1lJW00iuoBnQvh8l35Ommr11mUs75dY0ZXKa5nM5tGkps4?=
 =?us-ascii?Q?AP9/NUti9rYXDWBNe3PT7x3kry/nJkoFD4Clb87sJuZCDXdWObJ+PB5SZCOA?=
 =?us-ascii?Q?/MhQHTpit/ScG7QF4e2Bb+20hQ4JsDwUMBqkCe6jj1mQ/Gfc7wD+4LvTrX74?=
 =?us-ascii?Q?GMwzXF4niFRudesS+Wkkidre1ggZDHQRvtTJpljhG+S8KMJQe9lsLQHHglyl?=
 =?us-ascii?Q?i3zHJfuWnODYamPhApkrYM7nDd5JD0DzA80V/7g/QWtyzTshMiDEJWwtY0F8?=
 =?us-ascii?Q?H8skqaMJ4qsG2khEdttItf9ams0h2mYoFCSJmplaX5P3XlsmaBJjqpsUbSKZ?=
 =?us-ascii?Q?H719tdeCPm2BJZdfIq97FexELTv022mZYLuEDwWgqRI0YQmh53HCRp91xjuc?=
 =?us-ascii?Q?KWN42UCAhJeVB5gYfK6fm1O6uwTsDmZXZ/gAeobIrG9mFRV2UTozm7AkkZCo?=
 =?us-ascii?Q?+CG/uobMSHN7nfQon+9+xFdLlIzNy3Bn2YGrkkM9Vh0uJOMEjZj325DxV6Nh?=
 =?us-ascii?Q?XNxJOf4RJM2G8f/xGtnG8OJVN+BvgTUV/LbzN29y+q6XDFzqtRRXzAhYxon/?=
 =?us-ascii?Q?cnJbdJA9qtVzoHm1pIi4/NT5BUkoH3VmF7zEeQIl5dhrfKjSSIJqPqEHurZV?=
 =?us-ascii?Q?auYj86MaeZJmusn4F5ZO+yvq/6rzi5bjg+vziGctQG8Zvh3Y2fW2XMCQDNVl?=
 =?us-ascii?Q?ipnIootWbguV0PxZZ8AfaeUBEmHUdfNX1axQXUD7jEGsA6p0H4I1xxs4rCyR?=
 =?us-ascii?Q?f6SoMIoC+Uqt0bd5/IwCD4+bLNvxDVcaNlmHaHbgq3Awom3ckbdaR+i7XX9L?=
 =?us-ascii?Q?rbLOyNIYiExq3Mhvjl+EeXac6s1GL0NNGvy79lhY89Wcfdg+rIskX2/OY0Wr?=
 =?us-ascii?Q?rPuBoJgXn8IyXm3H1Af2sQZar1UiZB6jDbextHABfhMoVkIZIEFWctHJgf26?=
 =?us-ascii?Q?toyOUNmgJgspSxdrH5RXPeoFtdZofNPNbdv0kvljYGF2fMHBLXfRxYs3OyQ7?=
 =?us-ascii?Q?7HEpEODdqfh0Wx4OPKNawwLeUn75WqDaXNfLiGZ+qykiVG5rLx51eqNLfQje?=
 =?us-ascii?Q?6XaQvRFs34DrsCevjnqfZr2FM1hoytsl63JOqt6nlqJl3g1zTYS3SKvh5SQp?=
 =?us-ascii?Q?JEWzr33IHIWdmQwX87oMUTxL4Fr207ms1qKS6Yy6HEzYeaIZYRnZKc1v9zQE?=
 =?us-ascii?Q?TyFlOFEGWa8Bahkq9y4KznBBylOpKRODbH6W0j62VrfxK+wZKlb+rTQeq6Rv?=
 =?us-ascii?Q?qZ4/hkoXG9UzPHNMAaylF5nfVLuG2BfWEfU5VoWl36nt9bAZitNUHwpW6Oz8?=
 =?us-ascii?Q?tCwb4HsCaYUKMTpW+zE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SrLQpeV7yYnlOudAPPlJpsgHDFpyP3KkUmy6I9JEjfVGuMxGZ93whvnK7TSP?=
 =?us-ascii?Q?2LmP2orh5Ly9FsnditKoXZn7tjar47MQ+JySHJNFzyB1cIypCPUf1VfLgGXM?=
 =?us-ascii?Q?ULb8wNdkHGoe3GR1y8t7/LVRQZHGJ//8MIujrM29j4tRkqOSiws7bWrHXgxz?=
 =?us-ascii?Q?dNNozGSLYY3Is9As81tTEp9Pp1gqgT3lCx1OP0CIBx20/KRdVjiX02gIyFRI?=
 =?us-ascii?Q?qNnAXdIfpcc3MN/AmYrteH4PptmLaa08cuvHWousywNwGHQV9y5f5oqdsKZP?=
 =?us-ascii?Q?4ORqsRpe7cvVX2Ub0i5qlFDmdrDvI5jKz+1tL1Uy22KPTtOAOv/3FYmq7/4C?=
 =?us-ascii?Q?MGn7Xz5scAzUEurCd2LCCNZ2tXuJmbAqq6NCNB9YOjzniovUjAGI4zIyRVW+?=
 =?us-ascii?Q?pOavZ42kuTO9ty7Qb4wF8pQ16RU42Jw71094lGqOSWAeDQadCJts9AABmx2h?=
 =?us-ascii?Q?ZhBQBgnl+08qO+xwdl+SVbM73lOTTrwyjXqmkMGVyqp5f+cGt8EMBe+sQmnd?=
 =?us-ascii?Q?qaV8oEeYxNLPFU/0RKN1vEzdf27joWNUZSK1snsB6fi8PJMPTGIMGYRo8/9N?=
 =?us-ascii?Q?DYMrParDlGbTRY/W1OSECTZOpKZepo9v0LemnnPQ0xrcM7tToN/L9jzPFCn2?=
 =?us-ascii?Q?ye5RFtnEFskpHSVfCw5V8wBDMjv7cdFFvdL8kjhi3nAi94WQ0NrsjSESSBwR?=
 =?us-ascii?Q?AOmFmmSiAplZYDBbs8GFJ46EiZn8MLIefbFh88vioq7kWanA3B0SDuDa98ge?=
 =?us-ascii?Q?kMclW5J3K3FF8GtmZ3hEGq5gc21KUK1iYzCF9OV8WxBGFBBIKYJBSucMKkjb?=
 =?us-ascii?Q?p+jr1pzE8uRhCQaiYq/C8tc+moRJgYopv/Pc0B50RvnCTV/XcaE+qLz7tuaT?=
 =?us-ascii?Q?uB9z92n7Nfve8ZBG1gF4MXaxCTh31HBK/EY0R9pIf3OVuF4ezP376rGMk5hc?=
 =?us-ascii?Q?bjdKhZalP1soIVLyjHEHwxDdXxkY9IsSj8BGTvRhO6NJG3H3MYSyGvtaDDgo?=
 =?us-ascii?Q?o5dE4b/G0USFzGOngEm3BINgMkeRdP/EcGHOkgrQQPRJQuuHRUVpXRej6UT4?=
 =?us-ascii?Q?2rQPArMzHPL+0iuCpNY/iVEM+hY8/09ir6zYbWp1EhGT8rRKOhXuyOxZF0r4?=
 =?us-ascii?Q?Hz3/TPYHEC5HFF3XqnkFJhGt2oAsevAJf44fpSjsSTTeH/eGVVF0tickLlBQ?=
 =?us-ascii?Q?iGxv1O1nGCntu0tpGP1SVHjfwZy1S37Qa6CEckQs+nkITSHCuryWx48RdNzN?=
 =?us-ascii?Q?XPACRXEWehl2T/tDdFzAmXNqzCyFlfggOYgaglIQYsoQP+voGJbD8JVPriMo?=
 =?us-ascii?Q?MHqauqsXvbo9PlES2WDidZIJLiaMA07LXX10ub9914MeRnDGXlQXQMFE6ACj?=
 =?us-ascii?Q?Oh+bQ2oVlKXXDhKWqkNEMWRjBzsU/LRySFP84uC7v+w2/bmmB/Xk6n92XWjx?=
 =?us-ascii?Q?jbr7KVmk3/wjDtKqPpSI275avNyGUNhp+qWQ+ICsz7czgA7WASk+QqKtjLgq?=
 =?us-ascii?Q?+kNztbpfpnGVMPmpalnAi20EOpkUjcqDTRsPcNTfNinjjIxq0CY4X8hzcUfh?=
 =?us-ascii?Q?ozvvh8VAEAP+V5XkdzBc3zKjIbsZbdLqbKyVv8FYsKJF3m3P+z5Hzi8VTqG1?=
 =?us-ascii?Q?Zu90a0RKrpJXRXByW40c6ilcL8WmsGXfgC5qNct6/ohM5OlyCb+q8ntO2kNA?=
 =?us-ascii?Q?r9rftx5g79ijAH3LoYCOrd3mqeotE0ZxJkdATjD35arxDcy1Lm+c/DEy7P3P?=
 =?us-ascii?Q?XYyBsSHbjw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2knU29KZItDq+clC8Eqtm+xWhC4cKVkDffmBkYGo4REmpG4qrrqF5yJF2QfzDWFcM9X8pVVPJIr7o3lURHXhQID5i3m7mdeYF5AtCF/tug/wQ8lY01AUPWzpCd1k26pm6/2y7TLlN/MjoY4/Ha1+RPH4lfaXG6gJmayVNejZZrrupIhH7NQveJrvtLa4cFvGOzSVrY9IqqxtdYywy3HNjqbb4i8UdpEcp+dd+Pf9Y/5UpZ7arZNPOqlmeqhkPW05xjZVmY+K/qSVd7r0tJYIIiNZY+cv76K+ClgbE2WwB+dADEjpJUgiNPKOTUp1eu0HkEk+IQhkUPU+7bHX2VwTWhX/mZo/BQyYrRWqTixrwE2spTPmEvL6VgaWG1DhFlVTDjui3dsEmjcuQtUTdLoYlOiEx94ElUqYra+b2Emv7USUTGXrRXytvCxuAm4lvhIHmpyxISLEUPfT38eUKMLWBI97G0q89GZv6pOgbYiMv7L3N1SGa60PsjHEX0OSpbhUX4Jkn/3TmSpE+FHJ5/H29MSljbmNoEzVwT3SZCA6qFj+2oRAj6PPraomvQYtTzs41X18lCFJYKVTcq3MXFbAqtoTT9XP1QhOlIoD93FI9o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175b5d70-e64a-47fd-6798-08de681154e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:27:58.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXAgHTJPi2N6lmDPDMHQ9KxQfZa9A+i40h74ktdTLS3f/QplMHLSHSVAIxcATs2Rae/g+WwZ0WMl51NuoBDvLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090164
X-Authority-Analysis: v=2.4 cv=KaTfcAYD c=1 sm=1 tr=0 ts=698a3546 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=5v1go5wQdWjlzf3N9Q4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5eTbkAcIxmLS-T4lFHlmBgbDSzxLcidb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2NCBTYWx0ZWRfX7xoReqbepsWu
 1LyzHy0RHvtHPdq6Tme+8Wy29p9fo1M66HFe++j+PBPKO5ESjxTai0eh/3//ONWYJFG3QBsEryK
 um70IBZpNerF3OfTsjJdzUU1binrmqjzcpKY1MZL0tZZ/BlnmLlMsGPHHfcVvt5tfs1Mm9V38QA
 KvSmmRdPnhiquok3ZtRbAy7TnLlHPP2yxW15QoqCegKwVfcqo3nObAzC4EUFJKUsmOAV8nyR2F6
 5zb6xPmw9mTyrkDkTlaDkHdzVtMXT9YQ5zG5ECmPKTXu1C/3FsJD1F5wQ8MB5tDr+EVMxCI0bRJ
 nEs5dLH7XSox4XU8i9DlYJzCOAR7yIocN/DJe3S9U7teGTeuvkskmzubwbIYjeHnzqg5sj7t4P/
 ouLaC9sLwjg0nWw4dyy0OKPni8s2M4vzQjL5KSSRVm3h/sci15EaE1vgVbG2k1KyupFL/3k1JtR
 xQZoG9cZno3GxaUVT/w==
X-Proofpoint-ORIG-GUID: 5eTbkAcIxmLS-T4lFHlmBgbDSzxLcidb
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76745-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,suse.de,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2CF1A114181
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260206 20:01]:
> On Fri, Feb 06, 2026 at 11:31:53AM -0800, Andrew Morton wrote:
> > On Fri, 6 Feb 2026 17:46:36 +0000 Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > > > -#define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
> > > > +#define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,	\
> > > > +				     VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)
> > >
> > > as a sidenote, these flags are no longer constant expressions and thus
> > >
> > > static vma_flags_t flags = VMA_REMAP_FLAGS;
> 
> I mean this would be a code smell anyway :) but point taken.
> 
> > >
> > > can't compile.
> >
> > Yup, that isn't nice.  An all-caps thing with no () is a compile-time
> > constant.
> 
> There is precedence for this, e.g. TASK_SIZE_MAX and other arch defines like
> that:
> 
>  error: initializer element is not a compile-time constant
>  3309 | static unsigned long task_max = TASK_SIZE_MAX;
>       |                                 ^~~~~~~~~~~~~
> 
> And this will almost certainly (and certainly in everything I tested) become a
> compile-time constant via the optimiser so to all intents and purposes it _is_
> essentially compile-time.
> 
> But the point of doing it this way is to maintain, as much as possible,
> one-to-one translation between the previous approach and the new with as little
> noise/friction as possible.
> 
> Making this a function makes things really horrible honestly.
> 
> Because vma_remap_flags() suddenly because a vague thing - I'd assume this was a
> function doing something. So now do we call it get_vma_remap_flags()? Suddenly
> something nice-ish like:
> 
> 	if (vma_flags_test(flags, VMA_REMAP_FLAGS)) {
> 		...
> 	}
> 
> Become:
> 
> 	if (vma_flags_test(flags, get_vma_remap_flags())) {
> 		...
> 	}
> 
> And now it's SUPER ambiguous as to what you're doing there. I'd assume right
> away that get_vma_remap_flags() was going off and doing something or referencing
> a static variable or something.
> 
> Given the compile will treat the former _exactly_ as if it were a compile-time
> constant it's just adding unnecessary ambiguity.
> 
> So is it something we can live with?

How many of these are there going to be?  Could we do something like:

        static inline remap_vma_flags_test(..) {
                return vma_flags_test_all(vma_flags, ...);
        }

        if (remap_vma_flags_test(vma_flags)) {
                ...
        }


