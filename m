Return-Path: <linux-fsdevel+bounces-67192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6D1C3794E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4757E3BFCFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 19:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644033446A6;
	Wed,  5 Nov 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p5SpJ4tg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CUpmvqOm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9734320F;
	Wed,  5 Nov 2025 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372423; cv=fail; b=Rh9WHyQzUZ2Kc0CT8qz9e/oyUaVLeWM9jtPnKZd/tK+Kt91LgSWgtLOjswYvFRW72hvUVOkbd66gN1LXkD9IY6Hd3S3S26vNRTVqcGi+sJjdF5fec+Fb3eloHOMKfbZD9eKnU0KbuiLcizjkUTQgo2uODIDaXm1U6SJu5CYWgcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372423; c=relaxed/simple;
	bh=l+adM3sXYxYfysPr+tOmnUeCIw9kgM21k8ng8EXpDGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KctY9Xft0u0MIsY+U07SgyigYYbn3WWmF9e58zBHSJjdNF12C97YiTLmb4AQCC7yAaHy2vZ6JO7Otj7AUw8NvAFmWMvFxSFgsUREqDB622aB4rVPKNF1QTv6ihzTqj3np0qAV+YQWq5NFpPomnyKkDQYOu7F1wg8tuyR9skQs3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p5SpJ4tg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CUpmvqOm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HESnL030090;
	Wed, 5 Nov 2025 19:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GJJPhSH/SUu9Qtj2Cn
	KLwBTrxg6Jynk6BL1f5tLrfU4=; b=p5SpJ4tg0ZQnFlhj20TEZ+vTKpAn1LNEqj
	l++IzLN6mkQoL9g3hHUOwU/ZCETIWrA0kfPe4pC+Q3HME8cBOqFrHXyq8TUKWNRa
	3tgnxU4Qi9YDzkd/yw4Vzfl56i0e1H+R/2V6jkbh6ztrxLCGvKle7aHt6EVMbGBy
	F8ikVRWjBPyJxNtRPtRCqrT93Rv96ftUwUSFFfNphW6nIGaiNpJVu0xFQPflFBXm
	KMNdo3oM6qkxK65N2knqQsiCgZ9/h+H+Ry5KMTvFgkGr7fgkPjgFkmhWymwcOMyC
	VO+DfZQVcnHxMNzwoTaYfahwpa7PvK+SjpIB82yuES7AM/PA3byw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8at90ac0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 19:52:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5IA8SC035964;
	Wed, 5 Nov 2025 19:52:44 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nn8rdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 19:52:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apL6MhHcBQvbZSOvhgSXWb515coIXy/1RTajGzXaWo2i1HxioD4bvJMzMuC9GNaxLb5MpCUKLaoqX+h1/rGpyTKslhqrArf2xmv0SgcPkzaCrFd4YJBozgCYJEiu94GnagKfECQMf0ExgdR5hAH8WJbJTGaqzPBjUgxU1BavJ6vvczMIuUsgViKS8TRq/SGL/aiebxPyKT3snHfeDQ0zIu9n8JfS2bkVAvEmR8a7wJLD2+biRZ64Ri268WUXScTBm+5WQ0Vej3rm4d3NbDi1kgJsNtAddTCsusLtIWm5kXEas8/HABYXf/fJnC7sTUdkLEXLZ+ywABC3CXXbQZL1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJJPhSH/SUu9Qtj2CnKLwBTrxg6Jynk6BL1f5tLrfU4=;
 b=XLb4Kkb5MrsOjdiMoL3h2blTld4bGYzKiEriscqnox9ZdjzOD8SFRECWdz3gAVwSmn79ciZqJO7bfVUOhnw/nR1oecahy/v80xorioub7Zx29gc37EGWOAkutibYAaiwH2vplU9uEIdjM2LDK0wgX1Kwh0kU3UHJQc3jNcVVpFrhmP7SsTv2gg5stpTAYIs9md8ny09YcQohBFJNuNpM+Wz05ltuf8arTMjvjFA8JhOhc0hnCTwV6cY4ImPmsUC9JzkKYcPNgBuRt4kZ7DAAz6NlH6DPvySYpH6H5OoiTjIHxC6NyH9Wzo5NDXxSuguFiP+E8DrJAwCcVzqvU3J96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJJPhSH/SUu9Qtj2CnKLwBTrxg6Jynk6BL1f5tLrfU4=;
 b=CUpmvqOmwWb/R+qI1KzA8+vXmS1Yl8agkXS1ic3EOFmV+mqNi1yMEH+/V5vsRaGKU8RR7hYUcT0GR45SV/Nvh5foANFdeyeXh+l3yuSTljRhlPvHAxqq3zat0m2yX2ac1pMqPzMdbLG41GqkMFCgeeaCYjPwNTWqVMja05OWDMA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 19:52:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 19:52:38 +0000
