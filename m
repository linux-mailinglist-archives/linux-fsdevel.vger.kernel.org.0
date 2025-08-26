Return-Path: <linux-fsdevel+bounces-59216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68BB36961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3D8E5A75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E580E341ABD;
	Tue, 26 Aug 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WDwS1AUq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="golWhGGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601B34166B;
	Tue, 26 Aug 2025 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217387; cv=fail; b=efnPXq1sFZ9Aq4uANdzfKVulqcE8nMpNIEOTErPr94Qp9CdckAgt/FaQehKv0tQ28mXZV4+ifykT7BFhXRMetCG8evyki1qEEPJiIrsaQFQwZWH23sQ2Rta9eEEORmPIJmLs1+euCI4DewEbkpP9Ehfv15oasofi/CfqiGVc57w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217387; c=relaxed/simple;
	bh=kw0jmvQ876QcXfKZ9zKqn23iOXJw+v36i1dgB8f9qKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y7wj00swJIK90RY23Mj24VGxdq2H9Cks8tXFre1BndSK+H2fWXiVUaXLqLkhMi54ipeGUE8PlQh3cM0m4TUFnQSGPI0y8kSfJ8Us6Kh6fgo4QBZYl9fMWIqy2oEY+O8sHdML5s2BtKwOysYuN1SeJXd2B4Oo6KwqW7EGmziuxH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WDwS1AUq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=golWhGGx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCGtu5028601;
	Tue, 26 Aug 2025 14:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jVGRp1nmKMliMIrYWB
	Qq4rtPSWJALpAgKgTGuNctrSA=; b=WDwS1AUqlHnJglHUJv9xTtOs4qdmYWTW+4
	uivyVqNYnsyWH/AgcMBf2mAt8qBoWhoqppl7mG/Pk3aq8nuQ6CP3+Yas7Pq0g2TD
	XY3mbcETiMI28lcNKS8j7TOcNjjxsiCmtUMlh9LZWkc5yY6hKRtgkki9QnEwWnA5
	E/8GzvFKqePpdBYhc0kgwFVZoPu8XTOTBLLm3avuhVKOcUKr6QigRJx0fzijdg7C
	/PyPvP4fBx3DDCTzlwkufUHiq3d7wNxltvWq/EmmjmXGvEzAuEUBIblPk9K4oduU
	e/oCsaU/Stzufoz2l2VK2ceVO/lDTnzOR1P+nE443ROBmBzTl97w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48emjj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 14:08:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCtZ8i018976;
	Tue, 26 Aug 2025 14:08:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439n4gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 14:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7FGaRAVlpJemLCEDwMmL5tzKqyzXsDMLrA3K5RWguuhgnG+xVuwQU4meyXfxUNULZswCHl+YMCPllqdakgl/6fL8wowCiIWhkQPca5FbQI8UYMXnnAhmwgTsQgdL5GwwU/XYQMj8TM9CsVgeDCcttVNhrIOzRbI7I8mzSSFoLkL5fU2kVyGYDtlCy524DEh0NNBTBH6enZgPrxwA/Lf0XUQ3CYPE7upLV+bato9eadEd86/Cf9Qq7M07El7Vy/ZdqZV+1Dpw36pjKSx+WS8K/XAH7vTAgbOK+0MmGzvZDQygfRlypF5oec1IZKYAea4SJE4MLPo3BD0JmlRlJIcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVGRp1nmKMliMIrYWBQq4rtPSWJALpAgKgTGuNctrSA=;
 b=ypuSoZHpiFDEpP+godro4btjV8IKoC4WsH0vb/7f6qsQMQ48ftrP6L9XWlwrwQbah4dF4KA556JG1yLa2ch9aDb4ceX9e+ghL1mp+BAJC3VGqpQjS55BiSVMowcSO1BkI7FTPenJ6DdVIcjvXdD7q9qO6zPq92ASJ6X+IUus3agqpxOvTR/gBU0R2T349p7j61umYL7CF3yHkDtDEyOI14gVGxby/jq1EJHKjns5YQUvJ8YLO1bWtiW57qmEa2p9+TiEfXIYQhAZz/x7oq348cEKKV9TAEAXZNSiAa3PzvZYH3A6rKs5i5REFVR3sfDV0KALTv1FP7aYDTOsbyZpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVGRp1nmKMliMIrYWBQq4rtPSWJALpAgKgTGuNctrSA=;
 b=golWhGGxnfX5cu9RLjK07Kgjh8FV9L6D5y/DFZXyoh7q6n4pgAa35gLy7I1HrnaxGd55RBkACXATNStQLA6w7pNbMjQsg1HZfbIIoFQ8CAraUE2cPHfHCcB5eJZUoVIXH3icgqmOOFceT6rMNjBXZYLIh/YvzhiYDYwCei0YKYA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 14:08:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:08:50 +0000
