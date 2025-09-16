Return-Path: <linux-fsdevel+bounces-61811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E02AB59FEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1DE1C0548C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B728CF41;
	Tue, 16 Sep 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzUz3D6v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J1R4AnD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E722D795;
	Tue, 16 Sep 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045544; cv=fail; b=t8jMHKsurYPMRykCSfkZ/nflllxIcM55Fs4GRRSS0kWdz9EjasAEZfwlGO218oxWqk+QcSAN1e+x9RV2oJBnaHCKGiHDd2/n8JDLg8AU3rxtKqOQfb7J8IkANynihEXIRe2838jcVyWdkNwv7XMBFYT413mSTZLsYvMxX/xfq2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045544; c=relaxed/simple;
	bh=z/3NgeofnqZW9V/a5V3yuN7oAlWxOi8cOjLUKzqoHSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SQT4SLsKOHlqN2sWkUNpnqkW+WRNAX91Hk56xhsqAW8rOqNu8wwrJWhftBzj7BXJeb8NClI64OGnerp+zlh7AHbLJLmReIj93Spfw1iRtFdLOwyEmnKLhjK7o/cTXTONjTv7yTdd5h94Qvu8EthV/OJ5/cpn2RSTDBqDC4GIMys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hzUz3D6v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J1R4AnD3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GHu4wA029049;
	Tue, 16 Sep 2025 17:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fk0qZUdsSvfr+rIqKD
	QuJshAbeg2xHZ8OwVMfO7wi/4=; b=hzUz3D6vqaAGyyuaAw3e720pstN166d0nb
	qFDc0c3tNTTFL0RgRP24d8FowwXt8qspxBHZKQzKX7jf+KpfirTg+A9AbiYLY125
	6aORkvbyfjGT1DpxXUn1FG12aiBEVTIO65myDmZNNMRgHLIJX9+GUyowio+txRc/
	XjrtYiKoEfZn1JiLiBjz55Qn6O24VxmXoCdyLtqyNWgwJkTLlCvutZwzliBdcoz/
	X3jNfOMeqY+WI1SQHOZBNKFwnBrPXO2prxqSUgscS8JB2D/rTpUCUBEHiESj/kOv
	1BwlBcWRoR7ARJdw0ICTwyQsvprV2HNj7ujp44dzK1rKl4Q5wpKA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd59ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 17:58:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GH0lvf001596;
	Tue, 16 Sep 2025 17:58:23 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cyrhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 17:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn1vAMtzUYpgFtxl7HYHgHvSGO5yPoQWAe34I1yQz6t0+P5BFotpmA3f4/8PkOP5U3SjLTs7zten7YUrPq4JE5FrvDfTTQANCzWHlPS3PpkwaTIaRe8TC4IBMk9O1t0gBt+rNnw76bcNU/bAjBZiGX5GqctryPdEhyu2lSyTv9KxTb0vtKbkfERX/fal5JnPydQp7VGEjpQVwtcGI4Td/sa81BCHZ4FfJDW/fv1TY1AbFhM1faA9PcDdxywIebA8hzwlolCaLw1LrC4w2rER2Owr45ylRmObj+3QcMsbLfYgAKvpJJhjjwpRbK7tjEimFJ070gYhPF1FWYmcfWmRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk0qZUdsSvfr+rIqKDQuJshAbeg2xHZ8OwVMfO7wi/4=;
 b=jWJK1eP+Bpigjulzg4akDk2Z2TeUkP/rtVWzfGh+n1cmVVDcBNsh3uPJWXsddtRM/O6hcjTlVPNUpYUUk85ofSo1KLtRVlbg/RCpyv7UIXIZO1I1s7cuzR/e9pdiWeWgih7HmqeMVLCAucHTM3zLwgchuCOU1Ak+ZmWMZljgf5uBRJN+2e8r49QPRqL1Lel21NH3+wYKQYSHbJbDgN6PnWpUXHIg0uFew0M79exQZMvRLtzpSH+OFbYK/wUuBrEVoeLG6M7q0OCjNZbke5UYWelAWnPpZE1LKCaDJl2/926ziyaqRETjhHnsqOEoBTNFpmarBhLqs/ih7VzyuG5gKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk0qZUdsSvfr+rIqKDQuJshAbeg2xHZ8OwVMfO7wi/4=;
 b=J1R4AnD3dVL0vNOHI7fGh9ywQZWRY9tEiVsTs52KJs/ODhZvKAweQkyhJJXbaYJR3RrxbSqvYFFw3hqH25YSDh1O+eDMg+zEnDAsoF3eAFlMVrLgV0zInt+rELBbLA3lROTigvGPzkjeavDT7Ewmhq2y3aAaPG6+5/FRaDdCShM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5684.namprd10.prod.outlook.com (2603:10b6:510:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 17:57:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 17:57:58 +0000
Date: Tue, 16 Sep 2025 18:57:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 08/13] mm: add ability to take further action in
 vm_area_desc
