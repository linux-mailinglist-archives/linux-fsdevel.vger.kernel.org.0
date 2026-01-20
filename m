Return-Path: <linux-fsdevel+bounces-74691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCBWIw+4b2kBMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:14:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9E485F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C09DDA071A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DAA4418C3;
	Tue, 20 Jan 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DZ2okrX4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CYsdwKYg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258A441056;
	Tue, 20 Jan 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926208; cv=fail; b=OKLRnvbCoGwXlD3j2MtlpUFrclFfhIwAaAcTB0QaS2Etnl4SaZntH28g6sAhBgnU2kyfFqnCf4tYsM5Vda+jZUm9qqJo/3y8vMzilfRcgGKOEth3CIwortffOl+Ubh4YOivRSKl4cmuTxRzTVhuYEn6MKcczmL84kojfbM4lnQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926208; c=relaxed/simple;
	bh=Kw39Fu3MthI9SxYA14MYRg70gKHOHSHwbmq9lGaOvZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ugv1W1aoQm2u3goeMwKQ9xzdVfBcTO6izChRYa2dz0qxOiJVeiphe9nRFSrD9rdh8wZkBCYOE3uGqj0b0Enm15BvBsh+qLECLRUDZdpKl69FYb53zEh+wk4hd+wxF3uJWUL+u2+y1XcZMQzlI2YomFRVs/Xad0lLuchhuV2tZmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DZ2okrX4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CYsdwKYg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7v1xV3029082;
	Tue, 20 Jan 2026 16:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=oOcX2MMnF+WfP5mKiB
	kCJBYsVizdVUHUtzSIq38ZCyQ=; b=DZ2okrX4b+Vfpz0bhXEH96P8xm2z8KB7SM
	AVb5V1W19V7aUG1/+NBKyGx5OPvaT/dE/r6MSzpRSMTsqEs8ZQMlkfqafX9p90sm
	an5f4QpWeemEE0UWcp2uDREf6heqi5sODgNRBRaP2qkD5BMf/xV7OXiPC+EWVgYg
	j3wJj5olDJEzhs7ypRnNCLUEUKPpbb09Z3jxpZdzDjtseBUfjh3Sy9+AYMO8nlKU
	GDlSv9k96R/Mvf2rqw9SokIzDM3hOjC3FE+j97RtCDY9C1tmrzPIA0s5dk/a5bZQ
	jIz+fUHXcqXtvjc71bzl54VevG6Q8d5MdKzfkP80WeiJtnivaoFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vux7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 16:22:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KGA9g6019067;
	Tue, 20 Jan 2026 16:22:16 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrqq2k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 16:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0EVnEtXbNFvv+8gAAsnXvXiZn1jvE2avIeeZgH2wSpb8fDXwnc9huKkSqC/vLmJ5crtBfIqPVwgxbvC6yoDWhJolxXIou7h/2bEpIvfDBZoDD6X8at/SJiDZBEeBoq/hSBhd+fzlAwEc1bKmaOEGxd1gr2WMiw85C6LNkuJTqRI4TG+kA09vcOagaHQKEKz/mxchtgK062dxFCZi8FBx+URje6b1DLC1F/LgocpI3gL6RjgmxvgOX1ODJ5Uomk07wnGX1JdVH32JLonJkRzD5Pi58A6y1duax63S+aLckG5vyJ/qY0WVvlDPBpOTsqI9b7HR+tIvkc/furB8jPCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOcX2MMnF+WfP5mKiBkCJBYsVizdVUHUtzSIq38ZCyQ=;
 b=APz2NVt43DzeZ0Ck3c8fpsYa1JcznR5H1x0/c+EAZHpC/Paqs2tZFLew8/VhFjLQxTFjUuHhNytjjRNSHGtaXsWq+ZiJMkVYgo+qQW2eC9GdKXq882c4OtShTDTyYQ9cdmA+VaqxjnKGC0Q/wjNH4qp+MMC7hkcPnPFJg/+VPwWU2cEpYL+1o7kOoDy7Cl1auyUQVJxo6WQyhYI4M8ZLqgYUJ9l+IFKPuhZQ9Z1ydUT26KpiN7Gdn7iOravMYEp6V7FWe0axtzU9Ln0VVPYynTiwnXXi8HUPDSu8dJCy+j4JJ9cQHPs5IybRTJh7T2lJPpb4H3lMJ2hsLQzxjxofKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOcX2MMnF+WfP5mKiBkCJBYsVizdVUHUtzSIq38ZCyQ=;
 b=CYsdwKYg+SbeKC2L6o0WZ8SLl0KN6bfmpm9ayQ01DZJOkdR691w1k4G38MhXLM61SfuLVtvu4Qdy4ceTCeNWKrDJWQcVyLln9pI5ZowxcXnGkYg039EmtMnNERzO9pjCJ8tziGWVlzCvZKaYXHCXUtiOXDL3sgeUfjrafPH97JE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS0PR10MB8224.namprd10.prod.outlook.com (2603:10b6:8:1ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 20 Jan
 2026 16:22:12 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 16:22:12 +0000
Date: Tue, 20 Jan 2026 16:22:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
        "David Hildenbrand (Red Hat)" <david@kernel.org>,
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
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t
 only
Message-ID: <44461883-a75c-466b-a278-97c4ab46b461@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
 <20260120133619.GZ1134360@nvidia.com>
 <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
 <1617ac60-6261-483d-aeb5-13aba5f477af@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617ac60-6261-483d-aeb5-13aba5f477af@app.fastmail.com>
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS0PR10MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 172bdce6-5223-427f-54b6-08de584010ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xjph8nlFyQVnj3HTgIts2LQY5VqVqVaU1+NZ7g7fhGetjLh89AdTkjUJAu2H?=
 =?us-ascii?Q?qRbsJqQscvG6dw12ZpMyuOUrYvCGevxQmZY0zlyYOJZJiEFYdCTzWB31M9iN?=
 =?us-ascii?Q?m6oodd3SawSRRrKz6Xtj7LCU+UaCyqSP5WpZmUQ/IzPClj2FlGPu+mO2Okx1?=
 =?us-ascii?Q?Ic8tk15ph0FX1Tqgxkn01invbeIXTawwvJlP7KhAwuOfEIzqXwcrQW/WLwGo?=
 =?us-ascii?Q?q1nt0oSg4R//14Ko5rYE/XqVKkA4Sad84mEVDvGOPPsvRQzFh4UjHcXowm07?=
 =?us-ascii?Q?urEM+OXQEKhbPebGoznbheRKjGxNl9n0hXuyRKzgnixR8mwxee+KNoGS9lkA?=
 =?us-ascii?Q?R8UNZ6ou6WtS0SenCBy+wCfIgl1AmQROf4h2RwV7R2AGdQMggx67dV85M5qt?=
 =?us-ascii?Q?UZs+DjRWReemGh3f8tVk8vv0FKDcdwZ6YN0p9DS6k4k6ncEcMSCkb+WW9Hes?=
 =?us-ascii?Q?uNpg2WjCf07pTF3n5BfrUIYhbnqUARiBWccyB3aXuMrrL4OntGkEUnVOG2jR?=
 =?us-ascii?Q?QVvEpZg7QCWkCFvt/Mn9NQKFwRy9jl3NrhnKKXFMBp8vVATtP6aF3j0jpHyN?=
 =?us-ascii?Q?4+F6/nHxOQ69ln8cI8TxZ5gpvPcoiwB+7lcOPQMSU165XVKBBipum1l271ds?=
 =?us-ascii?Q?ETaw4szVUc65jUKivvj7I/kOrwSA638hiReBAsxASwSKQEMl+wMLUi3svvqQ?=
 =?us-ascii?Q?8sNuWnVyc3A7pl1yIrgoiVIBzZgatxYYf7VAaZqsCfnaxU2O/vFZkJQirEA+?=
 =?us-ascii?Q?ID6dZh8mZ5HkRd/nj5LBEz1vGSDAVx4pST/Eb5j7NoTqt4wA+b2NaXOHUlCk?=
 =?us-ascii?Q?obBJ1MCqXxjW2GXVqew32hmhiEDAd5TjtbyvOWjR7LWHWh5WLLlPVHCxq9R2?=
 =?us-ascii?Q?ST3Fn3APgHdlXDvgGX3lBP2eLWrvDf9RDeGYdoJsJJZ38Y5LI0hS753E2EoA?=
 =?us-ascii?Q?0g+3kMMvCWQj+QQkpBPh3vU/Cocr/Q5ipOppGml/9Ej1fO42MpZsILs+iRKU?=
 =?us-ascii?Q?pliFxlLqx4N+u68EYWri/WQkXNzQantE6ljoj0dwmoMcOO7IaZhgfetzMlDd?=
 =?us-ascii?Q?GEgQav4sIlU0+WzVZsW/eeVIp6JzzhR6lU9wUYdsWzNY+PMkZHHG4M7e2KGR?=
 =?us-ascii?Q?N9VsYKfI4KIgcSpwyxkIGi7DdqlvV8tgJLHLoEmkN1VTaUjMtENNKD4zwLeS?=
 =?us-ascii?Q?cHOoXgNh+QyHWTNNuio0FCfY3qiSnjKo8+FMBhNxf1iHjLIkP9pcgDdaOOVr?=
 =?us-ascii?Q?LL3isfqFAbDimiScZ8CLQqGUnJajx1gofG9BwAMiju4i/CFNvuMApUkNlThZ?=
 =?us-ascii?Q?tXoayBvEorrjCJ7mBxrUQM97dYbaPENlmKLQviqsCfzi4pM9tumint3Brblq?=
 =?us-ascii?Q?9REoOQ0WKXwGnv+GJyzZd31ABI7HXWllB4QpXhae4pgydUaLcPE2WRCtdDsS?=
 =?us-ascii?Q?0WMN9QD1pH6fjtj+ElB16a1mq7YpxKIJ+HURT9whNQcYDHfghrbBRAFyGJAg?=
 =?us-ascii?Q?wumczoBG71pG28DEHVqF6yjLXHwv5+GuxmWFucTWO6mv7octqZK/Rwi88MiC?=
 =?us-ascii?Q?IjvWG90vc/xeUdORMMA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LDeNnd5GbAG9mA83wbFq5zhl9aGYyBzHVOubTrmqRb47zJ4Kbjvd8HsOJMd?=
 =?us-ascii?Q?4Pf3/TOVAfMBnBMwOZlyybM0dtfUY5c9XT6ZHoVhGOlgjveR8jodwlvGE7SZ?=
 =?us-ascii?Q?UPyApV7R823kPr2ovktdHwDdXOGuJRO2Gwy9kl9TrtvmQ2EbE+uAPMfIjLnP?=
 =?us-ascii?Q?Q0v+eNmqg9e1lsWoH1e119b+KtzGcD9kIIZ7qHlCWrPSIZUszpynVJYCjR27?=
 =?us-ascii?Q?vJCJgHRdWOg1c24wn/rSKx1G8ex5tHi6rAIISdm/zIAEgEc0b2e7RCAHcIMY?=
 =?us-ascii?Q?ApUJp/BgXTJXbvJTn37i/KqY6OahdAj93T515xD0VFEE4dz1bJfZV37YD9RV?=
 =?us-ascii?Q?DaJA95gsfuqL5mZMhKJLctKPC+VT+7m4z9an8vP+dPax5oPdZQESQwnLlvNm?=
 =?us-ascii?Q?s2XKRqerP6gRLqc6jtX0/fBdCCvcrja6mNm7a8HouQsPC4UyKnC3UvGGYr95?=
 =?us-ascii?Q?O9ZpRAFfprwT6ZECjsoOidkVu+JYH3SM+q8iTMhRUCNYqvMqZUTFaiP3c7PX?=
 =?us-ascii?Q?RVpkyW3nYemlXBRNemy2c2jFMtFv4uzomyauDVMy+r3jsd+J6Lu3BYg9ibHA?=
 =?us-ascii?Q?mZBe33LMVT8Ll/z/+vv3RVkaOvNjnaV7uMAQS1Axad3siyJLuHHx99kRZBdy?=
 =?us-ascii?Q?SW+ME6QbuiyQ57+EmXDi4g6cgfa+wWvks9S0BNzCtGbhVOgr8A90njtRa7vN?=
 =?us-ascii?Q?uADTZu6DdaszsyN6C81lS2zRibuWzPw+RasPJfWqdS7BJer/t+R4Idkd2syb?=
 =?us-ascii?Q?0pW+XtBG6eO1CpvNBOssMwmN83iDB0+z+zdLDkcRleVcqR5IDZfOCdJndKZG?=
 =?us-ascii?Q?5EySFexiPhnEBHUku4aJpjgQPxS1JGSBe1Vx5YdFBGJ4a5eu53AURWz0FkCt?=
 =?us-ascii?Q?hWVJ9pZv9UiF+15TY0flw+vRi5ZSf7nnQNu5DDedgCT9SQEuxLSbCbAKxEeh?=
 =?us-ascii?Q?ReeJwvxauT+KHAm/YTlG+vz6OPfv3ZU738FoiUphmI9bcFGrE4QkPANTHI36?=
 =?us-ascii?Q?ay40HOuqKQIn5WEovdsmbZR/paShFNJxBPPxvFupF+gZVqOpvuCP/5Ah6vRJ?=
 =?us-ascii?Q?h7QMzCgrOEA1NCl7ztIHPDgbylJXm+V97ACV/pgeYjSmUJUXS9RkUBEyv+/3?=
 =?us-ascii?Q?UEf/0dAEd69RDnom0ZnaVIs4HL9hjcAFyFln40EXDiU2JdcUcrPkScxxLuc+?=
 =?us-ascii?Q?2cIU5+ScBcTAMLo4d2HbDNTFKhb5nV/D7B0ASPCCNImHlRUKR9/CGmz8mzQd?=
 =?us-ascii?Q?y6IsAe4e0EJSY/v8o14NrfVe2SdkfZiBDvZVbXh0PVGQsDRA1VnnxeKNZ+tM?=
 =?us-ascii?Q?0RFjV8VerO6BRul448zfMg4/vdlsV4wb9QwPZMtme3p6ndPGMV5MBWngCp3Q?=
 =?us-ascii?Q?9DWoexLINrQP7TLIJSETgyM9zUNHar6FImafAcn1Klsyiwayk2ZgGuYWQdWO?=
 =?us-ascii?Q?pe5TGtE4EH++0welVGzf0NTP660qnKBFsdarqU48or6ZnFW8zYx+H2o7T6kQ?=
 =?us-ascii?Q?ka8J556Pa5VXoewcBNuWrv89EB2OKb+v/MjD1aQw2+JD9SUOHGHTntNPJJgB?=
 =?us-ascii?Q?A95/r2mQ7BzuVS0QO29M5kebclWJ7rX+k0CE6QKVARgyXwHj1K6bVSUSTbbY?=
 =?us-ascii?Q?JUaY8ER2FCQIc/6cA8OYVAVqz3pFdO4B7c0sJOzCxtzm7PyIE1Aj6f+VVj8p?=
 =?us-ascii?Q?1d3EH/EAtEYofY+m7nhiZ4t2kwTWvBdHOHO1ShTZ129504E5HUi392TId1wA?=
 =?us-ascii?Q?rNInY3PB5mNt0l6ufqejPMpLOYRtnx8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OQbJvDRlIaPgy+SZwsr3J0G4PhsB0PB9IUbHy/rxHoN97J9pGSNxDzvpc0r9XuKhu/nVgw6SKz34suJgSwqi83ypmBDp73ggLnQtG89HrN1pRKh1WeNrDYVduKkIlyv6Ka9YyshHPJfkBgOqfPiV/aafMOVJOcQTJMzYIPHzQ5/KrLDKBFjWCCP9LK2hJOPJHvAfT1DR63iHNiubHqMEpPkZIPCVEJeixblKEf6jUerCWYAP+VLH64uSelWy7gf8B1cKiKz6uXbSntglG0qT/lfpn+4oX49EronAgLIQIicjY+Bv4hku78MkB4rzJ9LKEzURohjTAkvJbgGc1wjG9dfwW4kEQeSOsXwlQ+6bmRmX49PUweZ7TceO3Hs4KPtq3FJm8nC2dUu5odpC+BHHMjQBb2Am5CG77pl1XE6ZHpbCw7/t9OlhjKP1N1k5BROmMOwCb8ZMVk7mKUolQzaK6/U1QJveQtHqfJfSsq9VPLsBTWHqVH2g0Dc2tU592qcuKFxFmGu0PnLjCCnkLizb4rSwWhoKwYSIcR48In3F77N069/PeZxEEvJufb/bpU9OOgmZHT5tsG31DAx2POEJbwhC9rWAsaFolFueooDVDgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172bdce6-5223-427f-54b6-08de584010ee
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:22:11.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/Of+YyvMKHLIrQ2ufyZ1d/HMfF9IQuKi2lcEi0guQCZ1WnrwS8mrBMMg2lG3OWPhwUb7fPt5mi0xxp0bplqXh06Xa7HXJY3ueRq9cRJkhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601200135
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696fabb9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oSw7eB-6QLRB6zAhL7UA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12110
X-Proofpoint-GUID: sjZYuLN1XjPQOfSRq8yTOoK-Ug0SAisl
X-Proofpoint-ORIG-GUID: sjZYuLN1XjPQOfSRq8yTOoK-Ug0SAisl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDEzNiBTYWx0ZWRfX2XAhyCNxCPGU
 2rMNaALCOYNoyLfzkEW6GingIC/kFMv+v1yexqHxN+6fihbAVOF6p8be+vJY5XsYQffHWWd3+ab
 vCwErJVSN+xceCbEXghfLKB8UaLZ0ze0jyIHa72kenogEJ1qj+NNsjpSmOeLuIC9b/5GXhDCOwc
 h9rgC7aZTW6+QkS3+3r7ZNLNI2SsAxlceV30eHlkPVmgIT6L/PvtWkzXiCvlzihhj283W0S4Rq9
 IlDAfu6bmI8tXf+FNylDSFvqo5Ia3KH1QWYhoCOaSOSamrg4jfR7xwvEwYCyMMySY4dITxOslRT
 XNlJQRM+SNoxEL8SdtZyFOvwkyT/fNi4gAJ8Tb2cUCRZWQTFEze0L7R1NneuFKqtQaXs1l16XYE
 mcIifRpmrdMX3D1ys+wwkiLWN3Dn013rNkv8DHV5e7AeaRcWOacpxmkjoEDVumP4Lw6oToH48xZ
 65KkGBv+2MnhpFF5BDZaQvjB14RTm6GbJxY+sDr0=
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	TAGGED_FROM(0.00)[bounces-74691-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,oracle.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0CB9E485F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 05:00:28PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 20, 2026, at 16:10, Lorenzo Stoakes wrote:
> > On Tue, Jan 20, 2026 at 09:36:19AM -0400, Jason Gunthorpe wrote:
> >
> > I am not sure about this 'idiomatic kernel style' thing either, it feels rather
> > conjured. Yes you wouldn't ordinarily pass something larger than a register size
> > by-value, but here the intent is for it to be inlined anyway right?
> >
> > It strikes me that the key optimisation here is the inlining, now if the issue
> > is that ye olde compiler might choose not to inline very small functions (seems
> > unlikely) we could always throw in an __always_inline?
>
> I can think of three specific things going wrong with structures passed
> by value:

I mean now you seem to be talking about it _in general_ which, _in theory_,
kills the whole concept of bitmap VMA flags _altogether_ really, or at
least any workable version of them.

But... no.

I'm not going to not do this because of perceived possible issues with ppc
and mips.

It's not reasonable to hold up a necessary change for the future of the
kernel IMO, and we can find workarounds as necessary should anything
problematic actually occur in practice.

I am happy to do so as maintainer of this work :)

>
> - functions that cannot be inlined are bound by the ELF ABI, and
>   several of them require structs to be passed on the stack regardless
>   of the size. Most of the popular architectures seem fine here, but
>   mips and powerpc look like they are affected.

I explicitly checked mips and it seemed fine, but not gone super deep.

>
> - The larger the struct is, the more architectures are affected.
>   Parts of the amdgpu driver and the bcachefs file system ran into this

bcachefs is not in the kernel. We don't care about out-of-tree stuff by
convention.

amdgpu is more concerning, but...

>   with 64-bit structures passed by value on 32-bit architectures
>   causing horrible codegen even with inlining. I think it's
>   usually fine up to a single register size.

...32-bit kernels are not ones where you would anticipate incredible
performance for one, for another if any significant issues arise we can
look at arch-specific workarounds.

I already have vma_flags_*_word*() helpers to do things 'the old way' in
the worst case. More can be added if and when anything arises.

Again, I don't think we should hold up the rest of the kernel (being able
to transition to not being arbitrarily limited by VMA count is very
important) on this basis.

Also I've checked 32-bit code generation which _seemed_ fine at a
glance. Of course again I've not good super deep on that.

>
> - clang's inlining algorithm works the other way round from gcc's:
>   inlining into the root caller first and sometimes leaving tiny
>   leaf function out of line unless you add __always_inline.

I already __always_inline all pertinent funcitons so hopefully that should
be no issue.

And for instance the assembly I shared earlier was built using clang, as I
now use clang for _all_ my builds locally.

>
>       Arnd

Thanks, Lorenzo

