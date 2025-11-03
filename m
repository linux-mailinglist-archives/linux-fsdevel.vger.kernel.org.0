Return-Path: <linux-fsdevel+bounces-66774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9B9C2BC3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151423BC507
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8107A30649A;
	Mon,  3 Nov 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SiiylVVZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEfqV2y4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA54283CBF;
	Mon,  3 Nov 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173564; cv=fail; b=UsIsZi9QXghtn08dcfLlMMl1oZLfSpc3O/aMjCcn1zIKRLCwvaoQedT7kQGS5hGLqgd/1IccpHct4/HDlqSgQXHGWcHmMaIINYprCsNIFKElfKEh/21RlgKKcPoGnD2CbM6XPSbgWVfVVbNOKRK7RQLggsneCfEfHeJLOMXY+6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173564; c=relaxed/simple;
	bh=YRY/pYAYRZhm3vMIIezbxAmRnvw4oXHtJd2+fjTtIEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PVm/VUJAOK+aEU04Bzxxn46GzhdtGX+KxuWSQ1RPfxK3Thdd5PoKwUJG7ysZEwMh52SLfXnIhk2PAWhyYn8AKEQbdeHy/44TCPqeEUvbGLMDAcBWrUUOGQEtIYW3kGYQPPg/x1ZDBBfU3PF1BDVrw3KXhW4lWKd3ltePP/x+FiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SiiylVVZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KEfqV2y4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CTgS4019251;
	Mon, 3 Nov 2025 12:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eQP2gKV9s5EsyeOy3wWyaAvJjDWb1F7KV1e+Mn3O398=; b=
	SiiylVVZp4+3xML5eyhzxDWDWp658OrE6JQ63VUWydGj3jGt0aDsXZlda4uWYEhc
	u4VWfYBKtrP5ABIYAzYuz+mUzmIwkSjvo63OSx5SLmraTGbk7UOLyOIHuwW2wp0G
	nj5Uo6jStZ1bL+8Jl97B1LHd0PBE+/WGz5TavDUt1ChfR/TKgGPlU8NYZI6iXHgT
	TfeDvCz+GzQSyS5cEW+1bN9yVucyqRkuFulXbTkex9KsEzgWj6O9A2O03GynIbdz
	OuHkDxduYi6fHhNoLG1jP4xNZZSKAnVpDRfxLB/hUTYwipooWyY4mmRCSv6Fu8Xm
	1fw8EgGDuX4ha9t8JPhVAw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6ven80bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:33:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Bx7kT021025;
	Mon, 3 Nov 2025 12:33:24 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n83ev0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBPJaFqQs9K5y3AUThrc08Qvm9a+hZ3YEwlz5K7G/3A2qxa8cAyQhYS1Dy/IU3nsKVJvEb96Esnc7ruC0DC4nEl68wrPf1RmvCleYSa614QpZCLnmlknkwHeBsWk/EsRAb5IpX9RY4iQ0IVnOclgVsIIlj1g+JNUBtOqWaWROo+yOM/kEGlwmA4ssc/BSV2wD34VGhwmmgXTDcbJI7Ogk95OwP2QmbL9RHZInzqlYZBCr2stHttFmNTv095+NVUuRFRQrRU9FqAw16EXkVjx/GU0nwfWl8qbSTBi3o5g4A7jRgwc+yCNCde9ODo3jTWd1dKzhAA7vWOCdFvbF6S56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQP2gKV9s5EsyeOy3wWyaAvJjDWb1F7KV1e+Mn3O398=;
 b=PFsRSTCR7Z5NLMmCIDs3xNE90kgZBHODt1e4JCz+lZy07QG5mFZFAMr1TkNiMU+RNvr4YWZwPgNkKXKwjgDWyhCQs3U+uTR4iGullRh10BpWH8NE+263bGhBaqg88sLUWbH0PcpwmtKUDFt5A+6awuDj5b8VZ9kNZXj+CDpMA+ttmy5ieRMOeGsxTHZbQZ2Z5Q6CgTdYAzBiUPPeVdYZ0HOo3fbrm50R7M+5xndaOwvWJjpbnIZYW15JEjxtyWcyZc07C9XlOj4M/+H3r4IezjT0qWgDcxHQoRgxEr3fNaNHbRDnVpjTigppLPekYv5hjvQBmiCbQMfVb86ei1NymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQP2gKV9s5EsyeOy3wWyaAvJjDWb1F7KV1e+Mn3O398=;
 b=KEfqV2y4RdrVBcvJ+E87/TF0m8e5njx8Ce1iRbvTYTRljJ47+ojMOKUGUhL33/n4iROj4QF9OZjIOoOWr42WObuLsaKqzk/wJLwBImZrrnEBAeK/8PcTRClhDirWP37lYIPgnO6StG2C+jhijQLCD0oHvjH8IBDNbbFinaSEsQ4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: [PATCH 16/16] mm: replace remaining pte_to_swp_entry() with leafent_from_pte()
