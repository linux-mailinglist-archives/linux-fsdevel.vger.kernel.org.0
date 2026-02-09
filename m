Return-Path: <linux-fsdevel+bounces-76742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEA+FDQyimkPIQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:15:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C563114033
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7E30302834C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589D4219EA;
	Mon,  9 Feb 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SV1G3Yjx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HCPYYZ9d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356A385EC2;
	Mon,  9 Feb 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664480; cv=fail; b=fcYc2986CbUUKVCiT4+ebqn2mFC3v8kSS56FP4Hd7lQPOotQF41EKSr9+kh0Px78IBqB1KXGjhyNtgyzf7ITm/q616h8kK9Kzeew9rsjqw57JiOz4gM6aYZhzkskGQF8dXFqZBqjbRjg+9Sf4JRF5QNYLUMIzMENv8nH7w0Nkrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664480; c=relaxed/simple;
	bh=xxqWldIQxZ0xe2Q/wG4wdMf58ywxerC6FO9hF5awp0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M8TFatNG3FAp++bJevXKaSpkcg6p6iRoPszOFEOLewwb7bJQFk59Yqg6ggRIFYRrVoxVgBFeI+lnaPjKVDxi1s1XrJpBgiSAVEmx3XEqrQoeskKgcZ+UxbxraiizlfSdWbEQ0ppQuvpnybToKvke7W3NSdqGTfVo0XZV1oP6pYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SV1G3Yjx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HCPYYZ9d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECiX02925100;
	Mon, 9 Feb 2026 19:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rJQg+Ia3QneQZnYqOK
	qfRJhszgBGnsus0CDEQ85ty1I=; b=SV1G3Yjx9ZQPgKVMH07JaYf+zgEtXac+sJ
	qLEfEbKgeaAbRPWqNdmXsQs7PYWXR/n7TO5x6V9MEXKMVxQgUBiONIPr9qpht9cd
	0v/89qnlFrw0svSqKlRHWIzsZMQQsyUtiYfj6JYUAgDArdNvcTUufI3v4TqzaJ1y
	QvLRSidIQigVX/wU8CLfAsGOUVOVDWudttk6NCUPTi38sVM4BrmRiy+2KBrLn/MS
	1UOL0De2XlPF5vuqAMYPXwq6tKjWfKvsX8hRtUb9447FOJruA/NFTdDSDjCuOsiA
	ogNPGO4qtcPFHbz8AmEfk/a5RxfZ5bYl2/9jYCCeJJT9L2WTQi9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xf3tkh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:13:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619J1v5v040498;
	Mon, 9 Feb 2026 19:13:54 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uukdkjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsqmilHV8E1bCZ7qW7wRzCoQHx+AXp3OMJmhW6qeoDf8ZtkV8sqzT8hhwRwjTInBxsAVPbN398DrvAj5v0ibf2BBD5pb4fdVJe9x9iKXyuC6iOtHd00Cl6kfNJ9SHBJSyRhfdSbDzJPPLg5AjrTKWlBz5GJwZlgypaCxAZVRThSRjYZ3gCIBdhn82suQPiuEhaZrVL/PZsKvSZ95f/dpH6o46ygcu39y7hjrhbAZHQcdrK3jQHGSIMsrsp48W/KYkv7y6aCdBpTxG1BXFEil4amofMEKL2A0X7eBNOoJlyKRiajjWcZgeEk1jE5gGyzEcPoX5RM5Dkh3Qdg9uY/3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJQg+Ia3QneQZnYqOKqfRJhszgBGnsus0CDEQ85ty1I=;
 b=Lm82mHTyBU5cJyCn9Vln9bJg6w+iaOARtcWUMos+YNIL/Nmtfk3ksiBbkZmOymsuDqcd+h+sJnJ6FxJDWLyKGTHM7QWB6T7ubNwWuWdMaGiqSrh0ZRc9vTQVf1Frby0W5WB1XrHnydsGhFyyEH7iCHQKV2h4iVdoVHou42syJs8di+zBuTkeCKnLIeygYdHK6/8uDKsajbpvwZ9fLsY1dhFvzw92Ql3VZAkTIpKAFhdhgcBSIERNupYxnf4EPvpiDALDUrrvDyiNQEHii6lQ6ohmMpdZh9ENRRXGgYg2NxGgKTXp9uQC48i8uEGaFyb+ijLtgVNNMuh2NhssZW7JtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJQg+Ia3QneQZnYqOKqfRJhszgBGnsus0CDEQ85ty1I=;
 b=HCPYYZ9d0tvDISYgeNB3oTbhmYWFXCIy27EI5FvvNkIlqD3xtnnCj/nD4Q72g8wb4K77dGhS/jTKEoEGGT1h6Nl6lK9iAF6gtqgwR2CUlLVhsykwJjilbwyPZ3+p29Er912TlWGmThRx7M7gQym51AO6bWmwbM6ACVEm+xMSJ2Q=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB6352.namprd10.prod.outlook.com (2603:10b6:a03:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 19:13:42 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:13:42 +0000
Date: Mon, 9 Feb 2026 19:13:31 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v2 08/13] mm: update shmem_[kernel]_file_*() functions to
 use vma_flags_t
