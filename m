Return-Path: <linux-fsdevel+bounces-75101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGphFuFRcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:35:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DDA6A106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482F53229A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1755139CEFE;
	Thu, 22 Jan 2026 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MrW2Ag+X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H1VGB5I4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED03A5C11;
	Thu, 22 Jan 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098142; cv=fail; b=iMt4BwgrGqmqTafqRnYurhle7CyRDTEbDpZHyZZS84Sctjf27vE5Ti34LuM9Om44+RpbljYV9aAH/9TSftVHZejhy2T0QRGo8+JyrrN4IWFCWBG1SlCUnu0gW2kcS1ukiVEibbZs5q+s9QUWs/J6WIQWCY45x6lxqyWabyxj+O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098142; c=relaxed/simple;
	bh=edisyWa6piUaP0Aba6qVay/CqH7fp6C9j/ziOf/mtxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqtzAJcjw5kesPn9s41GP3It5ZUGwxe0DfnwoWH45+CwQjX5kP+qfuPg6hSY59boDgmFmbEHxC0ZA6r+Kb1DoBUEcOnoO2ukzeZEnsTggpmzxPMJYIvePr8QSPOs9PK5gWM/ATCN2oakymyR+IdEwamKoivciSUeyN4oQ76y4Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MrW2Ag+X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H1VGB5I4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgMq0596124;
	Thu, 22 Jan 2026 16:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mOWCkxWeSza2yDHCcTB+t4XyuIexlLt17waj7ueLmDI=; b=
	MrW2Ag+X4gr0q4rdhJ0WWMFrMi9zF6LDgnhsJ7jb/wfIE/mKNLhnO0yqNu82zlh+
	jq0y0JPzNVf5g7N+pgb2FDAoDReKvtnjlm4z2zcpRDbTukZwJJ2weZvhpICaD2dY
	JdrEZUiBiB8YsR2FQ2Ox5yWuhRojFw/GzDRc1DYiw/wv/n0NeM33S4EHQVj1dFql
	mbtDHvYLrNs9w/WBQ8uPOjUPSkhU6/8ZNUCNkw2GVgLoGHl0+EuAEeklhxFCiu0p
	ZwU2Mbm6v9gLXDuymeNKWRxgc11zkmgJpIb678m40F2G7DaEW229ASAMa3il6l+k
	A6Sn8orkGcZvsTMnSnmZmQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5qwff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEgcCT032257;
	Thu, 22 Jan 2026 16:06:57 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgusre-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+Db279wp+203XSmCuSfHuNID1aa/wlW/yhDkCynlkODIVeG7LC2eK/qRbjlezmaoL5qlvI7noouxEuYWwkzKHcnELTkpCPrrlp+913uW4U3R6+sC6IxWMn4o1dx2F/w03s6sAwmfUsPvaJbXFxrojFU96jWBcWzG3wKUY3NTrjgFeQy+4Vp9bsLhmR1xLAPoHLA4rUZj0lx2ZvT78u400JmNlVY5QhrdM6jvOTMAqI7qin9OVeh6BbaL1NUnuM89ufOgrz3ydOolXD85rYa4uyoaD8FhLVdm215qR2dOe9i1aSmUpalRzSZtyp/DQfKIvEKhuOFIPO6Xjc71BJoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOWCkxWeSza2yDHCcTB+t4XyuIexlLt17waj7ueLmDI=;
 b=gxRZhEUic+VhNPDLlxzEBsrD0DF0X51VxPfGz2k9FllGsFURBvPdnCE6pO/uhmNdQxAsvEM6Q+yNNYJz9d2W2vzGB1hBLruxAhqRDTWNYApcCFROPf9u8tSIyX110gLENzXCcGHu0m/J4OJwo7AdCmXcd5FvFDXCZRn7MGLcrO6JGUO+d9m/sGrI/1LdvS8l6mQg7TqB12OObaRYOnnC7EFro6httQ0n8sfdJxagxGCG892IRUzLMpD0L20rrvBPRsmUuxCYzBbfX8SjNxRgs+ilFPEKJZ8jaw3RRMrFheQkMq2eNoH1LI8ra0wQd2iPNQkbZGX9ttwbKlqkzPLhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOWCkxWeSza2yDHCcTB+t4XyuIexlLt17waj7ueLmDI=;
 b=H1VGB5I4mFMWOU9LYf7TVxORzlMN1zE13a/KkJgnwPospv8CFfjYbJ1nTqh90GFnvqu1N/YM8pcuB/3YtkVBlFY14eC6GnYpO2NXNY5axYSQX8dDQRZAC6kx4D1RTZ+SyY3V/E0aNwYQxbqhkRogt2CPaSPil+NkXQObkxdyewY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:06:46 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:46 +0000
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
Subject: [PATCH v2 11/13] tools/testing/vma: separate VMA userland tests into separate files
Date: Thu, 22 Jan 2026 16:06:20 +0000
Message-ID: <a0455ccfe4fdcd1c962c64f76304f612e5662a4e.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0269.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: e42237ab-3b7f-46e2-2b8c-08de59d03e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?47WrKhoZ2Fssbgz4JbJeC+4WLhCtZSI31r3aPxK3G0rGXHnBPlaVzmnqD08G?=
 =?us-ascii?Q?sKbfnb0ZaMxAIQ4gHhdeGgDCeLwELYfLGKD/g+1ioDL/dF9rSrIatzk4Oj2u?=
 =?us-ascii?Q?HGsp5C8QvrY2BNdLiCOu4NWO3G8SkFO3m+YvvDUEOmTfqiL8n7zF3q9fLBcd?=
 =?us-ascii?Q?YAzmwY1fXp4Eya0nLvE3LZZYIz5a7vRVfcZHJj2endk582K1PN6GzNp/3+Zj?=
 =?us-ascii?Q?nmq1j4+mBoU9Cli1sfNyBmroTeT16fHsIZVdf7eo/8Wx744Y2buMym85WX0d?=
 =?us-ascii?Q?Nz38H9WnffXVcV1cUqoyGeZW7zYlRQUKYD/xrDDZIwe9pBVVquSaD+dFVqZC?=
 =?us-ascii?Q?MNzer8IaHfp/DngOP7jnByh7TPmTFYfKhdyA+g+YKyzpTvpGPMxXxj8UdF8C?=
 =?us-ascii?Q?Of6SoQYMY7zDOsJ0SjfrGVPoGRo93feEhF6K5Sz3EYkGnfUAb/hkdVZ2Sf1H?=
 =?us-ascii?Q?fVvII/h1H+McZI9MJvgM+Q/JtTSqyRUbtdeS2jMIH+E+yXwoHLx8ilUJKG4s?=
 =?us-ascii?Q?yO+kZ/3zoUxxHBr5e4+ARptAECDYDJUl3dkJrTsqp8VAQptKEGZGCK4TcnKR?=
 =?us-ascii?Q?HI7mDAE0CrU09JEVKIzvCEURmOh51N52jB/NUyINCuPwoPhXSiUaCKjrZryG?=
 =?us-ascii?Q?kmbCUU5apA8AO3PhWwH1GDAUEYRT3S5YdZ4SCmNqjK54FvzNeaYaOrLIRzyY?=
 =?us-ascii?Q?YY6KEJwQrbuoldaao5pvGDzfD0zzvYLO+z9AfOf92L84Li5sl00a0dvFx70v?=
 =?us-ascii?Q?2uNQB8gDUEyOXTrrNZaskxxRxP4Ee78/rg3KSgH4W9glzQ8vNbqBPNQ8+3+5?=
 =?us-ascii?Q?saBHW2SKqjXAJs8OoeoYOpL81icsgC2NL8+Vh113bL/2S9rbAf6tfwNPnycC?=
 =?us-ascii?Q?Iuod4ljW14Uhce5aqSWjBfLK08yQGqF7XwS2gLNG1rGmyoTrRlOucJjbWgcY?=
 =?us-ascii?Q?06WD8IFN0UHJZXdYOoU5xlL1Wglxrb/apQ9Hdx4B2ew91RMZljm+n174bLwJ?=
 =?us-ascii?Q?i7KZNE8NrFePAxj/AjoQPkIrzIsv3MUnJcCvivkdn0FAOgrfz12l+ud9nxDL?=
 =?us-ascii?Q?r2SUDj77+ux1eIOeLzvbwoQ0Uq/idnHTGTvle4eIxkcvjnmMrcK42pa4kroy?=
 =?us-ascii?Q?sttEn17hk5/XmKxXoaxx7ZmU6EZGUFYdKpj0d7yvS0N9a+m9G6yLo1Lnrdao?=
 =?us-ascii?Q?gaj1h20/26FSrSZNmKRDOjnM5bJU3SLzQsRFzx0v1yXmizOM6WlpUnL84xnw?=
 =?us-ascii?Q?zarsFFqM21S+slyymYgzLccZ8GO5XjjFAZhfQAIPqmJsyIJAmdQxPIVBHfY7?=
 =?us-ascii?Q?7qQiRaexOwwqKwzPPH9KDQluIvReIWCP5IC5T6zgJCuZ1kNUOq4aH6LLaX8F?=
 =?us-ascii?Q?xlBkSnbQ+rr0Y7c7OQTk8EFTXP7cWWtrFaaLBPHGNmQt9qOiu2VhfqlUIWQD?=
 =?us-ascii?Q?XDdWAra85Se/9i4qhB6S0FzRHSuQcohPAGQweO3iO26cZx1j7eAPFQ9iLVxw?=
 =?us-ascii?Q?q9j3YuGRmN8AbUbxWe3xdE0fnIbvDH0L/ApFWJbz4Hl2LpziyIjMFLALQjhy?=
 =?us-ascii?Q?tXkPR0Lav/jKXLW9SRc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H2hV73+Jq5oK1LH2+89IPOzxGkhofXhIFlcYH5KgOv4wHelO/z/0wDP7WL06?=
 =?us-ascii?Q?yhjSwO5cwkPmh1JlCd5DP8XxsI5kIsY341VUml+Kw+9g0vEyy1VK4FyviY1E?=
 =?us-ascii?Q?pDV5t0vyiMKTmW8GVnFAF1CRiZi01ozdy34iIma4RbTwwYFM9VSc2T8rJ0Mk?=
 =?us-ascii?Q?fEPL42gP3EilLNH8bZVCu23rDkDaJ2DDuIoDDxbyI2ADscMeATwbjBTP5WPU?=
 =?us-ascii?Q?ZHnnUCukop+5cVvjZPaZDnsDzHFybg6bzzaB3m07WOjZ5HTGmlTFx04Wrmdo?=
 =?us-ascii?Q?0tmIavVDztM9Nodxnnysdrp7b7JMK9qOdNJW69lJqiurzx3+UgiS2TMLRCLj?=
 =?us-ascii?Q?xWo7zF3whfcw9HaJMuOHx45kh9skr9J0Wa0mEVkrrZhOetFNgqepeJoqdqVA?=
 =?us-ascii?Q?vg1aL70KIY2rJ//J1jR4XXq/xcpczvMEExHkzZ9CAdQaKssqyzqrQWETUZk9?=
 =?us-ascii?Q?x25PQQXPWnkn4pE/j7pESrodGdoCHtA0AM/QlndISXsZT7uJ1IQKuIf5NXRj?=
 =?us-ascii?Q?joJvL9bkkJ1aIF7gss/dHJWDptq8tCqC4wG3vKd191KzhdA79C8J1vXMt6CU?=
 =?us-ascii?Q?gZ+FIW67ZuJNILsRW8TGaNjXsEoTjPdGsIIrf7tfcPvNF7MvhoNiDhH2nw6C?=
 =?us-ascii?Q?EyWMMe84nWNRsDRQElnCvQcH/CN+QgaP2tf4vVd/YOhsULhMgcHPlE/jg8s8?=
 =?us-ascii?Q?q7OkE0AzvwHTBBFZFj+AvkE6hTTHlwMW2xgTvE21m44vHYD3KXGtt+TnMuzo?=
 =?us-ascii?Q?FkCSF0PMXF+Ya/mkyfxyVbbW69F4vK+TZS6syBK6VYWrMlIkQ/An1IyGZnTH?=
 =?us-ascii?Q?LZjATsgn+4WPIWJL7w2bkj6h6dthbg6JwqrWMuIPcKbcn+ipSvv8UxgKRJlT?=
 =?us-ascii?Q?F3lUl5tUS9dLU1EfkKPWgbb53pIX0d20riYs1I56U2FEUf5sigt8RfOy1LmV?=
 =?us-ascii?Q?0P4ltvFy4r3YIJ6duCaJ0Bd+bUdJMjuniOG0KPjFJvb1lK+zQXqIeLuE/XTz?=
 =?us-ascii?Q?xetD7scXrK1EBWfowupe6Be52xhZc1O1e4S1WBY9HtbMB7biLSEYFT4K9Xpb?=
 =?us-ascii?Q?tynC0Qgm+G154Y81/2S36mKj1v3MQVG1j+2W8YkfbIpwNvKR69oYr2rz/YuI?=
 =?us-ascii?Q?8Ciw1F12kA3kpQNi7yBP1C5xDTwLfFq2gpRIOxWZkXF/93b3uh+CNtdPSv+Y?=
 =?us-ascii?Q?G9r0R5UJHOmuQHoYIBPX7P/DsaiFwJrMOv9h4NN3+TApWgWqQBwl6GxZoj2K?=
 =?us-ascii?Q?dx2bw0ZQKOiJtIsPS22QGZxF5QEiOKFcKBc4K/9LBnp7ECTtMHJdX6R5K6d5?=
 =?us-ascii?Q?whP3TYt5t3QI21N0AOcNqRaeTlBFlRTKzXJCEi/h2jZUlM8IU86dn1tIhnFx?=
 =?us-ascii?Q?t96NZOoOlmgBJ6QsuDy4SW4IOoscobsj93FeEuU0DPJSaWVKDMLN6PQcLAxZ?=
 =?us-ascii?Q?vcJIjfZjciscsjd3DpU/ocWwNSMEZ/Qska9bhaWsKScbU4BG8ypjKpKxquvt?=
 =?us-ascii?Q?AEBHDd84XfKqB5fFb/vUA5swgi9z+llILEDxrp0BtuqQ2q4CKOrmq2qAlNGP?=
 =?us-ascii?Q?aVLL3KocrTLKcjrHU06uzz1EPLmGfaBk9izN8l9lRcmjOPKpJbdeyUZBhIqg?=
 =?us-ascii?Q?+ICfof/Vo+970IPeZifCmd/OMoeIFjkQw/NuEWKAA2Vobf4cNU9BopxXwBFr?=
 =?us-ascii?Q?3C/pP9VmbdscSG+hloVslsONe1yILUa08GZNkMIImYuiMd1igNw5UDoPe2hx?=
 =?us-ascii?Q?D95+TBUPvdmCA1FPP18yjsNcXXtXmQ8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T62+vACw2YFAYUxwBn/G3TuBY0/rCkS8fZX222/HZt4p4dcDaiZA4KCHLd9c+hg60W50Ege1yph3XoX8NmA8gN0luA5MwxZUU5TG6gB7CFJqsoPeaPiEld5lRinNZ2WBdCxx2lLlvFsZSyKnebOVvI+ue1m//2sGNjil1KmVunACqAI6YaD+A9amiXjaMCEAb28jB0nvCCB6id+b+paJiHm1jNpN0f9CRhOw/LHHQRxCLnzTwJC1ADhz1r1f+ADnCj0ESjLsSxzRlpw+umnR1fhAsQdsxbJu63UnY7QKt5AaaohXjI6Owu4idpBnX8WS/wINmopi6S0qRjMCtn5Co3ovwVMU/vWwdy1ZBiEgb+aNXqN6cCkyzGJFpFcI27kzd4+E4XA6fWHZoWF1sfx8ebJsK4qWp13hKH7F656t0PV75oepAc88OU5nHiFhthqUWqJpq84g85zoSjbxZhSkSoHwM2z6Qa8ENWtooaI+MigQOYWVitnPsrDjjB4S+KjPd//5RzyO8ENVvLkv05C0rx6hKhQQGvjfmLEsuQfGCTZ85R9/V1PYnkh8DDjXtXMoUucjDGmRv1fxz8J3DZqs10zelJiKx0gKgx52TUyOCUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42237ab-3b7f-46e2-2b8c-08de59d03e43
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:46.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xj3+DjQfEX5YaX1SXHWDS13O7EPBgYpKF/MjRNIz6lzzURmVuF9wPzKk43Go59dm2pAAHwl3cVlSPYxved+ZXdlcUaq9tvpC0YdtWO1XsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX+qDQxl/EM94Q
 PQrL2sQc/pcwJczIGrdU/krjyMx8E9oUoIfD118wsK1/LRJUahjGooyhDuRn2mO6vxmHoWFU1GZ
 Qmn2ji0Zoty6FQo7z+jaloGRYPc8CUZWD5NJWjIfX9FQ39lVIzT4tWFZ5MEpgqPCjfT5Q+PY23M
 eIWtTkcGLEpmWL92cnaWOWgFBK/bB0p5adubFIE3XipLrYRhCztazmJG7nKDfG+gJ0ePiSrfbHO
 XR9FUefHR1lfgtNRfV3CpvYhiyWsc7fwpaWi0lKipjktpnEE12wtfe0oRMJhEy6im9pkushuIXa
 LLB3siPnKoS15IolVYC+KAlTY6x5zvFt7K4x3Z5mYB7wEWVuTkCJy7QiNfU2ZRUywKD83GJmF3p
 T2VeE4085NZ7wFVkkWOYww1uyGEoylgf7B65d8owY+4LuVV8osRuvqzjIR8fT+awkg4aPyLOTZf
 l/+BRooev8t4Z8UeCBjz0/eilJliRPHrWM5H1MPQ=
