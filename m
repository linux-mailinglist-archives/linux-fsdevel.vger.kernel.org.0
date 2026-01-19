Return-Path: <linux-fsdevel+bounces-74445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B172ED3AD5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF74830FBC95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839BB387592;
	Mon, 19 Jan 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dQnPr6WJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P7eCqUiV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC555361666;
	Mon, 19 Jan 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834355; cv=fail; b=ri09jmNHG9v0GhgCK3AFJkbDdugGEbfUgI/RcgFp0i6pF7Px/qY9q0drYxWL9yVAl4RZTqNLICfL/zDEFz+JvtDubIrq2s2H/M2Oj230lH9WeRrij+ILN/38UItNBEbFDbCm3CIlRUVBABpbgsD5gIZLiYnIwDbwscab1cGv/3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834355; c=relaxed/simple;
	bh=Ms9E0VTVRySVQhJlksH+mPceTP6ymay+Oza+5dsRO50=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ix+9ztIPDhijwTVGKUKMVsm0Dd8tVUK7chzI4ppveQbPq//7J50J1ta7PBfII/iSF/F2yes+BngnF7fzejpo4rHREg9T3vlk4XGxJesH79+OhfnH5KtpD8VV9ecyLZddfCiqmnO+E9kwxGWnVzMug/yxHyDWQ/cPmCBEWfD28bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dQnPr6WJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P7eCqUiV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDU7r1341867;
	Mon, 19 Jan 2026 14:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=IuPW6PAtd5jWuOg1
	TMejuLE6Vsz4hQ0cp40QJrq2ado=; b=dQnPr6WJbOq0XeZIVEPZGS6dSXTYxO8S
	BcXEKAdneCov1XHZXCLMipirXNMZKe3fRYwr3L4cwXoSUcQF5naRcoxSqMvrB+/g
	mir1LLo4PUMxaa9FpOhEBai5dqOp9+d4jm47HxYnevxdXHO72PzUuZiuFt+273Ei
	rprvHMBNBM/qpvCnQts+630yjbLXxFeB0IEQenOZShRA3QCumPrcBB9AChb8XUqF
	NHKfXUuj2QoAHGFMIXBf1J3RcCriBX1Wd+qVhLKMiLAagfBy4cEPqhtj1V8TjOn2
	eTEfrrFaI2zN0ZDQfMzo+w7Pnzpu5bK5Ry7uBba2OTXP7mg5OUJYZw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br170ae15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDoTxC037770;
	Mon, 19 Jan 2026 14:51:35 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8f6rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFYSnbvYddsIPsvR2NEzOcGCR0JsE97O57W36mo/WTuqX+/tbV/yT0qWKc2bbzA7EL+Dv1mNEF9RMioMDPONp93IK2iJwcEcYsDaTH6hJRX0J/L0SInW0WOAyfyfoPU+WsrQO2MJ99E7K2lnXDJCSBIz8M7tY/NIYpizv0trU9OoGRGhHyq8hEUua9ynPY8D9XJwmb4gnzTtqhYlwOgZdAxG4N2V60hERsOgiW6evFnqxCKWnOvPkt8aHTAhOJBt8QhLXgILGk63RSuetTJHYcoEo90U2MEVp6x78oGDOHngNWQV0sU+6OOpKob93gLBRTPJc//mEQQ67tY68m/Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuPW6PAtd5jWuOg1TMejuLE6Vsz4hQ0cp40QJrq2ado=;
 b=GFq7N2zLznS3lPA98QPELawhnSe4Znod6qAjrOYMNZsx++q7bvNmGVKh/XtpAVdOzn30EUaviv8JZRKFjTYz42Mk09dYyDNNEq6ZH44o9iaCk35lRaUZTWE8JDKlFgPN7bjOAWrQDlaUXgtHIS2rayzDyGCHAlJ2MmrfGQ424ht4fbr+6vqfpBB/yLSp40BQ34BrQGUJjcfEQtMTn4x/RHkv9sSQy841FHg7c7/Yxl0u1r31kqjaF7c78VmzaOmQRk9YdZIFka9KMPSZlRQq+rmZBy3rpWPUEoWrdEs2Zx2qKkyhNKK5G8r0a9ooJY0QoTS+hy0o6vLhtqLwlWWMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuPW6PAtd5jWuOg1TMejuLE6Vsz4hQ0cp40QJrq2ado=;
 b=P7eCqUiVBeHN4C2DhahdrDfdTX4yYMG/d4DSdCz0djUCC0t3DdlMXXKOP4QIUsk4UwZRRw8OrinlTswxzVyZQesjeBEUHrqxQ4x25hutawwOdoZoFejQPW152gOBOhpgcS+4Ajhe3GUGFfFOuuArfItZ/c+ETAixWNp7vPAnLK8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPFD91C619EF.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 19 Jan
 2026 14:51:25 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:23 +0000
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
Subject: [PATCH 00/12] mm: add bitmap VMA flag helpers and convert all mmap_prepare to use them
Date: Mon, 19 Jan 2026 14:48:51 +0000
Message-ID: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0466.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPFD91C619EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d71518-b371-4e2b-d00e-08de576a36b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Er/fv1lCt43RooOw0bYk6QiAnebzzvs4LUCEvdljlFh5V3emxOIR7+z3sSB0?=
 =?us-ascii?Q?+PTih9Wa++I3absfIEm6KlqmdfMRgf92xvQ97YsGFUaoB1h8Cua2R3HG0VFe?=
 =?us-ascii?Q?h9lKiiU82U00z/rdbV1wcClcwq/uTerfLA807F5iOCJmFqRInFnmHxca6/zh?=
 =?us-ascii?Q?L+6bxXoTlAvQXcM53+djQhxRc2lT1ubNbKX6oPSKObLccjbEEULtZp3dztXj?=
 =?us-ascii?Q?mkk4oeuacN8PAdgeAYj6pZISx72jWhim6mIEDmWFMqOrLgrLKRDJnpim7fn2?=
 =?us-ascii?Q?GmhDol8ZZoTbRJIBiPCl1lrLeRKAeF66EqNZWEReCDSzD7l1Keor5Tdj5xxM?=
 =?us-ascii?Q?ZpjOefBN3LoQvR6Qf5gYVirTiw/nwY9T1kRIKaiKOwCC0M0Xymcew4VA24sW?=
 =?us-ascii?Q?KBTNX+beVFrwIiTkk7gnz7A41tCYJP14W+qJ+A6oon6QkJcKk3KI0YPG5hc4?=
 =?us-ascii?Q?Ci26Bnohj7DGzO1WJKAv0yc3DJKzBWRuy8KsnJ+8/j7Z6BuNrgnkXdhkbzqs?=
 =?us-ascii?Q?8q1XqXi/ZVFD/oSGa8B5ydaVuvD508ujUXgtMVSy+EY5CkioTPTZ/c/iYgwi?=
 =?us-ascii?Q?yKQobWAoJRU+6y2TqZrFIwM+bu57FMlJR0g0TxeZYiTnZI5FazB2F6hW4tVx?=
 =?us-ascii?Q?6HunoaCj/1wyeA+Ap8xYNb8hcvyNkKaCR54hHUfYUMhU/N5+IfFSTH3lcibw?=
 =?us-ascii?Q?B4T4cTAs6WtvfsHz9uCDrfnErarNZGoc+eWENxMGsqw+4tjbaztm7F41VjB7?=
 =?us-ascii?Q?bAn7FrPPNOh+M7E1W4nIqyPMUzZPOgkhbvT3HH0hAHy4bETTdhxJrT87QXE+?=
 =?us-ascii?Q?f4zU8fJp/NkghsrSSCSBMKeThsvx/JAn4V8CY94wBncCylhA16ihGpOExcKH?=
 =?us-ascii?Q?zyanO6eTBazfOFHuddg56T+2Ra/846RZxEyE0bzfStop6XIG9G6aCPZ7i6P+?=
 =?us-ascii?Q?jJJRDg8SfEVF3rVL7H2SaXGqdaqkh2h30CdLMvDtZcWOW2qT2LsrO54KanEH?=
 =?us-ascii?Q?VBN0kr6v7KLCoEzFNuKPnTdDu1gDPcgNTpgVy3qvMqMXxRhvU5z+GrDPZsuG?=
 =?us-ascii?Q?eOCVYHGLmze9xaf88TLeZ4omIn1vfFLI+S2vOzwPUoEALKO1wJh6JsJ/Rv3H?=
 =?us-ascii?Q?uNRIa6ewGdUVBDll9SXslNxKoaen8apTONpq6bxvvuCrYGUj048AfveU8xc1?=
 =?us-ascii?Q?DlnNRumZXGgIEO81G26ii4JXx5faFUzU5EapNCh/GswAadGNW2goIzZ3YTyI?=
 =?us-ascii?Q?XwrRafUZ49w4dzP4I1prlaIKv7RILqJPeqBRKQ9q3g6pCaWi31216t7t8zWV?=
 =?us-ascii?Q?DSeAlzvZQ+Tw87i8aXfBOVxoR65CgHqdMI1wSC2I2I0G/oZTVBtxMHgp0jJ6?=
 =?us-ascii?Q?rRxw/QCSmQPrwfA9z1tSUXgKg6qwC3eZGnNy5rKfFQWT5NqMCg/9TbQkuKXR?=
 =?us-ascii?Q?KcJSiiJVR6r+3VgXIGdMLEnwrT+Kn1TFK5zplE0Ag0qYkdCifYZFsEsxVo2+?=
 =?us-ascii?Q?gScThf9dJ6tJBwUsB1c8KXKR7aK2A+LyHCcGMrqQaspzzZm2tKpT6XQAyFhz?=
 =?us-ascii?Q?ocpeakuPvioaiNHI1vI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?px6TTQ+K1BcR1x8j3PFwaEhRF+wPuCR8KrqdrUOg0PdNwoRL9IiHtSxrg9T2?=
 =?us-ascii?Q?N4O38uSNwUDxyfOvwED6CPFryVZzWl/aZ/8Ayk9PlNcpUX65oxn31HBSaR9q?=
 =?us-ascii?Q?PvIZhcwnzwRhgBvfyNht9ES3y2jSsK114hDG8StzApr27Wg+cPCBo/DWJCwX?=
 =?us-ascii?Q?BIzRIMgZBoKh9tCy+f9r15vRVBRrm8uQKNsVnoyHXIWYm4WSLCCRCkLdiwpK?=
 =?us-ascii?Q?ZqE5aj0Fqsj+RFDf4FXU3TIhAPWmgTkYW6ILQ2FV2Ms4VfKZTzkEc2nwl9rm?=
 =?us-ascii?Q?naJ85DI32zpn9iK+Q1cbihbTs8mTFXvcTHLZXXT1OvwfwqSdDcMZB61copKw?=
 =?us-ascii?Q?NdTwk8WEdRBz/MU+k2bNiKgNjKCc7rTEIgO5SDTzs8l6WV0c107ZBz85iTk9?=
 =?us-ascii?Q?Ae63Y9r90Aei3XrpM5fXeuDDMp8Qj4pp5/H3mBoS9b/+C8T5ZJoWXy6Vge51?=
 =?us-ascii?Q?qCq0Ck0FR2dhMArI/7CwubGvSEGW5iXNt39A/sXMX4s3TSVpFUrV41+F4FRT?=
 =?us-ascii?Q?BsmX8yJpA0Mrxo9cYxw/lNRGEf5Y+Qz/ABg+9a6543BA6F8CEma6tThxSO4m?=
 =?us-ascii?Q?dsy43/yRvxhE6uhmmBh3nuVcIS6fbUII2caBeTEhd6sHi5DCB1GkRIHdsAPp?=
 =?us-ascii?Q?MoOMYpJZmEpyDesvxTfasavZru8VulOVnxfEqT4Kogv5Pl0Vrk4eNmUheuiP?=
 =?us-ascii?Q?zDes40fB7cqoh35gHQjsO6qc9EC7CseZA3XyH/7HE04R34+zbtiAS7nAWhCD?=
 =?us-ascii?Q?jJJ5gIplkfPX9bVZFgCHkmoWQ0Nh4cM6xZVBjdmUDJlt6WGWD7yE8iT4De5v?=
 =?us-ascii?Q?GqFYauiIEaEqm760YDNEXGVN4a3zpbAzYimfXu8l+hY64yUuArSY+rF7yL3m?=
 =?us-ascii?Q?hlDct4nF8zjmT6pvuAvzBOIr9zbEVnTACLjXxCua12X+kzvHnbftwHYqbFIO?=
 =?us-ascii?Q?YKZrZ4bdXU7itwgCzrj5Za3yQNQqvVq+DqX7pmz35pUHwVCIVxVlez7X8+4g?=
 =?us-ascii?Q?b9tfHr35BSolE7q4RtXDeJa6Nr6tGwMWl1IhljvuAGkSyhQRZt+BeuRsPlsP?=
 =?us-ascii?Q?TggWzHkNbmxKf+i4HOzKAgWCBZhpBoGZ7WxKpzUuQSebibXY3GnBD7yyg8VW?=
 =?us-ascii?Q?0s/EoZuunuc085gF+ICjLivsdG+MDBVZNbHRH3wvZ1bV+vjS3v+iehVhIzPV?=
 =?us-ascii?Q?aIkluRA7z0WeC0o4J4taHGf+IKLpeDVeKFguMu5LwS1Por7gpLyI93qTgRem?=
 =?us-ascii?Q?oIDvqIJO8d+OH2pJ8ZK7FVjGPFADWWJySTr1PgeR0J/SzrILMW7914sy7gcJ?=
 =?us-ascii?Q?ThuywwAhHh07PW9ozEgnooG0Rg8R/CFdQikkTD+C8l38DvJhgHX/o8HrbhyE?=
 =?us-ascii?Q?hZToXpwG9FnYKoJZO4uBRCPPj4N73ewG+0bCFHFcsqpOVt1Z6cYROsFGlINs?=
 =?us-ascii?Q?fpZUr3cWAEb7mySaxyzAhITa09iFSAo64Ko9VwSagQTl4SNlaBnN20RZQ72Q?=
 =?us-ascii?Q?NmaziN/CYeZBxgug4or7N9fEWUxfQnDZsywQ5v/ZBm5LiwkO6JZQtPNt+59G?=
 =?us-ascii?Q?q++pWsEvy0BIyQ2jiGDYFdku/riI8gmkRh5LqC+byYMVix9G04WHAo4CBm8s?=
 =?us-ascii?Q?WLUxK2Vsg+q5gpP5GSaZ978Lkf4Vv0dZ8iJvz10lFkD3gtnTFX/hJQaGWPae?=
 =?us-ascii?Q?vbJuigwzZ2sgnszAiba/FmaJonCcrHtMk/Uy7srVddxdfa0uEiRyYonQzX4q?=
 =?us-ascii?Q?TdYneOp2V0hFfHyojuoS99ZMnfnKVAY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sy9y7t2ynx9TAABrQThjxEc/KSpnnJ6VfbS8DO1xT5s91UxFw3vBdXP3nOwRuBi3+qnTBBsqiORVp2lTwyY4o7Efa0sCx/xdtnYQVed3M5ew8HYwlaOb0NlUxCTwYtSBW9jkaS13bywitMV6sR9pQD1ilfZGxGkhFqkMbg18pbi+avcNL05C8llaxMdZ6YWLHp7Nwrz3bTx5f+7u2w3ReOx59sRZ9VqbHHct3KJJN/ekQBnFA9dDwGCP7PJP6WfL//8TrWX25Y62Kq87EsZjZGEm1/MJ5kCcA7wYbQgjut0KEaHCE8qLzIJ5ASIwSawV0XAbNcEMw5zpEWg5lLzjvMnH+5f+snXKai2l8w6ibR2f+LO8XWQUAaosb8a0qVjUDMnQCm8JrO+zJKiXFPaWHtzNQnSdFADwr71OpoeO7UXs3p5hbLkBtu9Hs97idj+lpFy8R5TUOXhyp9WlrINU6fV25xKWmKed2/4exRRRKlC8E2IQyGeeCPyxCdFPjIPtkiUMCy6MGhKDG/O6Ifici/nhekoArh7/5ATcsrGAFPTyn5iO4T03sFCMdcKbD+jK/aiLR3qge3XYQLgN0MZ3t0E7m51aDQHwdk7XGhqQGCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d71518-b371-4e2b-d00e-08de576a36b3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:23.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdRPgTL97Mxns6ErI9WpiZ3NqL+ZSjjeKTPNfECVDG/PiANGD9FJouAZkfB/EmjzrR/zWMiRB42qVGHR4SIofz53RJXH+vQh9r1fswnssa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD91C619EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Proofpoint-ORIG-GUID: jJ0a0100_uWFJHxpsPkMgKVINa5nQhCI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX7OyGjfu2s5RM
 jkSS//FLT8dpiEoje8z8BJEhmOALi8fcQdCx2n3kkSo2hgBv/oHT9ZPWme55NIMPDYmEytRwt07
 SkX94YelkJh6/yySRowjty1nff8mbfHw2p8/Bzmd1UZWDxs1KMoXtFEKnbnJsWpeiaV/NT6VJTc
 NjpaIaezSoWOwzmPh5jxjhKTZkHPMX+hPxBYqud3IdCRhvEXfv1QrLc5QZEA344HXeb0WeKuWZn
 TMnQ2B8Rd1WN4/l8NffIftmEHgPlrAeyITuMeylFT/dtcdR0WxSPTiWpojG7szV+pPOjqOB835U
 LlqTTKI+A8trw5g/Skgi9UrmWyKikj69J+/ZN4nYxtKYXP5CerNDgk+v+HGKyfH+IaHPGyujcJ/
 IrjWl9u5AbNaTZP0+FDtP+WC0enwWznr12mDsEZp/JXeqKFEPA2PJC5SN3lLMT+vJkT8AtQMgCN
 q6ZGRp7gLRTUoESz+jg==
