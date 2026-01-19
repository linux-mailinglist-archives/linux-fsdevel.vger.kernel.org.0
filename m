Return-Path: <linux-fsdevel+bounces-74442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD4D3AE2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FAE53075B76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF28920E03F;
	Mon, 19 Jan 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pwawHgwY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZsDFlXHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A84C92;
	Mon, 19 Jan 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834354; cv=fail; b=o4HDyhRH9jHg3l8hh0aEhF8apKWvda0cls4h2KY725PHmunxzhzqnHjmw9HfyFDAT8NCxlc6Gw5Oi7a7lB++zcoYJ7OeIWV+wx6ZFt/D+8b+ObLeE4wZedRLGoHXSHYi+xvWGbmgkiseDMcsWT90LJON8rmtPMOszvgXqlzGVJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834354; c=relaxed/simple;
	bh=LbZzpM0Y1OhR3q3e7sDcdKT6nLGOnWI2QvyODOkI2Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3QwX0jf/el9eiD1zBzMoGojdJ5xPris3DBcmp6qgFYj/heLWM53mXydPlAAxqP6cJDmQqiJmuWsyxkVfPpfccrWd2lzIxBSIpffc17FdUtTMz43NGJVKRuOfqD4z6eaV79YMMdbidfBpLRLsluVC7kwsqcpt61W7fcsaxVm+o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pwawHgwY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZsDFlXHz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBEMIr2085070;
	Mon, 19 Jan 2026 14:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=; b=
	pwawHgwYSu0rsOHRXylk6TGnlUXwgPsRey5kyR4PiAXWa1lE380x8zsS8KS3NDLO
	F42k/oBSvJvkk2fxn05s9RWDTo63QXcvNF0Z1NWTymuq6lLpJmptJIVSubE9pCSR
	Wu4EM6grYu8ahm9yK7pyXjPHBWfxzn0K6CMCR0S42vqZ2pGbLR/J6moXTHOUa8Dw
	F6zvOTfgkmXdG3EDHuDEUnK6Gd73TmLMiXsff1ht5T+qUS0iVXbsZX1iL3VuI5x1
	5fjzdo/yrsz0xjh7Ktm00WcOhaemcHY6CiuDUd7G6SPz5XcPFLx5+LXBPhKwF1fZ
	kDnnBieJ+hl6Ujd478Ergw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2fa2d58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JE1tPS000505;
	Mon, 19 Jan 2026 14:51:36 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vc84x5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luPQT3W0fFC+OpYv8u+F0LQT6+uGVs4l2XY+/E5gdDA2UnecjKKcWocg9ahDUtYmU4BVYdMa8JPugIcj6egJvvezJRtdZkIADWExtr+4gJw62rlLMeYtOZPbG1h7JzibJeLRaMtV0Hjx2PxJKUWX/U5K6DK77XGeH6isT05CvZFHTE2ANj62lI8iAeK2vAnuGYjar4ZevqZQo6BAhviEDTcA5ponNqZTMrKY2UguKoL2P7hjeNxA0iY13izKhK1NZa7DvQm8evgnaylHU1bDbwz0aH8bdbkmhUxDqXO37MqVMe8r+yj8do+z7qgoWy6xpNULBo8HJAb14ZMiBQ7q5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=;
 b=sQNer/4a2jnbgfiCV/muIYQxBhTcfw6S2bs6JnRzwg+wrs4mwsfGu4MH/CHeRNhCK+i5s3NT/jXRRylRHYlozhFqOAXcLYDKEx5KD0fV1+UbhWNVMJp3cvvBT+8vytFd3CLe48keCCIQ0hAfpWtrgBelpb6muxDm/HEhx+Jnu7RMtPT49aB1SkZOGsFjNv6bkG6l0rY3DiEAmjMagYb+3k8tjaDmMZ3Eybj0ks/PezYPZ2wmw+JvcL8uRUF7nmwSCWgf8FhcOv97S9qkeyZd/BxiilzC4HlJVXq6uHRI/SROs/5oZ3rEw6dWhE0wd4t3QqrVCZ9g9vcYSccMoGOYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=;
 b=ZsDFlXHzeHf+nL87xtU/FCGwdSaFSkTHUH5AeFnjnXXtsUN6AyAj1v+HCuN4+Bf/O64J9df6HnNQ451Q5bJQriB/4KcnEfW6M1L88ZdtrUMI/+xmguxGLF15LhEbC2RmRASMeXOt4fJsnvCBcmGg8HLF0O4UMkoiO5ynJi/xI90=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB7300.namprd10.prod.outlook.com (2603:10b6:8:e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 14:51:31 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:31 +0000
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
Subject: [PATCH 03/12] tools: bitmap: add missing bitmap_[subset(), andnot()]
Date: Mon, 19 Jan 2026 14:48:54 +0000
Message-ID: <179ad7e5f62e87a8887807ecc7217899429ad24d.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0488.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d4ae65-3221-4dc1-54e1-08de576a3bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EkkzWNA1inb07EENEOe5fiJSPJ2YN/hVP8S5UPTSOwZj7xGVIKf2BCv7Nm4G?=
 =?us-ascii?Q?L2odMW2q6Av86dwf5xyTVjnfJEIXxmFql3HgJ7qIdqA/tqvZf1/nGQhpVBXO?=
 =?us-ascii?Q?z/I+u4vaR0EXs/cLklaApjPu8MYnZ19OKrbyZ/P6jIjR3x5l4+qrfXmS0er+?=
 =?us-ascii?Q?f89RvR1FzgfqrvawNSsoAHnVTlKNYzO/GNB7JaGOnDoqKJKJYOtDols0HOca?=
 =?us-ascii?Q?qP24YxVqky2Uf1Ks+hoRvxom68e8izpjvEnWYuGvzRdbsHil5npC/02LEu59?=
 =?us-ascii?Q?t/tgv5bVcHfmDOqaH31wImUfHextGAsaMsBUre3sKsSlctWxTTyTX264z7HD?=
 =?us-ascii?Q?fJTepcY4AM+FqNdydYFzE6CHG3yXd8nftmHF05evC99OnYuuhJnvP6zu6U0E?=
 =?us-ascii?Q?PYUGwMpAqm2TvApbBwxOTroz9mYtIek7GIGLRcJvz4Hiyld8iINEx0ihw87E?=
 =?us-ascii?Q?1jvNE1biWmUHvDZtvfuJtsOaP5x7x6Y//XpZPy4bj/p24MHeU1/TwGPz5DM7?=
 =?us-ascii?Q?XzqPLZZPXl54FF+ltDjuubt5YwmB03l4lvxOICPcACveHNrKk1dUhjqCBL0z?=
 =?us-ascii?Q?WdigaW/ItmycSTP7978X7JKTG7oFxf0iiCkOEmFa8vWvGiXxZd8EkTrb2esH?=
 =?us-ascii?Q?nLcBetljr3sRmAmgkp2nWkp9mb6tseWFkzeWuScVtQ+BM8EJibRXa93fnm/R?=
 =?us-ascii?Q?nL2PaqCN2XiFOtAQLxMX8izdilfhvuI15yxQNeIN/c0qI0ZhMGDl4ZWlOMO6?=
 =?us-ascii?Q?sP58eMJHmAO96irLxIXsBnddQDdKBqKs7Na3ezn3gZv/z+TM3hpuy5akNE1n?=
 =?us-ascii?Q?yKZwfpFyjjm/rZXarmWwJ7aG0V69+dse63MFCnj/deturr6EDVZI1s0SAUaQ?=
 =?us-ascii?Q?BC/p66yHa057PsFBeduNE2tBW1B52jnSYeRbr/JbUHGMcM3Ui/ZPoofT6CxC?=
 =?us-ascii?Q?ye/OPpvznQSNobqIZzH9tuQdYE8U+mBxAtlTIAx4TRp6bk8cldlWq0TrGcGU?=
 =?us-ascii?Q?Ef4kOWHrTfek1vQWDqLoemtw6/eFIuHtwCZHsExvAqi+tozgst06tjN705+p?=
 =?us-ascii?Q?ToRPEJyBD6CZL/M/EFBlHQlbYyU66SCwIKwg2w/Y/3YpEZEIm7cndW4+A5x1?=
 =?us-ascii?Q?7tX+549d3XSBiiAftcbVSB8CEv3sSLJPWshjPZgVTlxynJ6QJIgMlLh753IV?=
 =?us-ascii?Q?8bnqXXaU0Zfzd4k+BQK6IyOunJF1fs0uwM0xThby9y+10SUxOaRhDk+D3U8f?=
 =?us-ascii?Q?rIOdFioxHCkFDHEh3RLGaY6d7Cao/6e8mU2EELqAIiIbt7ilDfU38WfZ+ItT?=
 =?us-ascii?Q?emEYVZugosVnhGIe+PE2SW/6a32KhttdWPWTEKpyVADhxjRaiTTGe6feD/ku?=
 =?us-ascii?Q?j4oDdGimwGeFEtbusNoUkUOW6hnEErDcogKiMv6OQ6wGjkIwRo9mXoIEORME?=
 =?us-ascii?Q?fD4jgY0jPiCk+hUuGTDzFZt5yo6PkKdfF71j/ST8i6s/6LWS6L7JTqcRemGB?=
 =?us-ascii?Q?dr/MNQIavHapOMLbfs7A1SICOUuNI3tApXF+aml7WCrBsN6oC3vwdRLWnX57?=
 =?us-ascii?Q?5cCo8KJvCB/D9Ig3Yqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3iiIh5n9hwyEQDo9n2eVrwIxcGg68NRceabbFYwEDJGgaIk1Tn8EifoHCk+G?=
 =?us-ascii?Q?o4d+HGLyZcjKQEm7znhFCc97gjIG9CQ+RhhA4quRn1leSS7aeT71Z1aOCP7R?=
 =?us-ascii?Q?MCnHw2W8Hm70+ywlo3+J8ip9IQs6kWTG3Z130fA1RkSd/5ov5EkvBlrnQH2t?=
 =?us-ascii?Q?DqocAfXstkMDtoRuBGPhzD2WE26jymdqUgBFEOZp/DPPrZt8Oa+IjKcgEnk6?=
 =?us-ascii?Q?bqZBsTLKv3dUZTzRNvIJmVmTCkmyR3gYzCO6wA0A4VLfE79Nre23+6ywUjAK?=
 =?us-ascii?Q?LYs7pHKyYIVRuFo3wOLOSGdsL5ak9PL0VO/ekglj2eTz2a8JG7PJqbRhUyTN?=
 =?us-ascii?Q?SACRkdayWlTTWhYEmyduBvdMf/4OIElnmvYowPlFullfuvJQjXXNtSkFHnpC?=
 =?us-ascii?Q?htYvfqgv0RgJCgMXkQq82aqkeKg6pZvBdmuOAzl0d/u6O7Gf9LAyBC+J9f+v?=
 =?us-ascii?Q?k0AQRPj/DAEPzhtQj99XJyVUhNOoPAZC626cDaBu8wcd89hb9z5/Fw+ASSo6?=
 =?us-ascii?Q?kdjte27SMs/RuoLM/Hq4Y/LO041kgFKaU5VSwc+Pgt7TToNNdgbqHehto7If?=
 =?us-ascii?Q?BkENxR+C6QTj5GWiVsx12nKRclPLbdT0P3zKZbRwp5YB86HRRjMCabVQGFCD?=
 =?us-ascii?Q?Zi1OHbJ+8AGpyu9ZKFPG0vQgF0RL4EnPxoIArz+pByHlS9uf230TaP9hbkgH?=
 =?us-ascii?Q?OAwzZqUsBDqg0C2kkISqArkIZR3MvJbyHkFR+irpLhyxTew/kRBKDrwocBr7?=
 =?us-ascii?Q?1fVxJWMKbTEburHE2TYsBMQe75Qp6mW2cDMf0mt9+jleXVGvQTopiyjRt86o?=
 =?us-ascii?Q?cqBs78fmNfDNVGBrKasC4wohAegA2JCqEOBFQH/FibxFEF1HUtXvLRR7qQzS?=
 =?us-ascii?Q?WMpR3pn/5KDtfkKC4cpsyreUI+wmHMf7dDrVK8qz3+B/aY4ev9wji3hYypng?=
 =?us-ascii?Q?qzT6GM5ZBLT94hhDqKSAlOjLgIfZEVxzVxuDK5IedqgbQ/oey6bGyV3EO7XX?=
 =?us-ascii?Q?6KK/0CReCPtKOh5MzvXG2eVyjXJA5enlU5V6GdIMse5M91BhheTJv2xBWcl1?=
 =?us-ascii?Q?VQpJbGuH9rKRNO3aDxzJQgoybwsQ00oRaKaabQUDrrkyc5PsQN0PCxHbg/Z1?=
 =?us-ascii?Q?GcZoashNGdhFg5EEFA518puNoL6X56I+b35Zy83eszd0+4mkCqVc8AucTSvA?=
 =?us-ascii?Q?A3we04nfAlVmJbP7MdNJPAVNuBZNoB+cwkcbpfVBOdrWNw+ZJKHfUX3Y54aP?=
 =?us-ascii?Q?xei5tekMD6wrmqd7Iyi10BVaEUWYWIeR+kNukKceqHKbTm/m9K/zFIUJKcA0?=
 =?us-ascii?Q?b3sSDwVAXfzpGUBjrjJOc9hHIwcDZ4oOjN7Zl8KlHWYrAArVsuqP5AiZwibA?=
 =?us-ascii?Q?ZBeIDA1bL2HC4RvMrD6LO5GMEG8AKn3Ucr6pxnBJFAV8NZc+k6BGyQPpUabN?=
 =?us-ascii?Q?qYBsmLKBgPw7AZ6jPPIfnE+CWthR6wKcaYgSMQmlIWOgGY3O2fCjStHYREQV?=
 =?us-ascii?Q?UbVp+AYvusCR4kUiqz4Cy0NK3HFQ50kgA7uYIfWbuXIPtaAFKO80+t86iHeC?=
 =?us-ascii?Q?Df8gCxiXl9pzhi5N9a4nHX3Cya8nRWLDz8PXfGQdVh20tsidlMjluQEKm41l?=
 =?us-ascii?Q?6aK7itYVNATMeTbMJberyCYP0J6A47Hs65tvPQOsg5bqjhovkzb+3wSEtkzo?=
 =?us-ascii?Q?3e2aJ1PXCEke1CJkeotFRKtcHmu8xlJnm4yJU2umsgraCWwACNLoQDiQFLWZ?=
 =?us-ascii?Q?3ootOfSm+ihP8jVmQDKxLnpGqkGw6EA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AJtMkyYlmZDwkKd8ryzsJQbjQcuET+V+DlqchslSEx+zVrU1fIopev7tIqBITXTnRiGomClSA6eZuWJcXzRSHPDWF859BLvQg/03l9UAwtw3dCvTXgve6ZqPXIWYBTG+34o2eDlliiDsSDn967zRNb6J6oNcEE1DyK2RM439ZJTuqDfHMX68WNqtF8bjDygyd8s+ZfTHGZhhQCe2bZiyNvnMmWP4ZvXaoaDyP62adosjXwa3g97QVvSnDZmT/byyYoTmhZI8p/i0H+zgUdH/QChcvjl5/WkQv41XwWnmyvkFK43xDihUXvcfdJw0oiUM7CSr797x1QeSOMzTI8O//LgynhJY9Eu0FLkNk4BBe6xagsI4WhZLUzVyjh+uTBzsbEbFWcfkpk6GfHqGfjMzySRDVpn7odtvCyF3/CUlr5Y0ubz8TpG6o4ZMb1VHQxXuE//jJ2aIv4lXFX0ra7slJ2KW3/3QPAyQTsZ7VxlmSASEQG1Dk5sflLnB0xnn4rgcfqrg2IlLAvIJEeYnn0yfIhY3OpgDz9eFh5vEzz6YyCFksLBvAbjijDwBVYK1ZrbjzGuBXPEKuhpqvnOuUDsfqcTI5ALVJrmSYCzD7dvIzwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d4ae65-3221-4dc1-54e1-08de576a3bd4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:31.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sen/q2hF12IBBXtVZ6iKhOjaElASn1m2hv4shqrTZTLFFkoITO7W0UWeZkJdkh/M5onx4GRL8IqhbV+p+kWyQha31coauQ408kKQG490jbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX/lYNAjm8RiIK
 BgdGo7+A6HmNDsAjTXlF2/y5ZwM4tbficwFbVjz4q7ICsAtitDfOmL0YmeREoxw1PhoVc9UexD6
 iKf4aPuFHbN4h27nB30nrQFDwQ9vaMsmLM7OH+glDj0f/KwCSG5zORaQ48d43d4OCQ4muIaDcv+
 9w3oixc5iDvWE07MzpSvJIUO4PBntovW6iwrIppMw1XUo1eXAt3ecTDDJIY1uU0KD/rxFYf7EsB
 +O4Qi86T4ZqbY8rkRmj6GawacGU/68afZ0ZFg+ae5VDEj3hVyFKgrn1pg1fV42ua2vgtYqd7BRt
 OkfycAbVDU8RGM0LGyh6jZsj+7lgF0moC8D8erq84ZEYdw1prY7rLCU0pZDZ4ADhMu8w9TrjIF1
 77tnj1cqbQbJWAUQlJziqODxOQfqkFknQLWyK9ZzBaXIfi6XAYZEBnGP+SIjna127CoySpUrGFl
 y+LDMRGApoP9yhyGvEiy7ToZinlcnf9f61A0gS4I=
X-Authority-Analysis: v=2.4 cv=HvB72kTS c=1 sm=1 tr=0 ts=696e44f9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=a5eeGpJJMrXOYBdyZXoA:9 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: zbbtgE9MC5Fc7L0uksmJ3GOkpD2zMQ-Z
X-Proofpoint-GUID: zbbtgE9MC5Fc7L0uksmJ3GOkpD2zMQ-Z

The bitmap_subset() and bitmap_andnot() functions are not present in the
tools version of include/linux/bitmap.h, so add them as subsequent patches
implement test code that requires them.

We also add the missing __bitmap_subset() to tools/lib/bitmap.c.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/linux/bitmap.h | 22 ++++++++++++++++++++++
 tools/lib/bitmap.c           | 29 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 0d992245c600..250883090a5d 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -24,6 +24,10 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int bits);
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int nbits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
@@ -81,6 +85,15 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 		__bitmap_or(dst, src1, src2, nbits);
 }
 
+static __always_inline
+bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+		   const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_andnot(dst, src1, src2, nbits);
+}
+
 static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags __maybe_unused)
 {
 	return malloc(bitmap_size(nbits));
@@ -157,6 +170,15 @@ static inline bool bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
+static __always_inline
+bool bitmap_subset(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
+	else
+		return __bitmap_subset(src1, src2, nbits);
+}
+
 static inline void bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 51255c69754d..aa83d22c45e3 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -140,3 +140,32 @@ void __bitmap_clear(unsigned long *map, unsigned int start, int len)
 		*p &= ~mask_to_clear;
 	}
 }
+
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k;
+	unsigned int lim = bits/BITS_PER_LONG;
+	unsigned long result = 0;
+
+	for (k = 0; k < lim; k++)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k]);
+	if (bits % BITS_PER_LONG)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k] &
+			   BITMAP_LAST_WORD_MASK(bits));
+	return result != 0;
+}
+
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] & ~bitmap2[k])
+			return false;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return false;
+	return true;
+}
-- 
2.52.0


