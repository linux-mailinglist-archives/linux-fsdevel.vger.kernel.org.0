Return-Path: <linux-fsdevel+bounces-76645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OAZHH9JhmkhLgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 21:05:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822710300B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 21:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9051C3036D4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7230DD2A;
	Fri,  6 Feb 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j1D1lOHr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ysMRiNJ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98132E62C4;
	Fri,  6 Feb 2026 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408173; cv=fail; b=eu5tGtNB1xBHC6CKolqpQ+/595YJKHawxfijTdkZnu++zdTdCzTB7ucW5lI5pBsHFCJAKvZnqaJOlXgjOIGFlOs0StGHhHjyGUtJ8zCZG6jtfhmMfImkgntdk8EYAZOzk33g5K6YcAmJHdTGhvZw/g/qdYHVGwE039YsKaj/Ark=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408173; c=relaxed/simple;
	bh=0RErPAhVbGAMrLI8oTOEgW2gDceNVDchy+hsI4HgJV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bwzw1x+NpNal536mxPEs4eHqjd+d1gXN5qVinkDgSsBavrk03y12dLrUGs13VMeageVpJZj7QiKcBi6HgyUinkAUCNrK06wGcbeAYP5VmwDe6TZOoOR4DJYPww/YukTt0rCZ2SFdcwe5ir4tdUDnvuPweOJv4Pb0nvqa8vOAIXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j1D1lOHr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ysMRiNJ0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616JuPO8790774;
	Fri, 6 Feb 2026 20:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IIkdhKlounf8LNIOKu
	57WvWnowqLrOAc6ssJmhwgASI=; b=j1D1lOHr+K7D2iLzkIVS6kNZ3pHKwbrygo
	nabhbYjqsoyNWhCYPqKheYP1rl1smCSyVy5bwlul5n7wVeweVfrxt0GLbE9ioH+f
	vMO1NxVC/eunTPEgphwByAJbAQO0JwBv04ciEiQI/nAcKzGeLrELMHaNvhRfUSpB
	tDJjem8ulMVG18jLTnrY+0ziGQZ7ZKz/FnrnMcw2ZcIgb0SkGdxVLM1Qoueg6UU0
	78lpH8s6ZP5gGr33e6y8+9EsBFE/HdPOzmHwDX0q2VcbQOnkLWU0q5qEbbztCkZL
	NVZlrCpdCKmIQWx8lWjZNlAensS7IvFZwPupnz1uxTRzZQTEHAcg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jsqp49t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 20:01:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 616IE24h036938;
	Fri, 6 Feb 2026 20:01:55 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186f1820-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 20:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuT56QyxkT/9rUu9Um1AjvmlDL2JZ+qNmD+5PdOVU0hOWfohsXmzNklf2e4OV5FQXH8kb1MwEYjqY0DFWDUtOpJvKXDnIx8g07aP8wW8hNjTuaOwD4n9LR57EI4AUqusyGhZ6reXZRJTeJUKzYGfb5NnlSnywNW/tnWlqlLijBMD2sBUROnDJzQNA4lQMQPL+HM2HQ3LKJvM14oV4TUwK8GiaD3iGRcA8PId3ftbFw9zK3Kc8KIei4mPNEo8RysBDnRgTuRDAihO0igYYc6QavJw+u8ToHBCPfw+bSiGOcWCAat/liYktSJfL4rFACRGtNp0mT/3X7pshfRdHiRK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIkdhKlounf8LNIOKu57WvWnowqLrOAc6ssJmhwgASI=;
 b=x/RnQFV/B9ZA5lShY9tyr1byAZarISlHknEeTgpsQirV0kBvfT+topsTuLvmiPmxOywbIn0SBUTpWx9v6A1XJY0r8KuDkPUwZffmuSl00drLe1KtNguzEDh6ckF3EGl0gojvKDNnk9GV6DVPlw8wzfred75YedgdRfpVYNAO+SCRelJz5TFgzaAvAAr7k1yhHwZ+QYWH2Yn6oOkAM/aNRFIoovjZgnwWnvX1MoRSs8UsWJ3gzB8z4U1GtFUA53i87LFI+bOw2K2jHPtv/RJgtqI3uPUd89WHMEqn4P1O+LPIsD/UgHXNl587xzdBHuy6stx9sRJWmewsxKn21iG+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIkdhKlounf8LNIOKu57WvWnowqLrOAc6ssJmhwgASI=;
 b=ysMRiNJ0cbZInAI588n+QogfqnoBzrKNmznHr2gvRRfw6tqt/6zmwU1H56IrSjkTnO7s4wvaAPFpnJoFVygzRWjXCRLBU7a9wD2m8OVF+7+3HA0fhvoCpyetz+nl1T4OnXfcpvI0n9M7O5IVJiWqQsrs/aAEIbqxi9Wzo6RmqT0=