Date: Tue, 26 Aug 2025 15:08:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
Message-ID: <a0290c77-cd88-46d6-8d9a-073be7600d88@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO6P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: f8629762-9c13-41ae-2ca2-08dde4aa14eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Hplj8OOXpLaV+Xltd6zTW+19BaDsjtcSYk7cMIh48GpMy725hx+/yNnx9fi?=
 =?us-ascii?Q?zLY0M3XFRuCuVe/WVkiGqn+hOqMn4u++ne5wu81lga95ZU9mwKSPZ2wmJBiI?=
 =?us-ascii?Q?FX2rhtGd9Y+iVHKrL+psPEk99DNrUrcgP4rOFgVkwlhrDPHmspcFd3kTSHax?=
 =?us-ascii?Q?rfE2wJaI36QIMGE4kFI6wPgZ65NBwhyPxXYqqg2cgoshYSzI0dnvsYLHQyrE?=
 =?us-ascii?Q?nExcNCOixEzXjNkrDIREm4kf+8oR4I/cdSmNmNbItFlJ/pxBr8ykCl9eUmMB?=
 =?us-ascii?Q?z42rFwpSZ/++vKOBN0y73fTCX/f+tIxwrzcLF56ywDCb+0tALKKzHcBDT+JE?=
 =?us-ascii?Q?MMv0Fnf1DZXDI8Q0s18ebqfPWxZpjbFTfixJjuyRJ6uz3S2FCgIVl+42/8k1?=
 =?us-ascii?Q?eekbqWLO0meeVJz2Qu0iYPa1IurfYYDSXpEzb4nK1pDtUTbt/mknpWxiDpCs?=
 =?us-ascii?Q?e6tNdGYMHUeyljo/FydwYKhv/L6afsaIoVsCvoT+LsokGf9GfRRh84LPsiOO?=
 =?us-ascii?Q?OaSZOmbgDLbQ3Oij9XqsLswMa5c7aFWldReRTQR6YJ4bbwQ8pXQxkpTNBOxq?=
 =?us-ascii?Q?A2CLXynBcS32vKX08k4MWcCLOSWxZUqv+shp8Qgb6UpDDQyqhDxdby+IdKeC?=
 =?us-ascii?Q?bTnT08DsZHQVgdsAKw/4txrGP9oZl9sEK+Ba0ZlbxSwOp6Fz7wiFyt1diHVe?=
 =?us-ascii?Q?uBSbieCL3lgK1I/NWFfNtz58uCeOj6U7J9RAC3Rn7EAwqBx2IND8KRWrwLNz?=
 =?us-ascii?Q?CRk9XKFHo7X3Te7ceLW/r77o04FEWLxJGH07w8T9Q8bzO4g/a46NE4jqaBVi?=
 =?us-ascii?Q?hFB+mZrdq0NAeKuXdnQzvhqbJNjUAj3bNQiqKJ2ejWqZkEjjeAHiB74VbHr5?=
 =?us-ascii?Q?fs2KphUG1IO9J1XmvIPnNvmr+wA8I9+1pMY799Ne/znhriyct3p+6snPKtjS?=
 =?us-ascii?Q?1hubzFzMJ9u7t2boJ7obML0sN0p+VvJ4JcCFHtJ9KMuaX6ykQU4ISbUW6ik+?=
 =?us-ascii?Q?g4On+4Gdkun6Stoc6dgkF6z+MOogikhi6H53ZUbXhlI1tV/fVDuetcVh8Rul?=
 =?us-ascii?Q?R8rmPZWq5QFUAhPEONVkW8sLkDhllV72ccHF244Jp94OKE2/uDaFaBkgc5eD?=
 =?us-ascii?Q?HvnROLY8dKMugE2FuYIYfO665bMQbZJJ6i9BdZqge2Dxc1CnSbkPTCGoAJu/?=
 =?us-ascii?Q?sAFfUQbeHVNzj+HtE6PLVTP5q8TwCCsW9HnDKPAjSdbxoLiLVvn32B4Y7yto?=
 =?us-ascii?Q?cL7L43Y5H10wUQqElfO1h4Mvm/i2yb+DEKOJ4XL1uvjZxWXIwcfgCuxFSHiI?=
 =?us-ascii?Q?Gs5Lt0QRbcjd5Fs25B27KAqhPytMDA1RY5335ABAwiUwRw6COQhApUg2Z6Ah?=
 =?us-ascii?Q?reAYpsh3Yc90BVi4BWnUsz7owW39+Fh0rSiOeO6kvNAx+XDSGBI1AFfDHve6?=
 =?us-ascii?Q?lFOvR/3Zi7s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LAmrGjgXeSETncsoqH0CjX7vPDXKd5TQvpHsJ8uHy/9Aa1OjpPpLCrv7dRNw?=
 =?us-ascii?Q?QtVeip5irZhQIJdCYmfk6VLOKyWXBmkwRDQkJPG8KpIvhH+hGZZYoAqG6JRN?=
 =?us-ascii?Q?tbvHzs9RtEElFqnTJtUhX9vKVy7bQx0bwPZgP/L8+9OKVAVOTGB2BmYVZkoy?=
 =?us-ascii?Q?6kiYXiKS3qANlWkg+/Ju+pIo/akmmjdsf3KhRgWYIK7CfHsQIjvkTueG6bPL?=
 =?us-ascii?Q?L1aHu5jcwxP4TE13IS27emCkF0Xoy0o9QsVv6g9PPmJ7JIenTegAX09Q/soN?=
 =?us-ascii?Q?DZcXOUfPVXtRVTc3W08TPfBzc7pny95jeLOOfZcZr5OF7cB46HpqtGppQlKv?=
 =?us-ascii?Q?0ig3Fije5li60saUcYEBfXsIJrB8/n3tgvuQxPkq8ZoMpKbYmfUDtxc8PkOn?=
 =?us-ascii?Q?02UCLdeRWKim9eIeSW5h7lbx/mDy5iK/OVsLHCaCkA43FuPZMoCaTvwhq+DA?=
 =?us-ascii?Q?QQZ6cmPpLpjxwK1Xj1V1XGOXAqwn2NZbfuINH+B2n7xQsbMWpSGDGrKmo/kz?=
 =?us-ascii?Q?So5gFsc1KJH9aigU/+gUY4Ncwdq7KYjCT4FS/QigPxZwocukFxuyjBe0WO2H?=
 =?us-ascii?Q?jR2ApsQpNbBolZwLVc6Ip8HgYC1shBPh5wOe34x1BBJItosUKBs9XStgYv0p?=
 =?us-ascii?Q?nf73aWWRivAMpgXH5t/T0oPNePbFVNxkSl7JIkVxFbKVLN++YLphgDSJC418?=
 =?us-ascii?Q?ezu7US76Czbdu2RVtkAk5o0GswgpyhTtvPzeb0UwbPj5IYh157pzfedDXJSo?=
 =?us-ascii?Q?cUN10yFaOobnmgLrI+b8DgNm9oRLF21mlAzZRvNsO/VMcpMpHS+VAJmz8838?=
 =?us-ascii?Q?KeZRzqIm0ZedXe3XPf08QtpKlV1JCJplkKroI+4FsU64qAwY64Xz5OYuMi8m?=
 =?us-ascii?Q?aZTHZPPjmYuPtnhBiYgO5dmSORbuEOmefQK3LMHLwRPCsf3r1WeiveUG56xt?=
 =?us-ascii?Q?Ak1oZZGs7ZIfZBuwcQxFSSomDCqA4R0ms7ADqRoBS+Wzth9rqfbdmDS+aLOS?=
 =?us-ascii?Q?84TjPg8+s1BnFzpmk/h+UBO6Uq+lfFr5Lc/2yxJuLdkBFsdz/Iphyuht29Zv?=
 =?us-ascii?Q?2u4t7sWzrMCwVXTpXro3Pz9XYshfvrzxaxDWvvCeNQU4IlHSTUT4RxJT5K4N?=
 =?us-ascii?Q?oRSrrIRzYIW2C37YW2kuYEPowPyaayFptoDfuTZCXSFw+4CXeRka9aKHnTFn?=
 =?us-ascii?Q?f04GU4LQH/X+X1M7+z+0cgOXW0WdhQPQfnxN4OZfpYlD/Q+eFOOQCxTmjjMm?=
 =?us-ascii?Q?UNIAwoTbTQ3Zw9P3/F5ajeLmyRT4In3bu2tiQWX1kfC+Ehxt4rWZ2iy0bbTi?=
 =?us-ascii?Q?Ii5J/XFDxR3QcShdDaVI+KjJn7uv3fRcER0MjPEyuVbk79YjZCWvT4CLoXfq?=
 =?us-ascii?Q?Nt1cxsDQ16X/deM1/tji4sTcw1kes2UyABzqi+OWxsavpG153yWvPdV6OFWm?=
 =?us-ascii?Q?hRhKHbJKkfNLYSXKwZf9cHQ+szfoRkhyMTE875ywsUzY0RYI2glVPYvg68Ju?=
 =?us-ascii?Q?P91Avxr/dCsOu2jhK/Iy/g5LU5/Gl2vPyzkzqHDB4qPidSW2ziHWXieN+5eB?=
 =?us-ascii?Q?IuuQ16D04vOQYKuURYBO8B01PeZbsoxCXsAGfePGg9ymUOozYtW5PhxfNXas?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DBBel4idyx/e9PGox6ssEH7tLmVfbYpLEOPmuXGZgkZ8NnlcQ+YdpnAhUdutrYgpwKohR31LSK5ihQ01RKCDbstrW3ziCQNSn0dRtqMjHpXZ2eVp18WrnKViJTke6zX9XW5fKVO/l8DAzuhtr2OY6LHBWGz/6DI3nw8/ZCsfrbLXfa9bJHVApUpZKiacjlkWJxpgSPavujrHLBQ7xWzO4YL39F7ZOC2RNRcqT/rE44oi7x92S5GRTg9F/kMJHrtOBjmxtYsko8zCE2izeHdLp7ieM8gCXTPT+YZFLhA8G8+xBizor02yy7PCx9UJgDrctzpxh6H5ZbEkZnqHJjH5yFrlL8+GN36IaNdGNV552xNVMkuFEDgry67TNJpG2CaRFmDiWF/f2Y2Gmq1TsKZmJ4UPF1laz/F7FFWbF4phcdbCUZfGugl+HTtlpb0GFV0968Zqm72pIjVSM1YTNl4Z8pkavDAzaUFf11wwz00a5+HF4TAB2gLIkCLA6W/EKBma93H7/i4jr4ZRdNQn3IlzCo8t1a239OmaOv5dOjtG9UuPPR6qnXBJ3zpa4AX42wL0HGkUhQOCMldg3yC6lyHIRSPje8EU0qcdYFkyYMCN4oY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8629762-9c13-41ae-2ca2-08dde4aa14eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:08:50.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EP01tXiyE5Yi4t9mZ7PaEs01FLWtlZgyoVz4DsDcz8webTdAO1lhoPz8EVjDDLkoWIqI7nsYNrLpV1L8pmIHRpOH7MFAf5W2+uLAlAs3ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260124