X-Proofpoint-GUID: jJ0a0100_uWFJHxpsPkMgKVINa5nQhCI
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=696e44f8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Gu8Ga86ZO7ieT4smRq8A:9

We introduced the bitmap VMA type vma_flags_t in the aptly named commit
9ea35a25d51b ("mm: introduce VMA flags bitmap type") in order to permit
future growth in VMA flags and to prevent the asinine requirement that VMA
flags be available to 64-bit kernels only if they happened to use a bit
number about 32-bits.

This is a long-term project as there are very many users of VMA flags
within the kernel that need to be updated in order to utilise this new
type.

In order to further this aim, this series adds a number of helper functions
to enable ordinary interactions with VMA flags - that is testing, setting
and clearing them.

In order to make working with VMA bit numbers less cumbersome this series
introduces the mk_vma_flags() helper macro which generates a vma_flags_t
from a variadic parameter list, e.g.:

	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
					 VMA_EXEC_BIT);

It turns out that the compiler optimises this very well to the point that
this is just as efficient as using VM_xxx pre-computed bitmap values.

This series then introduces the following functions:

	bool vma_flags_test_mask(vma_flags_t flags, vma_flags_t to_test);
	bool vma_flags_test_all_mask(vma_flags_t flags, vma_flags_t to_test);
	void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set);
	void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear);

