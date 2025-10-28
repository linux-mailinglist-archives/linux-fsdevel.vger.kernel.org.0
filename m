Return-Path: <linux-fsdevel+bounces-65950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDDC16780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 19:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDEA850510B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957513502B6;
	Tue, 28 Oct 2025 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pmLlViYB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A5oiQ5BL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5573502A7;
	Tue, 28 Oct 2025 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675851; cv=fail; b=mzBE8PikUklP0942SGzm4CGRFAGoJAIDYDJGvFK+Hm27Nw1y4688hdvlhdDB8MfSZxZ1KmOrNYGIg7n1X/hnPRMh/jrylcDzuECYnYQ4IiFMSfvdlxhPqVT1+Y70VIpFP+RAts3Xcw3KgVX2NeBpPtTJLKSTxzZ3Ci3VpbyeSmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675851; c=relaxed/simple;
	bh=NXPgbQ1l14YsQYpaFbVrcQlavhun59QGMwbIZ1Ja5m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mReKGLm/Z3lxH0gigWnyh9uE5MtyP9BjYgbZzETs0uYNH3IRjBJFSPhWF+rjdNRECNf3aufVJ1jfia7DgNePJMx3iqnaTVak+WlQmy+60Dg2XMl4dm0VRVI898PTG0v5nDaBh6roOAy/+fENi/Ap2b6X4ZF2j62nRhQhTLZDmPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pmLlViYB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A5oiQ5BL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SGt42s015469;
	Tue, 28 Oct 2025 18:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nxkHhfyYfMxig4Ynu+
	twA34J56v6fYugccjR1qkMKhg=; b=pmLlViYBwSDOup4F6AH4JRyN2JRdLyK2ty
	bGho0Xnj7ZEUQLTBNUoujSZ9Cam7huDEsaIVtl3d3cBQZVRPG6u9ceQ/yBNglabz
	XTVVin4Zdb7+m3nckVvpRcEdcmekmL4oN2qY94BM4l4ZAO4bmjq0daBefseEveXj
	j0Q+XqqY2X49nTGJK1jcYTywIT4h7bwA3jT0Pxql2QG3F3pW63jiEkvI/JVVp4r5
	9JWrPTzQCknEhUGkIg1P2tMZZMb4Afdns5NpdYb2H2gBvKR3uPZxZyrW3oYfxjjf
	4Maiw1uDOPpDX1z0u7WOL0ab30o3KcJiUVnGNP/nodjx5jmCQVEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ypyn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:23:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SIIQte037502;
	Tue, 28 Oct 2025 18:23:10 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08kb8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:23:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BisPJkTg0+DMecz98r2oTaUHwfoOKUpoG8iM0gJII10XZ2aRbdgnsaKib3KNaFKPt8eoB6ZbqVXEo4c5v3lubR2INaG9H6WHeOlsaebhx29IcQ7g5KOaBgWhaXxUI39r3IT3A2+OxI/guELNEEVENWDMqQMMubHFWyBqw8kRahlPvZ7ANZb9e9vsk5zsG+/sOVmsjeb7YZ5paC/YU8TuP9xQTOmIYq9f1FekGJY7LObzj27dq01ZfdqeyaJuRCLDwFmluh4U/7cP47hPFo7yjM2SufjKJ5jI6eG9VMwtM8ACxyGic6mSYdqlQO5+GbcPbF1Za2WBLQ/7whpqW+opIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxkHhfyYfMxig4Ynu+twA34J56v6fYugccjR1qkMKhg=;
 b=nygWiGy2QNQGHrFT8qXDhOseIxHPxAb4tGjQSo8in/NNncEa1XjYov9hZC4IwRM4tf1rn5JsieUFx10XaGTCnUdpatNJPalI5+10+dsFM/CFIRrvl5sds4jjPbJNSl/btnCi00KqyKUFKdwsdg2nOQGjrZ45HpYx8TmBVW9/BgmCv3cQgkHRC5VZvOvBJrU6nadWyAPcIwtkd1WJ477yhhOT2jPm1AUUYEpp87EhmU/FkDaj8BTK1w3SBB9TmFBO1AUUZgH1vDa5ZUtJwG9damEYi6Z15m5CCKD/W1dZ77CmB9lSgePtGAQ6w7g1NTjkizCvncdwkCK9+4PGP5yLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxkHhfyYfMxig4Ynu+twA34J56v6fYugccjR1qkMKhg=;
 b=A5oiQ5BLGP73hSwi1nbv7NTYZSMsS+7kW236PMKYBYMzjjtm7cignmCADEzG3VK/solmP+jKOcaZMuJtmFBHFZK5seXkalpgqky8tYOXEWhfgl/X68wKzGXi3zztIqYy/wJPVjBxsDid51oafaWtoRTsmbjJuoP5QliLp6n8e1g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:23:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 18:23:05 +0000
