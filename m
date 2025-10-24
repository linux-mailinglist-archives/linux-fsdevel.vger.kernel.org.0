Return-Path: <linux-fsdevel+bounces-65580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331DC08044
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824873B2F49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF72ECD3A;
	Fri, 24 Oct 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jeU7z5VJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FPMpdBdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD102EC08B;
	Fri, 24 Oct 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337096; cv=fail; b=HS0lpZ1EzPTJF4EP9DhYMPMgnSMLKo/JOcYh/qh6ytNQ2zJ7lwdG5vR+KLz47C/GpthsuXO5PwT9Njmx0aCIyMJ+Q5qxlV0smgyIwNmG4nIp3iXYJ6/R4ahL8KivQvVhrpxuyc/p+N9Ud2N8IH38ErU3hxyTSdlOVNvtdCXzaTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337096; c=relaxed/simple;
	bh=pi8teI2ZXri2d+4P4ABNOssZPSn5s7Bbv7CR/q7aS08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A2WyzTm1os5uqF5/EvCF+4VBlqiYSMJKZzNY+rbWC5iz6pS5WjJ7mNTUlbh2TznMUuSROGFhl4c1jo7wBvA1IbjEMYRPisnzl/jPWnolBBA0SYi/Tx5H+2oCJEEfdegYWGsd1Qro0L7FIc4Fu4TE/o99JQhMBPgBP73nHTPVizs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jeU7z5VJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FPMpdBdf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OINC3K022387;
	Fri, 24 Oct 2025 20:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3hBtdkTvGtc5U7pSQT
	5PiIgXBYn8khzXiux8xElLJt4=; b=jeU7z5VJQtkPeQDcBnX2M4wJVYtKTJXo5J
	EQRERDkS+WxyR90bq+p/9SEffxsO1Di9E58/ehXCRzhhmR+tNFX8drZ8tXUHk1ZF
	Ld7/MPZilprlIrKGgJscmQYNukkAGblKEA7ZwzB64kXbEgrHrwNc8R9Tkkcdt1dO
	pfLpXo0EAX+cB2uxHF15/RMYXjTT65gRoskvbo8myKj4nehQ3rkuraVkdHkcioUk
	vtEcT3eK6UYS9HtjDv33Cn6avqHCpUrNmSEfiMa0QDo/9/0NilPT/aoRgjfGgOBa
	hwmq4woOtCs7DTbCLDoUqyJACNPTipS7Wk2Wu6CaxYYgtefeibmw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw4s79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 20:17:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OK2f1A004427;
	Fri, 24 Oct 2025 20:17:19 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgbh4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 20:17:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w84HaUmYCbmjSF6yxyPnCpBepo8oI0s2Kz4DlUoVl3TmUc25oV06iLFsFqg3YWy2RInjbv7GLv0Ay0mz5MhjQQ7Si1zaEuKip8iMBolUvO6PEbbqGXA8xdItC5UyJOcI7g0x2/MSrio1s3TiumuAkJZryQIVozTw337S+oJ5niRxIS8FxaWWaI2NPi8TLpmSBsSXySMgaMlUZQjWupQ0V8W1uHV5IvNH0TUHgkH2zluFIEDxZGry7+CnFMc+gs+oRT+CIHg2F1iZBQQeU71hp/1wyhEXCB7iaZHnIdYsJJBIlOS1My3i7vec4L9tIsAqGYMyK9yeDmHxAB17AtDBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hBtdkTvGtc5U7pSQT5PiIgXBYn8khzXiux8xElLJt4=;
 b=SL6UbzXNWiICPGUxWJQmZXlfDgN1TwqQ/25RI0LIN/wwhpsLYAZ11p/UokggcIMOpktXNOTTG8hKC5+mCqEP2zVX8EjzQbSyg63Yhvsp3McZz710jkIMdl3kV8txt77oK/dtqO6n4Ct+qq0VKGCn8DyYDyuQURlG8ikjDfPnWyKaO/C27zcn6sEIzvlx11bjjPuI69z6ZJbWkwh/YHHtFh38ItxVJUK+fgFgl9XqBRYCBJVzaF6iIEgX8+IEsj1qpqYeZhJFJfxMpYWyEGbys5agFsT85EYrDMpxD+fhRjLSqfNGFcKnrtgny0dAs3wiv/PeT0RBpEBoVUts1lJOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hBtdkTvGtc5U7pSQT5PiIgXBYn8khzXiux8xElLJt4=;
 b=FPMpdBdfcXSM5GVNSqj7wQshekU6sz2BqLuPqmOXibTKodzyVAvt6QAm9S+P9Krtx230XV7tNebxJvrnPHxsg27IsJq3KdXV2efQziRm2/wSkE3Jhy6THyHevurVWQfUnXk/j2LPbfMRUK5PMRW/OVyY1yS0yoR3sHdomNo8wqw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7102.namprd10.prod.outlook.com (2603:10b6:806:348::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 20:17:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:17:16 +0000
Date: Fri, 24 Oct 2025 21:17:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 11/12] mm: rename non_swap_entry() to
 is_non_present_entry()
