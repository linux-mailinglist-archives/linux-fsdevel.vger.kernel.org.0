Return-Path: <linux-fsdevel+bounces-74444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6CDD3AD59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1465330F910F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C87387372;
	Mon, 19 Jan 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E1o6D89C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XPKfZz2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30E37E2F8;
	Mon, 19 Jan 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834355; cv=fail; b=b01lp/fgj9S1vVI3NS4HBQd90a9HOAsRB/EjufWFoxZDdLgj7renBYLRzTbKxNNtBlQv48q2Wm4X5VrT6BcYbwrTcbHqMJEcBdORuLqhWEvb74NO7ANVS8kkyHDYscfJ0EESUdYA9bs+1fYfQYQCrUOKr51QLEn84m5wAhDKfAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834355; c=relaxed/simple;
	bh=xqgjtJjHYnWo2j2ZiiEOGZFAJp/jh037MIkK/NtTdTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=up+N19iCxAvgHoVMzoZovZluVtxBho+I8FV2Ni2aKMv8zSMq8RQULpNh3QuRl8XIimZagYbHec+ZybkKsaTnEbmkbdOhpnoL4DCwAAfFBwEHbmIj13dg20uCjwUOBkbS0ihiZbwJSY+1D2spiLODqoYUbgQqRgtoFLydTz489zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E1o6D89C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XPKfZz2s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDPVc1512391;
	Mon, 19 Jan 2026 14:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EQRukAxY7x0joQbP8a8sJTsqdNcC8mGLEMp0pqQvg08=; b=
	E1o6D89Cnz7K3zF9yx/eLDNlagySWNHnddDs6juXPOjOwXSB4z+n0THry/JhUn+Z
	GmxGraY01mucfr6nGgN/hm7LXdJ5kZx46VCi5ROSQ5+eHZefEnF3NSdPEnpaUksk
	V7fYj6csia7BGHEZnNvdjHvcnpElLRbf3P48G4SIMvX1P2QyQTtYSqQhej/IVN7r
	NwFSTW/RMeW2rLTHJHxHIyB/Pl8/f3qoXM3As8tO94yZ03m93j6S6zoc+UfVtoUC
	9SSsg7GAzLqra2wHJf8ErFWkULnHf5r96uD/doxuzF1QhEAW4s9fjujdXeVP3fWd
	2lhibytiNIz7f0fsu2NsRA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qacj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JD0a8W022493;
	Mon, 19 Jan 2026 14:51:43 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vc7wef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQyqrJteX0yDzh/ongCDOErDqENU/kDKFJvt6NqhumvY4+uRY/byhIZs8Pmr4qjnhaSdOUQZt3KLK9zEuDCaXTVjB7TQkz6ZRXK3zjm0I+8WWvApOhjdEneO6qX512QEjVyLJMgKTyPNp+KteDDnRd7Jr7u2cI3n0EW1/C73lKoo0YLo0/QfmrMfJ/HjKsAE1Ib70mAs/BpRJsXxbUd99DXbKbtIa5Za7rBqb2RioBIjWEj4ibOowMYGSmmxdlK/TXtBc7gawv1Tw1AlYSLLWXGDhuXci6RtecIyzlTGspjRNbdZso2wlClKXqd9syqkqFzW0bnJLt1VGwlHp4e1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQRukAxY7x0joQbP8a8sJTsqdNcC8mGLEMp0pqQvg08=;
 b=aiTDFfro8lxiScTrCI541YRALrkWnYsOD3zmaFn+HwiE9F6upGLuVki23n2JuuhHpKwdZETMSUgI/k7ctVnPfUzxomfnUG/UqU78bvnrLVq6csMeauq2G1uhCVyP++0Iug6YB0CKaa4jRE+u327dnP/W0MFsloxJaMp7eERSh2d2j8nxwqV09VTpzIHSmKsBXo0JoqvoNvO24T4RJyC1i6+6P1zyBc0tjM6poglQVGbrHsiCEGXlHU+Asfq9AYTmnNGqdqFAwIF6WGPKCD1HYfITYiYqwg7yTijf8FqBjQ9T3DzdjewVM9EvSQALUGjCAjGb0BL6/cq4Gwwg77njSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQRukAxY7x0joQbP8a8sJTsqdNcC8mGLEMp0pqQvg08=;
 b=XPKfZz2sRjdujpPzPJFD3lGak7eblatVtYfw84DJmGFCoD9YUMWyblrkMlOZVZr3IdXqZiut+ce4x4xxh6tmTTdAY70TLvobJMtfsosb64mGg7jMxe3iEJj7cCjq8tlWT9GOPA17ilblw4oO3zNPHmxNiZ7Q1USpr2AfUGgT6mE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB7300.namprd10.prod.outlook.com (2603:10b6:8:e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 14:51:38 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:38 +0000
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
Subject: [PATCH 05/12] mm: update hugetlbfs to use VMA flags on mmap_prepare
Date: Mon, 19 Jan 2026 14:48:56 +0000
Message-ID: <39343423b10c7b342647af3cdbefc89908b1819e.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9f3bc2-9f10-488d-f773-08de576a3f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZXjj33KWTC2HcFMsiS8KDoG73I0gk0JrXKM/GYqNezqs/SrQJMEK/0CcLEl?=
 =?us-ascii?Q?rJxh1hHBsLeI5b80eIAIHbceJriQtxfXISLeGg8f4xa0KTsUGdZ/BicZSWeX?=
 =?us-ascii?Q?BUtygkT+DED5RF+rqh1Mq9PjbK0jYmCtkhTDs6gERTFtN+yHNrddjPdNCT7r?=
 =?us-ascii?Q?hbN++cGUc+EGHYD35ZfwWlaWmrcF1Ttr+bjSl9+RZ/8Wyz5wQDAoS6mVft8y?=
 =?us-ascii?Q?HEcpR105NplRDwE34W37AtGcro8P+TTfx1J54ZlsDX/3bXpRSjljLY5DBSGz?=
 =?us-ascii?Q?V6O/wjItCAZCR9G5H6dzymMo0g+XG1edCqO760zEe5Phr8WCfY03oRgeq+FB?=
 =?us-ascii?Q?b4ko48bZICYyt9W8Um5sBUYCLdAN92H4nOljT4S4DFA4Lwd3F4xCpzTR6uNG?=
 =?us-ascii?Q?m6wMhcLXapAoftHUo/6fRzHTuv3mUhYfGlyETN7u909/0MaU8Wp6ucp5J5m6?=
 =?us-ascii?Q?L5miIhLHth/CfshEDdiSLoWh3ooyuFYnEcD6zwYdVaWJwvq0xrTvXD8LQ5Z/?=
 =?us-ascii?Q?V7eTIybExdiJ+X9n88qm0syQxskusddKEyM49xQ0bzcgUDw7ry0ZuEutkDst?=
 =?us-ascii?Q?zNe3n8oA0UaqTMKGyuOSzZz8iMgwwsfW0nNtSHVw52ToJp5il3Wt25lFOm3w?=
 =?us-ascii?Q?+0JySlcuJCP6/RjesaMfdSKdY1kMS3IlXwyK/y/hPuLAN8EuH4IUidRAa31s?=
 =?us-ascii?Q?LaJDBjjtfeme01WrboiZ3gfknoF2lh3beluY00/L63+H8puaTzRNW52f01/R?=
 =?us-ascii?Q?bIdfTvd7xBHKF5EgCTZpIsbp2j77KzVZIOdcoSAPsJmZ/z4NKWaitL5yBP73?=
 =?us-ascii?Q?pFlDHmi4HiTLzxSQ+LUEYTyuuntWAfqXeLsj6Y6KxFQuKMOUvz9G4qLeRkAR?=
 =?us-ascii?Q?hu7x2kO2gOb6Up6rbFk7UUkE+pprV7eMqgyNoGZ24x1r8yO+jlmwe1CmQZfs?=
 =?us-ascii?Q?nbusBbvE7v1K4NCteRC0iA4lsFsMtICp0pV6Fw8bOtea+5SvKWrIuFtgzgpr?=
 =?us-ascii?Q?uGheDUr+bg6EK1hBMZQrua7kUtmOzIw92GH40/2lfNbiivHgqcwPFg6RPN8O?=
 =?us-ascii?Q?3U5fK5rIZKjb2B2XS2269evlcdcG2xwHFkfCTanxhicGziZWiUJO8TaVYT89?=
 =?us-ascii?Q?dJr3mjqUJ6Q+SXAiQH9wadQXbgUf56Kmaq93ayYvA1cplWYtxFaGkRcwt9l4?=
 =?us-ascii?Q?LEePqldzck4x08I0dfnXniqsaibRDBrMlaNN43zTH2xHCDpRjLo9Re+A2UMS?=
 =?us-ascii?Q?TqOgqJbFxTdbSvURZDXTAFyIR0IdPev52nlOqufhDHQ4LItjl1JSGx58VF/2?=
 =?us-ascii?Q?pSAXNwGSvnytXzML9VmKTbci37azH2qUTMlO+/hxSzaST+cbYYIprSXHK4mI?=
 =?us-ascii?Q?Rj5zN8PGp91Xw58WHDjZ/mTuuFMQlXxh1eb66kNeU0u5RtQ5WKiYb/HA+iZu?=
 =?us-ascii?Q?0BU3X3riHk9vN58vNc1LdKtOdJH0aLOpSivW27gtlGTE3GaSXoEVI7L3+kir?=
 =?us-ascii?Q?3RJlIxHNCNaDiHVpU2ioqqnyH4sBM7b3HUtuGtBYEGCXWeEZa8F2e+bFs90g?=
 =?us-ascii?Q?jKs7qjkg4ISyNdSm96U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qiw4Gmpo6coSzcRmXkqKggQKDRXSECs1hqxPbTlCkti53vyw2EKTOLRPngGh?=
 =?us-ascii?Q?1S4fhkEPJIzmkp98hiWT09W/o8/JbfSkV9/BNYWGQ9V5BOkfCHN5Kteqx0FJ?=
 =?us-ascii?Q?ygTxJi/r/JTAFf0aJNck4v90AFg8iqc1C//odygcHgmzW3EGN9xOTO5OzkVc?=
 =?us-ascii?Q?uhh+vHciXnBe5i88him0NKUmBkgHHYH52xrUH8+h9dmsqw38G/nFSKXvoF4g?=
 =?us-ascii?Q?Iq97Wzo8Boc01zQzgXAk1J+xjwxuLKAuqYAByTcKMIIFR6Jk1XR68cfdcC7H?=
 =?us-ascii?Q?/4YSlADtt2xto6vMoHM3osAB2OHHoGzAA+8/ICuRli/lUsys3UMfop1f9LV2?=
 =?us-ascii?Q?K3y/IvXFZXvrbb09rNF3WpPTMtwTWpyIApe7ZEoI6xyVMnW1+ISXb8p+L3+A?=
 =?us-ascii?Q?waybj6DLjpcRwgzbV6FA9FaTKN+44WVx+rceLonxQSKqjOl2b9VWbopAHrnX?=
 =?us-ascii?Q?r4P9qfZiPFpstgwodCK/7EVaX5U5wFOM0ZybxFijnRyiCN4TTOtrfNGLrVD0?=
 =?us-ascii?Q?0iAew/8yhapqS76SkEqob7cJFC02lqR1lWzvpP/pgeQhPOukMgVOXuG3X2+N?=
 =?us-ascii?Q?HtkxM+Tn/ync8JzSAOgSa8alw/TO3iAP1/VdzT1y0eoPPgyvKiwd/ZhDIxKx?=
 =?us-ascii?Q?ylolPtbwRZ642DZHVi0lwJv1bbSU3ExCFCUYSb1ForNstGzg0Qd3Wngy0opr?=
 =?us-ascii?Q?NxOCHIn+T312Y0cXUa055BaWl/MjXSUsDCR8Hm2Xo7QfczMO/xjua0ydMGWU?=
 =?us-ascii?Q?a/R7V1YETEz5IiWp1a1KMcEVGqyiGq91r9bqhRsMqm763M3sTLnV/XcJ63t1?=
 =?us-ascii?Q?QV4JFvab7r6+OZnbyber14bexx+1QwWRyDEMMtEmV+iEHDPwpUHRKNKx/ywK?=
 =?us-ascii?Q?1u4fHvj8BTRXJ0hXSpxMOlHty4+yV/+BieKD5U7Yk/PYjuMOSeNXao5iOES9?=
 =?us-ascii?Q?EUgK73mjHfRIti1gvPEE/0xCq0xPOgaXSkbxY/J0akLTUZaxSYpg5MNml9w0?=
 =?us-ascii?Q?SkXV8IseUz3VzpHCowssPOuh4xg8AhSib66kH+74xDB4lbQAy0HrFOxRgeyM?=
 =?us-ascii?Q?FpBk3L11ivAyXCvXOueQv7eKUYfuTYj+02AqF01CNcwYi9Zu7Ow/6KOIErHN?=
 =?us-ascii?Q?HQ/zXhUcJj3TJtwVrEixZfHEhFBevmm3M5ajkF8Gn0F+Q8swGNuUC2SF+j9d?=
 =?us-ascii?Q?7CLPhwnIf/7jbdbZ4Gwu3hUS/hTCf9S/Il4AdpCCVF3ot8eQLFyOs27YF5DD?=
 =?us-ascii?Q?gvGcrqcf1SkbuJWF7+SJBBmewQ4EGJoF1BKx1ysO+SLdE7yDLqqRQHuAfUx3?=
 =?us-ascii?Q?gKqmgfOPf4eYPYjBu36iDgC0QvQPBCdOsi93qElCqFMfIKKn8AkZU5bxYlBY?=
 =?us-ascii?Q?Y/7vvayBPlxaDTNbSuYCSVI2Z9sL3Jccs2Alblx+W7Ef6bfx+cAR0CATMu0U?=
 =?us-ascii?Q?3aileceW6XlrzRTminPNIFsRf7jyWTNEYfsd9L0HddwZkSFK83yjWsa7zze8?=
 =?us-ascii?Q?W2CLhPI9eCdgpv6P2V0il2MuRZwXOpIPXQHnNG8110Q+esUfpMNme72FRVp9?=
 =?us-ascii?Q?YVt8BkNx+Lg1lxm4FgaKZeJ2JKVeFyidRh+5rnJpn7CKgH1ECoRf964TCQ4E?=
 =?us-ascii?Q?HYpzxDyibOU63SROcWfa4EKz8XN+3YSvdWW1p9RgSIjYEoRzuQnLgqdmurqp?=
 =?us-ascii?Q?Ac1uzP2AQEY/JjqkAKHOf1l2b/mqRwkey/qK8DYXOha2G+HFJcm52fIrubq0?=
 =?us-ascii?Q?L1W3OVBHjAfKITIHh3jjI5QIfkDT/ec=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bJK/VAdspkGKex3EUO6aWyd6H2MZ+j+mlHZKEKQdwmM+RAUmtQW+aqOWbWDkwmcvb5wMXg0Vpqm7o0Myuif7+MWEc5AU5VXZk+RxTSR3D5QQRPkQ/snzC11C9CSmQ9Q7Af9oLgl6R0xwAt7RPL7MISCJeZf7MSdBqIrkPwNoPAHVb8siEwyEFsZL44B4VICaPfpYMbG5eeKt95upQ5iKvytH3ITelClD8Rg9ntwUyLYWqWPpKtb/ro8BJrcQrl7KF1Dyud7LXTs50eS6SXf35xmW/A7sDURfL/WRPTFnoFZQJktNumf1PfBM01GdDLH5Wz4u3+ijdN3EvGA1wqq5c6v496HUKnXSwmp5vMxe2uqdpYEQEBuwGzkxdBzvbqXSrqstPNwgwfwIkPZVnlOjOoepZst0C8iR7/FN1j/lj161UlecFFtyOcDWhDWvQXxLxp54O8IU/+cyvjAbtqYTbapXUf0lMB1s0aRjYLFq/dt7EbetTatRxmNsnzWXvBaU7ano3c3/LZ0aId38zx4+4qr0vnLgZ5S1FyV3bsAD+hiiOVpcDzNVgD6XTIdUPUkSpYaWUujn2VLg7grkJiDWHwnPP0wG/tn7PJP5WJzYpBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9f3bc2-9f10-488d-f773-08de576a3f1e
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:38.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThzWT8mq5yg9ZKSy5iHrPKJfIwuqX/50OLrSM+mH96dOV/4Z++ieDK4m6TQs7+cyzZxolpkENokvEhwaxtr9vrCbKdcFanXQDk73m8pm9do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Proofpoint-GUID: JXx3glgKwolw9oIoyJdj1W4CZDDb_6SC
X-Proofpoint-ORIG-GUID: JXx3glgKwolw9oIoyJdj1W4CZDDb_6SC
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696e44ff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=atHbPFec4puc5jveiVIA:9 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX/AjSDBhmPcDk
 UiXV9Lq4+laoEE/+ivH4MsRtrp2rJS2tdQUYmAaZnmvS+725wSVwHlcpY4niCmkBIvutXPlVrA7
 0U2LO0XMcw6EwfaHhX/CzAhQQukRsNVnT+JEFdPtcX8AH2tu3vBcai3sohOweGhz7uNg6ElQwiv
 LjMtvJefm6JkqVi1vAu9zBntBgSXaCm/nJobmE2GrKCpv1b1qVFMKkr4GIXKo4PsRTxw6mby44Z
 s/GELSifut1g9ir9f+89zVbv4Md6J57bLPp633FJMtV2ZvTTt1K5e04sLQjq31Xs1hmWbtyflaL
 n+Wq6AVAEUGVHCCo4vDc5TxVVOs24z88GTEXsFNJGXmdVURRdBu0xtbXg0TrR/Gbt+VW41KSut2
 9tdQGmF6+Xbk3kpKTQNYDOEQU3Y/9knaVAlUn6d29IjBSIsFR9NHLuFKjnGdC8CDFX4OwmInj68
 FjyhSkI1tm8rzQVsGDSu/U3vcDpLrJStq25JSzPg=

In order to update all mmap_prepare users to utilising the new VMA flags
type vma_flags_t and associated helper functions, we start by updating
hugetlbfs which has a lot of additional logic that requires updating to
make this change.

This is laying the groundwork for eliminating the vm_flags_t from struct
vm_area_desc and using vma_flags_t only, which further lays the ground for
removing the deprecated vm_flags_t type altogether.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/hugetlbfs/inode.c           | 14 +++++++-------
 include/linux/hugetlb.h        |  6 +++---
 include/linux/hugetlb_inline.h | 10 ++++++++++
 ipc/shm.c                      | 12 +++++++-----
 mm/hugetlb.c                   | 22 +++++++++++-----------
 mm/memfd.c                     |  4 ++--
 mm/mmap.c                      |  2 +-
 7 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3b4c152c5c73..95a5b23b4808 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -109,7 +109,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
-	vm_flags_t vm_flags;
+	vma_flags_t vma_flags;
 
 	/*
 	 * vma address alignment (but not the pgoff alignment) has
@@ -119,7 +119,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	desc->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_HUGETLB_BIT, VMA_DONTEXPAND_BIT);
 	desc->vm_ops = &hugetlb_vm_ops;
 
 	/*
@@ -148,23 +148,23 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 
 	ret = -ENOMEM;
 
-	vm_flags = desc->vm_flags;
+	vma_flags = desc->vma_flags;
 	/*
 	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
 	 * reserving here. Note: only for SHM hugetlbfs file, the inode
 	 * flag S_PRIVATE is set.
 	 */
 	if (inode->i_flags & S_PRIVATE)
-		vm_flags |= VM_NORESERVE;
+		vma_flags_set(&vma_flags, VMA_NORESERVE_BIT);
 
 	if (hugetlb_reserve_pages(inode,
 			desc->pgoff >> huge_page_order(h),
 			len >> huge_page_shift(h), desc,
-			vm_flags) < 0)
+			vma_flags) < 0)
 		goto out;
 
 	ret = 0;
