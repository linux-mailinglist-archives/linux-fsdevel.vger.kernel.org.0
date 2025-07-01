Return-Path: <linux-fsdevel+bounces-53470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A9AEF573
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B96D1BC7A63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FBE2727E5;
	Tue,  1 Jul 2025 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hM1gHXM2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o7yPG9ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28427145B;
	Tue,  1 Jul 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366722; cv=fail; b=hq3fYBHGHH7IFpOK0mhnpQwBfnt5qi5GsjNBRLKa9N5w4PgoOkw06gPirq1+nDwWZTNJDQwevgHH0J8718rBtFHOQQ/1P6Fn2/HLfDTOYRCeK8hocqHEYU0VSsTg1iEmu0J2Sggav58BSjOG39PLu0iQMSX5vqRMC5A7bJKIO/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366722; c=relaxed/simple;
	bh=/CnbVL/G6Nq8XGd46de5Bj7cQUOn0iqobc94xYoS4dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ipthgy2QpVAz2r+v4KVqMUYvHkIIL1RKtl7B/BkWMu94FN0u6j8V2GPNRRopotl/3suzQrpRb78jl3/k/+vKWhlPYkH+5EXAzwHDngdHDascWJfsb6yi6IztKYfBakXBS8vsGbwL5c/ioelk/tj/TBk+6xigqpT4LMIQHu7Qzmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hM1gHXM2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o7yPG9ju; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611NMtp008674;
	Tue, 1 Jul 2025 10:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/VWynsSuaRGpdne87j
	zQQMCw4voE++hQgQllAxx3LaQ=; b=hM1gHXM2z3RPekH5pQ73BA6T+DssFmWnEG
	WuLKhAz0kqIDh32I8YtIwiisAE5Tz2DNkkiYE7up4W8CpQJtKWxtcAN9ScFi/AWs
	jQ7ZkZFVo/c0qXOIYkdrBtyjqhwynBGap+Wiza09Qtixb77jsi6lXucarzLFI/no
	mvP3Bh8Ym77K4Vw8zSDqVOZ8/B69zTLV4jMkI17xPo2CtsO9hrZI8/Tyy3sue4K2
	9edUkPyU07QFdKvEQeLGJ/cC/umMh/NNporRWVVNXLV/Tlh8GCoXhWTdcvlwykXM
	rUlZ4B5fPESrZFMxh/eSSFHjQpvQoCKJsQ/RVhtwvZBZxbbwn9bA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx4fat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:43:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5619r0WD029743;
	Tue, 1 Jul 2025 10:43:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9jr83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0jsoF3iXT33/5YL8BNIFrw+nyyp0IwoEjGbRq7mJ+nA6Qs9Vs1p+MZ2VBaGtvYHTmCllNkC1tLCsso1uUACQ2s6sqqUPM1mqzzn8M+JIiu6uTbROxrrQ1+TnVvd82jZYr2k+6eGsUkIWJ+pHCaEBzahAWs9cyNOGHgZZiJve2LbrfNQ/WN76fzm5Dx234UifFcSqbc3Ldv4Z6o6LUNo8G/z3ExUhOA1RGs9+90/Fx5FxuYsRN72zTDZieY5U9tV1Vjhtctr37QiFCYWpgludgropAPTgj+hJPS5wKctAGEZco8fHx9Dg43/1ri1lvgg7ntD6Exlp9ls6dO2ttLgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VWynsSuaRGpdne87jzQQMCw4voE++hQgQllAxx3LaQ=;
 b=M9TvARJyEou4ImzKe9bbK1COzHc8bOkr6yfFlUvaNVNn3AHMpy9Y588Uu9WHBXEm33Kt0Vo+X7kBnql83rpnW/0E3igCXYEN/zZ79T7RaYKonTAttKrL9ZnT6Q4lizMPXpa1WFxlhht6bwIBLFkLpezaDVlTblvP6TP0fERoFfJMQx9nACHzppWy/eiURIrFqUSeFQRmPILwWViS6VYhN7e/VMSZhXdDttf4sG5cATDHwb3IA2iZOWS5qSaaMB7f0am/jeqvN6NxXr0pLDYuknEEwoqdOtJzOu80S6G+WMU7x0+TvgWRcN4TRmevxoiUUksH71RdQGUeHf0gxpYs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VWynsSuaRGpdne87jzQQMCw4voE++hQgQllAxx3LaQ=;
 b=o7yPG9juFoWNoDQjyP7x1gpJ9gt+FRr2TPPlpCZhQlBKVMOsDX+T7FWJBRpRKM2Z2HL8JIW/Txxd/Lzm18yGe5MocXfc1BA0lSnH2oU1/gW6UIYlNUpUQBn15cv98AXueELxiVDP1gVu3tsDWQXaLrLsqDxbCPd87JJaJMYvYIc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8373.namprd10.prod.outlook.com (2603:10b6:208:565::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 10:43:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 10:43:47 +0000
Date: Tue, 1 Jul 2025 11:43:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 14/29] mm/migrate: remove __ClearPageMovable()
Message-ID: <24d2b984-857d-4a11-b016-dc0227d81c88@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-15-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-15-david@redhat.com>
X-ClientProxiedBy: LO0P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 597dcfb0-1800-4cb2-aba7-08ddb88c28a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3YKrfk02mq8y8lat60t1QN/MCucaSKQAiTKud/YgYhg7L1WvU/uN/4q1uTP?=
 =?us-ascii?Q?T7Tz1jpMG7yE3gK44+KE8FD+F4XmfN5jBFjN/VyljIKlZG9KkE0nFHYfmV0x?=
 =?us-ascii?Q?bx3d5CaHXa31th1QYpNIk0qDKametHDXTSb2OIybwtDnz2N3iizWUNZhCV7V?=
 =?us-ascii?Q?PjN1kpNMsnHPWNTh1Mma1S5I1uSETxY1SOEi/j1ZPndx4D3490DIiducvFKU?=
 =?us-ascii?Q?QXMvA7xSOUo79t4wQCFBfU1DN7dk2+Ddg0lmfMFHiq5OPCGxjlc5Bdx8imnw?=
 =?us-ascii?Q?xdNtFSW3+RYNNwbc2BXC1BETQmWampdIh7u9gbpNPTVaNkHIlK4tE8Ep+3xI?=
 =?us-ascii?Q?64pkY2Ag5VUJ66uuYDSzck6NpNY3/LyVg+qly1tHeGo8nNtoz3HOrsYB+yWB?=
 =?us-ascii?Q?LLmPNkgikGANV/zls0pc7lZcW5Eb8zdmkDm+BQCNmzATPfpc6aa4/CwUqEku?=
 =?us-ascii?Q?npDNqsKxv5/MIsVkBCL1qP+FBo8Xv2U/RiJ5IPRTiheCMWrHGZVhURssY7zG?=
 =?us-ascii?Q?EGI6rQ8/0j0R4duNHaeTKBA8IIkZUIa2muULmBqTgfOKY3A2PRV88PWzkO0e?=
 =?us-ascii?Q?+LeNNJieDNlIVzvqhZ8Un70cBYicwlmn6anGDOMlLESXbMwQeYEz6+NpV4Ev?=
 =?us-ascii?Q?M44Gp4kl3rJyMOAxXEckuDZ/vgN3ZMmPEQD9OBRZahBlicD+l1TibT2nG+qg?=
 =?us-ascii?Q?175V8slqpDolERAFNLOo5ZfBr5edfm7P4ri05PJvLGX3ZdA9jeUT5uveUM67?=
 =?us-ascii?Q?k/QGPEEoNWZ1SKnGDf4zl83nEga4fMp3Wz9QR3ri1P/aqNS+TXMhrkSQwtmS?=
 =?us-ascii?Q?mGxIWBFgB2wLuaSli2lUcy2Gy3VxLPi6AGigLQkxyeqTO7tsm263vcaF5DC2?=
 =?us-ascii?Q?O5wu74BjlUxTup1/Q5H1ZmUAUhbYyy5g/6t043rXtdC+zip0xIPVuPgSuZDc?=
 =?us-ascii?Q?mtqplvkerhs7ZxstYsyeJw/Dg6k/9BZwelnQW1KCmPvsgCagLHGz7UMpHGLt?=
 =?us-ascii?Q?nJx1wH/UzTIedAsAP53I1tSxlNnFuJUOzXq6Ln6eHEb0lfmUVGABCwFnHdCz?=
 =?us-ascii?Q?B765VfjftfF5etga5mP42d0wfbxBKF3TFj5WIovRl82FctDwjznQcHyD9P2F?=
 =?us-ascii?Q?AGf5Sl+u9kAB5AVakuLBwILbtSrBOWJPklfx2REYEGyfII3+aBO/5bQTPhWo?=
 =?us-ascii?Q?HjKCExNiVjztFlbq6NUAXh/XF59OAIHSPzmIG2dNKsBNRCB/dSNz6Suhquqp?=
 =?us-ascii?Q?ssgODgmvSNLFrBGOJ8PHF0BmVeetC6jXEDC5xnw6RHMTozHTf+qrc6yofp2V?=
 =?us-ascii?Q?ep3hv2gznDHsvqyju3r7YshS5u9dFBhjptkEYKNoSu/iDU03hgCYDKLeUQKh?=
 =?us-ascii?Q?i481Ezsf/blXvhaZUqRzB26UzZ6dVBw4XYLJJF5HsVfYHp9NOo5YtHiohA6X?=
 =?us-ascii?Q?PAN/ISugh6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9XKWVMi9c7TFlwBx8QtLGqktb8HHZLYQkUE8WQ3pX+dL5bjRhuLIs8z2t13p?=
 =?us-ascii?Q?gYTRG7gp49s8LV0HGmwXk10CgWGceX4pB4hBBKerkm63lBumsO5/PktxloHR?=
 =?us-ascii?Q?2SSe17ojV8glciyhUcdKlnq40gD9vWa1K/2KM8TpBHJexHXIyC0B3Yw/KmyM?=
 =?us-ascii?Q?/Ry9VXKGRMfKJ9nQTqiB9B5D6PV5rNC+zQijBJvcpln2ITHeSr44ZRWiHstK?=
 =?us-ascii?Q?aasMfcTJYpX/DQhNlUQ1guN7kzYROqI8CVpK+53CjV1aPFrKRY5BsfPjy3GC?=
 =?us-ascii?Q?SR3z8bkvf3l3UMjqDz1gl3wnqbPJB591bYnCxw5uYzyTkMXKHr1oGQOrrEco?=
 =?us-ascii?Q?7pcEeIXP2pP+VcOzHynwSSffDBuJWr4UjqDGl4P3rDNGycfNfwQM6vmP1N7g?=
 =?us-ascii?Q?FNmONIQFd+3XG3U1U77Rug3lA7IIBOq/k9VmiesG62zPWtBCxGkonNRT/LlS?=
 =?us-ascii?Q?jbFFjB5p+L0RDoO25xZ3eyQFBVrvShWvKPzaiIUX2tkmPyZfcDzsq/Yql7E1?=
 =?us-ascii?Q?/ODT+a0IqJeVe8mQyE2coX9lzhMzPlKCoNomB/n7sagGtgtt5LHybKwEGUKc?=
 =?us-ascii?Q?3EZWmbRL4L9DDMWXMUsjBOMyZDXi+BmGOxliyNz/U4XOHDwakEcITGXpe3EP?=
 =?us-ascii?Q?9FNlRjDR69ODwg/QmPtSyNxn64yRUpqJa/tYq7prQ8uaEhT6GPXtiy67vokf?=
 =?us-ascii?Q?9C6f5FoPAadC2RVlgiXsbSyYWJEkrg9/SHWqdbNjV1n34PTmPb4BALxapkmP?=
 =?us-ascii?Q?cn9CzSaWRgggKwow8Gh5JTH+3iGCTxKLM/DJ3HLbrSOjf1TWSAeaK5Lq89xt?=
 =?us-ascii?Q?ttxxRa0yBEomto2EiK6VpV9taav+pBC6u30hmPdSzEHn3MN0nlLYrzlh+R1X?=
 =?us-ascii?Q?aWMnmF/TC4FU488VQvLuBlqX/xI59JFrvTxeF4Yea9qaEJpB+cHGGSFVN6DY?=
 =?us-ascii?Q?9gr36rVvXES0/6OqHtJiLWmXktOlB5AgxywjSbr56tklMZEUMpBaAphrwRgp?=
 =?us-ascii?Q?Xy1se8V+yFE0XKak21C1YthClAhqFd0vCYls95R90W/cxRKcJkWzoBUEJgq+?=
 =?us-ascii?Q?tYlM79DIbiq9ySN1o2qsBnHJu8J44lKryQ/PuOEXevswVabyDe/weFycsFFJ?=
 =?us-ascii?Q?cRk1mNkryjHSjzMTW2u9ccn2j5Cx7sRION43//2bY0kELqNkHaCCFUwpYw64?=
 =?us-ascii?Q?xPwnb4vjyfPOnnLj08x04HNP8uxxF1EwaFILcqP+w7WvyN/4SSPYbKrAvdET?=
 =?us-ascii?Q?1NAOleuglJFvRgxSG7yCAD8CYS83dXa85zuY9aOqXblyZmQxcxXuswsZPvjG?=
 =?us-ascii?Q?3NKy4iW1lCFWz8mPvWRF2LPdBWGiG8o35MGaD+h9MkHwkKYIxUfGnT/ds3XC?=
 =?us-ascii?Q?YPfXL2mlRkzCz2YMRJsoWXK7RfrIoXu32kUUCFRPZ+EGfzh1/s3LMAlM2Vbn?=
 =?us-ascii?Q?71q8ZxyBicDYSr270vsvDtztj3MnFrZbq4OyPOyXUmLoxugp1Z2FwBxHfGJL?=
 =?us-ascii?Q?jdts8py1L9uP8hmgg4OyH6tiNVVymxgOP2pJNxn27kI+4Lmoe3AHh1Tk5vnD?=
 =?us-ascii?Q?aOtQhbaXJC0wE8xgyuiCbw8dee2WeGFLGrqgO9j1ohsodCkiqnAzpWny5RPY?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lpZzGQXWgFQAI58TlhAp90fOO9mdlwDp0W/WypKicgLZTb1xRMZgNNWxrd8WzXHSSHJpaYygeqB/Dc98wZjosLB00l04KLe68/WyFtMp16q7j9Zt3mlTqWhtAkgin8aL/H4iklJIyH18UwLKAoWkksw1poEYOju+s2GY+pIIYI2Rr8rwfuIKPXzY2QL0QZjuqSuP89ssDUSXlWYYmyT8K7JiiaFL9ZtQ/0uXRq5R/9lZdPtrtHF3jPciYFDKOscoJ9KlfRH++swgs7YVHqWSLLOfdVedyab3UXIO9yvQjNn0ji83Zlv51A9DDyhmv006rwdR6HAnlEuCpzbLgFAoxI8pZPxgEm5xQlR/+oDWURvKyIZpYnAFCrrMx5uV40D/pkmLEn20uGYjd+le+HAbvmDsnpfn59terr+L//JpUGpjWjHGVlritMEiyn5Az1DfCH1hfNbvPClu/nLOBxVS1yEaUWgd5qmJgTGLWqdXtQ40AI70dgnGPe5h6eDpxo8eYSSWYYwKOoGYaQyMhYuXqo9inZRr1FvaH/ZWrGoqKL6AAGGUjoO+s1JfYPUlYaJIBln+lNf8GBCBXwl6lCuTFzdurWLwVek9v+uJfmFLl+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597dcfb0-1800-4cb2-aba7-08ddb88c28a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:43:47.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p32osh3P9YfKeweFan0HkzM3kpmbYsnBnO8MEXA6rcSu+dvnHbYEJfgE7nwyVKim74HvyrFYxlpLlDnhFPjzd4eVCtWelhHE4qI8fnFuXQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010065
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NSBTYWx0ZWRfX0/jPGEpkV/bD 8C0KGB63LKKh5miYhHcFSkf+kunNCrVeXoqLmRvxeOJUp0jGBNgzAuauE6BBi0faDwlA4iCqZuH 7WG23titc46rH7cNjRb++sskFdjooe7ZKWSgbPVKigDjR449eeyTl+P6YZ4OsYGo9Sxaa/LuH2h
 MkiwWlDfaiEn4ir6x/BdyOR2YdkVS/+OCNoVA6YkS1Bs43nDfP9TmLAqCB1LKTLH8RmRnG8bmgb xQ8PT30Z6OgpT+X6e5CkCzer3suIbr/r+lfEhwqmWpU7CF/n49PSWJ5BD28zfwycwCw4PV2VAzZ Y2fFXwQkoV09B0c3yKSvX2MiHQP+7prMdJTovY7nrVIJQMe0hjaIMoCqPEPuhqACH+wfxRJ4+4i
 gbOEPUQHfVgpBw0oAv7T2tNluQpjRDaJV+XvjwoEuZSvC7sOyBkosRaQA2KFPAbUefK9e7sS
