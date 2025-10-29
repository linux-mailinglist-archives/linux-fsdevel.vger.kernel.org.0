Return-Path: <linux-fsdevel+bounces-66349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B688AC1CA6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E1858490B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565C8350A0D;
	Wed, 29 Oct 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bOz5pMIx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wnEfppDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4DB28695;
	Wed, 29 Oct 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760300; cv=fail; b=dG7b6bugA/TWspLxnRUXVnqr8SRk2E9f1yliE80BJ+26Zskk7+4y1kZ5hlCP3Lqjy0UpbWhABztpHmXSRNJyntSbXPWpWDYzYFno3EPTRTLGPeO7z8rCLMK1YiAcSJDpWaVxPGiDH5kGQf/aU7Xg8h8S6oMZg26oMHnEjR612Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760300; c=relaxed/simple;
	bh=Fe594WvnxECTawOPCbTgP4f2/NHR0HvP7tpIhbXBBfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ie6cLJ23C5jSgi5gzAEWiVS1LArg+kIsTo6rueI0mkvnW7MjixuatoyRuRa+aUgi/sMmCFgSw3AHugfhuWCU1BAKbsYXBFuAo2CJfASw0mVNT4mQgjncMyqHd2xKLoHNxBaKgKRWB/Epy4LJuYJjVLHiNxMy8mTzpol1o3DPKGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bOz5pMIx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wnEfppDl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGfv1F006726;
	Wed, 29 Oct 2025 17:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xmcyH+HXhy6huL/7hif8RBikq7Bc8TT9Lv6n4RyJRAw=; b=
	bOz5pMIx7eM0XJhvt9Ht3vM1P/EUG8SifWHtweI65wduLjWdCYdxBZ+S/Ng9INiK
	Yfbsef7iMngTXpZ9Jjk9DFVjNQN5morrVyQl0kuJhk3srUbNwfrFbz/rPz/luzVF
	gIW7JGiTR4WhPCq3r2cOVjPw3XxxtXfnmnYCS1YLnu41142LSDtwekb0QZpceR5L
	fp3vc+JXpNmYmu2ifyX+2wcYEULraT1kdTj72/gjus3qYRVTbgCLK0Bh6ookWDv3
	uurHiyTBDW9KIF/WOzf3lZ1FfvB2S3kDAuZ2onob5SpAZfvqZV4ySL1CG/TdiF/5
	o/7CY/rOQogYf5tY8JDqpg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cbthr7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:50:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TH1KdI031648;
	Wed, 29 Oct 2025 17:50:03 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34ec96s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzp1w+42/rK+eJN6Nl6tDQyZbnBeOS2tHsqZDDEsxUBF+gvK0tWY2pP6eMpmX1shuGMZATx8Is1l21BrzoHWQWFzs6b9HAjiZ/oMjuBNpJ8c9pwTEbDDOihdKCBKtcXEF0tJh5KCIwo9eIuQgjatyUCTTk4JR0yZ1SGOscjjFsXEXx80WEgoIFyktbOTHlX/u++X9CWm1oSjGq4S+SwVYGrICpTsM1n5P/4m0Jb87XqkANzbTAqs1LQNGPC91FSAbGA5rTp86x7M6ut8B4xUNYQUa8ZJJSRRolxNrr55qW15yivxbH+2j6NCHYJxpQ84QoLhqGpdji+K23llK8CYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmcyH+HXhy6huL/7hif8RBikq7Bc8TT9Lv6n4RyJRAw=;
 b=GojgNFGCulpfa2bQGhSkmxOk/Nz8UXY4nxwbF4B0Z5kJdRzM2N9b5HHmGF52xJTl2iGR73i6HyaKDhxlI+0luQ1LoLPKHCZin0Eicnr0bvl2IUeKZOqPsASJPiC5UG6cSG6YOnPWo8QqjPM/B18B9ptKTuzyGMY40yO6GSfJ2XuObqGtEUrJy/UtRvIgsnhjiBHRGJvIIFc+0XG/uN8bGAhG/vXZWCuBnKCVTRRJ8ucWQXWh4ff7Gjae/Y1CwypsMDm+tPVWVJzUFQ6eXtJXoqziDuTC8EWLnWO2wXBy+D7pdbaTHTBIlN6hADpyFy3DKb4o/+WgiaYYbDuTT2zZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmcyH+HXhy6huL/7hif8RBikq7Bc8TT9Lv6n4RyJRAw=;
 b=wnEfppDlhGS/+P2STDO+QrgRb3d+FxZFhEPVSTDMXUqCilmJfJSSW06bhCMRMLLINR28o6YO6hmlnCUknHaANY16jyyiNVnsI14KYj4hY0t7GTb4EPKa8NUDBA75G3hGiKobTlVNJtD2pvIRikHjGd/Vz7Md33bAgwD/woPoiW8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:49:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 17:49:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/4] mm: declare VMA flags by bit