Message-ID: <dr7u5luhf53j5fobwlmq22n5ndyuaoj2bdfrqr5redyvh6gfkg@lkjqcal3ypx4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
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
	Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
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
 <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0418.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d56b51b-ee0b-4d22-b068-08de680f56be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeTMkthvcKqPxDt2NwJ1AeDLVWywnnwVN7AHjZo+2bu1Z8F9U5SdnHsz2wa7?=
 =?us-ascii?Q?/N4lSgJ1iUZMNyk/9z/i+g41F/blelnqW96/Mz+iDwLsoPXgB/4AJm2OBpTK?=
 =?us-ascii?Q?oX3VjvJKbOU2sxD7s+1m95NbpcCB7mX+Oj4Q4H0aTeFER1/iINJjBxoIhsys?=
 =?us-ascii?Q?0SKvZJtrzFkMSP9FznGCZYcj0hZJ2lKdEvheohgXmojppk4a7/YAkHYpbdN1?=
 =?us-ascii?Q?Si1hvlsYUiFEHfclPCNwytNJiysZdhbbCjjf0ka9tKyEQGd35CgiIJIA0RIm?=
 =?us-ascii?Q?xqkkqd1xPW+VS/CGTLqa4Fq2UOm4Feju+Lc4uY5d3n2neJpjTeAX6lXDtjlj?=
 =?us-ascii?Q?ApXUyO1AYqzP25sGcsAYumFyH6QBNBfLq7P8+iJtYxg07za6J5U55XbNQTyb?=
 =?us-ascii?Q?vvFXymw2xQhAewDHKM/J/CzlUdnr93wUxprvUuZ4IE90JjqDZApumGX4Bgki?=
 =?us-ascii?Q?BjuQcycjqlHI0L9huBq1EZtucAzNwYVAnuXrwJvP5w9tvigcurRM3zsKbnqF?=
 =?us-ascii?Q?a+P9vPhrpYRpWBxKZZqz/fspUAglMxmTm41uWROJXEKLBNWV0LHnaWMzuqW0?=
 =?us-ascii?Q?wyiUiatmzi0uYXnmf8WmyCZue3RIEIiQUgAytQ9oVe/WEHCs2hgFOKrKRU7U?=
 =?us-ascii?Q?kD/ppQOVC77lEDjqIYSxK/RA63TNhuxwOnqwXOmobUpqmAR3gsBk65aMTy4U?=
 =?us-ascii?Q?7wgmPo3fy9yK260YPSx5KgQUKQqShNg6cdKbbWbPZurhfjlJz0QtyQesipZn?=
 =?us-ascii?Q?h6BrdF2QRKIxYkB1NlkJVKOSR0g69azVt/M4AefRdGo0etjn3X16MfvATe4o?=
 =?us-ascii?Q?frXVPzzkx+S+nDEdWx6X7IL35r7CXjnn4EeoO7A96ypw/UpsbXMUZ1ovt5GS?=
 =?us-ascii?Q?V/iLtc4bf2cRR+0zlMduSX7diVuBedDVDB8I2VpKV+ajo8M4zm4QqKpCQ39k?=
 =?us-ascii?Q?nQjFw4zrRkbLgZlaWNLghkWGb/NKrAeqIcYNPHRqWugcNF2xY8DB+GzNIOfy?=
 =?us-ascii?Q?xu2j5d2nFjohJTK5pczUWdn0WQNXjIoKEmZ6v8Wc3rjy9Mgqg7bea9EcHbYZ?=
 =?us-ascii?Q?Nrytcw7LBotbPLDzTSpG3/uDWHKweEKDMg/Pd+lRLSHQt/ff3YgWyjHCrOK/?=
 =?us-ascii?Q?bU6vJJUYcqpwwO7cFeWpytZAogP4Nwc9b183zmcyMPdSPUmpOYitMejaGO6J?=
 =?us-ascii?Q?FyNGn+hPU90PfqIUyTQcsJcLMIQkdZkzAvC8ZymynTJitzMBMunA0sXoX0jY?=
 =?us-ascii?Q?tLlLXp+qZm1mgkojNzW1yLA+N0A/ujQEEA2X/joH1Y0wzOIsUzPV4deNvQYX?=
 =?us-ascii?Q?2vPKAoR93RZoAFy3QeVLt5EHQwR8OQjzsf934mBrII4oWWotU+9oD3WhCddu?=
 =?us-ascii?Q?hNYBL8ultFTVLs8kks77SJ/ouMK4L66RAAb68V4WijDlb3rXXp6+UpFXKyGG?=
 =?us-ascii?Q?TyEZfoVbvl5yVb9RX9d9OB+ZW6KblOivzAbv8aDaDv6vFgAe6RyuL0Ud28ES?=
 =?us-ascii?Q?rQnRukB7vguGBYr6F9mLfXaYb7DDFH2OYtvLenzdHx0gl8CumLzvHaHwLHTS?=
 =?us-ascii?Q?A1+CBSxLfbQ9aeqLkvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oISvGW6UHK6YV/TBwOn529bCBqpKGOWnOry/tKM67cp2psX6xFciG3Je9qkn?=
 =?us-ascii?Q?VQxcDYnn1ZN3BpgzbXW8R26gV2PvfCjY/NqAAKqksp2s6uFL1I5VfzbBOeY7?=
 =?us-ascii?Q?347r0P8sUscFePLfrfE46sibbs8ZxniS7Ft9aplZii0oXJsjD5FJwVoWoOce?=
 =?us-ascii?Q?EpKxRr90mqwh+BddlICcmJHGqs1c3fi9ncUs2GO/E7QXps7rf/Ru3Kilrj1I?=
 =?us-ascii?Q?b4UOBLER4YtT/1hoUH1bnFeKusAP6AVJGx5nAZzgZ0hV1C+ShV8JKuFCG6RG?=
 =?us-ascii?Q?7Yx2+7JvhVX7CeHnUKRlKZw41Lux89x9Lg1Byr3lHr+ZSfe8HKJYgUY3Bx8n?=
 =?us-ascii?Q?4+NUHDN60kc95bK/SNIWgam1rncFO47HNyTCE7EW/QFO8DSjcLvm9lZCCNwN?=
 =?us-ascii?Q?c/qWOETLwX7tZb5FyUjw1ak2snszo1XBW/OxhBZ4mi6ldMyeoaKPUBQsPixE?=
 =?us-ascii?Q?XSXSLmVI/zrghmeebofbDfnhQhjiPgiplPm8Yx1gydj5v904Nsz0kp3nwRE7?=
 =?us-ascii?Q?L8bqhiL4/87B4ywRZz5Maqs/HDHZ3LQnf36u69pTXg5zOWUJX+s1wCARbRil?=
 =?us-ascii?Q?X+HfY01YCec3sha9zpMRIxP5YJy9Gg7E0PE98QiqDPDFg5CIGNHx5lle9uCb?=
 =?us-ascii?Q?NKJuXUEu9wjUAyQ54kiJ5xY1wvSFfZmZQSldC7lJXuPFnXdZVJs2KCICkoOm?=
 =?us-ascii?Q?141EcDZSYfL73F5tDRBFvG+RG7L3zH8rJztfi4sx9bU1DlI3psbYfQv0bnVd?=
 =?us-ascii?Q?48Qsb/fyArZBkbQzE+gJQr3Skns/uLvKEUV9WQHzNpqhI0nLKaLadFIIINfS?=
 =?us-ascii?Q?JwJYayZpffr8Uw81/IoWj61nPi9oKTBxwkoSrYINK9vE3IbglrtOm9z7XtH7?=
 =?us-ascii?Q?R7I1qIiqtZNzPhe3nhT1bPtIQAXK7Z8QPbIrOMF7mKwJOzbT71AqSuQAel/X?=
 =?us-ascii?Q?oLfMIyPkFcCWiIw2aTIq8OFvjiGRJNjbtvOJoqWXDZaYGr7BXBnzw4SYJm67?=
 =?us-ascii?Q?WOWXuiopOPCiciDp5RJjgYZoZ+usZfRujTWbeXbV5gzS2CQ/REfGi8s+wWOS?=
 =?us-ascii?Q?rwvWtHz3u7Uuznx1xhIVEsj/niTSz/JiU3nBOsk1bnOF7TXBZifSCTpRh0Y6?=
 =?us-ascii?Q?ZCnIX6wg2Emi7vrmqhQa2gBG/p0Smk1Kx70v6dJSPb3mVp8x3ojtjIDMDm3K?=
 =?us-ascii?Q?9ZtS6p7oviIRBrV8rS4lXDt7SQ+A4XfduoYFzBd7UWmUfjCwVNCEtJ/6zapJ?=
 =?us-ascii?Q?c5sB6fygBdiOpJYOGV4t5Pugc/Uan/sbHpK3bfKxYo0RP/j9iWXBr4+LcXUV?=
 =?us-ascii?Q?kBfanxk5I8MOUnd9/j4Y2ALMqPimY1Ul/g3UWJEuPJkwIOOQd6/wq+W8GSfy?=
 =?us-ascii?Q?FCnIGOBI/PcWlEahSthtHgk+FlMS1pi6H80zGofvCfjFczsaA5f6BwZWGmlg?=
 =?us-ascii?Q?LdtCPOdWsfyKgiyak9yXyCp8QiM9DY8X27dEFHUYk6EJxP6/WXCqHoTFjSw6?=
 =?us-ascii?Q?Cr/YmI6MC4jl7GSlgwA4G+zMNdlmbVa5GkNfVHlBxcYPYmRA1L58wF4bltDn?=
 =?us-ascii?Q?4cPVkAeHwEAwTf/XkSyXHxPjLB5khezR7iLQoaLRv33VqE2rBKnIYe4KTPO1?=
 =?us-ascii?Q?0HyfF5XUGFOhHgqu5vHuPd1Cc7nmui2ftDqv7BX+FgSFDlEj0BPmFnb3IYlp?=
 =?us-ascii?Q?s4twrWjb7ueEtsLqob1pTdT9rxbTXEIodAyLrMOdDHwZecvJAetN2UNG4sAW?=
 =?us-ascii?Q?cAhv+IR4vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AwJUiL6Skro2Ij87dGwGrvcUoo6Kkg+GJHc53r88ry2YOAUZxuYyqH1nIzMHJm9YpM6u/CsRB/kKvwvxAREf0P+S1E7nHYj8UDWGY8xuFfs2e0s4++iMd1Cn7dcJw+l20eJ5VOWJBvmFN56Sh6hPUXv3M1Jp9A86y6npGCFb/l0gDpP4HcHuC8MdVsdI5PSnbeGP/mP/pvqogd1qLz27PreMxsSr2LDYR7EqZtffsnFWXUMQI6rDPsqgXsqvSQ/LvlchYZmB3AXTSr6RFxy+UjtM+97rtXL4yWO0C46g/UOHIt2fAs+RF3bxayctDXn7nPNkHaizHkVHOz/jNis8YgjddwqZJbhaQi5HcOj3iTP2Vo7bbBhkAuZj9zWjB63YwZy05GdHlVL0vyUX3Hp2VLyttGantCSmXo5YPd6Swn0hop16LmCO9axgJtRHzeHI5Q0LuDyI8ybYQQkyBjUkN0ci7kva4DA/6G1Nrh+T4q07NV4jW5aV2HN515cUryaVsRgJ7QvpIFHCUinwpDgu+S/7nWDxaG6eMlKii0D3kx8rTYx9zpY2GNB8PkDgExemJbj0WIVBiqFCUYx2KUIcuUUwkmYq9ekX3HMyQ1Cmk6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d56b51b-ee0b-4d22-b068-08de680f56be
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:13:42.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D3rPhryDAMnhNeqGrtZgBJe/KnI3wP2d3N08c1Z44QneHg7fk/+TgI51YieaCwdO3RorWzJgHxwT+S1DWgeig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090162
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2MiBTYWx0ZWRfX8lYTeaR0pZ28
 lEOveTgRdsXvxhIlYxRhB73CKsPOeNXaOf/hBW9THYqsdMIHwgg++UmRVpKsmKxT4EIPzqi7SsO
 DzVP7mgvMIllK9tQ9H6CSaPEkAP5VJAjFeqKvPDj451CUPNTgXMb/QFH+m4NK6zUtuonXsFGUFW
 TS+QseJPw0rRKZ3qPqniHZxViH3XLlgQmLiMtonMfxqtHLtk8U/Oblj62uFfCGJtaSeo2u7roQx
 OgPSsckd5Bkr7RvajdksBsWlBbzAoAeAeqL6Gz/s5NP31mcdFvYscrkdDLDKhdbvxc4dQxZiUSx
 Ub26lVnYoIjQQ/ETZjnC3vREQaRwUczpVqQLFBrr9E+8g1ckWFMYFk2D88ykEYhz81mVJnHd3hw
 1WKuP6iWuzc8PZwEKe4Uc5YDAG8Fs4Ern5LVMwCQxk1tIuNBVeD4r/D8iaRd2iFu+6oFPaPG7nK
 Djeh5/mVqIyBW2nndKdjqjUr0p9jqqNX5uI1P8bE=