Message-ID: <1d78a0f4-5057-4c68-94d0-6e07cedf3ae7@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
 <20250916172836.GQ1086830@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916172836.GQ1086830@nvidia.com>
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cc60de-66d2-4ba9-cb07-08ddf54a9237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oGM8MKKCy5oS+QP8Ol1FcKy3optlKwwWyK3d4AY0vtrJcu7EEH95oxxfpKHk?=
 =?us-ascii?Q?wGPPvxDzoYgx0Bb3P7Zq84oHNRXYFq3iDdgU+vlCpL2tvmHJqUkHNB0khDqV?=
 =?us-ascii?Q?sPxem0nOi/IeWe0/Se6UXYB1FVSpAO2ndVPOwbmnOSMHYF+DUqI6oYbzXtVJ?=
 =?us-ascii?Q?Nn0pBgfoF32Nw8HsUcwV+7Mt0SdvnPHvkYjTEUrMqSqO2J5yhHQQn6G9KNcj?=
 =?us-ascii?Q?OASbj3KDaSCwVb3HAOObr2A8B1ILRg3tnI/CxBzgJFKKEgDkYQAP7rmXLdh0?=
 =?us-ascii?Q?6ImrUxPggP9uIG07EM1MWgG1D/GSJhW6ryY2nMjerK1Wo6DD1JP54/gcZ3I3?=
 =?us-ascii?Q?+AJvfjemEByUij1udTV9c3uGpsCrssjC0pAkyOi6EmaNUbROAD1zuTigOhOt?=
 =?us-ascii?Q?w8UEpefdQohGrMYlH/hkZPR4TPMMZVUZsSadOPlnGHRl2vze7nKbl0VRGP3d?=
 =?us-ascii?Q?hj6A2acCYfIjA0nFG5Lripw1BwuMzFkkls+/rkeu/RBjFkH8ND3lQ9o6gpQC?=
 =?us-ascii?Q?nSkQLnKcl0ZPJiQVA051KjssZB5ykBqOK1SvriNaNth1mn1aEXXlsXa+9aG8?=
 =?us-ascii?Q?sLbHp6+LqU9nsLC066Lg09FBGvCVjnw5AtEwidxo3D0eM/cUcKz1q/DCxw/8?=
 =?us-ascii?Q?f6mKpWsvF0/0/TNIoKeSY7r9fzs60UeIJp8zr08Jmz0xCSwR/wfUDe83X489?=
 =?us-ascii?Q?qYvj74tt1+tE95lIuQTIWcIGyAFe8pYAO00a/ZqNAnaytLVIJ4jlMrugYvWK?=
 =?us-ascii?Q?WCcdC2ApTrwccLVmbieOw7rH3TI42juPiCYtxpldkUqnR+H9COzuFiCR2IjR?=
 =?us-ascii?Q?gHymcNg/meJnXxu9uTh3ZzpWUCCtpMagpiJPMQNMTeqd4g/RiZLX7gjZy1/K?=
 =?us-ascii?Q?O8POHzx86XtCPJijiAm3UaxfqY++Qsbwut/K+YjON+xJoJbIZALziebI4JTG?=
 =?us-ascii?Q?owOaNFvbrG4amKm6KWl9a5GEQ2MjXywp6bdmnO3mkJJ7Mf4fpiqYyDfxNAXq?=
 =?us-ascii?Q?BuDQpHD7jxpnLz8pPeVjIvLbvnaCYw0mEa+6avF5CdJIUdBHCSIls5ybTdCP?=
 =?us-ascii?Q?78IYS+Sea08J1s3s6kF43ckTe/33/TXHObkC3xWaJbXxUe1zbMtDatIPgfhx?=
 =?us-ascii?Q?gQaQN2D20iyKa3+yLX3XuJtRcaAi7GGbEVc+jLCPwqBHJR//6qCyOSt31DDK?=
 =?us-ascii?Q?+/pbTjTB/41Klmj3m7xtD3GJt3MhJR1jeSQpPC7VhWFc5cOXvhgobDAE4oqv?=
 =?us-ascii?Q?0F5UedZqYeUlKzsVVlcn0mq+pzwsLYlpa4EN/tGIrGvIXZTj5GXhL6ORHFoX?=
 =?us-ascii?Q?PL5FAQ09MXvZQjerh1S2pt4IE8vtSQBmHGJAoyQwWqg5R2dyeHnVUpOQjWGk?=
 =?us-ascii?Q?A8in+ikqRdGiY519N2iu4V/V4pUmGN8ISgrsspyoWFqDotMF8rMPsmJlnMpn?=
 =?us-ascii?Q?/9R3nVE1Lk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GT9HkL6uAZvF3Uh4KNES+kPFNvtOHSLF+U3qfy7oudqgX33rVYTtIpwtLT6w?=
 =?us-ascii?Q?JStnOlbX93Cw2nfB5iUkslLvC4EMRj/fKyFbzer9P1FB+rrx8q4WE9IFQgb6?=
 =?us-ascii?Q?kvaaU6H/QDY5222RGjOkjv1CfVmdRTDYEuo7LQaNedz9HDBuSAyC+1AJlzHn?=
 =?us-ascii?Q?gv5mEHyvmYnap/6hDjZTAO3L0xC3DlP7lJJeeY4Ao5AOIzMOmDmXayWd7L61?=
 =?us-ascii?Q?vJ4jq6O0eZ3uCUL768eKK2g6Q2GrMR61gkHN+szps13BO95cm4hNmveUB67x?=
 =?us-ascii?Q?iLRrE0YmIHT3h7eXhM3+gIIKKwvvrr2BC6yLN5LzkoFa+srgwhhYmTPiQghY?=
 =?us-ascii?Q?OI/LOxnL0G5f+X7It7XnUup4hQ079Xps66ZEzacbzcrRlm+G6m1hTLNKaD0F?=
 =?us-ascii?Q?VD/W5sABYMsndAl655c1ualnzBNzWiCLWyCgGlPowTe6E92gjFApxrVodc3S?=
 =?us-ascii?Q?RjlSKnMfYGxYwuBlIyRHnOYiqial5DfXhFbcmquHYLL1eRHhtOCfsyG5NmLB?=
 =?us-ascii?Q?RR40Keq3UlIeSCiM0819+tVwG5WpJGIgM0NhqFR4v8/NSHv1RirLJn31jq1r?=
 =?us-ascii?Q?SYaYO1FSftG7jBgdUOHplTncKlPQR2RynigKL38W8gfWmrePJHQ2myt+eGtf?=
 =?us-ascii?Q?nNrNHm8OxwaFN3gfpWjwbJY4aU5i1mtmUGAu0Hnsv7/KPHN+WC/OV3Q4Pw8t?=
 =?us-ascii?Q?bI77pPu+vVpjRj+xFRDbF3io62BKjWOkC0SvmzWUkWHQjfhf4SqDGCUe3eU3?=
 =?us-ascii?Q?f3S7yQ2KO2lhmpwI3e4kxtjXVnI7ouxQDThTj2GG+B7TaIaT5fc0eNMVk1lr?=
 =?us-ascii?Q?4STWtabwQ50f0tKcQDkqEbl/MFRMITyl5kRdRXdsq/70OiUTdwbVsVHejFn9?=
 =?us-ascii?Q?WaHEED3oIKHyB6LP8ODZrnriDoMBhYILBL2uBjIJaWawV/KeKA1i8R6z7pqf?=
 =?us-ascii?Q?NKHzqcTexq6pGslNsVI1zkEvra57EGnfBuu7lQAUGS67QtJQl/UZ+G//OUJ0?=
 =?us-ascii?Q?skRSKfyOa0ktTCXwxywKwJCuUWSwFhLu1D3VCmOAf1gCUPibIDzEp1eqDPGO?=
 =?us-ascii?Q?wyHdlvM98BuCBTgBfD+Hbagj9kDt4sr7np13n1SBfWfnOfZ28YgvBqTBAR9f?=
 =?us-ascii?Q?3+NctoXWVJQed9xugU3bs9Mr46dysCpvfS1J+dOSVD6isEAl9M9e1F81RzAx?=
 =?us-ascii?Q?RCikP7keTy/MzB2rS8IvUxALgeKNST7i8YwwUVK6w/jkSl4MeFNzjiWXlG+B?=
 =?us-ascii?Q?MHIWCxdL7dGz0YavDEWDtJXf0V94xoZDpDihUH8rVGlTQUhmIM0WffeKjw2w?=
 =?us-ascii?Q?zlSai4yWna/0BnGbuZ+1AhOgRvSnUNgo58XA4HrJY9JDuvzIpSum87ia62Qq?=
 =?us-ascii?Q?G8PRkAy7VlYCL84m2+T6CyhloUl8nsSaJgesYMNADYqTJOZ7YGbcw42erzMz?=
 =?us-ascii?Q?28/F1ytffVw/SRxBn5DcNuya+EjRGEObY/wTtm4ptU0FhNMPHaPWGwih8Ed4?=
 =?us-ascii?Q?qdu/khj6f4Oq/2HaB4Sq2Er8vtwR38W6uHrBcEWSsj15p5HzAgWERXVRZa/7?=
 =?us-ascii?Q?+Mjh7ByqekeJBgDn5toqSnkt1Uk0cSaaWi10GW8p8XLRq2UbjfcSLRJvZD4a?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u5pK5obXCEDvj36bINo9nsOIIoFtTaDOq8D+XHeTV0NOI2nmXNds8s2G4gP/N7+risR1zmqzFpCJm7SqOzks42LUGyOITgcEMiuYWGKk5mNt54mxTi9qlq2YmSXQQnOUy2GslD3tFeOBUeB7LBB2TUMt41tv7Ez7qsgukvdoZP9temXhfec8so+Uh7F1CWpegIIXhktaQ/PXRamiUJUnj98i5ZizSTS4nqCNkbYV0XZTi9uSNHd6Rau700kGovbHg2v4bNnagq42Et5YxTar0fe0TLI0NF8vKAjHxpy1BXMOYlG+9PDJcXo3VScjcY/aTisnCfgXfmXc1UiJkJQzFI/mlTutM4tWDnzWnRHL9xIofU1CONI9hiJzKUSzanvZS86aVbfgB++OVbJ1vL7+Ni2xlInCqCpxSW3BvSVEihe+0HpwtsXKrVEzeJaLb7Zc0Cng2UjY8SLWXENAiQyuTTSoLyycsSTgMLcEoMXGSrhSKvCRlBhKFyfEzQu8tudjiSGnKVvDJX6In14sTDgIKWPqds5gX+Q25NwYxjMXSIgBHdqu6V3+kNHuXJoB+Iq3xOCWtvdQsn8+rs4mIE+x+5J12hQQPvrEv/TUjQHTSmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cc60de-66d2-4ba9-cb07-08ddf54a9237
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:57:58.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7d5o22cbaxec4rbP1w3dhqIvLSfw6X1xgK9BNvr+GhyLH8nTClczXBFYO9FKWYp0+txUFIg90z5GqFjEsvYGhCIquYGpCLlZX3DV4iqal0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfX+uNzgOlR7od2
 c3X8CUm1+iB3vSoAipGoO86NuB+bDfbMI7/Fa7eO46Bk7PhODjsf5pdVoZgF61Z3PqTKOf/puu8
 qO2WfeMGMgbu8D+G3Z/402x2B8oedDmOdwGZAkVjfZjSLoBWtA5tBn8Y7oXHCaGaeIp5dAQ5Tr7
 IJwU+LHgml+gd8QWVnF5FivrR+MLYOYCY/lHTJtyCEllM3bwYOi8Vc+pS/kkX5TTnqUJpGULwzG
 Uofma9uj6v4nvqsMcq4iZ4LdQyfzWt5j43xhglVea97cYUUUGJkxQTsB5D9ELbKTb6by9I5FwVQ
 6QPYhiCKo1RH3CjsgQhiaV9f3oJSrRsSrNuOFwT7Ddi6E3Jo1tC9eVy5bjZBWzbx8+gecqx0IYw
 9gun5s+g
