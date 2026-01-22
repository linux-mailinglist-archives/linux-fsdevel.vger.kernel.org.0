Return-Path: <linux-fsdevel+bounces-75091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jb0DP9XcmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:01:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B66A9D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6C2303B7D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4C3859DB;
	Thu, 22 Jan 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kWjvy3g9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gEhWPiQY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A47377579;
	Thu, 22 Jan 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098085; cv=fail; b=qC6vJl6GVorVPxAq3aTW/XrCD9Inyj/HxLdbw90lAMtcvogxC5WfuQpNVlQbV7xRrrw4NaQmnAZtT/fDULzlzOwTBTFpf723sS/BzpncdrVZz+k8DuCuUJ8C/PySQNgTsAKm13Rc+u/ou2j57n1dZgSkQJTs/JnP8SuZwkXhvks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098085; c=relaxed/simple;
	bh=Q1Pm0o6cyJs4JAK0485OGzBjDGzsxyk8EPQatTP2I+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tc13bkIUaMqhkSamKqZRWjZK4r27FGj3iujWomhq3HBZo7R0EdWhLdO2BOFw39bN8uaSXL9zLxYoKdGBwTqHnOkhDe8HlcWhwixN9QuBxljlatB4Ughq03U/w3GcjzMIywNvQgIXnlN9/WRlmjIccM2f5RGT3mB/+eA4qiBhIQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kWjvy3g9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gEhWPiQY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgcLJ197959;
	Thu, 22 Jan 2026 16:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kR3tqMBCtJKOjtZkUf+jQdF+dfxa5dkIKxVbXnS+N/A=; b=
	kWjvy3g90wRe/30dEcF7HmNLdS3onwC2dpeLReAkOA6bBNFVeQsG7CDSkcWMgpvQ
	CD0OEj+fkfnupDpeZ3JPap/dLkybsXnd3nnUdOykOGDwF3BNaGDogu/8IisJ+hqf
	LL0DmdH1nNVHjD3ed/FLMP/aUPrnNLYBufEjXEWVLUd5N/lth32Cyy34SCZR/XXI
	myk7g/LkxUMn9FRiyVZSMRmKocm5BlBLqtHzGGCTnLsRBxxWipTD7Dg2fWLo0eZ2
	SX8m1Z1Fu/Fqho+2zxTnEi1f1w/ZjMqiLC51XwErgu65qDmjdJ1NFzamCZJG1N5I
	ceS0yt178gBDIP9boIcN5w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypyvm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEgcCL032257;
	Thu, 22 Jan 2026 16:06:47 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgusre-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkEBTI/q2tiUbZm1iRoQbeq/ay1adlewFNViSoR3wuRbI7gCsWVu/9SHnGHq2i0omFS/8qMq6solI5SPLY8hbF8akUl53AbE7z3LcnyrB0lrY0+xN03Nc/MypWqtPyY54kFPQ0t0lc66SYvpkGVIGmmpko3+WALVWHbnM+qHUFhG50lew47PZQ4iqOz5tRfkhy24BsoXS/7UKs3KEtLqxC3Fg3xzN5x9PU5Ej5izrwbjKehoFCJV9ZbKVeijOMmYMcWQEyM7hCyt2pjPWODVt7jP0eZUdUPM8uHYQXU+0sKvnA+z3Wf2ybGD8XZqr3+UWu8iVTjTcOkj1CiEreK6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR3tqMBCtJKOjtZkUf+jQdF+dfxa5dkIKxVbXnS+N/A=;
 b=A5D54rVQuqxTqj2xTHJyP301eMV3sXEakQnr3qNDs682DZbl2Z0zlJ/2XmKwfYHh9rkJnmPhBMO/mS6Fp4EZw1axJclPpLpysObqJjceoYUO5Lmz8yfsRta7ko19e6WCSzWgM7F64xFsxquwyf5o7yh5azYL38cTamkblWp4D09jqMGReGkHhQ4pJxG72UGZ7qAcyeeWesrOaKgs8a1IFasamrk73G0N7klX7W4rGUpUKyHF2p58gaNAalpM6H16xp3+io4vV3g9oeD8RgFNjR9LhJyDtFfmlp5k1Frvs2AWPk3rVe3AAEjA1Ahkj6yLh3XghV4O0Fk2x9Tsuq4o5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR3tqMBCtJKOjtZkUf+jQdF+dfxa5dkIKxVbXnS+N/A=;
 b=gEhWPiQYWCIV5Gy/rCMBQTM9fhK7yrbmREShPdQZ2Wk8t4XAm25kHi5IxfubXcFyAtCkp84xA4q1PImC/FZLjMsZvcl1gH08B6eb+CC428t/rN9nMLWkbpy058PAGYkEOoX0kN/n0bbKjsmvY8SPP4OlwuxWMt/UGqdIC+XwlmM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:06:33 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:33 +0000
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
Subject: [PATCH v2 05/13] mm: add basic VMA flag operation helper functions
Date: Thu, 22 Jan 2026 16:06:14 +0000
Message-ID: <885d4897d67a6a57c0b07fa182a7055ad752df11.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0020.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc50689-1d2b-4ea0-0516-08de59d0363f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tnx8NQHKy99YLjkaW9+A0D6XH0iWQ81G/jyW4apb36UqyzUK16xgcJvc0UIN?=
 =?us-ascii?Q?y0PUEKo5zlgW0G2IDdOmPaGfCeBjg5i9vOwvpiRWLwY+WIE0JBrWpHEXSQ4D?=
 =?us-ascii?Q?otXF+/o9bO2NlQ11kK6t0t6fahscZjDsvJITdWHtmWh7wLoOxFHPLU+Ddt7O?=
 =?us-ascii?Q?K2zh2V+jTPXqpu9638cCNX4aVQv3cDJz313rlSgji9lafUvhukytKVoyeSIw?=
 =?us-ascii?Q?6xFzEPZpccWm4TJ3pxvK9ej5LNTeLEVSCkNO79FYOs6bO+K2TyJw/oVLfl53?=
 =?us-ascii?Q?N+KkYkcEMuQid4fTpLN5CxVw8sX0qE11JzqMnbKeWBjbNgMWZw2esfxHKWGJ?=
 =?us-ascii?Q?oduATV9MFTJ8G+UhDDgT03HJvGio1fvV1tipTipQMa44LZxniu38AAgP6Kft?=
 =?us-ascii?Q?6iS9TLebKB34a63xljedIZ5DYopxCcGmeJFk9LGrE2xpKI4AxTt4rqYocWdT?=
 =?us-ascii?Q?6J7ssl5Du6/wl5aZ6BCtSLscXzLhTl4qMXJxKcxho2pgoZ1AhnVZ+olhNltN?=
 =?us-ascii?Q?eDiU4p3XkHYZzDq8o1yVWDSnVFJab068FJibe+BahqqDbTa1vYwcag1pqvNs?=
 =?us-ascii?Q?aQTHgd9S61i/5o4hDUmaaH6S5WkbxkgtWBjoKHUaoCi71QEImGcp1EZRfYtz?=
 =?us-ascii?Q?K1AuPvj+buiz2K5fpNY86lU2bFwImCsXOQxCk9MfyEcQssDvn0U2lDYsXGqQ?=
 =?us-ascii?Q?nS53ru52WPzVvE3/okhiWMNpy+Up4+8ivLkLtsDq8O/JNQ9DIRJnf3NEuh6h?=
 =?us-ascii?Q?ByscwXGlyrd3a4QQnruVIVGamHKyJqOhEsDYVh/ybHY77zxz0EN3gZIQ+pzA?=
 =?us-ascii?Q?SVmVhhsxz6AOL8QNyy7jstXRyy+5LTyD8geSsHRluraqGh5Rk4WwV++eVUd5?=
 =?us-ascii?Q?skdUeRgq9ZaTO5jbPn7yJzkb8pehoBIrEsw4Khzh+AUnTsKRNrBE4iom/DS1?=
 =?us-ascii?Q?6Qa5v3QvIDQ5kKXSK+hq480YTBQ7P7Hor3z8smK4erbL25/meJf/zFAHaoTW?=
 =?us-ascii?Q?TnVrE5x6Yi8zGxTmooZkQKAEcvhWJsjNSzTCNDxRXnymRprXlNsVhIrE08zj?=
 =?us-ascii?Q?cultjtki5aQy+aUD05Cn4joboY8vnwG/UawvrdvFzMCF6QE5lJ0g5Dv+KqP7?=
 =?us-ascii?Q?9Z7KwdVWUyv4YBqQDkf92SchxZ9FJMi4j4gPvR5pwLYBhXybEGCOjtPfI84G?=
 =?us-ascii?Q?g6cz1XLjxUVViZm2ZS4MBeVKAmmV1/Y4Olnwww1/FfqlK3fY8VrfCGxWVK6J?=
 =?us-ascii?Q?7XAW/so/80jxTAg2KVrsEPcLibNnru1gd5hSqm7LgJFoET0/eh23OPDBNHYD?=
 =?us-ascii?Q?bimY09Ot/6rOObpba1pb6WjiqxuULfSG3R4Nwe9wKJw8rbT0QGzDhPYTflmA?=
 =?us-ascii?Q?OArCxfwwYkEHr1LYxTTzr8pjIo0WWI44mZ3mtdBroQbsyzDWTpfr04n0W1Zy?=
 =?us-ascii?Q?AvOUfM+F3GIqLnYI08cn+lRRWrlO2ZcK8ZNAc+0RjI5+N6jd1Du0e4A97KcV?=
 =?us-ascii?Q?TJ4VHQagMzuMIhaOxVlsyGlvLm4UW2OusL+yuvg2qSKQOyLSUX8b0YYnSPRz?=
 =?us-ascii?Q?NEgha8dyt6KZuhLXo0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BGR4wNuYLvFTXVQX+H22qIV2Vyt9f3M8nTbdG5BCXg8n7ZLnLrxl1Pu8oV22?=
 =?us-ascii?Q?eoK+lTIWuW4Tq9vEU5HQMCMefhKzsFv4+seB2lvXLe8ZOxPKcimEIF5ogLfk?=
 =?us-ascii?Q?VzaJaVVxsQ6av+YX7abLP50R916yv+yZ9FvFT4RevUxE6aUnJFt08+Kn3whC?=
 =?us-ascii?Q?9mIpxa5cGV7dlqQAgKIZF76KLjB5gzKa2k4pWbIle9yRu36cO4IhehgE8c6D?=
 =?us-ascii?Q?y9CkQpTFqqlokXPtpkUC9bd9qUNijbBIWoqN8HLE5abXVxauNhIiqWvSYrhB?=
 =?us-ascii?Q?ZyXNOOg/ZAjrQu+A0oDmuVm4imt03iA18BDQMYPDGuSytz6DRcyl6ZcikxfC?=
 =?us-ascii?Q?wB5Qnna6HAa+qlhTOKwVdscI8B4eA2gLtshmoqlN1/4fJ19aq8kIbpVnLDqW?=
 =?us-ascii?Q?VYtFYybakrIuPV6dnvXJS1DyTOoCksGWCz51HWUoBioZ+QiaP+qybUkop8r4?=
 =?us-ascii?Q?Ot5MTKCYWg4Kw4fcRbbwe60iMd8yXtFeA2W5QiqhkbqJjonlnZHQ5LO9r0jA?=
 =?us-ascii?Q?Y38sVuOa3ZF0DYIlMuv943I6oXeYz64tUcfrsAweJZl7yVwdB9N3X0BEFHxu?=
 =?us-ascii?Q?9Ty/PNSHMnD0vLU9DaOLR+LXxxMDqF5D5XEJapfT54DSmaVYm9VPAtn1YaLD?=
 =?us-ascii?Q?JmJIbgtR9X4553I2+N3V23rdClRAjRRtuzGBJMndfteKjv47IZwG/qW7NMXm?=
 =?us-ascii?Q?fM9d6cU7T4xLjsQWS+vP3ZGvDszPAAUfgAJRRujsaBT3lDZLlytley9RB7qx?=
 =?us-ascii?Q?rnJgEpBrgujJPruHrTMHawTt/kfgPUqLiiB2vnbLrPyjncYvq1W9mO7V/qno?=
 =?us-ascii?Q?5U5AE51E0q2WYOwy7EmalRHJqQ2dIfgoIvEGxESHnASHOIJ/xr1SAfrc5piq?=
 =?us-ascii?Q?RYOITSmlFKuiV9St1epWTTMCWSmzwfloa1VPxOHQ5VG9VY7sQMfbOJibo/Rg?=
 =?us-ascii?Q?xgXSgLVlkcsV++VhVbKS9Vac6eK3OjhHF2YtVxQTL4I+rNpzpKITjuBERC88?=
 =?us-ascii?Q?hY+vBvCD2Ii+KZozEoWeUlcg2EJnZGyaoKl6af4TemBp4FkXaRtZIyC9Xhtz?=
 =?us-ascii?Q?gs99F+p8emRSZsxTKJu4sTaxOeceqMxz+FOKZGt7Ff04cqS+50ZfTR21nJxi?=
 =?us-ascii?Q?BWD+tukMr7+Y++lQknUp76L8/wL3KJE+crrTVhA7q3TxedHFGQrXI1zZdjPk?=
 =?us-ascii?Q?69hZG4Q0VokYvcxG5o1iND0b6u5Jb9iVV1GtVP0VQwEmzbtTW57kq2xC5krc?=
 =?us-ascii?Q?9CuYyj4yG1fVzVnL1N0dcH0wR6VD+6/DjMi+SWU6PgxvlPZ/jmOJEwkzBzGn?=
 =?us-ascii?Q?8uYTrdZiZub/nnkxaWkf7HZxJ73B0aVJLVXeRtO54U1HOJ/2BcWeKt3TSE4X?=
 =?us-ascii?Q?1GRn0YaFr1XPKLZnS88p26i7y/PoISn5g/Q4qEURxNkEuOFwHAXj0x5TKQEV?=
 =?us-ascii?Q?Ax6P/EzWtpuSRLU3SO3EDZcrUe5KgqMcl2r7nA9C6jTEgIOo0+TEX/8IzizT?=
 =?us-ascii?Q?VW6EYpmKhVTAISULoxz5G8dR1V3hzoj75tg/cMjsgE6CQARKEMaHqRqeVckY?=
 =?us-ascii?Q?TBYA1KM8KmlSY2JHmAkv57MoOTUdK+DLTDAmB8Fy7yXDFofC2FolCKX8xrm9?=
 =?us-ascii?Q?whE/pMaxr5bw6BdBre7Mym34kHK37w4aUQ/A0hwSqElIJOxZqSN4A6Cede4B?=
 =?us-ascii?Q?sFv3/8tU4/0A865TG2+Lql2PpzcIwmr/o//jWNAZBOn3r02IstqAWFSwcU8m?=
 =?us-ascii?Q?A2kHiOWX8je6WNI1L79rJFACCvWfRAU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aMPgcSfbHPULXczqHNRVnRT2xSv7d8Wu81DZDEY2dvuUit0DL2DYLuPJJk8waeQV18icwZjWBjF6ig063XXJYlTKRR0l8t0l1pNmh4xZheBWgLOy3ph5ualo9yR7FANivWKym93B+E3vkkSNGMql+wb09ZX6KUXfptCwdBEnL3Ozwqpm32s7a6jibtDxVSE6UfuAr6D5uOv24hUVQlMMbeM1WV7oS70ecYiSJC0QMX4HYW60g0ol5Y8YgudScbFyVvvHA1rhE95WE9UwzNBXr9wI+unH8x7kPwmHl+oE7a8eKD4HcI07zgVev10bB+plKz/AXgUdB5+x9idnFJHRtck70ZCyPir6XDvfLlNhACM677rNU+o45FhdNolhpWta5TIW1JhVXKXT7SbuXAZhLKQ2eKUKZPMottmwTpTgyGBZFtGtcW19n7hZeTzyYGqFisMIKHBpHtpv7wCdmDQFKm76sdVACZi0AKx/gjeFLsvS2yjWGey0a/idsLrkkuTqcGu/mE6Z/iIh1W8gRIgpIyENPN8gz2sRqmEZCLGutvCpKuCF/Jww2baf1dvqvghX4qKbMV+zYbMQOGxQSc9uA08d6XwcQLS70QyBpLG4xlk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc50689-1d2b-4ea0-0516-08de59d0363f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:33.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEgaPG5BO+7NXX7Te24lMnuQhpOIZRxtl7YNcvwrFSzo0Jc2PHL2Hzx10BwTexI6zNFDoTJNBY9No/no5B8YxGuI3mn9oA8yFRju0g24Wts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX278HqdxKMfxR
 3sy7ynxhHesVXZtqz8puNW0PdsCq5qgfzTaHS4r2Vf3oHVkqyu/VMAcg7SuoZRsTZaN30oRimvR
 VbUaSY4PnE+xIoOACOElmTG8J0cWm3ZpEUqQk1tTOY7dsIvUmDZqSWfV+PHjJ8ToSKjenoNnn9o
 Xva0zhNTxS0ZEsVWS/sKN6CSRUFT4m/AWvDKUoEjVi/3XRepcHRnM+eu3UViTwvSJXJ8/Ac2cL1
 1e43Zhqfkg0pgUdCYchENm1r6PpBdm7l1PX18i2q04m5TcXGPveqD6qKPdefuDcJWvm1NtEk51N
 WnnVOSVTFJrYD9b6SeJbDNTRMvhVSpI6Wy/A1KHzdxaNb1YjZj8vIFmba3cWlyelDT5EipdNxg2
 u+xMC/eNzbhEsUV5SNEMNeOaTbm0A9U6YqR7AnH1fuKRFUZKOd09G/fiY7n7/jj1007A+itF94k
 FFTG+rgsZZx/0NTQhlTHePU9eGMqJb5KZrO6i66A=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=69724b19 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=4CvRKFuNvIJ_q0EUuscA:9 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: Nsw0ULscyIHY4gfJBg8yCHwhZb3L8yVZ