X-Proofpoint-GUID: mVKmJ-G9K1yMc95D2yy_dS3vEWzegkE9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX8pJ49HQ9R3VY
 Sq0Unwr6RGsmuW74FaQ5yaK2fSmptPuKDbBThBMcY7PCPhxZAlcYMlmNLlUuScp9/65riu8/Wo0
 ZmeIvtI/AWqmeR+eyjsbvlhK1mFCXhXLpY3Xng/t3GpJFppykqVkZGUpy/hUxa2Xr3vXpxsaxB5
 Y2huuqsuVI8UGHxHxyCQYdHCAZ59eLF0wyzc64S0TuLFo7TtW34rRY7a5zphx9jQ5Nlaf2SP99y
 8v8eoJSEm6oixS0afYs95AEgB10hlbnbWKoSCiwjGvcRPKOT2CDPABhVAhC7iX5e2d3eqXn1ItW
 vjPDJ3bOfZjmGYg42Kbk7vJmM2AuTdMap0uk5yFoyQA8RLutw5rKiG5voMMa7DUQ6c/UJgcfIyW
 brBogHy/
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68adbff7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TTuu5njfDaThCkTwWdcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: mVKmJ-G9K1yMc95D2yy_dS3vEWzegkE9

Hi Andrew,

Quick fix-patch to use BIT() in favour of _BITUL() as requested by David,
since this is a far more sensible way of generating a bitmask.

