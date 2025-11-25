Return-Path: <linux-fsdevel+bounces-69760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E064C847A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0233A25E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C72FF67F;
	Tue, 25 Nov 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U5RBIFXY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CvpMs15x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7D2F361C;
	Tue, 25 Nov 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066426; cv=fail; b=Bjf6AAi8dWzrVqLTDJYI68+79CV+Afnns24+D+JlSmuaMW8a+gk+MPpLwGvoJ5W5yRNY16nmp8anUNhJsURqsofUFvZQ2k0SAoBJq1vMDm6VPCo5nTor4gH271eSSirRKELbHlPYnvJJHEzPVKI6JsrcSm9hP9jo7r+CkYWTVL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066426; c=relaxed/simple;
	bh=5w7iVSA9berm7L9mh3ybF8wlerjVPtvtI/R4ivvGYLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=maYuZBvm+A8DapChHmJNmx3PdDkM1fzE3WCwYcxEoDvSlofVSTsyBaYo0iU1U0hkMTRsrUALlLFKBC+QnicYfJAjCaHDrX79tXA2RNHwrWXMXYPjhFVs85etyQhwE9hu1aw+reMV0PcArw8awGAsOUUj1IbvLz2NfMrNhlzBc+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U5RBIFXY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CvpMs15x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP9d0BI2343197;
	Tue, 25 Nov 2025 10:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5w7iVSA9berm7L9mh3
	ybF8wlerjVPtvtI/R4ivvGYLU=; b=U5RBIFXYC+Lh5OZgtwIUhyjUZp++DJTQSR
	uK8bT1JxIuR17TRKkyxlyFuvuMW0sBMgcvjXguAFttQFlzOopzmDhTGkk3TUz43o
	gD1ZW/VzH0LtHzncVs2H0Dwf3ZbV39LixMbNQslvvHBP0nyaPH4oKf1W8x/sh5XQ
	PLn4dxv53Zi6rATciXFzgnjzbkQobzbQfV3o4wGdsnOKtjsmcjHIYYqtpPJGYOLP
	w3GjogZGIT7FMN8Q1WZOiQOmWIdid3RxVfczyU9fcseSJncK/Hs1BQgBszAxEZmQ
	nCn4R2jvZpJxkK5KYxSPUx2eKiK6WAMIYzIVKimBZRkfrHBcWO/w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkcauc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:25:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP9Jt8n019736;
	Tue, 25 Nov 2025 10:25:33 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m99aq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGDFuX4GSScoci184yc4szrxT5gNmI5gGQvQoHQHtKWC2KUHxOIbJq6S3+27/Z2K4B8Zqn08O/FwHWAh0zCW8T44pitx9a7UEHmrtRtEXpOWv09mNN7uG3PmCe/7PG/NZPe2XcGFeF5WB0crK5bpus96U3z/J+cGGdN+24nY6MNyIazVkXZ2kqxtlOBz2K0vzAzlPfG7FtHgOINnK+/ouBM4S4riQF6nZPtRboqO/Ozb79D6DNQMQhRU7R52kpPB8d62MLqhj6uEh9X+R2hv155rcxNLpeXI6gj8W+nmN6i6idWNximrdb/1aOpFJcEHJdXuFoqroufjpHjUZQVvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w7iVSA9berm7L9mh3ybF8wlerjVPtvtI/R4ivvGYLU=;
 b=O+91tcox2VXxTlIjCrCW6e/FSnI4H6SJH2rYLea4fAyrbPjXBH1/he389TfR0X7H+EgPWBRF+6xXOp0VfEX0ssY799S8gfZm4JnrMO2p87jlTZUu//kQS+JYLsig/6PdKlQretDjLPasfBtnGIzW2X1yx5Is0KbtN0DpyhjJdH3ZMOR0YFBwen71WEHOS74wDNA02Dz/QwduiNUmCbDeu7y0oVUygN9pTdOGAduuFivU9ZDB3v8KY9ICOSQy93rgDIRqv+ogHe6YnJJuckiT8hwZBg3xDEGSSXFPMLqrzOZa3Bz615zF5/5dZvNkFM7UCGfxixRw39xmHy9z3CpwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w7iVSA9berm7L9mh3ybF8wlerjVPtvtI/R4ivvGYLU=;
 b=CvpMs15xFnOtbKUKy23qumel6UMcStKUXN9rtEXQQoOzOMymGvC318kbk/zuz2pKBjRCjDefq93pPFj/i9zKBpId6D4d5Gf+bvEetZLs0QB0I77Vvhg2PoUZ0VNwJKb8sGaTmJR90tEyv9pgbIU4OTUhvjs5d46JV4Y5QyBfuWg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6087.namprd10.prod.outlook.com (2603:10b6:8:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 10:25:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:25:29 +0000
Date: Tue, 25 Nov 2025 10:25:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
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
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/4] initial work on making VMA flags a bitmap
Message-ID: <e7af6426-56cc-4615-9696-019987748f51@lucifer.local>
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
 <aSWBNSbXrWJnpsRl@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSWBNSbXrWJnpsRl@google.com>
X-ClientProxiedBy: LO4P265CA0206.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e5159f-429a-4851-c3a1-08de2c0cf4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OvfaZ8Gj1CVCxC5Ii4ew+mi3EXEwCZxvMiO7YMNJKqnhkQnFrc0qpL6tt6mQ?=
 =?us-ascii?Q?MV91RGjufdW5gggD5ydqHjjqAi9u5HbcdpfllWSa8Wc+gmlXQpFGA3OF7Mel?=
 =?us-ascii?Q?kVSEx7VCaL3uJEL6o2jaLczVFVf/VuPO7jSEPfsbhxxPIe5YMNnxaCNgou+5?=
 =?us-ascii?Q?QRMcthYHqZfG91048lLcG5zOkYCUMMf1e+4/MkhF2SY8zW6AdRNAOTJKTkw1?=
 =?us-ascii?Q?GNnlHpQfsDNrrxFPq1iLw3QkY6Py/SkbB7ZbzxGSSPKjiz9yGx7wvcMfuGkh?=
 =?us-ascii?Q?a8cBA0LTj0QSCOYChu3TrfTtikLdIcSXAl55e96Q9Iuqb/QLBAcy3T5DgKFR?=
 =?us-ascii?Q?MZZakvP/MIfjzqnVmsqjWiyQEFKZU/vfIdn7Pvks8YtKZvkzssWeQeL9w2R1?=
 =?us-ascii?Q?HQ2zb6H7TjWNGeJQuIa5LhSKjkQhQ6sreqZLqSQnlJjiujcEGbnwPuaOJUyo?=
 =?us-ascii?Q?FyWZfuOQcmWkt+u+GO7Ixk+WwbCGS2WAdmLBgmmmtBLGFlsezW33sQBh37uN?=
 =?us-ascii?Q?erKdpUKxPkg1rO6Ec2oFsqYcAo4ldJI5nOs3HMQ+lZDFjBdkSgv5Eyru/IDO?=
 =?us-ascii?Q?501O9JAF01achLKHrna/LVbeG+dkvzBoUeHCww4kUfe9C0RMUHdBHRb7Ik/Q?=
 =?us-ascii?Q?++Imn0TnMGWn0AmxZH5OzeCVzYRdAqpq3nvak5WwJWCMa2fNXUkQ3s8BTzm7?=
 =?us-ascii?Q?rucrwbXpP+eUwHei29mVQbSNOh+XjRcb3Bq/tIslJtMSPE/FNpf78sOGNzCW?=
 =?us-ascii?Q?K36TpSwff4JzFz6ohjertOOV1a3gRJgxBgICqlOzcjDsfXF64PgEae9gwNNF?=
 =?us-ascii?Q?lzOpz7UG2V2PWQGM7ntxFPZNOXHbvYNeBtbAJOWOrxZOT4JU/QN61QL9yjCJ?=
 =?us-ascii?Q?6AUG/Wu0ExHjh343klBDp4j0HsWCps2J5GE+01qDMj3Yu6k6WIqvJGfCDaQR?=
 =?us-ascii?Q?GVCThqTzVvQAE8n9GSbuDI4/C8b9T4KiwSxMsWAc+FRikEF/iAnithbs5xjP?=
 =?us-ascii?Q?eARHTGWacSs7dOm4lupA1qy8a2r4Afmk9xNihvpQliL0FvhILkoFPXA3QeBJ?=
 =?us-ascii?Q?KsvMwWTXjITjuVad6ge4I6Frmnz/kQlzPxyPJjx2Er/hnch1LcEehIYaQ9JP?=
 =?us-ascii?Q?/2YCmHbpyBVhbzx9bkUzzGkmmJh/SEyZuF+VOjelER3LI0bgeGEQE4bECWMA?=
 =?us-ascii?Q?OJHbb21valQhWUVfFxlJH5ZpKq/OBGfDjYVcZiw8hxz4dW7D6gKdjK6M7r5b?=
 =?us-ascii?Q?qlRMJfDQmxrvWgp/Z3wrlRFFU8u5Ksasm4mPqjZattInxuxzL/qkjNflkAK1?=
 =?us-ascii?Q?ZaQjqdzvFXEpz+vUWm275s9Zql9bcka5nQAq5GnszKd02cFUXrTN+JRrRsus?=
 =?us-ascii?Q?eeBBVr6QILNbwepk+D28QvDZPf5RVMOVSe0VL/8tvjGuVwbHYHElmXObP+7D?=
 =?us-ascii?Q?clbHjoi0O3NJH5Ly7OWaFW/NPfhcReRQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtC3kftLI926mxrRc6MUArWyUX5AdcESj+fhepW67fjFjMD3FRtk+MyzlYvM?=
 =?us-ascii?Q?TsE4sAAcslttLYuu0rN83nqxmKtXMpKiFk6RkXqix6avtnUuQv5WjvYJ2T2f?=
 =?us-ascii?Q?EXSbqwWPcnjG77NcT6HFFGeuB7r+JsiZaDUV2c3bz2vrDffbznmwwGGD+Mg8?=
 =?us-ascii?Q?uIzWk3hjW0J1xepy6vGEKxfM1wpM3RHfWRAEF+GJhyXYfuFanzJ98N/7QKTo?=
 =?us-ascii?Q?dP8B5Ud6VjS9NIYqEse+oRI0zcrXjygLbUaLbJvS19LRBtEUg+DcYTTxtWFZ?=
 =?us-ascii?Q?X05RYMlAD9B3CgZEfNA4kf7ES0Zc24I4VAPaohOoKYxwjiNf1EDVJeIh+EnA?=
 =?us-ascii?Q?VaTrmIH3CTctVQi1ZaS9VZR4gm3cAdJ5YJ7/adIAk7wfGe36uJEKhs3fS4PT?=
 =?us-ascii?Q?ggns8ATV4qD39BWWuXnbK9oeuU38R+lYCw8cav5Q1GZL47czXg/OJBx5oDNr?=
 =?us-ascii?Q?249/rtsBRV8GyztokZwIfp3yN9THUTJiv4pVQwRGH5+WcoPAzH0TOoBaFOqg?=
 =?us-ascii?Q?HXluHESDVPAISpuwc2XDQIXdrbB7zFdnJq2Cz5wCdxhzDG3DMNJAs+95gbH6?=
 =?us-ascii?Q?DyV4ncft3yNGGcvqSAycPHGGJGpZMjCT1Hgc/jyE5qCEqCl7TOIVMlyASYJc?=
 =?us-ascii?Q?DhFEx4MCbwG+iIoLX1jfDB20UZ96NOl+naksyRIZsRFID+Ic8RBpTVqWeoo2?=
 =?us-ascii?Q?rxiiPz2K5YHVzd0J2qlyudK3GpFZFSaYDqyQXs0uBLbIz59y82pviFaidAzl?=
 =?us-ascii?Q?FYI4pbpquJ3k3QmcRoBVNPerTZRmgpRi76DmqfedhmwgF8sCrBYtbn+wyc/4?=
 =?us-ascii?Q?E+ACXri8Z/lqOiInAshW/uf7rs3fDx2maFF/Fa1CHJiAj/LGNT9J9phGroxO?=
 =?us-ascii?Q?vjlIoIFqI+6LjWBD3QHUUW63Cl/XpwUaOOao7UVCL1L5hC1KajSqBLCCdmNT?=
 =?us-ascii?Q?BJ0F2JHYlnQ1aMqs/ihfv3PY5h9ilDM/edjDm8O2xGNhtpwTz8XT2EKOysG7?=
 =?us-ascii?Q?PJtTcxRkIOYnNonz2tTU5HTwNFm6GNG4ej5Z7EH24532A0De8rLwYI8LVHeI?=
 =?us-ascii?Q?cK65jhwfT3ObZZNl2HoBalaiON5VzZPHp0wxbPym8RZzd7r9yirV1keGvk+l?=
 =?us-ascii?Q?yfTka9kkGmZObimHubRpXXiImYCHjiCmYcyyDAkXL46YmCL37af9fongTtcb?=
 =?us-ascii?Q?ILix1t1VpYOC6NpWlovTZy3eYQfrBCyDQN+xmRE3svyq29tSc1P91cvUPFCm?=
 =?us-ascii?Q?ixgWD6zVuXwiXeADhfcMMY2q57PUbst2ogS6Dcm3cBu55K+TWAOYVyjjeUB6?=
 =?us-ascii?Q?PDiBbL6sacfSHzPmhpAj6yBb6OmzkjG4Ve2V+BhMwWN9gJyLOQQVkh0Sm5Wu?=
 =?us-ascii?Q?4LsRQDQV1u93BU/SgrlEFDgsNRS6MjqpCv2mIoiIK78FzjQP9xbgeSybv+7a?=
 =?us-ascii?Q?sAuK92ZQNjQeHn11GJefkNvSd8FIvl2z5JuZtOX+U66FIWwX/KHZ5t/pn+zw?=
 =?us-ascii?Q?u+oL3AKCJimvq6wT63cOOyz/i8h1vaqSoXLrIoO5AJAHpNJjxfm2XbDCxqdW?=
 =?us-ascii?Q?RGMmKVtlGjN0bdRexSubKzuDsm5mHB23PMCIQdm7LNKqnJ+vU/mWOQLU9VYH?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jSQctJ5pWIONQPtSaUAwiMgFZ+7njFsXV+PczW1gOMS8SsdPr5R5+KCJyKueovIVrWckdTTzqHAX5zjvv0PR2IZnThT+SMGk19Nt6eNPP25d1Rn7WVd2C350x8n3ZZxPPWjfpOtIaZdu1ggnOIYgbA6Iez9T6ZmPD9ScmP1yJTYkxd3VneNOQXBESOYsp87gYun0UlQUdXtVbPvjoX9nyL9FBXMqFFTuTAvMlmRAKZ6hYEepvxXsr3FNXHt2l8LXGbsKcfpUsbrCvdhbihx3Y4NzMlJqJa4INosx5csy5P81by0wEyM+nhdf/bFyw1YMPIGu7LIauHOWAN9rlyGkaA9zPZZuhq40TEwYdTMCsfweqp6XFJm4VmRytJYRpuQZbICKICdgBqBeP9ACV9u1LMFfKiatrMZhrStsfjuwpd4YlVdzr1IgsOtxIjX0B/OMEkNgIdu7uBQ65oMdLcR6VhT0fhIjB0MIM3unLF+cY896byXmibt8aTreLflxkaEVseBRd8P/5Np6df2SNiHUz/o5bTyawGaFWdCfdjRXV5pNjH9NHw1QGjAqiG5KhOi0r5SEv0c1mlpxIT2+1iqdMklluiXFWISv7QHnrfoRBvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e5159f-429a-4851-c3a1-08de2c0cf4d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:25:29.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZydvB1Vp9448x/XDeI8REvEHha7MtuSMRBPLCmG6ujBrjeXOThDy7vlnb7bCYffqvFuiA9hnQrYIEkw92NJmKfBBoCdyGupvloYZ/bYglk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=536 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511250085
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=6925841e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=6eHyYN06GUfSrN7Yd7wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4NSBTYWx0ZWRfX7YCchofI81Al
 e8u/k9BeSoawVD6miZPYHDxEwnWksTlrbrGX+ZEuDeXvr8naGKMLBE8eDh5ptGkREHVyHvBeFlj
 DMvvXlI5f0GVuCSNQH/EOaCpPCMpKCgjF9CP78+KkzFR7emf05qoUUsQQJDss+vvm6zG1kufpdE
 dLA8OQRYME436KyGEUmU1KWfLVkM+96StxnDt34LIk7h6X6LAyiIwk2pvxj5La5EHzs2mko3lPY
 dws5ypNNqEw9N+u4lVNWEnLpudmCPBp9EsCQxbhsPABpk+N1EOoSbgq6c9SFnBu3kgfMjulti8j
 QGD7yeEJxNno4g8bqytv9SsheVRWp/5p7unH1yIdyw8Y9V26PIYDsmwF3iaDDY3VrbtOOH2kmcM
 S9+APVBiyLhBIwWBbvYRmtSnZD3ZkA==