Date: Wed, 29 Oct 2025 17:49:35 +0000
Message-ID: <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0311.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5ac943-afaa-4a9a-b662-08de17138a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIhAgWDpIetZa3xkjKwCArfyEDUPrQIJDLnWjI+7Y1qoVYwPudWjjErslS/9?=
 =?us-ascii?Q?kVv1v1jtdclZoffnE99du+/T3NVhLjGN9/PKCcUdR5DNhdz3RgLFQfiAkRKy?=
 =?us-ascii?Q?rFMGldgQ3rxJ+z5crfOhAsaMJT4s+QdkDDI53+Tn0lE1TDNE4Ag7jQzeZm+1?=
 =?us-ascii?Q?/RckrYt3s0cbo0L5HiLQehwMfm2JksLPJc1hmchSXcnmqiyvfGc8k3/2BBpI?=
 =?us-ascii?Q?r/V/NP7sEws05HFJ9bmmZ3awII994VhEI4nNic/wuCSlsbvXUwy/li0M+88a?=
 =?us-ascii?Q?HDVWxxDBTVZgwc8KtMt8ZqjUoGOZai17lOZnJcI+wECrin8wmuiXpSzgK+i/?=
 =?us-ascii?Q?r3sNftWY54EzaZsWNbNC/xutS55h6w7KuzytW4z/kFpayDtwSZq9xkZ6x1ql?=
 =?us-ascii?Q?n1Jq4GF98XqcThv0OxkbwQ/5xpdYslJMglhmOp8+VK03Y+y7DFEjrHl+Y1aM?=
 =?us-ascii?Q?pxeBW8A3Pq7mUQAwNIWeUW6fjewmCcSm9SDq0CuPPSxHpcqmkJEDolP8642Q?=
 =?us-ascii?Q?IPdTPBnsirPI3HNcl+ETSR2pRssmMBCBqIiqv/usXfT3sIH00ceHP9YV3Ie/?=
 =?us-ascii?Q?uJC3sHATRKE25g1wuyI7wzl00/0JtbIGEzS4RDqEIGLZM52f0TqQ/kUZWgHx?=
 =?us-ascii?Q?qnV4c+5S14KsQ7eBRmZYCV8coKS8q0OyeoJBODAaZEgkTszMoE9fYhuw/GhG?=
 =?us-ascii?Q?NoxyVSPxNWhpu4FMVXKaE8zbiXFIcdbdamAVOd1b4wI2USvg5hrS12dYzz0d?=
 =?us-ascii?Q?UCpo71egBF8L1vQkBWrEkmj1ev7NiaJE3hJOz4UuNP1/crZza+sVAQpjPciW?=
 =?us-ascii?Q?gt3UtYdG0fQzGypMYpMo6VHhaGFO52Gv4zoMZNS3eZ0Bujec3Vls5t2JCa1N?=
 =?us-ascii?Q?fc88Qm3sispPqah7p5rjZ+e+NQYqsnuGJJxcTVfhI1F251nmKeqZddoDMQkG?=
 =?us-ascii?Q?FFSa3S2YJ3g5uvozcaipWBJN3s3zw+NndmueQbEYzHhh6Gt1iH7SJYE2qNzU?=
 =?us-ascii?Q?N7I9plUEiIjsTOom3oPh1N1NLTQNQKgX6ih2ulBUSeNpxdOedGcstEBzdjks?=
 =?us-ascii?Q?S7EeqcY5bIQ7YMlsZwaSWkrwvraKImL3eGm6Y7mi8uRPsFOWVMnBVRe4S2+a?=
 =?us-ascii?Q?PS/Df3n+whb0o7M3GdoqywW0+aK7UwSiszlazMqeAqgXrOGQNrZ38Ujiys3V?=
 =?us-ascii?Q?ccSfPwbHOzvFaRbbrGdqHbQg6ibF++KwERbsX8CwOq6+llKkT29/obf7MKnT?=
 =?us-ascii?Q?Qpsx7cR3WaoOHcc/H/Jr179+DkJJ/5rPOaejW5tQEL4kGwMQpNgxCVh1DK+g?=
 =?us-ascii?Q?8iPghDtsw3lLLSSpGbkquF4P8XIUMSxddtJjq7WhRvPPSj0nvCss1dztruUs?=
 =?us-ascii?Q?pP4Jtwr9wTOigKoQy9ZiJEuDK7WeHPGmZVDz095P9zE4I7BEer4H+hxjui+T?=
 =?us-ascii?Q?/2SXb/XdJN8kQ79xzpvfc4hEIRJ56f20?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f1XgzlJVJXS3AiFIgsJxakZ8hvqfigUPX4PWd/XdyM3srcOh01B45iuj7iHE?=
 =?us-ascii?Q?uJbpzpPL2TxYFZZ2QHRlfYqr88tbErvsVRpuOWBKI/NmdILqn509yYXNDnM7?=
 =?us-ascii?Q?o4XSxo3ipkN7skaepB8m5ttzly3PqaOFxjWo87lPohSPbVGdBMH8Y+tL5+Ua?=
 =?us-ascii?Q?oforhMdx6nd0s9CST0m6x/TSB8qVFJjdJL3fY5jRMr7wLR4la+L5DpeJ4Ro/?=
 =?us-ascii?Q?KKPWGE0weiqi+0yeYsFT0o9NsQFOPpIEgbwri+ut8fmz4A7+J/Z48LjZ26Ks?=
 =?us-ascii?Q?EYC+He71MXBo3ldDfKg/MSG8mZHcoXWkj7HA6NQfzBPTeBTnwtuFHbhL/Apt?=
 =?us-ascii?Q?iz4F+Krno6Ihc959uyGj/m1dFjqUqcSITcGhHtJfnfnMTkgFZQjpsw27SQmC?=
 =?us-ascii?Q?B6/2hhbPZe43QIxKVyAsm8tFub5xbocUESgMoIUve3HyOOmb9hirH0kckp+E?=
 =?us-ascii?Q?r65pkw1rjIJEZknp5d9Pj2IaI2bBzuLOkYZ61xU4p9ZijgB1gGtm7eNSWnRc?=
 =?us-ascii?Q?i4YIA/Co55o2NOT+PMZkDHjfOzSdHhLGsoDj3gBmOSy69O/phAwwAXVH+Sji?=
 =?us-ascii?Q?PfjnqXOlVcAkjpSu7R1pJumz32LT1pMOdvudYyRNHrcFZJw6TifYsBPxctnl?=
 =?us-ascii?Q?PXyOMFX0jSCvGA5VgZaqPtfZG/eh93iJymkIPEpp9RNZnzok8EgxU8nTi0yi?=
 =?us-ascii?Q?cdmRsg84E6BrIxC47PxrAdbHkuv8X0HgcL7IJrqbvk1eMYP9u+xWFKWR87Fs?=
 =?us-ascii?Q?cwt4GO2riqLc79ssetL7ACYOs3ZRyG5K2cx6ohYKrxEfuRWQZw8eYNC5w9Hz?=
 =?us-ascii?Q?ZrJYmXf9CSc0QNa+wZh5/sPo5uSpZI0Y1Wf3i+cnpGCzGlVBM9TXrnNqyDk6?=
 =?us-ascii?Q?oV+WE78MLbPHtzRhU9FMu8m65owb6j2hb8UXRBDdVOkPFI2JhHNd89eUfgOP?=
 =?us-ascii?Q?/08uG5Ll+NK0r3qOtfoqFa+1g197aCLuGK18WHxsReNl8MzHTGt/+OETG5pW?=
 =?us-ascii?Q?SY5CjVc1wHiVUwMbd68J7tkwlCIK1bdk5mdKqYK1qfnJy1zev4tqoDvPbR5j?=
 =?us-ascii?Q?PhJsYtecmSGWtE4ZiDpqELbKqFXi2k8b89ONM/YfdcRfYhSNG1xouYRZfDkJ?=
 =?us-ascii?Q?ZixJpYQywPK2j0GsSLUrffCU7+6dxn5cVc+8ZvSTksOsOgYG34oKcq1g3VUe?=
 =?us-ascii?Q?wJCCb5HS9aArTyD6RBYW6lLGTMn2Lt1NzX94QtbnoSPefmE0Bx85+n00/XYk?=
 =?us-ascii?Q?4QNseXwVNUx0IEKTasbrmWgLCp9Jr5ZGb4eVAofkmFtBijhmlFBkiGanPhBz?=
 =?us-ascii?Q?uB1xMCvR6AUVSwG1W2qPldxDEKKV0gyQGvLcgTm/3E28KvnF3vreu6b6kgqf?=
 =?us-ascii?Q?ZC9I4EP+zmNOn7EcDnfCQDQJxLfS4cSXis35SED74TOqn5weRDkc1O4r+UYe?=
 =?us-ascii?Q?VTIDFHcshbkH3QZlFH1GjTuJymodYBRMDzWoB1iMsndxDZi8snGymCHjrmfL?=
 =?us-ascii?Q?65fm7lG1su58RXx88sGrYahQv/CZt8SCzWUHddNULch9AHGbXkktA+VPox4S?=
 =?us-ascii?Q?JmEWei4GQyRTQ/5wviQLmlkgBZN/xWg8w6UVLdEsbfQIdNNpQITbZOouGbjL?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	He0wRBpzpmzlqYcLZqI+jI35Q40XAoLetMTrKZo6290lWP4NtqMEeX2igT4fCbcVP5/WQ7yg/QaYRUFHesLYszj6N+zDR6g9vGNdwUvTeAjmF6/HjxejJUQZM0Lw6GG+SOxM+YXZfzKVfICJ9JCFVpzGYzmjPcYmJa6QY0YgN04j3I9lkkVB4KSRfUKR3W4Gmvku5tSVfuG2C5WrIWVwdm3R6y4T7T8X3GZFdvGpmiRKk1m1ui0To6QPibHSxWLGezyBra6xsrRjm3y7gn4YU4LTXLAn+4v7Nb+hHDTHhJPKPKH0PSWMMVBA/1Hu6se7BJUvHnBiQd0FFfwgU2embYInC/SA1UZrRzcl32KTT/7I3zyXgV9AvqHRJnXKV/jTuzjIzOtGLghNJ3sDjOsmJV/69BE+NPDo0h/h9/fYL3zkTgU3G1wSIiV4Z3Mn3mijkhQfomwKyjtxwkNQmTYd2d06RNIAe9fOuKY/tWFWhoVMO11Q/HanyCItfIAT2MwsM0RDbOAj0EcVBnx8n2+XMhcw/PpTqEpxC2POk6McjUZnF/HU6L4D1fkCrHRAdTWPsU+kwusboZTl32Vvh7Qnbdwro8aJycYzbA9rIWyOauc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5ac943-afaa-4a9a-b662-08de17138a92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:49:43.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFS/URmeQyC8U5GamlqnW4DKRycsZQ+zZhavd1xLVwQ7aPpQJ3iT+vdKWGV0kTTpJUyDMdEBjbSHVPoy/TTinvgVWgk6KdCRyXB0HKINrdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290142