-	if ((desc->vm_flags & VM_WRITE) && inode->i_size < len)
+	if (vma_desc_test_flags(desc, VMA_WRITE_BIT) && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
@@ -1527,7 +1527,7 @@ static int get_hstate_idx(int page_size_log)
  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
  */
 struct file *hugetlb_file_setup(const char *name, size_t size,
-				vm_flags_t acctflag, int creat_flags,
+				vma_flags_t acctflag, int creat_flags,
 				int page_size_log)
 {
 	struct inode *inode;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 94a03591990c..4e72bf66077e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -150,7 +150,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct folio **foliop);
 #endif /* CONFIG_USERFAULTFD */
 long hugetlb_reserve_pages(struct inode *inode, long from, long to,
-			   struct vm_area_desc *desc, vm_flags_t vm_flags);
+			   struct vm_area_desc *desc, vma_flags_t vma_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
@@ -529,7 +529,7 @@ static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
 }
 
 extern const struct vm_operations_struct hugetlb_vm_ops;
-struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
+struct file *hugetlb_file_setup(const char *name, size_t size, vma_flags_t acct,
 				int creat_flags, int page_size_log);
 
 static inline bool is_file_hugepages(const struct file *file)
@@ -545,7 +545,7 @@ static inline struct hstate *hstate_inode(struct inode *i)
 
 #define is_file_hugepages(file)			false
 static inline struct file *
-hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
+hugetlb_file_setup(const char *name, size_t size, vma_flags_t acctflag,
 		int creat_flags, int page_size_log)
 {
 	return ERR_PTR(-ENOSYS);
diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index a27aa0162918..155d8a5b9790 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -11,6 +11,11 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 	return !!(vm_flags & VM_HUGETLB);
 }
 
+static inline bool is_vma_hugetlb_flags(vma_flags_t flags)
+{
+	return vma_flags_test(flags, VMA_HUGETLB_BIT);
+}
+
 #else
 
 static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
@@ -18,6 +23,11 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 	return false;
 }
 
+static inline bool is_vma_hugetlb_flags(vma_flags_t flags)
+{
+	return false;
+}
+
 #endif
 
 static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3db36773dd10..2c7379c4c647 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -707,9 +707,9 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	int error;
 	struct shmid_kernel *shp;
 	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	const bool has_no_reserve = shmflg & SHM_NORESERVE;
 	struct file *file;
 	char name[13];
-	vm_flags_t acctflag = 0;
 
 	if (size < SHMMIN || size > ns->shm_ctlmax)
 		return -EINVAL;
@@ -738,6 +738,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 
 	sprintf(name, "SYSV%08x", key);
 	if (shmflg & SHM_HUGETLB) {
+		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 		struct hstate *hs;
 		size_t hugesize;
 
@@ -749,17 +750,18 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		hugesize = ALIGN(size, huge_page_size(hs));
 
 		/* hugetlb_file_setup applies strict accounting */
-		if (shmflg & SHM_NORESERVE)
-			acctflag = VM_NORESERVE;
+		if (has_no_reserve)
+			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
 		file = hugetlb_file_setup(name, hugesize, acctflag,
 				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
 	} else {
+		vm_flags_t acctflag = 0;
+
 		/*
 		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
 		 * if it's asked for.
 		 */
-		if  ((shmflg & SHM_NORESERVE) &&
-				sysctl_overcommit_memory != OVERCOMMIT_NEVER)
+		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
 			acctflag = VM_NORESERVE;
 		file = shmem_kernel_file_setup(name, size, acctflag);
 	}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4f4494251f5c..edd2cca163e1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1193,16 +1193,16 @@ static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
 
 static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
-	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(desc->vma_flags));
+	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
 
 	desc->private_data = map;
 }
 
 static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
