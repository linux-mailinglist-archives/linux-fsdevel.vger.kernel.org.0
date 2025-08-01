Return-Path: <linux-fsdevel+bounces-56522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FBCB1854C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15CCA82682
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906627AC59;
	Fri,  1 Aug 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bfLPMzse";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PA2iNrYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866126C39B;
	Fri,  1 Aug 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063682; cv=fail; b=d7jTNMIiqcv8gmTI8h6LIzvqppMn+2ZDYeBGtdwBEIJUhgXou01yYOsSIYnjtkJ4uqnNpvAkWvMVgmQ2A4DM363TGsbI+9+9mC8P5w6ZaRzoFQgV+4NB6voA/KGp9J1gZccv/vqvVaVHVUDDG1yFg+BooM1NkVrxEtvNwAOE1gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063682; c=relaxed/simple;
	bh=exKcrExpfwE8CHAM2lesQU5gy9RQ9CZQV0+gtp6z8Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EEVHd7ndRcQ7vSTYQzrJwgVxW63F02FQbtcPcawNxiQ3Q1/Y1MKGQNLgIpNY7lMLSUXq4sAMUZPL+212d2F7JCFKjkb1/WUYqU6y2slgwIDD2R+xfWZZdq6wayLXqH+OJfSs6ufj7E2+tjgUcQufCZnPXOHTV4LHDzTlxJ9r9qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bfLPMzse; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PA2iNrYk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571EmxIY013929;
	Fri, 1 Aug 2025 15:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NRw8m1a3px6az8NIWq
	/F+UeXaY6Z9h+KUFu5sNwsxz8=; b=bfLPMzse6mf49hisPMTuwKIJiy8eKO2HUb
	pbx8AZt8dFhip7rlOzQNzuj6UcYpixHHWcfI+afGHwMHoOUIeZdbGj3EA65OsRlB
	MxZS8yJVA/NkNxKtTQVKJBoz7bwcVwrEZuWPda0PwOi6myM9tmxK6/ieZOUBN+yt
	2ikPbajJS6uTHGVb9KhqfHErpckR/TWHYwmyJbRialT0kNWPmXezmJ0rkZjQNZiY
	IqPQAdIxxx7Dc/yTPwDEflwjtQwEq1uQ8DmQOUqsAvi3Yr8/lyRoZWzMAdHOmmoy
	ZOMcgMNHthljo9nygA+4aqq1xP47I2QSgH2RM3ICXk1uSEMdBxBA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29xnec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 15:53:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 571FUn6X003459;
	Fri, 1 Aug 2025 15:53:12 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfdyq0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 15:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkTaLzR+btB8/oQvYQDTEaWgJFi3WPnS8hueSHYn/m8FeueT0FmfW1yzWLQQat44eDU86onEcWHqDTZTVtbzD3Sa2Ozifgk0ztK1GqsdyKlpMsmDiIJqhlQh4A4gco6/HjId0EMzS01SH54NlbMBDzeZ5wBvEWZgn2oVQS+Uipl1vZCz+CVosLhlxE4zHWep8JJqKiwQsqxMGkPggU8TelRDoWr0LlWwalV3NDdVmDspMBIZ/qt87WSR2gnd8Un/vxQFKhKamOdzJKLWTuOULmWZzWp6YzYpfT2mkrKkBXUsHaZ+g66/KgwDRNfrayx5iIrmdnNV2ILoD9M239weNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRw8m1a3px6az8NIWq/F+UeXaY6Z9h+KUFu5sNwsxz8=;
 b=y3e6m//LZl4cOM9ahtimYPDq/eINLztsKybizaMp+9WfnHWSKcyWDNBchUKbaI0ovlXDiAKeXGzmZrpN68K+gjRMKvtOOdd0pzIn4+xZfGgA+dHrOdlHVMuL+3QWLliZcY38TH5lBy57lK5wx5+WCOCuZKcCkrSWZVy4kjn6aiqDuJEGqH3vkQEPRZJADEl43awioTb4ro1DiHldrEFxAYPUlLXEps0cTGJ64ZLTT6FzEmM7t/phCcpkjwUUKXGV1JT178nydtEob1khBzdkFXhOf/EH4yhyFdJfn7s+hYFBzipzb0qhFVhXBei1VHWJ/BgSkmrWGzREswapB1QUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRw8m1a3px6az8NIWq/F+UeXaY6Z9h+KUFu5sNwsxz8=;
 b=PA2iNrYkYA/gOb10ekq9rAbbrSaBnkkQYgrU3Uew/bZR7Gepxkcdw/NR+9kqtvOIj3ER9VeMqf9egBWrbh7/DsWhQXzGDY1w/FppQKnuIDFWYLQOL7Ms0mbXX15Hy9aJcPTIQMtRb7xQSxUALt97VP3gHD5MnNf1+YBV8gMH5Rc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7413.namprd10.prod.outlook.com (2603:10b6:610:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 15:53:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 15:53:07 +0000
Date: Fri, 1 Aug 2025 16:53:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 1/4] mm: rename huge_zero_page_shrinker to
 huge_zero_folio_shrinker