X-Proofpoint-ORIG-GUID: KLhHMPo9qgBCeuEuIaDrWsooShXaRpWW
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c9a540 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=DebM3o3khbZDP6qhVTIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: KLhHMPo9qgBCeuEuIaDrWsooShXaRpWW

On Tue, Sep 16, 2025 at 02:28:36PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 03:11:54PM +0100, Lorenzo Stoakes wrote:
>
> > +/* What action should be taken after an .mmap_prepare call is complete? */
> > +enum mmap_action_type {
> > +	MMAP_NOTHING,		/* Mapping is complete, no further action. */
> > +	MMAP_REMAP_PFN,		/* Remap PFN range. */
>
> Seems like it would be a bit tider to include MMAP_IO_REMAP_PFN here
> instead of having the is_io_remap bool.

Well, I did start with this, but felt simpler to treat it as a remap, and also
semantically, as it's more-or-less a remap with maybe different PFN...

But you know, thinking about it, yeah that's probably nicer, will change.

Often with these things you are back and forth on 'hmm maybe this maybe that' :)

>
> > @@ -1155,15 +1155,18 @@ int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> >  		.vm_file = vma->vm_file,
> >  		.vm_flags = vma->vm_flags,
> >  		.page_prot = vma->vm_page_prot,
> > +
> > +		.action.type = MMAP_NOTHING, /* Default */
> >  	};
> >  	int err;
> >
> >  	err = f_op->mmap_prepare(&desc);
> >  	if (err)
> >  		return err;
> > -	set_vma_from_desc(vma, &desc);
> >
> > -	return 0;
> > +	mmap_action_prepare(&desc.action, &desc);
> > +	set_vma_from_desc(vma, &desc);
> > +	return mmap_action_complete(&desc.action, vma);
> >  }
> >  EXPORT_SYMBOL(__compat_vma_mmap_prepare);
>
> A function called prepare that now calls complete has become a bit oddly named??

