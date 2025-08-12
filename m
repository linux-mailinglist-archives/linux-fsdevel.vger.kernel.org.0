Return-Path: <linux-fsdevel+bounces-57545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00857B22F1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F267B5C81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9D2FD1CE;
	Tue, 12 Aug 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TmBybz2t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bsl7dHzE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA21A2387;
	Tue, 12 Aug 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019935; cv=fail; b=N7UtfQDNTIPtqs3qBKkjERxzwRN5XXENo7+/QYfkNNWdA9Abkpx7XRELQU6CK4ZqY2dUrlS5/KOUOuXoy28so/RBnOKQ1qJ8axWI/FUAQY3y8ETiBfl7uhvgdh3Z0+5HES9cNIMnI/uUHPmcsFzi2y6BDckdzu/zzoufZaMKG88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019935; c=relaxed/simple;
	bh=cI6EaB3l3NDYhk7bmg/WayLsKS8/yNxronfgGj4PFPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fNnDw7P8lfWA8dHZnpbh+49HNbT8H6Q2A4AtKGuvR4aXqSSZ+oi8lKGSEiI9dGZFI0plnjSOGkAU0inye0fIDtURXU+ovRWgTEOCvgcEUWdNl3pDuU8ZiqMshuUoroMpM+nzG9OYDOe4z9+RNsuqPCk9Yd6QaL31PlzQ9IlHNNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TmBybz2t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bsl7dHzE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBwuo015982;
	Tue, 12 Aug 2025 17:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DA+5xVEopJK7xeAdBO
	xx4PZPEX6vukfF9qkgCwRaLmQ=; b=TmBybz2tDkWutJMAZl0mpZb4LG9HylsiKq
	h+6MnZKfcJGBlnTC9cryhVaa36QY0Ia5VPD2G4vgiTe9f1CK/hIWsQjGRmMCYs/1
	hBJfpAHSRFZWcZj0iiy6pyvY66Oi2/vb+iqb/Ij3whK+XImPk5tcWapXiQb8NA83
	VheEBbR7DOGhWdh653kZVdgQmGo/Cvcd/tIhQLqrtlGzsnq2K6Nu2MJhpU3HnJ3T
	8LAeNa1637h3Ol6QS/+qMh93xYsVWvbCj6DZojgTFrMnScUSI7w6RrBmlNG/7VyX
	Se9EqqMpJ+ua2tQMcQtLJYv995xfGfggihuSt4YayB2sb2kw3YHg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf5ahg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:30:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CHP7Ud030158;
	Tue, 12 Aug 2025 17:30:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa94a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR0P5erDu58BhbHjgy2V5Ivx7FAWImd+1wRsQj7Le/mMGHaEAaVS5EbH5/hdxuvMowLHVJI9+1QgMuKR/vdxM7jnKM9yIc4PhqlqMnqkiTbV8VKkvLZOXj/vQyvCcxva3f2V8PF9BCtv9/sDZ2oWzk3Wo3Mb6WHUmYA/CWN0qfTLfdJmTHP1iVBvNyI8JXzaWNtEyGZbdo8GPwZBVJxXNFpZ0kUvAKAVoAMbkg2Cc5FiHwc318nnpDLFPFVR7Es801GxlnbfaNQDVaUoPoUcfzOgYctUyxRqaDtfaYC7XZjsE5aLjMhRR9DfKQ3MrogUyPKEFBgifHiF1nUrYxwwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA+5xVEopJK7xeAdBOxx4PZPEX6vukfF9qkgCwRaLmQ=;
 b=E+aahoTpIZYBAK3j2AgHHNuNBIytr0/sP/SzOVzJ3xCxr5bGtWj5fKhO8qkYMbGnEEY5ZdvYgevs2vZ6UcoQyC8CJiolBnuQ+LZPZrPNu6+renimkvrGogngn/0/Xto4QGPj6LrlvVlU2beFZLctaZujstwrfJ2O1+duu9OmtWxnlU0YrLw6LFxYWF0cXMGai/JYJOl1F85D2jWf/I8v2PGgwiTsbYrtUyxQu1goCWX6ZE4A+9t2FIw36HruybVx4U1KH68PtnYuicz63/kVvf46E9QfKmbLu392Fli0GSkw044TQNf3b3gbT49JBM/pJu2qf3+ryHQNDyVsVX/bag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA+5xVEopJK7xeAdBOxx4PZPEX6vukfF9qkgCwRaLmQ=;
 b=bsl7dHzEEoaLbjel8syeEr2A956qzxLi2+UPNMP5vBaP5cWPWsnB6Xm+FautPN8n328a546H5mEoJLR9iiKIRNx4JuFtlgfWleqRXRFG0FF7VZoNi4kwBD21svaugcEF3TTnAk3yt9NMt+4D/v+l6EsvGk6EwfwFtOS7zwg9TZQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 17:30:22 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:30:22 +0000