Received: from DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20)
 by CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 6 Feb
 2026 20:01:47 +0000
Received: from DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9]) by DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9%5]) with mapi id 15.20.9520.006; Fri, 6 Feb 2026
 20:01:47 +0000
Date: Fri, 6 Feb 2026 20:01:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
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
Message-ID: <d55a0ba8-46a3-49d4-ba76-aa9658e1e8be@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <fb1f55323799f09fe6a36865b31550c9ec67c225.1769097829.git.lorenzo.stoakes@oracle.com>
 <hmc2or77xnhrdlncfzjsljljwljnp6zztqsvmgxspfilmzkyty@czxpjpdm66ov>
 <20260206113153.c443545459474cdef6dfd7ea@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206113153.c443545459474cdef6dfd7ea@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0674.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::6) To DS0PR10MB8223.namprd10.prod.outlook.com
 (2603:10b6:8:1ce::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB8223:EE_|CH3PR10MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ef8c73-bce5-48e9-d95b-08de65ba8f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9zJSU9Pf54JdVbwxsbDpmdk3jELo/jV7oFwPywMzYWnub0II9PVoW5EzrFj?=
 =?us-ascii?Q?eEusQXBpIXTIoIJzKSfZA2JCTqR7gFq6VHwIYekCyRxt8b3GtIp4gNSe7vYG?=
 =?us-ascii?Q?kIiU79eGzK0Pmu2rwN8U8nr1RAjGX8ePB2fy5ZeImK4ezhCzCpQ60Blmf8+E?=
 =?us-ascii?Q?eVvVvGKwjGp2RaXYtzYDYHOZ1Fctwm8FKT+HzMFg/I70UIzT6Zztkv1MZLQT?=
 =?us-ascii?Q?TGD+dfo8BkUTBpdigjsWeVC6Ogz1x1oM16nW20Ns8bsdFMOErjBgRGqUH2pZ?=
 =?us-ascii?Q?svaJXYIv/7CgSCm/RsPs2C0BafhToU45elzfeYTk+Fxgq/GJCOshENHvau44?=
 =?us-ascii?Q?pob9UOepxBkhji839ikYFL3+p5OCzxwOKPkqrxRTc6ZRAROAG3b3x+EyUvEW?=
 =?us-ascii?Q?gjl4VZFTNKLVIfcZRYDKIKO80oKAqDk84pU7YFn4R+xRh1m0g8Du2SmkQQTT?=
 =?us-ascii?Q?6r7Se9QtJW7PyjAhad8RjBV4goXNDs7LSu+8GyNB1g0yTJ1N/v629ggKTxuc?=
 =?us-ascii?Q?GWLvO/KMBqOIKv+fs/TfrPPW4phNhCW2nTPrqv/kFUB3IfA1XD0VOofzxR0f?=
 =?us-ascii?Q?w1PGNQgOl8bejdt2gWxpb3x7R8345Uo12RcXxJXU0F0c0i0FRY/tZUxg8L/R?=
 =?us-ascii?Q?qfSKpwCvrNOifzMl1X/ej9YA/kVvnxLmcp2GwitBa2Xc7GXKtZ9VbmCUGYV6?=
 =?us-ascii?Q?DEOtCcc4xuBhaZ7rkTKVNDtxoitiM8ShzVLZawOf1saLnCOe5233BVlvW2/q?=
 =?us-ascii?Q?xNOnLpfGfgGgv0b82GsU7604KDRrGxU4bT+WjMH4V2/avobWiv/kTPXPHojC?=
 =?us-ascii?Q?3pCtjNTsM5nWhg3DN8l7+16jjC6sBFEIOB6kwFyxt8XX3p5XiFsrTnHNcEFm?=
 =?us-ascii?Q?RCUPlFBluVpYM2McCfy61zViDLpUcbMc1hTbq3HRl7MPw9AqKJFbUlpldlOr?=
 =?us-ascii?Q?lnHDdiYMDgLICXzI5ObDEClMMEgjOIszY4JsIaKevTZAkU9XNg+2w2ydCocd?=
 =?us-ascii?Q?aWf+kortpXqim2OikfyzO4F33VKqVLx1mtnsZWTIBbgn266307HNpOKTjAVv?=
 =?us-ascii?Q?z+oMkIMFyQBt9TFFckpm8TSfc1VMNuZ2AX9LEDtT8j0moBo0EW8oa8MQwV5m?=
 =?us-ascii?Q?6P/e2vHIWvnv4I53/0k45S5qCga655BDelV/QEtmRCUpZyLzHZo1otiA2nen?=
 =?us-ascii?Q?vvhS2gpVLhFfVtoMwDOgpTVP9NQPwXPjobh1Vi7UkWpIL80mrLYR+NlMLlxn?=
 =?us-ascii?Q?IW5COWpAko91nGx/DrUMc5XXJdYdMXMAlZMU5kmZM7brc2Xw6Bv05dC+mYr+?=
 =?us-ascii?Q?X0ZpFCr65z5X1MUIM7tCiBqBN3ihAyNd/ZMVqCWDeGqcfvd2lvgbD7CkCC5t?=
 =?us-ascii?Q?qDM49/EuevQtX8IXpH4AdTeBZDuV5yE4aKbBX3jZLct2B4I22GChnM/deKHS?=
 =?us-ascii?Q?UiJcsISO0jXZtJINkYVJxZ1M53uEb6qtBTr6P0alSGDcxTcizFaeimfKwFBR?=
 =?us-ascii?Q?cQuGGCh9zSmrRfsFhN6ctlCxC82g0LtBat1OWm8UYtpWHFhMDPVG96wE+pHC?=
 =?us-ascii?Q?PoPJmxq2oS2nEm6Npos=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB8223.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5fiS3hEI71s1mZtg7XEvgdeYlW7y5BVQPk1UWGYhSM5V9XeX+3Dqkgwn5pxH?=
 =?us-ascii?Q?UTmCZEBn5pLqEOdvb0ufe4JpF+viYTaP5w/5VeenB6yyhyavG3YyMs7b2REj?=
 =?us-ascii?Q?FH4rt6mn+a+fqSOx5gtM+cAiL8Jb8sCivRABfVIgFA+cYbd1kdcca3yf/EaT?=
 =?us-ascii?Q?yNN5bWrAdoVYnDc5C/mlrqmkO5MrHAJXm2EoZweOfmp+FDXSMxJglp2iFnOm?=
 =?us-ascii?Q?wlAHD7YEypWMiMKdnk4q81VMbVnI8X1HQYIoAVhOgwK2w4vQOkEv56gVl4zb?=
 =?us-ascii?Q?ilkFXyKGhMZvffKMg81vZlhPKxgpcUFom8w6EsdkQp5E6y3DXB6aKOpQmxt5?=
 =?us-ascii?Q?t21CfwTZhl8tr6PzoASpG3ahQC/FlUARO2UqBL87KZHOKophUROEd6FFHyvc?=
 =?us-ascii?Q?lKLMpRTGz+TUgM/e0dOcroni/hFvcAk9BD78Uixby9U2yzzDpwoWq77PseJl?=
 =?us-ascii?Q?wRt8phf+x56oRNfRoI/cJoQ6Fo56F1NCKbb/HVbZ7t2t/I4q8QnO+n2Sgz8O?=
 =?us-ascii?Q?KpiKLLzuirkhrmRqGL9HI5xDBjVFVAh3GWq0Vp/g8xvn0W3vae2Sc5MrbTZQ?=
 =?us-ascii?Q?ijRoShOpTm96Hj2czGMk/3zvq6IB9AxNUZnR16aDnGbVaNA5KDYFZhbRzKDB?=
 =?us-ascii?Q?w2E171nz6PpqXizzc791gIaDqv8QvF5NhnCMdyhPlchqeTkCAawRkcNQRSPX?=
 =?us-ascii?Q?8rGSTWlEwD/YUMcEyYskFlmCSQImIKC7Q3YuizOWUbkYhQwMFx3I6V1L7Ps6?=
 =?us-ascii?Q?NUYuVg6lZClU5dbwozMF4s7JgmRtlBTCqEv9hRYywim3TwzIVDrvdpQOb/E8?=
 =?us-ascii?Q?ntL2lIY3DxyiG92hRjPf0R2IOyAZk0PQ92off0CjON5R0FoouLfGaCEdeBGd?=
 =?us-ascii?Q?6yvntKH1d0WZ4qxZorMyoKPB5iLIXFw8C9NQth0otYvwryJJIB1aR+P4HcMX?=
 =?us-ascii?Q?jAWYGHHIk8NXTvKtbdRbw4R6PqpCSMTPnysfEeIgAUkv2FQiOsTIByJpkufL?=
 =?us-ascii?Q?o0FhPobPERKh+O6nYSZTe22qjFQDeRTVNynHIBpKNk4CMxCKETYhFEiFabpV?=
 =?us-ascii?Q?vKOzXY0Xzbm0CU5LRY8qDtV24V6phdEJ5jTwPTU2wKrPUhUYwfXwT4rvrLDV?=
 =?us-ascii?Q?y5++nL3ZgQavsSWU1bPEoGyC9Te7nKCqzyMqZke/trwwWqjmwsKKU4CWKpZK?=
 =?us-ascii?Q?IL1CdzARJ/rVWACs5M9dtMi3coEbPYbH2KssoQMUcn1dkGtT8AS66OG9N/Y7?=
 =?us-ascii?Q?8N0q0Zd5WNtSRaIwvP44uXp7ZsEF2qRaemtNNIUImwT0yw28Dv0KMjRelh0A?=
 =?us-ascii?Q?cZG+fEZsXRgvmCr4cg62jfTl9JW20gl3neoEisE6ZzVGq+roBo81Y978xrfg?=
 =?us-ascii?Q?TnnlpF6eZK7cszPOwYLejd8tKVDTWp1nr/r2MFopOnn1S6lxr6muBEyO0++b?=
 =?us-ascii?Q?242QHcMUbRO1nAYp5+WjLos85bBpSXJswxQmEAZlDECBrWW+KQ9NbpOhngIl?=
 =?us-ascii?Q?Ejf1oO8/6aV03DuGhcNgHiuuVFeMo1BIQ0+dXVOpfcQmpFANPKufXuxXsfz6?=
 =?us-ascii?Q?j+b5eelrZ8THRSB6dhjxHhOgY2CKXu7n11cxFiG+ld5VB5Q9zdYpAYugQVUV?=
 =?us-ascii?Q?tCpyUvWF95ClRO+BkAhv+mBIu0C1TCANXdqN+u/rM4W0ckYEiHtBkA1dIG44?=
 =?us-ascii?Q?p05UQD9pWpfX/gwocYCUaBRpCLVJ0+k/TvSApu/yWEi1Ippag33RWfLsAitj?=
 =?us-ascii?Q?chEaGlQISwCNdmX1dokZGc81CQQIa/k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gRg3zfjEgoOb1pzNIRFIXMWmV8OXJnUZaMmG6lvdJCjgyhIxVtbIxtf1Zp3Al32t9c/Pk3CYjW4DEMLnq1LsAccIiqyqxP2gZ6doz0aBxDeZhVu8rQLTr1btGmRvwHxVSVxrI7rkF+3H17cMTaKqX32gDRwfd5UDza/50OPTp8OrJJyOrPS4rXLr12Rzi1lqrz2O2LpU0qwPXq33MPsIlTF0+CZoSxQPmDvtO69bAgtYbCTBn3jjgQvGgAzJ4wWMWbpabKZUV0wzce6MH57tV+RGjBPBcbBfdmYy5dNzGI+RC78sqLhIr56ChK6lkczO4+CYIUKbbzZ8f2Nu77FwrWUezwk+ONjhUHdbg6q0RN+OlJGImQcJ9dF1TS77B2uXZ4f2CIJZ0b1cBWyyCMpxv9UkiZyPwktQnZi3cCnTJiJD5XJfd3PVLiuADSvLnE3MZg+hOIYewhtaeIA4GgHWAEA/A9+qjW93cCY/9HkZkGfFlHOBU779y5Jt4Ix9semlDlFFsbwP+8cDu8mS4hWTEs1kNrQM/9OkO1RYWI1h5xVJc1aVNfW+Sbebpl0LZKJ9tdvrDo36lH4nA/8ZFB7IlZv2F/KGLwU8Rf3iJMIxwIk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ef8c73-bce5-48e9-d95b-08de65ba8f5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB8223.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 20:01:47.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oE39J1tHGB6bCnlJ/MGiyJii+EVqj8rNF1mWtGn6pSRB1D/mGKZRsUd+AILfS1PyHJNo6440Vad2sXrf7k1j5soyBWRtgo8gMXOA8qz8SdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=921 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602060147
X-Authority-Analysis: v=2.4 cv=Db0aa/tW c=1 sm=1 tr=0 ts=698648b4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=se1DkVxXpihIbOsVGb0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: db6m_is3Yv0tbcwjkkKt16lvjfSadZc6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0OCBTYWx0ZWRfX3AAS7Oqt7MxT
 iH0ONPvWZqHXXd4hieWMZH+5gm0UHlxSyQGndI4Vb9KZTZkwPSgJmEdASxIXYTMrEVShLhixhwg
 pW4IAyyfo6bYi7ydIh1PCVuXnru10qq5lZHiFmo2Lu1Vct0d0mLWCCN0vTMh9O2y4LbXjP0zzwt
 dxtb9mwbP0pgBmCVhPRePEnINuu/DcK9r/YrxMojiR31bIICsk9B5zDXKZCu13YEReG9cSmg856
 aL59JIWRwQWHrdS3BfKXtWi09pBJJbiOycP4hqGvgsZ8IXR8XSh5jVC04pj77H6vvqxL4/GUkEc
 AT19EmxlEwCJBtFnqHhh0GtoKKCrCoMxhacOxl4HEOv0bDOvrcpAVx/+vcTF9Qk9/WDT14hnsyN
 sfzfRppVGQHbDxUX55yyg+uLy+vfrwz8LMgobEYsonjsmtRK4JQbqVlAJe8wqlgf/3Bdfq2DOtE
 S+mQt3DUHzFPM3goSsA==
X-Proofpoint-GUID: db6m_is3Yv0tbcwjkkKt16lvjfSadZc6
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
	FREEMAIL_CC(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,suse.de:email,lucifer.local:mid,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76645-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[93];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0822710300B
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:31:53AM -0800, Andrew Morton wrote:
> On Fri, 6 Feb 2026 17:46:36 +0000 Pedro Falcato <pfalcato@suse.de> wrote:
>
> > > -#define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
> > > +#define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,	\
> > > +				     VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)
> >
> > as a sidenote, these flags are no longer constant expressions and thus
> >
> > static vma_flags_t flags = VMA_REMAP_FLAGS;

I mean this would be a code smell anyway :) but point taken.