-	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(desc->vma_flags));
+	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
 
 	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
 }
@@ -1216,7 +1216,7 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 
 static bool is_vma_desc_resv_set(struct vm_area_desc *desc, unsigned long flag)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(desc->vma_flags));
 
 	return ((unsigned long)desc->private_data) & flag;
 }
@@ -6564,7 +6564,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 long hugetlb_reserve_pages(struct inode *inode,
 		long from, long to,
 		struct vm_area_desc *desc,
-		vm_flags_t vm_flags)
+		vma_flags_t vma_flags)
 {
 	long chg = -1, add = -1, spool_resv, gbl_resv;
 	struct hstate *h = hstate_inode(inode);
@@ -6585,7 +6585,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * attempt will be made for VM_NORESERVE to allocate a page
 	 * without using reserves
 	 */
-	if (vm_flags & VM_NORESERVE)
+	if (vma_flags_test(vma_flags, VMA_NORESERVE_BIT))
 		return 0;
 
 	/*
@@ -6594,7 +6594,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * to reserve the full area even if read-only as mprotect() may be
 	 * called to make the mapping read-write. Assume !desc is a shm mapping
 	 */
-	if (!desc || desc->vm_flags & VM_MAYSHARE) {
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
 		/*
 		 * resv_map can not be NULL as hugetlb_reserve_pages is only
 		 * called for inodes for which resv_maps were created (see
@@ -6628,7 +6628,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	if (err < 0)
 		goto out_err;
 
-	if (desc && !(desc->vm_flags & VM_MAYSHARE) && h_cg) {
+	if (desc && !vma_desc_test_flags(desc, VMA_MAYSHARE_BIT) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
 		 * of the resv_map.
 		 */
@@ -6665,7 +6665,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * consumed reservations are stored in the map. Hence, nothing
 	 * else has to be done for private mappings here
 	 */
-	if (!desc || desc->vm_flags & VM_MAYSHARE) {
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
@@ -6729,7 +6729,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	if (!desc || desc->vm_flags & VM_MAYSHARE)
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT))
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
diff --git a/mm/memfd.c b/mm/memfd.c
index ab5312aff14b..5f95f639550c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -87,7 +87,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
 		idx >>= huge_page_order(h);
 
-		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, 0);
+		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
 		if (nr_resv < 0)
 			return ERR_PTR(nr_resv);
 
@@ -464,7 +464,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
 	int err = 0;
 
 	if (flags & MFD_HUGETLB) {
-		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
+		file = hugetlb_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT),
 					HUGETLB_ANONHUGE_INODE,
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
diff --git a/mm/mmap.c b/mm/mmap.c
index 4bdb9ffa9e25..35d11f08005d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -594,7 +594,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		 * taken when vm_ops->mmap() is called
 		 */
 		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len,
-				VM_NORESERVE,
+				mk_vma_flags(VMA_NORESERVE_BIT),
 				HUGETLB_ANONHUGE_INODE,
 				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
 		if (IS_ERR(file))
-- 
2.52.0


