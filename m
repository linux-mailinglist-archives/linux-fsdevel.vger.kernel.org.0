Return-Path: <linux-fsdevel+bounces-74681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDVZFerCb2lsMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:01:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B05D849006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE99938CE74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB01547B422;
	Tue, 20 Jan 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oYgRuDzL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BwP9u/zX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BFD395D89;
	Tue, 20 Jan 2026 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921959; cv=fail; b=TTTk5ynnimH6fdHW4O+5oqwO9D6YqL01p5SBb/k3oM6M1HCHQbM5NNKI5gbTX7XQVJA2/CZcoxDapbwEKZo7kgjUnNcVPQZKnvm54fUuCqzPHKai+4ARZWarFcQz+QtHZIynpyF219PUJPKQhDhX+znOhn5ZCGVcbOf18l0e3ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921959; c=relaxed/simple;
	bh=YTRtDUGb2Xt5C9nevYG1Jq8Ifu/uKRQeBMbjHX8AHs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cupU1BziJ8IQatLZl/X+ZS5iicu9f9jHroG9PTHes80IvJxDnM2CSffKgUeuE7Es8TwWGQH65/ZTKfv6A3bpmg3CGnKdFJtqid+CvtmqQgdBUQ9lrjVRawiU03+t710B9EI0FEoI3o5W3gajptDmF7yKGOPNgA8Z1rD5VqXzs/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oYgRuDzL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BwP9u/zX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7vHXT3523936;
	Tue, 20 Jan 2026 15:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=50hrOELBDbhERj97OW
	SU8+qfureZunBOSOIB2UVQlX4=; b=oYgRuDzLp6+Gp0ugftv0ubqbAtgltSJ0qT
	qkrM8RrwlVy92nMyFw+9e+NEKCbIyU+CQhwhPAXg18QTOPPfES54d1HlX0AJLJS+
	mnixTSxrN07ZSOWvbd/8eijc9oJCiT6UM3j7r1Mafz7sroajivlrxh9mwXNqwQRz
	En6NA1K45pM6/3GWc+XoCwUIDtvcvNOQX+ww3rR+b/iIlEVCPHY8qQjiMjTOYDZj
	ghnxagYNsAdiYHDxOJv2gY7WYB0eW8+Rpj0qbi0Rn1nWvNUsJfM0E2VPxFAl34iO
	tAPYDkrj9OAx05fExhztzKw/QjD6b6s9AWzZuQlwHEZduZEaEMHg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qbu86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 15:10:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KF20Nu037842;
	Tue, 20 Jan 2026 15:10:57 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v9sg9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 15:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyzyI1e9SafuOKYrPadFI69L/rKljUGx8FXFlytTRhgSwlSO9uAR21Ptc8Zn6RjMAL1ZVKV2zpHjcwDEzs3ZLCexWTYDNFN3QffTIDfXEF0bBeYu6B5gPol4nhnl9X0NKU1YIGuw9Jm9GTCnQG4t0NnuNRDr+5dhOwwT6ugFGFUQu5yg9NO2kXLcj3oDQ1QKmTQzhULoRdzIt98t/NCk4RT/W87SiJu+42JOmC5VcCco+o9Qy4Mb+Sh3O266sc3ksfsSU2dDs7SCCjlUGNtmYEkp1bbkelOx6eZ2DC6YhrVeok1IYF+/TMgRUqI3pouvTshh4pj64yYMDnQNPNuYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50hrOELBDbhERj97OWSU8+qfureZunBOSOIB2UVQlX4=;
 b=EOfrHhr+SBmRqokREx5THkOrzq0yZL0XcjsLVhhqyNpXIztM3/X+4VPPWbBEISAc5wgLBVEmiBP8j+mFhg1ScQ7vkf6RijfPX23A/nSNZIv7V0XCJrqd5KgfzYKV8XHShWgym1kblOwZAruBOcxIfipGqX/woBaddwpoVix7fw5FQCZl9hjJ5Su6vJ6WD/3vSkHEssQEZGnyj29N5QMnE7k9IDDHmI8PlESRKmNdtyR2Ys96N25SUI/ws5BegJX3Q9sWoPhhCykp5rDTKJpVTqQr+X+sZwe9lUmJQCNCakPUKrWtntdE/H8PaZZsISr+eRY+3nwRpiSQULQr6d44JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50hrOELBDbhERj97OWSU8+qfureZunBOSOIB2UVQlX4=;
 b=BwP9u/zXfp0PUgGSjkZBKgrSESWiQcUsrtkMQQ/QWKiRBIhmmFO7S+KQJUV5oSrrBS/fDIid1pDxIt7G+GoIYLcOhJhvek3X2RH/uHBKEfphit+PKIcUbkWV/+c6MKJqVGDRO3SojnAgSPQxaGQz0OghnbR9zFVkstegkUwEFs0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH0PR10MB997595.namprd10.prod.outlook.com (2603:10b6:510:381::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 15:10:52 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 15:10:52 +0000
Date: Tue, 20 Jan 2026 15:10:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t
 only
Message-ID: <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
 <20260120133619.GZ1134360@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133619.GZ1134360@nvidia.com>
X-ClientProxiedBy: LO6P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::10) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH0PR10MB997595:EE_
X-MS-Office365-Filtering-Correlation-Id: 918fdbbb-2b7b-4c03-ef72-08de58361a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ShsyOO/gEOPFKo7DJVgkG0eZFbrGDXXe7/VitR7Vv8yyIPxnc0ooEkxgFCI?=
 =?us-ascii?Q?/lMD6wGjvXA33trx6OkbaDOYnJ/rCwMBnwLZ+SO2g1ViMA1pqcJO9aZkAnES?=
 =?us-ascii?Q?O7/v0Pi7r3ibBT+wtWTlhUTVVeqC+YcUpOm2ajWidAYdC85ghYIFn5kszKjY?=
 =?us-ascii?Q?AwX+lLcz495bBoPR61FRJJTQejmvm6jWAxMifVWfust9MT1RkthGD5GDK64D?=
 =?us-ascii?Q?9qQW8XovwJyjUmY08dnmLIn3EovdcKnQOVfoTvtPIHT/KcqiUgGkXxsF7AAD?=
 =?us-ascii?Q?LKKSGMjEJmanLktR92CBiWV17oHcNTfrTCKS432ETOIvbIV1rVL2n5dwk+b3?=
 =?us-ascii?Q?QE3i5QBbE9OHcTNObO7mniA6Fiq66kSE886mUQY03M+TsWGcdmROH9UXeXOV?=
 =?us-ascii?Q?pxTZ8NhNaz5FzCzDqfzi2CRKZU0KRgKFTwIWGLaFcL1g5wr7TMWkwbYTIbn7?=
 =?us-ascii?Q?I45nycXdYVp88CcWq6s6xoup4YjWbsddXoc+ERuUXSFc8OdFu+IN4wJ34T68?=
 =?us-ascii?Q?WpP1XxwVt+dRsVrZWgf/9zV5SeMCCyIigouihSXkGbzim3mnfg8BTdkHs43/?=
 =?us-ascii?Q?QJdcZ2NFlzbNi060tRfBjeIscV0Ec6CTTbVg1GvySTbd6T1ARrpCwMrXB8iM?=
 =?us-ascii?Q?HdKDXcl7fbFr+ITcAHc2BzyVEqcQeCXD3AaJ55k5i5n5RwygxP9PRXdKtGjm?=
 =?us-ascii?Q?yq0oJttoccfcqyF75XCK7iZ8ziDQ4eQBRz4jhrPzySRu+kUaJyViG1et8EqD?=
 =?us-ascii?Q?y+OoP31f+yayyF+pGOdOwib6/1GxX9Zu2iuZFpy9AtrVWI2ybi2UqM764Hgw?=
 =?us-ascii?Q?+32g3w+z+5JwPcaXBNY4RmRc1oyPOgP5d+808A3wNgrTksi6FtLQfxwQ5bxa?=
 =?us-ascii?Q?+RowVY/6NFaB2CfvfeIvcNmhvB74N7KrETivADGmB2XFTM9Or8Jeg8x+3ASs?=
 =?us-ascii?Q?POCfkL+lxaMrzt/Ao2qF/Siuer2Wc0rOvhKCZOZQRh/xrjWfkDW8TjMyiSLQ?=
 =?us-ascii?Q?BfV/Fhm7RrpjrN2cf3h+lcNHSauu5wC20T1/Dq31+Q2nA4Env3Q7hJo4Ajac?=
 =?us-ascii?Q?UvGY9Gkmt55xJC1qCZfFYawlueqwTcHK/lgHVV6MJpHiaoAy+yTMSPB1Ny1Q?=
 =?us-ascii?Q?POtgmUGQCCaBt07VNbTpD93p6p675uHPg2/aXUVdEGjXIAoADMrvVeM6YfxG?=
 =?us-ascii?Q?Z772PHBH4338R0+nIRa8XYOxsa456olKAjnFzydwosJKec0hw+Il3b+OOU4m?=
 =?us-ascii?Q?m1UNMlrEPaUFmVNM5iE4OHPFvq0u0p7VP4SVYdeJ2eMgynal6CIM8exAHa79?=
 =?us-ascii?Q?7f8X64HvaJkGI8k6XxSMWgH5rnnZq9OekLVSYWAtB/dnNHPtEGfznQJ5rMgU?=
 =?us-ascii?Q?DxWoNMQKFZdBzARV5Fd6owMV8KfSi5Gn5kWavAgilMQWcJr75KNy1VJf6EPK?=
 =?us-ascii?Q?LyYeS0sIxEH+5hFhHsiXCZuiUoUSLxen5UD8iJvu79TBwtJDsBgFem+PFri2?=
 =?us-ascii?Q?UmDOr0upxC3ohdiMtVOgKXESWRRp25Al9DW19hkm3LDMV5j6jQwYxjUzaEs3?=
 =?us-ascii?Q?4K3euMaOwBa82vzw+rc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MoKTjnZqwdNT+lKaG7KIJkqnHcNJdOrIMR2ndWLiysv546z+xw8NBr9PBnbY?=
 =?us-ascii?Q?owB5Z+SVX769q/WNCgh+wKbdAgwcq0XRui2thmi/bx5FsyqR/E4sYYPCLFUw?=
 =?us-ascii?Q?8o3M1xe2ctE8EryGInzt8m5ujkpGyW8tApUCbb5fumKYK8b6mKGAJSTpwhs0?=
 =?us-ascii?Q?/IW2wvgSUYw0k4R8kFA7vyoTL67fZWbLW9W3X+0poMdif9QWpFxJVUAMdaMA?=
 =?us-ascii?Q?bqurtsHTIqVJjG7YOhpytFQVTzm+YFHr4C9qv2yGYyF2UVeulK+sfupp2YMv?=
 =?us-ascii?Q?tdPx1P4Gl0nMmgBtYTITh9F0V6NTSHaQd9pZxGCxj5v5FhYtDiQGc0imOEas?=
 =?us-ascii?Q?iF+H2fyHWnI2Tqps53Tf17vAP+gLdH2h2Ar8W90j5EqS4RNeerP3Ob26R3V0?=
 =?us-ascii?Q?FzBOFUNlp13qwwKBlD68Uaf82NDHEBSnT6OVgMjQI6X14kyvuQNbeqSGh8EO?=
 =?us-ascii?Q?tMOz23qqhdS/VGsJl2bRvxXusTKnvMT8dexrYYRHCOjL/OinG1mLZHIV5eD/?=
 =?us-ascii?Q?t42xGpCkjGvt0AcgH4HVvkNlr//j0d19/w/omNpOxXkQrWobd0OHsJNY1LZv?=
 =?us-ascii?Q?3Wyx62cdkqjQs4jCbWNkU3TMnKsx5fxPuEV5B+vVI1EJvhJdbX7AE7jF4O/o?=
 =?us-ascii?Q?O+ExwbQ5uxuI9aw40gQOB8U/bigdoK08mjiTwgKiI0jKZbAjQC04HYNtAgyM?=
 =?us-ascii?Q?Y1kS6f42HV+C2WRTtNKil6x1XC5170u2wh5gfmFy9QwSX35ybQbcun6Mhxfo?=
 =?us-ascii?Q?Hfq3J4R9gXDgpqEUMr+0SZFZ5ODq8njW+gP9tlQsNu9kM0u1HoOesreqk5i2?=
 =?us-ascii?Q?UlKUWi7QvAYCYSWHa+6P21/hR0axn8eB47R6OJQn6EhSCG6+aawPpR7cjack?=
 =?us-ascii?Q?lzwq7cx0rx3nsC4Gzv6UTAXWiBqD0chP1vxZ2TfFbK9HlvSMF8Yj+WhQfqlC?=
 =?us-ascii?Q?YMd+n9X6Fk5bGqLCoOjMahvjrPlqxjsI0liPGwSFd+5crMJ6SF/QN9OgajU7?=
 =?us-ascii?Q?qABtje2LoMZ84WRwfAbBrvIXEsblbqaEqFBZ4xpJJKpgg0ejDvoKXCsFu7qf?=
 =?us-ascii?Q?+BcwlsbFNmoFw+pBCIISALEgQ8R9cT0e9uW+MZjoPYyrm26keLSY1FDbHV6F?=
 =?us-ascii?Q?mGZlML5APxQqva8Vm0jPq38Zk6j6sqPRS9YNhW8HpaZ8AHSXusky1TJhmlbX?=
 =?us-ascii?Q?6lYQ27xZzz38TxD5mI7+GPmZOaJMTfYhEO2f6zpilfvaaH5ai6GxY6fZY47C?=
 =?us-ascii?Q?Q+0wHTxCpq0WBbfUUSWP47IItvK61geaRgX2rk+NSt26X5zR2lYvScWrriJX?=
 =?us-ascii?Q?7udAjUed8+qbTlx2+EcyJj8jP+wSGGJ3jyevxdEX69JLtE+JiREx8sTBRsk+?=
 =?us-ascii?Q?FGQRW2dpSvPPj2ZJ451XN+MpyfM7/tAPmcFUXIrhfC2MFgSR/uc98WeX/33x?=
 =?us-ascii?Q?RVBNDZTxc8TfSZAGeEGDP6EQvFacpbt/JuSVcNt1OQF6z+cs+kZYq7JWXUHG?=
 =?us-ascii?Q?wuLpDHV/Hv6mdD+eAV9x+s+OA/YzLCzYRqI8qd6es9w6aci0AZEz9kbMFQXc?=
 =?us-ascii?Q?uWvpjixtqmRs4qMP4F3omZXGONT9iXVqnev3k6zzt/ELA68jypVExY/5f13N?=
 =?us-ascii?Q?jgmlFUWCPCYUmTfJIVGZBbB6D0TIYZbDgu/ghY29syRtCsk8vv60C+1X8cMP?=
 =?us-ascii?Q?T0PunNytDcgcozWvJM9D/WTFebDbMt7dJ5pQ1bJ/sizYdMHa+dhgIes+v0Xf?=
 =?us-ascii?Q?6C/5j1OsQ3k0NQDViE0nTWlN37xQLfA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	adB0hw8chaEsxsWsM7XtJhbPEAuyFaHE+863nVOcYfqdAKI67VvZEZuCw3/DnzhIoZctgk/xwjk+P0Do+GSJNHHQ6XU75rA++aKObhYHRuKWT/7z2tVZdEEnCnM7irVsrrAV8h1YQPyhERKIIcSdfJzIoCYV7BZHiQKNZOv6zrHs4uS+cw+ceyCNgIxA97oePZeTmAg3IrzWv0McZKUPM7QGQZ9OO+9JFqlEzRn6DN/WPp4otcuO4BgMWeyzWTV7u14BK7R1uQK0HbP8TGdvIwf2f7kSaUDXg056AZoaU2qZtg0pirYImTaS1AG6bo1aTgi/EcfcSzG3hc66a0LYM6F0Yo+a0ERX1auI4UTHk+sCY0XtwTcqsNKPQmb33JUxkbn3pwZhWvd8i74dRhc+BLce6njiafiluy4vbBF8Uog2jph/RS0znDNqmIpWafRjc6aHFdjEByT2xkDhKWyYMwsRb0b4rpoanstBm3Kd8350ZqDHWlKjC+KCXyFFbKQIjGc3jRA4pb9q7iuQXLN37hO5xmvmy2sF3gxisKzNr9xrFf69VhNUDkwv0jC17+Bw4QUeafXpfgXSmFoCnZkdIjsGHanSUa4RRgB/3sXqnos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918fdbbb-2b7b-4c03-ef72-08de58361a3b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:10:52.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6buiMPEgkTIDQl2u3atTRb2RhSYR+JFGtM9Wq5RIdcu4Lf8uM1URyfKcjpZcaLOewPncS8SPlbSpbz/MC0gDLtlqR7nWVTgTz/Aazlzf6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=985 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200126