Date: Wed, 5 Nov 2025 19:52:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: LO4P123CA0613.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6ec21a-0e39-4b79-d446-08de1ca4df6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yNbA4XY+BD69Cv7uMOmKc09Hh/rajJP+JGsoSsj02853ECZtRIEVDNiptJ3p?=
 =?us-ascii?Q?U1I6KuUU2Imxje350ZmF1mUcriw42SvFgWLv3BALHL/mj/6C3mvgGJ95CRJf?=
 =?us-ascii?Q?TG8OPdOLiZ/+DtBn4loZM853Lc+lhrZ1LJYqijMrC4l82B1hnw0XuGpcrcj7?=
 =?us-ascii?Q?PQL5D7RkI85n9L8YtL0sM13Dcf4vtFPNUfCCnPfiCW2y6cLDfTy3WpsR7Exs?=
 =?us-ascii?Q?XrKUN9F08S9Fx8ShBvSaxaywsKEcE0eEDtuh2WpUYRZrMBGE+iseIis/nCzN?=
 =?us-ascii?Q?ZstpIwTXpd6NE4sq6MBJcigEfVFiQISi9DlPP9XIkQIcV/axQvxE2Hqipdsm?=
 =?us-ascii?Q?4aU0F4IhVk9PoL2TFosKZDRJfqrnGtYTtF5bls8uxbROIcSMWFIrw7gKbvEa?=
 =?us-ascii?Q?zRvJMPpf8rye2BrWfTT0uemG5V3QsJVtbioNU6uiCGgDrhi5rWvRI0T5osx4?=
 =?us-ascii?Q?9GMuFy2Fxr9uK9Fq4c/jUmNNWlq4MGeUJNwaSRIReNbijBmZv89ZZ4j0b2aU?=
 =?us-ascii?Q?VZCBebJxD2Vh4N3pwRM34zl0fUEDRHzzkdp62a57A6b+3aV5eEGlvSz386dS?=
 =?us-ascii?Q?AXUHJuD10W8ly4wHUTGP1YI0l7IMgFR0+CcDUsw9JuPjKYN7HnOj/KrYp2vj?=
 =?us-ascii?Q?SEwtM/vrXMp1bNW1vM+6pCLijceY8bP2OHvO+XXBLV3QW+OTFUgaToENNg37?=
 =?us-ascii?Q?lE6BjvoqePXyZtA/APXGneJA9ILtX6a67J+a/YcJIMLl4QQDMmBDaBjrRiA0?=
 =?us-ascii?Q?sthoofID3yxQkId/YEQ7/yTBaUMdbt1S0j8DMijf/JSFft1Nmkls7i8RtpUv?=
 =?us-ascii?Q?GECz6yrrL8SGLNdUcMPDjqccjBaCSN35zwy/SUFbj9Z4O95BFYTmW4b5gFc2?=
 =?us-ascii?Q?uWs8BR7jSsC+/Lkr9mgSzmjKXsLlB3vigxkuSHsxyVau51SyBAhQ7uOA7leW?=
 =?us-ascii?Q?PNVhUWTkIqYhTv+PETclsxKvsTVQB/HTuP/L7RBfD4Yf61XhkNNf8wM9Ssff?=
 =?us-ascii?Q?poLz2VpTEKxxKVieBmR2ylbPDSfaurxIsogaxCke/1Phy8545MfkJjMFmcxL?=
 =?us-ascii?Q?Z6D6YsrD6Dgmua4qK7/i7f7dVDrhE6p+PcbxqUUH8B7KxkCbw6j9C21KQKtS?=
 =?us-ascii?Q?f7N8yjt8v4Kl4zTBnBvTfEaIk7/LAGpMAmbYbmSp807IBQchjfD4+6d/hos5?=
 =?us-ascii?Q?XfN3Ck/UHnbzGAl5xZ0YqYTQvXQkANUbiszdzYovMevF4GoGKsQyTCFuceXl?=
 =?us-ascii?Q?rVMl5GmHmhTqQviPSvD9CRw3ncQl0YItEOxkHb1MtIceRNqgxGc5kq0Qzz9S?=
 =?us-ascii?Q?MYZ77gXXoAxfqxTppEoGoQinjPuAzuCRDHdYpa0GJedhErGxBHPacfiKkgnw?=
 =?us-ascii?Q?7kE/FMVjisHp0aq+oV8TozyzpPNiAbfFIzvY3oC4IuYcoWXyaQK6k4/T4qdz?=
 =?us-ascii?Q?Efeg3QFcmySROgecbQ8hnt1+U4y3hBe+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gp2w4yndu/ytTcYNiW550YYtCs2EGayrth8e5cqcABdaFojgIF2e32GkxIEJ?=
 =?us-ascii?Q?l/dBStsoLMGOSE19xeZ6WhSEy8M8mQ4QHZnBN07Fslf81o70SHI2rGiZikwC?=
 =?us-ascii?Q?PIsGRmfSYGcIcFWJQx1gD+GpmI3k9Rq6hmJ46xWhTmSVn6nGSMPHkeCJ5Eyq?=
 =?us-ascii?Q?vTH/4O/M184evuJmpon5+qqpEr8VJ/6UJ0QvUc7c01l7zavN8m8VEPxZwUXO?=
 =?us-ascii?Q?c/Llwwjlj7Le0AdAt8O/7hzgTdQzss71+c9Hiq5gs1L4bvveK11ENpDNWPjk?=
 =?us-ascii?Q?mc1zVl/MFh+y5ba6Hgz4MNbwsZprpkma9g1s/cCANFJlzTXphZiCnKxF1bVv?=
 =?us-ascii?Q?OTgPsOB3/ulFBGPRiYs3S+85FnHh96OUbxe4zifQpSTXsxjW6REPJDmmeTmR?=
 =?us-ascii?Q?/LLZjMoUCjftxRvpGOSWzuBPq31i4vozf31v5smeMulv+gFBFSU9kL1jffS1?=
 =?us-ascii?Q?iVySEfHwIGdxxINct26CdgFzb6wkeo6t4dTXUZTuW1tKGImTpDT06tyi6ak0?=
 =?us-ascii?Q?oyRsB/pZxWGhvKi0NGJk9fhE44BJrXTNp4HG8D3vCPzxpb0ffNMjEmJm1Qha?=
 =?us-ascii?Q?IUlOhQMsN0KPjh7RayHG2vzKN9puJT19AolImewVWLGb74M721W3aKcweMTR?=
 =?us-ascii?Q?X6L9aZGBdVuPyZ5aNganHMK4r5dKU3OOAqxWDh47AuQ5QJlJir8dlAM1o5t1?=
 =?us-ascii?Q?rKTj8t8wVnRsCpdJh+uZj1uYJrr/9Kx8eBvqOdg7N1zmACIFp0OsIz8jlUEX?=
 =?us-ascii?Q?EndL0cO0lR1OwQ68ZD1SU5gFX/G6iK4g4xrI5oYVLK51Ky0+pOLpq3CbrcgJ?=
 =?us-ascii?Q?6BKccWPqBCvD/3mQ0N262L7w+cmumJB3ti6T9Xi2+PxwbLnHDgrOp9JLSZs/?=
 =?us-ascii?Q?YJk/pVpp96cruqzm0ATJCovaVNNrTXucmRyxZNrS8WqlzKtPuDwj/Zxe+Pes?=
 =?us-ascii?Q?5xlPNxpIMEdK7AWscWa6cnsOd8Fv/qb9NM4sZlhgreeeSuZKEwrTZJj0n7Gk?=
 =?us-ascii?Q?jnx/Xc5odm2mV/A1aiX8DiyYOdVE9QOYB27iGJnGqWzqgdtakPZo25H9ceSQ?=
 =?us-ascii?Q?GR3LaYhCqz/FNqwFuHk0zvLws1UiUyg/hdiJLM34M6pq9o/yzXBSCwd9/jYK?=
 =?us-ascii?Q?77nRxigw3CtZrZ+pTi20pegv7HK9/P3f/XC7zxCHmcembWVqqOf3Jfj1B2Au?=
 =?us-ascii?Q?LZ4Y6AVUQtr1QTlme/wfWCejxERgx5CfSskPOkWuWMoci91QS/T9BLw5eKZp?=
 =?us-ascii?Q?LLnRZo8cShJdUal+eUWqNXniSC87Bt1lFuUsLCw1fO8zUzbdPGHNIcaaXbV+?=
 =?us-ascii?Q?G0jCCcgiMqAuhzk9R4ftFghdhKvKx51Dgb/YAC99AI/2sEZs2y3ffIWssHAl?=
 =?us-ascii?Q?4g+Sl/GpMlU4yfR+mchXZeAWqTUqX9LB3ca/dWcOqx3uNJxG7/T1S+z9kcns?=
 =?us-ascii?Q?Xrf6fPAkiYneqdrLwh3IcE6wTPLX5YrWdQOYIEsR3ln3/aT+VwzwThJIAXlI?=
 =?us-ascii?Q?0bakmB1qWm7N9vuaI5a5tE0w5PO3Dro5bu/vZ+Ljx58DTmaapZD4FeLsCsIV?=
 =?us-ascii?Q?MDNsuXDRAJYtYLvILLyBrGUlcJT40G9jHpKj7yJldxGrrBjEPO3TK/PuxjIq?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XYrs+/esYln2shLejCj+XkjBARFuM0PYR3K5lRRnXm6+A0sUr0b1hdgxFG/XP8YloOWKcZCJZsrd6O7zRNsgRrqnP623YlPanzzACLQV7ek3vGSXkIvmFD3N8hf5n+g9rc9tSIVJYDlqorVbTYzUWrTIQmnMSPVGX0gmE8l8gYwgyPoLgbw/WDJTm4bjjs9SovE+JeQI7c3hxCK0Htywx/T/pY8AKC7Gz+ijdh2W1C1JpoAUH/7vtcmlSrPpQKYo5b86h6E4Xvtd+grwdE0AFbr2w4mhBD6kavNqfE+V4Beixw7NbND3Lja1rv3JhX/iRsr+6OE/Lby3JOQPI/zPUDHnyvKbQMJgOGStFWZvni63O5Ev2SSVBXotu+iR+eisHTy9/0r9tvcK4lEUzPIzloeJ6SmK86ye2B2pNT5FKobjINnO7mqN6NJTlgHiwP2rdbtlp8rMBH0XFmcOUmsLNPcx5pWyfCTCSOJ5dt5wDllExu8k42/lANJzgdyZMfcuRzRa3k3dFyhOigFXLHhK47BhpzJ0eP3tpeajBOclW7pJF8bf+jUURTD8uCeEGBa9HkguPwjSIUcW71qaGU5oNvKLETfx/7JryZRsciUa9/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6ec21a-0e39-4b79-d446-08de1ca4df6a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:52:38.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSplFlIS8LyYkyMHyz4OPxh1oV6t1Yt9XpvuZtZ3dH5V7Zejky8Lg4SqxDFLDEzD+lLtWnH/REXN1LPoNicKKu4Ej8ZQTLm1VaZDNCdv2mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=662 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050154
