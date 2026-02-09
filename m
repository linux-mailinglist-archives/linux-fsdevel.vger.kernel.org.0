Return-Path: <linux-fsdevel+bounces-76748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIlHLes2immhIQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:35:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B0114276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A38A5302D099
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1B425CFB;
	Mon,  9 Feb 2026 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j9Ny8gdH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PMAl0Xf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AA38F223;
	Mon,  9 Feb 2026 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665666; cv=fail; b=skD+OzVmxKVObp1I7UheBkTPfiP9ZlQkdw+oLK/kaPQpIyWWYby+NeBSCc8HogyvgaJcVkc5gz/2t/SytoOLbyKk7w+XPWXdM+iHLgSe2I0nHFOf6F0hmJn9UDBo5Zv7r6fpfrwuk/fDZMIe4N69knrMibtmg9Zp+y4DgQBkpqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665666; c=relaxed/simple;
	bh=AePakR4o5mnGBkNZBNva9xstFl4Z7QKEAdLc7H8j8pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYG1NgJpelc1/NP2cJVCcnCmbjDUTpepk7svRNwUigH6q3q0cin4GtCM+JPDtOroXuzcfaIgFNKlnS37BwLs63MCV6e3t0EpBc8Ux10Tek0MMufIQDNM+eIRrjqPnTkwkOzpiIvIC2RkewRxOZqbcmvq9CnMYFpQj/UBY2G1IWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j9Ny8gdH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PMAl0Xf4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECXic2021204;
	Mon, 9 Feb 2026 19:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IKmr/kWHgu6MoC30Ij
	xLGIQVphVlYFMT/wSyOrKMfGk=; b=j9Ny8gdH9d5OOgAKt+icoy4Qq0XPydCQ+Z
	gwtDe1IUeKHPrCuHIXickqk1Od2oqB4IRrWjQExZA6mW8Eo2AlnhrjwM0uk2z4ru
	iNjgJg+8GjO8AnDRJ01Ln58jDy6oEITW6zWsm0JMqba+20x9S0wJ7XvMgXxB1I1u
	T2sXu8BTq3i5XsKCk3jpp5bp+tGPxraJgcldWbhlZkcMFs+eXo5MxeKK597sLSNj
	NsEFJSHth6dizqK8qgkluz6O+v80KWs6YDZ+7slEEAboxJ/atcEdlhBCnh2JA1Hc
	GjZD86vaHkcgzH4xje15BfJfuj39bgddVG7ZgmMsyAEze3DurYTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xfp2m5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:33:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619HgrBA035379;
	Mon, 9 Feb 2026 19:33:38 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu9fw0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dmi0IG5hEMJwjWp6ABxQpnLqImhHSoPW1iYAd+0oqMmGWYBa9TlK3NaNvdM7B/xxGpEATDzY2t83Lg8eDxtngPTjdFJTTwsY6V5gsPqroIbCcNrJ3lOudBcabQEaLRlTrNo8eoAiXCxMtiaA0ZEMsD1E9gYki65BiRK2Wll/LNb/H9cDb8NY2t8ED6FlQQ9nQ7HttHen8/iZhcgEJ+BRO0tUy7hAmvWiMBy2d5lqY6hg88I8WHCSJuIQCSh4o+qlpVgW9GQ6Pl4gEalgJ7nSCk9Ynx23IbpO32w+ANfrQUDqx4ZuD0JHlvtUvFO/gu9ybZ1gpur6h4CSNp6ulzuF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKmr/kWHgu6MoC30IjxLGIQVphVlYFMT/wSyOrKMfGk=;
 b=qmTJ8Eb6UpaxKod3sJbe1ki2hFxOxuSOjsqidSizcNI+W6HhEz3A3tnFVUK/1nGhz3ps8QodtXzfGVdLPTpjPQOIEoUT/hHrW6xTCSJnUK+2pDP/y/pP+II8xA2x7K6bSkaDWJbOqIvrhLRKLEIVYrqsvkwOxb6gtSmrigvOptTQ2runH3gvifGRPwKqYGgVsHpuSeov4lcrjPqNmLKXCXX0//1qYE9VWtMeaMCSDY+SjdcijVbQBte8ozWMScG7B4zPeKpGfFtbEgo/TNacpOYOdT05TTTV4zs6DSusn1uFNcXS/UY3J04QgaZKpae498Z8S+pOrbQlAfr9ceTdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKmr/kWHgu6MoC30IjxLGIQVphVlYFMT/wSyOrKMfGk=;
 b=PMAl0Xf4uCC4irCyG+76h8Xjw84NRjESXMk1sIo4KkAVBaE+ddu6zQ3tWk3rNzupVcfcwdmFuTfHyhF8xmYF4/KEmLagsqeYYL8O6jVhWrlOrNjEfioqso3kHNx5G+o1oc76byN5pGadpTNDPCgmZSa8VJVn0/tqYwinLgFZFfs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 19:33:06 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:33:06 +0000