Date: Mon,  3 Nov 2025 12:31:57 +0000
Message-ID: <1518bb0d0e40ace2012e64590288046aef03781e.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0344.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 398e10a1-4af1-458f-5b1a-08de1ad51d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jNWPGwyhe9gMlURguxQ6hVvjyD0vJxU48MGOaZAk+IcsaISzzS+5nuxWm8ni?=
 =?us-ascii?Q?WjEKgk24DNelBZj4zLf3lxyp6jHZAzgrkz2pyeiQj6JhQAHRWFb5CFqASknG?=
 =?us-ascii?Q?OABu6Fw/y8YY3yzp84eZYg2MO/ScEfn2qBIC6lC/y8IQ/pi7EpEhpH4OUkAA?=
 =?us-ascii?Q?pTIZelyLdhJzoc7DWoHZCxzrjqJGrKvV4Y5UWR5qBl41+bhG/SV8E6Cneg4d?=
 =?us-ascii?Q?EynI3Hn37mdZVLquVXwzRpoh0+1ZyfYZNNbSW8RBZb2M9C5R/N7jpUAXXCiH?=
 =?us-ascii?Q?3od2W+BBVh7hi9aWbxvnAfQa8LW8bZ9hB17B4co+Rk+f0q6D2tJVS4dcj37u?=
 =?us-ascii?Q?N5GH7bKwuH0CsW+A7P1xxJZiLaeEY+pj+m/yArLOq44KCxUcO5JapMJtdAws?=
 =?us-ascii?Q?nFORKUZMNNRY83HxhuKvz/PaflfrEE7rt9HkzpAZTMLqTM4MA1GAzLjCuTGv?=
 =?us-ascii?Q?K4A1MMhugn8xIozT5sFbxn1RkZqGXtHvbNZLOrVnqUnTaf9G8UelMjK0IgTm?=
 =?us-ascii?Q?x1W+gii26pw65nusaQI/xfJWU8lxPINb7TyznTAfR9lWmreKVP0IQDr8jvY4?=
 =?us-ascii?Q?rk4CsiCM1nGyk4Jrd8ALsUJEpFtu0W2cwxLsecGCQgUZw0kVTQeK2Uk2qnJN?=
 =?us-ascii?Q?knHJ7Rw8zIjLAkzxG2ADZ5U5EKlzCQUj/XHDNV3UfCPVhpQW6EkP5jAVrNlv?=
 =?us-ascii?Q?VZXLMn73ZqeRMwz7210Ls4yN4kvROyod9rw9IMQac8g4EdXXvEe+AsA27/3X?=
 =?us-ascii?Q?sefSSU+XKZEefdpNIReYLqu7rgNX9/XipdQRQ6iYqfjN02WCIla1hKCNK1dD?=
 =?us-ascii?Q?jPLj7GmP5zBemAkowMTlmaXBQpknzcQoE0B3fsrsyLfNe6Ncod1QPJRNU1Kh?=
 =?us-ascii?Q?qbk6DQFalXCA5K+D7fnIdERcOF+SquOtn1CIVobCHu3nWiQww3az3GHKoTBP?=
 =?us-ascii?Q?oBO3hdl0ZnDutT+FJsz3V35QA0bn8cpkUJg4mwVEn4VMasK6fsjD3+O9MHeO?=
 =?us-ascii?Q?Uk8G40nOoGuYGnNrXgfsDt24brs52YJBviCEFbZAOHijCo0sd+4h78nMxA1Z?=
 =?us-ascii?Q?y4M0UHT4999nXE48xcbkqcsh3CP0c7x/53I7777i2C3WRjYcBoggllvMZwye?=
 =?us-ascii?Q?0UmjgpQOQBQa69tSgVOmYehmRJ7OkpPjxbCM7Dl2GTOMmBUqohJujCOIjnk6?=
 =?us-ascii?Q?zGOucBD0m6d888zSJjgxrYD5WPv9Yq6f1a7m/PWtWtvuHvq4m0ML77+vZEsE?=
 =?us-ascii?Q?49BoXIJttxoz6fMy/gN5sLiNkkFA+U+CtMpb0RBYK+XjO7kSZcMBeXmydghi?=
 =?us-ascii?Q?z/qXdMRmrwZqxFSY816K8yf7c8cTtUk1Nm+/e5AUb/EGp2C9172nnXCI84Gx?=
 =?us-ascii?Q?auIluFN7fpdZCGR1+/a5VhyztIboGRIeS350uOi2i4LAvMQxp2ll9fBdpWOg?=
 =?us-ascii?Q?lW8uVOKpZyhMBOwN/CRdYkfgOm1jH6m/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eaA7JsCZu2G0sWIkTeOeQTAJ3QdpK97M1Vvn2rMe1o12w7OkCbA0fgWuAxWF?=
 =?us-ascii?Q?Uz9eKVgsTENvK0Fg52hJ1/e0x2AwjXEkv2N3TWw3qM+Q5ZUKN8eM28tfrzS0?=
 =?us-ascii?Q?2UfisSTILdMah4U5X8lNvwp3rCQbA3R6vTvqrtuONfFgXSm0tHF23wkRhUJV?=
 =?us-ascii?Q?m1MAHhVn5S2n+1fDcnGC57Or2Sx7s4Zuf6elfPf5PHV7jnm6+l0Z16q8lEOJ?=
 =?us-ascii?Q?MoBbcan3UosbNRn/Z11/wfyjrHn2nTeJxfbwtGHp3Yq19EEpzf7udsfvPIUQ?=
 =?us-ascii?Q?diVg7x1nYm9A0kW0CumNltuMeffsch1NLUxwO0TybNM/tLcBTwOq6/KAeQtW?=
 =?us-ascii?Q?QCHdH5Z8pHLsvi+tZ27RQmrkGUSwFin6ilfWhZ4PqtUXWlk3o0ANotmKMXUL?=
 =?us-ascii?Q?7VvHfL3S7bX/VD2noJSS/as4v//TomiEt1UijFmKm5WTuJ2nqZj62kIFdcvr?=
 =?us-ascii?Q?ZryIOqTg35pR56Z/hUoAJSyloT2UW3vmA+qJkDYRBHTr6Q/S9U711MBvY+lx?=
 =?us-ascii?Q?KXuwai5FzCDILSBcTGV4cZJHQ5aZ2tk/hm4UZhM/4oJNRgMrHgziRgLVXUD/?=
 =?us-ascii?Q?QxoA/tZdWVKHPq6cYclzciKi1rnrguHtArSiJXpEACmhhE7iIOYfldo6JZ/6?=
 =?us-ascii?Q?+zLiX6GGPr3PGiFK4DS2gHnCSUK3gDz3fOjdgGAQH+qR5ria0auXYbP4xljc?=
 =?us-ascii?Q?Tc7LxkTgir6Klhp8TcUZDnRlsIP2Bi3RN/ho+0hOxjY64vQzKjRrUJO0cPOu?=
 =?us-ascii?Q?hFyB6R/+3sS4Koph7NNIbU18UIhsXuxMbbaLn4bs4kmfcmkIBwFLz0g4zu0x?=
 =?us-ascii?Q?j8WuJ9iZn/cOMLISnpKy7Y+25QNHOsBpgxQIiNyQAgJab7nYVjrSiTv4UD7Q?=
 =?us-ascii?Q?wn4AtHjN4DLjXkO9No19xsupN6FyMoqCyDKuM4FZs5deeuX0D9vGSqkLWPqT?=
 =?us-ascii?Q?rqx+f7dzcAXx0sJjqC83CEgPWUj8CD2nuxiTGj+W/QhCuRrwZobhUlrWKlav?=
 =?us-ascii?Q?u52eUiOi6Wc/ZQSXXozK59oCIqU5PYdXJlSiEgRMLZU9YmItYkgOGwpPnsad?=
 =?us-ascii?Q?gq+LIgHDopjgkEtlD7CA5QdMH7891DPpzyhJd3Nk9qrmkhWCnyuVs2ICX1rh?=
 =?us-ascii?Q?t0NKbcxbA3sbTAOG3NdDFrgkf0/jrrzTKD87nTkZbUb/FcmaNzVD5Q2eSWBe?=
 =?us-ascii?Q?Lx6FE7+SIriiTSDFFNDSh2D8qg+B4RkzuKTQpcEmLAku+ykxNCD7Bjpty2ny?=
 =?us-ascii?Q?nJL7BNVt6LAxSo9je7fWeAwBcoEzXi2V9bHgzwB3XYBKiBuPud9Py52E8r+9?=
 =?us-ascii?Q?Ajhq3eMmYcoaMnHKfN1s5tgaQ4ZLKTcTmCdsJManul6pZSLSsPv6cAabXcgQ?=
 =?us-ascii?Q?IYCeNA5CgQapXMZU5B2hqwjbtY0OSkEfu74VILzUuDXnIANP4gQVbESkoUQ1?=
 =?us-ascii?Q?lXvigEhaIW3M9sXx4sNAeUDs1ZdtN07hHLTPo2ggQ0f9VfuciVg50Teq6/7d?=
 =?us-ascii?Q?MkNxV+pLbHlJi7/SnxwNHGra1sUUrxYtI03LkQBkIa032rvGT2T1DHsYmjay?=
 =?us-ascii?Q?mq9+VRjz5tECDO5WGEIhHRIzp66SVIb/EBD3SYvcjZhpQcjyYXtpwzzRtacC?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yWY76NyAX1hL5cMZoQoXtiva84MoAanLtzs305g3ASM7f9086uUqsbFO5aglUzjoHVTRMAOHjLZPDD8eGZF+6Lt2E/EMx5Q9TulRY5MLi45PkxRwrqnoX8psJysW8aYb4oe2rRF2OZlS3PITzmz6u3wrH0ewLju6FrHVe49XIeJQPoospKn65Ll44itfQbwq6B7tYQ7j/SzTA8o+RX7Df0bfLW3N0o1UV/jpI1p8zTYzxLh3wVAOvg1V1YILLGV9E7Z0I1Xwj8ZVLMrdooZFx8SgqqWh/Ros7iGjds2/EX5OI7yYR3qY7W2ielXNuTKpxEKr7TY3kqtHl+EC6Y4qi2msjOxGs2kfVjqP/0NgL0l0Uru0WCmNQezohApv4cMZooKWhdD8HnxlStSINIYvVxhSA8r989wqej4KHPIAQXo3HdsA8bMJZEiX5NCL/B34CC/cq/rfoYn9kLgsQ8Ocze5Y/0+JCLJ6U8lPEiSvn1uq114epJ4ioy3CnLzBYAX4zWiAzqaHY9TU0mQwBTkwHAuBMbBxxLZo+gA5SGs67r77nFfbyaAYBxY1PStHC2hyBvl9gAJwWWaWUkSlNYxEjGzbGmrzDko3I+flgi1zS2E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398e10a1-4af1-458f-5b1a-08de1ad51d31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:55.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wx9pgxsv4iKfUP+Gi1K9AqU7+bNuSulHVYRan66pDo8ZldHMolw9vUQ3VCW+1TMWPdZz4TQo/ZYFrvQDHSrx4rMFpwoLpCqvZC7iuhjcIDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030114
