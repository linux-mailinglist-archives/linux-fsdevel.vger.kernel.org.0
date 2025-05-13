Return-Path: <linux-fsdevel+bounces-48894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6667AAB55E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D068546184D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466228ECCE;
	Tue, 13 May 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hhheVEtq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mwH2sS/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA961E5206;
	Tue, 13 May 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142592; cv=fail; b=ExlLTLc74k6yR3dFmgp/j+6ukfC275E5H1TuUcRnf9Xg80Vm7N5BkyZ36lQp4jpteqnpZInoud6AbfPntqfEtkW4R3ZjfnDonbc7oYjE7EdMxuE1Wk0kWwt2XN++xyODHll8cWZyRYVM/MB5L8agPNarUVfU61qQKyGygpIcZVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142592; c=relaxed/simple;
	bh=jU1Cf9dSYhk9ZhyDn2Gbdqki39ZxaFPTBKgYbDNjCrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a3PeaVoB78FH1zKKItqmWdSjCHOiX0f6f2JVGAlE6gaUTW8GQ2LNSs0RqKKxbXLxlnHeDVIrLFUH73dZXwCRwIIl6YaPh9ILeU5uek7K9jNivk9PNn6TS8iGlXFmpbFeHVQW4qSTutwaRGFwJ4p/VKvjuMEz3x+yDDz+p0thcb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hhheVEtq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mwH2sS/J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHPQI026295;
	Tue, 13 May 2025 13:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6AztTHa2jo+Cd7jEgV
	6C+jJPwWjjzFKWtl16yW5pkzw=; b=hhheVEtq3vRV9DY4WMcyYJpsGlKxT0WTa0
	S2qVuoPIwInh5ksK3NSfwNbgD/K7hvSrLze5xhg0eKcyUdJasaWyqT8HZUvIsXGY
	iMrJAN6AqvKjq8PktneYhXCg4nrqXBSdBmY9XooSiCmNPC9bPi/0CC5jWhFEXf5u
	YIA61LSaTWtPjk+4oFxijEMCp3iz7J8CEl1NmhXTVi8te7W6cM/Yuc9KeYb+PnTI
	b0+VAP2y2KxBtrpXdyCT1IRxAnOnaSJZlstqY0CY5O46gm8FW7lZM3wH+ZXXc4Sb
	55AScaxiqzRB702sHz9pfNRNJ/alnrgjwm+ue/MeBZFYxFiwQq3w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epmpst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 13:22:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DD6hOq033193;
	Tue, 13 May 2025 13:22:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8enme8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 13:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWtNqIw/VlhZUyiiZR4JE51D2GP2so/NJSF7yXzDuhrjUueQeG9qZammjHBrgnkB2jpwaqYlhSCfrjcGojIN8iFdKGRFMzfY2goCZTmivzvNGhuNsPURcJlBrSRVjpqVA1qPdHd3/nROTumK/w9q3QBJhmqQ/jlm+Xh6WcmdtWmQPY6i+uGJCDTSZrjDnr8HJMHs5X+wRIPHFW9bKMZW0pjGT3E/4f2dtASlwNLMNWWuli/K2bw4J5lwXwgGChKwQGGgwMrnFrvcry9IDRMZT0OrLR4eNqDKQgx09LDll2By4iK26orPZGdupyy4fHrwVypYlCSOdBdko0jOgdveHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AztTHa2jo+Cd7jEgV6C+jJPwWjjzFKWtl16yW5pkzw=;
 b=U6uD0iLjVAzwNqVJLg23a4A0IyZYVudkX2GIt1tkgbpUB3vaQoTObfjZ4etRfyspiE/mNB0BSDXFSpqfWUcIKLvSZQDrZCJWQPCes44wNT4v2bemucpDu+BOgaudFMks20IfisAWqSIs8Z1eny4/b66lxQ98Tv54F8zQtx2ldTajalzwpmwR0TORkJ4WaSFlNuSqBW4YsnOWMCjP9N/vEGSRUzpHlb7doeU87rG3poEjiLNwtEJqduDBTIDbcGN+0/50EAbMXRonowUGFX/G8UUnylhja/z7jkBtgRF6Pq3n33cnYMLrXYHRUi1MAuH43vWjs9//kXGHvsBwJxvunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AztTHa2jo+Cd7jEgV6C+jJPwWjjzFKWtl16yW5pkzw=;
 b=mwH2sS/JOM8HsFEXx5owNiU3HwLSj+tRgWQIK7qIYh5TUpKR/JKqhVOYmesT5MGR4Up/wnIQ4iIsB9Kn8fPgXKcBXvIVVv3+OP/mpTe3dKQzukWPUM1uSU1noSYkhO+yY0LJaRJbUNOZaqiyXheN/QngC2AV8mtMw/GpdxUR4WM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN2PR10MB4207.namprd10.prod.outlook.com (2603:10b6:208:198::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 13:22:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 13:22:43 +0000
Date: Tue, 13 May 2025 09:22:38 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <7eregmiodgcit6ijvs4bhl4tdpxidj6gsy5yidg2ocvanspzqd@725modadje6b>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQBPR0101CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN2PR10MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: ba65957f-c1f6-4d31-9e44-08dd92213def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ki09upNTemxzegKxxPp36YR+5SsWnG+JUFyqvHpSnaNZjUq6Zw2mp5G42Dpg?=
 =?us-ascii?Q?mWBr97N+3RbMDt1NfEeiV59nzAYiUywCuQf/4TDMlyDdHkEq6AVT6Q/xC8ff?=
 =?us-ascii?Q?oVRgtm5QbCWM0GajCpaiXXu2aBaDpvTff5xtXyrwnAJHBmj727FAvwR2aKDz?=
 =?us-ascii?Q?4KUVN5rL40ZoBQZDPLZ/+3jyTaDzh7OrKr0vnQcHc6UWCwnErgUUcuw7EpMp?=
 =?us-ascii?Q?W6QMlT4/KRBl624rBoiRQsT91ciAPaLofQ6CG879I1/8oLc44aIwnJzXdZeR?=
 =?us-ascii?Q?RRw4EAqjhyp2BALjWik4UYqiEHpnBpTrjjLSem13qz5RTydoHqhBOO64U3JK?=
 =?us-ascii?Q?oQjiNp1/e9A6cU9fuPhpDh9RqRPRwsw7CXPWD/UTKIvujARgKLHmxgUXk+gp?=
 =?us-ascii?Q?wA+tGHpBJZs6qZhj4OoMXzEy5P5zg7PCKo1eY+IuHw3SiVN51b6GOh64zVCI?=
 =?us-ascii?Q?Ms21R7xKXlaURkjMlSd1z8/l8gtymNJc1nzYx0pQn9dODtYcJ0VfvcHvNyYU?=
 =?us-ascii?Q?GBJSjTxvelkp43auSFKGSvA6i+G7ABeZV3D3Hf8Q/IT18NDOyqtvBSfQOwMv?=
 =?us-ascii?Q?Xq7+XRvmFr+4AO4UWfkVQkxeWPAx8yn1/Gnwe2ocGzfpZFTFUw5Vm26cIrZk?=
 =?us-ascii?Q?CCy7FyH1ZuRvoKjwTezQbIn12u7s4P7LYtw4TO2n/8N07qBt6YdN3NHMTQDh?=
 =?us-ascii?Q?GlSaTWnHnuBPbbjPu04OJWVt19LMi2qF2jPuKn1LJWfSEvXK+fxGgaIPq1sf?=
 =?us-ascii?Q?UCYi/dUO3hYlYQ5NqkJmdLa7zjXg7//IicV+ABlzrdNoX1qejZ+xV7WxBBLZ?=
 =?us-ascii?Q?uP08SW52W2DQ//EglUvdCn4zgB5DzGMpW4dMVsPfWIV3D9KPc7RfZzje5mc8?=
 =?us-ascii?Q?dTGZyp3t7IZFwhWuEiOcVoTw2/w0mMUky9V61UCi8bbSxnNIFlTAMsTCDXGy?=
 =?us-ascii?Q?8kKfAsBF3flu0QxvmeIhZrqPtOkES3ExysD/x5i3XLRWvGkROyW8Al2YCLQT?=
 =?us-ascii?Q?NAkjHZmLn4er9sCGT19Kw2On3XZ76ry9jjSvg/gDeKP6oc71dMSlQjtTIEUn?=
 =?us-ascii?Q?c4g0yTV9MZCjaEncGN2ElA7gZyy2/9a67aBB6Au3izT1OQv8PTMyIJ5Zvz9K?=
 =?us-ascii?Q?e5Qo71FKHt+UbDFe2rOLRX03a6LuBfRtlpB97Y9ir9k5qOkat/tiC9qZISjS?=
 =?us-ascii?Q?rnKgnphYl+lHcyR9z8SrO5Eq5TH9QSjbpc5Foh0+V7n89WorQW5Y7Qy+P9G+?=
 =?us-ascii?Q?OTNlHdiHvhN7GCoGqr1zS14DF9lw9msVikByeXfdBtS0QnrDlQMdwsBSX/Ci?=
 =?us-ascii?Q?CihMbB1VvnoMA5iVJt5Kyep61L2CzHf37zRqGnJNPPaTuUUkZw5kvCH9TC3+?=
 =?us-ascii?Q?iZggEob3eP/45dBIOv4F9pq+TjqX+G9nla6+yzTjYJICy1kZnUfEOT5Q4fCk?=
 =?us-ascii?Q?pu3xkX3eTAQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1h3f0Z3Ip6fCdOQQmCNc+lqKplTuF1bmJPtkw88ALfUPGgdDCZpTys2JfqII?=
 =?us-ascii?Q?itQXznu0POmuDPqHymQidZkC4Gx0nznlDHi1Nln5rSGI4yDyZYYzy97ttBld?=
 =?us-ascii?Q?9a71+CselKcI1ekXlnP8Rrb3mWzqE0BJBi1/Jxluuj6QVP3aDKBLl1JaZeLO?=
 =?us-ascii?Q?9SE6zSoUrmFFIZFyn0x7cvzqBLkV/EAkbONNqoXYGjuUbpwtv4BubECYWqWE?=
 =?us-ascii?Q?kxBAdIvXw4vMsoLMgsx6z9y8KGcRifhe2Pw6+f4jNj4bwzFUhELzv++8Crmd?=
 =?us-ascii?Q?vokrHxsr7mf+/m+AiNuPmFJaNSpKq8M7TMYZJx1TJuOXebfURUlql3F5482b?=
 =?us-ascii?Q?ivwlFIApjlML6pVdQUQN2CgJCpEIJYvyfVBBj0ErCL1mww++Yon7PrNrgQrX?=
 =?us-ascii?Q?KV8UltgCk/TsK3UJ82wzVzbNaoWJ4A0Fa7sPDkJCsXL6QAxbpSNvQKAglN1U?=
 =?us-ascii?Q?Qvt+dvPNff6HoRokmTG7KX7pcybW7tHQZw0wx4grJTTq/UnRteJd0CyIGAas?=
 =?us-ascii?Q?72BNq8EnbWfHBkjxd4ydv5BcyuxobeBr1q3qnrnoCK67vFSyDsc89YyRhZYP?=
 =?us-ascii?Q?UPJlwChJuA9sNfHWPbqD2mXYrayOIrTlJ4rFfaRcA58ido4H2PF7AojqtgnB?=
 =?us-ascii?Q?G7Y2Y2UdEZPAUKJ0e/aDDNFz+/CbZLMM/+FYSS4nAsVWcse9efUUOpQgV3LH?=
 =?us-ascii?Q?sA240PTsC5TiHYrjOavUb8MX5Jmw2uAf5VqMZs7SBy1tftLl6A0h4XHGOHAC?=
 =?us-ascii?Q?wuPR1g7EKhbjqthsDfZ0WDa1Q/C7+qgfaOY58aeJZ65+ZjDKrVvRo65GbnPS?=
 =?us-ascii?Q?XRsdxkkurCQjHLN5QqufA5hnDDrvQXcay5xVizLHNWg5RMTVwzTuf4eajc3Z?=
 =?us-ascii?Q?9YxbBpbWFgsVQtfbRz8srEg5v6MPcKJ7WR9dNi168JZWtjcscEhjLi7f/z78?=
 =?us-ascii?Q?cnwv9KpnECze8fjFGgw7wLyy0ONO1xqvgNkas6MdmNePzXuW/ehONvpF9nRM?=
 =?us-ascii?Q?ShDVsml6laWQ62vmc+q93Y1JLViozXy57ogmgyGiO+8yZTCfvAlMr+zz85Hp?=
 =?us-ascii?Q?CJWtz/ovER5mM9WXOanekzr2f+DBXzDMQ1aTidv0kDCaWieU0opCWEGOw8zQ?=
 =?us-ascii?Q?TrSCn9XcaCFEFZbj2LWzqa7PkvouCqzNZ+/L+S+79De83gA80NXQiIzgtEqN?=
 =?us-ascii?Q?8GddL4Q7Xc9JttWHivGQkM6Ua3S6hfRnq0uzS7nEc92YVodsKgdMmBwE721Z?=
 =?us-ascii?Q?MVOc2bPME3HrSRxLCs6ifJicnWOLJI9yZmDhKhUNIvY1hku04igXawPVrGe9?=
 =?us-ascii?Q?0SEXxQKPv04NlYvqxoG6FIESVZsY+imqS0xcj8lPuoTTnMC7ouLpeUK5QdOs?=
 =?us-ascii?Q?gtiOuMBz8xBRf4OvP2YtW0PpMk1SFavMm9hX1oSP8BbmPZqI0xjMIgOhQmlQ?=
 =?us-ascii?Q?TeNeyLjHNb18fhLHo5Eo1gbXJ33QmEx39yaRmp0lnDwLgzGRqimKugPrJmK0?=
 =?us-ascii?Q?8DsnVFW4UQ66VfPwdZhNQ61Luf6eJWGwlXP3JB8G1emg3vV1xLna/dwXXBQJ?=
 =?us-ascii?Q?97JvGVPIu2Pt4yWOoHwXmEGIkL0RltzDBgjPWMr+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oJqc4dYcwIaoag7ZO2MUsPR2bzRXw2MKvND4ugwXIZivW5ajkLC5WzluaXSiBKen8TIQeTTLl3uPOxo8TN2rdhiVV6fsUYj1pBhoT2OtrgTrxo6M36Q1e8wc1nnxHfh0idXDJoaCgDkcQCslGjatc9GbmRns4qNjkCCa0cBw2oQsBYKHgFZUXK98SCIZ/WWphoc+rGRzTyOVB8ULZrlHwxE06gXvXV64nVYZ+0Nsk8B7YdCYwNo8UvQOhdOwLvhXXz8BApJk3BoCpzKx0aFpgfS1q+umtsG8/pDzee+L455n/T/IXjpT+JmrE5tHUbJcrcq46tdm7/L0EBCmefFzGZlMnWCx90ZSr1VVUEMF6pTmqinpFXsUeEzbQear+OzphnaItO+Jcskw+hFrGxfRlFKxs2SyI2EgEz4pMSBxyCXzGUzFtl2x6mlqRo0w8J4GgW1aSaq/ktAor4tJUso5AOPWdhsnzv17cQCHdTmfUjw6feMtrK4uQK64aYpKQP/ErV4VdNNbeNfoHxJgzzpb1oHNFztdFNy4OxlHfPqbqufRDmUSos+uuzpWhwbbPv8dvLtqmN8RoYo5EJB1D4jto2jAQRdF0nTPMV441yEd0jY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba65957f-c1f6-4d31-9e44-08dd92213def
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 13:22:42.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muo2QsmpKRG0OK5yEkjkpMb9EnQXMuN4yJpqZo31VvnJI2CsfC2XRD9O1Y23d8z1VLrRKjPf9j9TIABvUIRBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEyNyBTYWx0ZWRfX0Hh1Qq5dGm2N uOtLctpXijQGN6e7t/FRco0dZhF26SWxZD2gu9FvDsa44HEHwUahcqzftBjKtSPTHfR8hXhMcnk ry+k0bCRoyxnhZ33wsRSH7tkJwEoNA/7vNKZLtURtv93e9mq5yvakfGe0ST9ItMWM/liT8Zmkkx
 qtGYbppj1eTlNJEegUs5QTjIzUWmdeXdtIsbD9IvGIxsC5DOx30Dem7brweJmWAbsaYzWAHc1KY BfjP62xAAZdDJ3TfwYe+wtKcxpIwmiuv6nbTva47gKxG+k7uEWAU5RRa4yJWx/g50fn93Wm4ZLQ UOURU+tXtgZkxFDTvrBkmEcCWVqVDq6atfYT57SYo6uq+sgXCMSJaUttPO6gXOnDayZ/3pYzBBf
 lOxu900lH2dZ6iICmmWVv6JRzUaG6jY1TMOzcPUeplGu0bNxsAo3FWUq57R3rk/fWGob7fc8
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=682347a7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=IGjjO237aKuVbEsYDsQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: vfv6NZdQO1fuKGph3TzOyFw4ZWoHBhg-
X-Proofpoint-GUID: vfv6NZdQO1fuKGph3TzOyFw4ZWoHBhg-

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250509 08:14]:
> Provide a means by which drivers can specify which fields of those
> permitted to be changed should be altered to prior to mmap()'ing a
> range (which may either result from a merge or from mapping an entirely new
> VMA).
> 
> Doing so is substantially safer than the existing .mmap() calback which
> provides unrestricted access to the part-constructed VMA and permits
> drivers and file systems to do 'creative' things which makes it hard to
> reason about the state of the VMA after the function returns.
> 
> The existing .mmap() callback's freedom has caused a great deal of issues,
> especially in error handling, as unwinding the mmap() state has proven to
> be non-trivial and caused significant issues in the past, for instance
> those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour").
> 
> It also necessitates a second attempt at merge once the .mmap() callback
> has completed, which has caused issues in the past, is awkward, adds
> overhead and is difficult to reason about.
> 
> The .mmap_prepare() callback eliminates this requirement, as we can update
> fields prior to even attempting the first merge. It is safer, as we heavily
> restrict what can actually be modified, and being invoked very early in the
> mmap() process, error handling can be performed safely with very little
> unwinding of state required.
> 
> The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> exclusive, so we permit only one to be invoked at a time.
> 
> Update vma userland test stubs to account for changes.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/fs.h               | 25 ++++++++++++
>  include/linux/mm_types.h         | 24 +++++++++++
>  mm/memory.c                      |  3 +-
>  mm/mmap.c                        |  2 +-
>  mm/vma.c                         | 68 +++++++++++++++++++++++++++++++-
>  tools/testing/vma/vma_internal.h | 66 ++++++++++++++++++++++++++++---
>  6 files changed, 180 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..e2721a1ff13d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2169,6 +2169,7 @@ struct file_operations {
>  	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
>  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
>  				unsigned int poll_flags);
> +	int (*mmap_prepare)(struct vm_area_desc *);
>  } __randomize_layout;
>  
>  /* Supports async buffered reads */
> @@ -2238,11 +2239,35 @@ struct inode_operations {
>  	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
>  } ____cacheline_aligned;
>  
> +/* Did the driver provide valid mmap hook configuration? */
> +static inline bool file_has_valid_mmap_hooks(struct file *file)
> +{
> +	bool has_mmap = file->f_op->mmap;
> +	bool has_mmap_prepare = file->f_op->mmap_prepare;
> +
> +	/* Hooks are mutually exclusive. */
> +	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
> +		return false;
> +	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
> +		return false;
> +
> +	return true;
> +}
> +
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> +	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> +		return -EINVAL;
> +
>  	return file->f_op->mmap(file, vma);
>  }
>  
> +static inline int __call_mmap_prepare(struct file *file,
> +		struct vm_area_desc *desc)
> +{
> +	return file->f_op->mmap_prepare(desc);
> +}
> +
>  extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
>  extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e76bade9ebb1..15808cad2bc1 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -763,6 +763,30 @@ struct vma_numab_state {
>  	int prev_scan_seq;
>  };
>  
> +/*
> + * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
> + * manipulate mutable fields which will cause those fields to be updated in the
> + * resultant VMA.
> + *
> + * Helper functions are not required for manipulating any field.
> + */
> +struct vm_area_desc {
> +	/* Immutable state. */
> +	struct mm_struct *mm;
> +	unsigned long start;
> +	unsigned long end;
> +
> +	/* Mutable fields. Populated with initial state. */
> +	pgoff_t pgoff;
> +	struct file *file;
> +	vm_flags_t vm_flags;
> +	pgprot_t page_prot;
> +
> +	/* Write-only fields. */
> +	const struct vm_operations_struct *vm_ops;
> +	void *private_data;
> +};
> +
>  /*
>   * This struct describes a virtual memory area. There is one of these
>   * per VM-area/task. A VM area is any part of the process virtual memory
> diff --git a/mm/memory.c b/mm/memory.c
> index 68c1d962d0ad..99af83434e7c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -527,10 +527,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  		dump_page(page, "bad pte");
>  	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
>  		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
> -	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
> +	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
>  		 vma->vm_file,
>  		 vma->vm_ops ? vma->vm_ops->fault : NULL,
>  		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
> +		 vma->vm_file ? vma->vm_file->f_op->mmap_prepare : NULL,
>  		 mapping ? mapping->a_ops->read_folio : NULL);
>  	dump_stack();
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 81dd962a1cfc..50f902c08341 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -475,7 +475,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  				vm_flags &= ~VM_MAYEXEC;
>  			}
>  
> -			if (!file->f_op->mmap)
> +			if (!file_has_valid_mmap_hooks(file))
>  				return -ENODEV;
>  			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
>  				return -EINVAL;
> diff --git a/mm/vma.c b/mm/vma.c
> index 1f2634b29568..3f32e04bb6cc 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -17,6 +17,11 @@ struct mmap_state {
>  	unsigned long pglen;
>  	unsigned long flags;
>  	struct file *file;
> +	pgprot_t page_prot;
> +
> +	/* User-defined fields, perhaps updated by .mmap_prepare(). */
> +	const struct vm_operations_struct *vm_ops;
> +	void *vm_private_data;
>  
>  	unsigned long charged;
>  	bool retry_merge;
> @@ -40,6 +45,7 @@ struct mmap_state {
>  		.pglen = PHYS_PFN(len_),				\
>  		.flags = flags_,					\
>  		.file = file_,						\
> +		.page_prot = vm_get_page_prot(flags_),			\
>  	}
>  
>  #define VMG_MMAP_STATE(name, map_, vma_)				\
> @@ -2385,6 +2391,10 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>  	int error;
>  
>  	vma->vm_file = get_file(map->file);
> +
> +	if (!map->file->f_op->mmap)
> +		return 0;
> +
>  	error = mmap_file(vma->vm_file, vma);
>  	if (error) {
>  		fput(vma->vm_file);
> @@ -2441,7 +2451,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	vma_iter_config(vmi, map->addr, map->end);
>  	vma_set_range(vma, map->addr, map->end, map->pgoff);
>  	vm_flags_init(vma, map->flags);
> -	vma->vm_page_prot = vm_get_page_prot(map->flags);
> +	vma->vm_page_prot = map->page_prot;
>  
>  	if (vma_iter_prealloc(vmi, vma)) {
>  		error = -ENOMEM;
> @@ -2528,6 +2538,56 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
>  	vma_set_page_prot(vma);
>  }
>  
> +/*
> + * Invoke the f_op->mmap_prepare() callback for a file-backed mapping that
> + * specifies it.
> + *
> + * This is called prior to any merge attempt, and updates whitelisted fields
> + * that are permitted to be updated by the caller.
> + *
> + * All but user-defined fields will be pre-populated with original values.
> + *
> + * Returns 0 on success, or an error code otherwise.
> + */
> +static int call_mmap_prepare(struct mmap_state *map)
> +{
> +	int err;
> +	struct vm_area_desc desc = {
> +		.mm = map->mm,
> +		.start = map->addr,
> +		.end = map->end,
> +
> +		.pgoff = map->pgoff,
> +		.file = map->file,
> +		.vm_flags = map->flags,
> +		.page_prot = map->page_prot,
> +	};
> +
> +	/* Invoke the hook. */
> +	err = __call_mmap_prepare(map->file, &desc);
> +	if (err)
> +		return err;
> +
> +	/* Update fields permitted to be changed. */
> +	map->pgoff = desc.pgoff;
> +	map->file = desc.file;
> +	map->flags = desc.vm_flags;
> +	map->page_prot = desc.page_prot;
> +	/* User-defined fields. */
> +	map->vm_ops = desc.vm_ops;
> +	map->vm_private_data = desc.private_data;
> +
> +	return 0;
> +}
> +
> +static void set_vma_user_defined_fields(struct vm_area_struct *vma,
> +		struct mmap_state *map)
> +{
> +	if (map->vm_ops)
> +		vma->vm_ops = map->vm_ops;
> +	vma->vm_private_data = map->vm_private_data;
> +}
> +
>  static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
> @@ -2535,10 +2595,13 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	int error;
> +	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
>  	VMA_ITERATOR(vmi, mm, addr);
>  	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
>  
>  	error = __mmap_prepare(&map, uf);
> +	if (!error && have_mmap_prepare)
> +		error = call_mmap_prepare(&map);
>  	if (error)
>  		goto abort_munmap;
>  
> @@ -2556,6 +2619,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  			goto unacct_error;
>  	}
>  
> +	if (have_mmap_prepare)
> +		set_vma_user_defined_fields(vma, &map);
> +
>  	/* If flags changed, we might be able to merge, so try again. */
>  	if (map.retry_merge) {
>  		struct vm_area_struct *merged;
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 198abe66de5a..f6e45e62da3a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -253,8 +253,40 @@ struct mm_struct {
>  	unsigned long flags; /* Must use atomic bitops to access */
>  };
>  
> +struct vm_area_struct;
> +
> +/*
> + * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
> + * manipulate mutable fields which will cause those fields to be updated in the
> + * resultant VMA.
> + *
> + * Helper functions are not required for manipulating any field.
> + */
> +struct vm_area_desc {
> +	/* Immutable state. */
> +	struct mm_struct *mm;
> +	unsigned long start;
> +	unsigned long end;
> +
> +	/* Mutable fields. Populated with initial state. */
> +	pgoff_t pgoff;
> +	struct file *file;
> +	vm_flags_t vm_flags;
> +	pgprot_t page_prot;
> +
> +	/* Write-only fields. */
> +	const struct vm_operations_struct *vm_ops;
> +	void *private_data;
> +};
> +
> +struct file_operations {
> +	int (*mmap)(struct file *, struct vm_area_struct *);
> +	int (*mmap_prepare)(struct vm_area_desc *);
> +};
> +
>  struct file {
>  	struct address_space	*f_mapping;
> +	const struct file_operations	*f_op;
>  };
>  
>  #define VMA_LOCK_OFFSET	0x40000000
> @@ -1125,11 +1157,6 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
>  	vma->__vm_flags &= ~flags;
>  }
>  
> -static inline int call_mmap(struct file *, struct vm_area_struct *)
> -{
> -	return 0;
> -}
> -
>  static inline int shmem_zero_setup(struct vm_area_struct *)
>  {
>  	return 0;
> @@ -1405,4 +1432,33 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>  	(void)vma;
>  }
>  
> +/* Did the driver provide valid mmap hook configuration? */
> +static inline bool file_has_valid_mmap_hooks(struct file *file)
> +{
> +	bool has_mmap = file->f_op->mmap;
> +	bool has_mmap_prepare = file->f_op->mmap_prepare;
> +
> +	/* Hooks are mutually exclusive. */
> +	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
> +		return false;
> +	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
> +		return false;
> +
> +	return true;
> +}
> +
> +static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> +		return -EINVAL;
> +
> +	return file->f_op->mmap(file, vma);
> +}
> +
> +static inline int __call_mmap_prepare(struct file *file,
> +		struct vm_area_desc *desc)
> +{
> +	return file->f_op->mmap_prepare(desc);
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> -- 
> 2.49.0
> 