X-Proofpoint-GUID: 2Me7yfc89gr4ZWe-FwvIaticfrTFYIR9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzNSBTYWx0ZWRfX+L+GRf3gvMpd
 e99vP6GedfwlVK8ZE0E3bw30TIsvJlAvBg70FW7Mx6MitfgiYLcYRXa6xmC/VbA4bFMfc5Tx5lr
 phEiqZgoXKwBmRpHY5JPQB4d5Dky9YaLjNeUZYp5OsirnwswjRuhI2tvzOqVPRmHnoR0ygwLwur
 nbRmWGaGSE1V3ugBBxaADdgp5/se4GQZflEFg6wUILo8T/tf8ZGdYlXtEqivua27f3WFSkrwiG9
 +HueeIL/gjZ/LGiFSMCgiB9avTA6BMb/01QOKDIRIssdJVpE7UTyxVFyJ9HS7ExLdPiCag936CS
 fuyVLUTOb9FIYl+X9/5r+gidEDNU/+J5at4IjfRYn2XYuqvc5WAXlWcpJCwjTjuFttKHXW7F9G6
 Qcva8g3DcObQLmao5Zdt/zmSwRaHUWPFwKpXOA+o2ykuv01hJaE=
X-Authority-Analysis: v=2.4 cv=A8Nh/qWG c=1 sm=1 tr=0 ts=690253cd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=2VjzOFfT8JVXtLKdsj0A:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: 2Me7yfc89gr4ZWe-FwvIaticfrTFYIR9

In order to lay the groundwork for VMA flags being a bitmap rather than a
system word in size, we need to be able to consistently refer to VMA flags
by bit number rather than value.

Take this opportunity to do so in an enum which we which is additionally
useful for tooling to extract metadata from.

This additionally makes it very clear which bits are being used for what at
a glance.

We use the VMA_ prefix for the bit values as it is logical to do so since
these reference VMAs. We consistently suffix with _BIT to make it clear
what the values refer to.

We place all bits 32+ in an #ifdef CONFIG_64BIT block as indeed these all
require a 64-bit system and it's neater and self-documenting to do so.

We declare a sparse-bitwise type vma_flag_t which ensures that users can't
pass around invalid VMA flags by accident and prepares for future work
towards VMA flags being a bitmap where we want to ensure bit values are
type safe.

Finally, we have to update some rather silly if-deffery found in
mm/task_mmu.c which would otherwise break.

Additionally, update the VMA userland testing vma_internal.h header to
include these changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c               |   4 +-
 include/linux/mm.h               | 286 +++++++++++++++++---------
 tools/testing/vma/vma_internal.h | 341 +++++++++++++++++++++++++++----
 3 files changed, 488 insertions(+), 143 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index db16ed91c269..c113a3eb5cbd 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1182,10 +1182,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT0)]	= "",
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
-#if VM_PKEY_BIT3
+#if CONFIG_ARCH_PKEY_BITS > 3
 		[ilog2(VM_PKEY_BIT3)]	= "",
 #endif
