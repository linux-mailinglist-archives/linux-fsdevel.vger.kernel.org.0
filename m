Return-Path: <linux-fsdevel+bounces-74446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF42D3AD5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C25310922D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C547D38A9AB;
	Mon, 19 Jan 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hqkla6HQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rcPa2p7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA138756C;
	Mon, 19 Jan 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834360; cv=fail; b=Muj16opQlcetxs2luL8nsxrz0Lpe03ZjTf+lsOSSu9VXOiazamo7eqIaZPWSkLTvDM02MqpxP6H+Eadl4idaEzkbGugKoJqlMNSU/QHAxvML55efpEz5rI30AdBsu4uV+bXvr4rrlQkOLR/+l06HU0WS68vdLn3vFzfAFv1XUQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834360; c=relaxed/simple;
	bh=z1vju/K35EwJJowKdf188qQyAvrPfeYfNOz48m33g4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GXMHDYD4eusi4wAchs6vGIrT9Kmfwbl8PWv4tLytlNjhAAMwSxvNMFudX2RvJN5fGufmwsrijplqL29MEEpNTQWD2jJ19MrdldyAF+Qn51A+5LoC1yuX6w/RgN4TpKq/Mp19S4T1oPvy5lewOZ9gektU+7bw0EuZ5kdCprmpHXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hqkla6HQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rcPa2p7P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDNPk1512384;
	Mon, 19 Jan 2026 14:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Imjsz0I79yOoix0VY7NS8mCt3/mX1K9eyb7SfjmWWio=; b=
	hqkla6HQZhGL7CQpzvMTqF9sdBHy+LE8MdJv3f6PYxciGkEVsXWZ1gDcu8PUK5go
	3fcJ8eoZZP4NpTO3FoElDIhEa8Az3vdMSqNSLriHLau9JeMYnECgel0fiCQm7bi6
	GtInGSe7ZH1q6X7KRj2iTzZS6ICK3Qsnt4G3iC/jAoJ3FPohXO3dYOhmKgP5u3Wf
	JXagk9+b+mpnizcPu+69IfyQwe14rWVd3HiDYUXo+sPbBXKOBdxpq5eJWXSclCBL
	p3YlbXdDlPl0Tc31J+pietGnAuBRmXS3lDvGhqtPxgmYwcDyhx9Snm4AmFO5K1Ft
	EEsxPSgF5wXE/e/YiasxtA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qachd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDDtiL015541;
	Mon, 19 Jan 2026 14:51:31 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8fe3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnqUcCH2qmEsGdse8OG5zmr6ctCGRE30H5/+WUekW2PEANC5qu+MsxhtYmEbi7G8qjWiTe3Rk3l8InF8T6jJ2pJtXKzfPKmJq2RpPiQYjN1zIgdbndaJr5r/wYb+oI5oN5HSF8xGsCsu8JtWVbYZLIrMmpMCgBPMENiXzkM+GYo/EyURJtLedV2mmAyNZe1R7L5s+GB2QRipQMnL1F1XuGK4fpZ4/KHGPpho8pfL7xEHCdhPM3BN10EYR8SRlKJdYaIucqFjnkmkxPN/5+QdLtxL/XaknKKsBU8q4jskt+pttxJVmPR6Ad/yoEiN74K9bf68NF6CcfiJ4ZCp6v9WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Imjsz0I79yOoix0VY7NS8mCt3/mX1K9eyb7SfjmWWio=;
 b=ZBTVprT5YhWD8j++6Nt0E8I8bmXvkPG4JElg+AUsB8H7f79wu3MfJdl5EpQp0S3+sEmr/TCZpw5Y8ilS+cVMoySUTd97g9siYuKN5K3SwVsFHTXc618hJggTcPgV6cBbp899uIGrOubkxC9ZmrWcpGan60GZMvQykpAxCd9aeFtDIfss+r4UE/wQyHGFztFCzX2M1kGbtkXWgp+Bkoht3yo97WlNTSWQ89apxHgjxy6BhQpUSZl+fIFYqIXfiUn0ozkJTujZNKYZDAs6Tf/sOckJNJUYi93B+SMg3tZ5os2Bq6FXEKl0ens2MardLqZyw/ZHOLUhh3X4KtEY2PJklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imjsz0I79yOoix0VY7NS8mCt3/mX1K9eyb7SfjmWWio=;
 b=rcPa2p7P1MC5JzcwSoN3+oROtgGA/MKNC2g72AQnGUPmjBuO6E2vBwL04OhPixShJFWztedgUMOviGxuQHH+SKyXKsK/lpaOJutk8i+v/okMSuJhTBzo7F/TXESmpeqib9KeKkI7g6ruJdAmVMiFbpO3a/Mlz16lEvIYOrPTvvQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB7300.namprd10.prod.outlook.com (2603:10b6:8:e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 14:51:26 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:26 +0000
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
Subject: [PATCH 01/12] mm: rename vma_flag_test/set_atomic() to vma_test/set_atomic_flag()
Date: Mon, 19 Jan 2026 14:48:52 +0000
Message-ID: <2e5b2bc153b1e0cd61ff1ae67cb6acd289ddfa7f.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 51784fbc-1bdc-4953-f2aa-08de576a3850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yff7vHKMlasLDrHGH78I7i1hGu67bCyspLgwLHmCRAjH1m1MPlski35t158C?=
 =?us-ascii?Q?Td6YklueutUDhtC6NkDD21/VU5HukGxRA3Y4QGPFF1tDDp+nPz9z4LUXybsx?=
 =?us-ascii?Q?NNqmyL5HiOcF4MYvZ178LwxuPfAb1lcYaOTetxB7gbrZUqa+tTPaktWKbASR?=
 =?us-ascii?Q?I2bAxt/B692yz0qGLeto+HonbCB+z5ntT4XdNs7f8xdE8VHugceEYt7QjEH1?=
 =?us-ascii?Q?SrdsUA6fttQM0L9QjKmgh+8koDk1dWm1/jzxVgBH6iqI0UGy/EY2zpXYKNMn?=
 =?us-ascii?Q?vCm6I+JhECuFQadQvDiP7Jrvpfo4JCLemcMD1OiAkXJKvo/aoQjp9eDUqELU?=
 =?us-ascii?Q?o982aflJALg9N6Cym2Bp9HlcM8WWqKVO/Ppt5nZJYtFSQJns/JwqThQQqa7j?=
 =?us-ascii?Q?5NfEiC2WOB1yx7cNCeVehQYNZsNgpxNAlDYSepIx0BByU4UI6RxEo78EF0e5?=
 =?us-ascii?Q?Noy7AYQYMlOUaYQc3hjVTs9rWD+49Wl9t1oxg6oaTj2E+Omt9wLl3dOB4gAC?=
 =?us-ascii?Q?9/5tObgLEFTqwcfoklr8l+Ezws/KRORPDXK05KLJ0/a2hKDeB3m7+aE/NbWA?=
 =?us-ascii?Q?W+511naaJhHLM/DmpCacWwK9A+z5zI5mL+kl8MPazuir2mSawhpNAWnKClnu?=
 =?us-ascii?Q?cJlIda1dxUywFcpS5k8yaC3G2WZUpxxF5h3eMk+lfUFAofF0B7V9VQ0ayKry?=
 =?us-ascii?Q?3TBBv5pDw+0NzAuDXODbVzh7ij6H8i7k+mAtZ5ZVA8qiTQM/HfFZdpf2hDjg?=
 =?us-ascii?Q?2foin7XjppycH9b0dWNh4wE76BQsTVvWAJXQZ+fZjnpP1emadov9TowaoGut?=
 =?us-ascii?Q?X3CQpUaFmLyK3HDOYIqa7Z4hMDxmeVY86gMr3LbzrdT3brOTRG7FDHY83/Z+?=
 =?us-ascii?Q?WGkWsN7shUgrrkBXcXwqyF65WAoOjgEF3UvsLtsQkm46C4roM3AQi1p2PusA?=
 =?us-ascii?Q?B9i+BrDTgi0J//hosQnde6LTIiwSWQ2qiWEGk98fMUl/+ifyIiMxUzk+DsXY?=
 =?us-ascii?Q?2Z5p6Swi8Wb67JLr7Hl9aXL4UwxlFdjFUgAc3wwUVDp5J0D5CldKKteRfjog?=
 =?us-ascii?Q?K/Z5D0kbYyIuUL1/MFs1wYxcV4aHN6WhylvhURf481SH2NDAIpSINI+oELK2?=
 =?us-ascii?Q?ndmOkxByMAmwPkjo8WwbxfBbVmzFOcjNfX2zgl7nneUz5LKlgiu4PzgCbMwM?=
 =?us-ascii?Q?TvHXBNbFPxdQqyQY9HZijkBfxNA93T/7BAuUypa1w2Ht0Olxakxo6199juVx?=
 =?us-ascii?Q?vA5K3ka8kQeyLJ51X2ff1ZLJ72/+AW0utR6DaVjg0ZaKQiHpDXgjvGC/RHzx?=
 =?us-ascii?Q?VJw7qtu5pNh/VqCMKd7I1oI+VdL8Yfacukr8j9Ejhjit7+dZsTfbWS3bmUL9?=
 =?us-ascii?Q?jCMkqWH3yjZqXGObcClss5rkDQDCPNIyMSu+nvYv9T10EkBvVwgfHZV7gq52?=
 =?us-ascii?Q?ZKszFresBMVpL5mT8vmHTs0pJV3+zq+WQscwIUvQiVho0/XbUe6mDakHmKnz?=
 =?us-ascii?Q?QakMpkAHETg3i87+DCwJ2oFagbrIBPNhS5LMFAbDFt5WOR67adI4/cMUIBci?=
 =?us-ascii?Q?GABGXPsKjkzAOhZjbdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Dr54QNZMIhIuJ7c1XgSwmfGoQ69i/wLq0P44EfRQvfYlwoHtRH6BVEDgR3V?=
 =?us-ascii?Q?K5uy4W2ivabFPI6vQbB9sro6n532cI3hi81iK/fYBaEucI2mO9M8fdtVZ8cP?=
 =?us-ascii?Q?V4nNffUxoxun29j4q0yQ7yXQpjE/TC6RjrSYvvZ5x0bWj2Y5K8NWolYaZdQx?=
 =?us-ascii?Q?iYv9AZM2aGQIEBH/dBUAmPFc5YCyVqfvBVaVW6dVg2tEZNZOkoKPRry9AVky?=
 =?us-ascii?Q?sEd+uWeMObsLOfBCd0PiT8AgrmYX1R1DDaoU/4KQ9F0rp2DU4jniGpe34f8h?=
 =?us-ascii?Q?bqMKJ1ZRIlXpRT+R1sOWthWxIqXT8Mer15MdX9rUJwEYp123wVR+gt4BBbRz?=
 =?us-ascii?Q?cyEStNB5rDrgNMgL8ZbxqHHbJxS7s8LmyrSgEGuYbxTiCZ7MSls7vIhG+V/N?=
 =?us-ascii?Q?bdbkKPydHS3MpxFRfOQb04/kNYUpJQ8dQ7VwlWE3Rrk2sMSkJlOwoeKkX1qT?=
 =?us-ascii?Q?DGwNlqtN52tk3UrI209SOpjcAL7ZLOZ5+VyH3x3LejnDE4qZm/Rcd/1S9WWD?=
 =?us-ascii?Q?INT8L61ZMGp+ZqQKlD8hqPXaHzyPHFj7iGGEgQD3KNDpVlMoPa83NC/pUiaX?=
 =?us-ascii?Q?SHZhYzaIJWP8/poiQbzlzmpjt1pNLiOVWGWCGEoT53vbocYBUZZtZyoCAvJY?=
 =?us-ascii?Q?yxCZdLbiwMI8Zs4oxqSwyBP9c62nWvLc4kxJdtsDaieCb0NluarvTgL6bR2P?=
 =?us-ascii?Q?3BW38FHLMVLIafw8c+SlMiQWGDlNvsw/swY+Sj4KUZ9WTlDnFXT6Izi04e6F?=
 =?us-ascii?Q?rUie6wFeaLxV5ehj/rtitFsCk2YhbCcyb88o51vfiLgxxWKvHd0hcJcVESAS?=
 =?us-ascii?Q?pnwtNf1bTBRjjToea9KXaUmmaI2RVallHM1jN5YlrIBzNSmWn50hkXqDB/Hk?=
 =?us-ascii?Q?0y8We3hC2PWXr5eYmoD2KI2XATgY7djeyBC7Trg3iodwDvyfOBXwc8QGLZ1j?=
 =?us-ascii?Q?knzjyO/T8kRbh3k3ELgFVru4qlmqNof+3sB1qUSsjd0H8HFTYpS9X8E/PN4v?=
 =?us-ascii?Q?AbqlkgQQKpBJCgnSvLa8idNaNKOnr6xrCMRpfGAov9xQJzPTJC+JPfBCy90W?=
 =?us-ascii?Q?SX3IuBcp5AujulwUYvecl9q+Jm928PO8y9BCMaW8mEFeTtkl2+4uud473ijn?=
 =?us-ascii?Q?eZJ1b6N535RKOt9nqFzYrnliDMF3E3MGFTWAe7hNvDEIVLgVRfold4eBvDQt?=
 =?us-ascii?Q?Vp7AGkxi99dewixbAxfyU1ypTHKZDtK5QSamhfx4anF0Seaxys8nf3rWhecs?=
 =?us-ascii?Q?4VY0xAKRzhHkUo1dKiE1onsXQhODZkVaQX0/DVBxThdYLYmWMxFMH764Il1b?=
 =?us-ascii?Q?XcbF0T18igFYBXVL+w4wLfesHuKs/p1Mcj4qE/scVA+iE1LbevD+7OS021sc?=
 =?us-ascii?Q?MSFBqNnriGg5BlHUivpQYEroPx1rDP2ed/5TLwer4cwxlzfwgXLPpaDVwBuP?=
 =?us-ascii?Q?SwUdayRg24mCY7HKtiP2ZdpmZVpE+q6CvSiQFdvyqI5WPJEzugcJia4e9sUA?=
 =?us-ascii?Q?55erFW2uLr763pil+1o+Zsab6Yi1gb0/zs0PcUS8ek4Y78NveQGDJy+heDm/?=
 =?us-ascii?Q?cN0AjkMXZnoChxwhzX7Wp5nWljxA5kKpBNJG7rWuVzpIXOx9wHI/XvaUMuvn?=
 =?us-ascii?Q?kSAFY0hrpduzLnuQl/nES2c4iZziZPfXnPZWXxy8F+RJquDaL8NoJrV1F+0v?=
 =?us-ascii?Q?FgHp17OjXRmh/rBHLKz70dH+YDhvFbKQWhlCqhD3ttXv7cDm9BYO34khrJWg?=
 =?us-ascii?Q?3CB0ujADYAgRuUOvLlg6hMv0ibIeflQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DkyqxT5r6gnf89qVgHcr5zihwPuhA+ULbBsn8fkkL1M80LRaSsN+HvgtCo6dCM+PGXOuPEtiGrZI/O94g86N3U9Tq6XmtZ+LP10I+1KLBQSEAQyn/y2yL+B6HyXT9MOK4BWl8Y2dRvBLBMnT44n+SXhUYhbFeCXQgomoy/Rn6GUpzIfLATkbOQoyuc0EYJcoRKsWXnqfyk14OuVWaR0QpaKIGCAVDgQX9MhkoOu7c213G5Chq9kAxzUB4nsRklgPtHDO7+FY06t6lEr9wc4wcIQhBqoKbFcOA6JRZVjjhqg1lpEtwGIoqKemNo6x3fMhy2AL4OImdR3oI6r3yInB0AoAPSryOZMrJ5JlOHqDyItneg250wjUG8bTiyyc4zqhlHLN0fsuDVF5Uo65Un8lnPlTsl97Y7gJVBT+Lb/UMCtQ5fWbfOQisTtOWOADVUtS9nv0I1rk82f5wgtyBKUTCpdnF3/5UWiqB0cWBfbfACLlTKIsDLrkldJhiA+2y8/HeJ9dXu9APR7owa3M1TXrn2isR6oxbsZ5EU+ruM9iGd6WLzHQSeXshMuQBojwWAGi3eqdsdGGgDVkI+OTddP8JrRILu58dk344UfYBlnXgNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51784fbc-1bdc-4953-f2aa-08de576a3850
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:25.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ho7S+0OGb66XotkBQJgmrAhGv1D54uDm/WelaWPmvItagcf2r/R/93SSr17Wu128yFtRmES/Y1b5So7i1f5GzoH+qpDOS59Ed1IZwltoDH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Proofpoint-GUID: bq7RW7_nPBkDnKGkIgTnPBDB6kRmkKbs
X-Proofpoint-ORIG-GUID: bq7RW7_nPBkDnKGkIgTnPBDB6kRmkKbs
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696e44f4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=79C6M4AKyJxmQlF-J2AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfXywwjAXHGfnMp
 FSOMv/oF8mTjzB3igBj9psqCxBObsAwUVdE3xEJROBFIIVCPlMp3sJYtxRDhEylceSy4eGka5O5
 jbzf5HgebT7yhhXtxjkRrSI+ccJC1XLK36BS6mSM10YHAppNXKMfhAGeqgwPIW3uYzHP87egAHd
 LBYUzdSXlVL2V83k+/2q/R6xJRpuflryHcGZ+vc8fd070jU9leIuaODEkIRWCqsA4/rj0l81LpH
 fuPiOo5tThNMLY+EpaBjnlP3jaZ7ksL301JpApzxCcN5XjAgWErz9D7G1K8YaG3R7HLiEOiF2sO
 Oa3E/Uk5bxomAfVu6krKrsI20r0jUm1Ik9DnYXWryyQ7LylfW7+HMctzl372GghaBCG4yuFmWgJ
 S5JUGnHvyswZFAO16+vXW6t1BBq03c50K7t8BSbQnpjNynpQUgISkXokbu+ROl/j/TNX51JU7So
 FxjDLcgaAT3Kx2NPMiw==

In order to stay consistent between functions which manipulate a vm_flags_t
argument of the form of vma_flags_...() and those which manipulate a
VMA (in this case the flags field of a VMA), rename
vma_flag_[test/set]_atomic() to vma_[test/set]_atomic_flag().

This lays the groundwork for adding VMA flag manipulation functions in a
subsequent commit.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 13 +++++--------
 mm/khugepaged.c    |  2 +-
 mm/madvise.c       |  2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a18ade628c8e..25f7679df55c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -987,8 +987,7 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
 	__vm_flags_mod(vma, set, clear);
 }
 
