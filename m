Return-Path: <linux-fsdevel+bounces-76741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMgdGCkximkPIQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:10:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E2D113F93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF2D303CE10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1C41B378;
	Mon,  9 Feb 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TnbLqKcs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y35bQm/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3B3F23D7;
	Mon,  9 Feb 2026 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664159; cv=fail; b=foOlEaPdAeFZP3cPXM6xrQhs2hGfxCIRUIdQZOmfYl3CKeE5UKl/uLYpC2C0DqvMWHOkgbaMfQ/zNrXluTgoVqhySPNXnnl8RJMZcM0wawljRbZsg9PdV9ey/VgWsNsi8t9WLekqDbjmtcf1dsnRco5Bd2E+v9IcHeg7L+vNYB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664159; c=relaxed/simple;
	bh=/LpEE88G3TCseqZc4mQOAt1TF8xy2YOV1YphO9Fd+Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bb0GOX/naueQi6LMDGVkIyhB0tVDm8sDEopCUINOE9rgOqOjhJdK8W8Z1TE58a2R68lEwzDBwm7MaS5/1856YAzycjAG/0NWE9jcXrKO2r7vHF2sD5PkTumhBY1G7T1Hhnh476gC6kSqUvI8eTm5RtOYx6gr92fJGeHd9XS25jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TnbLqKcs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y35bQm/5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ED2DR1150033;
	Mon, 9 Feb 2026 19:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dnRK64qv0yxI2qJNLn
	fSSsJXkH8X5B30WaDIg4d4mHg=; b=TnbLqKcsxoIh6wNN9FsN1/xhiJS3LM8S+C
	Y+xg4hQsYI/PX2cEq5NhM1vO4zrhk0x3vPa15SD32vWPseTTP9mtKFxT8yAfXaAu
	pMc0YpRUdFPceOPL93f+MvREnNe+S8imJhP3WJlzH6tc0AuzvpbOKDAv20KFJhGj
	/nyKcg6MDorcys7jKI0j2nbrQUXASfqriMGSKGfv82BJS2YvNptE7CwrUPjsG1jz
	aMZ7ox1otctH5rM/LMMEfil78UGwaXrX48/olAroXZ6u1hu/zdYw39Kx/hv1vviQ
	hsU7Kufpkkvjyj8EnaI0jLvDCtUKmMGGi8u2jAzevKLSV8VjiMow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xjythxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:06:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619HhbcH033641;
	Mon, 9 Feb 2026 19:06:37 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c7ctxv5ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJyppj4lDCyeJjnhB8/zXlQ7UQihjC4V3JPIPJm7EbtRRwQSwqANgNXvmBHHMdsqulifO15JtcitO+sSZj2VyO2Pi08W4Owni42qNooxe/dDVjCMjF4pfrEb3J8NXChpKNIm4Ro0/vQnNaxx9J6N7N5nK2R78aLumsJHyZY049Zncsp/V0K5AJAECuaPxbJkFqOCRQAHo42GFOWs3SK8b/fElnerTzakZkYbQ3c0I5ceHFD1Az6Zl99nrA5moBt/jGs7LqAQkknCwKnn7B9cnduZ3AqjN9HfUO/dCbBwjtjIZSb92qpHMowG3zUfavzWZzQB1JHL9VZTd32gbq24cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnRK64qv0yxI2qJNLnfSSsJXkH8X5B30WaDIg4d4mHg=;
 b=MOlT/QuDv/V/25+YLB740Kin+CYDDaKl+L4trv4mGDN8XyfGLPAom8dB09Nfra+1n/3bkhJE9HBy9fc6Hrj+ZTJxU5meZRhGyPJoTIePE+rQEbQFhC/rS9hbJSX13UStufCT6fXvRRz0rtjEPwW2OJiD3Idccp7LwmJnGKU8CIPXHKrFY2/SCzpKt1mu7TeK7S5DSduWzadpAyNzFkq33gpF8MTS+pfOzzBB0kgRa61BCALICZMQV9l+gMqsPn7OX/pXYkEjFEaA9OnF3p/CiubP0T1L/Ojkc5OIH+H552Y9kxRoExQ4S4VHZt0MF7pNwzzvYKY1BT0LzTTHdLJ6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnRK64qv0yxI2qJNLnfSSsJXkH8X5B30WaDIg4d4mHg=;
 b=Y35bQm/58C4NmpiYSoO+Pi8SibP7Zj3vTrv4R2wRyV7Y/9bgJB0/J0IBwIzZmL3mUy+1ky31b5CqXN+N0fLnLHvtfaZUKdpnjEQnVnEpNzTGk6rrckU0ZUWGkfpwqJsKrl0TA9wIdpCfDquG33dO54cHRZreubhBCRmoUj4VK3o=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SN4PR10MB5608.namprd10.prod.outlook.com (2603:10b6:806:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 19:06:29 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:06:29 +0000
Date: Mon, 9 Feb 2026 19:06:18 +0000
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
Subject: Re: [PATCH v2 07/13] mm: update secretmem to use VMA flags on
 mmap_prepare
Message-ID: <6q5m5tld34onhbgwkjno2g2xqapwj2zlarcfub622xf6vxemsf@opelo2x4fvut>
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
 <a243a09b0a5d0581e963d696de1735f61f5b2075.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a243a09b0a5d0581e963d696de1735f61f5b2075.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SN4PR10MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 958eb2a3-8153-4504-1393-08de680e545c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?frhrDhhP1x+W6+AQW53ZDwKgBugBerMvMnMY4IaEPhyCl/BM46mS8GMj0ewF?=
 =?us-ascii?Q?KyidcGoYHQ2Py/ni7s+DAU3pEuoi5Rg13ytqxB8bjDCppsV8NUiXSmFtjr1l?=
 =?us-ascii?Q?9axv9ErieEQbe5TI2ROKphLMrzvv3yjxDUVp64oZ3RYsm2eW9rNbrprnpBqs?=
 =?us-ascii?Q?GmQLspacrqRtqp3pHtxBW9SFCogyXthxcwBR4JHw2sLIegfoHSM4SgSiwbur?=
 =?us-ascii?Q?FaHHpa9DlS0piB/iVbm3IKAB5NgqIBjGfB3T1hLvLa7eARzCZmKYyJ/rutDL?=
 =?us-ascii?Q?MGxSBCNebhw6zieevVQQcGY/TwleXrJt+X6mN2kGlj6N8LuVk3O2pl30PwZK?=
 =?us-ascii?Q?7818hgYiEPgs+APB/ZCZ1Yh7xVrvlrz+GeRBA5GlQcOSMqvETPmrFG/dwSgk?=
 =?us-ascii?Q?uAHPTATtcgZqAjEY7MeHKx6oZGG01c8ysVXHqt+IHxhS9wCDJ0KVrQN8Moa8?=
 =?us-ascii?Q?F7XJfQRjBjBLJ4sWa28nYG7DE4lbHrwVsyzCuk5+vYpS0VpwMi5qr6sL6Ri2?=
 =?us-ascii?Q?Jqlh4maYs3Qeb9tOCcE0XX4DYZ/WziC7tM4AIiBBaNU/GVPKmbFjcl2G5m0j?=
 =?us-ascii?Q?YZQX6SAZPWvkCOWjTd6J+Kbkv43XPK4fNF4S++/qm/afRlTvBm58blZ96Olt?=
 =?us-ascii?Q?mYIa32/hCvj9YPguJT+eHvKOXz7c0yA4QMvqndH3RaUvzAglGrEhw1BiUTCV?=
 =?us-ascii?Q?sOSlmbsfx4PjxNI5QCqBEL1bALOqESdVwZ02tWVET/9LLKR0U63kGOgx9BQn?=
 =?us-ascii?Q?PCo3Q+xTxfuCOvwmGuc1O12el/Ft4ZJaBBHXkuoPIn7/WikMwnW9Oz0X5FuW?=
 =?us-ascii?Q?onNXuDWYcWIvS2a45QHkvMxzfzoEojzhZMbN0GhiBJhOZVOX1jaH2Bsoue4j?=
 =?us-ascii?Q?JPYbux8ZmsVrxzfQxJ06WKYDTxbACtFrCxpdyAVhzGduqnWgahq7ewFGO2mA?=
 =?us-ascii?Q?/KXgX3FUTqQ28UAo1RxJvOo5L7BWS22EoQ+4Gx1bq39CAJ/Tj4HxlG9G0uC1?=
 =?us-ascii?Q?qlvDmrjE7Fb8Gy+x7oave8j85pmtld9VsSjvBjvZmKQm4r+lH6oRIYNzJCfE?=
 =?us-ascii?Q?2dDNNG84uk0Lx8lq4+E6GYM04Ib1jL0oSsdxdagvqeFnZyLXky/1dhSDCp6Z?=
 =?us-ascii?Q?BU726siFnPLXSJbG7zEhCQ1Oi7S/lbONmO6PzbkJr8ioX7K+ohl9bxo/GnMv?=
 =?us-ascii?Q?8bHkRRfq0e7Qqf22JSZJ01Z6nLU4GZybRDewK5Lxg4JBM4TRxXg2J61olQQQ?=
 =?us-ascii?Q?0kVm8Bkolj0eXTPNBvBGJV2ffSUe2wgKMD/8Jt31W7GYq/ir3eiq30qQgqpD?=
 =?us-ascii?Q?3nCdCkRwtDjEEFqrqan/1VdGNaEOpCOnuNyhj3vLtrQpCOgD4pJVSa9AvLcv?=
 =?us-ascii?Q?w3vMZoDLKKp2iG8uyfBL/mmI+Km2RC8pYXs210HGZ/+upyN2ycBrF2q5oQYS?=
 =?us-ascii?Q?9E+2X/g1PVbV14JNR3L8Peq1oKgEjH1uu/8AaFYc3R334RypCzktvFT9gNJe?=
 =?us-ascii?Q?RkEgd4yCAKmzxeuE/KLFJ2Rt2Zde5a0YhhMe3+6IyzU9LFF/RB6xiOnagte6?=
 =?us-ascii?Q?TIdi8fJIeYEVD8opj7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZYbsgRE6ARXcnpmlF3Cw4JtdBghhVO6YMWF/FVgrHDwYWA9tV7LKsA0HxDT0?=
 =?us-ascii?Q?po7WdHrqOTIp3X6fg6iwUdMpOT/dUnJ1yNwNYjDtqQjp9bpxmcqCNh8GMpBc?=
 =?us-ascii?Q?UezkNdSqvBCt9pBrv6DvpOT3OiczGIrk4Uqv2m0KFFiZTsku0QWrSoyDnoL8?=
 =?us-ascii?Q?tLiZxb42LTA2cN8UlmAFbvXHntP5kJfC8I22u+d+nigGg/OVfAXJyrpIb3kS?=
 =?us-ascii?Q?vBDjNBFXwKMGLlRAbQr2eS3Iu6EKaKrkZ7JNKf+Kxks/tYmo7Hy4453PP0Rn?=
 =?us-ascii?Q?dHuHQgbDle3aEdOvodl3WKKmBg2zBRdNxt6leOBXFDnDcVI/nPlXPpC8oB+G?=
 =?us-ascii?Q?oSD9Wf+nAM0ei/9iLFs4uD45RtPhoNffSCJObFUwGFgXLX3CmQkhSYmUvMVc?=
 =?us-ascii?Q?X0UYq9daisLT2zViXp7psjhd9Py+zgFq62qaDQEe8ZkCuJxo+mCQroTufUp1?=
 =?us-ascii?Q?RjI7ZL3aqaIuac89vRbsrPT30c9iih27gAsyXB2KN+KMaVVUWxq/e9Uequu9?=
 =?us-ascii?Q?TXJDZlxBfag/NqoWI0Ub1DXvgqKFG0kvXtqr6snSJs6Qtnr2h3iLANI1PMst?=
 =?us-ascii?Q?7qt0cmiRFBa66srEVcw78JEWcs04RustDBFQBTWZLHqqGlNLFQgYxnS70jhF?=
 =?us-ascii?Q?Zf6mb8AISVn84B2zTB2fU6Fe3Tk4v/QCbZnKyFyNBcoGTU2gFTMbWd4vpSjp?=
 =?us-ascii?Q?dAgK1vZnJSy6cVBXVQ1eH57zIOadSJ0s5ifntjjDPFsjXMWVx4GU9gHicn9P?=
 =?us-ascii?Q?XPiXWkwfs24sOcuf/wukHLKl8BQpCEkqlq9X0PbU5qyNr0+2KGF5KtZmDwEI?=
 =?us-ascii?Q?tfyxMF9tZhk7TCpOZBUdVyr60Jueu0bORxOOJLVkY1QDmkcCSGTIg8+t/WrX?=
 =?us-ascii?Q?/A9RATlX2DJzlN/PlgAv5a6iPEzKfuU8OqUiCq43ouLyg+RjGA8N5Aw3kGbo?=
 =?us-ascii?Q?GuluRNYVG79pwFxkylU2VbogfFGZcSIUqLAwf0xIHfLRqYrZ/icLf5LADP+z?=
 =?us-ascii?Q?G0j835YKdbE7hdbItzVleXhoWoToYXntX+QXMvh4j80lLXfGDfunDdFewwgV?=
 =?us-ascii?Q?Ww8Iua6PFrjgc0GkQvHc6N3bGHro3CE27mwEkb2O3iUbLekpfaNXkyvsWlFi?=
 =?us-ascii?Q?y1eYIPH2TPrLwXa+RKWWY46K9GA650ByevoEw2XRogzBHqtGMiwIhbX/D3Bx?=
 =?us-ascii?Q?9yWXXnLwTF5qFHSOQAlecA7DjNyqSMoNYF2Vxj5360J0TX1UeG5JQ7FEp8VC?=
 =?us-ascii?Q?BaGNcanLACrRafo/CjpJZ/B8E1tO/qzGk9mQYZD80yuSU2W5Owpo6Mgq+wTg?=
 =?us-ascii?Q?Lcv6i7DK/son4U15/w0vxeBwsMk2INJ2p3pnJ7rxl790MrANvmhSRkAVb81Q?=
 =?us-ascii?Q?vse2un3ehh+VtQqgKT4MLSnvrWvDfYQZOn1iUaioIUF2P9qtl/qLcvACs46v?=
 =?us-ascii?Q?SUXSwhFuHOTSw2++6z8fCqLF/oMnGA0uy6JA3e918zomFWOX9QKU8vajjLdY?=
 =?us-ascii?Q?Lz3wxpyRzyOtLf79tTIA7gs/x6ZLU61gH8Rfrun80u96P9BGr38f4wVbWafg?=
 =?us-ascii?Q?KmNjDRfOKvNS0Y1XC8jc28PXQkTTEPFwKRPyb1/jU11Tlc+3/7da/GpvQPxT?=
 =?us-ascii?Q?fYnIeg2NrJ+lJiERE51UyHwZv2oBGtaalQQOKz2znYf7WIb0C2pnal46OTfk?=
 =?us-ascii?Q?8XrguVJlf+KzNOMwR7clA6BJ3thBZk+/W7v5vfyOzjsRi+DztmSTxWgo9SL1?=
 =?us-ascii?Q?p0AqxTDZbQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xuEwK2Un/Ln4X9YlC3p2XymZGZ62uk/yvYl8b/bevsT/sBUkogbvNiQguyPmdncnf6IT23e3zsh6YLxzfJIjNTsnjtY3D9o+1AaUUbo6Bb02tVQcd29J9BscvZcYejsPLt4srWQhqXQUyV3iYrFlmfRXZMDqttUTU9mzrd96QdarPf00HD5AcJEjR7c51Ib29PDm0NIbBWdMAch0whZyt4476dLgWk0Rm/zQ9iwgNwpMHY2I7MTKXTV/+qSXcvxsGVedEoxwdFKsVdjU2v1s9qRKzf31MZ0lkBCrtW6s6pG4HDInrWs75+PUuQ9xgfTFrpZU2oH45cvU4OZqzqsBJAiMo/kH9kKRxF8X+rBSEPRflLWEbbnnUpf/fmou8eGGJ9IxPTs70Kotfq5Hm1jxQ/K2l/idatr/WHqZ2c3JQGeOeaPajzBX6H1pAwvCoHB3PrxuswEwy18eA9qOOhpxIu+it9BKELAlv3sbH7nDpTkwG4CHEO10+mQZ6t0bvC/cF8fJL/Uvf4mgihgATPFVBsDBVmVF//+SCmQkH+pf5vkViX+q29Il2UmVMQnyJMvo3p3gIBHju/f+ZQnOwoptHSeoRF8q+b40Vcx9ZcuBiyk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958eb2a3-8153-4504-1393-08de680e545c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:06:29.0489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l72H3Vb+n6N3Sud2k+zjJKI+dcyhe1YH/0bQ6ZKSpeUqR06S3kASQLhDNHZj3fU7fw0Lc1fJagB6mGAVuaIJAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2MSBTYWx0ZWRfX91mry5ry/gBo
 k/l0DzIyfpI2cO5QPpSrSVV3LtQUrprVTZt7xTqYPEtPtVhGhsbnqayg1yzZZJSnP43kuBIbxNh
 C7g2HBt73+6vzZBE+mlOCULl0VpR/A/r2qBk4Za9PnLyFfaaz/mRrRGPoEADjNvL0nbuIo5+7zI
 SwGi+UY9yy0WBj+Hkl1UP1rTSSz9l0ELL2sXQWXnSwb+FTTw+/7OlEFRC5NSRlAS12Um8Ctktx5
 jN+6l8qpMEtxFf83UC96i9Sjyvjn3ILUU1Hdb81xmuxgBH2K7vSmndG3lXv8uijsU3iYUAmCJI6
 eaTd0TJtA5+WuXaGF4lsEHYIdvDhGVwxZ2pAmhAQI0Fjr5jBpy0dR8hupkfSyIRUlJMthbRyN4+
 xSERtlOagxz4BoOHQvz/Njo8bCJ+BvSAYa8YjZSbpYdrXSrZx3+tqC86NA0wdt7Ipc8oBQYQ+RO
 /aknsdQ9YTS674niqhw==
X-Proofpoint-GUID: nelCH1YsQ4RlLVoBgBWlpx50FE8xSlzN
X-Proofpoint-ORIG-GUID: nelCH1YsQ4RlLVoBgBWlpx50FE8xSlzN
X-Authority-Analysis: v=2.4 cv=VPLQXtPX c=1 sm=1 tr=0 ts=698a303e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=tbHv_hX9IPuTo63G16EA:9 a=CjuIK1q_8ugA:10
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
	TAGGED_FROM(0.00)[bounces-76741-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: A9E2D113F93
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> This patch updates secretmem to use the new vma_flags_t type which will
> soon supersede vm_flags_t altogether.
> 
> In order to make this change we also have to update mlock_future_ok(), we
> replace the vm_flags_t parameter with a simple boolean is_vma_locked one,
> which also simplifies the invocation here.
> 
> This is laying the groundwork for eliminating the vm_flags_t in
> vm_area_desc and more broadly throughout the kernel.
> 
> No functional changes intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

With the type fix for brk - I assume sparse would have detected this as
well.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/internal.h  | 2 +-
>  mm/mmap.c      | 8 ++++----
>  mm/mremap.c    | 2 +-
>  mm/secretmem.c | 7 +++----
>  mm/vma.c       | 2 +-
>  5 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index ef71a1d9991f..d67e8bb75734 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1046,7 +1046,7 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end, int *locked);
>  extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
>  		unsigned long end, bool write, int *locked);
> -bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
> +bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
>  		unsigned long bytes);
>  
>  /*
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 038ff5f09df0..354479c95896 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -225,12 +225,12 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
>  	return hint;
>  }
>  
> -bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
> -			unsigned long bytes)
> +bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
> +		     unsigned long bytes)
>  {
>  	unsigned long locked_pages, limit_pages;
>  
> -	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
> +	if (!is_vma_locked || capable(CAP_IPC_LOCK))
>  		return true;
>  
>  	locked_pages = bytes >> PAGE_SHIFT;
> @@ -416,7 +416,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		if (!can_do_mlock())
>  			return -EPERM;
>  
> -	if (!mlock_future_ok(mm, vm_flags, len))
> +	if (!mlock_future_ok(mm, vm_flags & VM_LOCKED, len))
>  		return -EAGAIN;
>  
>  	if (file) {
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 8391ae17de64..2be876a70cc0 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1740,7 +1740,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
>  	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
>  		return -EFAULT;
>  
> -	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
> +	if (!mlock_future_ok(mm, vma->vm_flags & VM_LOCKED, vrm->delta))
>  		return -EAGAIN;
>  
>  	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index edf111e0a1bb..11a779c812a7 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -122,13 +122,12 @@ static int secretmem_mmap_prepare(struct vm_area_desc *desc)
>  {
>  	const unsigned long len = vma_desc_size(desc);
>  
> -	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> +	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
>  		return -EINVAL;
>  
> -	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
> +	vma_desc_set_flags(desc, VMA_LOCKED_BIT, VMA_DONTDUMP_BIT);
> +	if (!mlock_future_ok(desc->mm, /*is_vma_locked=*/ true, len))
>  		return -EAGAIN;
> -
> -	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
>  	desc->vm_ops = &secretmem_vm_ops;
>  
>  	return 0;
> diff --git a/mm/vma.c b/mm/vma.c
> index f352d5c72212..39dcd9ddd4ba 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -3053,7 +3053,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
>  		return -ENOMEM;
>  
>  	/* mlock limit tests */
> -	if (!mlock_future_ok(mm, vma->vm_flags, grow << PAGE_SHIFT))
> +	if (!mlock_future_ok(mm, vma->vm_flags & VM_LOCKED, grow << PAGE_SHIFT))
>  		return -ENOMEM;
>  
>  	/* Check to ensure the stack will not grow into a hugetlb-only region */
> -- 
> 2.52.0
> 

