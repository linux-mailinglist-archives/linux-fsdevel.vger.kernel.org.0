Return-Path: <linux-fsdevel+bounces-61813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B54B5A001
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6264675FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877C286890;
	Tue, 16 Sep 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nBz6g+gU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OlgEXKjm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E5265CA8;
	Tue, 16 Sep 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045792; cv=fail; b=Z9yICcpkNOgRG8jik0TBjSp5YYGQOp8u4WrC3Gk8UtQzJzGNgcUGVl8tNLJC/v7G05DYqM3QghjEotXemzznlNFFCe1BWwj4xllwXi/EEL/MzKQjNAPQp6ONs8Yf8mXhnDal/WiALiWoLhK0GlepwsTAv2BVe2r+4CnP3kKrxFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045792; c=relaxed/simple;
	bh=H7X6s12ythFUelylNQX68T8xYTOq2C0UzztmrhBEnRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cJJ2TfPY8XP6wQdo4hytlFXZjiTAEnCQl92VI+KsauOrmRu1gPwKhf3oH5UEwZD6hv/dr3+uPtWyg4NSNn/ArHD//gj8PeB5fkSrtc14zlmx5jOyaD56idJqAQkp7BhBm40gRiUnuHILDMwTZ2PX66UH0qEoi6wOfJiwf0A9nuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nBz6g+gU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OlgEXKjm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GHuHhj000849;
	Tue, 16 Sep 2025 18:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=H7X6s12ythFUelylNQ
	X68T8xYTOq2C0UzztmrhBEnRc=; b=nBz6g+gUfBWpOt4QTagjtfmPNX1sHxYqJf
	j2w/1LFEXRpVAzLVUyvCospNwPq/oWSQkE9o1cuDmg6vEnOOW2B34lzXlQaCmCLN
	dpIvwC4NqNUWgTpa5uCT+nsr0hXXeT5RIBFXaT8ACm71bE3SelrBafrLLuCWTCRV
	OA+8LRu2bz2r74S0V1nPzwG+7rLyV3GAvD/s2NtC6EPt3fEKIbL/fFFYWjtCSCP0
	pXZM/n7NkM4t/MBnUnZOufIAT6mGCNywmaAwiL3694ruLBNhmfNZepbjtITj7tlF
	2QWdyZec4ASFle3PQmBdofDKPDTkdromZVPaoSQE5RxU3B3EDuuw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yd8naeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:02:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGmQLF035200;
	Tue, 16 Sep 2025 18:02:29 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2k1p3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptCjVyx/16sgF+O09Yt0oRK1mwPJJXJWUjgww/u7Oq8FIoagxY2oqXo+CGjkF9i1n8RSbyNb4lYXDZTliFPccfXCsxKyKV3n+syrV2EzycmTqMnjs2wP8N43xuml303vbzFQqUNBMEZwJzviPIj8n+PkOGttCa7QuGdIcsIqiM0fFl7+qSBjSWgc5vAX7T7pT1oO+3lzIG5ISfWsYbIxvlDyUAc7J+HYAskI1dVrOIZc5/n8pfDQzGRC74KBzUrN2IK5BY3aTWiOm31YbJ7SBETfSEpTdFnBNm+WIsnQDh+JyYsAV2W4Vcp0P7XlV2qCExc5GAWibOGxkRivHTJJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7X6s12ythFUelylNQX68T8xYTOq2C0UzztmrhBEnRc=;
 b=aJRXiBT5vseb7Yw9mNnRQnKzinhR8edQLpqIK8pjcvubjYEDwz0DDEfzV7aUDu6UHJi1g/hCAC158FhQbSZDT+niDwuWcmb6n61W2ElM+7AygLiVzUWHSylXurF+Mh+8yixfJzq690geQ8P8xXsUlOTs4H4DIUhRAzybtPJuDHMxI23usSNNMq8F0l1YYObIJ8a/91/7ehDSCTP23OYycwwaYaIoJ48gO1rkJlQnBMyVuev7XvW7D9BXW1ClX7x2rc2aLuXMRtpirn+Ook3qw1x+1jre6XuyLXMspxF0fDlhkd42giysGhW43tIlVT1l9iVslPHI8CqATu1pF8kHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7X6s12ythFUelylNQX68T8xYTOq2C0UzztmrhBEnRc=;
 b=OlgEXKjmOvtI9Z3l8uv1AeB7p0slT10iFVU0wg8SCZsfYTKzNDi3ZTgv+Y9sDZ0U6niu05dyC9f6vbP5eOPq0IvhHceMWYUmowPKJCAORJzQZdmrqij9BlpM8Q/PquZjrTviuZtM88BdydyJTwm/QZ4ZCD7bExMJsGi8c6/FiH4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 18:02:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:02:23 +0000