X-Proofpoint-GUID: 5HysHHozgrUX-BYOfDANUD6bSSrYNasY
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=69724b22 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5uttRRLgS_GaOMRt2q4A:9 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: 5HysHHozgrUX-BYOfDANUD6bSSrYNasY
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75101-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A4DDA6A106
X-Rspamd-Action: no action

So far the userland VMA tests have been established as a rough expression
of what's been possible.

qAdapt it into a more usable form by separating out tests and shared helper
functions.

Since we test functions that are declared statically in mm/vma.c, we make
use of the trick of #include'ing kernel C files directly.

In order for the tests to continue to function, we must therefore also
this way into the tests/ directory.

We try to keep as much shared logic actually modularised into a separate
compilation unit in shared.c, however the merge_existing() and attach_vma()
helpers rely on statically declared mm/vma.c functions so these must be
declared in main.c.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/Makefile                 |   4 +-
 tools/testing/vma/main.c                   |  55 ++++
 tools/testing/vma/shared.c                 | 131 ++++++++
 tools/testing/vma/shared.h                 | 114 +++++++
 tools/testing/vma/{vma.c => tests/merge.c} | 332 +--------------------
 tools/testing/vma/tests/mmap.c             |  57 ++++
 tools/testing/vma/tests/vma.c              |  39 +++
 tools/testing/vma/vma_internal.h           |   9 -
 8 files changed, 406 insertions(+), 335 deletions(-)
 create mode 100644 tools/testing/vma/main.c
 create mode 100644 tools/testing/vma/shared.c
 create mode 100644 tools/testing/vma/shared.h
 rename tools/testing/vma/{vma.c => tests/merge.c} (82%)
 create mode 100644 tools/testing/vma/tests/mmap.c
 create mode 100644 tools/testing/vma/tests/vma.c

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 66f3831a668f..94133d9d3955 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -6,10 +6,10 @@ default: vma
 
 include ../shared/shared.mk
 