-static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
-					   vma_flag_t bit)
+static inline bool __vma_atomic_valid_flag(struct vm_area_struct *vma, vma_flag_t bit)
 {
 	const vm_flags_t mask = BIT((__force int)bit);
 
@@ -1003,8 +1002,7 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
  * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
  * valid flags are allowed to do this.
  */
-static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
-				       vma_flag_t bit)
+static inline void vma_set_atomic_flag(struct vm_area_struct *vma, vma_flag_t bit)
 {
 	unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
 
@@ -1012,7 +1010,7 @@ static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
 	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
 		vma_assert_locked(vma);
 
-	if (__vma_flag_atomic_valid(vma, bit))
+	if (__vma_atomic_valid_flag(vma, bit))
 		set_bit((__force int)bit, bitmap);
 }
 
@@ -1023,10 +1021,9 @@ static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
  * This is necessarily racey, so callers must ensure that serialisation is
  * achieved through some other means, or that races are permissible.
  */
-static inline bool vma_flag_test_atomic(struct vm_area_struct *vma,
-					vma_flag_t bit)
+static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t bit)
 {
-	if (__vma_flag_atomic_valid(vma, bit))
+	if (__vma_atomic_valid_flag(vma, bit))
 		return test_bit((__force int)bit, &vma->vm_flags);
 
 	return false;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9f790ec34400..e4fe9144667a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1749,7 +1749,7 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
 	 * obtained on guard region installation after the flag is set, so this
 	 * check being performed under this lock excludes races.
 	 */
-	if (vma_flag_test_atomic(vma, VMA_MAYBE_GUARD_BIT))
+	if (vma_test_atomic_flag(vma, VMA_MAYBE_GUARD_BIT))
 		return false;
 
 	return true;
diff --git a/mm/madvise.c b/mm/madvise.c
index 4bf4c8c38fd3..98d0fddcc165 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1142,7 +1142,7 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 	 * acquire an mmap/VMA write lock to read it. All remaining readers may
 	 * or may not see the flag set, but we don't care.
 	 */
-	vma_flag_set_atomic(vma, VMA_MAYBE_GUARD_BIT);
+	vma_set_atomic_flag(vma, VMA_MAYBE_GUARD_BIT);
 
 	/*
 	 * If anonymous and we are establishing page tables the VMA ought to
-- 
2.52.0