X-Proofpoint-GUID: 21ec7nF9pXtmHH-jFlT8pC53_-e4P0AY
X-Proofpoint-ORIG-GUID: 21ec7nF9pXtmHH-jFlT8pC53_-e4P0AY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExNCBTYWx0ZWRfX08y3nCdPXBlg
 MT8honoUQYqB8yyTqMmaW1GavDyb9453eDdIy1PGuDYQnz9xTnCWP596S0a888gE5QJ0+vkFTqc
 +lgJalQzpYFImRb9S5uF4lMFPEtB1eQo8qhsLZaadd39Sz/uaruj2LhS8ngEQgYCEoBNgkdYxEG
 gmQ8tHK8OPcr5TKebfZVZlgt5L8Y5hJvdUT83fl6P/adWQgsZXObXAOdjI95eC8Mxbte5lyBMkf
 nvHr3U3SBxfbl0PvyxRpuiuy8p/paup+RCCqMYMzxv6jDH21REfIrt10Hlol3ZmslsndE63wajX
 iOB/8pbn/us2+s3MJWdtmqlp2xli5JxSZ7crCLaZE8K/bnSWmfhopv79omiUM5CdWyDsP1EVhZJ
 87ZcR6lx0xUjuOq9tUcH6UzZusY+Cg==