-OFILES = $(SHARED_OFILES) vma.o maple-shim.o
+OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
 TARGETS = vma
 
-vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
+main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
 
 vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
diff --git a/tools/testing/vma/main.c b/tools/testing/vma/main.c
new file mode 100644
index 000000000000..49b09e97a51f
--- /dev/null
+++ b/tools/testing/vma/main.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "shared.h"
+/*
+ * Directly import the VMA implementation here. Our vma_internal.h wrapper
+ * provides userland-equivalent functionality for everything vma.c uses.
+ */
+#include "../../../mm/vma_init.c"
+#include "../../../mm/vma_exec.c"
+#include "../../../mm/vma.c"
+
+/* Tests are included directly so they can test static functions in mm/vma.c. */
+#include "tests/merge.c"
+#include "tests/mmap.c"
+#include "tests/vma.c"
+
+/* Helper functions which utilise static kernel functions. */
+
+struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
+{
+	struct vm_area_struct *vma;
+
+	vma = vma_merge_existing_range(vmg);
+	if (vma)
+		vma_assert_attached(vma);
+	return vma;
+}
+
+int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	int res;
+
+	res = vma_link(mm, vma);
+	if (!res)
+		vma_assert_attached(vma);
+	return res;
+}
+
+/* Main test running which invokes tests/ *.c runners. */
+int main(void)
+{
+	int num_tests = 0, num_fail = 0;
+
+	maple_tree_init();
+	vma_state_init();
+
+	run_merge_tests(&num_tests, &num_fail);
+	run_mmap_tests(&num_tests, &num_fail);
+	run_vma_tests(&num_tests, &num_fail);
+
+	printf("%d tests run, %d passed, %d failed.\n",
+	       num_tests, num_tests - num_fail, num_fail);
+
+	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+}
diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
new file mode 100644
index 000000000000..bda578cc3304
--- /dev/null
+++ b/tools/testing/vma/shared.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "shared.h"
+
+
+bool fail_prealloc;
+unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
+unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
+unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
+
+const struct vm_operations_struct vma_dummy_vm_ops;
+struct anon_vma dummy_anon_vma;
+struct task_struct __current;
+
+struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags)
+{
+	struct vm_area_struct *vma = vm_area_alloc(mm);
+
+	if (vma == NULL)
+		return NULL;
+
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	vm_flags_reset(vma, vm_flags);
+	vma_assert_detached(vma);
+
+	return vma;
+}
+
+void detach_free_vma(struct vm_area_struct *vma)
+{
+	vma_mark_detached(vma);
+	vm_area_free(vma);
+}
+
+struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags)
+{
+	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
+
+	if (vma == NULL)
+		return NULL;
+
+	if (attach_vma(mm, vma)) {
+		detach_free_vma(vma);
+		return NULL;
+	}
+
+	/*
+	 * Reset this counter which we use to track whether writes have
+	 * begun. Linking to the tree will have caused this to be incremented,
+	 * which means we will get a false positive otherwise.
+	 */
+	vma->vm_lock_seq = UINT_MAX;
+
+	return vma;
+}
+
+void reset_dummy_anon_vma(void)
+{
+	dummy_anon_vma.was_cloned = false;
+	dummy_anon_vma.was_unlinked = false;
+}
+
+int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
+{
+	struct vm_area_struct *vma;
+	int count = 0;
+
+	fail_prealloc = false;
+	reset_dummy_anon_vma();
+
+	vma_iter_set(vmi, 0);
+	for_each_vma(*vmi, vma) {
+		detach_free_vma(vma);
+		count++;
+	}
+
+	mtree_destroy(&mm->mm_mt);
+	mm->map_count = 0;
+	return count;
+}
+
+bool vma_write_started(struct vm_area_struct *vma)
+{
+	int seq = vma->vm_lock_seq;
+
+	/* We reset after each check. */
+	vma->vm_lock_seq = UINT_MAX;
+
+	/* The vma_start_write() stub simply increments this value. */
+	return seq > -1;
+}
+
+void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc, struct anon_vma *anon_vma)
+{
+	vma->anon_vma = anon_vma;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	list_add(&avc->same_vma, &vma->anon_vma_chain);
+	avc->anon_vma = vma->anon_vma;
+}
+
+void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc)
+{
+	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
+}
+
+struct task_struct *get_current(void)
+{
+	return &__current;
+}
+
+unsigned long rlimit(unsigned int limit)
+{
+	return (unsigned long)-1;
+}
+
+void vma_set_range(struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
diff --git a/tools/testing/vma/shared.h b/tools/testing/vma/shared.h
new file mode 100644
index 000000000000..6c64211cfa22
--- /dev/null
+++ b/tools/testing/vma/shared.h
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#pragma once
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "generated/bit-length.h"
+#include "maple-shared.h"
+#include "vma_internal.h"
+#include "../../../mm/vma.h"
+
+/* Simple test runner. Assumes local num_[fail, tests] counters. */
+#define TEST(name)							\
+	do {								\
+		(*num_tests)++;						\
+		if (!test_##name()) {					\
+			(*num_fail)++;					\
+			fprintf(stderr, "Test " #name " FAILED\n");	\
+		}							\
+	} while (0)
+
+#define ASSERT_TRUE(_expr)						\
+	do {								\
+		if (!(_expr)) {						\
+			fprintf(stderr,					\
+				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
+				__FILE__, __LINE__, __FUNCTION__, #_expr); \
+			return false;					\
+		}							\
+	} while (0)
+
+#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
+#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
+#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
+
+#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
+
+extern bool fail_prealloc;
+
+/* Override vma_iter_prealloc() so we can choose to fail it. */
+#define vma_iter_prealloc(vmi, vma)					\
+	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
+
+#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
+
+extern unsigned long mmap_min_addr;
+extern unsigned long dac_mmap_min_addr;
+extern unsigned long stack_guard_gap;
+
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+extern struct anon_vma dummy_anon_vma;
+extern struct task_struct __current;
+
+/*
+ * Helper function which provides a wrapper around a merge existing VMA
+ * operation.
+ *
+ * Declared in main.c as uses static VMA function.
+ */
+struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg);
+
+/*
+ * Helper function to allocate a VMA and link it to the tree.
+ *
+ * Declared in main.c as uses static VMA function.
+ */
+int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma);
+
+/* Helper function providing a dummy vm_ops->close() method.*/
+static inline void dummy_close(struct vm_area_struct *)
+{
+}
+
+/* Helper function to simply allocate a VMA. */
+struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags);
+
+/* Helper function to detach and free a VMA. */
+void detach_free_vma(struct vm_area_struct *vma);
+
+/* Helper function to allocate a VMA and link it to the tree. */
+struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags);
+
+/*
+ * Helper function to reset the dummy anon_vma to indicate it has not been
+ * duplicated.
+ */
+void reset_dummy_anon_vma(void);
+
+/*
+ * Helper function to remove all VMAs and destroy the maple tree associated with
+ * a virtual address space. Returns a count of VMAs in the tree.
+ */
+int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi);
+
+/* Helper function to determine if VMA has had vma_start_write() performed. */
+bool vma_write_started(struct vm_area_struct *vma);
+
+void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc, struct anon_vma *anon_vma);
+
+/* Provide a simple dummy VMA/anon_vma dummy setup for testing. */
+void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+			    struct anon_vma_chain *avc);
+
+/* Helper function to specify a VMA's range. */
+void vma_set_range(struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   pgoff_t pgoff);
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/tests/merge.c
similarity index 82%
rename from tools/testing/vma/vma.c
rename to tools/testing/vma/tests/merge.c
index 93d21bc7e112..3708dc6945b0 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/tests/merge.c
@@ -1,132 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "generated/bit-length.h"
-
-#include "maple-shared.h"
-#include "vma_internal.h"
-
-/* Include so header guard set. */
-#include "../../../mm/vma.h"
-
-static bool fail_prealloc;
-
-/* Then override vma_iter_prealloc() so we can choose to fail it. */
-#define vma_iter_prealloc(vmi, vma)					\
-	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
-
-#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
-
-unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
-unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
-unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
-
-/*
- * Directly import the VMA implementation here. Our vma_internal.h wrapper
- * provides userland-equivalent functionality for everything vma.c uses.
- */
-#include "../../../mm/vma_init.c"
-#include "../../../mm/vma_exec.c"
-#include "../../../mm/vma.c"
-
-const struct vm_operations_struct vma_dummy_vm_ops;
-static struct anon_vma dummy_anon_vma;
-
-#define ASSERT_TRUE(_expr)						\
-	do {								\
-		if (!(_expr)) {						\
-			fprintf(stderr,					\
-				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
-				__FILE__, __LINE__, __FUNCTION__, #_expr); \
-			return false;					\
-		}							\
-	} while (0)
-#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
-#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
-#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
-
-#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
-
-static struct task_struct __current;
-
-struct task_struct *get_current(void)
-{
-	return &__current;
-}
-
-unsigned long rlimit(unsigned int limit)
-{
-	return (unsigned long)-1;
-}
-
-/* Helper function to simply allocate a VMA. */
-static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
-					unsigned long start,
-					unsigned long end,
-					pgoff_t pgoff,
-					vm_flags_t vm_flags)
-{
-	struct vm_area_struct *vma = vm_area_alloc(mm);
-
-	if (vma == NULL)
-		return NULL;
-
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-	vm_flags_reset(vma, vm_flags);
-	vma_assert_detached(vma);
-
-	return vma;
-}
-
-/* Helper function to allocate a VMA and link it to the tree. */
-static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	int res;
-
-	res = vma_link(mm, vma);
-	if (!res)
-		vma_assert_attached(vma);
-	return res;
-}
-
-static void detach_free_vma(struct vm_area_struct *vma)
-{
-	vma_mark_detached(vma);
-	vm_area_free(vma);
-}
-
-/* Helper function to allocate a VMA and link it to the tree. */
-static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
-						 unsigned long start,
-						 unsigned long end,
-						 pgoff_t pgoff,
-						 vm_flags_t vm_flags)
-{
-	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
-
-	if (vma == NULL)
-		return NULL;
-
-	if (attach_vma(mm, vma)) {
-		detach_free_vma(vma);
-		return NULL;
-	}
-
-	/*
-	 * Reset this counter which we use to track whether writes have
-	 * begun. Linking to the tree will have caused this to be incremented,
-	 * which means we will get a false positive otherwise.
-	 */
-	vma->vm_lock_seq = UINT_MAX;
-
-	return vma;
-}
-
 /* Helper function which provides a wrapper around a merge new VMA operation. */
 static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 {
@@ -146,20 +19,6 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 	return vma;
 }
 
