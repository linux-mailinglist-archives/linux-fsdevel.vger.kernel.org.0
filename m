Return-Path: <linux-fsdevel+bounces-53395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E9AEE562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47128164BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DC2949F1;
	Mon, 30 Jun 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljdz7P7R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j/F1hZJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87723293B5F;
	Mon, 30 Jun 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303356; cv=fail; b=BZxPfoicy9vBlSJAf7hCGH/Bdtd9jJGV2eeU0puVq9fUF5MI3eRPZxkUe4qMArgaC6qmTucbr7WDRlSWymClcv6zXhPmpZPCe3+LHBjYiwxeFLXZPewesavW4ntbwexh4Dwc4kUupSrgwLrWe4Obc8aAOlqLxEoiLZlB7D02WSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303356; c=relaxed/simple;
	bh=LSPaGWEqPKa4Y37DllmscIDijj3/h83CxLiUKl2/TJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HUqW8on4f8CG49Ve0uN7fqPpedoKDLyTC2m3cNi3mnSYWM8qPE4OTYLf48pjD8XaDwucE8BQbpZQS0/SmExYqZAswcx+vD7UwRYxlxp0Y2/H6rvN59nG7TiI6Zk8oQfDbQoteknzIZTlY4OxwfrgHmCiWjRQF3owNQYFvumWY3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ljdz7P7R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j/F1hZJh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEktbF014166;
	Mon, 30 Jun 2025 17:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KTA9yUkNAIx3vxKMrK
	cnVMO5r6R7CiRvKbC7GS4j0P8=; b=ljdz7P7RAyIzRMfSfnaLVSiR7tgez6raXb
	Xl/XSPNiHBR/vWtEz2wXcHA4ccvUWqu+2XDDN36e1NXvC46AVFqlXk1i6Ic5IY1T
	58tvKHmmRGw5Mn1MjAsbkzQ4nzXY2L9UQo7she4YdB3r/S8xnv+WBFZUMqmATiBY
	fCaY5yilUIoJbsRVXByQEMjuW5hB16i7bI+byt/HlARnzFOyJeUvp23XZbJz6MZB
	68w6Pj2788JUPFc0IawTxHL8Eu5LH0gYWN1rbloBqXFUkzaF11H/SIVv2+9wT4lH
	a4lANjb7v0ijc3gWI1HuwUr68BwC8+snfuziEWNytE0jgGk+409A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af2yh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 17:07:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UH4hvH009139;
	Mon, 30 Jun 2025 17:07:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8mkft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 17:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG7Xd1ApcKIP/ecqH/+uNY8UqmsfzlOJ5GzHAFANoU6/mTvEand+ibzb+AawHF7IsfDdZK0P8PWB21oI2fM4b83dD0ihtKF8M5zzZHDUqEQl1SzZHylJRHEAgnA5Dd20DjOH6o1HA5HlL2DxSq0TVlLS34kI21Q7s6WYP/BApK3hluSX8AZdcD47gSrGc5BQN6b+BNwC0FjYnvVWqCmrilq9CzFpmdYEn0CSh9nLKVVWJarv54OI66sKhQMS9us51VMH6JXypTc2w2/ZBHbaEeZUycVKyhfj6JkN20Xh7j53IkCthr9I329FcNLKcRNgFkaVgIgcpl/zYaAtDf3KfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTA9yUkNAIx3vxKMrKcnVMO5r6R7CiRvKbC7GS4j0P8=;
 b=FuoSKVi8Tlk75ITt//lL6CKHut1fh1IP1aC93qWPqbeQ+v7dBj+QeYYvTCo1538IUUx8PWPeObfl3C8eTUoEJwsaniekSHVDGmoUfY46opIWmOJBAIx4qSxlLSQ3Q5Ed6udsOrnpqS/V76knwsLsoOhKy2w3SqhfQv3kjKyz8YXPAerkSf3pmlowM9xkfnVpbi5OtorsAx6DqEH9KnqHYUuTj/00MamWCR+BJqCGYcnlAssF7RepjDWShDkQn564Kn8fNsCWvS4cPdwCfNXAzqmyX7ag9eCH57qM0xjewe+CQzseGY6ZQqhEjT0bjhyWTpGA0+If2QNaYI2S/tZ8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTA9yUkNAIx3vxKMrKcnVMO5r6R7CiRvKbC7GS4j0P8=;
 b=j/F1hZJhZZTcdKp3sIVJ14hW+rJyMqpDvsuKLszrUyESXv9p7RXclcDqES0H07uaW+3mxK7b2AtyywIiq3cNquQ72u+6TmLVLMTZL2EgkvKXgVAXUfWfFQZXuKtlltVOtg2tuYAevXMZA6npoOB4dtmzMMCcex2xqx30aRDhfQA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8159.namprd10.prod.outlook.com (2603:10b6:806:43d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 30 Jun
 2025 17:07:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 17:07:41 +0000
Date: Mon, 30 Jun 2025 18:07:38 +0100
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
Subject: Re: [PATCH v1 10/29] mm/migrate: remove folio_test_movable() and
 folio_movable_ops()
Message-ID: <100ed589-d3cf-4e31-b8d1-036a8bf77201@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-11-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-11-david@redhat.com>
X-ClientProxiedBy: LO0P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: cddb1bd1-22fa-4a61-2c01-08ddb7f89fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qlgPU7gUAjiGaH0ymdOZzUULVJym1recusL+ZymuqCu9KjFiKV5WqxVzJDHv?=
 =?us-ascii?Q?TBWKbvaXsybjyZ88noeIUtpAKGVcu0uHVHBmqJmMAVorf9AyPOClIqnTbTCy?=
 =?us-ascii?Q?fH/XXBrSRSS2Tfbvj4/8HUSnKa4UJxKbfplfghb0mV0IVzcEN3D6cM0VMkfp?=
 =?us-ascii?Q?DS/PhRD4E1PDfNZp27xDOjOxPqKecr99w57CezKPpzBb4+FdUjN9Y1/LZTYy?=
 =?us-ascii?Q?wfqPvh9Veesnm5ShF8FTCOePE7E2mH5L9vAbtAse+AQ17L3q/DzPlCptd9vk?=
 =?us-ascii?Q?kzMYx9waI3VpN+tM0JgD/Dd9dqgV4Y7uQtH6yT4GxHu5GhT7QUveDzwrFd74?=
 =?us-ascii?Q?1+5w7Q/H0yRSrt3+0NJyEGPbU0rBgETQbHo1RGACjpruIdNuj8ubp6iMK23c?=
 =?us-ascii?Q?1KS+1Fh6WsSGHwayxiWZv/S1RMkygSNaZMM2XIYkz72pAHtLu8RWSK5Ciwsu?=
 =?us-ascii?Q?MCM9+0lYs93ru8D9QyaKTvDBUeG+XP899xrVG/DcT9gBHY8i2jEkATmGVWYM?=
 =?us-ascii?Q?U0n8AO5EbzBCiXkKknhVetCfHlTc5+J8seADPUsGpScSEuyqgKAkwzsNCLWe?=
 =?us-ascii?Q?aHKhaOQ0VuKliUG3dXWjEBjZSmKtM+mpMug1YUvRXayHEfEkag4schlGP20o?=
 =?us-ascii?Q?ckQ0QP/vYDT9guWs+z0cY3grHVeuEsfzdX8uSWorudzDiDGthxxxOs3KwGGy?=
 =?us-ascii?Q?bMvvRo9oWsSWf642A/jHm2kUOaCX/mvPw0Ty1Dj58HKg6Kezsl8kcNPUYCYw?=
 =?us-ascii?Q?y4KME2ZCcclhtXDCWaBdDvO07PWpaeDGSX/wDIRbTqlXvFbyEYn3JZlfIkq0?=
 =?us-ascii?Q?DAukthu2wZQjTAo+o4ueXvcTYgtCGyA9JU8dH2qW/QnA3UStMV+0PbeDQvZA?=
 =?us-ascii?Q?TI3Ga47kTXqyi1k/xRG4/e6HEOwz8eUmJIALevsR+rQcaGJT8gl+PbpwzJxf?=
 =?us-ascii?Q?BLCMTHFjH4FYJMhOY8piVX8lEQyyFAKuy3DWGi6sB3ZAXofGjdUCMZObv18U?=
 =?us-ascii?Q?pmUyxQdFQ94F8bMngWRXragH/njauCMBEYxN4Ffota+KlLpVj/N7afQ10Npg?=
 =?us-ascii?Q?bnu/YcugmvyuMSSN+cYX1zfZ/yG3eGYb/upMUm7t+A0u8Xm+oldH6sgpiDJ1?=
 =?us-ascii?Q?3FIQH4lYC57caXghLZD/a/6tSRWg3QIBjidSKo3xuVeoGefg7cu93xlgEAq5?=
 =?us-ascii?Q?ua3CtD38nR8zvfpMkM5/M2DsIi8ADUzqJghP1c9W02Ebv6fI/m0u4MhMCwyI?=
 =?us-ascii?Q?0Lbrc3MujyyE2dnvcy1i3NyQavIE99CPe2Rbabuu3v2HOb7ynQA04zXgP6NX?=
 =?us-ascii?Q?ELeNY4U7Z++X+bcqNTnqUtGO+W7UY/qYt/RNweZ2jUPNiVELr20sC3wLMjjx?=
 =?us-ascii?Q?WZMyL22waUABukes26zAG411/sIvkrMLq+PBlIy5VygZbnqGJVfmZhK8R+OV?=
 =?us-ascii?Q?nwU6vrxd78Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w6l5Tiilymnibu0UxmyxUqWS2eDyX7ccCrXN+8nH3HHDZR6uMRXi7T3/gM1+?=
 =?us-ascii?Q?4WStPMmrAYfE0wlm217XJLh+iO4qI7MEUe8z5s7SolwSsauop7sViNKKX5r0?=
 =?us-ascii?Q?N0Kaln8Dpk+ssZCtHpF6LPo+vd6hS3lRWoEu7D4gzzA3IbaeP917xjW2gQJF?=
 =?us-ascii?Q?GJQbd36OkjQtlRZ9DsIAS/FnWZiFSMRM+9d0g+KVs+5F0GYL99N4mW5m8+sS?=
 =?us-ascii?Q?/LfcRpEq9eQoKL1fT/cp+dxP38pr3+i/TTZG6qfmtC6CPAJGUhymz8m8oEWG?=
 =?us-ascii?Q?sLc4KBUBO339CgB1GWxzDmZh/49GAQ+jgELtJWNXrOewGlq8vRUKzMVHOPIN?=
 =?us-ascii?Q?IoyL9OdvDVp5aPF8VnX1kf30gDgO8sesUgra4+SAwmof8Ppq4S/jNLIW9xAz?=
 =?us-ascii?Q?pyxEDewqGQVBOFtEDOTN1iIgV1TR1NXZKe4lHtvb8KJyJUvdv5wmZ6vttp8h?=
 =?us-ascii?Q?Qx0QKcP3s54VpUrdUm/dQmGTbXZ+vlDpF7PYcU/PMXqnS2UqF00iUdalAqRk?=
 =?us-ascii?Q?FyDyUQo/Q5GimDgdbVkzGt0SwMfVfOhWnjeOFLgxnWD+s78ahXpxh0UmNbPo?=
 =?us-ascii?Q?pAJd85y9Q4tYO6KuGBEPbfRmTTS+jUt0ynvr+M5obG1bLpQoAS0D1iaNkN5w?=
 =?us-ascii?Q?Gc266ySYijgiDDfVK+0Ejok06Tp4Jg5wtsLn2Cu9XaFjWBxC9rUVNJxS/Wtc?=
 =?us-ascii?Q?cmi4spXSUt7j5NDxeqxFY5vCeyNFbM2EhtVokV/r8yFVnZw6XD0Z0u6DpXZo?=
 =?us-ascii?Q?01nN/EYhVYJIf1GrALSgc9cWmOdYsRyMETDF0PAYkKt1jpHvzV+R/+jSxFhA?=
 =?us-ascii?Q?YI7ATYanDK1BjVjYS3MNux4xTdI9Urwkl91M+EEZoaSpeSfANCxbmxWiVa8N?=
 =?us-ascii?Q?ZfZwpvyeJAfmnyk7eXIOl+hwpcXWjJY0aJnXmCCBWEPPiYLHQ4WYBRsjStMR?=
 =?us-ascii?Q?dRbCAjY85LTENGnpsbdVs7uddPwVnbDCdrCCXlmho67XVYX78ixQe9L8kR48?=
 =?us-ascii?Q?b3vimSVRidOVGtp5qB7qv360CTDOT5w+tN1VPnN7IPe6L2ct0wxC8xfFAo50?=
 =?us-ascii?Q?Dw44DkyODW3PQkpLuua9c/xKWD64rIXe2JLR3hF5WwsyNQxGp1CIoNXMLtjR?=
 =?us-ascii?Q?guCT2YOcarXudcA43FPqRiaby3ImPp/qMTKhdxwXSRKRoN9njyAaUUGk8Isl?=
 =?us-ascii?Q?EMgHrnEUw0y71Pwn+wh2Mzl2TTDIAR4K/69QiPS+BvWlsiQgryfQnmr9wFKY?=
 =?us-ascii?Q?xGqd/wJbNXPG4Ovlfuz3JfP4Xqh6wlO1SoZpDb7xAbK+FzRWs9DN3e+QZlE5?=
 =?us-ascii?Q?dVR0G0Ribxm4Q2pYud1SJQF8HfGG9061Xz23HEHg23WoWUfxVKJy8icWtfUw?=
 =?us-ascii?Q?0/yjrmbPJ+9sktiEs9wBCbsgAyf9zK4a6pOSq739gyk3kt1ClJdQG+KPD057?=
 =?us-ascii?Q?1Kr+m03tZJhu5hI5tIGiWEYcj02rTxTLpeQL4SRRzvwC6lcOz9kS6nCt+4O1?=
 =?us-ascii?Q?HMvJ6A3UIL5CDLYI6R4A3Uu440Yee/MGJ8S9LYjAuRdqsadH+mWVO4tyAiFa?=
 =?us-ascii?Q?YvB57Xkuvo2KGClxcrrBVEhxsJR6nOtBCwn/tayJl9XqkchxO5FCeYubiWLu?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qbeXbmtmH1UPuiUu0Sd2y9+93ZnoEt/hNtitt4G+60j6v4Qm2h9ZfZfnMQU5q24G/CS1UM/58cPREJ3/EVVmOakZec7zgouPn19rGn5nsptZ5Wz4aHhvNQj3Yx8lwDoXJujLEGRrZ2q8eimvwv/NIP+fgDTAzGsXsjxr7v7kHkfX0R9kADRh7OBCuWSNeMPCfKGEw/7WmFYjrM909G//XMfVx9ZYR1NCg4uzh3oJDN58koiPbGSTXfnPrChhkI7GMXIPVEMLrLRUjzdcE7hUcYC4eCbuD9w6i0N5YmSh3yjgCbF6qW0EiofrL7cLBzNOAK2jYwumuu+BdbGPVKjdXRHIVTfAu6s3Iz13V3Q4nYeVUZ37pDQsbc5pc8EkQruOzzXslAE6AwVpHMO1yC9RNrEWvbSKf9INN4Ym1QKJondB4xeEBqch3iDtAjlc/waKySmIQuRgigmzU8QhyNSeESms2p0cD5e3uWfxDJ8q4WA9JaHJ8v5lcV9pUh2FkmE4Pn5TYb5lZxnDSLbRR3zvxKeSvwzVCGVwqvkI9f0NNvLRAHVonyBLN3a//74I5XvK2X7Gmxc53CIxz1HjIIZV7BedOaidWe+7Fg9BhhrDowU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddb1bd1-22fa-4a61-2c01-08ddb7f89fde
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:07:41.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckSLKtSeBBUC67Pim9fYrS8zHSwVf3PY+tpwTJiOEGmXbDh/ssnO96o+bsIHWF7R4LOcf1MhCo6DC9jh2JUwbXB1tqosD4JvCAywqEMXzCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300140
X-Proofpoint-ORIG-GUID: wpwn4bPWRwfjHkh8WGm0G14plj8-JELT
X-Proofpoint-GUID: wpwn4bPWRwfjHkh8WGm0G14plj8-JELT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE0MSBTYWx0ZWRfX00KBa1gqb8Nm Z3LNwZpYeNzf0Xt55jO7apHx7zpbhspm/6ZcUHdPI/t+JwaOpO200RHdtUw34fu+8YPeWzKqoH8 JWxNAjMH/ELTaBDf7hWE58Da0cykRsiSwaYe//q0Qj0rHiVSeE2jUPkGY76JH8qcQwr8QM6aAtI
 KhaUcviylQpJrzE51OVDGqiukS1Y1ImdTpnpYjGUzX6FQIx16ioD2eI81eZ1NGWDkykdUN59rMJ sI4JBIDnzyx+LAzgsTtr4L2ngoXucbXZiorcMcO7kozV/ftntDi5DjIMNv9vDk28GP0yqQAsgC/ DbUIHw9QrARvpOwh3N0vXLAO2mI8Pjt68H9HmIZZNJZhIHZ5sB/4az7tPU8hbN6IZPLTy+TFCuH
 Dip9GyXqA/TJd+5S2/hHJg7tzbVGdFifsXUuELK7SHmtpypgqRrPLpoVetMk22FHhHObaD4F
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6862c463 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=GrzLhoeBJhj7Pgv669IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723

On Mon, Jun 30, 2025 at 02:59:51PM +0200, David Hildenbrand wrote:
> Folios will have nothing to do with movable_ops page migration. These
> functions are now unused, so let's remove them.

Maybe worth mentioning that __folio_test_movable() is still a thing (for now).

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/migrate.h | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index c0ec7422837bd..c99a00d4ca27d 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -118,20 +118,6 @@ static inline void __ClearPageMovable(struct page *page)
>  }
>  #endif
>
> -static inline bool folio_test_movable(struct folio *folio)
> -{
> -	return PageMovable(&folio->page);
> -}
> -
> -static inline
> -const struct movable_operations *folio_movable_ops(struct folio *folio)
> -{
> -	VM_BUG_ON(!__folio_test_movable(folio));
> -
> -	return (const struct movable_operations *)
> -		((unsigned long)folio->mapping - PAGE_MAPPING_MOVABLE);
> -}
> -
>  static inline
>  const struct movable_operations *page_movable_ops(struct page *page)
>  {
> --
> 2.49.0
>

