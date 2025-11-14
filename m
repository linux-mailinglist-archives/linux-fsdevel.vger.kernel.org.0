Return-Path: <linux-fsdevel+bounces-68508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6443DC5D9AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15A9035B3BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79795322C9A;
	Fri, 14 Nov 2025 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QgEK93kI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SDQw3+xX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7A322DCB;
	Fri, 14 Nov 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130231; cv=fail; b=g1K4QzLx7FeJgICmzXT6l094lU/Lqanhi4mpbb0D/fIf+swDYN9B1UnUKXVBHpxQEqS/oVJMHGT1G+6rF62JEL7oZ+uJmIypLFTrNLK3iafPLRHudZbikRG0vfVFTFur01eV9vaG5KbsZ6n2orL5d5dk2YkYTbPnUvc1fZUPkus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130231; c=relaxed/simple;
	bh=iYNNtjONHS/oE2F74iFaU7OjwDAEFwHM4ne+4vdpGQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g4qBpYWeHYTitIfjuDdfEY5t6baSMfidg/H/aAqNYBFu1bygRcpNe47pc6chMSJ/CXAkWQC1iX8AhgPpxFhIT0bu0ikQLe+pcPCx87CY2fBquV/hKKhngW8FQ2ILHfvfTxAj48QvHwcPFn+iALt7ggaZ0r9VcVV9bFUSdJC1pIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QgEK93kI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SDQw3+xX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuC3E032745;
	Fri, 14 Nov 2025 14:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iYNNtjONHS/oE2F74i
	FaU7OjwDAEFwHM4ne+4vdpGQs=; b=QgEK93kIJD8Etr1IrO4M2wV97oj2z+nG7j
	uxPIFUwbq20hGhmycuFjCEA/IY7WpGb2jKBykqwDsO4IEymlioGR5SfsbcJ1jAcL
	xUW1pJzPlQ+qJaa1a4aurKgxj59V+VWCN5CHL0M+F8hJrCnFNGTemLAB81/mrrYg
	NqE07GxY4QHqdqCkXjihroe9v+XChvqLztV73vnvCF2zrM7evRxDyg+VzEblVe/b
	MjFE1IMEITs8CxxNgwPxmVp3xcLrkgt4d+/e3uxrpQ9NaZ4WROdyTy8Gw9kWq7qs
	p5OWpdF0G33l+vFnemrg7uF8a0VRZ4lDlmSvnMJLind0sy/TQzIQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8s97mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 14:22:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEEKf5a003034;
	Fri, 14 Nov 2025 14:22:32 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vae4es8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 14:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1wr06taFnEu0VR+gPe+Xxek9mom72KzXmp1tGbK/XD3jTqwHi5RjowxgEEeoQf0pWnqhWS4tiKuj23ObIC35HG863+fkhYvsHBQ1VhcPBGwmlr5Dk/SVfhfkHX+uso5KFcq4t7tEmBSwL+XPVF2Lgjl5fan/VXwRtqJOo0rx6t9e3vK2xo3OBKw1ITde0PxkYFRV/G6hxa6uNHAT7oSMEjkke1+H3uDhjROdb9KTwXFKa/Vzx37nfW/Jh1VaHohTY/llybmeRy5vHxFb1cD9QweKSuX3CCBbTDu4qAJHOjyAN2ihTI0WGCortyHeIrWlcQZc1CTFfRcOTvgyAwzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYNNtjONHS/oE2F74iFaU7OjwDAEFwHM4ne+4vdpGQs=;
 b=hV+W84NGQSXZFuQlkKr8spV7Iteri/jNzcj8xFFmm3CTfgIzO+TFVcXnAGC3VBLap5KF68R4qFJIKqLXE0VZ7W4LFKv6jthsxx3wiFgIUKrOchdQ/7t1ywnEXZa9JeOaK5Kbu6q24IUaQ+W/ggSdtQ3UTzP4uZqNi7pUdClAjyCMaASaNZsCyCZA2ltaPFsmxHiaQhcPwvLV8yx7FRZCua0BV/HycM+9cSR2gzkfJ3A+fRjRxWufCUV/vPsH17TNrc0l/AfFhO8oELbMNuk6rkdS9hytYoGm+CpVs1+x/9rs3v72qdplxR3vJ0ne2ONWpMmebFXOLwYq1NyL0sHVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYNNtjONHS/oE2F74iFaU7OjwDAEFwHM4ne+4vdpGQs=;
 b=SDQw3+xXG6nBwtJYxDo8attNDcNkxqKUpPWVKdIwMBKY9IBi7nllX8nB0NK1bgFSdpnfEevlqlinHx9RxrXs+zYAZw66ViyJNW0a393RirQYS1amHMiWLO6int6qkg8/zc48RqoPtgi0N1CH4jEZDpUhR7dxZL2Gehxc5KZWaqg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB8117.namprd10.prod.outlook.com (2603:10b6:208:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 14:22:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 14:22:26 +0000
Date: Fri, 14 Nov 2025 14:22:23 +0000
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: declare VMA flags by bit
Message-ID: <536f483b-ea10-4190-ab22-c2ad2cf8cc78@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: e47a6e0c-ef60-47a3-7faa-08de23893c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?il4I49CwY/p7LpLPOiybK1CW61TP8NC1gvn/QseTLHxfKfrOy4/txsijEsXI?=
 =?us-ascii?Q?6slOUSqiYCLKlKTr+UDt3CCyelp5UzJmIYiKfyIDzsvR+ra/xAITgu5+KvKZ?=
 =?us-ascii?Q?JZ6oQhPL9AlOOsmxIyGn25Dbnhm+QcXxRcsIO71EIFdnujocmCGeXyj+xUSM?=
 =?us-ascii?Q?M9YlTYQRcFNTc4AsPmerec/YZQTQIldNwjrGXX20tsx/2ye0qGT1+T/Y07JL?=
 =?us-ascii?Q?9BbWp/aHNenG87UIf2IMBDrPgFKYOfP3BF35tmRB4BAYPbTHa18lOuqJQJyK?=
 =?us-ascii?Q?JKdqjXq5ET+1EiAZn6phthyJztgVjtvqnIGf+H8yRU8PKQS0WAuDniCA/+ty?=
 =?us-ascii?Q?YEic7waNufoPVNw9xm4dzSK1KyMFPQ3gbyKCXYcHQs9rU9vzUn56Yl/Fk4Fu?=
 =?us-ascii?Q?Hz+GH75ooHzSMCxr9wir9k6PQql+z8cAuKN4wDjllF61iEV0q2pXOR4g96Ld?=
 =?us-ascii?Q?fh3BI/223ueH92C6p2VvnHXYqn4sotwRSwhFY76Ft/LHxRxfxgyV0Nou38fA?=
 =?us-ascii?Q?BmGc0K6XEbjfVemP3og/N8nNbECuUiTWLYWWXA5ylUxIpeqwxkiKQrIJI854?=
 =?us-ascii?Q?AmFq5lc3hYtr+SfxE7zmi+9FEyNJ5MPNglthPWiBLTI5D99duSnSi0d02MO9?=
 =?us-ascii?Q?XDxdg+DyJWgNLfbRckHOigvzH0oVofdJ/v/a4RkpJiaP5l/34fUeZb3iHtzY?=
 =?us-ascii?Q?ne0hWe0fRFoPAKHxN1lFVY1/Y77j7hz7zKv/lZOTA9WTjRHc/PMB42RI7l1m?=
 =?us-ascii?Q?ayplhEv0HIGlFIu7/LbOZQ6W8NMURlopVC584YRxhYHswmsMpNiVV3pycs+e?=
 =?us-ascii?Q?xo3cmey+anDWehcX/6JBl8/JfNQAs+YahAOGgB0HYuMSXFu0f4Sc14d4iyzX?=
 =?us-ascii?Q?TstqE8HDxYX0BGIQF7gNb3mtaaiCo5YUL70ZgqYATAHelrlT49S6UQjulS9Z?=
 =?us-ascii?Q?VECZsNol+WQKPcUK7NmtYEddKy0ZaukX2BkRe+qiJ9VuGmsUCgw2KtElDJZz?=
 =?us-ascii?Q?h349C/M+CHB95RwDjefG3dITI5gcb1V68Fawc4+CdiJmzB3ZSDG+mC/WpZAw?=
 =?us-ascii?Q?VbZYrImrQkGZeHM7/W9GmvkqPSApZcaw+PuXMkuT0RddQKREGWeDL1QOH0bb?=
 =?us-ascii?Q?RSCS91Rz28pA7EoGsZ5e/LxfwvmPk86tJPeRFo5su0IIZW/srYspz2gA37i9?=
 =?us-ascii?Q?dxZI7SI7pTLS60gCpPOBdl348H+iLYUeq89gDRH0iGhExgYmDjif1XqztDih?=
 =?us-ascii?Q?6va+O7pJU99ma1QNixcAaL1jOBL8Krvq+dF6vKuua+WA4yJVYxdF0pv1brEy?=
 =?us-ascii?Q?iuw8aTsoVKPsB81rvtcwwa78bcPuu3Fzo3+xnxM7NFjgpWnZ2guU20eaKem/?=
 =?us-ascii?Q?PHZm9IHk85SBDhmGwZ7VWijJoP0YG4paz7YN/6BmMziEdaH0ZxqiZnSGgBhj?=
 =?us-ascii?Q?xWzfD0M3WAjdbgRP8oRiDVvIJ87BgWj8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZMpxnV8oVGatU/zRbB7RzCKWjimcSks9yP+kHlMNa/8FSHdAHkvwe7RjHv2y?=
 =?us-ascii?Q?TgyhKZiDhjOTwgZWtaH4D7VgephSRl9RiD48unEj9G1rxAk7kqYny8Qd3gt4?=
 =?us-ascii?Q?/J37lB1+q2/ixsHt1aqdVnw0PxK/o+O66nO5Lq6V1Thsx6G7cj1rhcZ4xBqL?=
 =?us-ascii?Q?Ao8W9V5tru/rdlIY7e1kd3/LnYqs5hzDyXkmozP8RBu5D0XmL+hTHfCkcQTO?=
 =?us-ascii?Q?gdYnktcq852ySS4kfJlOZCSddRX52n7P2K8KzOj2jJWNkh6U92MzQTLMMKdV?=
 =?us-ascii?Q?9//2V3B3lF/jRPbzhP7zg9nH7ujvyPj2Gdh15uFbzOmcFe03r7qjwIztrBQF?=
 =?us-ascii?Q?xe8tO8379y+hVmxnIy0F2q374CDmd7hJq7fRyl6lD+xP5iIfdj0Jn8IFV72Q?=
 =?us-ascii?Q?WxHn0QaZJ+q/UdArt6ll6HNJEojX78w/GSG9kc3L9Nv+hwnVL8J4rBTO/uHe?=
 =?us-ascii?Q?HCwmiUjMs5cKdioH3GZcpp/0dvDIu7FmhN4V6JN3qnx04jjpPv4Ydpd86mBj?=
 =?us-ascii?Q?jn1fY5yFSFm9na2YGK41h3HclF+NkUoC2p3XBz8KuCPa6VGWmlCW/LtSl/Y7?=
 =?us-ascii?Q?1V0UejjOeMQgTve6Rx6rpBVYB1K3tTyY2/swhw/JgTvlq3zOA70214l5NoN1?=
 =?us-ascii?Q?0SX8lzRDk3Tqtzwnb6Pc4dHRnLty2JsdD5YV8eyQJJeDK5622hemHGfPEBzz?=
 =?us-ascii?Q?uNdkh4ALnABEvHIOJJvo/h56SwxS65OwM0shXRu6n1eH2XreyC+LivfcymDh?=
 =?us-ascii?Q?OHFcVklASYwyp3jrPqgAY+JcIVkSkaiVmqKAPNNhPOudxGWocsUQtPCRXoUh?=
 =?us-ascii?Q?pSrxIhYoVqwuUn/zA/4M/WT8jsa4adlQJQP0bs2YLs4Wh9nht8O79wWXVoEF?=
 =?us-ascii?Q?jtsUB5PMxbPrRw3gsNYcq9bI1sZO57aRqIvrPARVnDdDiVUoVp7EaeO1v4y4?=
 =?us-ascii?Q?V1AauCKv3vyVphA3xcjau4EoAA5kFv7SPep+sMMNTn96yD4yMRy0Dd+9qqhI?=
 =?us-ascii?Q?vHqXPYa8Tgwi3fT9GanbYPYyaItY+dfnHSO/XtOLuZ34edG1pRMxFmjUq5qb?=
 =?us-ascii?Q?2QVVsdcYjrRkBzLI2PW4vZe3kzJiwvHI39UzLqHl8x+d8fzeulrN+SZFk+yb?=
 =?us-ascii?Q?R3CgnPHEHgfGgrRp16Kc6WYaItGx9fVma6QYE9SEk5hoLW+UuQGMVUt0/fli?=
 =?us-ascii?Q?ikTQp2XhYPEbLgmJWOCvFT4REPO/rmyED+MIGk05HBuO6QLr6rM/vwekJGsn?=
 =?us-ascii?Q?j873R+foMp0B1G6YjoxPR71pi+jDFZgz1WKjuUUGVcuySId86N+yBLveYI+3?=
 =?us-ascii?Q?akB9t/qMinf/tq03iiSiaZ+ePCyo/PoJ4Ag5X18vvyIsj+tGR/ToRsTGkBJv?=
 =?us-ascii?Q?7X7NuG2BEMstY3McSx0W5cbeaHaBvrVjYFgx86rFm4s/WOY2G++zByXn72oV?=
 =?us-ascii?Q?8OzXxobpL2aN5ehW6t0KpLDY4Fj/ClVYRSkqKLlwwp0eSky1rGLYfylad3AM?=
 =?us-ascii?Q?SEwnR03ubdJDAkGzMp78kotx478NvcczfnRfEtKiXZJajBSymoj0+btEMzYm?=
 =?us-ascii?Q?jjLWrdXLyK5wodic8OY0lvofwvnIazY93en9MzDrDI+Op6TFiQwlf8E5nBbJ?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1LWTNNiGerk6coH/WptLaWI33MwW8hrJ95ix3PhV6lGN/5qUsBjEFSlWV0moKaQhj+Qg1sh8Vej+tjPYe/X78wbLT5dFU2Eoo4dYEfMo3lqoEk4h5E0ZR3K9FN39U1w40K8vzq2aBcMb411w1gCtFZ/Cvvi5FUSFQhPM+mtzvrpHIpjpJmo9oJBZ8MxODgsDWM/+ojR/kFDuUdDhRFsFc+wA29atfKIvwU9htJgif4HhNpYg2JaZhHuV0XhYfwad4pmDV2D3mzsqZXdnvYSUKl2tEN6EWbirQIpqyojp6RVErj/hGE7qyOujSeJqaQebxZTCasGXj32l9h2bi12uY6FfP9uAGzppwMXSOrV8F0dF+4HQjvzvqzv2TETdOemv3j4sR6YFImCu/ZSHZb+tgWYny12gV6PRrCu3IfRVyJNtu395FG/31jXKLadL4QKaceHDwF1poALefaqhMpEwaRXG1pqa1JOW9VRO3laSLeJooSrIiGhSBk7R6K/ZY56GisvKwwpKi/FSfENNFjB0ZZaueLF+IesVjaWiSJdfnlasDRdqdoL/S2PRr5zqfxR+/FGl3iWe2Hu6FDTiPoAXr0YPZ2sVfmbDTJ4tXQArAew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47a6e0c-ef60-47a3-7faa-08de23893c51
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:22:26.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gJIZJwHUvIMExg6m27tfZ0UdUHFQVY0/A6UmzjabqpOIGoovftGOaN/FCmhUfJbYCcn/O/sh1wmGAB2t8N8hVihy4VxcymVINzkGKceRU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140115
X-Authority-Analysis: v=2.4 cv=VqQuwu2n c=1 sm=1 tr=0 ts=69173b29 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=KHwhsd_FDsKGKhM5y8UA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: 91rSYlvQLssEZ_GqAQjrVRNMqYr8BeNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfXzBHMYt5Lt+xq
 yByNJh5zW3coE0rweBJEvIMFfmMzP6C4sxNhMs4Mu/GQfY3qEAVGNzyceWmrPEwJD7rbbW7UFdP
 +imZcm7MWYPNm6+kSevzrM5l2B+gRwQ++r9EtGwXiiS95AnqJDrnmfQm4VvyTKSaNXhJhlgKnyZ
 EiSsNbNb1lP56v//1qYJ0tZ7s2DapRdfzTDDCII+nTHKD93uK/LXR/eu8Mm1GW2RqUCSD+AZkCa
 Yx31a9YAyU8SUx9d745zUaorxQq9LG5TqtZyZdh3nnrSrSqy9nzD3/dOJiet5JG1YH86H42Qjlj
 oAEd5L2+fWHENlcX7S2ccAxOdKRUppnc1AOzonT7WBMVTnGww++G8E/oy3qYFu2JCm8VskkOafF
 PFlpFDLyLdKs7lXZ6GhmbkD5uRuIGg==
X-Proofpoint-GUID: 91rSYlvQLssEZ_GqAQjrVRNMqYr8BeNt

Hi Andrew,

Please apply this fix-patch to solve an issue with the patch accidentally
causing duplication in rust bindgen when a VMA flag resolves to something
bindgen can generate itself.

To fix it, we simply blacklist all the VMA flags used by rust from bindgen
auto-generating.

I repro'd the issue locally thanks to Alice for reporting and giving
insight into the issue + explaining how to fix it! :)