-/*
- * Helper function which provides a wrapper around a merge existing VMA
- * operation.
- */
-static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
-{
-	struct vm_area_struct *vma;
-
-	vma = vma_merge_existing_range(vmg);
-	if (vma)
-		vma_assert_attached(vma);
-	return vma;
-}
-
 /*
  * Helper function which provides a wrapper around the expansion of an existing
  * VMA.
@@ -173,8 +32,8 @@ static int expand_existing(struct vma_merge_struct *vmg)
  * Helper function to reset merge state the associated VMA iterator to a
  * specified new range.
  */
-static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
-			  unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
+void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
+		   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
 {
 	vma_iter_set(vmg->vmi, start);
 
@@ -197,8 +56,8 @@ static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
 
 /* Helper function to set both the VMG range and its anon_vma. */
 static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long start,
-				   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
-				   struct anon_vma *anon_vma)
+		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
+		struct anon_vma *anon_vma)
 {
 	vmg_set_range(vmg, start, end, pgoff, vm_flags);
 	vmg->anon_vma = anon_vma;
@@ -211,10 +70,9 @@ static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long s
  * VMA, link it to the maple tree and return it.
  */
 static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
-						struct vma_merge_struct *vmg,
-						unsigned long start, unsigned long end,
-						pgoff_t pgoff, vm_flags_t vm_flags,
-						bool *was_merged)
+		struct vma_merge_struct *vmg, unsigned long start,
+		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
+		bool *was_merged)
 {
 	struct vm_area_struct *merged;
 
@@ -234,72 +92,6 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
 	return alloc_and_link_vma(mm, start, end, pgoff, vm_flags);
 }
 