-#if VM_PKEY_BIT4
+#if CONFIG_ARCH_PKEY_BITS > 4
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a8811ba57150..bb0d8a1d1d73 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -271,94 +271,172 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+/**
+ * vma_flag_t - specifies an individual VMA flag by bit number.
+ *
+ * This value is made type safe by sparse to avoid passing invalid flag values
+ * around.
+ */
+typedef int __bitwise vma_flag_t;
+
+enum {
+	/* currently active flags */
+	VMA_READ_BIT = (__force vma_flag_t)0,
+	VMA_WRITE_BIT = (__force vma_flag_t)1,
+	VMA_EXEC_BIT = (__force vma_flag_t)2,
+	VMA_SHARED_BIT = (__force vma_flag_t)3,
+
+	/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
+	VMA_MAYREAD_BIT = (__force vma_flag_t)4, /* limits for mprotect() etc */
+	VMA_MAYWRITE_BIT = (__force vma_flag_t)5,
+	VMA_MAYEXEC_BIT = (__force vma_flag_t)6,
+	VMA_MAYSHARE_BIT = (__force vma_flag_t)7,
+
+	VMA_GROWSDOWN_BIT = (__force vma_flag_t)8, /* general info on the segment */
+#ifdef CONFIG_MMU
+	VMA_UFFD_MISSING_BIT = (__force vma_flag_t)9, /* missing pages tracking */
+#else
+	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+	VMA_MAYOVERLAY_BIT = (__force vma_flag_t)9,
+#endif
+	/* Page-ranges managed without "struct page", just pure PFN */
+	VMA_PFNMAP_BIT = (__force vma_flag_t)10,
+
+	VMA_MAYBE_GUARD_BIT = (__force vma_flag_t)11,
+
+	VMA_UFFD_WP_BIT = (__force vma_flag_t)12, /* wrprotect pages tracking */
+
+	VMA_LOCKED_BIT = (__force vma_flag_t)13,
+	VMA_IO_BIT = (__force vma_flag_t)14, /* Memory mapped I/O or similar */
+
+	/* Used by madvise() */
+	VMA_SEQ_READ_BIT = (__force vma_flag_t)15, /* App will access data sequentially */
+	VMA_RAND_READ_BIT = (__force vma_flag_t)16, /* App will not benefit from clustered reads */
+
+	VMA_DONTCOPY_BIT = (__force vma_flag_t)17, /* Do not copy this vma on fork */
+	VMA_DONTEXPAND_BIT = (__force vma_flag_t)18, /* Cannot expand with mremap() */
+	VMA_LOCKONFAULT_BIT = (__force vma_flag_t)19, /* Lock pages covered when faulted in */
+	VMA_ACCOUNT_BIT = (__force vma_flag_t)20, /* Is a VM accounted object */
+	VMA_NORESERVE_BIT = (__force vma_flag_t)21, /* should the VM suppress accounting */
+	VMA_HUGETLB_BIT = (__force vma_flag_t)22, /* Huge TLB Page VM */
+	VMA_SYNC_BIT = (__force vma_flag_t)23, /* Synchronous page faults */
+	VMA_ARCH_1_BIT = (__force vma_flag_t)24, /* Architecture-specific flag */
+	VMA_WIPEONFORK_BIT = (__force vma_flag_t)25, /* Wipe VMA contents in child. */
+	VMA_DONTDUMP_BIT = (__force vma_flag_t)26, /* Do not include in the core dump */
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	VMA_SOFTDIRTY_BIT = (__force vma_flag_t)27, /* Not soft dirty clean area */
+#endif
+
+	VMA_MIXEDMAP_BIT = (__force vma_flag_t)28, /* Can contain struct page and pure PFN pages */
+	VMA_HUGEPAGE_BIT = (__force vma_flag_t)29, /* MADV_HUGEPAGE marked this vma */
+	VMA_NOHUGEPAGE_BIT = (__force vma_flag_t)30, /* MADV_NOHUGEPAGE marked this vma */
+	VMA_MERGEABLE_BIT = (__force vma_flag_t)31, /* KSM may merge identical pages */
+
+#ifdef CONFIG_64BIT
+	/* These bits are reused, we define specific uses below. */
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+	VMA_HIGH_ARCH_0_BIT = (__force vma_flag_t)32,
+	VMA_HIGH_ARCH_1_BIT = (__force vma_flag_t)33,
+	VMA_HIGH_ARCH_2_BIT = (__force vma_flag_t)34,
+	VMA_HIGH_ARCH_3_BIT = (__force vma_flag_t)35,
+	VMA_HIGH_ARCH_4_BIT = (__force vma_flag_t)36,
+	VMA_HIGH_ARCH_5_BIT = (__force vma_flag_t)37,
+	VMA_HIGH_ARCH_6_BIT = (__force vma_flag_t)38,
+#endif
+
+	VMA_ALLOW_ANY_UNCACHED_BIT = (__force vma_flag_t)39,
+	VMA_DROPPABLE_BIT = (__force vma_flag_t)40,
+
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+	VMA_UFFD_MINOR_BIT = (__force vma_flag_t)41,
+#endif
+
+	VMA_SEALED_BIT = (__force vma_flag_t)42,
+#endif /* CONFIG_64BIT */
+};
+
+#define VMA_BIT(bit)	BIT((__force int)bit)
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
  */
 #define VM_NONE		0x00000000
 
-#define VM_READ		0x00000001	/* currently active flags */
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
+#define VM_READ		VMA_BIT(VMA_READ_BIT)
+#define VM_WRITE	VMA_BIT(VMA_WRITE_BIT)
+#define VM_EXEC		VMA_BIT(VMA_EXEC_BIT)
+#define VM_SHARED	VMA_BIT(VMA_SHARED_BIT)
 
-/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
+#define VM_MAYREAD	VMA_BIT(VMA_MAYREAD_BIT)
+#define VM_MAYWRITE	VMA_BIT(VMA_MAYWRITE_BIT)
+#define VM_MAYEXEC	VMA_BIT(VMA_MAYEXEC_BIT)
+#define VM_MAYSHARE	VMA_BIT(VMA_MAYSHARE_BIT)
+
+#define VM_GROWSDOWN	VMA_BIT(VMA_GROWSDOWN_BIT)
 
-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
 #ifdef CONFIG_MMU
-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
+#define VM_UFFD_MISSING	VMA_BIT(VMA_UFFD_MISSING_BIT)
 #else /* CONFIG_MMU */
-#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
 #define VM_UFFD_MISSING	0
-#endif /* CONFIG_MMU */
-#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_MAYBE_GUARD	0x00000800	/* The VMA maybe contains guard regions. */
-#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
-
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
-
-					/* Used by sys_madvise() */
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-
-#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
-#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_LOCKONFAULT	0x00080000	/* Lock the pages covered when they are faulted in */
-#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
-#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
-#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_SYNC		0x00800000	/* Synchronous page faults */
-#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
-#define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
-#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
+#endif
+
+#define VM_PFNMAP	VMA_BIT(VMA_PFNMAP_BIT)
+
+#define VM_MAYBE_GUARD	VMA_BIT(VMA_MAYBE_GUARD_BIT)
+
+#define VM_UFFD_WP	VMA_BIT(VMA_UFFD_WP_BIT)
+
+#define VM_LOCKED	VMA_BIT(VMA_LOCKED_BIT)
+#define VM_IO		VMA_BIT(VMA_IO_BIT)
+
+#define VM_SEQ_READ	VMA_BIT(VMA_SEQ_READ_BIT)
+#define VM_RAND_READ	VMA_BIT(VMA_RAND_READ_BIT)
+
+#define VM_DONTCOPY	VMA_BIT(VMA_DONTCOPY_BIT)
+#define VM_DONTEXPAND	VMA_BIT(VMA_DONTEXPAND_BIT)
+#define VM_LOCKONFAULT	VMA_BIT(VMA_LOCKONFAULT_BIT)
+#define VM_ACCOUNT	VMA_BIT(VMA_ACCOUNT_BIT)
+#define VM_NORESERVE	VMA_BIT(VMA_NORESERVE_BIT)
+#define VM_HUGETLB	VMA_BIT(VMA_HUGETLB_BIT)
+#define VM_SYNC		VMA_BIT(VMA_SYNC_BIT)
+#define VM_ARCH_1	VMA_BIT(VMA_ARCH_1_BIT)
+#define VM_WIPEONFORK	VMA_BIT(VMA_WIPEONFORK_BIT)
+#define VM_DONTDUMP	VMA_BIT(VMA_DONTDUMP_BIT)
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
+#define VM_SOFTDIRTY	VMA_BIT(VMA_SOFTDIRTY_BIT)
 #else
-# define VM_SOFTDIRTY	0
+#define VM_SOFTDIRTY	0
 #endif
 