Message-ID: <7caff42a-d471-4b4d-b7bf-61f74a75b9d0@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <a4d5b41bd96d7a066962693fd2e29eb7db6e5c8d.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPvOfIfcRM0X_RaK@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPvOfIfcRM0X_RaK@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: LO4P302CA0034.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ab7db5-e11b-44cf-38db-08de133a537b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4IOVPk+UOyUh7Bejpa410FF6DmnWa7vfzJieCrtwR6RfBMVt5tAI37KluNaL?=
 =?us-ascii?Q?mwwtUnpdDbry9qqzbnGAkexTUYcHIF6lfkqkVCubsWX8y/Bn1uddQ4nCqEfw?=
 =?us-ascii?Q?buus0yATQgPj0j3KVTdLhmbF4Gl6VKM0tHXE0PEUKbXDs7crxkJDXz9s4DZR?=
 =?us-ascii?Q?gcH21JgIPW1Sst+IHZn44etJZXbDtekZohIvl9ag45vyC6zyrS41bK6Iq8XJ?=
 =?us-ascii?Q?QreSMbZPzdx9+OWI+Fbs2WIo0foO9J4obd3UaUbGjfSlkSeGYibeG3c5fIb6?=
 =?us-ascii?Q?RAD6RMuBJVA74RbrNWaD3PL6dvhIZmr2UWmP66pv06b0axOTCUHrHpRTuTK/?=
 =?us-ascii?Q?IogXMT1xO1VG8pQZjjGDA9X+sYX7Kc9+RoNZM/1LYNHSWagUW7KKJScr4o5N?=
 =?us-ascii?Q?M32yfLltBNJIo2tsYrjfaC9xq3VAwwLUClbMacCVo9ljYMhtMfniBJBX2nNp?=
 =?us-ascii?Q?wF9es9yhdkWROwBtKW2tnSxoS58Yo0q8Q2tS+/1I5F+zW6HLNuntCkYHNDPq?=
 =?us-ascii?Q?atO2t8KaFNq5uWBGFKXNnMr6TKhSPrjRGuN2gnpNjlHw1oU1kfHyM3m3xLKC?=
 =?us-ascii?Q?NWW70o44dedMc3DB5foEUdr5tVe7NpQzJFXdHpgMZ0U8H3HHNiVSjRuMv5vS?=
 =?us-ascii?Q?+iTFpsUa80CiMyOOD++nFvz7qfT6fM/IZRED8QWcgpi7zDd8MSR94JFlefn0?=
 =?us-ascii?Q?FvvP8GejVEAFXWyTMMP2Ny3lNWEELMj6c/hKurESj0OZFYM/erSHTFSy4HH6?=
 =?us-ascii?Q?cafyeYpoduSGPZVvu02FL59CN8oyVWD9FloYf2Iv6z5dg8XkI4e7SVukpSML?=
 =?us-ascii?Q?a+NO0bXBYSDJJxTjewIoIvnsWgi1lFdpKEDD8ygNc1Tn4Iz39YsndE3LNsnT?=
 =?us-ascii?Q?1b79tPuXLArdtET0lhZcbtZ6rgSCpBhPcg3SQ/9kinbqFDLVdXL8c9wkhBr+?=
 =?us-ascii?Q?Oba/of96fIY+eYg/SpcFTC/lVEke1hMH/1SxEWj71FYp1r4z3Niue6H3SLNM?=
 =?us-ascii?Q?zUSj4P55iNMCziM+YehPbJyB4BUW1PzDu0wBk0Zs5fq+d5GqHNZSCId2VsM4?=
 =?us-ascii?Q?Hh1MqXzSYP9mhgZfn9hTmSGEAu3kIUEkRoU4oPCu/FrwaTesVaF1PSje+hKG?=
 =?us-ascii?Q?QbntEaLSezswysja6cnZdYtg3/hAxIm3Dts8Nftw1HiImU47+tgrchwWrIPI?=
 =?us-ascii?Q?HwzUrb/zlGKb4LHW5hzomHXK2AxbuwPyTfa8j7sUjKOR91X5IRPzelWN6mfv?=
 =?us-ascii?Q?TOO3uU/y+QbNNrFBngPS2mzNeRZNq3UZ/2foyJPNXAZtcJYQJblOHYnq6M/E?=
 =?us-ascii?Q?n0uSg/PVSvqOMwSO5vwRVYmZLKy8Sc4Z/iy9iA3eWs+32eIYG6bNG3q2lNzT?=
 =?us-ascii?Q?T/B6w3puIeiFHg5SAgfboTLV/dnpxJ5btY8+JOtrPFaPLq1JYnhWi9vVHP6q?=
 =?us-ascii?Q?OxSZUj0EmIyMfiV/38wPH5jQ2i3IESRK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUiUF1F1KP84ngYFZEquxCa8x0dpvvZQhj7xA0bxIhubIU2n+5hIYoxUDMq+?=
 =?us-ascii?Q?VTVwws5+9tnIOaW4UFyF/LLF4ZJKemjPKKPnnRwZOhsyYhM8AxXLB3RztBkz?=
 =?us-ascii?Q?6y9LPYq+j9WL0c5U6ZNCcRR0qXXWKynP3bN30Lz15PyojDcrckKR1008L7br?=
 =?us-ascii?Q?FDKmJqe1yIUCPszkxD6iYEdfbmVWZZobDpCYwiG94+Z5EvgYIP+jWjAEgZny?=
 =?us-ascii?Q?7m9kw4tXaT1sDcNK3PeaORJgc1bjWYwvAcBgPAjqsPe8J5I4fcaMX41avPfg?=
 =?us-ascii?Q?dsoXXZRVv/9VbmCemTh2qgQOP+M7nNSh7kmvf4x+d6Idrf6kNwS7LkEbhuzU?=
 =?us-ascii?Q?+5ylve8Wh0cSMNpVJZMisKSQ93Lnxtf+GW6VG23Ax3Jv8ZQWNT7kZCNblpH1?=
 =?us-ascii?Q?vgvjF1J5CspxvDYG38BtO99ccH87EnfGDv/fWP4+/PjGVayL6zIzbKrUd0l5?=
 =?us-ascii?Q?50+1dLcKeWY08kjZB5BCyBGnIUWSp8mH92eDdv8wF+7EZ9gJOQfjRMNHAsPO?=
 =?us-ascii?Q?loyrfJ4aSk2fySF909CNZEjHtEBt8Zc9UBXoHwN8CmUB3X/FuVIHIvJDhOq6?=
 =?us-ascii?Q?jgCTptPBpBbWGSSacw1yayXF4LAerK7I0CbMsTTEGagxWE9mpfOop+D7Mwaz?=
 =?us-ascii?Q?aR5QJGe4yecnYGDfmIaIiCpKimm6QGe7kGoO22e55rAVvxR45Ch9XfOtsRz/?=
 =?us-ascii?Q?otEaK95COyLtkhdy/fKWXI5HeFHglWnvJ6w8hd7Xou4Turtcm9HvplkE7hN6?=
 =?us-ascii?Q?zxbh/SGIWCTA59jRoj5sP5pfTr872f8isVEfOSaYBaiXvDn9eHOvH84/waGF?=
 =?us-ascii?Q?hBFwsHNal3hNnC7wTUmWWQncrd5k0NM+W37rEuREA78vp+THjClKFyk4/O3z?=
 =?us-ascii?Q?PL99Feg6hFM9GdzcxAtz5s8qSEl3wBgDjGvR/BnMxdtPEvVSPSN8dAPrzEi4?=
 =?us-ascii?Q?XJS74INO3fAyY4qLVLlDx4/PLJvILAQfPjA6J9LiluBovMKsMYJNIvdMH+RD?=
 =?us-ascii?Q?MLFKnFibVtrbWqYpgHsnenWphEzN4L83F3mlHZvbmJ8KP4z4bI3xTkD1Ne7s?=
 =?us-ascii?Q?pcu2xe6CIQ43VvrOxC7EEcKMXRODLYElE8n1EFN35qC3354vP5wKfCATzPe2?=
 =?us-ascii?Q?QJoAe7LlvdFfX2I/YF6S/LkxkOAPInvIhUbk3A0+newhpmRcDrSMIfBLYwC5?=
 =?us-ascii?Q?1KXLzNbxIv9oGTHrKtn5RfMvdTg7KA6rNmM6T8zj7SwIS29VXuTx4UdNXHAE?=
 =?us-ascii?Q?fijeYn9fI8QD6pyIEDwXQB5+4HliCVqfDXGjjHVbR3cmwJ+XyRwa4uAvmwmj?=
 =?us-ascii?Q?T2HLeixAB7Zr9MG6Jsr3QU0/+e+VfyO16gtd0WQ7ohaN0a2M7fZEavStCIZg?=
 =?us-ascii?Q?MMKzLGidlGagdJ7iKHdKnC0d8hszzNQfxjdBCS1CQ4EqBNQN0KNqFeLyZJbH?=
 =?us-ascii?Q?Asif3Q4QlulB5pDjTbcz0dQO769GcNEiAGsebtH4/+2G1dIngVRI4EmJs9Dw?=
 =?us-ascii?Q?mSdTBH3htjolQDNKIq/zxEv8+5EM8pOq6py/PdPBPgMlLHfkcjKStINi4siz?=
 =?us-ascii?Q?2L3CHECIN3J76vwAs6qef7THAxCvQt4PwVrR4wg6U+ZdCBXcV3Beho6NJu2s?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jwEJ7JHudT+Nsmu98BOH3eD3CMBYS/5XjKOoeo7dXvKW9vUXCv8ufCzKW6Hnu3BKisWGK7IWaKuHOv4s6aoxGhG4iBqEmw49t6AHR/NEHHSV6QFfg0IgaM13dslHcY7uojlMRk9sB8gRVlJcnciPGmvdIkhGKLXYZA+SwAWNSIA33pTzHsFUmZsuxU/TPpnHJbaoxAAbW+PhlGBRMZjpXT1MEfe3aZnPHXq8mg0+goEcNkjIJBuWDKUyiSPjiFpsz4GjR1XaMPl30vKugxhvXm2Zr5JV8FBo2xHcWtDBtnhnxji8zVnL0OyYi/wsWr4ZmLuDk667aTlGtSWrUs14PghT2rfL/dCWV29uXrRjoY/K7GHEBBelCAQ8kQEUbcmOD1lLsFcQM+LLSH4hTvZcYuLy5vca+htqhee738YcCBW3GRnXC6Rpc6v1JTQNEY03ZcdZ5EmkOdUFlQneC3KYdQR4lu9UMPBNjKC3Pc/JseHD5wx49zziEP/ll75nII70PhgLJAk7TIoO/XnZZifpS3c3waPT61nC7wetDyQyVaakoY1HXvD6OTDa2TV6GM8U6Lv5yV5D7ICZhG+UQSmDeR6RyQH+OpPOmEhIW4Q8jJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ab7db5-e11b-44cf-38db-08de133a537b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:17:16.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgCNuN9qZBXyhDHKCBJXYWz7OSKU8Xpw44koaubk2TZUOnud2WQhEttsqvckJFuvaGUQNGddwpkLKbec2Gf6YP0XsudG+4Ekl3p3GANM5cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240183
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2OKOVx0g+3Tr
 dS2wsRqWifoaqzdkqW7we0PC8w2UJcZohSQPXIN1vm2gLHK0Oq19FkEEkxytEHwHLp4Iqx4j9+u
 hRVug0QiT3qXmh0vA4zfYmGjVXY2NrzCdu897LrJiCLm3ULe2J5rjflPvjiMajG8ehP/dp0AKeb
 biwrhVDYk0IqrlkTaG+qnPY6y+HDzknrfbIEOQpZcY8QVQR/VsnS2XbbGa2vOyu81mRthN94JI9
 XbyXMF/rpWEbBPJR9UA4RpPtLJcWb4bcRgRH88D513pUAg1ib+rWBtn9iVD6joUCYI062Q7l6v0
 leg/DtDX8r7dj/aGYgOU671qnIDczRCsPbzDBfTKYAUmPGlmmxsnMpMKdXhU59U4xR5/XcC8biI
 +uXwgtLzMTAEAbPrIexfQkth4M/yDw==