X-Proofpoint-GUID: wKuXxtICDh1LLtysuE6pRfsEUg3FfGFG
X-Proofpoint-ORIG-GUID: wKuXxtICDh1LLtysuE6pRfsEUg3FfGFG
X-Authority-Analysis: v=2.4 cv=KLNXzVFo c=1 sm=1 tr=0 ts=698a31f3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=Cdk6s1E-3BJOVbofpSQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12149
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
	TAGGED_FROM(0.00)[bounces-76742-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
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
X-Rspamd-Queue-Id: 7C563114033
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> In order to be able to use only vma_flags_t in vm_area_desc we must adjust
> shmem file setup functions to operate in terms of vma_flags_t rather than
> vm_flags_t.
> 
> This patch makes this change and updates all callers to use the new
> functions.
> 
> No functional changes intended.

A few nits, but

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
>  drivers/gpu/drm/drm_gem.c                 |  5 +-
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
>  drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
>  drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
>  drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
>  drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
>  fs/xfs/scrub/xfile.c                      |  3 +-
>  fs/xfs/xfs_buf_mem.c                      |  2 +-
>  include/linux/shmem_fs.h                  |  8 ++-
>  ipc/shm.c                                 |  6 +--
>  mm/memfd.c                                |  2 +-
>  mm/memfd_luo.c                            |  2 +-
>  mm/shmem.c                                | 59 +++++++++++++----------
>  security/keys/big_key.c                   |  2 +-
>  16 files changed, 57 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 9322a9287dc7..0bc36957979d 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -83,7 +83,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	encl_size = secs->size + PAGE_SIZE;
>  
>  	backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
> -				   VM_NORESERVE);
> +				   mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(backing)) {
>  		ret = PTR_ERR(backing);
>  		goto err_out_shrink;
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index e4df43427394..be4dca2bc34e 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -130,14 +130,15 @@ int drm_gem_object_init_with_mnt(struct drm_device *dev,
>  				 struct vfsmount *gemfs)
>  {
>  	struct file *filp;
> +	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
>  
>  	drm_gem_private_object_init(dev, obj, size);
>  
>  	if (gemfs)
>  		filp = shmem_file_setup_with_mnt(gemfs, "drm mm object", size,
> -						 VM_NORESERVE);
> +						 flags);
>  	else
> -		filp = shmem_file_setup("drm mm object", size, VM_NORESERVE);
> +		filp = shmem_file_setup("drm mm object", size, flags);
>  
>  	if (IS_ERR(filp))
>  		return PTR_ERR(filp);
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 26dda55a07ff..fe1843497b27 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -496,7 +496,7 @@ static int __create_shmem(struct drm_i915_private *i915,
>  			  struct drm_gem_object *obj,
>  			  resource_size_t size)
>  {
> -	unsigned long flags = VM_NORESERVE;
> +	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
>  	struct file *filp;
>  
>  	drm_gem_private_object_init(&i915->drm, obj, size);
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index f65fe86c02b5..7b1a7d01db2b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -200,7 +200,8 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
>  		struct address_space *mapping;
>  		gfp_t mask;
>  
> -		filp = shmem_file_setup("i915-shmem-tt", size, VM_NORESERVE);
> +		filp = shmem_file_setup("i915-shmem-tt", size,
> +					mk_vma_flags(VMA_NORESERVE_BIT));
>  		if (IS_ERR(filp))
>  			return PTR_ERR(filp);
>  
> diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
> index 365c4b8b04f4..5f37c699a320 100644
> --- a/drivers/gpu/drm/i915/gt/shmem_utils.c
> +++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
> @@ -19,7 +19,8 @@ struct file *shmem_create_from_data(const char *name, void *data, size_t len)
>  	struct file *file;
>  	int err;
>  
> -	file = shmem_file_setup(name, PAGE_ALIGN(len), VM_NORESERVE);
> +	file = shmem_file_setup(name, PAGE_ALIGN(len),
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(file))
>  		return file;
>  
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> index 61ec6f580b62..bd5f7d0b9b62 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> @@ -143,7 +143,7 @@ static void ttm_tt_fini_shmem(struct kunit *test)
>  	err = ttm_tt_init(tt, bo, 0, caching, 0);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
> -	shmem = shmem_file_setup("ttm swap", BO_SIZE, 0);
> +	shmem = shmem_file_setup("ttm swap", BO_SIZE, EMPTY_VMA_FLAGS);
>  	tt->swap_storage = shmem;
>  
>  	ttm_tt_fini(tt);
> diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
> index 32530c75f038..6bd4c123d94c 100644
> --- a/drivers/gpu/drm/ttm/ttm_backup.c
> +++ b/drivers/gpu/drm/ttm/ttm_backup.c
> @@ -178,5 +178,6 @@ EXPORT_SYMBOL_GPL(ttm_backup_bytes_avail);
>   */
>  struct file *ttm_backup_shmem_create(loff_t size)
>  {
> -	return shmem_file_setup("ttm shmem backup", size, 0);
> +	return shmem_file_setup("ttm shmem backup", size,
> +				EMPTY_VMA_FLAGS);
>  }
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index 611d20ab966d..f73a5ce87645 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -330,7 +330,7 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_tt *ttm,
>  	struct page *to_page;
>  	int i, ret;
>  
> -	swap_storage = shmem_file_setup("ttm swap", size, 0);
> +	swap_storage = shmem_file_setup("ttm swap", size, EMPTY_VMA_FLAGS);
>  	if (IS_ERR(swap_storage)) {
>  		pr_err("Failed allocating swap storage\n");
>  		return PTR_ERR(swap_storage);
> diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
> index c753c79df203..fe0584a39f16 100644
> --- a/fs/xfs/scrub/xfile.c
> +++ b/fs/xfs/scrub/xfile.c
> @@ -61,7 +61,8 @@ xfile_create(
>  	if (!xf)
>  		return -ENOMEM;
>  
> -	xf->file = shmem_kernel_file_setup(description, isize, VM_NORESERVE);
> +	xf->file = shmem_kernel_file_setup(description, isize,
> +					   mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(xf->file)) {
>  		error = PTR_ERR(xf->file);
>  		goto out_xfile;
> diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
> index dcbfa274e06d..fd6f0a5bc0ea 100644
> --- a/fs/xfs/xfs_buf_mem.c
> +++ b/fs/xfs/xfs_buf_mem.c
> @@ -62,7 +62,7 @@ xmbuf_alloc(
>  	if (!btp)
>  		return -ENOMEM;
>  
> -	file = shmem_kernel_file_setup(descr, 0, 0);
> +	file = shmem_kernel_file_setup(descr, 0, EMPTY_VMA_FLAGS);
>  	if (IS_ERR(file)) {
>  		error = PTR_ERR(file);
>  		goto out_free_btp;
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index e2069b3179c4..a8273b32e041 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -102,12 +102,10 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
>  extern const struct fs_parameter_spec shmem_fs_parameters[];
>  extern void shmem_init(void);
>  extern int shmem_init_fs_context(struct fs_context *fc);
> -extern struct file *shmem_file_setup(const char *name,
> -					loff_t size, unsigned long flags);
> -extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
> -					    unsigned long flags);
> +struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags);
> +struct file *shmem_kernel_file_setup(const char *name, loff_t size, vma_flags_t vma_flags);
>  extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
> -		const char *name, loff_t size, unsigned long flags);
> +		const char *name, loff_t size, vma_flags_t flags);
>  int shmem_zero_setup(struct vm_area_struct *vma);
>  int shmem_zero_setup_desc(struct vm_area_desc *desc);
>  extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 2c7379c4c647..e8c7d1924c50 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -708,6 +708,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  	struct shmid_kernel *shp;
>  	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	const bool has_no_reserve = shmflg & SHM_NORESERVE;
> +	vma_flags_t acctflag = EMPTY_VMA_FLAGS;
>  	struct file *file;
>  	char name[13];
>  
> @@ -738,7 +739,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  
>  	sprintf(name, "SYSV%08x", key);
>  	if (shmflg & SHM_HUGETLB) {
> -		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
>  		struct hstate *hs;
>  		size_t hugesize;
>  
> @@ -755,14 +755,12 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  		file = hugetlb_file_setup(name, hugesize, acctflag,
>  				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
>  	} else {
> -		vm_flags_t acctflag = 0;
> -
>  		/*
>  		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
>  		 * if it's asked for.
>  		 */
>  		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
> -			acctflag = VM_NORESERVE;
> +			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
>  		file = shmem_kernel_file_setup(name, size, acctflag);
>  	}
>  	error = PTR_ERR(file);
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 5f95f639550c..f3a8950850a2 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -469,7 +469,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
>  					(flags >> MFD_HUGE_SHIFT) &
>  					MFD_HUGE_MASK);
>  	} else {
> -		file = shmem_file_setup(name, 0, VM_NORESERVE);
> +		file = shmem_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT));
>  	}
>  	if (IS_ERR(file))
>  		return file;
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 4f6ba63b4310..a2629dcfd0f1 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -443,7 +443,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>  	if (!ser)
>  		return -EINVAL;
>  
> -	file = shmem_file_setup("", 0, VM_NORESERVE);
> +	file = shmem_file_setup("", 0, mk_vma_flags(VMA_NORESERVE_BIT));
>  
>  	if (IS_ERR(file)) {
>  		pr_err("failed to setup file: %pe\n", file);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0adde3f4df27..97a8f55c7296 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3057,9 +3057,9 @@ static struct offset_ctx *shmem_get_offset_ctx(struct inode *inode)
>  }
>  
>  static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
> -					     struct super_block *sb,
> -					     struct inode *dir, umode_t mode,
> -					     dev_t dev, unsigned long flags)
> +				       struct super_block *sb,
> +				       struct inode *dir, umode_t mode,
> +				       dev_t dev, vma_flags_t flags)