-#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
-#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
-#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
-
-#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
-#define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_1	33	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
-#define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
-#define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
-#define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
-#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
-#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
-#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
-#endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
+#define VM_MIXEDMAP	VMA_BIT(VMA_MIXEDMAP_BIT)
+#define VM_HUGEPAGE	VMA_BIT(VMA_HUGEPAGE_BIT)
+#define VM_NOHUGEPAGE	VMA_BIT(VMA_NOHUGEPAGE_BIT)
+#define VM_MERGEABLE	VMA_BIT(VMA_MERGEABLE_BIT)
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
-# define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
-# define VM_PKEY_BIT0  VM_HIGH_ARCH_0
-# define VM_PKEY_BIT1  VM_HIGH_ARCH_1
-# define VM_PKEY_BIT2  VM_HIGH_ARCH_2
+#define VMA_PKEY_BIT0_BIT VMA_HIGH_ARCH_0_BIT
+#define VMA_PKEY_BIT1_BIT VMA_HIGH_ARCH_1_BIT
+#define VMA_PKEY_BIT2_BIT VMA_HIGH_ARCH_2_BIT
+
+#define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
+
+#define VM_PKEY_BIT0 VMA_BIT(VMA_PKEY_BIT0_BIT)
+#define VM_PKEY_BIT1 VMA_BIT(VMA_PKEY_BIT1_BIT)
+#define VM_PKEY_BIT2 VMA_BIT(VMA_PKEY_BIT2_BIT)
 #if CONFIG_ARCH_PKEY_BITS > 3
-# define VM_PKEY_BIT3  VM_HIGH_ARCH_3
+#define VMA_PKEY_BIT3_BIT VMA_HIGH_ARCH_3_BIT
+#define VM_PKEY_BIT3 VMA_BIT(VMA_PKEY_BIT3_BIT)
 #else
-# define VM_PKEY_BIT3  0
+#define VM_PKEY_BIT3  0
 #endif
 #if CONFIG_ARCH_PKEY_BITS > 4
-# define VM_PKEY_BIT4  VM_HIGH_ARCH_4
+#define VMA_PKEY_BIT4_BIT VMA_HIGH_ARCH_4_BIT
+#define VM_PKEY_BIT4 VMA_BIT(VMA_PKEY_BIT4_BIT)
 #else
-# define VM_PKEY_BIT4  0
+#define VM_PKEY_BIT4  0
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
@@ -372,53 +450,63 @@ extern unsigned int kobjsize(const void *objp);
  * (x86). See the comments near alloc_shstk() in arch/x86/kernel/shstk.c
  * for more details on the guard size.
  */
-# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#define VMA_SHADOW_STACK_BIT	VMA_HIGH_ARCH_5_BIT
+#define VM_SHADOW_STACK		VMA_BIT(VMA_SHADOW_STACK_BIT)
 #endif
 
-#if defined(CONFIG_ARM64_GCS)
+#ifdef CONFIG_ARM64_GCS
 /*
  * arm64's Guarded Control Stack implements similar functionality and
  * has similar constraints to shadow stacks.
  */
-# define VM_SHADOW_STACK	VM_HIGH_ARCH_6
+#define VMA_SHADOW_STACK_BIT	VMA_HIGH_ARCH_6_BIT
+#define VM_SHADOW_STACK		VMA_BIT(VMA_SHADOW_STACK_BIT)
 #endif
 
 #ifndef VM_SHADOW_STACK
-# define VM_SHADOW_STACK	VM_NONE
+#define VM_SHADOW_STACK	VM_NONE
 #endif
 
 #if defined(CONFIG_PPC64)
-# define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
+#define VMA_SAO_BIT	VMA_ARCH_1_BIT /* Strong Access Ordering (powerpc) */
+#define VM_SAO		VMA_BIT(VMA_SAO_BIT)
 #elif defined(CONFIG_PARISC)
-# define VM_GROWSUP	VM_ARCH_1
+#define VMA_GROWSUP_BIT	VMA_ARCH_1_BIT
+#define VM_GROWSUP	VMA_BIT(VMA_GROWSUP_BIT)
 #elif defined(CONFIG_SPARC64)
-# define VM_SPARC_ADI	VM_ARCH_1	/* Uses ADI tag for access control */
-# define VM_ARCH_CLEAR	VM_SPARC_ADI
+#define VMA_SPARC_ADI_BIT VMA_ARCH_1_BIT /* Uses ADI tag for access control */
+#define VMA_ARCH_CLEAR_BIT VMA_ARCH_1_BIT
+#define VM_SPARC_ADI	VMA_BIT(VMA_SPARC_ADI_BIT)
+#define VM_ARCH_CLEAR	VMA_BIT(VMA_ARCH_CLEAR_BIT)
 #elif defined(CONFIG_ARM64)
-# define VM_ARM64_BTI	VM_ARCH_1	/* BTI guarded page, a.k.a. GP bit */
-# define VM_ARCH_CLEAR	VM_ARM64_BTI
+#define VMA_ARM64_BTI_BIT VMA_ARCH_1_BIT /* BTI guarded page, a.k.a. GP bit */
+#define VMA_ARCH_CLEAR_BIT VMA_ARCH_1_BIT
+#define VM_ARM64_BTI	VMA_BIT(VMA_ARM64_BTI_BIT)
+#define VM_ARCH_CLEAR	VMA_BIT(VMA_ARCH_CLEAR_BIT)
 #elif !defined(CONFIG_MMU)
-# define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
+#define VMA_MAPPED_COPY_BIT VMA_ARCH_1_BIT /* T if mapped copy of data (nommu mmap) */
+#define VM_MAPPED_COPY	VMA_BIT(VMA_MAPPED_COPY_BIT)
 #endif
 
 #if defined(CONFIG_ARM64_MTE)
-# define VM_MTE		VM_HIGH_ARCH_4	/* Use Tagged memory for access control */
-# define VM_MTE_ALLOWED	VM_HIGH_ARCH_5	/* Tagged memory permitted */
+#define VMA_MTE_BIT	VMA_HIGH_ARCH_4_BIT /* Use Tagged memory for access control */
+#define VMA_MTE_ALLOWED_BIT VMA_HIGH_ARCH_5_BIT /* Tagged memory permitted */
+#define VM_MTE		VMA_BIT(VMA_MTE_BIT)
+#define VM_MTE_ALLOWED	VMA_BIT(VMA_MTE_ALLOWED_BIT)
 #else
-# define VM_MTE		VM_NONE
-# define VM_MTE_ALLOWED	VM_NONE
+#define VM_MTE		VM_NONE
+#define VM_MTE_ALLOWED	VM_NONE
 #endif
 
 #ifndef VM_GROWSUP
-# define VM_GROWSUP	VM_NONE
+#define VM_GROWSUP	VM_NONE
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-# define VM_UFFD_MINOR_BIT	41
-# define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
-#else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-# define VM_UFFD_MINOR		VM_NONE
-#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+#define VM_UFFD_MINOR	VMA_BIT(VMA_UFFD_MINOR_BIT) /* UFFD minor faults */
+#else
+#define VM_UFFD_MINOR	VM_NONE
+#endif
 
 /*
  * This flag is used to connect VFIO to arch specific KVM code. It
@@ -428,24 +516,22 @@ extern unsigned int kobjsize(const void *objp);
  * if KVM does not lock down the memory type.
  */
 #ifdef CONFIG_64BIT