Date: Mon, 9 Feb 2026 19:32:55 +0000
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
Subject: Re: [PATCH v2 10/13] mm: make vm_area_desc utilise vma_flags_t only
Message-ID: <ty6kli66kwas3hhzfbbux3mavl6dvi4us5c4bjhvp3m3ziwqxd@kn4sfnkc32iy>
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
 <fd2a2938b246b4505321954062b1caba7acfc77a.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd2a2938b246b4505321954062b1caba7acfc77a.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::9) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e869cfe-424c-42c9-f355-08de68120c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LNwxEEzndWMepF8XLtLJqB56suqCrq9ZwBx9jh+otYrRfPqwxnVpIJkIDasu?=
 =?us-ascii?Q?HQVNM/qZpL6QM1cb/m46+lkm386//MxvcE1cjhGYIIp3bhBgxdZgOt1g01OZ?=
 =?us-ascii?Q?qhRXN4J4pdIDAisl+c2CsPLF4dC1VlilVH157IgvpTGxtUCFw5xP7htedkCz?=
 =?us-ascii?Q?w3z/3XqiK1zgFZWhnmAAXOoWSBXlWSZZJ4Bt8VYsbKbr96k35I6R8Qx7YMMi?=
 =?us-ascii?Q?AvlR7KjX0Wsgzz4fsiz4gm/QJaEHXhFqBlmj9vyZqtF6SXqmuf6SNwL1pzv7?=
 =?us-ascii?Q?JFoy2olbd2rRZeYYM83fyAQm8Hx+ZFpBeoWssr5NpNraiJfTDBonu+v2oR4E?=
 =?us-ascii?Q?KTs7ThzAwYDMbr8wDCsWKuCXSggqLFlDcLyLsdmTI4FYYetPs+ttsNJfPXtO?=
 =?us-ascii?Q?2+e/gX3kcZNPvHxIcSOvgHL6afsSmn5E78JXGyNuxZes0eqajH+FCl8tkn9k?=
 =?us-ascii?Q?PzUK07QhCsYcpvoFvm3I384qoxVz8uIp0NCrms/K37RJ/awacXaY+8r4Hnrm?=
 =?us-ascii?Q?fNZmmVPM5eISqut+Yn9zxbY6FAOvbnnVUrYdCPLAf2oDGG0wrI8zvwxI1JlR?=
 =?us-ascii?Q?kxVJLEjRvmXHsWJNFXDLAciYPxHomIRknwM4Q8bsPz7fpR2jjfB3kkhQRkbc?=
 =?us-ascii?Q?vYvmnnTBW9mcuXk5o6VHLBc4qZaVmiGyseyLd39GHeO4LMvnAwhkGVLlZ8O/?=
 =?us-ascii?Q?hzq6xjYSMCDRczAYpP4BJzoOtO3kvf7hS0LYeHEzlEzF+PRt9BG1IpROP64W?=
 =?us-ascii?Q?FTo7NvjXzl7oIS74l+5FG7Cn9C8gMB/Mkvk6rl1wUQvE6Lc1Xb0cxrX+gSCT?=
 =?us-ascii?Q?VBZMOjR6JR0bWGuZkjWMHXcyCYKUuM1tuw7md9l7yhQwC90vnaL5hMNpsKt8?=
 =?us-ascii?Q?YqGCeSpuYp+WkTV3aScoJc16lvyHJ389uGPyb8avwR5DCNYXx3BZrT4Vvlu+?=
 =?us-ascii?Q?ya2aPmq3cDZXnt3vYaavzsV4aM7ZMzzys1SiYtCOnSXA2h5vgMczoaGyeVVn?=
 =?us-ascii?Q?OyfwH3I2NSMTCqprOTOANkeM8Ut+8MN7PFQzngGZbg6lpYnJHPg36492Y8H3?=
 =?us-ascii?Q?Jv8qOe/ZZbsRhjoD/HBZ1ETxbhArgInD1WJTT6l/dkUMoAwdaBFqWBvYPWU+?=
 =?us-ascii?Q?LTY/niUNDYC+KfUYTeuj8HhYn7DSo0B0S35OQkFj1DquwSk4i3K+UVt204Ua?=
 =?us-ascii?Q?/hqL4rRnyj0+GJmCbC5kP6co5kVaov93YmzHtdIPssfe4HC3XwdxH6o7SRlD?=
 =?us-ascii?Q?XfFX8H5gZDzlgj17Y8/EcfbgDCKIOGeP4jL+TUOf+gqb1fl81eYA6qyEYTOg?=
 =?us-ascii?Q?zwWN+tNa5ViznSf1qqaMvO6QoXI5D0E/pV1ojp+POoBpjyMBnH+8qImUkwfE?=
 =?us-ascii?Q?O3yPikmlvNJ58PRNmY1A5jQV3W66tBEn7IcrvEyGeoKqAGRFXBlprooe1exR?=
 =?us-ascii?Q?u9ZfvP5RL1GQbnz0Au8l56VCIgJO8Rt/Dw1MqsdGBGSXKORPAgKbAlWtPnzS?=
 =?us-ascii?Q?S4TDWdQqBec7gOOXgYuHZY+fMGVAUtWPYMTh0euAKd2bgK4nxOIkTQEUmwpC?=
 =?us-ascii?Q?ZMM0OnJ8czpGUE/1r0E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O45GnaDLc71TtDt61X5NqE/E/YRSMJoCyF8wxP/bPjPPUR4nfPRmdUxqAo7f?=
 =?us-ascii?Q?0Zp01ZscaD2F/1qVQFy9lB5l9EWBny688r5WE2e7TWvSvQiU9DuxbHAQEJP+?=
 =?us-ascii?Q?46UEbvxg9jLRnpXSVkUfvxkKiyhCLARs6IsBl4FBAqkjN+ysWrKGNgCaH88O?=
 =?us-ascii?Q?dfHOqwFcNkiTW8MbjkX8gfcECmQpP9VZJO9UVJ2mlGLXjDkEVYBPakAX2yYX?=
 =?us-ascii?Q?xVYw5vibZbEXE8D2lrTF9GXB59ran+ZVu+BCd/kwJhHojuhvKdmLmtqfReEs?=
 =?us-ascii?Q?wtxW+NCDm3Fwzzn1Q/pOMjvx2v1SGgaH3m8vjbMmspChwxSooyv7UStRS3lN?=
 =?us-ascii?Q?C9WK+f9qp1Ve8Nx9pXjrKE1TtQYIVjge5Ye4uhl+ln0WR0KnoMFFZyyJnih6?=
 =?us-ascii?Q?gkqK7PWO371ocQHZk54MB1TdrAtXjhpR/33G0bYT1oDnyi7kk0Fv58Xxg0ic?=
 =?us-ascii?Q?wjNgn5VSgYExn3NcHlJnyfgPF42E8ndjde2IlQXRHAwtD5nvjsztwc2CkFqp?=
 =?us-ascii?Q?52uYOPeD9DXoXiPqdgPrVkWBLYzSEkPFm2NRbgghCytd1k2kHd4NBQ/bDKEW?=
 =?us-ascii?Q?KeESBcElp4gnhq0ZUdM9fAkmrKf09C3mda2FpPfIvDvQK3uEHF5otADaFB3x?=
 =?us-ascii?Q?8/eO1St6wbaiqPQIPcS6uga/KdLfYHDfF+zNJll8gSoCjJXqjA3YwX3Zlm3O?=
 =?us-ascii?Q?N4/zmtPPrdIrn7zwsEXjUhx2OsgxTx5Sri6on+vUmyK7/kpJLg1+i+cY3xnS?=
 =?us-ascii?Q?JfwW/zeJ5FPluvMEhwyGHwdUkSm/mMu547CmjFolhtAkrIUH1Px0H8U+2hoF?=
 =?us-ascii?Q?X6x6YWA/N+/fbxjBOmDJsdRV16KbAvCcn7I53pj/dvhjyO8D10Ou9j/ysSqu?=
 =?us-ascii?Q?HCLg2SrYF7Gr5LlJFbZOuKdQbwShqyYW6sHQexZp2LrKbUNDGzJ/niHQooP/?=
 =?us-ascii?Q?BqDOfCBrIo6g338r6d582eJOO3ybgfYupQ9kYSwCy19/byGODGwVNIpConkw?=
 =?us-ascii?Q?RZLFgJzxQ8PxqGjp+AKIb13KWHT6L2Sq1ALu8QdRFOF0qiLS64GyMYpUznm+?=
 =?us-ascii?Q?07F/BQ7uDlLSwxaNx5wIbwhB4PrVI+ITHdkeALs9/DC1Z7mJ3F9fkeJ31ic0?=
 =?us-ascii?Q?tUNK3gKiGLFDIlvBhh547AxFaS2GJ33gYgREm/+w7CouIgKgR11nbJjS9jWf?=
 =?us-ascii?Q?UsKJ9rBzI4YTPjINPVGYMgfIeNjIWeXOwkxdX5dFNCni29qaihfHb+qqqKi3?=
 =?us-ascii?Q?voTrePGZcj146ESlNzDD31cgjBukWzkITRjROf9422UHrfHK/HmtmeK/TcJO?=
 =?us-ascii?Q?QUZZYh2dNsJWRqsxuFnseueOu2JD54ZR9gU9otJVqgMuTO1rtMyGnhAd4FsQ?=
 =?us-ascii?Q?uO6vyniT0P+CQxcICE3IxNWF+RoucRVygFlmBw7hBlfiaZGP9+IypEIhis54?=
 =?us-ascii?Q?GXfvHjKQd9rZjfBza43ab6ITzLSnlRIZ0W3EIIHICpL6GlPth6xfPJH3EN7P?=
 =?us-ascii?Q?VniEKUCh/jr/2rzEKsGjQ/+95kIn04y8pKKLFtE/6XRnly7rqZ/E4IaxBoGJ?=
 =?us-ascii?Q?rnQLNJO5OvTmdHNxmA2Y/nYtd4dAQxYv5wHOutEU0Y8PJFtBMowlvnDR41a/?=
 =?us-ascii?Q?4S7prHVjxoooR0F9CXjPJlOjVLW5FQ8WhANTksrTmVNYGCJZngEFb+UcX6ut?=
 =?us-ascii?Q?W3nWikzHrl5EdIYof15qf5d0ZPhm3w06ZRkcqZjaVdDdIjMxu+sLZF2e8i3K?=
 =?us-ascii?Q?7mn4/p86uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XYC+8blRA9DVbNka5cMNDhZ2b9zhTQcmFDCmC4D0DZIsHwT5HvVZSUorGqHOL7mXx+J8DATrW/BS2aTal2blGvujKHQa0blWtA9nM4RPjX6bSjCqVN8xTnMiaQscTQWgYXDe/KWOUa/QdYTkD68tcPtS9xO+OQgZUbxF3KPM8dSzJjqtyGeJQVf1t3KUQ0qhYh7dOB6WgWfRbrsjES8ar0BO357NUPm9S/2M8URXe1FFNTSCZZ1nx+LqolnWFM1Pgu/s4Tt1D8uFDk8vQVQkCS3yRxLAk7fCyBT2CUYuJfDj0USvdnq6l7bnxAUyGVthgeerO0+C2aBQzWf1E/KJOGBEetBfWP7vZf3+DCeS9LjEO/iYc4h8MFk8TsOsLgz+Vz+g7N7CUMkNNbwlzHm65Vlr4Mu5MwIiGj3nsROWcPqIhZiNCxIBqKWnM4+djQwaxZ23MMnhAUzFMb9qARenDba9+T5jmR97V4BoGOPShEETZEMiGjot3tU2ixcJ4ln+F43d2xQeBsCXKW2ktC39yCO+EnA7pgxqJpOrv9+0HvBnqN0/Yb+iBbaJEESHlpnQoxy5XL5WPv1PP9zMhp7thyn4Audq9vjz7WEFvy6CHgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e869cfe-424c-42c9-f355-08de68120c55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:33:06.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oymhgjfRbzAehacAm9gq8kbHH6giuoZ0Ozobv8N085+v9q6U6aNeNBTGZW61FAt9ZYow6pOi1x2ACTYgQEShVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2NCBTYWx0ZWRfX4hT2i38I9t7T
 /vwdOVqfgrpbls8bTJBhw7NgGkFqKkmyYiWypjztHD32RkVMKPZR/ZhBMobCzJfYgA04JYCD5Jb
 9v6/VWBZ+Sw7kh/O5jOXG8ZDtEbz39EnRhTKUC39P7syvvTHGM7+ErrfNZ6N8l4l8S6hHUNe+Sd
 02xju+svaN6eSN50WaCSphl9cSvd5npVI4k1jGdmcw+RiEn2rRnWD2IHMETiwtoWROY3e5ObpwA
 yTBp6oi9yMsM+CK1q+YcXWEePz9nuCfCCWKIegzOJEnBghJqwQ+9jFGH2RHF9p9NOp6ZCsIIuSi
 IBtdIImMcnR2lpVYETpiql0nw6aDQ7qMObLAv4xKWPWGrvCI7aQhO944hlXZwGxH5NvHqMijm4C
 qvo2NWICzjs2h83xUj5qhuZ8gqQewZXaYOc+AibVxg/to1rbq10qIMHNxjA4HRQifLg6t4vWccb
 txGXoh028pTdFuMBwbA==