Date: Tue, 16 Sep 2025 19:02:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 11/13] mm: update mem char driver to use mmap_prepare
Message-ID: <cc8e295d-83ec-4172-a541-21b877349a73@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <03d4fce5fd356022b5af453fc5ab702c2c3a36d6.1758031792.git.lorenzo.stoakes@oracle.com>
 <20250916174006.GS1086830@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916174006.GS1086830@nvidia.com>
X-ClientProxiedBy: LO4P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 56070689-1da4-42ec-358c-08ddf54b3034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m2OXGFArw+3+rD0N1MXkc7RT8dM7qoRbkZI6dSRuheN0tJvJMw8U6dZ3XB4j?=
 =?us-ascii?Q?TJVqo8/9CHtQ8X2GF5wohpMSDoQNbAPXqUMGem5Ej1f04ZS2eliwP4eo7GnR?=
 =?us-ascii?Q?EUjhXJbMOEWWdLnQCi9xNAbK/Br1R5vL0+jpK2UURnbPz9RLjCRHQPiCWtrK?=
 =?us-ascii?Q?QRe0Ax9gszYVQobKEU3BT3TTVehfQ9AIhdLR46bfHLuv3C3mX854z0zKq/GH?=
 =?us-ascii?Q?piutxCaQDGgOAGYfEmIgIwPXSSGgD521zhIcXU0D9FzEX1rsU4giIOtLnbX6?=
 =?us-ascii?Q?mVKFBwv1su9etUEPx8SNrA4U/eyksA1Prxw77FqHLcvZlaEr/qntRNqLJ/DL?=
 =?us-ascii?Q?ryLPiC8gmDge7+2VUL63Q+ntDIp0GNzp8ViAvYkKdaoAE0bXU9dc3Xg0eQZr?=
 =?us-ascii?Q?y6gLX+iqLIQ8CgHJbmmGR8GVAxAxOf0Yp3o4YAdw1MP9tqDl9sNFCwzw43Wt?=
 =?us-ascii?Q?J2270x1l+Bzhp1kRKT1uw/KHQzMTAUFw0dId2g0xKTW2FdvVa0Mfdivx9O4g?=
 =?us-ascii?Q?kjWlGdNxLa/mTxcSwnmg/rViSZEnKc7u4/dKRm4NeSz5BcSOKScA6ImcGVfZ?=
 =?us-ascii?Q?JWh6/jeK23qzVlW1a9TjesPeF5tdQOyb7hE16ZrbI/K3LLH8QSZmXwmVGAOL?=
 =?us-ascii?Q?TD6f/oaPGzghtE6BqEC/6chX6WoDV4TwOr7YziYAqVenXn8ik+4dxVFG+JGr?=
 =?us-ascii?Q?HIWw6bvcuMgJgsLM8Ms77Rv9yLqR/MpCelXz6I2oEwGXoF8IFu+ZJtjx/sPv?=
 =?us-ascii?Q?YbKl5vAL5Q2sKY1CLaHd5z0VfhfpE2LhMzuVaT8P0eZ8eSzNwbPUxpoktjqJ?=
 =?us-ascii?Q?H1lLQOBNtz7c71HfUfJnyY0sMBaONMGIyIIvVlw7ckecdr6tuG566KAely5K?=
 =?us-ascii?Q?OHnlJKTq/Q1eCQNtWuc7E6/XbapujtIk7cx0KIZmDmdTH8r4YypU47aMehKW?=
 =?us-ascii?Q?Ta4a/9yPJR54ddk7d5e+PmgbIPpKj6jZwokg0U/0AD9fEH0CwFT3b8QJcxAR?=
 =?us-ascii?Q?KkOOKrcBNapy4qdr4Qgdi0KZQVVWd4QORW7bouR/TXhYumJRlyUJIM4pRSuR?=
 =?us-ascii?Q?qQI+vUEGvxyEGTpiaiFEHwl2COLh0MF8mqaugWBru8/HUsIoiMyWw6p4NkW1?=
 =?us-ascii?Q?oOd/n8Dwt9veLhchZ38sbuVYKbjvrUsqiCo4j+7JicHshavxjvMWydBQj/DG?=
 =?us-ascii?Q?yYu1r0kNAqfCAWYAGwYggQIZZOLf5cnjLfLeR7GfvEgwrwE/EC25eHVDMCoV?=
 =?us-ascii?Q?ki8QwI48dtGTFb+SGl0n00EAnuEMPanyX7KHSj1yxqx9IAfVXVnhyJiqJp4g?=
 =?us-ascii?Q?aE+FZmvs4ABlGOqtpsimkas91kZYIx2qkcVoulSnDm0m0DpJgoQPwwv524zz?=
 =?us-ascii?Q?QyiwVNLNO8gBvXSYCQSoCP4mOGnyL6W5OyxHBIShxfv9HbYavgSS36hM8FuX?=
 =?us-ascii?Q?5VFXhxExIJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHPboedGg5HdRyEiwlS70bF5k3ZIhMGuGo3dIhnJ0XiGxoOkJjwANLRCCLV9?=
 =?us-ascii?Q?+TZ6diBf4VGnGQGc4Qr8Oq45yCgl04sX3uqOkeMWyGKjLSvM6uTVfn/pcpc1?=
 =?us-ascii?Q?rFUkl01urmSxgDLzF6JJhAHMVqaIqFJjqcz54YanVQshKO2aKZTrkLns3gDZ?=
 =?us-ascii?Q?kKxCGu0NYzhSs2TiZg79LYcDLj/b/g7Fz3vNgqHv91vXr8Pee3QqyeSU8Shh?=
 =?us-ascii?Q?6qXRvqDVFDDWmXyIJ2Pd5C0yiS1FGaJpFUw17KH90za6VF6PJAdi1Lm+h3eh?=
 =?us-ascii?Q?NTOBHJi6lVQvUizlqcVCD83SRiuELaJxh7dzdWGXGrveVTusc6nlSaIdN5sy?=
 =?us-ascii?Q?H8Osv8CLAiSqYA1jAUboKQSTQ+sg8ALJHq+N3ULi2hoGsll7y5Dd2bhFtLd7?=
 =?us-ascii?Q?ZBklAyekKp0yxhonnrknS6GAy7E2pKsNxeMpHeg4EIxd/6QDVgRluF6jNODu?=
 =?us-ascii?Q?14jmtHf/1XjXDOD8dmyG1JU8Pah+ElEczua1MYZCIvI96CALKnk52CVzcldV?=
 =?us-ascii?Q?RKB/lbCNWckchdDN77U8ps5pi8vFCYt2tVEdmuNB/Cbv8oy36nI4FToBLNWE?=
 =?us-ascii?Q?wtk5LalWYowykSKm++fT6YbV0KcSGdhHk2ka1E6FP/JYLaGhhRy4UmAIgfqG?=
 =?us-ascii?Q?y/C4etT9UnC6LiwRlfV6n8TMoSwTk8kRvg2pPfHGSyAGpTZuVGeaFfFnWYPL?=
 =?us-ascii?Q?FO3O27in8mj3RTcH+MLvyhLLgmNKalMNHQjnP5d5qujz3iNdCRxfDbcUwhCU?=
 =?us-ascii?Q?9w+lj8m4NIIsGLf4UFooHsN1puK0b0ibZ8599ATyVUH870atUeY/EzOqHVai?=
 =?us-ascii?Q?W6uyYTY3KAQKJz2tcOLo822pTT5SW1rZxKobwtFvp9VtmYUvNzvkUBWQHfZw?=
 =?us-ascii?Q?sLjezsizMLY5tqwp+bmVnEQaiNEaBhUG5vz5jvwT30OoG+AMtoW/lw9UQGBH?=
 =?us-ascii?Q?t/LD5zWSDRIIJjE9kd9bhNqZjYQdtZJNCDPnoGuS59MjjM6MK0oZ6lU5OlcP?=
 =?us-ascii?Q?EJJEkW23vxRV5B/prQ9AxtOnjaWkpSggNTEvz/izcRlEOrLSnkUAuKuE96qV?=
 =?us-ascii?Q?OWrTgGikxN/4ckxz4U0JzqLTnsgTSJ9NkBacM8lCQuU/2wAIhErSqJiNdX+p?=
 =?us-ascii?Q?FsNrQHKfFc96/M9bOuH+MYSmJDUZQZZ8fTWbebqBjX6eAqY9yBprZ6e0UF6S?=
 =?us-ascii?Q?Q7cCC6lIEhRYSrBcmuQvUz8YJb4ryXy6e3To2FYIskbqyc5i2oq0182u9Tfv?=
 =?us-ascii?Q?uAz//ULMnQZJY1LrS6qnnG6kQ4vAuTAYc/wtYMFsf+bEvTuZk9WlwiZ30Z4d?=
 =?us-ascii?Q?w3165flYWgdmSJ1/BHutTFBRZQpbadA4FSnSF47pyfauRoyxt3wvwIYqEHtg?=
 =?us-ascii?Q?X4PPwl277jo8cwBPbZp8ax6i8wen3rIxO4FSLZcvGTXJodY4ucJNt1qF6kUQ?=
 =?us-ascii?Q?f/H90CIprYJeZXwUPOtVORgEZjk2JsObEaaCBF0YnDl2GQAho7nsxiQYsETh?=
 =?us-ascii?Q?HvKA7g6Znx8WxkJVs5+EVvkcEVNmLTyEaNUxFPjLpLq28e9rSscIH1ck7g2z?=
 =?us-ascii?Q?O28qrJnviWqAVkjppfgyPJA0aFn/1Pi9tNtf+IrWUj5bRBTChkqVT4IGBRkP?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r+7AGvgiR8+hCji98DMYtKbHEHx/WB6HT0Vo9/vpHBEbExCsMuUw+eYsFUnPPDyhSmltz0zg5W5vvnBCVn0U3z7Ldsem93bXwzkrzaHbvzEqAPcjzDfERCL2moiA3AiErgjrwBZ5rQ5N7YSZBSLYlnCKlbCIsCH+Yc7r2SEEOUqsk6/wD5VHoBHFHg+zCYwhNlo5iP8huqSxSUVxZ7vqNvBPRJ/PmJ3T1yykKQ7FlvgNKiSKdA4dqYyibZBpMzdU/xtrq3EEXG6JuuOST5QJPLAH0NVoJ4fQtzH6714RsQMkXlpDPQbm+ry/qq3jkfpAMlzyzZdeAKOpbWqOgO/XDTvSspgZlMsP2uiXQ3FqYpeCPlX3Nmbo8q1aJN6XlsmrTMWdq4jWGQF4kgC+ep6vTTa4si+kESO3lFlyxUQ1h0EUvG6Ye+71Ax3kvZbvOmjowafsXOj/4mODfCKHfdUnpddKI4znaDg3nCSB8klSnIwwXJeMP/b8k8LzsfSOFBH2Viqu9eaOY86Va2C3adY8i0mWLJfMKJAsuVpD2DEWVmpOT8KUGNy/NbaO4Yjlb35RZ4TWjNna0Bk1Ms3MFqau17g20ALdBENY+vV+mvgWXkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56070689-1da4-42ec-358c-08ddf54b3034
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:02:23.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9zrI7oBTdmgMnqx2mcFCBYIGOIJIR+UmzbMbtW00k7CmydfNMjxtQrjxKzhpBElEm7GAKjIcK7QI4ZYGvnh5/cEp/n2SgASFQ0bfAV9iKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=624 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160167
X-Proofpoint-GUID: j0ZgSCZYXfFFGw-JKzeWm3yRUDskgHvC
X-Authority-Analysis: v=2.4 cv=M5RNKzws c=1 sm=1 tr=0 ts=68c9a635 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=tsslbAQQsXPSOxKik7sA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: j0ZgSCZYXfFFGw-JKzeWm3yRUDskgHvC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNiBTYWx0ZWRfX8RqtQ8EMixDx
 5wSGFu+M1bJzsTG9ANXUWTop/snfCjTSsMHBU9Lpowm7cvK0++kjd6osQkoM6zQO0cj7wVGYAMh
 4J3x2cPTp5nCrUwwQwkBbvgEkEhQyEkNVTEwn1yqpKVWU2iSQB9j6VKeA+OGjLgUR81maPwKXmf
 z9jAGRz4YHe8r9e9nlzL+wS9AKtPWoPJnzNBg4CqGzwZpWCJcfMLNMaeIjI7fkr7hoTDxYfddwh
 hTY2DbqyHdBlxOp5qXVGrupV6mlJT22Ez2hS9H0BF0y43ednm8N1wUrPgAywsUc2TmCW2pkkdMk
 dN7uFv02seMdXzFsmEuTjRmC3gPTrq7+BISN2wtRysTW6d5xqu/vyiwoyKr9PZbf+ucv/gst9fU
 Ft1eLSwwGm1k5cgpmEwcJ9WOaBXZcg==