-#define VM_ALLOW_ANY_UNCACHED_BIT	39
-#define VM_ALLOW_ANY_UNCACHED		BIT(VM_ALLOW_ANY_UNCACHED_BIT)
+#define VM_ALLOW_ANY_UNCACHED	VMA_BIT(VMA_ALLOW_ANY_UNCACHED_BIT)
 #else
-#define VM_ALLOW_ANY_UNCACHED		VM_NONE
+#define VM_ALLOW_ANY_UNCACHED	VM_NONE
 #endif
 
 #ifdef CONFIG_64BIT
-#define VM_DROPPABLE_BIT	40
-#define VM_DROPPABLE		BIT(VM_DROPPABLE_BIT)
+#define VM_DROPPABLE		VMA_BIT(VMA_DROPPABLE_BIT)
 #elif defined(CONFIG_PPC32)
-#define VM_DROPPABLE		VM_ARCH_1
+#define VMA_DROPPABLE_BIT	VM_ARCH_1_BIT
+#define VM_DROPPABLE		VMA_BIT(VMA_DROPPABLE_BIT)
 #else
 #define VM_DROPPABLE		VM_NONE
 #endif
 
 #ifdef CONFIG_64BIT
-#define VM_SEALED_BIT	42
-#define VM_SEALED	BIT(VM_SEALED_BIT)
+#define VM_SEALED	VMA_BIT(VMA_SEALED_BIT)
 #else
 #define VM_SEALED	VM_NONE
 #endif
@@ -474,10 +560,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
 
 #ifdef CONFIG_STACK_GROWSUP
-#define VM_STACK	VM_GROWSUP
-#define VM_STACK_EARLY	VM_GROWSDOWN
+#define VMA_STACK_BIT	VMA_GROWSUP_BIT
+#define VMA_STACK_EARLY_BIT VMA_GROWSDOWN_BIT
+#define VM_STACK	VMA_BIT(VMA_STACK_BIT)
+#define VM_STACK_EARLY	VMA_BIT(VMA_STACK_EARLY_BIT)
 #else
-#define VM_STACK	VM_GROWSDOWN
+#define VMA_STACK_BIT	VMA_GROWSDOWN_BIT
+#define VM_STACK	VMA_BIT(VMA_STACK_BIT)
 #define VM_STACK_EARLY	0
 #endif
 
@@ -486,7 +575,6 @@ extern unsigned int kobjsize(const void *objp);
 /* VMA basic access permission flags */
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
 
-
 /*
  * Special vmas that are non-mergable, non-mlock()able.
  */
@@ -518,7 +606,7 @@ extern unsigned int kobjsize(const void *objp);
 
 /* Arch-specific flags to clear when updating VM flags on protection change */
 #ifndef VM_ARCH_CLEAR
-# define VM_ARCH_CLEAR	VM_NONE
+#define VM_ARCH_CLEAR	VM_NONE
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 3d9cb3a9411a..7868c419191b 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -46,43 +46,315 @@ extern unsigned long dac_mmap_min_addr;
 
 #define MMF_HAS_MDWE	28
 
+/**
+ * vma_flag_t - specifies an individual VMA flag by bit number.
+ *
+ * This value is made type safe by sparse to avoid passing invalid flag values
+ * around.
+ */
+typedef int __bitwise vma_flag_t;
+
+enum {
+	/* currently active flags */
+	VMA_READ_BIT = (__force vma_flag_t)0,
+	VMA_WRITE_BIT = (__force vma_flag_t)1,
+	VMA_EXEC_BIT = (__force vma_flag_t)2,
+	VMA_SHARED_BIT = (__force vma_flag_t)3,
+
+	/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
+	VMA_MAYREAD_BIT = (__force vma_flag_t)4, /* limits for mprotect() etc */
+	VMA_MAYWRITE_BIT = (__force vma_flag_t)5,
+	VMA_MAYEXEC_BIT = (__force vma_flag_t)6,
+	VMA_MAYSHARE_BIT = (__force vma_flag_t)7,
+
+	VMA_GROWSDOWN_BIT = (__force vma_flag_t)8, /* general info on the segment */
+#ifdef CONFIG_MMU
+	VMA_UFFD_MISSING_BIT = (__force vma_flag_t)9, /* missing pages tracking */
+#else
+	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+	VMA_MAYOVERLAY_BIT = (__force vma_flag_t)9,
+#endif
+	/* Page-ranges managed without "struct page", just pure PFN */
+	VMA_PFNMAP_BIT = (__force vma_flag_t)10,
+
+	VMA_MAYBE_GUARD_BIT = (__force vma_flag_t)11,
+
+	VMA_UFFD_WP_BIT = (__force vma_flag_t)12, /* wrprotect pages tracking */
+
+	VMA_LOCKED_BIT = (__force vma_flag_t)13,
+	VMA_IO_BIT = (__force vma_flag_t)14, /* Memory mapped I/O or similar */
+
+	/* Used by madvise() */
+	VMA_SEQ_READ_BIT = (__force vma_flag_t)15, /* App will access data sequentially */
+	VMA_RAND_READ_BIT = (__force vma_flag_t)16, /* App will not benefit from clustered reads */
+
+	VMA_DONTCOPY_BIT = (__force vma_flag_t)17, /* Do not copy this vma on fork */
+	VMA_DONTEXPAND_BIT = (__force vma_flag_t)18, /* Cannot expand with mremap() */
+	VMA_LOCKONFAULT_BIT = (__force vma_flag_t)19, /* Lock pages covered when faulted in */
+	VMA_ACCOUNT_BIT = (__force vma_flag_t)20, /* Is a VM accounted object */
+	VMA_NORESERVE_BIT = (__force vma_flag_t)21, /* should the VM suppress accounting */
+	VMA_HUGETLB_BIT = (__force vma_flag_t)22, /* Huge TLB Page VM */
+	VMA_SYNC_BIT = (__force vma_flag_t)23, /* Synchronous page faults */
+	VMA_ARCH_1_BIT = (__force vma_flag_t)24, /* Architecture-specific flag */
+	VMA_WIPEONFORK_BIT = (__force vma_flag_t)25, /* Wipe VMA contents in child. */
+	VMA_DONTDUMP_BIT = (__force vma_flag_t)26, /* Do not include in the core dump */
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	VMA_SOFTDIRTY_BIT = (__force vma_flag_t)27, /* Not soft dirty clean area */
+#endif
+
+	VMA_MIXEDMAP_BIT = (__force vma_flag_t)28, /* Can contain struct page and pure PFN pages */
+	VMA_HUGEPAGE_BIT = (__force vma_flag_t)29, /* MADV_HUGEPAGE marked this vma */
+	VMA_NOHUGEPAGE_BIT = (__force vma_flag_t)30, /* MADV_NOHUGEPAGE marked this vma */
+	VMA_MERGEABLE_BIT = (__force vma_flag_t)31, /* KSM may merge identical pages */
+
+#ifdef CONFIG_64BIT
+	/* These bits are reused, we define specific uses below. */
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+	VMA_HIGH_ARCH_0_BIT = (__force vma_flag_t)32,
+	VMA_HIGH_ARCH_1_BIT = (__force vma_flag_t)33,
+	VMA_HIGH_ARCH_2_BIT = (__force vma_flag_t)34,
+	VMA_HIGH_ARCH_3_BIT = (__force vma_flag_t)35,
+	VMA_HIGH_ARCH_4_BIT = (__force vma_flag_t)36,
+	VMA_HIGH_ARCH_5_BIT = (__force vma_flag_t)37,
+	VMA_HIGH_ARCH_6_BIT = (__force vma_flag_t)38,
+#endif
+
+	VMA_ALLOW_ANY_UNCACHED_BIT = (__force vma_flag_t)39,
+	VMA_DROPPABLE_BIT = (__force vma_flag_t)40,
+
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+	VMA_UFFD_MINOR_BIT = (__force vma_flag_t)41,
+#endif
+
+	VMA_SEALED_BIT = (__force vma_flag_t)42,
+#endif /* CONFIG_64BIT */
+};
+
+#define VMA_BIT(bit)	BIT((__force int)bit)
+
+/*
+ * vm_flags in vm_area_struct, see mm_types.h.
+ * When changing, update also include/trace/events/mmflags.h
+ */
 #define VM_NONE		0x00000000