> >
> > can't compile.
>
> Yup, that isn't nice.  An all-caps thing with no () is a compile-time
> constant.

There is precedence for this, e.g. TASK_SIZE_MAX and other arch defines like
that:

 error: initializer element is not a compile-time constant
 3309 | static unsigned long task_max = TASK_SIZE_MAX;
      |                                 ^~~~~~~~~~~~~

And this will almost certainly (and certainly in everything I tested) become a
compile-time constant via the optimiser so to all intents and purposes it _is_
essentially compile-time.

But the point of doing it this way is to maintain, as much as possible,
one-to-one translation between the previous approach and the new with as little
noise/friction as possible.

Making this a function makes things really horrible honestly.

Because vma_remap_flags() suddenly because a vague thing - I'd assume this was a
function doing something. So now do we call it get_vma_remap_flags()? Suddenly
something nice-ish like:

	if (vma_flags_test(flags, VMA_REMAP_FLAGS)) {
		...
	}

Become:

	if (vma_flags_test(flags, get_vma_remap_flags())) {
		...
	}

And now it's SUPER ambiguous as to what you're doing there. I'd assume right
away that get_vma_remap_flags() was going off and doing something or referencing
a static variable or something.

Given the compile will treat the former _exactly_ as if it were a compile-time
constant it's just adding unnecessary ambiguity.

So is it something we can live with?

If it looks like a duck, walks like a duck and quacks like a duck, but isn't
there when the pond is first dug out, can we still call it a duck? ;)

>
> It looks like we can make this a nice inlined (commented!) lower-cased
> C function as a little low-priority cleanup.
>
> > Rest LGTM though.
> >
> > Acked-by: Pedro Falcato <pfalcato@suse.de>
>
> Great, thanks.

Cheers, Lorenzo