Date: Tue, 12 Aug 2025 13:30:11 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 07/10] mm: correct sign-extension issue in MMF_* flag
 masks
Message-ID: <wibnhyzysutk5xpsarzdmloycfurclqsyaehl7mqrhzc2oddt5@tmg2xgp4ho7t>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR04CA0262.namprd04.prod.outlook.com
 (2603:10b6:303:88::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd0adf8-b1d2-4d81-3154-08ddd9c5ea4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nmkbP+1J2XRHiGNkx++QDF3cDxHb+GVPhhCK73AUTGmhl+V6JFS7xuAcDBn/?=
 =?us-ascii?Q?qb+xYjCebKv9C6/nLHxzhmh6GlGAQQhLMSpT/tIZSgJKvtFzgtOokPAuGgsG?=
 =?us-ascii?Q?pyXFpeO6lCSLgl5ElVGNFASmYYvXLLKBeemhDqmmBU5QAtTGUkZBp/ZpJt50?=
 =?us-ascii?Q?5OssM+QS6yds8WsqRmzfSBKrC3m7v1ezrV5fYXJ8txbaR3gNsa/Yya6RSDl1?=
 =?us-ascii?Q?mLe/8BdQQtp1sqcRhBBBSKAF2uXLDGQNOsvt2YEjunxknAsGtJpd3O8mhJGB?=
 =?us-ascii?Q?B2SYnug4O5Zh94q9Ynhuqa+sEZBLRFSQ4A5tQlZb/Odd3uvbk3XDiRXWdW6D?=
 =?us-ascii?Q?VKRr5qF6soE0ZQVSR9Li3UysKn2SLdS352qa9AIu3kntNXTwPd9B/Iq+Kgec?=
 =?us-ascii?Q?+Y7gLeqhtCOg3fxtSh+xN8wVkZaYmjScJUyifD7koRH8GQigbAc4LkTkO9/C?=
 =?us-ascii?Q?YKqkG4TKQv63yZMbfkXUS73Clna3127DnWGKMfFYd2kO1rHy0R7FyZ79bxyQ?=
 =?us-ascii?Q?4J3dOTCkrDKfgkZ+mi2+MZwKaAl7nMtV4BStXhNwLCeweEpHixOyOhTkV7tn?=
 =?us-ascii?Q?kFvhwDF91RTeTQVr1VrtqEGG/oNrhy1cCCvYiKSgtFo5TxOTJfszBxtD6WKy?=
 =?us-ascii?Q?AQVNZ9b83cxzo7to02NmwkM3W0XV5whpILnOtdvFFzQnrcO5CVgr/LdmRYgW?=
 =?us-ascii?Q?f+IzfvqDFAr30zGBJPEKGoDX5PWew2l7Yt82E7gURSzy5hEkhy5UqLfi3oJ3?=
 =?us-ascii?Q?EjKM/hQmgPeKATt8LJR7M+0LArjKEXq/qndctXujpkZyKp5HzHjQ4dXaPCkc?=
 =?us-ascii?Q?RBrDgi8ReomBYTcAuTqXcnsl8Wxl1miLtvQMcVE2HhWINl34LgZoTSYjmszL?=
 =?us-ascii?Q?k3lPjZYXz38TbSyBlKugnS1w+bTHQmAEugIRrgkHBpdc03PAId+Wydkcm9ue?=
 =?us-ascii?Q?dCb4AZpOsts5ZiQIMw3fgGMznsd3+F5a5fvkb6Sts0i0b1mXkMVtD1Lm5lZE?=
 =?us-ascii?Q?5rP7eQyFhvkpi/AuYpz7LCv+SqWWafNlIHzgM+yde3Hhka6exBDyYeWXv5TG?=
 =?us-ascii?Q?nher5iOSLZTgkEd7g8nXq1D5YygJWqc88sBOSsz+QZ3FCv+/l2rQ54V34ewx?=
 =?us-ascii?Q?A7WfhQIDmIiTBNi9LP3t+BJKIkWj0lVbRY6fzjz4QYYGNrmiJaZuOQs5rF5I?=
 =?us-ascii?Q?pi0d6680H5TGQR1ebbOJSzyYqptcqaqadAOODrnwmzhonXefMTkyOY6SBVMJ?=
 =?us-ascii?Q?Ed4b71rBmUk/hG0VbT0ACQi82nKOptDAcSLyws+reUk4O75EREtBOdZpKKhH?=
 =?us-ascii?Q?gQk8bQcHGGwAIKFWBLos/zdICx+Tlw0m7HyRHvKyRDF01SBiS4UsuSoUkjS3?=
 =?us-ascii?Q?kJA7vCgnqQaJnqxzp8CFXDv4/DIgY2hZ/BdeDVv0Q0VYH+Xd4JLKdlVuCcDW?=
 =?us-ascii?Q?csz63wJv7i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3R9uQaeBLEObMzbypRluPcg4MUQ1Ma8hhUDcNz1e+lwALyFpnDGI64tzX8K?=
 =?us-ascii?Q?GASO75qFhwb8IxHYdk18s7smCVdfF2Lr4cBJjRRx+QKjSm/39zOae9emiuBl?=
 =?us-ascii?Q?X39yjpdzsv9Z1e+UEGa5wuofyqE5sCWqVZABd17u4WwdwWdhnrRdYziKykgG?=
 =?us-ascii?Q?xdRGnklO9TvHmRv98a58AmJvoeQnWvYUbpEinyayhRuOgww3KaZ4lcBeijmS?=
 =?us-ascii?Q?lEvReBwk6O6kgTYgr6/hu6xO1o+RwQNa3Z8e/A8T1h12OgwZTbYyaxF2WeBh?=
 =?us-ascii?Q?5E0BbtqWobJL4IvNLiUCiylxBncAV5FGHsx2h/lxTaWAWqY+meEgNmK5MQM/?=
 =?us-ascii?Q?xWLkDmX/IPjSKBnhSxuWvp8C0olF1hW6GcYAL9mAHsREns9pfOQdceufARAK?=
 =?us-ascii?Q?LNXzE64fnY18mvj7w4694q4NOfZuAZ4GQ6A3O5bWlhgeYqGjZmHjdh//wdrP?=
 =?us-ascii?Q?r8mNZm/Acqg0O9Hxq6xC0sH0IC78Vo6jFoPpF5qW/XV841Qz2C+EfV6r7A7W?=
 =?us-ascii?Q?7PataUP53Ko0pBfYkgLh70Y0W3jeiDYGhULaYpDf5pPy5Y69TMlfeoI4s/mY?=
 =?us-ascii?Q?iYYdBNLZdXc7EhaFXO033z70guqEXtWxNykiVUrxnK5E6ZCfvJw/aX/XS0Tm?=
 =?us-ascii?Q?jQp07g1adLGacJ3hgrhwnoqj6NTUqdpQBi/x9JORq6MJ1kkio8r0vje5F4ul?=
 =?us-ascii?Q?SXy6JBaJ8e6b085kgW0md1qJdROelJzEtV+p2jYqbVPQVu5h/1UBMfl6js4g?=
 =?us-ascii?Q?QkwJIKeWXjWb6yUhf4YTvJWWh5sRhu9i/frTj671yOdXO/6nKs1zY+JgEhVW?=
 =?us-ascii?Q?nghhDlPO2dhb+OoABm1mbkS5afoMsQmP6BUxX96MHbREVhAMko0r6UCr0nFa?=
 =?us-ascii?Q?GV1xypFSJDca4ZJasyH0ITDDdsInu8L0qTDFo64j2HKXiYeIcfJ2t3xqqyVa?=
 =?us-ascii?Q?c0SD5zVsAU16EyCmn/gN1vh5ouilWcqQZrhMQvrbE9asPKOzWr1dDKkCYC2a?=
 =?us-ascii?Q?xQf0Zf/E5YG4ZOUOVqrpVwLhV3kNhm6BePLnu6T+g3WGiK/FoGQLybvgCxCy?=
 =?us-ascii?Q?ugVw3PooSJDLYwKC/2IglqS6JjdMs2dptiX1hPKFOjNJIGhTtRgpTBBVOea6?=
 =?us-ascii?Q?ovncEYZ+lna9n92REvaG+6op4atG3x3P+XUhd6kW9j4tcm/QFIf2clCiP7fe?=
 =?us-ascii?Q?RAc0YGn+Gg/rXWglc8+DxG2QdiLGc7HVWo5r86JTTXnGxUHn1vTmXK7CKAac?=
 =?us-ascii?Q?FnKT7x1zPQuy22jCT9DlW7jb7dN7pfNS98a631AAjVmtQWX4KICzhim6/tTf?=
 =?us-ascii?Q?puarl24Y7g7RxtTUnzzBjMaiDmDHA5fZn+wwm+c5UuV33fCw00snOOI/d6gP?=
 =?us-ascii?Q?11e5cl4XiPAMz5HRrLHwZcXb9gRauhClJ86uY/GL+PZA4WiVJ2a7hpmN23a3?=
 =?us-ascii?Q?e10+VkU+9Y7v4hd+MdHM7PoMIZ5oVrsx67RNyg+P8qdWNZKGEIOuk7UHkNt9?=
 =?us-ascii?Q?1f9yJyH4XtCUZPETFTs2Ndu+kiMDkx9ooGKUahRGVU+3cPJhKzyyHTZCRjhy?=
 =?us-ascii?Q?MqkGksMWtMf04E1TRvu7gaQVIRNWeyn6manLB91G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jY81uVR6aoIysbD5ca9gOUFTiyOnbEO4QvukiPIuNf2bnELPwooreEXGI3sLRxIcJ4tf6m4fNpzfsVblYdtuuXabIiwn6vrsulKITGEp6msNy896JTu/BzOGDqJFnZzQFrlMp6rf4A82IfHJKe45Zf0o1uQJq6kZZ9tfd3UWx31aMPfNygmTiqjvUAhueKGEHWZ1X+LAWe8vmsrT8GXddZIaAqVsCmQkEqMIFhhr3lmfut6t3ub5ooY9zm6cZz4986fPuboLpThdKCsohdply9TcKANsAlqZ5Q7OZahFgwOcAsOUkoS2zvBOlLoBiWAcX8M5KvBP7NK7rjGOkeYvkbPWR2ZQEgT3v/YXaZAQtOosrQVuaiMfX2EzAZhY/GrPiSyR4UY957Rld5SN9A5IwMERwAF1WmbnZusNmeIPWWCZA89JdDRTgF1SqVyg6XLIS5WP1VgGVDzPE0Ye3sQxvPOM/2WORFI2SxspA1xNTvGHvUQcqnuMFMUzztUvxN0C4P/cvlCawa5xGgfke98aGfrwCRfbujXieiBF22paQDW/nlHfj1mvi6ex3qC8M5IB7mRxijuIJ806oNbwUBCfcq5ulRGfCi/84yiJ5nwDIp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd0adf8-b1d2-4d81-3154-08ddd9c5ea4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:30:22.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl8dCx17Wef2mRwT9ubQYJswV2vFI6v0CueztIaJCLyYTLnhJ9ejC4ANjA9AcC7uG3xvagQyGtCCwMyBgPPcOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120168
X-Proofpoint-GUID: gCNPR_0DG0OY8LphUdWEMpC4wA1kOQ7h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NyBTYWx0ZWRfX6+AcWj7WSawj
 cYl6/L+Fk+P3+G8zB5U37ujb+XYj8SdAv4j8btnjXvBQImhI+Pra7/cwdvBzp+SChKqF0/e5IF3
 w2ZxY+oicJYIoz1KU3yFDBDSBPoxB3TA6MuACVVTORNTQESFOuWdG44Fccsj1WLPIMR4ZW4XTQd
 mkw4p+S/AyMyCA41urx6SsLL/85JWUVPap9v2GpHij4cqfckHSOs9Xefc9OTXIUdL09ht6BO+uY
 IH1g1MRS6XqyhldYuTERvSYYhN9uU1yS3Yq7pnMnY1lRSlcNKb9zusMeFWkCM+Ybi8039v1BXNJ
 nzRO9/92nRb0StoR7IgCn1dqHvq2dQoA6SlEAez9R1eCNP3ApMUtRo0lyhN8nbkvU+pCq5Kv9nF
 bO/VDcxIU1Li7BqMHS9dnyz8pcuwAkK4SAy8UhhqGFRHJZFz+Pb6FBWOB1kK+/uf1B2dQmL4
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689b7a34 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rBQBehGO2VM52d_tg94A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: gCNPR_0DG0OY8LphUdWEMpC4wA1kOQ7h

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:47]:
> There is an issue with the mask declarations in linux/mm_types.h, which
> naively do (1 << bit) operations. Unfortunately this results in the 1 being
> defaulted as a signed (32-bit) integer.
> 
> When the compiler expands the MMF_INIT_MASK bitmask it comes up with:
> 
> (((1 << 2) - 1) | (((1 << 9) - 1) << 2) | (1 << 24) | (1 << 28) | (1 << 30)
> | (1 << 31))
> 
> Which overflows the signed integer to -788,527,105. Implicitly casting this
> to an unsigned integer results in sign-expansion, and thus this value
> becomes 0xffffffffd10007ff, rather than the intended 0xd10007ff.
> 
> While we're limited to a maximum of 32 bits in mm->flags, this isn't an
> issue as the remaining bits being masked will always be zero.
> 
> However, now we are moving towards having more bits in this flag, this
> becomes an issue.
> 
> Simply resolve this by using the _BITUL() helper to cast the shifted value
> to an unsigned long.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm_types.h | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 46d3fb8935c7..38b3fa927997 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1756,7 +1756,7 @@ enum {
>   * the modes are SUID_DUMP_* defined in linux/sched/coredump.h
>   */
>  #define MMF_DUMPABLE_BITS 2
> -#define MMF_DUMPABLE_MASK ((1 << MMF_DUMPABLE_BITS) - 1)
> +#define MMF_DUMPABLE_MASK (_BITUL(MMF_DUMPABLE_BITS) - 1)
>  /* coredump filter bits */
>  #define MMF_DUMP_ANON_PRIVATE	2
>  #define MMF_DUMP_ANON_SHARED	3
> @@ -1771,13 +1771,13 @@ enum {
>  #define MMF_DUMP_FILTER_SHIFT	MMF_DUMPABLE_BITS
>  #define MMF_DUMP_FILTER_BITS	9
>  #define MMF_DUMP_FILTER_MASK \
> -	(((1 << MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
> +	((_BITUL(MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
>  #define MMF_DUMP_FILTER_DEFAULT \
> -	((1 << MMF_DUMP_ANON_PRIVATE) |	(1 << MMF_DUMP_ANON_SHARED) |\
> -	 (1 << MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
> +	(_BITUL(MMF_DUMP_ANON_PRIVATE) | _BITUL(MMF_DUMP_ANON_SHARED) | \
> +	 _BITUL(MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
>  
>  #ifdef CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS
> -# define MMF_DUMP_MASK_DEFAULT_ELF	(1 << MMF_DUMP_ELF_HEADERS)
> +# define MMF_DUMP_MASK_DEFAULT_ELF	_BITUL(MMF_DUMP_ELF_HEADERS)
>  #else
>  # define MMF_DUMP_MASK_DEFAULT_ELF	0
>  #endif
> @@ -1797,7 +1797,7 @@ enum {
>  #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
>  #define MMF_HUGE_ZERO_FOLIO	23      /* mm has ever used the global huge zero folio */
>  #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> +#define MMF_DISABLE_THP_MASK	_BITUL(MMF_DISABLE_THP)
>  #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>  #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
>  /*
> @@ -1810,16 +1810,15 @@ enum {
>  #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
>  
>  #define MMF_HAS_MDWE		28
> -#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
> -
> +#define MMF_HAS_MDWE_MASK	_BITUL(MMF_HAS_MDWE)
>  
>  #define MMF_HAS_MDWE_NO_INHERIT	29
>  
>  #define MMF_VM_MERGE_ANY	30
> -#define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
> +#define MMF_VM_MERGE_ANY_MASK	_BITUL(MMF_VM_MERGE_ANY)
>  
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
> -#define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
> +#define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
>  
>  #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
> -- 
> 2.50.1
> 