-#define VM_READ		0x00000001
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
-#define VM_MAYREAD	0x00000010
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_GROWSDOWN	0x00000100
-#define VM_PFNMAP	0x00000400
-#define VM_MAYBE_GUARD	0x00000800
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-#define VM_DONTEXPAND	0x00040000
-#define VM_LOCKONFAULT	0x00080000
-#define VM_ACCOUNT	0x00100000
-#define VM_NORESERVE	0x00200000
-#define VM_MIXEDMAP	0x10000000
-#define VM_STACK	VM_GROWSDOWN
-#define VM_SHADOW_STACK	VM_NONE
+
+#define VM_READ		VMA_BIT(VMA_READ_BIT)
+#define VM_WRITE	VMA_BIT(VMA_WRITE_BIT)
+#define VM_EXEC		VMA_BIT(VMA_EXEC_BIT)
+#define VM_SHARED	VMA_BIT(VMA_SHARED_BIT)
+
+#define VM_MAYREAD	VMA_BIT(VMA_MAYREAD_BIT)
+#define VM_MAYWRITE	VMA_BIT(VMA_MAYWRITE_BIT)
+#define VM_MAYEXEC	VMA_BIT(VMA_MAYEXEC_BIT)
+#define VM_MAYSHARE	VMA_BIT(VMA_MAYSHARE_BIT)
+
+#define VM_GROWSDOWN	VMA_BIT(VMA_GROWSDOWN_BIT)
+
+#ifdef CONFIG_MMU
+#define VM_UFFD_MISSING	VMA_BIT(VMA_UFFD_MISSING_BIT)
+#else /* CONFIG_MMU */
+#define VM_UFFD_MISSING	0
+#endif
+
+#define VM_PFNMAP	VMA_BIT(VMA_PFNMAP_BIT)
+
+#define VM_MAYBE_GUARD	VMA_BIT(VMA_MAYBE_GUARD_BIT)
+
+#define VM_UFFD_WP	VMA_BIT(VMA_UFFD_WP_BIT)
+
+#define VM_LOCKED	VMA_BIT(VMA_LOCKED_BIT)
+#define VM_IO		VMA_BIT(VMA_IO_BIT)
+
+#define VM_SEQ_READ	VMA_BIT(VMA_SEQ_READ_BIT)
+#define VM_RAND_READ	VMA_BIT(VMA_RAND_READ_BIT)
+
+#define VM_DONTCOPY	VMA_BIT(VMA_DONTCOPY_BIT)
+#define VM_DONTEXPAND	VMA_BIT(VMA_DONTEXPAND_BIT)
+#define VM_LOCKONFAULT	VMA_BIT(VMA_LOCKONFAULT_BIT)
+#define VM_ACCOUNT	VMA_BIT(VMA_ACCOUNT_BIT)
+#define VM_NORESERVE	VMA_BIT(VMA_NORESERVE_BIT)
+#define VM_HUGETLB	VMA_BIT(VMA_HUGETLB_BIT)
+#define VM_SYNC		VMA_BIT(VMA_SYNC_BIT)
+#define VM_ARCH_1	VMA_BIT(VMA_ARCH_1_BIT)
+#define VM_WIPEONFORK	VMA_BIT(VMA_WIPEONFORK_BIT)
+#define VM_DONTDUMP	VMA_BIT(VMA_DONTDUMP_BIT)
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define VM_SOFTDIRTY	VMA_BIT(VMA_SOFTDIRTY_BIT)
+#else
 #define VM_SOFTDIRTY	0