That's a very good point... :) I mean it's kinda right in a way because it is a
compatibility layer for mmap_prepare for stacked filesystems etc. that can only
(for now) call .mmap() and are confronted with an underlying thing that has
.mmap_prepare, but also it's confusing now.

Will rename.

>
> > +int mmap_action_complete(struct mmap_action *action,
> > +			 struct vm_area_struct *vma)
> > +{
> > +	int err = 0;
> > +
> > +	switch (action->type) {
> > +	case MMAP_NOTHING:
> > +		break;
> > +	case MMAP_REMAP_PFN:
> > +		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) !=
> > +				VM_REMAP_FLAGS);
>
> This is checked in remap_pfn_range_complete() IIRC? Probably not
> needed here as well then.

Ah ok will drop then.

>
> > +		if (action->remap.is_io_remap)
> > +			err = io_remap_pfn_range_complete(vma, action->remap.start,
> > +				action->remap.start_pfn, action->remap.size,
> > +				action->remap.pgprot);
> > +		else
> > +			err = remap_pfn_range_complete(vma, action->remap.start,
> > +				action->remap.start_pfn, action->remap.size,
> > +				action->remap.pgprot);
> > +		break;
> > +	}
> > +
> > +	/*
> > +	 * If an error occurs, unmap the VMA altogether and return an error. We
> > +	 * only clear the newly allocated VMA, since this function is only
> > +	 * invoked if we do NOT merge, so we only clean up the VMA we created.
> > +	 */
> > +	if (err) {
> > +		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> > +
> > +		do_munmap(current->mm, vma->vm_start, len, NULL);
> > +
> > +		if (action->error_hook) {
> > +			/* We may want to filter the error. */
> > +			err = action->error_hook(err);
> > +
> > +			/* The caller should not clear the error. */
> > +			VM_WARN_ON_ONCE(!err);
> > +		}
> > +		return err;
> > +	}
> > +
> > +	if (action->success_hook)
> > +		err = action->success_hook(vma);
> > +
> > +	return err;
>
> I would write this as
>
> 	if (action->success_hook)
> 		return action->success_hook(vma);
>
> 	return 0;
>
> Just for emphasis this is the success path.