X-Proofpoint-ORIG-GUID: pqnNN523keSU8QroTb5EvXEdCzDFrobq
X-Proofpoint-GUID: pqnNN523keSU8QroTb5EvXEdCzDFrobq
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6863bbe8 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=KojgDtQxXYKJGcIna18A:9 a=CjuIK1q_8ugA:10

On Mon, Jun 30, 2025 at 02:59:55PM +0200, David Hildenbrand wrote:
> Unused, let's remove it.
>
> The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
> still mention it, but that whole docs is destined to get outdated and
> updated by somebody that actually speaks that language.

Yeah I've noticed these getting out of sync before, perhaps somebody fluent in
Simplified Chinese can assist at some point :) mine is rather rusty...

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Lovely! The best code is no code :>)

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/migrate.h |  8 ++------
>  mm/compaction.c         | 11 -----------
>  2 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index c99a00d4ca27d..6eeda8eb1e0d8 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -35,8 +35,8 @@ struct migration_target_control;
>   * @src page.  The driver should copy the contents of the
>   * @src page to the @dst page and set up the fields of @dst page.
>   * Both pages are locked.
> - * If page migration is successful, the driver should call
> - * __ClearPageMovable(@src) and return MIGRATEPAGE_SUCCESS.
> + * If page migration is successful, the driver should
> + * return MIGRATEPAGE_SUCCESS.
>   * If the driver cannot migrate the page at the moment, it can return
>   * -EAGAIN.  The VM interprets this as a temporary migration failure and
>   * will retry it later.  Any other error value is a permanent migration
> @@ -106,16 +106,12 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>  #ifdef CONFIG_COMPACTION
>  bool PageMovable(struct page *page);
>  void __SetPageMovable(struct page *page, const struct movable_operations *ops);
> -void __ClearPageMovable(struct page *page);
>  #else
>  static inline bool PageMovable(struct page *page) { return false; }
>  static inline void __SetPageMovable(struct page *page,
>  		const struct movable_operations *ops)
>  {
>  }
> -static inline void __ClearPageMovable(struct page *page)
> -{
> -}
>  #endif
>
>  static inline
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 17455c5a4be05..889ec696ba96a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -137,17 +137,6 @@ void __SetPageMovable(struct page *page, const struct movable_operations *mops)
>  }
>  EXPORT_SYMBOL(__SetPageMovable);
>
> -void __ClearPageMovable(struct page *page)
> -{
> -	VM_BUG_ON_PAGE(!PageMovable(page), page);
> -	/*
> -	 * This page still has the type of a movable page, but it's
> -	 * actually not movable any more.
> -	 */
> -	page->mapping = (void *)PAGE_MAPPING_MOVABLE;
> -}
> -EXPORT_SYMBOL(__ClearPageMovable);
> -
>  /* Do not skip compaction more than 64 times */
>  #define COMPACT_MAX_DEFER_SHIFT 6
>
> --
> 2.49.0
>