X-Authority-Analysis: v=2.4 cv=MvBfKmae c=1 sm=1 tr=0 ts=6908a115 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=o1UEzff51pvCjpypyTAA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

There are straggler invocations of pte_to_swp_entry() lying around, replace
all of these with the leaf entry equivalent - leafent_from_pte().

With those removed, eliminate pte_to_swp_entry() altogether.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/leafops.h |  7 ++++++-
 include/linux/swapops.h | 13 -------------
 mm/debug_vm_pgtable.c   |  2 +-
 mm/internal.h           |  7 +++++--
 mm/memory-failure.c     |  2 +-
 mm/memory.c             | 16 ++++++++--------
 mm/migrate.c            |  2 +-
 mm/mincore.c            |  4 +++-
 mm/rmap.c               |  8 ++++++--
 mm/swapfile.c           |  5 +++--
 10 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index b74d406ba648..ba970d4e2e17 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -66,11 +66,16 @@ static inline leaf_entry_t leafent_mk_none(void)
  */
 static inline leaf_entry_t leafent_from_pte(pte_t pte)
 {
+	leaf_entry_t arch_entry;
+
 	if (pte_present(pte))
 		return leafent_mk_none();
 
+	pte = pte_swp_clear_flags(pte);
+	arch_entry = __pte_to_swp_entry(pte);
+
 	/* Temporary until swp_entry_t eliminated. */
-	return pte_to_swp_entry(pte);
+	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
 
 /**
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3d02b288c15e..8cfc966eae48 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -107,19 +107,6 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-/*
- * Convert the arch-dependent pte representation of a swp_entry_t into an
- * arch-independent swp_entry_t.
- */
-static inline swp_entry_t pte_to_swp_entry(pte_t pte)
-{
-	swp_entry_t arch_entry;
-
-	pte = pte_swp_clear_flags(pte);
-	arch_entry = __pte_to_swp_entry(pte);
-	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
-}
-
 /*
  * Convert the arch-independent representation of a swp_entry_t into the
  * arch-dependent pte representation.
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 181fa2b25625..4526be294ecf 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1229,7 +1229,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 	init_fixed_pfns(args);
 
 	/* See generic_max_swapfile_size(): probe the maximum offset */
-	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
+	max_swap_offset = swp_offset(leafent_from_pte(leafent_to_pte(swp_entry(0, ~0UL))));
 	/* Create a swp entry with all possible bits set while still being swap. */
 	args->swp_entry = swp_entry(MAX_SWAPFILES - 1, max_swap_offset);
 	/* Create a non-present migration entry. */
diff --git a/mm/internal.h b/mm/internal.h
index e450a34c37dd..0af87f6c2889 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -334,7 +334,7 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
  */
 static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
-	swp_entry_t entry = pte_to_swp_entry(pte);
+	const leaf_entry_t entry = leafent_from_pte(pte);
 	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
 						   (swp_offset(entry) + delta)));
 