X-Proofpoint-GUID: CnkwTqrA78BkfgcC4I1v5GaB9JIPPlmg
X-Proofpoint-ORIG-GUID: CnkwTqrA78BkfgcC4I1v5GaB9JIPPlmg
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696f9b02 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NbbQPaNqh1ZckODCHBwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDEyNiBTYWx0ZWRfXyHl3VEbq+f5m
 O2Ufvb+UDZ+A4EJntc5F1uz9RHRgZ9BWeaqn/heiXyh0ZHsslp/9XvQH5EI8xprcjS9Cz67Gf76
 Gf9EhV/kH/25+Wg+lwkUfGjbckHjxTm420hiA/JJnq2icLZExoqv1aQFJEkXHUxekoSMqkKR6qE
 f7x9+MrJ5barOQPt9ziybu34QAvIeXpN2RPLlx8Wz/6S/jX6Ejb85Jbimo/KOoCRvTKAJdmwq0S
 MJZl5ENKN3lmzoEi6wz/5FXPE+cGBtgdd8gFroeLw2lfhbSuUs6tT4rZpyavzXhtvlOzJJBUE+f
 B57XRe7GyeNxuSwNntK0rz0LTIHSDRJeyw03ndpEOGFFTBXSGAO2fXUNrk5KkdcWgNrHEhvphz7
 LK17Iel0IqGzv/BMEqKYJty9qEOJRpgYuclK6hp5q7f7254Iyl7V6+GacI+xL99YcDp4bvcvRAw
 xJMtJ4gtOx34+qnOO9w==
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	TAGGED_FROM(0.00)[bounces-74681-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,oracle.onmicrosoft.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B05D849006
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:36:19AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 20, 2026 at 09:46:05AM +0000, Lorenzo Stoakes wrote:
> > On Mon, Jan 19, 2026 at 07:14:03PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Jan 19, 2026 at 09:19:11PM +0000, Lorenzo Stoakes wrote:
> > > > +static inline bool is_shared_maywrite(vma_flags_t flags)
> > > > +{
> > >
> > > I'm not sure it is ideal to pass this array by value? Seems like it
> > > might invite some negative optimizations since now the compiler has to
> > > optimze away a copy too.
> >
> > I really don't think so? This is inlined and thus collapses to a totally
> > standard vma_flags_test_all() which passes by value anyway.
>
> > Do you have specific examples or evidence the compiler will optimise poorly here
> > on that basis as compared to pass by reference? And pass by reference would
> > necessitate:
>
> I've recently seen enough cases of older compilers and other arches
> making weird choices to be a little concerened. In the above case
> there is no reason not to use a const pointer (and indeed that would
> be the expected idomatic kernel style), so why take chances is my
> thinking.

With respect Jason, you're going to have to do better than that.

The entire implementation is dependent on passing-by-value.

Right now we can do:

	vma_flags_test(&flags, VMA_READ_BIT, VMA_WRITE_BIT, ...);

Which uses mk_vma_flags() in a macro to generalise to:

	vma_flags_test(&flags, <vma_flags_t value>);

The natural implication of what you're saying is that we can no longer use this
from _anywhere_ because - hey - passing this by value is bad so now _everything_
has to be re-written as:

	vma_flags_t flags_to_set = mk_vma_flags(<flags>);

	if (vma_flags_test(&flags, &flags_to_set)) { ... }

Right?

But is even that ok? Because presumably these compilers can inline, so that is
basically equivalent to what the macro's doing so does that rule out the VMA
bitmap flags concept altogether...

For hand-waved 'old compilers' (ok, people who use old compilers should not
expect optimal code) or 'other arches' (unspecified)?

If it was just changing this one function I'd still object as it makes it differ
from _every other test predicate_ using vma_flags_t but maybe to humour you I'd
change it, but surely by this argument you're essentially objecting to the whole
series?

I find it really strange you're going down this road as it was you who suggested
this approach in the first place and had to convince me the compiler would
manage it!...

Maybe I'm missing something here...

I am not sure about this 'idiomatic kernel style' thing either, it feels rather
conjured. Yes you wouldn't ordinarily pass something larger than a register size
by-value, but here the intent is for it to be inlined anyway right?

It strikes me that the key optimisation here is the inlining, now if the issue
is that ye olde compiler might choose not to inline very small functions (seems
unlikely) we could always throw in an __always_inline?

But it seems rather silly for a one-liner?

If the concern is deeper (not optimising the bitmap operations) then aren't you
saying no to the whole concept of the series?

Out of interest I godbolted a bunch of architectures:

x86-64
riscv
mips
s390x
sparc
arm7 32-bit
loongarch
m68k
xtensa

And found the manual method vs. the pass-by-value macro method were equivalent
in each case as far as I could tell.

In the worst case if we hit a weirdo case we can always substitute something
manual I have all the vma_flags_*word*() stuff available (which I recall you
objecting to...!)

I may have completely the wrong end of the stick here?...

>
> Jason

Thanks, Lorenzo