Thanks, Lorenzo

----8<----
From f441480340ff608869f3655b2371ca70c77eb82b Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 14 Nov 2025 14:19:04 +0000
Subject: [PATCH] fixup

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 rust/bindgen_parameters | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index e13c6f9dd17b..fd2fd1c3cb9a 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -35,6 +35,31 @@
 # recognized, block generation of the non-helper constants.
 --blocklist-item ARCH_SLAB_MINALIGN
 --blocklist-item ARCH_KMALLOC_MINALIGN
+--blocklist-item VM_MERGEABLE
+--blocklist-item VM_READ
+--blocklist-item VM_WRITE
+--blocklist-item VM_EXEC
+--blocklist-item VM_SHARED
+--blocklist-item VM_MAYREAD
+--blocklist-item VM_MAYWRITE
+--blocklist-item VM_MAYEXEC
+--blocklist-item VM_MAYEXEC
+--blocklist-item VM_PFNMAP
+--blocklist-item VM_IO
+--blocklist-item VM_DONTCOPY
+--blocklist-item VM_DONTEXPAND
+--blocklist-item VM_LOCKONFAULT
+--blocklist-item VM_ACCOUNT
+--blocklist-item VM_NORESERVE
+--blocklist-item VM_HUGETLB
+--blocklist-item VM_SYNC
+--blocklist-item VM_ARCH_1
+--blocklist-item VM_WIPEONFORK
+--blocklist-item VM_DONTDUMP
+--blocklist-item VM_SOFTDIRTY
+--blocklist-item VM_MIXEDMAP
+--blocklist-item VM_HUGEPAGE
+--blocklist-item VM_NOHUGEPAGE

 # Structs should implement `Zeroable` when all of their fields do.
 --with-derive-custom-struct .*=MaybeZeroable
--
2.51.0