X-Authority-Analysis: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=690bab0e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0A73lpq3wyF4uw-O_RQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12124
X-Proofpoint-GUID: 0kGD6MhqXybkmmZNPCQrKmtmKwRzAumV
X-Proofpoint-ORIG-GUID: 0kGD6MhqXybkmmZNPCQrKmtmKwRzAumV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX6aGiddG2H5N0
 qaQzmE0n/OoqmtrDSTOFpoFHlJ/EDbbKv4cWul6qnmxukM6ku+ddgKPKdIP/HjkyNYvHwLVpInw
 cKekwxXrg+EZvG2RcGjSRNMrDmBdOD6J9tg1IB7ka7IdpW3B8oTOEWIh5azwh6FdVgzsjCoPid2
 utg1c1OWhvozVljutR+1HTqORmXYDrWuQ1oQIbyNjYGaZwzjPZB7ZuZXSEEaavvxt7ajQFhlpoC
 mW6HBSt4EXV6qBfipU8hqr9yDWTZCsVFaBHROD/lpN1oirQQYv5ZmXr/y93VVo+cxb5rQXSAxEv
 rn/G+JGu6dS+cBRe4i6Zcph/YY4/g1bU9eICrRoLMGRGRWThJYwdwMpoYKn6o68cirfbD0m8V+/
 363Kqf8SRx0Y8VIsoO+RjJHrwrhTxGJKMq7kv1XzH1uI93g1I1Q=