Date: Tue, 28 Oct 2025 18:23:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Hildenbrand <david@redhat.com>, Gregory Price <gourry@gourry.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
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
        Leon Romanovsky <leon@kernel.org>, Muchun Song <muchun.song@linux.dev>,
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
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <1881f35a-76e7-4012-a907-51810356c680@lucifer.local>
References: <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
 <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
 <20251027161146.GG760669@ziepe.ca>
 <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>
 <dac763e0-3912-439d-a9c3-6e54bf3329c6@redhat.com>
 <a813aa51-cc5c-4375-9146-31699b4be4ca@lucifer.local>
 <20251028125244.GI760669@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028125244.GI760669@ziepe.ca>
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0929ad-e95e-4e54-dc18-08de164f098c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fJ42J0ggGghcne8Rttv3GX+I3tPxwbRPWDfQ665cIvZjNGLpkOvcy60XwJeO?=
 =?us-ascii?Q?vndYkYqMMkGavTFszh9YCf0tBi0lJCZEZQ1akFD7JSVUjiorQa6CguW8wEuw?=
 =?us-ascii?Q?Qu5uh0OsVV/v6dLH/W3Ab+n0Db2VeMJDJlyWR2D8/d1Wl9GAvdYT0eU6RiXS?=
 =?us-ascii?Q?zjmHNKpvGSOxYptnU9P1SHznvdD+h8l/f0LIr7LFPVxzZoVduSgfuf8cDVXo?=
 =?us-ascii?Q?6W95Viva4jX8lp4svkChSw87x6CEkNXza75vWEPCAIIlfzV7ZSN1iIG6T+Py?=
 =?us-ascii?Q?o6hVo3uEK4ISs3dkU0PWH6noiVrDJzdAPiSZ2R05kDZ72nuLqN/YxJawcktW?=
 =?us-ascii?Q?h/LbuDIg9V0IAw0QlgswmWC6PQMY9c5w+pJA6Z4GxdjRlGp4Fu6Qs/uGOVJy?=
 =?us-ascii?Q?oV7fTIPffacVuJo6UsHZL5TrITiXQmfz4KDZ9BRUz0MhSfjT3jCKylMxlpXb?=
 =?us-ascii?Q?kbb71FNRP7gxwVfC9d8v5rR+j0XA6xsKIfGbi9ESjmg2ne70Bmqd9BAP7oKd?=
 =?us-ascii?Q?IazFg7LRtReQ1c/VOx5dZ16ve0Ik+m4XGbmVOttTceTQVeJMbmCV2d26UOK9?=
 =?us-ascii?Q?cB9PEdltKZBJrEBDSHNB6Sss007BtJXyOaF1ZSegBDrURGr7UQvYfKGeK9YP?=
 =?us-ascii?Q?9OSgeFHo++rkHSeN3o0qPgz63qwv0H1b/PqEimwmwTaXqxq9HhC826sF0taM?=
 =?us-ascii?Q?bo2iSmUs12Js+FYN2sZR0465S4ZwGO9NuaWKX9M4Bk7J3vhU+sNEHdbiBCg5?=
 =?us-ascii?Q?flGyoxIpNPgwSvXD7VSHG+5QWnjfKYqsdgsYeduqzmr+RMLkRH/wCQQS3zHx?=
 =?us-ascii?Q?NTWyglIA6binKBPYEx3Oed5t49gzYOn2w053Vpt8VIC5LZNSejahx2ovfYlY?=
 =?us-ascii?Q?zFx6h6pZFf4sDrHvwEfAIMoDz2T+V1HXwUpXOIQpjVBlQ0hDVA0FT/1o0MW5?=
 =?us-ascii?Q?DiLJXhtcWxkhO6/0r9cL8RSd74OmGXP6giTqHuwYVlHUXp6jmi6m7xuhYr2H?=
 =?us-ascii?Q?fUV87H1gRov2X8qdDJEQAeDarcJb2c9ev3qjweUXDew/UUd1ih9Pn0P1uv7o?=
 =?us-ascii?Q?wXxUOLAOd09cChbSFKFjVjfdTN3RGOBlqv7hfFM9z4QyP8lmOQ0OFIeHmbhJ?=
 =?us-ascii?Q?O7dnd5OgmPrm6VwTrV/MWwp57kSNrscTDhMRRnGBIVY9kTonXs7ru6UqFxZa?=
 =?us-ascii?Q?iXgIQkcswAUq+J+LHLzKYSif6HnnDxz8KW4EbSOWNCs92rSf0er4hFfUcf0W?=
 =?us-ascii?Q?u895KcCysE49Gd9K0TepaHODGp6VOukQnuC9I2TvQfOByTmk3t6mwsqnzmWJ?=
 =?us-ascii?Q?gdgm+jQ1oS5hT9Znr+rZL16LTI/PKb+lE90XQDF/Ns4BqeFzIERcRv0coaJb?=
 =?us-ascii?Q?IJKRhf7H1HHixbACP66jY0zlm+5LMyQgazRtSDTXmm0RfKD0WzSPRCFnujTY?=
 =?us-ascii?Q?BIx8/M6r9Iw03CdKpg5OdzOwB74eEw4L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?noGTx7DM0JLGbACWe5IhQHoSHqyApLpn9KYA1woYQXrJg8Yayd5I92cuL8BV?=
 =?us-ascii?Q?9K1nM3s60lI6A259GRcnFQ0sV4qlgk+NYoy3NHyQBvHAJOO3g/gzc2u/iy3A?=
 =?us-ascii?Q?ZlTW9/P6Q2uGQJGSRXshHW4FncFcfARr4QTIx8DXjyQLfXsywPKnTTbXZ9HC?=
 =?us-ascii?Q?mBcx9ymz7o8Ygg98Uwl0SEbzHOtHvDImJ7bpW16xGKzc15igmW0MuhecZxOI?=
 =?us-ascii?Q?qF/BVUpnmCxVBumc/rwE39ctOBC8HH9JOZ1+jVyZSIuAn4nVxC5hkZEqdDDQ?=
 =?us-ascii?Q?jYZ2rSOQOk4Z8ZGh/6KJtjpwRbgpuYrVH18Q+saJKX/TE1OLo0yOgCKDsfI2?=
 =?us-ascii?Q?1TETaEtMy/JKK60CBc3dxCNzY6AdlQb4T+gOS+oGhpiXQQ9YUUqxv5D3Aiol?=
 =?us-ascii?Q?942kWnrCNRyJkDJO4I939T+kwEx6BnCAPDu9S71FtN7SkOLcIsMGxzXXloJ0?=
 =?us-ascii?Q?3uQf+ZrUa/bM/n0/t4RxqNkkpcU9t1LfOxNX6rzMrXj5yWCNkwtqEcJcXa9O?=
 =?us-ascii?Q?ba37t9HPiDebKNx1ryM43usoj52aCrrniWOrv1CqPgCMCES6GHcrgM1Q69op?=
 =?us-ascii?Q?NBUlQ7jE7NjHuX+Zq84HlzKEhue706DTQizJW6tm+/8c4hJAvooMqKdl56ek?=
 =?us-ascii?Q?5FWw5b+nO9AwQ6zu7gpzTndKsRErCq2h5RPVCb089o3doa3rA9HncNTq040+?=
 =?us-ascii?Q?F+vWmq9Vb3I5hKnCPVql+pzNLny/eCJx0j53dAoRyBI4BFqoKNK2yN4uCV9a?=
 =?us-ascii?Q?L/gqCPCriJIZ+53ijKVgYA2C2Y8MxHtlf5ZAM1FtL3dltAoznjNg/JS9OCJf?=
 =?us-ascii?Q?6tweeqQ0V0VNzvtkUjCGPdc1YbPM546/Zk/x0oWFLrh7ReCKtVvTldrr60P1?=
 =?us-ascii?Q?bVCknWLSpSg0TwQh9+Zftfu8D/9MCfX1FAL2p1hlgt+VdF7QiWGjUWgEJ0/w?=
 =?us-ascii?Q?ccMDC/isI1HbI5RobIken9q1e+9TvzGcJ8ML74bYEgf6g16Qxo6NiEuVAuQO?=
 =?us-ascii?Q?B7ul8KKi+2IqxDpVterCd5t0l2scNP5b45mVGtdHYPdIgJgRZMCnjW9s+eA6?=
 =?us-ascii?Q?NYdeAkKiBip4Ctg+qhnNE+L6yZbhHg6X0OEWYvf6+PFpRwtbU5QQq12fbQ3o?=
 =?us-ascii?Q?26UFLVBaCwXDuAUNdhr2vqapFiadrgvPwG27mTpmHKD4x+Akzk8oodUFL7fE?=
 =?us-ascii?Q?Aemx7LdcL+Bg2EfMAFyvKVlxxvRqmFBTvDniBkct/JgQZ+LcNYqJtnts6ohJ?=
 =?us-ascii?Q?GlGEvpyNlN3oyQTI+pFx/J8CDTcRBUBQBbw1E4cxsf9Z4dWgM4osHP6Wdw8H?=
 =?us-ascii?Q?HQDrc5ZJHcfQZNcyUnkCYVAxBIPoEE/9ybT+UQtnx9qNN7wLRd18EQk/wVZZ?=
 =?us-ascii?Q?OlwcqY+86/cREH7qIYlp5n+oQLMPT/gVhHHK8z0PiX0dkvwVRXe50WCpoGOZ?=
 =?us-ascii?Q?haSr6ToslHms0lb30zuj86ocj/ls0REDzMdSUaWQoqFb9I8s8YArchSbDh5k?=
 =?us-ascii?Q?p/L+9Gq6lJSFbTxBkSFUOegF1UMeb27EmEI6l0X+DYSHlHO+VRgZE05qT5jc?=
 =?us-ascii?Q?GXvakcpf1i/gC5YoOEv0K7TxiDJ7S5aVssc//Ba3xSiJyVc0uzMCnu6p5b/j?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	onopunD2D4zoa+0pSfhIQ/oyuEmtHSFEGqZOHkCxoUT1IcNCnDAWDSZPRrvwjcJ0xW35wp3P9xl0iO5WkWurOu+C1rLQog35sl5m5LfPNe55lyrEVWKYtDhIoLb5ynReQuCy5Wjur8FPdXT+IpAjHMBRNdzAFi7f/qAjwFsT3IaJxBuJozSUL+PlEBZISNv/JJbD7ta44xxidmzRSuOqH9C+FZmo2n8Hs034LkAtt7a7G40I4DYk2+o5cT5fT++57PDZt/A0tuHWGI7NxALagdC/DGdoyyvhEGZrMPvWEWads+O06HzwyQ2/XG3+zMioGo2G2UCGBPU/1yVRnqAcsVRoMHC8rsUZzl1xqtYEfWD/oa3sSgdxv/uDeAq3AOufpQillczV3sX1TwYIvu1pLxqyHzQx09XU0euzbt3HsjHyn/35J1ZxXoI1dLj+kaTnV8GXo+/aazrJEygumLa+ZbG7zG2C5m2+vndCHoWLZBVFWLVAfy9fG+p4IP3DB4uwvCxYsHZi5P8WL8c6pd0JNuHHogWuZ7rjc46Mzc75x/otLNnG2iBnAsdtzIfrtzDB5R8BVe/IIyxuJcpJKieHa/lXbbY9j/YI6eSAEzIe/ys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0929ad-e95e-4e54-dc18-08de164f098c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:23:05.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: It/jZgQUJ8H3qK3D9hEIi5ATGrPVpja5HLvxcxS7faT9cCT1jNNHaMHdo5plWmnb8ZYMqltGCMklXorgNFfRdw/bvH4ywEPIgRzXpT1kpSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX/F414Yoj/3Ty
 TfMymSmzSNI+p/t7XYZr6orNQlYVIiZSN1PCaky43BYf4oQCBTBfGuPYx6S9yXbwmx33y4tWHhP
 hSM14djevWtSGdsYXdW72Gt5NA7oCDhWsLa6QJtuxH0gv2YUuI90PZQk/U/kChaKLwxZY5knv12
 fCpl825tlPlfcGJCZTJe8WW3UlcjT+rtrZd6S292M5mK8+E+5+AOnFvFkbFfs/qgNfrJ02Zvy/7
 y/dLl0z+YIPTymlX6q2FERyCRYww2Z/l1mOgHSERUwNY/WVRQe8UUT30KaABfxfrQShdePqI6EL
 UzEP83xNKYV0MBZSq/l0xK+i8pKxGxU1KaB7U5SC/3i8b81Uc/zSn0+aF3I0n5c2855KE90GQdD
 nXH+CP4JG6IqPR3IMVqQyEvXV1/rug==
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=69010a0e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xojTed5wux2NnWtUTk4A:9 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: w4XSXYkWaZow7iBt6uCJYR9wXJ4okEGz
X-Proofpoint-GUID: w4XSXYkWaZow7iBt6uCJYR9wXJ4okEGz