Thanks, Lorenzo

----8<----
From 83a10e3fe7dbbc7ab7c04312fff32b28787acf9b Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 26 Aug 2025 15:01:18 +0100
Subject: [PATCH] mm: prefer BIT() to _BITUL()

BIT() does the same thing, and is defined in actual linux headers rather
than a uapi header.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_types.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3affc6a9e279..c3d40fddfb60 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1755,7 +1755,7 @@ enum {
  * the modes are SUID_DUMP_* defined in linux/sched/coredump.h
  */
 #define MMF_DUMPABLE_BITS 2
-#define MMF_DUMPABLE_MASK (_BITUL(MMF_DUMPABLE_BITS) - 1)
+#define MMF_DUMPABLE_MASK (BIT(MMF_DUMPABLE_BITS) - 1)
 /* coredump filter bits */
 #define MMF_DUMP_ANON_PRIVATE	2
 #define MMF_DUMP_ANON_SHARED	3
@@ -1770,13 +1770,13 @@ enum {
 #define MMF_DUMP_FILTER_SHIFT	MMF_DUMPABLE_BITS
 #define MMF_DUMP_FILTER_BITS	9
 #define MMF_DUMP_FILTER_MASK \
-	((_BITUL(MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
+	((BIT(MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
 #define MMF_DUMP_FILTER_DEFAULT \
-	(_BITUL(MMF_DUMP_ANON_PRIVATE) | _BITUL(MMF_DUMP_ANON_SHARED) | \
-	 _BITUL(MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
+	(BIT(MMF_DUMP_ANON_PRIVATE) | BIT(MMF_DUMP_ANON_SHARED) | \
+	 BIT(MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)

 #ifdef CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS
-# define MMF_DUMP_MASK_DEFAULT_ELF	_BITUL(MMF_DUMP_ELF_HEADERS)
+# define MMF_DUMP_MASK_DEFAULT_ELF	BIT(MMF_DUMP_ELF_HEADERS)
 #else
 # define MMF_DUMP_MASK_DEFAULT_ELF	0
 #endif
@@ -1796,7 +1796,7 @@ enum {
 #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
 #define MMF_HUGE_ZERO_FOLIO	23      /* mm has ever used the global huge zero folio */
 #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
-#define MMF_DISABLE_THP_MASK	_BITUL(MMF_DISABLE_THP)
+#define MMF_DISABLE_THP_MASK	BIT(MMF_DISABLE_THP)
 #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
 #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
 /*
@@ -1809,15 +1809,15 @@ enum {
 #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */

 #define MMF_HAS_MDWE		28
-#define MMF_HAS_MDWE_MASK	_BITUL(MMF_HAS_MDWE)
+#define MMF_HAS_MDWE_MASK	BIT(MMF_HAS_MDWE)

 #define MMF_HAS_MDWE_NO_INHERIT	29

 #define MMF_VM_MERGE_ANY	30
-#define MMF_VM_MERGE_ANY_MASK	_BITUL(MMF_VM_MERGE_ANY)
+#define MMF_VM_MERGE_ANY_MASK	BIT(MMF_VM_MERGE_ANY)

 #define MMF_TOPDOWN		31	/* mm searches top down by default */
-#define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
+#define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)

 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
--
2.50.1

