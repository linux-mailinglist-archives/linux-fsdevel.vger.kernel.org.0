Return-Path: <linux-fsdevel+bounces-74598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A12ECD3C46B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5012B5660F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12B93D1CDC;
	Tue, 20 Jan 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K4cjbLDr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="egiiLKQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776E3446CA;
	Tue, 20 Jan 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902425; cv=fail; b=QYBvsIvR0t7bdjvvcAN9fHu1HaBMaQdMCH9Zrt7WRfxyE2nMrPiFbSKUvvf+nOsB2jmZU1ucF6vjIG/lQ/mR6NQWTxIbgasPKHf8IyAb8yTtOZ4JSZN4WtUCYMhY3Xj1QVtTh5wU0OxSbfBRkux99/oaGFs894xv42549HNa/yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902425; c=relaxed/simple;
	bh=FhysQuq+d6AgTujh/zTwjy6F+WpTkhjNAUelcNxan9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TqOt3dSsDZjeslxvCLeR0IuEnckR6o69WGnIKYBEBnKpoAJQjveZbU41FigXHe8BF9lt7wHZ8pOhiiM99eGKvaUo0QHSG03cEP+t2Qu6s72X1VLe7CDBmNuuk1yHisaS2lP1pHM3AeC/oyraPSmHSTooCwho/kfpn2XhuIKKEIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K4cjbLDr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=egiiLKQ6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7vBPG3032110;
	Tue, 20 Jan 2026 09:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=M77DeTmiu2mhkc0uvM
	+9aXg7cAIQwydOwnqc4LX7rxA=; b=K4cjbLDr0TtI6EzfGoDcgLroip0vELjikM
	raE9zDuwQoC2VY3afMJ6kz6iuteruipQOaHxZBAlpmWKoO361uAFIY+2Db7lxoi5
	AwI/ZVZa6M/Kuf0M5xSPwDrCgCTDAs9ZmJoKrXfHIbHIyyHKQZa8Bl4YU2XZhztD
	7TNkNOtOH7AfvtJwmkFsOxJZARe5awn89HBts+jKg7Q03kcN5QU+WX/dlb+hvPuj
	xnq9OHsD7oKsM0yKt2Mx1w8k5rwSDJIXXhFl9PyAXwfrJlQJ1alCtluQoHXUmEz/
	GvBPrV5jH4ycezYO8iN/WWuAFuLo8kKcXAmPpz9vpl8xH2jaGaGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypu7ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 09:46:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K8dUjo022493;
	Tue, 20 Jan 2026 09:46:11 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd589u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 09:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/3zQX30CjidoU6qeB4zRs+hjy5C0680xdUON1dXGKfGDO5PHgiwFa592JFLNFFmtpiweGGCNsa9TQ51bczgwB+sSk7AG9MbNEYdH2NLNVfBCqemQDl6/RHafuadGFnBHKBa1Yu+0+OiarWc1cmQJ2ADFxmO7a0mAv6pDrVec/23yF+RzE0wOK4GGwRDIdp149fFPwq8CgFEhVlDBUsFgGrUKry6LQREb2GiGI+beGcFPSIW5oFkXMIkB0aeY22qtEjxvj09vKnW9V1mbvOHAd+CuWHPJ5SGE20EWyiq3Fl1ZBmEhXOA+LpIOtgCiPI0igcC+v8lpLSgKvYXiH2yCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M77DeTmiu2mhkc0uvM+9aXg7cAIQwydOwnqc4LX7rxA=;
 b=wXjYgRO8W4Zqva+wYVD0EPqWJCBxRnFpecBmbEoX4jo6VKfVlZftixBdvU8RisSThE/ZTxsEIFp2jF50GN2sGMRONc95E03J7bx1ngRQ9RxGJdN+WXpUQvvd2+9q49ZTEGkhnbAcapM5Fs0rPJJeBYrOXUu0cxW1k/Eu6F8xlXjPPBkR3VuO359V376P5Lw0xgIHBj1AYH0l5z5kAKO4KKorpHzZGn/8KPYvoVD8NFoMXEgh0NDFhTVhhgL1hVeE1wIq1EVKlncZAlWQfbqTCrFTvqSsPiR7aOUzoUYKocd1c9ijWkplVPVdVmZllLRICaPIMFk0QzmCD3HgYoB4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M77DeTmiu2mhkc0uvM+9aXg7cAIQwydOwnqc4LX7rxA=;
 b=egiiLKQ6u+FI96RPfd5j9+hyn6ndLN1OJwntUcIm724CnQ2TQIZNQBPgLQ7hoqLWIGImOyldqVRR1AJq/dOUnL6yihxTMm8H8v2bzWY2gjMb3glkciNImVZ2pVP+BZIoCiQgyZY7ozQNBxMoHs9oLex+JKtM0mG5xvM1hHwc/SQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by MW5PR10MB5665.namprd10.prod.outlook.com (2603:10b6:303:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 09:46:04 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 09:46:04 +0000
Date: Tue, 20 Jan 2026 09:46:05 +0000
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
Message-ID: <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119231403.GS1134360@nvidia.com>
X-ClientProxiedBy: LO4P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::10) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|MW5PR10MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: b142e651-0d83-4c21-bfcf-08de5808b9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JGvihoQTgaQdtmVB7znDlHF/1EFq71Q8qr6RZxRx+N9IRoKzC94zLxLHR+H?=
 =?us-ascii?Q?4fbAxmn4bmGbO6dX15ISU2sop1XQuk+GDydSNyauXDQh5zxhRx0LEC7MLgrs?=
 =?us-ascii?Q?6HiUvpVcUptMJQcW+bWH+uAJSO9tzS3QK7YgpNBcGqi7vLEX6daTuY+zuyo1?=
 =?us-ascii?Q?dU2KbhNooCbZnsoTRZFgQFvdpZiMYLejutPLwmdzFLWVcjaMCDaHnAQjqFoQ?=
 =?us-ascii?Q?R4FM9IpTLAzRpIPykxQY0H7EzAIjXWwHePkIjvdkpBisteM4xP0YZdyQqLNS?=
 =?us-ascii?Q?vSj6pDkSOYTphgVzzBh2aEiBTpokrQDHKy2c/kf3KrEjRMeSFrBhb2gulOHR?=
 =?us-ascii?Q?yEUQYkWyew1jPlLWvG82u3OWXLEzu15S84INIUFXEt46Yt0YcpeyVf8D1PSB?=
 =?us-ascii?Q?PYDZrSdkyL9n7Qsovb64FrlFajJrXcijZbw0A/z48oKRztp9wj9bF0zcQtOI?=
 =?us-ascii?Q?7xxou5+1xb4jkiUnsqMAmVN/Ast7PjlJ47s/J59nmy+TPPSJK/X/LB4zepbX?=
 =?us-ascii?Q?RjXMaQfOUxIvPZbl+ugLXNnPFOf/+AmXWkt9tVZQ+Y9L+GA1MOlnbc291z+H?=
 =?us-ascii?Q?JRR7QcldBVe1AYqOhwU89u/v8t9sqx08HCez/8ZFeLzwkXszV5FsgOQqwPz8?=
 =?us-ascii?Q?5v2KrgQDmdbLiwtcbQITUfXk7UkYGaHRgvW+YJ1GVNrQBeJt5PMONOvsdX35?=
 =?us-ascii?Q?FbW/ULuXkYG5lNOPhnOO03nisCCMTtU6HSFJ6XPmgKDNIuE0tvVcGVATHCAT?=
 =?us-ascii?Q?+OEw2wP1ORQJ1tr2l0KKtwQmMWTIQ5hmtg6+kv34VnYTbMFpnTqao+z4lZ9f?=
 =?us-ascii?Q?D8pGGmOgnL1Qi/2Lq/cGh3W/wJpIfOWaK3JB4nl2m15lhqNGEmyIGdg2lJst?=
 =?us-ascii?Q?PgbqIuTjCoOglTlA3SxDr32xAC6YhJYs1kmBxVBe89ThGpNCh4LstPxgIphg?=
 =?us-ascii?Q?omxwnsqWvb6pmKCS6bL4YpNr5IB1+FD4zDfVzFvwjETYWxVcZVCZb40g0VCQ?=
 =?us-ascii?Q?V1k/trivU131aVb2xMqVKGNooWsvWWOG0onYeGxgwl5g10t22HqSmGMStbku?=
 =?us-ascii?Q?K532yPKlF00GAjnZv36JvqLaDU2/BAXKrJElojusW8vPFwna7MKEBqsmcXjW?=
 =?us-ascii?Q?9SumjbJt7s0Z/E/gRfQx15c7AMdTx6Nmt7bh0jxnQt+nM5Tml5UoqHhq3plU?=
 =?us-ascii?Q?WoAsAGxEzMA8wdYvxnbtvZNh6gDj/A+5F9Oxb1XdKqxdrw9q28YauF5cIRiH?=
 =?us-ascii?Q?1JPeobLCoXbYDA8ufZf7QtpjiiyxheM9v5H/chdT59xqIvGS6mN2MOXNkCdq?=
 =?us-ascii?Q?RawMjIC/jZJ0lDllTcG34cP2xlu6MPp6YfYyrfi45TGXbnZVBVLQPvEHJg9M?=
 =?us-ascii?Q?iIcSQ61V17sFGa8T6yaD0oKmi+fKX1yT1CIxfBGfPb7/I2C4+8b75WkumI2Y?=
 =?us-ascii?Q?1oVqMNcmFs0G1pYTPLrR+bbN9CCdYRVBM76uDG7Bsqj8MegdNBOs7U5x4ERJ?=
 =?us-ascii?Q?4AyXYZ3NZPInRVsAWwvJKGn60ySAg5Q7M7pOA/1Cfq8EV8561bIqYxBZCNr9?=
 =?us-ascii?Q?ZjoZ6ZnDP2AI0nwPS/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XwU9g/tGo0D5HSg7ACi5F36M8igTTtXvwfiIHVIjz3aIu4yU7EUPcqoEaSgi?=
 =?us-ascii?Q?f60VCPw3N9gks7W1DOMWOR0WnRRTAIyRDn1H+usGw8aTBxyiYXF8RPKbbsNP?=
 =?us-ascii?Q?ioqIPow1Gu0wIeNM/+XNl2Mh06SiQbtAx+eTQ1aix1lH2wpFIjt47reyzv4R?=
 =?us-ascii?Q?mG5n9kKcw4tFXA8jP62f4IMhSlp2YEaB/+bTo5dxZ75CuOYD3BnByDKXwCMh?=
 =?us-ascii?Q?wVTydR3cWkdmXSkE78AJbqkO+3sAnyBN51dYTEWO6nyvssWo4tlS5Gl1XX/Q?=
 =?us-ascii?Q?vb9irjjWdo3LLhbL2LvccI/DkSzwzEVxNMr8qkN5zvaShiilFlU7SEdrAMj0?=
 =?us-ascii?Q?IHeuys8xX8oSu/IwfyQHNRQ3yw8xfmQW2nJtSOd9wdG7ky8waOUaoBO5/f2n?=
 =?us-ascii?Q?4jDqL7G09FKTgnYBQLZFI9FCOi+t4czsFSQcit1Qyu5jxcA2Np79PJ+wxmp5?=
 =?us-ascii?Q?BjemKmle5dr3w1SLBz9TPfSTzMaHChLRKFtA8dK4m/oso5rJMqfNkt1aAXdi?=
 =?us-ascii?Q?B/fpV4bMvPgNJKO6zbIQPnAiu8mAgQNSr0TboR1QH3PHjMcePLwoU4ZrRgd3?=
 =?us-ascii?Q?mmg1Cd0ZhEYPFyb0GPEbs8LXIjiNZfzaYkE+KytcXQgd8HYSgxfAEo8UL9NV?=
 =?us-ascii?Q?NZEcCmhs9KBnPTyIuMu5b5uMTI8H3zVyIdl+wBDsjbskwcXnw8qrqXh4bfCV?=
 =?us-ascii?Q?6krx9amQjsqFBz+lBUfRuq/fYyhh5TBoxNCx5PWE9Qx9xvFz6nDCJxhc8e7b?=
 =?us-ascii?Q?2uWqns0IU5njf8i5+ykVi/i2C7NhPFrPHuR/QwRRWgR2f35Zs79sCfEEpaHP?=
 =?us-ascii?Q?pgZkk/PKj3AZoil/Htx1JuGsdkJE7p+C81wmbUk8dYmiJlXFQxzsuBWT9RLm?=
 =?us-ascii?Q?OOweN2FpEAlkaHmKZ484ORlUk6snEhngAEYXtu5+iE7vriFNH4aBL05IIgIZ?=
 =?us-ascii?Q?CKLpApKQ/rW/vr3zhMn17rJLYLvPPnEOtmp9tyncEp6uZAyQwdx6HwnFb97Y?=
 =?us-ascii?Q?B3ngYLgwlBZLhNcz6yvbdiMco1Cej4aOf4+RpG9A3mekPhn8KG8kVPGnsTvf?=
 =?us-ascii?Q?+kZNg6SpAi5Mv/BI7YNOH14QmVmEfzir9wcHwKAy0GxfPKGsAQ3zj/9maNPM?=
 =?us-ascii?Q?Vx085H5utdkCinqAuJhHM+6cNZj8KtJ36mGeezABoe9jv7XaRVpi48oU0XnB?=
 =?us-ascii?Q?wwN38gl69Nq058s98ojgJXEuaKzSJra278rN7WOgJi7O9nLl0V3Pj4PB9sZn?=
 =?us-ascii?Q?3hESukm3G7vmOiWiNocx8+2inVx8LK1Lwhmu+5khipb1yfEE32jDX3pnBvE3?=
 =?us-ascii?Q?BUwMELlzsyYiHV6vtDBRGRNUO+imhXiHg/56XhfKXEgmZ6GLiEwMhhM9DFOS?=
 =?us-ascii?Q?9lzpv4zBZmlRxcue+FiraYvbNdS5xGlTyWGMLQV/VGZWdnBFlawM5LKnwucI?=
 =?us-ascii?Q?UBJ2vy5y1CVaTrnybxG0Ll2zaqFyfVx5xC9d0pcGmbPrWsiC7/Om4WMtAmOv?=
 =?us-ascii?Q?wk0+NwjppAKubnk+OH6xvbnx0oeECwt+MQAp2TmYgQOggcKCdIQ6n1+FVfAu?=
 =?us-ascii?Q?7vtUjBBGuBFVic96cqHmAbMe1a486WV8DUr8mcwjsA8KXuT+fmUEGo5+d1cI?=
 =?us-ascii?Q?qKj0sPW7EARkA/jam75OmsbnzpPP+PTpsPRJWJoQzRIkFRNEQkHjVNt9rSRL?=
 =?us-ascii?Q?uPQ54KZuXZ+8y7Uk5T9uzvnQWjxsfdXHFaEUabYLkpUEfkQQ/TRu0U02AB8O?=
 =?us-ascii?Q?vWPJAJuz/rupbfkdc1xJiuEOSeKJk48=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zNjCMitcsmkMUMQdU8eGbdxAudiXglnvJ8sfH7F3GHWcBKHaCjSeFMcLVBCyYDSimrTbSVdC98cl3dXXILqFD9uZD67ywh2p7bE8oxPf29tjeIjsqyR2omYzxZxiyGSnXolbOSq6yuryb32tOPaG4EuJ4uzOSnd5H3eWykC0fztyt018IZUCe80cz2tmrJkb0yoQfVLdroXHVNRV9P6zuax3AwdhqMr+mr/ADhxvilPOAlZwrNhx5Vgju+JzR21nYhnHoGsaoXb1kQWEfAOd0iS7vTcEZ5v0QKwWPYLj/XbREvnV+R9hd5qOHix8QvmHg+9GJhqySh08bN/IJnuIfmp1YPotB6YLwe3QtGiHH8D1sOniai8DS+AKJzDlM/LUlgu8Qs6jtnayfEiJ6wNF6cZX/Na2BUhNFoTQKw6Tz3HsrjF0rWHfj7HaCHfltIvCg9+J6yUctT3p8smXTF4+OT3HifSdhqAM+bDI+7DJC7E07PgrEwpplEFoCtFLQxu9Uu8WEvwTkR+YPIUEyD83gefoOuoOB8fO+EbBKVNXh69SQ/Hm3diqY+l47SuV92Waj91ZJ81IBc3eB1ezFOtguCpMWeu9ZFZRLp/nhGQXNO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b142e651-0d83-4c21-bfcf-08de5808b9ba
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:46:03.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsUKgRkYQRscTPakAaYJoDD9A1T20GUcqObz4Kma1XuJei22YtSDPOvPS3TkZNdhepHjhMgTAZBvjHDIY/pW06B0nMVjwq2ekgSs4J2o428=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=693 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4MSBTYWx0ZWRfXxNu/uiqpLShT
 zoYx5UG9UosHdYNUzF1cN67/CDHEraMH6EEIjFNqJ12QpusnwcRbDPnf23J6yCCrka0l0bCWWuP
 QnEzz0gC/ua+Uc186vkQLRL04rEPpmSehzkBjwddETiF/BFPMYN1S6oh6vuFbzWIWj8ZoE1xm6a
 WlDsY9hg37i94pZ3O/4tbVQ1p4WXDak9fm9M8SfCGdsM/senQcJ/6iYjcY115VPAQ3Y9+Gf/xDh
 7HqxWy8lrzQ2kNlSGwubkuy5Ca5QQRp9Z7QGdE+OXtvivIn9QrfOlwkoY921A/trWuHUJogqwNa
 c+wVVsIle9percLa+51C+STJATPlUMDYQO7iU4Eu5RUGg+S5kisiefQZ3flKjdCkN/2/Vp5//8o
 WPEXmN5EMCDPSs2lV2a3W+0N+vdXOJCtNPt5S8zyIK7ZH7WoHxS4VnaGhpjQq+0id/N68Szphss
 FhuQEibe5wYNB9VpiFGhuVBQlYm+tiJeKa0K4kYs=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696f4ee5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uBMRrvkpIik1DE6aJ00A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: iPzQxldOBpWj7uUcNbGAxkwvWWe8N0Ge