On Tue, Sep 16, 2025 at 02:40:06PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 03:11:57PM +0100, Lorenzo Stoakes wrote:
> > Update the mem char driver (backing /dev/mem and /dev/zero) to use
> > f_op->mmap_prepare hook rather than the deprecated f_op->mmap.
> >
> > The /dev/zero implementation has a very unique and rather concerning
> > characteristic in that it converts MAP_PRIVATE mmap() mappings anonymous
> > when they are, in fact, not.
> >
> > The new f_op->mmap_prepare() can support this, but rather than introducing
> > a helper function to perform this hack (and risk introducing other users),
> > simply set desc->vm_op to NULL here and add a comment describing what's
> > going on.
> >
> > We also introduce shmem_zero_setup_desc() to allow for the shared mapping
> > case via an f_op->mmap_prepare() hook, and generalise the code between
> > this and shmem_zero_setup().
> >
> > We also use the desc->action_error_hook to filter the remap error to
> > -EAGAIN to keep behaviour consistent.
>
> Hurm, in practice this converts reserve_pfn_range()/etc conflicts into
> from EINVAL into EAGAIN and converts all the unlikely OOM ENOMEM
> failures to EAGAIN. Seems wrong/unnecessary to me, I wouldn't have
> preserved it.

Yeah I don't love it, people get antsy sometimes about changing what the
error code is.

I'd rather pass through than filter but there we are.

>
> But oh well
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!

>
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index 0e47465ef0fd..5b368f9549d6 100644
> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
>
> This little bit should probably be its own patch "Add
> shmem_zero_setup_desc()", and I wonder if the caller from vma.c can
> call the desc version now?

Ack! Let me look into whether vma.c caller can use that also.

>
> Too bad the usage in ppc is such an adventure through sysfs :\

The arch code sure can be fun!

>
> But the code looks fine

Cheers!

>
> Jason

Cheers, Lorenzo