Message-ID: <f00bd734-df95-4057-8263-460c044298f8@lucifer.local>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
 <20250724145001.487878-2-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724145001.487878-2-kernel@pankajraghav.com>
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bf2a97-f003-486a-2604-08ddd1138236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oLGuwugyznZPaGLlyQtEiv4Nv/N+W16riU0WFFf5FkJDGsIM8A0Wi9+6/fHq?=
 =?us-ascii?Q?Hc3Fb1fY8j1k2A9Cc6b/W4Ussz2bnKewaWb6ozgf2biTgyUO2wlctlEHsRGb?=
 =?us-ascii?Q?8TclxVxpalYDrxa+1oQ+PfU3fWEYyuATsGTMiM+1KCDyxzcomQTTUzklLUr7?=
 =?us-ascii?Q?NG/usLB1CBxRQs+/szIE7sg9BXxwI2yv2JaccPVdfnI921KtCPVdh+b55rRc?=
 =?us-ascii?Q?2JTFYAM272BbMnplqMgngZvHmS/URu6AoAnIuJK0s35YeooYjVLI9iHP6COq?=
 =?us-ascii?Q?B0wOMbKKkSGcmIiiQuP/eENVXBY/J6zyIp4ju1+5vsblWE0KIaYKHk0/bWGZ?=
 =?us-ascii?Q?9uB9tt1pWrtJXZLPML/3CyNhSe0odChwFKeOMNDWo9kx7hiCbEW6tJMsLSqF?=
 =?us-ascii?Q?3WXsRPJUC4GyHG+DUjfEh1EzL453hiZ9BcfFnqHTu6zFyhJ6ABe9vBYjift3?=
 =?us-ascii?Q?DLLiomRc5cO4FdmxHR5wID6p6AdRz0UCQBzKBUzTxlUei2Cig/33g+LD8bsV?=
 =?us-ascii?Q?2+XP07aWp0VM3ljFzPPVEGslf9Z0uJK3ZZ1ENOLeDQv7sJufEGUEiouydsi/?=
 =?us-ascii?Q?fICqKgXSnqpzAwGqQmefQ2w6CuRL/KGVI1LKlzmXl2Vr3fUczkhw4kdlSXcu?=
 =?us-ascii?Q?0Z+328VLlccqvbCze7931N1e6einhJgRhXnrw6F8x3BbTYwfMsfmqooTI18N?=
 =?us-ascii?Q?4Q/mNpGCHXjlzGoZkbF8tjLq3tLNnQyCpjMmPPqYtO1TuIvw08GOgIPZpY5U?=
 =?us-ascii?Q?wVBf3Yh1RApW/xuTxbsnVzBVnIyoNzSGdDdTSMEveIcJqpeUV1WbjQsKpcZo?=
 =?us-ascii?Q?k2rwQkpr1TR1FCJj6iXXzH5pDeMb6p99xffUmAoAlMM7WRTKM4UhT0pPFxvz?=
 =?us-ascii?Q?TBBANlI05yt1RLKZgBiuA6vYT4nfWqhGin90pMdGgNhdkAYZ6fwpDNEMAhiH?=
 =?us-ascii?Q?xC3hjEDbtXrXQ7rwfp+ChgPkl1UHguBKVsOyPjJVs6/aneo3z9P+DL8hTyFN?=
 =?us-ascii?Q?P2Sl8Zi+YOUqcg4m9XoO7riQzM4389/1fvUjEO2VgEvW+dFfblUu5cE4Sqwq?=
 =?us-ascii?Q?vpVnwmCnT2pRK6nZ6DQcpSSqRxKmMVd1PxFOVTxI9CnRhN/JkLdShk6nvvK+?=
 =?us-ascii?Q?daduuysrQCIQLwguIa5eSZ/Oaw6/8o1gtyOr17bx30W+h3aAvvN3eHPEWxkv?=
 =?us-ascii?Q?VCb/QnNE7KyB7yFA+h+swaP6vrmixbolfEcfC6NsSKX63oZKFfbypOCORf/B?=
 =?us-ascii?Q?4//NsySF++PcmQVofxlTfRI9iq0J2QziU813jIC/Zhx+49f4YQRId/OHFEPp?=
 =?us-ascii?Q?fF9KeM3gh90EiSfWsEZhHeXbkdi3GVCV9xn6RW//WyMHf57cUPSAw5RRFb5N?=
 =?us-ascii?Q?jjvkg3mBiW16HFLqcHiQ2cl/gPQMaxf5k+A0zFqE1jA9J+L3OQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OV5HlXjK1MO3GNwkaODd0IEdkJMDLcotqdZnT7bqVLiANpHBlO0wmeqH0As9?=
 =?us-ascii?Q?h6aofK7rzmgy2nkrqkXOKrhzWUuvl6+TbGBWo3MOuizQ2DKtjrt0ajuiONGW?=
 =?us-ascii?Q?PpmQQxFgPU1yyhepx16v8QLfEaIvYiP/sqtNwQQk+M6EmoalN/6Rsfamt9rP?=
 =?us-ascii?Q?+vpKMfQrYBSs/Btp/9UCdX5Jwn51XtauVm0KP6roUlKV8pDAWIqzLhJNmYOM?=
 =?us-ascii?Q?eZeyX3Qfb4TOBQdpoRAWTIr0FcImJi1FbSUTHyGfEMnpr/s1QpVigVE2zTdt?=
 =?us-ascii?Q?HXckoGlw6UhZDc/6BtwdkyKfr9NH2o5HaKrQB1tze5MRPNlZel8vBoNzg+6H?=
 =?us-ascii?Q?mc29foOmD/UhRHbhLVGxj3WX2Toh2ABquqvieEDHOaw5tLaeq5mRulvPqja8?=
 =?us-ascii?Q?GmLMKZI8YsCNxvqU+ANzh3hVjhAMo25F8SPS5kG8vgTfSW0PoPLraM6fE4ID?=
 =?us-ascii?Q?NOl5pIFgdpja8DFofBUaRpy370RgFOHONuyjs+rzUR4AO+zsBtjDup0dgJYd?=
 =?us-ascii?Q?Tv5QU6yHCFXUyMo6XdJuTmS6PaVMBHSigz0yJidTgNXRY/bZIpTTAFB47SMf?=
 =?us-ascii?Q?9zOAvN9uvpAoQlALtU27/oe8GyZEFBoVI6mJH7hSh5y0EzLUe/eT9LOOs/je?=
 =?us-ascii?Q?DKvig2d25hQEBlb3LOOM1+rfZN3eM/BWSie/6Blz55oMBn9TBVdKRCBqs4UA?=
 =?us-ascii?Q?UqctMYjt3Wxjvwz8jh69BWH1OoZg/nKPXmF0+ryOc/IFXo7prN6SyuYzwwqw?=
 =?us-ascii?Q?qW4i3SoIBYrOcwluAHlAwJISOovZBj67ZSXGVZ2CGy5rxZq34gaNzaojh/XH?=
 =?us-ascii?Q?yuRovpIY247LAdTP1glJGwKvs4nZWKe+pxXurmw29HiWlSf3DVVoR7v/W07Y?=
 =?us-ascii?Q?xAK4Ta6ADuyVg1NeIFU1SpKgeGsNsEDbJFO4IDwQx7RNeNfmSRxF5LpQvXsj?=
 =?us-ascii?Q?9G4GJYc/cN8C4yMxLCjb+pYz3QQ0m+1rQi6Sx80F6B6nSiUhIroZKVDGxuER?=
 =?us-ascii?Q?9q/VrXu5Qf3q0uK5LUPvcg2ZmaGHcXMJmjnXxhzKeJqKTQo5gXwElxijBjYF?=
 =?us-ascii?Q?wd/AQcw4TtS7NOJTAhZUNSGVrW/53g135wOIx9s05ybEmpgFoD1qzUBup96O?=
 =?us-ascii?Q?cjOMLtjg5WRJQ0S9REhuWKDqfQaeclRfmGjPpjFjDz09mdUFrfKVIKNYutud?=
 =?us-ascii?Q?ixf6MZipygNphl5a8ui3oQKRjffdvxmwspwSGecGS4InUn0HeQ0VMB6MHRlc?=
 =?us-ascii?Q?YmvDD1Wfuz7+oa/g45iPLSDjSbM3pJ9p05RtAhS4fpHl6SMBuGZ2gej4OxQe?=
 =?us-ascii?Q?+dUfdtyaBfwqHC3oMtFQqEYyBB64Jb+nKhzuyym1Y0USzfJYUynA0LmPUsyb?=
 =?us-ascii?Q?OLFQA9rrHSc/Hv84PMaFa79Oq1nSQwV9TYd1uy5puHoNkOFuiCh6+DxnYniG?=
 =?us-ascii?Q?appdTf/bKyGChxM/2c24OLkwh3ghwWA3u+FNE3ULSilNik5ZUuvHtE8cCA+t?=
 =?us-ascii?Q?yMAKH+cpiNuPrnrba4+apHqX0CiY5Uz1ojryVU0tvIPkD0kEWa6OeWWmodEJ?=
 =?us-ascii?Q?YKrWWEkvHvGxCWBTaEoBbWmGMvyWqDw/R0Kg60cF6Bk3AlMgComntHq/7le7?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qFeMtxpH9tCQpbmIEiOGPb7Ld0HCYQp1YO/8Z0li2uKSPmfXNTY+2VAd4mNiY4UsFvchRhZ9mh4uQqn5FCdnpTr/LKNPQUslS4V1g+GIoblNU+znIswQDm6McHG6+9nEy+R0myhs9oqlmehtpoL8b/8CgpoxCY38tXFOF6X53ZJ0GjDp3UENG7LdnbdUGfuRzMXsdly5Y8thus/blnfCFIPsl2SrYeC++Y41cLnZZKfztlvU5YkEy85Eq2Qvknb29PlCE9QOXEHmNKIROF+2thhzV4E5naR3q9h68F30tfU22V646yKfoDxPSha8REyeckB65uRVZmahgcCeAkMpSytbgw2kerF5ekpARMcShRImKydzj+QBtZ2kBjNhZSAIOoHjKRZpenQEzrdH1J2zrf1n/tq7cBxJPlKfAR0UxWWr2F3K/asdr6RgM4jVTsCf4lyA63dvTyPJWcep0DuR19jBXSaxXDRZJPm5QXnUdz44qI93/qolQLPqKm4qbhJkUZfhgppLYUHxNML4NeObcaHZTim3bD6+VdoS036Wo6hVZzH997VReuQFxqUbNpQ9VlICohR9ei5VPqD/sjnUuxW/xCBV30AQAs936OodBqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bf2a97-f003-486a-2604-08ddd1138236
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 15:53:07.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLIUE3st2IzuVHb4iTtka6h+Ae/TPUV3v3QsD3VbuPIQQjq5n1ylV5BdGW7bzdTL0q9RdUCwQRxqzAM+KfTLWhd9+754WZZcU26Mr/gK1g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508010122
X-Proofpoint-ORIG-GUID: l3EJicd3uklyJlAsSS4tRcj09mU74zmk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEyMiBTYWx0ZWRfX7gY1yrrHP5Cz
 L+ow80N95O6GgIqcVkIQA/+09j6kXjhEkv16yMjXcFcQUhwrU4ISPjlyBrLXtdDv8AjhvOd9CK1
 HGL4JKzX8ZxT9OizYVtxUKE5ohBUfLLea8JuVrxVwxQBl6XbyGH4vL+I0qivm5IvNP4pyKePe/0
 uFQZbNXzw8twMU4XFscYmx4CE04Z1mCE7Fv/nvqRVzFabuP4pQuDYoZJ4M7wrBZrsUhLrCeZkyX
 N7q6lxnXwpWf/NZfsR2MIQ5hp35DJ8J16V0OiW54M2p9QH51yI6B181+w8UYVvoQqwtxIRIv535
 xGOLtOpGxa3Y+Wyp++G/LmDB2pfXohfDWbtipwUlDZdkXyFqDQrlqHZXnSiiw2665hjVQvZCyCc
 SmL5JjOIiFZYPSzb9wf1PH+PAii6mFYFgLX3mGNo20etj3gnEcH6mYXxawibaKbR+QbMEobK
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=688ce2e9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=p5Tm_5Oj0aXCBKwpJbcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: l3EJicd3uklyJlAsSS4tRcj09mU74zmk