X-Proofpoint-GUID: iPzQxldOBpWj7uUcNbGAxkwvWWe8N0Ge

On Mon, Jan 19, 2026 at 07:14:03PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 19, 2026 at 09:19:11PM +0000, Lorenzo Stoakes wrote:
> > +static inline bool is_shared_maywrite(vma_flags_t flags)
> > +{
>
> I'm not sure it is ideal to pass this array by value? Seems like it
> might invite some negative optimizations since now the compiler has to
> optimze away a copy too.

I really don't think so? This is inlined and thus collapses to a totally
standard vma_flags_test_all() which passes by value anyway.

Which is in itself passing-an-array-by-value, and also inlined (though we force
the inline).

I have done a bunch of assembly generation and it has all indicated the compiler
handles this perfectly well.

It in fact is the basis of being able to pretty well like-for-like replace
vm_flags_t with vma_flags_t which makes the transition significantly better (and
allows for the mk_vma_flags() helper and associated helper macros).

Do you have specific examples or evidence the compiler will optimise poorly here
on that basis as compared to pass by reference? And pass by reference would
necessitate:

vma_flags_test_all(*flags, ...);

Or changing the whole approach? My experience generating assembly doesn't
suggest any of this is necessary.

Explicitly for this case, generating the invocation from
generic_file_readonly_mmap_prepare():

	if (is_shared_maywrite(desc->vma_flags))
		return -EINVAL;

Is:

	notl	%ecx
	testb	$40, %cl
	je	.LBB106_6 [ return -EINVAL ]

In this implementation and:

	notl	%ecx
	testb	$40, %cl
	je	.LBB106_6 [ return -EINVAL ]

Without my series (I am omitting movl $-22, %eax in both as this just sets up
the -EINVAL return).

i.e. exactly identical.

My experience so far is this is _always_ the case, the compiler is very adept at
optimising these kinds of things.

Thanks, Lorenzo