@@ -389,11 +389,14 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 
 	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
+		leaf_entry_t entry;
+
 		pte = ptep_get(ptep);
 
 		if (!pte_same(pte, expected_pte))
 			break;
-		if (lookup_swap_cgroup_id(pte_to_swp_entry(pte)) != cgroup_id)
+		entry = leafent_from_pte(pte);
+		if (lookup_swap_cgroup_id(entry) != cgroup_id)
 			break;
 		expected_pte = pte_next_swp_offset(expected_pte);
 		ptep++;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 42cd4079c660..0e64d070d27d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -50,7 +50,7 @@
 #include <linux/backing-dev.h>
 #include <linux/migrate.h>
 #include <linux/slab.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/hugetlb.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm_inline.h>
diff --git a/mm/memory.c b/mm/memory.c
index f7b837c3c4dd..1c66ee83a7ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1218,7 +1218,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress, max_nr, ret = 0;
 	int rss[NR_MM_COUNTERS];
-	swp_entry_t entry = (swp_entry_t){0};
+	leaf_entry_t entry = leafent_mk_none();
 	struct folio *prealloc = NULL;
 	int nr;
 
@@ -1282,7 +1282,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 						  dst_vma, src_vma,
 						  addr, rss);
 			if (ret == -EIO) {
-				entry = pte_to_swp_entry(ptep_get(src_pte));
+				entry = leafent_from_pte(ptep_get(src_pte));
 				break;
 			} else if (ret == -EBUSY) {
 				break;
@@ -4456,13 +4456,13 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
-	swp_entry_t entry;
+	leaf_entry_t entry;
 
 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address);
 	if (!folio)
 		return NULL;
 