-#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
+#endif
+
+#define VM_MIXEDMAP	VMA_BIT(VMA_MIXEDMAP_BIT)
+#define VM_HUGEPAGE	VMA_BIT(VMA_HUGEPAGE_BIT)
+#define VM_NOHUGEPAGE	VMA_BIT(VMA_NOHUGEPAGE_BIT)
+#define VM_MERGEABLE	VMA_BIT(VMA_MERGEABLE_BIT)
+
+#ifdef CONFIG_ARCH_HAS_PKEYS
+#define VMA_PKEY_BIT0_BIT VMA_HIGH_ARCH_0_BIT
+#define VMA_PKEY_BIT1_BIT VMA_HIGH_ARCH_1_BIT
+#define VMA_PKEY_BIT2_BIT VMA_HIGH_ARCH_2_BIT
+
+#define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
+
+#define VM_PKEY_BIT0 VMA_BIT(VMA_PKEY_BIT0_BIT)
+#define VM_PKEY_BIT1 VMA_BIT(VMA_PKEY_BIT1_BIT)
+#define VM_PKEY_BIT2 VMA_BIT(VMA_PKEY_BIT2_BIT)
+#if CONFIG_ARCH_PKEY_BITS > 3
+#define VMA_PKEY_BIT3_BIT VMA_HIGH_ARCH_3_BIT
+#define VM_PKEY_BIT3 VMA_BIT(VMA_PKEY_BIT3_BIT)
+#else
+#define VM_PKEY_BIT3  0
+#endif
+#if CONFIG_ARCH_PKEY_BITS > 4
+#define VMA_PKEY_BIT4_BIT VMA_HIGH_ARCH_4_BIT
+#define VM_PKEY_BIT4 VMA_BIT(VMA_PKEY_BIT4_BIT)
+#else
+#define VM_PKEY_BIT4  0
+#endif
+#endif /* CONFIG_ARCH_HAS_PKEYS */
+
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+/*
+ * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
+ * support core mm.
+ *
+ * These VMAs will get a single end guard page. This helps userspace protect
+ * itself from attacks. A single page is enough for current shadow stack archs
+ * (x86). See the comments near alloc_shstk() in arch/x86/kernel/shstk.c
+ * for more details on the guard size.
+ */
+#define VMA_SHADOW_STACK_BIT	VMA_HIGH_ARCH_5_BIT
+#define VM_SHADOW_STACK		VMA_BIT(VMA_SHADOW_STACK_BIT)
+#endif
+
+#ifdef CONFIG_ARM64_GCS
+/*
+ * arm64's Guarded Control Stack implements similar functionality and
+ * has similar constraints to shadow stacks.
+ */
+#define VMA_SHADOW_STACK_BIT	VMA_HIGH_ARCH_6_BIT
+#define VM_SHADOW_STACK		VMA_BIT(VMA_SHADOW_STACK_BIT)
+#endif
+
+#ifndef VM_SHADOW_STACK
+#define VM_SHADOW_STACK	VM_NONE
+#endif
+
+#if defined(CONFIG_PPC64)
+#define VMA_SAO_BIT	VMA_ARCH_1_BIT /* Strong Access Ordering (powerpc) */
+#define VM_SAO		VMA_BIT(VMA_SAO_BIT)
+#elif defined(CONFIG_PARISC)
+#define VMA_GROWSUP_BIT	VMA_ARCH_1_BIT
+#define VM_GROWSUP	VMA_BIT(VMA_GROWSUP_BIT)
+#elif defined(CONFIG_SPARC64)
+#define VMA_SPARC_ADI_BIT VMA_ARCH_1_BIT /* Uses ADI tag for access control */
+#define VMA_ARCH_CLEAR_BIT VMA_ARCH_1_BIT
+#define VM_SPARC_ADI	VMA_BIT(VMA_SPARC_ADI_BIT)
+#define VM_ARCH_CLEAR	VMA_BIT(VMA_ARCH_CLEAR_BIT)
+#elif defined(CONFIG_ARM64)
+#define VMA_ARM64_BTI_BIT VMA_ARCH_1_BIT /* BTI guarded page, a.k.a. GP bit */
+#define VMA_ARCH_CLEAR_BIT VMA_ARCH_1_BIT
+#define VM_ARM64_BTI	VMA_BIT(VMA_ARM64_BTI_BIT)
+#define VM_ARCH_CLEAR	VMA_BIT(VMA_ARCH_CLEAR_BIT)
+#elif !defined(CONFIG_MMU)
+#define VMA_MAPPED_COPY_BIT VMA_ARCH_1_BIT /* T if mapped copy of data (nommu mmap) */
+#define VM_MAPPED_COPY	VMA_BIT(VMA_MAPPED_COPY_BIT)
+#endif
+
+#if defined(CONFIG_ARM64_MTE)
+#define VMA_MTE_BIT	VMA_HIGH_ARCH_4_BIT /* Use Tagged memory for access control */
+#define VMA_MTE_ALLOWED_BIT VMA_HIGH_ARCH_5_BIT /* Tagged memory permitted */
+#define VM_MTE		VMA_BIT(VMA_MTE_BIT)
+#define VM_MTE_ALLOWED	VMA_BIT(VMA_MTE_ALLOWED_BIT)
+#else
+#define VM_MTE		VM_NONE
+#define VM_MTE_ALLOWED	VM_NONE
+#endif
+
+#ifndef VM_GROWSUP
 #define VM_GROWSUP	VM_NONE
+#endif
 
-#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
-#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+#define VM_UFFD_MINOR	VMA_BIT(VMA_UFFD_MINOR_BIT) /* UFFD minor faults */
+#else
+#define VM_UFFD_MINOR	VM_NONE
+#endif
+
+/*
+ * This flag is used to connect VFIO to arch specific KVM code. It
+ * indicates that the memory under this VMA is safe for use with any
+ * non-cachable memory type inside KVM. Some VFIO devices, on some
+ * platforms, are thought to be unsafe and can cause machine crashes
+ * if KVM does not lock down the memory type.
+ */
+#ifdef CONFIG_64BIT
+#define VM_ALLOW_ANY_UNCACHED	VMA_BIT(VMA_ALLOW_ANY_UNCACHED_BIT)
+#else
+#define VM_ALLOW_ANY_UNCACHED	VM_NONE
+#endif
+
+#ifdef CONFIG_64BIT
+#define VM_DROPPABLE		VMA_BIT(VMA_DROPPABLE_BIT)
+#elif defined(CONFIG_PPC32)
+#define VMA_DROPPABLE_BIT	VM_ARCH_1_BIT
+#define VM_DROPPABLE		VMA_BIT(VMA_DROPPABLE_BIT)
+#else
+#define VM_DROPPABLE		VM_NONE
+#endif
+
+#ifdef CONFIG_64BIT
+#define VM_SEALED	VMA_BIT(VMA_SEALED_BIT)
+#else
+#define VM_SEALED	VM_NONE
+#endif
+
+/* Bits set in the VMA until the stack is in its final location */
+#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
+
+#define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
+
+/* Common data flag combinations */
+#define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_FLAGS_NON_EXEC	(VM_READ | VM_WRITE | VM_MAYREAD | \
+				 VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_FLAGS_EXEC	(VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#ifndef VM_DATA_DEFAULT_FLAGS		/* arch can override this */
+#define VM_DATA_DEFAULT_FLAGS  VM_DATA_FLAGS_EXEC
+#endif
+
+#ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
+#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
+#endif
+
+#define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
 
 #ifdef CONFIG_STACK_GROWSUP
-#define VM_STACK	VM_GROWSUP
-#define VM_STACK_EARLY	VM_GROWSDOWN
+#define VMA_STACK_BIT	VMA_GROWSUP_BIT
+#define VMA_STACK_EARLY_BIT VMA_GROWSDOWN_BIT
+#define VM_STACK	VMA_BIT(VMA_STACK_BIT)
+#define VM_STACK_EARLY	VMA_BIT(VMA_STACK_EARLY_BIT)
 #else
-#define VM_STACK	VM_GROWSDOWN
+#define VMA_STACK_BIT	VMA_GROWSDOWN_BIT
+#define VM_STACK	VMA_BIT(VMA_STACK_BIT)
 #define VM_STACK_EARLY	0
 #endif
 
+#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+
+/* VMA basic access permission flags */
+#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
+
+/*
+ * Special vmas that are non-mergable, non-mlock()able.
+ */
+#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
+
 #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
 #define TASK_SIZE_LOW		DEFAULT_MAP_WINDOW
 #define TASK_SIZE_MAX		DEFAULT_MAP_WINDOW
@@ -97,26 +369,11 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
-
-#define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
-
-#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
-#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
-#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
-
 #define RLIMIT_STACK		3	/* max stack size */
 #define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
 
 #define CAP_IPC_LOCK         14
 
-#ifdef CONFIG_64BIT
-#define VM_SEALED_BIT	42
-#define VM_SEALED	BIT(VM_SEALED_BIT)
-#else
-#define VM_SEALED	VM_NONE
-#endif
-
 /* Flags which should result in page tables being copied on fork. */
 #define VM_COPY_ON_FORK VM_MAYBE_GUARD
 
-- 
2.51.0