Ack. That is nicer actually.

>
> > +int mmap_action_complete(struct mmap_action *action,
> > +			struct vm_area_struct *vma)
> > +{
> > +	int err = 0;
> > +
> > +	switch (action->type) {
> > +	case MMAP_NOTHING:
> > +		break;
> > +	case MMAP_REMAP_PFN:
> > +		WARN_ON_ONCE(1); /* nommu cannot handle this. */
> > +
> > +		break;
> > +	}
> > +
> > +	/*
> > +	 * If an error occurs, unmap the VMA altogether and return an error. We
> > +	 * only clear the newly allocated VMA, since this function is only
> > +	 * invoked if we do NOT merge, so we only clean up the VMA we created.
> > +	 */
> > +	if (err) {
> > +		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> > +
> > +		do_munmap(current->mm, vma->vm_start, len, NULL);
> > +
> > +		if (action->error_hook) {
> > +			/* We may want to filter the error. */
> > +			err = action->error_hook(err);
> > +
> > +			/* The caller should not clear the error. */
> > +			VM_WARN_ON_ONCE(!err);
> > +		}
> > +		return err;
> > +	}
>
> err is never !0 here, so this should go to a later patch/series.

Right yeah. Doh! Will drop.

>
> Also seems like this cleanup wants to be in a function that is not
> protected by #ifdef nommu since the code is identical on both branches.

Not sure which cleanup you mean, this is new code :)

I don't at all like functions that if #ifdef nommu embedded in them.

And I frankly resent that we support nommu so I'm not inclined to share code
between that and code for arches that people actually use.

Anyway, we can probably simplify this quite a bit.

	WARN_ON_ONCE(action->type != MMAP_NOTHING);
	return 0;

>
> > +	if (action->success_hook)
> > +		err = action->success_hook(vma);
> > +
> > +	return 0;
>
> return err, though prefer to match above, and probably this sequence
> should be pulled into the same shared function as above too.

Yeah I mean, you're not going to make me actually have to ack nommu properly are
you?..

I suppose we could be tasteful and have a separate 'handle hooks' function or
something here or something.

Let me put my bias aside and take a look at that.

>
> Jason

Cheers, Lorenzo