-	entry = pte_to_swp_entry(vmf->orig_pte);
+	entry = leafent_from_pte(vmf->orig_pte);
 	if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 					   GFP_KERNEL, entry)) {
 		folio_put(folio);
@@ -4480,7 +4480,7 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 {
 	unsigned long addr;
-	swp_entry_t entry;
+	leaf_entry_t entry;
 	int idx;
 	pte_t pte;
 
@@ -4490,7 +4490,7 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 
 	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
 		return false;
-	entry = pte_to_swp_entry(pte);
+	entry = leafent_from_pte(pte);
 	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
 		return false;
 
@@ -4536,7 +4536,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
-	swp_entry_t entry;
+	leaf_entry_t entry;
 	spinlock_t *ptl;
 	pte_t *pte;
 	gfp_t gfp;
@@ -4557,7 +4557,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	if (!zswap_never_enabled())
 		goto fallback;
 
-	entry = pte_to_swp_entry(vmf->orig_pte);
+	entry = leafent_from_pte(vmf->orig_pte);
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
diff --git a/mm/migrate.c b/mm/migrate.c
index 22e52e90cb21..567dfae4d9f8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -534,7 +534,7 @@ void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, p
 		 * lock release in migration_entry_wait_on_locked().
 		 */
 		hugetlb_vma_unlock_read(vma);
-		migration_entry_wait_on_locked(pte_to_swp_entry(pte), ptl);
+		migration_entry_wait_on_locked(entry, ptl);
 		return;
 	}
 
diff --git a/mm/mincore.c b/mm/mincore.c
index a1f48df5564e..a6194bbc0c25 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -202,7 +202,9 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			for (i = 0; i < step; i++)
 				vec[i] = 1;
 		} else { /* pte is a swap entry */
-			*vec = mincore_swap(pte_to_swp_entry(pte), false);
+			const leaf_entry_t entry = leafent_from_pte(pte);
+
+			*vec = mincore_swap(entry, false);
 		}
 		vec += step;
 	}
diff --git a/mm/rmap.c b/mm/rmap.c
index 061d988b6ddf..60c3cd70b6ea 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1969,7 +1969,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = leafent_to_pfn(pte_to_swp_entry(pteval));
+			const leaf_entry_t entry = leafent_from_pte(pteval);
+
+			pfn = leafent_to_pfn(entry);
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
@@ -2368,7 +2370,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = leafent_to_pfn(pte_to_swp_entry(pteval));
+			const leaf_entry_t entry = leafent_from_pte(pteval);
+
+			pfn = leafent_to_pfn(entry);
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 82a8b5d7e8d0..86721fea1aa3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3201,8 +3201,9 @@ static int claim_swapfile(struct swap_info_struct *si, struct inode *inode)
  */
 unsigned long generic_max_swapfile_size(void)
 {
-	return swp_offset(pte_to_swp_entry(
-			swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
+	const leaf_entry_t entry = swp_entry(0, ~0UL);
+
+	return swp_offset(leafent_from_pte(leafent_to_pte(entry))) + 1;
 }
 
 /* Can be overridden by an architecture for additional checks. */
-- 
2.51.0


