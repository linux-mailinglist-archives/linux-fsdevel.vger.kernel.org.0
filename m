Return-Path: <linux-fsdevel+bounces-61875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02738B7D806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF0D2A6EBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 05:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EAF246799;
	Wed, 17 Sep 2025 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SPbx8TDb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EB1HEFt5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E5523A;
	Wed, 17 Sep 2025 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086248; cv=fail; b=RVuFMZU0Fkf+0n6Gbfhmxvgcte9pHmkDzov7rwfTcKHhxLOi8eKc5BxR9JbrgZuLpPaBnkWz1MWbqnpxGh5/wLvNfUuMb9iZvGR4+7RAI9O16nrp7JoAayRoGYS0/5TTi/X4ypidbjl+lpq6xYFP9zwRbT5AcIMrVBroP8ppzB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086248; c=relaxed/simple;
	bh=vKCe21w8w69Y/V/tMROZhwrGy3TGrCDJ10+f3ZrG3pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWH99fbPuW5h/y46sDb8pS6L8O1wKe0MdLsQBace9Mfrrbqaao0+NzsE6p0tGVt3wuLzjRq++BtX1UxdUHc9uw5dtMpsL/8IPtFrVdxkEsm/9o9vYG2L9XGwL2Mkf+weWru8XXGEhlC+U/D3+J0P9KopBzgAH9lxj6qAAFt5wVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SPbx8TDb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EB1HEFt5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLYwuQ020120;
	Wed, 17 Sep 2025 05:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=m4lJxhmyQe2G2EvosB
	pECFmJtxADMg8LZGtkhjyg1eM=; b=SPbx8TDbsYOdvE8thHsn6xWKZNsHp+qviJ
	O8foTYfx7zQEMxbzxMpSYlqUfr2FA1IyLrxBljTcVPNr4bioMdmC5/ms91fi1DVh
	AfGvYIJzK2sAdqCPWZFC2+lPM7sUS119GTsp8w2/K1DYgV9ZNah+ZQAJoapdAuvA
	Ur08uaQ371QienZGxEGV9GR6Lyq+PkeJ57xfigg0Fg+Zc/GU90I7UCN8fhq10GZG
	3tG6cHjzHZH6YNXmMW2GSprsY+2ivOxDPuhulhh5g+qoRrwgKib6P3wSRZPh/rBj
	9oLowoH5NGAdB0iJEs+cIRSxY0ia7WaxDci19JXlRTPVAB9/HW3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbrds1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 05:16:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58H4kQas033754;
	Wed, 17 Sep 2025 05:16:44 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2d8v4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 05:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR1kb0mX0c3mdglvdBMb4ANa3P2QLIQKzSz5jjJ7E5FBOI6fQ+1zN4MRrvdu0arLsvvJb0MWVsZ/d9gTW/WnoGecrP/6f+HUcWXxU0Y0bTFZKKYMbr9n+TLDVqycUiyAx3ElsGzZIie4JRwN9QKydOzPFoRfFUMK33YwL9bpsYJhy4cBo1wBV9aM7aExriUlFmxQ/Ny381oVsEsh+tmKPAPr2th270u110za2Rx119yMaFNCrQhh2BfkSI3XzQvcgqQWhXdJc8CTWaxBRaY/dv4Me/h3WsyMEFtXny8XnxNeV22j+hI63ZTu4z8Rp4vxmijYuABhcfWQhRA9Ok5zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4lJxhmyQe2G2EvosBpECFmJtxADMg8LZGtkhjyg1eM=;
 b=obJ6fMY9+13goaENcGEV8ALHQ1j2j/qED+edGkPifskLWliEG0W5pszWfIsDf9E0A5jkPIDq8eZ8rVHosEWgo9za4okEd0p//+cXgw3eRZMLYLLmK4/TirkRGJJ177qCgAXoPNNTyKmRq20QgbmYp5b5Xmpv+iJnuqG2Rbv6Z0b1j0ZpaBMbxlFneLZObtTgP6D5wW+aYUJ0+vilZXZb0Bky4pJHAyELx1draLO7y8CYRd2GFHgx5hKb2nd3IRNzTQr2Iq7KHuXOkQMlsE2SwJZppBdK3lqEgSfdAoxK1nyWhqH1Q6Ly9Hf/l1KMzDTHG6JOZv6+L5CnOMcoWYZSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4lJxhmyQe2G2EvosBpECFmJtxADMg8LZGtkhjyg1eM=;
 b=EB1HEFt5ZikZYDJBmuIiMyG8jdK0xuImyLvNB3rIFKKO6ROdTKlGKxISpTEfgrJ2J35SnBzZc13f3TsezqKzNFv1l4QkisVPc98YDggaItCVNBmo0wL/1tO3Db0yRBL5RP2D1OSuhWv2jNrCezLluwUuEYQGb77Yh3WpUTUTyT4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6358.namprd10.prod.outlook.com (2603:10b6:510:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 05:16:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 05:16:39 +0000
Date: Wed, 17 Sep 2025 06:16:37 +0100
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
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Message-ID: <3b7f0faf-4dbc-4d67-8a71-752fbcdf0906@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0347.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d3d0c7-e325-4492-d1e2-08ddf5a9617b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7T/kJCuXngClaLWkHlKCzxd2MYreTal/bO1WgwmkrMWAZ2NJrK8qCeNY+kDW?=
 =?us-ascii?Q?8kXRsaqLbfy/RfcOhPW6IbwLM96EWXWk5w89KRSzuXjPmtQ1qSS0mpN6llnH?=
 =?us-ascii?Q?y6Us5nYomULyHxvW3rCPSMSwd3VEVjulQWE+Py2hu0aWUUvC10EMCNcwJps1?=
 =?us-ascii?Q?P+IkYNqR4cPDfE8Fk3cjKU8XOnnY+DT7s0LQvBoz6f2GcRWB1PILc4titaqK?=
 =?us-ascii?Q?/UuLVF0PrgBrBQ6IQg3Tq7Douzw4GaDN+Jtj9UHBKmtpeAeC4Ke4pno55TiU?=
 =?us-ascii?Q?hmlGkfkRYusOIHHSZFGacLS+f7vmhIE7kGiwRUhkkCgNhfSoI2oy50mJE6gy?=
 =?us-ascii?Q?eIfxViG5JlB/e1BwUkYzClmUllh5KqVkZpZp09s3zU/mJXDBW2kKc2WsNwa7?=
 =?us-ascii?Q?zU8xd7SZ3WgvVzRqyFWzYWB1/tybNmNjYbuwuwXYKe68P5N07c3ZOyb6hmCm?=
 =?us-ascii?Q?Y2qbZORARU9V0Q9J5zKZknOs4lpuYLArXDLzqX+Y1YenvxbHwsJUd3KxeUl1?=
 =?us-ascii?Q?Ah7+CLvdCvNOTr48p5RS4veKO/CpxmS7q8e0WAluHbzJX/fumwYfAwAQ4AcZ?=
 =?us-ascii?Q?9OrBC6/8Zm7xApQktR2h8lcpDzgN9TfGnKviB21jpfoVc+EBcP5znZgJI1xQ?=
 =?us-ascii?Q?FCneP3VvG+wpqSa3bDNqnnLpnRUiFC6Tb/RenHVPFoOcTZ8uV20r41IpNwZ2?=
 =?us-ascii?Q?sFr1g+TZOfC73lhYQWewBDbha4IyWqhTjEn6YfV0H6fPnOk7wGwRvRdY1T8T?=
 =?us-ascii?Q?K1gkRLkNHx/n9zXDOAOiTNoOe2lCexvs7LbgLSwTD/9FdEye2aYTwLlQx1wB?=
 =?us-ascii?Q?PJJ+MBf8Ev9kxebTsA3gP9wfhYAHZJCgefytOOM7grTVwnsuJMojH7p8pLxk?=
 =?us-ascii?Q?mMKDKjWhymghIN36Ex2WGNoZ6uHoWxTOK7CD16Cd2Xg2jKxkZF6WlKnzbqZz?=
 =?us-ascii?Q?i4xWJCODc3eSJ770aGxF9jP6dh3gfkO8U+m8TdVw46daluKq/WLfOHbsepRV?=
 =?us-ascii?Q?4oaa8AWKDQJrVEJHgmmSGWACNLIhUyX9ffL9tE1ygFD3Zn6Y6oQHWdy2yNsp?=
 =?us-ascii?Q?HW3Jnc9SxD5o7uz8qnnmRrP4rjRB6naSxIVFAtG+P72/K1Ws9+SxHZ6vRlPH?=
 =?us-ascii?Q?dgNe2zxJHgew1neBKyKcrpn9hEbbfP1ENlUKKQt5VwgIDpt8ihGib0fTa4cn?=
 =?us-ascii?Q?FdEh1u/dSFsRG36M+s/vxbSF9ULxInoHGQmIgGl2GobZcT/7bwcNVlB/KAkG?=
 =?us-ascii?Q?WnJ4mEnVbXCyI/Ngg0Bi763liEWPB1pB3+Xy4NdgD16pbU2oMlKu3Kv2snLd?=
 =?us-ascii?Q?VGCbbc7tWGg2cxVUkz3pH5hggK/XRARiEwlSVJWVTGuSFC74Ru0FJGzrxfYn?=
 =?us-ascii?Q?bIbOH0yZcc+JrMuXCkEHk6LhUSmT6trvLcSpYhqSWh28iF8ykHuvvL4N9d7c?=
 =?us-ascii?Q?Mw75dN/IRpw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByYUys4OsuaxoHkYUh58yTrAXQDXG1iMuz+PPxEMb3OYAQ6D+y6CDA+gkXLq?=
 =?us-ascii?Q?IScGwqUibIUTnZ4QLo6BmIGeeFE/mfTk+WvFnn5/O4Ku1LR0XZ/bklOsubPg?=
 =?us-ascii?Q?Fo/HG2QcorKkpaU6XhYfedgfOHFuPO85YF38EMmWFIMBkDA2ggNnmCOaNQ9B?=
 =?us-ascii?Q?YGQyCUqtdpHlZcTC+2M57RZpEuot/e8LWHsREPhE16waS/xc39H31i/TMNPO?=
 =?us-ascii?Q?ArbZuVzu0nYqB9cqg/7bO8Vm57RW2nG/H1mvcLqilw8ZB2adyCC+Kt2GiX3N?=
 =?us-ascii?Q?h5/55gspQec+kqP3zZLnZdom6ypHrv1dcV93SABZya5oQqQXb7S2T9iT2zE6?=
 =?us-ascii?Q?EnqFVvTRh4Gi+IjVp+kBTTjQY4LJlahhrlcR97cDtJb0tHdtbtnL2ZZA2c6+?=
 =?us-ascii?Q?dBmyWrJ7lAUjamBFTCs1g5AkHhY9wm1cdcFL1C+5TsvyPTGLaPMrJyTzfwsv?=
 =?us-ascii?Q?y/g1ZczJd37Ci4cTlTk/d45wbp2OQRhgfvVgQHI0qhYIL5H1FVd8SpGdI9kW?=
 =?us-ascii?Q?zAtQjLbRsPH/+QqtPgFDi8m+jhmx6DdXFuPLOm0ZS0F1Sc7PYpb6Zu+Zz226?=
 =?us-ascii?Q?LEfaqqYF1eSxUJiJbDYMlK7u/FQwU1B3OqHp9fqynCZN9IOJWoJVdJljv1rN?=
 =?us-ascii?Q?KHQSy6dh/UcAMClNL9exf2ocj47a+TSDiovFErIoJt5CKupMHbWhXOy7Aoen?=
 =?us-ascii?Q?1uhNwgYwptu8d+Ui5WxBbY6v0egZx6/SgXD7jh8kJmZGkiI+Jxg+anj2cOIJ?=
 =?us-ascii?Q?T16gxnUqFRnOBpx1Ci6+hBTeANfDJbJt+DB4nqskEJcohXeRwNEBvURHYJvX?=
 =?us-ascii?Q?uwY3I72R8K1ny+sV+Lk3/UjAbWpV27JJXd6tkwZduEtRxLnEy6FpooECB5s8?=
 =?us-ascii?Q?1saObTUcz2vkgWTcQDhXcJDZ8E7BerDDLQbisUxtVvjvZmxsPfw9m9XqHPov?=
 =?us-ascii?Q?76A+Hp+l2hZ5TT0/PRsNHRXNS+YilVLsX2qbEglNzxGeMXP+NBN+l7iZR2oL?=
 =?us-ascii?Q?Knqr6qUTsKEnFbAgwc7DIXhpdOLjet0UABLycYRh/rP2aEaIWMEDteOdibb8?=
 =?us-ascii?Q?vd90/QEqsVmKcPaQRHfZtiJOdB4a5EFPWBZxtxsVyh52ZOgTfnT8bMcRs1pA?=
 =?us-ascii?Q?smyV32LraDG9YS5cvG5DPtEbuvFTeSh/S+KLG5RQuxJ4qPTrqBJGrEyMTHuP?=
 =?us-ascii?Q?oVvYN0mqYpEQqPzeB3wMwMMptJ3xYEPBotg/KzAZzHcufZe/yoHchKRJDgeF?=
 =?us-ascii?Q?WOn4HKq9VAftKMvr2+MnABoWyPtvgrYz31/jzt4trKLDi+8ctdGiJU4GgLxA?=
 =?us-ascii?Q?rQpyBvutmz4uUdve4nZ9cLPh9EJJSNpa5XbNonJJouo62raJTH7HQVi6SIXl?=
 =?us-ascii?Q?bLogZwb6FFnisEcya3Y4B6lo4c548u0Bb7nF4zIaa/lipR3wMKm/1DR6yLyg?=
 =?us-ascii?Q?vIHTz+wtwpy2dvzg5yT/2StIdvjv1twuU995fS2fPhgxtJqfvHoqtsTVx0A8?=
 =?us-ascii?Q?avlYbPigJCk+d0JhBCpq/f8KkDGkeFGd6sWiGmx4HJdFPvDmvRvYaYcloygM?=
 =?us-ascii?Q?vtgHC89pZ0BWNwXgBiLFrWSKSXbChXTDISjGp5YSLrAizLBGc48M7KVt6bN1?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zAl7kH9FMr3pWzstIBL6QJztP/JIeWxVy8klCVFlNFSPLp7kdl9JOcK9RZXEdyUwRBBExV2qm/YowKV6Mm+1NyUk8x72zGB2X7s9no601MAJ+QdAqb23Sy30z8jFgXuq3eiZck9O49f9YqK1995PVwpCWHACPdGQCoilkb8neMVhrt3I40/U085CWZgNWo9AMsZxNrxmeQRVRDDjNBtH9V/Uh2Mk/YtFsJf1XM5HS/aRGhIuJAuGgW/U2errevi0w+NmxRbd8+ep2zRGpdi2ivx4kvCil2jIcVevnDiqOR7ecKsfnGLJeCDmD/jEW/H5QsHzJ9rR7A51AWwhU///QRigvjvLHsaaX0DbzQDSdR5DIWAV7X+OrMGv7IQypsmo903VKi6yBiOmFgyPtfoor1Pe4fs3LgKFdCcS+HHQLOd1Pm6T3ybXiNdUZYWjeovJjxWzi2NV2ddJP/JYwBJ0boC/oiAfP+txA933u0MSS875eJw7IqCVH/NWbI9jgZtlGnaTHUutdOVtPEdWnG8Y6UdJK6hdypCTB7ymdBCC6+fQ/WpK73FkyPoUMOtBVr/0FW2a4CA/Ggh3QjeEsd5IH4hTLBjlnHtiPIMMN0afI9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d3d0c7-e325-4492-d1e2-08ddf5a9617b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 05:16:39.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgIaKh5pnLbwykRHbjaBwBtNQqGGrhVMusEGegPLouek0bD4FcrTjpmMa4iaNsRput0c1i2e/pKDi8Jvi8w7MuXb7zzzoBgqodU7v3Fre9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170049
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+RHP2ObnT1AZ
 /Oomu2uH2qUnFV2fk6vBtdpeLz6Aqvyt4xsfHsS3tTJbx3SilFucJ2Ejpr5E7WYdNYgTOZy12O6
 QLnZBx6ryfWAMgxKydP0NQIf+SOpejLB2Q7q/6cM/zgKXiinwv5MDBsW8jkSCzLmBj8rshoInIh
 Z22Ct4z7q4i67j2B5P/thVIAyj6nrl4Dan7XFFWFGnB2hK4ZZGfat0KWQSl8EVIAz4GpsnaibD7
 Gyu3AiLodf21+jGyB3Tyep4WHYnBYSGdSSLuwrbKylgVF+Bz8uzuXK4DCZjEuOgtInEUvCYppBw
 4WGBrvRcen8/IVUCiuVbiRFxbkdJH479C/AiKRonkZauqdO1XMSkSuja0L3ogMzOStlqX7P5gYQ
 6upCfO48
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68ca443c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wsz0gEWpSORBqcSUAyYA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: xdRkcANgaKSurmVzaG4WL892wI0pAejL
X-Proofpoint-ORIG-GUID: xdRkcANgaKSurmVzaG4WL892wI0pAejL

Hi Andrew,

Please apply the below fixpatch to account for an accidentally inverted check.

Thanks, Lorenzo

----8<----
From e5a04f488d2f5bc7e94003ffa586e01fa76b39c1 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 17 Sep 2025 06:15:31 +0100
Subject: [PATCH] fix missing !

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 17650f0b516e..a2c96e625618 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	* Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
 	* possible change in exit_mmap is seen
 	*/
-	if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
+	if (!mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
 		ret = -EAGAIN;
 	mmap_read_unlock(mm);

--
2.51.0