On Thu, Jul 24, 2025 at 04:49:58PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> As we already moved from exposing huge_zero_page to huge_zero_folio,
> change the name of the shrinker to reflect that.
>
> No functional changes.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Makes sense to rename other related stuff as pointed out by Ritesh and
David, but for this part:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2b4ea5a2ce7d..5d8365d1d3e9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -266,15 +266,15 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
>  		put_huge_zero_page();
>  }
>
> -static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
> -					struct shrink_control *sc)
> +static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
> +						  struct shrink_control *sc)
>  {
>  	/* we can free zero page only if last reference remains */
>  	return atomic_read(&huge_zero_refcount) == 1 ? HPAGE_PMD_NR : 0;
>  }
>
> -static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
> -				       struct shrink_control *sc)
> +static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
> +						 struct shrink_control *sc)
>  {
>  	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
>  		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
> @@ -287,7 +287,7 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>  	return 0;
>  }
>
> -static struct shrinker *huge_zero_page_shrinker;
> +static struct shrinker *huge_zero_folio_shrinker;
>
>  #ifdef CONFIG_SYSFS
>  static ssize_t enabled_show(struct kobject *kobj,
> @@ -849,8 +849,8 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
>
>  static int __init thp_shrinker_init(void)
>  {
> -	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> -	if (!huge_zero_page_shrinker)
> +	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
> +	if (!huge_zero_folio_shrinker)
>  		return -ENOMEM;
>
>  	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
> @@ -858,13 +858,13 @@ static int __init thp_shrinker_init(void)
>  						 SHRINKER_NONSLAB,
>  						 "thp-deferred_split");
>  	if (!deferred_split_shrinker) {
> -		shrinker_free(huge_zero_page_shrinker);
> +		shrinker_free(huge_zero_folio_shrinker);
>  		return -ENOMEM;
>  	}
>
> -	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
> -	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
> -	shrinker_register(huge_zero_page_shrinker);
> +	huge_zero_folio_shrinker->count_objects = shrink_huge_zero_folio_count;
> +	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
> +	shrinker_register(huge_zero_folio_shrinker);
>
>  	deferred_split_shrinker->count_objects = deferred_split_count;
>  	deferred_split_shrinker->scan_objects = deferred_split_scan;
> @@ -875,7 +875,7 @@ static int __init thp_shrinker_init(void)
>
>  static void __init thp_shrinker_exit(void)
>  {
> -	shrinker_free(huge_zero_page_shrinker);
> +	shrinker_free(huge_zero_folio_shrinker);
>  	shrinker_free(deferred_split_shrinker);
>  }
>
> --
> 2.49.0
>