Using two tabs here would have been less ugly, and below too.


>  {
>  	struct inode *inode;
>  	struct shmem_inode_info *info;
> @@ -3087,7 +3087,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  	spin_lock_init(&info->lock);
>  	atomic_set(&info->stop_eviction, 0);
>  	info->seals = F_SEAL_SEAL;
> -	info->flags = (flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
> +	info->flags = vma_flags_test(&flags, VMA_NORESERVE_BIT)
> +		? SHMEM_F_NORESERVE : 0;
>  	info->i_crtime = inode_get_mtime(inode);
>  	info->fsflags = (dir == NULL) ? 0 :
>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
> @@ -3140,7 +3141,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  #ifdef CONFIG_TMPFS_QUOTA
>  static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  				     struct super_block *sb, struct inode *dir,
> -				     umode_t mode, dev_t dev, unsigned long flags)
> +				     umode_t mode, dev_t dev, vma_flags_t flags)

A variable named flags is often incorrectly passed along as the wrong
flags, so I try to avoid it.

>  {
>  	int err;
>  	struct inode *inode;
> @@ -3166,9 +3167,9 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  	return ERR_PTR(err);
>  }
>  #else
> -static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
> +static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  				     struct super_block *sb, struct inode *dir,
> -				     umode_t mode, dev_t dev, unsigned long flags)
> +				     umode_t mode, dev_t dev, vma_flags_t flags)
>  {
>  	return __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
>  }
> @@ -3875,7 +3876,8 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
>  		return -EINVAL;
>  
> -	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
> +	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev,
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -3910,7 +3912,8 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>  	struct inode *inode;
>  	int error;
>  
> -	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
> +	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0,
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(inode)) {
>  		error = PTR_ERR(inode);
>  		goto err_out;
> @@ -4107,7 +4110,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		return -ENAMETOOLONG;
>  
>  	inode = shmem_get_inode(idmap, dir->i_sb, dir, S_IFLNK | 0777, 0,
> -				VM_NORESERVE);
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -5108,7 +5111,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  #endif /* CONFIG_TMPFS_QUOTA */
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL,
> -				S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
> +				S_IFDIR | sbinfo->mode, 0,
> +				mk_vma_flags(VMA_NORESERVE_BIT));
>  	if (IS_ERR(inode)) {
>  		error = PTR_ERR(inode);
>  		goto failed;
> @@ -5808,7 +5812,7 @@ static inline void shmem_unacct_size(unsigned long flags, loff_t size)
>  
>  static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  				struct super_block *sb, struct inode *dir,
> -				umode_t mode, dev_t dev, unsigned long flags)
> +				umode_t mode, dev_t dev, vma_flags_t flags)
>  {
>  	struct inode *inode = ramfs_get_inode(sb, dir, mode, dev);
>  	return inode ? inode : ERR_PTR(-ENOSPC);
> @@ -5819,10 +5823,11 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  /* common code */
>  
>  static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
> -				       loff_t size, unsigned long vm_flags,
> +				       loff_t size, vma_flags_t flags,
>  				       unsigned int i_flags)
>  {
> -	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
> +	const unsigned long shmem_flags =
> +		vma_flags_test(&flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
>  	struct inode *inode;
>  	struct file *res;
>  
> @@ -5835,13 +5840,13 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>  	if (is_idmapped_mnt(mnt))
>  		return ERR_PTR(-EINVAL);
>  
> -	if (shmem_acct_size(flags, size))
> +	if (shmem_acct_size(shmem_flags, size))
>  		return ERR_PTR(-ENOMEM);
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
> -				S_IFREG | S_IRWXUGO, 0, vm_flags);
> +				S_IFREG | S_IRWXUGO, 0, flags);
>  	if (IS_ERR(inode)) {
> -		shmem_unacct_size(flags, size);
> +		shmem_unacct_size(shmem_flags, size);
>  		return ERR_CAST(inode);
>  	}
>  	inode->i_flags |= i_flags;
> @@ -5864,9 +5869,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>   *	checks are provided at the key or shm level rather than the inode.
>   * @name: name for dentry (to be seen in /proc/<pid>/maps)
>   * @size: size to be set for the file
> - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> + * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
>   */
> -struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
> +struct file *shmem_kernel_file_setup(const char *name, loff_t size,
> +				     vma_flags_t flags)
>  {
>  	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
>  }
> @@ -5878,7 +5884,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
>   * @size: size to be set for the file
>   * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
>   */
> -struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
> +struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags)
>  {
>  	return __shmem_file_setup(shm_mnt, name, size, flags, 0);
>  }
> @@ -5889,16 +5895,17 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
>   * @mnt: the tmpfs mount where the file will be created
>   * @name: name for dentry (to be seen in /proc/<pid>/maps)
>   * @size: size to be set for the file
> - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> + * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
>   */
>  struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
> -				       loff_t size, unsigned long flags)
> +				       loff_t size, vma_flags_t flags)
>  {
>  	return __shmem_file_setup(mnt, name, size, flags, 0);
>  }
>  EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
>  
> -static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
> +static struct file *__shmem_zero_setup(unsigned long start, unsigned long end,
> +		vma_flags_t flags)
>  {
>  	loff_t size = end - start;
>  
> @@ -5908,7 +5915,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
>  	 * accessible to the user through its mapping, use S_PRIVATE flag to
>  	 * bypass file security, in the same way as shmem_kernel_file_setup().
>  	 */
> -	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
> +	return shmem_kernel_file_setup("dev/zero", size, flags);
>  }
>  
>  /**
> @@ -5918,7 +5925,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
>   */
>  int shmem_zero_setup(struct vm_area_struct *vma)
>  {
> -	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
> +	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->flags);
>  
>  	if (IS_ERR(file))
>  		return PTR_ERR(file);
> @@ -5939,7 +5946,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
>   */
>  int shmem_zero_setup_desc(struct vm_area_desc *desc)
>  {
> -	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
> +	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vma_flags);
>  
>  	if (IS_ERR(file))
>  		return PTR_ERR(file);
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index d46862ab90d6..268f702df380 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -103,7 +103,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
>  					 0, enckey);
>  
>  		/* save aligned data to file */
> -		file = shmem_kernel_file_setup("", enclen, 0);
> +		file = shmem_kernel_file_setup("", enclen, EMPTY_VMA_FLAGS);
>  		if (IS_ERR(file)) {
>  			ret = PTR_ERR(file);
>  			goto err_enckey;
> -- 
> 2.52.0
> 