X-Proofpoint-GUID: y4i8qwRDC75wLaHSlH82OBUxT2yx4tdd
X-Authority-Analysis: v=2.4 cv=V8xwEOni c=1 sm=1 tr=0 ts=698a3693 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=MgI1wqV417GTJutfrhsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: y4i8qwRDC75wLaHSlH82OBUxT2yx4tdd
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
	TAGGED_FROM(0.00)[bounces-76748-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
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
X-Rspamd-Queue-Id: 527B0114276
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> Now we have eliminated all uses of vm_area_desc->vm_flags, eliminate this
> field, and have mmap_prepare users utilise the vma_flags_t
> vm_area_desc->vma_flags field only.
> 
> As part of this change we alter is_shared_maywrite() to accept a
> vma_flags_t parameter, and introduce is_shared_maywrite_vm_flags() for use
> with legacy vm_flags_t flags.
> 
> We also update struct mmap_state to add a union between vma_flags and
> vm_flags temporarily until the mmap logic is also converted to using
> vma_flags_t.
> 
> Also update the VMA userland tests to reflect this change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h               |  9 +++++++--
>  include/linux/mm_types.h         |  5 +----
>  mm/filemap.c                     |  2 +-
>  mm/util.c                        |  2 +-
>  mm/vma.c                         | 11 +++++++----
>  mm/vma.h                         |  3 +--
>  tools/testing/vma/vma_internal.h |  9 +++++++--
>  7 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e31f72a021ef..37e215de3343 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1290,15 +1290,20 @@ static inline bool vma_is_accessible(const struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_ACCESS_FLAGS;
>  }
>  
> -static inline bool is_shared_maywrite(vm_flags_t vm_flags)
> +static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
>  {
>  	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
>  		(VM_SHARED | VM_MAYWRITE);
>  }
>  
> +static inline bool is_shared_maywrite(const vma_flags_t *flags)
> +{
> +	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
> +}
> +

Confusing git diff here, but looks okay.

>  static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
>  {
> -	return is_shared_maywrite(vma->vm_flags);
> +	return is_shared_maywrite(&vma->flags);
>  }
>  
>  static inline
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index cdac328b46dc..6d98ff6bc2e5 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -887,10 +887,7 @@ struct vm_area_desc {
>  	/* Mutable fields. Populated with initial state. */
>  	pgoff_t pgoff;
>  	struct file *vm_file;
> -	union {
> -		vm_flags_t vm_flags;
> -		vma_flags_t vma_flags;
> -	};
> +	vma_flags_t vma_flags;
>  	pgprot_t page_prot;
>  
>  	/* Write-only fields. */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ebd75684cb0a..6cd7974d4ada 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4012,7 +4012,7 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
>  
>  int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	if (is_shared_maywrite(desc->vm_flags))
> +	if (is_shared_maywrite(&desc->vma_flags))
>  		return -EINVAL;
>  	return generic_file_mmap_prepare(desc);
>  }
> diff --git a/mm/util.c b/mm/util.c
> index 97cae40c0209..b05ab6f97e11 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1154,7 +1154,7 @@ int __compat_vma_mmap(const struct file_operations *f_op,
>  
>  		.pgoff = vma->vm_pgoff,
>  		.vm_file = vma->vm_file,
> -		.vm_flags = vma->vm_flags,
> +		.vma_flags = vma->flags,
>  		.page_prot = vma->vm_page_prot,
>  
>  		.action.type = MMAP_NOTHING, /* Default */
> diff --git a/mm/vma.c b/mm/vma.c
> index 39dcd9ddd4ba..be64f781a3aa 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -15,7 +15,10 @@ struct mmap_state {
>  	unsigned long end;
>  	pgoff_t pgoff;
>  	unsigned long pglen;
> -	vm_flags_t vm_flags;
> +	union {
> +		vm_flags_t vm_flags;
> +		vma_flags_t vma_flags;
> +	};
>  	struct file *file;
>  	pgprot_t page_prot;
>  
> @@ -2369,7 +2372,7 @@ static void set_desc_from_map(struct vm_area_desc *desc,
>  
>  	desc->pgoff = map->pgoff;
>  	desc->vm_file = map->file;
> -	desc->vm_flags = map->vm_flags;
> +	desc->vma_flags = map->vma_flags;
>  	desc->page_prot = map->page_prot;
>  }
>  
> @@ -2650,7 +2653,7 @@ static int call_mmap_prepare(struct mmap_state *map,
>  		map->file_doesnt_need_get = true;
>  		map->file = desc->vm_file;
>  	}
> -	map->vm_flags = desc->vm_flags;
> +	map->vma_flags = desc->vma_flags;
>  	map->page_prot = desc->page_prot;
>  	/* User-defined fields. */
>  	map->vm_ops = desc->vm_ops;
> @@ -2823,7 +2826,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		return -EINVAL;
>  
>  	/* Map writable and ensure this isn't a sealed memfd. */
> -	if (file && is_shared_maywrite(vm_flags)) {
> +	if (file && is_shared_maywrite_vm_flags(vm_flags)) {
>  		int error = mapping_map_writable(file->f_mapping);
>  
>  		if (error)
> diff --git a/mm/vma.h b/mm/vma.h
> index bb7fa5d2bde2..062672df8a65 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -286,8 +286,7 @@ static inline void set_vma_from_desc(struct vm_area_struct *vma,
>  	vma->vm_pgoff = desc->pgoff;
>  	if (desc->vm_file != vma->vm_file)
>  		vma_set_file(vma, desc->vm_file);
> -	if (desc->vm_flags != vma->vm_flags)
> -		vm_flags_set(vma, desc->vm_flags);
> +	vma->flags = desc->vma_flags;
>  	vma->vm_page_prot = desc->page_prot;
>  
>  	/* User-defined fields. */
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 2b01794cbd61..2743f12ecf32 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1009,15 +1009,20 @@ static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
>  #define vma_desc_clear_flags(desc, ...) \
>  	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
>  
> -static inline bool is_shared_maywrite(vm_flags_t vm_flags)
> +static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
>  {
>  	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
>  		(VM_SHARED | VM_MAYWRITE);
>  }
>  
> +static inline bool is_shared_maywrite(const vma_flags_t *flags)
> +{
> +	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
> +}
> +
>  static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
>  {
> -	return is_shared_maywrite(vma->vm_flags);
> +	return is_shared_maywrite(&vma->flags);
>  }
>  
>  static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
> -- 
> 2.52.0
> 