X-Proofpoint-ORIG-GUID: 8Vh-QgYBZnygHYLVdmT6v-pmCVoYpKHH
X-Proofpoint-GUID: 8Vh-QgYBZnygHYLVdmT6v-pmCVoYpKHH

On Tue, Nov 25, 2025 at 10:13:09AM +0000, Alice Ryhl wrote:
> On Tue, Nov 25, 2025 at 10:00:58AM +0000, Lorenzo Stoakes wrote:
> > We are in the rather silly situation that we are running out of VMA flags
> > as they are currently limited to a system word in size.
> >
> > This leads to absurd situations where we limit features to 64-bit
> > architectures only because we simply do not have the ability to add a flag
> > for 32-bit ones.
> >
> > This is very constraining and leads to hacks or, in the worst case, simply
> > an inability to implement features we want for entirely arbitrary reasons.
> >
> > This also of course gives us something of a Y2K type situation in mm where
> > we might eventually exhaust all of the VMA flags even on 64-bit systems.
> >
> > This series lays the groundwork for getting away from this limitation by
> > establishing VMA flags as a bitmap whose size we can increase in future
> > beyond 64 bits if required.
> >
> > This is necessarily a highly iterative process given the extensive use of
> > VMA flags throughout the kernel, so we start by performing basic steps.
> >
> > Firstly, we declare VMA flags by bit number rather than by value, retaining
> > the VM_xxx fields but in terms of these newly introduced VMA_xxx_BIT
> > fields.
> >
> > While we are here, we use sparse annotations to ensure that, when dealing
> > with VMA bit number parameters, we cannot be passed values which are not
> > declared as such - providing some useful type safety.
> >
> > We then introduce an opaque VMA flag type, much like the opaque mm_struct
> > flag type introduced in commit bb6525f2f8c4 ("mm: add bitmap mm->flags
> > field"), which we establish in union with vma->vm_flags (but still set at
> > system word size meaning there is no functional or data type size change).
> >
> > We update the vm_flags_xxx() helpers to use this new bitmap, introducing
> > sensible helpers to do so.
> >
> > This series lays the foundation for further work to expand the use of
> > bitmap VMA flags and eventually eliminate these arbitrary restrictions.
>
> LGTM from Rust perspective.
>
> Acked-by: Alice Ryhl <aliceryhl@google.com>

Thanks! :)