X-Proofpoint-ORIG-GUID: DSwKRkhK-9GcYWH-WBNRGe4FvCkcfq-k
X-Proofpoint-GUID: DSwKRkhK-9GcYWH-WBNRGe4FvCkcfq-k
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68fbded1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=N4YxUNX4kpYwjd2aZjQA:9 a=CjuIK1q_8ugA:10

On Fri, Oct 24, 2025 at 03:07:40PM -0400, Gregory Price wrote:
> On Fri, Oct 24, 2025 at 08:41:27AM +0100, Lorenzo Stoakes wrote:
> > Referring to non-swap swap entries is simply confusing. While we store
> > non-present entries unrelated to swap itself, in swp_entry_t fields, we can
> > avoid referring to them as 'non-swap' entries.
> >
> --- >8
> >  static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
> >  {
> > -	if (!non_swap_entry(entry))
> > +	if (!is_non_present_entry(entry))
> >  		dec_mm_counter(mm, MM_SWAPENTS);
>
> I guess the question I have here is whether it's feasible to invert the
> logic to avoid the double-negative not-logic.

Ah well, see the next patch :)

>
> Anyway, naming is hard. In general I appreciate the additional clarity,
> even if we still have some `!is_non_*` logic sprinkled about.

Again this is a prelude to 12/12 :P

>
> --- addt'l aside semi-unrelated to your patches
>
> I can see where this is going in the long run, but the name of this
> function (ptep_zap_swap_entry) is as frustrating as the check for
> non_swap_entry(entry).
>
> may as well call it `ptep_zap_leaf_thingy` if it's handling multiple
> special entry types.
>
> but renaming even more functions in strange places outside scope here.

Yeah there's more to do for sure, I'll add this to the list... :)

>
> ---
>
> ~Gregory

Cheers, Lorenzo