Providing means of testing, setting, and clearing a specific vma_flags_t
mask.

For convenience, helper macros are provided - vma_flags_test(),
vma_flags_set() and vma_flags_clear(), each of which utilise mk_vma_flags()
to make these operations easier, as well as an EMPTY_VMA_FLAGS macro to
make initialisation of an empty vma_flags_t value easier, e.g.:

	vma_flags_t flags = EMPTY_VMA_FLAGS;

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
	...
	if (vma_flags_test(flags, VMA_READ_BIT)) {
		...
	}
	...
	if (vma_flags_test_all_mask(flags, VMA_REMAP_FLAGS)) {
		...
	}
	...
	vma_flags_clear(&flags, VMA_READ_BIT);

Since callers are often dealing with a vm_area_struct (VMA) or vm_area_desc
(VMA descriptor as used in .mmap_prepare) object, this series further
provides helpers for these - firstly vma_set_flags_mask() and vma_set_flags() for a
VMA:

	vma_flags_t flags = EMPTY_VMA_FLAGS:

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
	...
	vma_set_flags_mask(&vma, flags);
	...
	vma_set_flags(&vma, VMA_DONTDUMP_BIT);

Note that these do NOT ensure appropriate locks are taken and assume the
callers takes care of this.

For VMA descriptors this series adds vma_desc_[test, set,
clear]_flags_mask() and vma_desc_[test, set, clear]_flags() for a VMA
descriptor, e.g.:

	static int foo_mmap_prepare(struct vm_area_desc *desc)
	{
		...
		vma_desc_set_flags(desc, VMA_SEQ_READ_BIT);
		vma_desc_clear_flags(desc, VMA_RAND_READ_BIT);
		...
		if (vma_desc_test_flags(desc, VMA_SHARED_BIT) {
			...
		}
		...
	}

With these helpers introduced, this series then updates all mmap_prepare
users to make use of the vma_flags_t vm_area_desc->vma_flags field rather
than the legacy vm_flags_t vm_area_desc->vm_flags field.

In order to do so, several other related functions need to be updated, with
separate patches for larger changes in hugetlbfs, secretmem and shmem
before finally removing vm_area_desc->vm_flags altogether.

This lays the foundations for future elimination of vm_flags_t and
associated defines and functionality altogether in the long run, and
elimination of the use of vm_flags_t in f_op->mmap() hooks in the near term
as mmap_prepare replaces these.

There is a useful synergy between the VMA flags and mmap_prepare work here
as with this change in place, converting f_op->mmap() to f_op->mmap_prepare
naturally also converts use of vm_flags_t to vma_flags_t in all drivers
which declare mmap handlers.

This accounts for the majority of the users of the legacy vm_flags_*()
helpers and thus a large number of drivers which need to interact with VMA
flags in general.

This series also updates the userland VMA tests to account for the change,
and adds unit tests for these helper functions to assert that they behave
as expected.

In order to faciliate this change in a sensible way, the series also
separates out the VMA unit tests into - code that is duplicated from the
kernel that should be kept in sync, code that is customised for test
purposes and code that is stubbed out.

We also separate out the VMA userland tests into separate files to make it
easier to manage and to provide a sensible baseline for adding the userland
tests for these helpers.


Lorenzo Stoakes (12):
  mm: rename vma_flag_test/set_atomic() to vma_test/set_atomic_flag()
  mm: add mk_vma_flags() bitmap flag macro helper
  tools: bitmap: add missing bitmap_[subset(), andnot()]
  mm: add basic VMA flag operation helper functions
  mm: update hugetlbfs to use VMA flags on mmap_prepare
  mm: update secretmem to use VMA flags on mmap_prepare
  mm: update shmem_[kernel]_file_*() functions to use vma_flags_t
  mm: update all remaining mmap_prepare users to use vma_flags_t
  mm: make vm_area_desc utilise vma_flags_t only
  tools/testing/vma: separate VMA userland tests into separate files
  tools/testing/vma: separate out vma_internal.h into logical headers
  tools/testing/vma: add VMA userland tests for VMA flag functions

 arch/x86/kernel/cpu/sgx/ioctl.c            |    2 +-
 drivers/char/mem.c                         |    6 +-
 drivers/dax/device.c                       |   10 +-
 drivers/gpu/drm/drm_gem.c                  |    5 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c  |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c    |    3 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c      |    3 +-
 drivers/gpu/drm/ttm/tests/ttm_tt_test.c    |    2 +-
 drivers/gpu/drm/ttm/ttm_backup.c           |    3 +-
 drivers/gpu/drm/ttm/ttm_tt.c               |    2 +-
 fs/aio.c                                   |    2 +-
 fs/erofs/data.c                            |    5 +-
 fs/ext4/file.c                             |    4 +-
 fs/hugetlbfs/inode.c                       |   14 +-
 fs/ntfs3/file.c                            |    2 +-
 fs/orangefs/file.c                         |    4 +-
 fs/ramfs/file-nommu.c                      |    2 +-
 fs/resctrl/pseudo_lock.c                   |    2 +-
 fs/romfs/mmap-nommu.c                      |    2 +-
 fs/xfs/scrub/xfile.c                       |    3 +-
 fs/xfs/xfs_buf_mem.c                       |    2 +-
 fs/xfs/xfs_file.c                          |    4 +-
 fs/zonefs/file.c                           |    3 +-
 include/linux/dax.h                        |    4 +-
 include/linux/hugetlb.h                    |    6 +-
 include/linux/hugetlb_inline.h             |   10 +
 include/linux/mm.h                         |  244 ++-
 include/linux/mm_types.h                   |    9 +-
 include/linux/shmem_fs.h                   |    8 +-
 ipc/shm.c                                  |   12 +-
 kernel/relay.c                             |    2 +-
 mm/filemap.c                               |    2 +-
 mm/hugetlb.c                               |   22 +-
 mm/internal.h                              |    2 +-
 mm/khugepaged.c                            |    2 +-
 mm/madvise.c                               |    2 +-
 mm/memfd.c                                 |    6 +-
 mm/memory.c                                |   17 +-
 mm/mmap.c                                  |   10 +-
 mm/mremap.c                                |    2 +-
 mm/secretmem.c                             |    7 +-
 mm/shmem.c                                 |   59 +-
 mm/util.c                                  |    2 +-
 mm/vma.c                                   |   13 +-
 mm/vma.h                                   |    3 +-
 security/keys/big_key.c                    |    2 +-
 tools/include/linux/bitmap.h               |   22 +
 tools/lib/bitmap.c                         |   29 +
 tools/testing/vma/Makefile                 |    7 +-
 tools/testing/vma/include/custom.h         |  119 ++
 tools/testing/vma/include/dup.h            | 1320 ++++++++++++++
 tools/testing/vma/include/stubs.h          |  431 +++++
 tools/testing/vma/main.c                   |   55 +
 tools/testing/vma/shared.c                 |  131 ++
 tools/testing/vma/shared.h                 |  114 ++
 tools/testing/vma/{vma.c => tests/merge.c} |  332 +---
 tools/testing/vma/tests/mmap.c             |   57 +
 tools/testing/vma/tests/vma.c              |  339 ++++
 tools/testing/vma/vma_internal.h           | 1847 +-------------------
 59 files changed, 3033 insertions(+), 2303 deletions(-)
 create mode 100644 tools/testing/vma/include/custom.h
 create mode 100644 tools/testing/vma/include/dup.h
 create mode 100644 tools/testing/vma/include/stubs.h
 create mode 100644 tools/testing/vma/main.c
 create mode 100644 tools/testing/vma/shared.c
 create mode 100644 tools/testing/vma/shared.h
 rename tools/testing/vma/{vma.c => tests/merge.c} (82%)
 create mode 100644 tools/testing/vma/tests/mmap.c
 create mode 100644 tools/testing/vma/tests/vma.c

--
2.52.0

