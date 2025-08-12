Return-Path: <linux-fsdevel+bounces-57519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6EB22C0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CEA503F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C930E83F;
	Tue, 12 Aug 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UD4lqSx3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bfKZ5V7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53830E82A;
	Tue, 12 Aug 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013704; cv=fail; b=cteljDLK3xXv72PZZSpmF4uxBjYAIPQrOMs0D6o7EGANvPFhXWTwLUwaLAGgA1dmwEEPcCaO1a6PMMYhAwNzkd6nxVPxWyUZsSphJm2Pp8RoiMo4QrJk1qKLdsud4zb6+SjjwEqJutcmlZVdUwcIoz2W6vCUeDuL4YSVVFNXIRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013704; c=relaxed/simple;
	bh=yTkbJuRXZcOD2jeOPKx7mjnGXgLx4st9gMllfroTFg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fu/RTVk31x8xPef0jxhpVxANw402Du5zkITUGvscSnpBd+fGvQuG76eUSp+Nfv94R/50tzN0rC8nD3LPnpetOmounrceMg4sDPIiByFtpRwxW0vVajUZyWIOR1P6e1G2YZyXMrEL1AHyn/OBFFVsJHaROHqsNmjG36YuaNxCJWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UD4lqSx3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bfKZ5V7L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBwIp012373;
	Tue, 12 Aug 2025 15:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JwNnwgB6+dl8aPL3GOfeh1k1dY8JCAuFZYHk4vJh5UQ=; b=
	UD4lqSx3/JYN85kkHIvMtlhfdpIyBpsutyV8TtfFNtDwjbiWRXRj3B6qwptX9zDp
	CNyVWYBpaaHboVNYIZe2O9nyOUFKfbEayav5iRek3nUF1Lzc7Ino68vXwLDg2rc1
	2WiWq//rQgq8RqYdhIUlDWCcdfzl8YHUQd7N3O6g2SozEbB4AlPI4gQAFCIvhBbp
	K14u7BJgFgUOaj6YwfA2hTpPAKMAPMrB19eNBP02sGqJ54dEtE2or8F6nGSr1JLP
	IbNRNqwpmEvxfvbYFiEhyswt6k+1EdnC/kDQvotTPYZHclDYkmhJFNEgrU2aJ8Zs
	tA4X/37keyzHN+sodWuJVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44w2u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFiZln017414;
	Tue, 12 Aug 2025 15:47:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa4y3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kU+ue57x4YBQiZThU6CyyBG7dLmw6OxmjF1hMxwgIx1fta2fB0zhvGA43UN/r4SG4TtIp9g3a/egD3oz1XJBtFfIl21eMLi6o1ZY3Bs7eoDLiGKsUj/2mmAEOXI566nKxXDEVPKRWM8RH8vWycL6RKEIIokHRNShfNAyARRB0DvVroq7IS7eUs+VK6kSDBYQSNqdbxN3j6uBila8z9xfD99LcgiuEI6THrLH1ETwh0NR053HykfE+IS4SEZ19mhW/dLRlCvkqrsPqoK+w36clguor0bdyX3dpfsKMtggDNeCBQe2LIFB65beyBTqLFDeGAKnscmkqf57jjbcV5VUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwNnwgB6+dl8aPL3GOfeh1k1dY8JCAuFZYHk4vJh5UQ=;
 b=ua6v4ZWwQaVXNGfkiqWUT1KmyBALLjmVf2IOmac/ZeAKiS+shU3ihVzAooqPIp9ndg8XauLe96qZzy5dnBo/x/wtarhNrMriMAkkdqtMY8Qd2suk+u/0/OAc3NpHDZhcZhbHGXfQ8Y5sp379XusWsDZIgmKHMgIiwarBQf+/5UdvouGubonlo9i8VwM4DYeNVP90tWZVoaKmsvnWziFO491QMb12TyWUc90pBavQAI2rz9shiLXElNGg4o5UfK40PwtLm5wl3fvTGBbHWY0LTDBHfLZGk9CaUeFAsv9K3BxNtFACh5xoCreqQk9eViONmQeO/yhm2dIknOm4OOEJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwNnwgB6+dl8aPL3GOfeh1k1dY8JCAuFZYHk4vJh5UQ=;
 b=bfKZ5V7LKlN5MaCzM/V5DNi1aW4HZOwBlXlesQ8rjezu3DLf99WzeXcColVzoptnz0GuixUO3rdhojiNb2rK31vmRtaoMEJ2nGNUlMA4yq0ahLT2jMop6Dayvmxp+IC2Afk9fb2jy2Z5VEXqTRo5SJqBrPuZiodtAZ0NHFF+JdQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6329.namprd10.prod.outlook.com (2603:10b6:806:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 15:47:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:47:36 +0000
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
Subject: [PATCH 03/10] mm: convert prctl to mm_flags_*() accessors
Date: Tue, 12 Aug 2025 16:44:12 +0100
Message-ID: <b64f07b94822d02beb88d0d21a6a85f9ee45fc69.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00003841.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 95effaa6-a12e-4195-71c9-08ddd9b78f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6u09RjgNCgrxDltYBA33q/jfIiEZuLvzpyjrU7fZ6xHncu78aSvd3Bs503ic?=
 =?us-ascii?Q?rujq4e+wTvq2ESrc5YgSIHX8ZEa63El0cpJ/G70Aw0C9XmyYTOEuMBd7JC9o?=
 =?us-ascii?Q?C3rz2g+QkU06ZXVpdLExm5MZdYoC0KEFZwtzSilhMvw4xKsAP+HXzIMlWfhY?=
 =?us-ascii?Q?zV3js2JJK5k9ePh1uC74q0XKJzD9jgg6OQf2FBVrPw1K8o8OGe3DQS+YuZzF?=
 =?us-ascii?Q?RumjsM3+VsO7Wda1qsFH3vAEiD1NAotdRabWlT3webYJASzrs1VQfikhWSsB?=
 =?us-ascii?Q?Rswx3Fwlzn0W8OfzpZW2q0kDJuzwZmIZK+5Kejv59EwwoSYBpxCEYTgOAvJE?=
 =?us-ascii?Q?UmXWskp8U9077Wqe7g1M+65NA056NqhnFk+m8rYX23j7gBWdGcdUZBNZf7Cs?=
 =?us-ascii?Q?bgUp1xDHNFloNMKxtytlhgHEUSj+NtKpbOUgQb89R3L3/drfLI/BCbtRLUSr?=
 =?us-ascii?Q?TQWLsakOFCIF+cTq2LhHGFdjjYnSiULPgywGWSS7OzRYrzV3JansqLLj3ZAr?=
 =?us-ascii?Q?4tW8D7KVqZ7oXYxx6kn2TloUr6x2zbvPq6GVlJQQskFor31fU+LcLgMI7yVf?=
 =?us-ascii?Q?pKzLSLAEuJyvZrTa4T/ieOuWOi5jmrxgb6liGattVvhE8r9XZTHX3x3m0ZBU?=
 =?us-ascii?Q?RTR8m2jbmTHM9hLozP1JUQNNLDL1zSUA5JzkDepUnobcy1dBCbpJbeI0E6Yy?=
 =?us-ascii?Q?w0hdxfMDMy0B4hMHdqdaChVILVhxjP2t4Z88bHUfTYmQriUZe/qqm2gz2dML?=
 =?us-ascii?Q?Gxci30lzivyJN7eTT5HFd2vDeekK8GEg2b2UPVAg6vZ/0gQPljVFua8nOEMA?=
 =?us-ascii?Q?h/1XsI8oJi2SdsF5a1MaQrKAk74qP5Ua1OgFr1a2KC9ka+aP7kTyDfq6NfI/?=
 =?us-ascii?Q?Va6exw6/goQETe3RnbYv6VPWCpu/HZXhmvs8201qndrGnPoUHFydqWoqUGNC?=
 =?us-ascii?Q?0Dr7gJG6KE6C54sW5YfHAER2AwBUaNDtckBGUsx/X2leqElbzMHLRlxqL8o9?=
 =?us-ascii?Q?zdafJdQ3j2T3b2prvlewxk8LKzSp1RbioH2D5guOHfx+HdoY9ElRIuPc0D9+?=
 =?us-ascii?Q?0IVNA81pWwAL4e/MWXmUtdxp7kXaeiwqLEsk/uvMUizbwjf1zfCo27TR8meh?=
 =?us-ascii?Q?z1NAg0yTqZPX0o5zO7JP/tz82TaslSzuLsAe+gynklV0yU8WUlE89vFuhF7n?=
 =?us-ascii?Q?W1kJkEqpKm4sZva7sgCGExtsManvOfMuBXIrb5+0UGEfYd69vJ3JSm9o97Lg?=
 =?us-ascii?Q?GIHpfAqvHN987er/klfjYHbRY8K+sL0wE0Q7rWbYNuYrrnDL/LLA9eyYY064?=
 =?us-ascii?Q?/Ik5fmp/pbISXG5AAu9AQ76eb+BGQJZe26MZtGnyxCab4uQf/eVgd8y3U+ce?=
 =?us-ascii?Q?a6hxg4PQUQ8dytj/1hZdUkHrNoc3gE42cJZbSEYfOYuC61XFmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f2KbOb21PtjJlkewAenJiIdBAtWtc8/u5UsLQA6tGZvXdoODIcbBPjpfuxWP?=
 =?us-ascii?Q?jyNRQ2ZDsCKinwl/CEHB3MJZbbX6wRruNwPdO9TGo/oZY9NgTyjbzsNlWoti?=
 =?us-ascii?Q?+xmukOq1+INnMUGBikeQzFszWIs4XyF8vVaA6k3s1Qt0vPIIK26cxNnrquhV?=
 =?us-ascii?Q?/87xHOd/aOu53LEzyWwlpJRRbbk/Ar7kKYacNBsmrTr0ckDJJLynCJMMz7Vi?=
 =?us-ascii?Q?R8PyYe6hlzRn67FqqgP5DT9nXwHSHwnzsCBGEyftWHO9uKm29IW4yRJ7Jka2?=
 =?us-ascii?Q?YMlHGouD4XfykhjEmnAO4D2mCnQJUjleMGAF4A3ZWgMxOtBXr0S3sXSdOriE?=
 =?us-ascii?Q?NRhyu6nZ/DOrkUublOPS5KoMH9yV14dj129whWt0OpbAN1FBkTiz4bBrk6tS?=
 =?us-ascii?Q?+40i0/XPH3hCizKTpPHG604OFwBKddz1KQVMTCxutjdOT+Xw/TjYR8Q6QOKj?=
 =?us-ascii?Q?Ayj3RZrbsG3huaubIDzP0xTBePgAAI0EEMP7HX7VTMgJ0r4DzDoxOSbrsOYU?=
 =?us-ascii?Q?BCPJrDe4MxNttfo2TG5LsFWLvCA/d/ru0cLWZDfof7mUig/b5e9GagbckTmY?=
 =?us-ascii?Q?A8Yc0rlD7LrEIbPMx0n8rs/gqGFqQ9afZijZo6Dl0Cb9ZTmm5BCL2vVelWwd?=
 =?us-ascii?Q?nWzGq4Pl5eO2zjZKMxW1vW0C2BvVG+lfO60AB75DPopCSeCUHwrkvf3j7a05?=
 =?us-ascii?Q?lEJhTbKBhdCjCVZ4Be2XsVM3bjXP4FYHZjdXc+p4GDg/A8f7JmaqTdw6x+IY?=
 =?us-ascii?Q?kwLSXz+IkDh8INCjT7Pk7MnsVE+PWwMCjx42hbFSZjP2PR1u0tBTFMlAR8dD?=
 =?us-ascii?Q?g6MbYcsWENLgRcSw0KJXUSsiSVd9baECj7TLP2aCRBzyqJB0JZt949R4pE9+?=
 =?us-ascii?Q?86ieJRREvAZk8LKWCuwqe+FRXWcysnnPaC6jDWDG3MUrgX1BMtZJ0FdGnAnR?=
 =?us-ascii?Q?K5wsoJz9sQAd8Lt68SQbfmMozm/ZvuJ7kpjmjvPf56lr2nywaA5YdtOSY+TA?=
 =?us-ascii?Q?u6RvQ+d8rUQBWv5datAon0Yfuq+MYu27+eUeQirkcDgNwR0T4Ul+qexl1rOx?=
 =?us-ascii?Q?/4JYrWvr+SVLJ5qt2CuYXjuxXmSNLZAYD42bBd3sh8FiIfoxV0TyHH3PfqR7?=
 =?us-ascii?Q?cYtTvVePxqcX1pAIW1LomqdxK0HZ95ITuNgMucQmhGdukccA6MMZAu/hPNmA?=
 =?us-ascii?Q?kt3LfYPJe3U/tw2bQjMO0DtaMUcmeMneH5DP8ly0LLspKlOn4sjFGQ/oQQMH?=
 =?us-ascii?Q?vJ6Sp9keV3NAFvATez6m1TocKp00OGceRT+OfWXNqxV+/3Q4xTQr8W3m7O18?=
 =?us-ascii?Q?jc3+dmL/iGKT8K0P4cd0mNb2SB+Z+VZuFgkYu/Omd4zZPLDDV0kaSlmvTS05?=
 =?us-ascii?Q?9BV4faRiyxT7bu1yYxOufQLlX2sUIXL04HQkbYr4wwh3Fccltgzr+UhM3Iud?=
 =?us-ascii?Q?bDqPDQ7GMWEeeQe6aWQnJ3OmWt7FQhYSHLECuW5p/v4PKLNXRJOyVd4VDyUJ?=
 =?us-ascii?Q?svw67uScfQwzi7JYdMDAsKx3l2vk/HKNBbsqM3KzqTmbuXk3Wmg04osG72IM?=
 =?us-ascii?Q?u3fymcqArBQqU1oV23Tyfaqa40xnoXyV1QEy+DLg3nHq/XLMbBn+ED3rmksv?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lriGhU7Hu2gui1lQ0sYB/CS72eV6wjzC5n/qjaNOoxxrmYXK9NHFAVKMIq2IHqOXgg83nhI8B/8lmH5ZV1P7xiD1PGXTGw3+2LXjmDbTfd/IIv1eHWV1TIcC55XRDI4fDE6xcx19+yShjGyNHKah7HBxO7MADIlJn300/H98Aa9dhMoOFr3uoxHh09YYH8HrGIl+W2lS/grjc89URmeCEvndak6dLD0Z2nqhJtdauuQtDNYkJsSpUdQSU1UGy2xOrWuZvpsr6rY3Mygw9nTXpzdH3yeBgsNnOw/1cIfCbtZVuay+UlVqcE9fYnA+yyoNPU+M0t77TU6lR9UR14+DBbxs+XDp+nlJprLRd05wee3sx8JtiUgsvBd6qOHcUBCgrPBWzcoy+N3HBUGGgPgpd/D1JMfdBDAtkDHf/+ij+EnEIUQFtyATJbCCfXeIfj/vRZR4SQtDu8H6/Y/xIX3F9TrTmWnOcXpcHtyc6p7HJOQgtXLxSBMaY+R9th202bKnpdbpUxi8B+qONUO9u5l/4kV6+K8c1Yh6d/1Z20f6Fli++RyVPPF3u0iZuM2Dr7nOC3HsJcBeyg2MKOnOhrPCW37T0ULfzES7n2hEinof304=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95effaa6-a12e-4195-71c9-08ddd9b78f3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:47:36.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri0kHYAUMgqtE/91pleVb5hJk9jK1MnFnw9t/OF4AsP6CWg2/TycERggbbsSvJ5Bb0xbnLtW7Fc5f2arFpixanlzsbf7iLlg1tyj3IXZ8S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120152
X-Proofpoint-ORIG-GUID: piJcVP7OPqC2tdJSicvQmrl62AY4j_Lu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX//u0lHlUxWo7
 jQG8f8TodRHcmseiwMngLpEDj2rlcn11/8Ytm75Y2rDnXLKANUNztzYpvXiW4MS0HvBr/rLHGBZ
 pg68wZLQakE9LRw5M8Rb5Ong22Rr5wpFTZm3q07tl4MG1juwDy966c70bF5H8m9ZRhw04uySLS/
 IE87vXbIL7XArEiIxeNobh5rLcBtQ0V1fztK+qMndL8lyWnoG00xW5DPl0mnlC1HEEWrLVh1wGB
 CRlh/Z7SNaNDPnL9SRa4pIxiokWFcUAgWFT+0pUPLfXmzIjN0Ny/mG1fZPRlYvKeZac/D/8biDx
 ULkTIWU/VR1WwEsLNTLo1E0j1oXmCI6xrS71ThaYincjcOx4SW+nQZs13l4O0cIFrt7Tdiib6/S
 /nL501Wp0mQprDz17oyL62Ix6j2pps5avKNNEtd4hGYjkolNMwZsIJ7HFjZ43q6sfKWpw4vU
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689b621d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Dmo_WeIGsy9f1n_2DrgA:9
X-Proofpoint-GUID: piJcVP7OPqC2tdJSicvQmrl62AY4j_Lu

As part of the effort to move to mm->flags becoming a bitmap field, convert
existing users to making use of the mm_flags_*() accessors which will, when
the conversion is complete, be the only means of accessing mm_struct flags.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/sys.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..605f7fe9a143 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2392,9 +2392,9 @@ static inline unsigned long get_current_mdwe(void)
 {
 	unsigned long ret = 0;
 
-	if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
+	if (mm_flags_test(MMF_HAS_MDWE, current->mm))
 		ret |= PR_MDWE_REFUSE_EXEC_GAIN;
-	if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
+	if (mm_flags_test(MMF_HAS_MDWE_NO_INHERIT, current->mm))
 		ret |= PR_MDWE_NO_INHERIT;
 
 	return ret;
@@ -2427,9 +2427,9 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 		return -EPERM; /* Cannot unset the flags */
 
 	if (bits & PR_MDWE_NO_INHERIT)
-		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
+		mm_flags_set(MMF_HAS_MDWE_NO_INHERIT, current->mm);
 	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
-		set_bit(MMF_HAS_MDWE, &current->mm->flags);
+		mm_flags_set(MMF_HAS_MDWE, current->mm);
 
 	return 0;
 }
@@ -2627,7 +2627,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_THP_DISABLE:
 		if (arg2 || arg3 || arg4 || arg5)
 			return -EINVAL;
-		error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
+		error = !!mm_flags_test(MMF_DISABLE_THP, me->mm);
 		break;
 	case PR_SET_THP_DISABLE:
 		if (arg3 || arg4 || arg5)
@@ -2635,9 +2635,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (mmap_write_lock_killable(me->mm))
 			return -EINTR;
 		if (arg2)
-			set_bit(MMF_DISABLE_THP, &me->mm->flags);
+			mm_flags_set(MMF_DISABLE_THP, me->mm);
 		else
-			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
+			mm_flags_clear(MMF_DISABLE_THP, me->mm);
 		mmap_write_unlock(me->mm);
 		break;
 	case PR_MPX_ENABLE_MANAGEMENT:
@@ -2770,7 +2770,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (arg2 || arg3 || arg4 || arg5)
 			return -EINVAL;
 
-		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
+		error = !!mm_flags_test(MMF_VM_MERGE_ANY, me->mm);
 		break;
 #endif
 	case PR_RISCV_V_SET_CONTROL:
-- 
2.50.1