-/*
- * Helper function to reset the dummy anon_vma to indicate it has not been
- * duplicated.
- */
-static void reset_dummy_anon_vma(void)
-{
-	dummy_anon_vma.was_cloned = false;
-	dummy_anon_vma.was_unlinked = false;
-}
-
-/*
- * Helper function to remove all VMAs and destroy the maple tree associated with
- * a virtual address space. Returns a count of VMAs in the tree.
- */
-static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
-{
-	struct vm_area_struct *vma;
-	int count = 0;
-
-	fail_prealloc = false;
-	reset_dummy_anon_vma();
-
-	vma_iter_set(vmi, 0);
-	for_each_vma(*vmi, vma) {
-		detach_free_vma(vma);
-		count++;
-	}
-
-	mtree_destroy(&mm->mm_mt);
-	mm->map_count = 0;
-	return count;
-}
-
-/* Helper function to determine if VMA has had vma_start_write() performed. */
-static bool vma_write_started(struct vm_area_struct *vma)
-{
-	int seq = vma->vm_lock_seq;
-
-	/* We reset after each check. */
-	vma->vm_lock_seq = UINT_MAX;
-
-	/* The vma_start_write() stub simply increments this value. */
-	return seq > -1;
-}
-
-/* Helper function providing a dummy vm_ops->close() method.*/
-static void dummy_close(struct vm_area_struct *)
-{
-}
-
-static void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
-				     struct anon_vma_chain *avc,
-				     struct anon_vma *anon_vma)
-{
-	vma->anon_vma = anon_vma;
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	list_add(&avc->same_vma, &vma->anon_vma_chain);
-	avc->anon_vma = vma->anon_vma;
-}
-
-static void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
-				   struct anon_vma_chain *avc)
-{
-	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
-}
-
 static bool test_simple_merge(void)
 {
 	struct vm_area_struct *vma;
@@ -1616,39 +1408,6 @@ static bool test_merge_extend(void)
 	return true;
 }
 