X-Proofpoint-GUID: Nsw0ULscyIHY4gfJBg8yCHwhZb3L8yVZ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75091-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8B4B66A9D1
X-Rspamd-Action: no action

Now we have the mk_vma_flags() macro helper which permits easy
specification of any number of VMA flags, add helper functions which
operate with vma_flags_t parameters.

This patch provides vma_flags_test[_mask](), vma_flags_set[_mask]() and
vma_flags_clear[_mask]() respectively testing, setting and clearing flags
with the _mask variants accepting vma_flag_t parameters, and the non-mask
variants implemented as macros which accept a list of flags.

This allows us to trivially test/set/clear aggregate VMA flag values as
necessary, for instance:

	if (vma_flags_test(&flags, VMA_READ_BIT, VMA_WRITE_BIT))
		goto readwrite;

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT);

	vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT);

We also add a function for testing that ALL flags are set for convenience,
e.g.:

	if (vma_flags_test_all(&flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) {
		/* Both READ and MAYREAD flags set */
		...
	}

The compiler generates optimal assembly for each such that they behave as
if the caller were setting the bitmap flags manually.

This is important for e.g. drivers which manipulate flag values rather than
a VMA's specific flag values.

We also add helpers for testing, setting and clearing flags for VMA's and
VMA descriptors to reduce boilerplate.

Also add the EMPTY_VMA_FLAGS define to aid initialisation of empty flags.

Finally, update the userland VMA tests to add the helpers there so they can
be utilised as part of userland testing.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 165 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h         |   4 +-
 tools/testing/vma/vma_internal.h | 147 +++++++++++++++++++++++----
 3 files changed, 295 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 32c3b5347dc6..fd93317193e0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1059,6 +1059,171 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
 #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
 					 (const vma_flag_t []){__VA_ARGS__})
 