On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> > On Mon, Nov 03, 2025 at 12:31:43PM +0000, Lorenzo Stoakes wrote:
> > > The kernel maintains leaf page table entries which contain either:
> > >
> > > - Nothing ('none' entries)
> > > - Present entries (that is stuff the hardware can navigate without fault)
> > > - Everything else that will cause a fault which the kernel handles
> >
> > The problem is that we're already using 'pmd leaf entries' to mean "this
> > is a pointer to a PMD entry rather than a table of PTEs".
>
> Having not looked at the implications of this for leafent_t prototypes
> ...
> Can't this be solved by just adding a leafent type "Pointer" which
> implies there's exactly one leaf-ent type which won't cause faults?
>
> is_present() => (table_ptr || leafent_ptr)
> else():      => !leafent_ptr
>
> if is_none()
> 	do the none-thing
> if is_present()
> 	if is_leafent(ent)  (== is_leafent_ptr)
> 		do the pointer thing
> 	else
> 		do the table thing
> else()
> 	type = leafent_type(ent)
> 	switch(type)
> 		do the software things
> 		can't be a present entry (see above)
>
>
> A leaf is a leaf :shrug:
>
> ~Gregory

I thought about doing this but it doesn't really work as the type is
_abstracted_ from the architecture-specific value, _and_ we use what is
currently the swp_type field to identify what this is.

So we would lose the architecture-specific information that any 'hardware leaf'
entry would require and not be able to reliably identify it without losing bits.

Trying to preserve the value _and_ correctly identify it as a present entry
would be difficult.

And I _really_ didn't want to go on a deep dive through all the architectures to
see if we could encode it differently to allow for this.

Rather I think it's better to differentiate between s/w + h/w leaf entries.

Cheers, Lorenzo