-static bool test_copy_vma(void)
-{
-	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
-	struct mm_struct mm = {};
-	bool need_locks = false;
-	VMA_ITERATOR(vmi, &mm, 0);
-	struct vm_area_struct *vma, *vma_new, *vma_next;
-
-	/* Move backwards and do not merge. */
-
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
-	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
-	ASSERT_NE(vma_new, vma);
-	ASSERT_EQ(vma_new->vm_start, 0);
-	ASSERT_EQ(vma_new->vm_end, 0x2000);
-	ASSERT_EQ(vma_new->vm_pgoff, 0);
-	vma_assert_attached(vma_new);
-
-	cleanup_mm(&mm, &vmi);
-
-	/* Move a VMA into position next to another and merge the two. */
-
-	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
-	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
-	vma_assert_attached(vma_new);
-
-	ASSERT_EQ(vma_new, vma_next);
-
-	cleanup_mm(&mm, &vmi);
-	return true;
-}
-
 static bool test_expand_only_mode(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -1689,73 +1448,8 @@ static bool test_expand_only_mode(void)
 	return true;
 }
 
-static bool test_mmap_region_basic(void)
-{
-	struct mm_struct mm = {};
-	unsigned long addr;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, &mm, 0);
-
-	current->mm = &mm;
-
-	/* Map at 0x300000, length 0x3000. */
-	addr = __mmap_region(NULL, 0x300000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x300, NULL);
-	ASSERT_EQ(addr, 0x300000);
-
-	/* Map at 0x250000, length 0x3000. */
-	addr = __mmap_region(NULL, 0x250000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x250, NULL);
-	ASSERT_EQ(addr, 0x250000);
-
-	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
-	addr = __mmap_region(NULL, 0x303000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x303, NULL);
-	ASSERT_EQ(addr, 0x303000);
-
-	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
-	addr = __mmap_region(NULL, 0x24d000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x24d, NULL);
-	ASSERT_EQ(addr, 0x24d000);
-
-	ASSERT_EQ(mm.map_count, 2);
-
-	for_each_vma(vmi, vma) {
-		if (vma->vm_start == 0x300000) {
-			ASSERT_EQ(vma->vm_end, 0x306000);
-			ASSERT_EQ(vma->vm_pgoff, 0x300);
-		} else if (vma->vm_start == 0x24d000) {
-			ASSERT_EQ(vma->vm_end, 0x253000);
-			ASSERT_EQ(vma->vm_pgoff, 0x24d);
-		} else {
-			ASSERT_FALSE(true);
-		}
-	}
-
-	cleanup_mm(&mm, &vmi);
-	return true;
-}
-
-int main(void)
+static void run_merge_tests(int *num_tests, int *num_fail)
 {
-	int num_tests = 0, num_fail = 0;
-
-	maple_tree_init();
-	vma_state_init();
-
-#define TEST(name)							\
-	do {								\
-		num_tests++;						\
-		if (!test_##name()) {					\
-			num_fail++;					\
-			fprintf(stderr, "Test " #name " FAILED\n");	\
-		}							\
-	} while (0)
-
 	/* Very simple tests to kick the tyres. */
 	TEST(simple_merge);
 	TEST(simple_modify);
@@ -1771,15 +1465,5 @@ int main(void)
 	TEST(dup_anon_vma);
 	TEST(vmi_prealloc_fail);
 	TEST(merge_extend);
-	TEST(copy_vma);
 	TEST(expand_only_mode);
-
-	TEST(mmap_region_basic);
-
-#undef TEST
-
-	printf("%d tests run, %d passed, %d failed.\n",
-	       num_tests, num_tests - num_fail, num_fail);
-
-	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
new file mode 100644
index 000000000000..bded4ecbe5db
--- /dev/null
+++ b/tools/testing/vma/tests/mmap.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+static bool test_mmap_region_basic(void)
+{
+	struct mm_struct mm = {};
+	unsigned long addr;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	current->mm = &mm;
+
+	/* Map at 0x300000, length 0x3000. */
+	addr = __mmap_region(NULL, 0x300000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x300, NULL);
+	ASSERT_EQ(addr, 0x300000);
+
+	/* Map at 0x250000, length 0x3000. */
+	addr = __mmap_region(NULL, 0x250000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x250, NULL);
+	ASSERT_EQ(addr, 0x250000);
+
+	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
+	addr = __mmap_region(NULL, 0x303000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x303, NULL);
+	ASSERT_EQ(addr, 0x303000);
+
+	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
+	addr = __mmap_region(NULL, 0x24d000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x24d, NULL);
+	ASSERT_EQ(addr, 0x24d000);
+
+	ASSERT_EQ(mm.map_count, 2);
+
+	for_each_vma(vmi, vma) {
+		if (vma->vm_start == 0x300000) {
+			ASSERT_EQ(vma->vm_end, 0x306000);
+			ASSERT_EQ(vma->vm_pgoff, 0x300);
+		} else if (vma->vm_start == 0x24d000) {
+			ASSERT_EQ(vma->vm_end, 0x253000);
+			ASSERT_EQ(vma->vm_pgoff, 0x24d);
+		} else {
+			ASSERT_FALSE(true);
+		}
+	}
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static void run_mmap_tests(int *num_tests, int *num_fail)
+{
+	TEST(mmap_region_basic);
+}
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
new file mode 100644
index 000000000000..6d9775aee243
--- /dev/null
+++ b/tools/testing/vma/tests/vma.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+static bool test_copy_vma(void)
+{
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	bool need_locks = false;
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_new, *vma_next;
+
+	/* Move backwards and do not merge. */
+
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
+	ASSERT_NE(vma_new, vma);
+	ASSERT_EQ(vma_new->vm_start, 0);
+	ASSERT_EQ(vma_new->vm_end, 0x2000);
+	ASSERT_EQ(vma_new->vm_pgoff, 0);
+	vma_assert_attached(vma_new);
+
+	cleanup_mm(&mm, &vmi);
+
+	/* Move a VMA into position next to another and merge the two. */
+
+	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+	vma_assert_attached(vma_new);
+
+	ASSERT_EQ(vma_new, vma_next);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static void run_vma_tests(int *num_tests, int *num_fail)
+{
+	TEST(copy_vma);
+}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 2743f12ecf32..b48ebae3927d 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1127,15 +1127,6 @@ static inline void mapping_allow_writable(struct address_space *mapping)
 	atomic_inc(&mapping->i_mmap_writable);
 }
 
-static inline void vma_set_range(struct vm_area_struct *vma,
-				 unsigned long start, unsigned long end,
-				 pgoff_t pgoff)
-{
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-}
-
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
-- 
2.52.0