On Tue, Oct 28, 2025 at 09:52:44AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 27, 2025 at 04:38:05PM +0000, Lorenzo Stoakes wrote:
> > On Mon, Oct 27, 2025 at 05:31:54PM +0100, David Hildenbrand wrote:
> > > >
> > > > I don't love the union.
> > > >
> > > > How would we determine what type it is, we'd have to have some
> > > > generic_leaf_entry_t type or something to contain the swap type field and then
> > > > cast and... is it worth it?
> > > >
> > > > Intent of non-present was to refer to not-swap swapentry. It's already a
> > > > convention that exists, e.g. is_pmd_non_present_folio_entry().
> > >
> > > Just noting that this was a recent addition (still not upstream) that
> > > essentially says "there is a folio here, but it's not in an ordinary present
> > > page table entry.
> > >
> > > So we could change that to something better.
> >
> > Yeah but leaf_entry_t encapsulates BOTH swap and non-swap entries.
> >
> > So that's nice.
> >
> > What do you propose calling non-swap leaf entries? It starts spiralling down a
> > bit there.
>
> You don't even ask that question.
>
> You have a leaf entry. It has a type.
>
> What you are calling a "swap entry" is a "leaf entry of swap type".

I think this is pretty well covered in the other thread tbh.

>
> The union helps encode in the type system what code is operating on
> what type of the leaf entry.
>
> It seems pretty simple.

As Gregory says, this requires reworking a lot of code. We at the very least
need to defer this, and I remain unconvinced it's really worth it.

So yeah, let's come back to this later.

>
> > And it's really common to have logic asserting it's actually a swap entry
> > vs. not etc.
>
> leafent_is_swap(ent) - meaning is a "leaf entry of swap type".

I mean, we already have a function that does this in this series with a
different name :)

But sure I'll rename it to this so we're good.

>
> > 1. we keep the non-present terminology as a better way of referring
> >    to non-swap entries.
>
> I vastly prefer you leap ahead and start using leaf_entry
> terminology. We don't need a temporary name we are going to throw
> away.

Right well we agree on the other series to use the leafent_xxx() prefix so lets'
do that.

>
> Jason

Cheers, Lorenzo