+/*  Test each of to_test flags in flags, non-atomically. */
+static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_test = to_test.__vma_flags;
+
+	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Test whether any specified VMA flag is set, e.g.:
+ *
+ * if (vma_flags_test(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ */
+#define vma_flags_test(flags, ...) \
+	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Test that ALL of the to_test flags are set, non-atomically. */
+static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_test = to_test.__vma_flags;
+
+	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Test whether ALL specified VMA flags are set, e.g.:
+ *
+ * if (vma_flags_test_all(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ */
+#define vma_flags_test_all(flags, ...) \
+	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Set each of the to_set flags in flags, non-atomically. */
+static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_set = to_set.__vma_flags;
+
+	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Set all specified VMA flags, e.g.:
+ *
+ * vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+ */
+#define vma_flags_set(flags, ...) \
+	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Clear all of the to-clear flags in flags, non-atomically. */
+static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_clear = to_clear.__vma_flags;
+
+	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Clear all specified individual flags, e.g.:
+ *
+ * vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+ */
+#define vma_flags_clear(flags, ...) \
+	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/*
+ * Helper to test that ALL specified flags are set in a VMA.
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
+					   vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(&vma->flags, flags);
+}
+
+/*
+ * Helper macro for checking that ALL specified flags are set in a VMA, e.g.:
+ *
+ * if (vma_test_all_flags(vma, VMA_READ_BIT, VMA_MAYREAD_BIT) { ... }
+ */
+#define vma_test_all_flags(vma, ...) \
+	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+/*
+ * Helper to set all VMA flags in a VMA.
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+static inline void vma_set_flags_mask(struct vm_area_struct *vma,
+				      vma_flags_t flags)
+{
+	vma_flags_set_mask(&vma->flags, flags);
+}
+
+/*
+ * Helper macro for specifying VMA flags in a VMA, e.g.:
+ *
+ * vma_set_flags(vma, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+#define vma_set_flags(vma, ...) \
+	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to test all VMA flags in a VMA descriptor. */
+static inline bool vma_desc_test_flags_mask(const struct vm_area_desc *desc,
+					    vma_flags_t flags)
+{
+	return vma_flags_test_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for testing VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * if (vma_desc_test_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
+ *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
+ */
+#define vma_desc_test_flags(desc, ...) \
+	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to set all VMA flags in a VMA descriptor. */
+static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+					   vma_flags_t flags)
+{
+	vma_flags_set_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for specifying VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ */
+#define vma_desc_set_flags(desc, ...) \
+	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to clear all VMA flags in a VMA descriptor. */
+static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+					     vma_flags_t flags)
+{
+	vma_flags_clear_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for clearing VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * vma_desc_clear_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ */
+#define vma_desc_clear_flags(desc, ...) \
+	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 592ad065fa75..cdac328b46dc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -844,7 +844,7 @@ struct mmap_action {
 
 	/*
 	 * If specified, this hook is invoked when an error occurred when
-	 * attempting the selection action.
+	 * attempting the selected action.
 	 *
 	 * The hook can return an error code in order to filter the error, but
 	 * it is not valid to clear the error here.
@@ -868,6 +868,8 @@ typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } vma_flags_t;
 
+#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index ca4eb563b29b..2b01794cbd61 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -21,7 +21,13 @@
 
 #include <stdlib.h>
 
+#ifdef __CONCAT
+#undef __CONCAT
+#endif
+
+#include <linux/args.h>
 #include <linux/atomic.h>
+#include <linux/bitmap.h>
 #include <linux/list.h>
 #include <linux/maple_tree.h>
 #include <linux/mm.h>
@@ -38,6 +44,8 @@ extern unsigned long dac_mmap_min_addr;
 #define dac_mmap_min_addr	0UL
 #endif
 
+#define ACCESS_PRIVATE(p, member) ((p)->member)
+
 #define VM_WARN_ON(_expr) (WARN_ON(_expr))
 #define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
 #define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
@@ -533,6 +541,8 @@ typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } __private vma_flags_t;
 
+#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
+
 struct mm_struct {
 	struct maple_tree mm_mt;
 	int map_count;			/* number of VMAs */
@@ -882,6 +892,123 @@ static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 	return __pgprot(vm_flags);
 }
 
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(flags->__vma_flags, NUM_VMA_FLAG_BITS);
+}
+
+static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+
+	__set_bit((__force int)bit, bitmap);
+}
+
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+{
+	vma_flags_t flags;
+	int i;
+
+	vma_flags_clear_all(&flags);
+	for (i = 0; i < count; i++)
+		vma_flag_set(&flags, bits[i]);
+	return flags;
+}
+
+#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
+					 (const vma_flag_t []){__VA_ARGS__})
+
+static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_test = to_test.__vma_flags;
+
+	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_test(flags, ...) \
+	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_test = to_test.__vma_flags;
+
+	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_test_all(flags, ...) \
+	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_set = to_set.__vma_flags;
+
+	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_set(flags, ...) \
+	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_clear = to_clear.__vma_flags;
+
+	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_clear(flags, ...) \
+	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
+					   vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(&vma->flags, flags);
+}
+
+#define vma_test_all_flags(vma, ...) \
+	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_set_flags_mask(struct vm_area_struct *vma,
+				      vma_flags_t flags)
+{
+	vma_flags_set_mask(&vma->flags, flags);
+}
+
+#define vma_set_flags(vma, ...) \
+	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static inline bool vma_desc_test_flags_mask(const struct vm_area_desc *desc,
+					    vma_flags_t flags)
+{
+	return vma_flags_test_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_test_flags(desc, ...) \
+	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+					   vma_flags_t flags)
+{
+	vma_flags_set_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_set_flags(desc, ...) \
+	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+					     vma_flags_t flags)
+{
+	vma_flags_clear_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_clear_flags(desc, ...) \
+	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 static inline bool is_shared_maywrite(vm_flags_t vm_flags)
 {
 	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
@@ -1540,31 +1667,11 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
-#define ACCESS_PRIVATE(p, member) ((p)->member)
-
-#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
-
-static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
-{
-	unsigned int len = bitmap_size(nbits);
-
-	if (small_const_nbits(nbits))
-		*dst = 0;
-	else
-		memset(dst, 0, len);
-}
-
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
 	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
-/* Clears all bits in the VMA flags bitmap, non-atomically. */
-static inline void vma_flags_clear_all(vma_flags_t *flags)
-{
-	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
-}
-
 /*
  * Copy value to the first system word of VMA flags, non-atomically.
  *
-- 
2.52.0


