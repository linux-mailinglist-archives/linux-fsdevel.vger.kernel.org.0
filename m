Return-Path: <linux-fsdevel+bounces-60542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6A6B49207
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC3A1BC1796
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454330C635;
	Mon,  8 Sep 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qTGF/yNt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E+z8GtYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5A22AE5D;
	Mon,  8 Sep 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342911; cv=fail; b=HxmxD45V6E+wZshfMZ5YJNAp7D7GR/myNxmKNXb1uDS3K17F74kh/P7jrxekphCBGirif/9jo2doiaAm9/A4+/kKsMdFOXKCLbx2sMrg1eXkGC7FSkf7jSgUeWPUnpPyTjBXF76V4tOif43QnODwRMNi/a+qP0cK74+LzxtXr48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342911; c=relaxed/simple;
	bh=RYLU6znws5MEMjPtkJC4HATgEO6uZNNTe7Q2skWRUU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p0xw6o+bP8VK9MtnK3oJ2er2iQMah/uwjDkNHJcfUt9X6I9xfB7l1iqzfe0mRBKB0T6iqPUL+aXxvEl2zHurNT8ms1c0SjD8Jbgz2W3KZ+y6ZQnJ83iy0tylEr4QzDBWHPx1AbtiVegDq3ulkuRPCaxHLglyGjTQ3VoACYGMPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qTGF/yNt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E+z8GtYj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588EdcOe003523;
	Mon, 8 Sep 2025 14:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sl9A9tm5ODd+z5CWzz
	yagQFGQE1WJK61sW9fDPpxLQs=; b=qTGF/yNt42mFOxZURG9OMs8rqXoPzTq2be
	y36SA/5cs6DuS2fNn3t9VEJvkxC+d/tMoEolCz8ipo6TJKV+AwsexGF/YKyTJ6TC
	XY6Sf3M5hqeUAQz9bGYzQ8fa3ONolbszDD+tFBBIa4RgvMst9dXSBZ7ZpWICvE47
	MsmKcpqLiFSL6jQUBGD5nzS3g3jc+2eJTnYs2VnhwIUmcZSS0WrGXXXjqZM6GgnH
	y0268CG6/iMGystPj3uy+ZorYQqJHhddS0GIn3Pck7l+jo/XPXNXGMo7euPVLBA8
	eSMrSezw4GZR8pasfPto2JeB+fWB9mt2KtTbluxqHmphSDCiJrxA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49213p00hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:47:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588EadH7002867;
	Mon, 8 Sep 2025 14:47:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdetby8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:47:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3dDe4uSffKPrb0r/47ZUnNyD4Zgg3bhun0gxqzhQo1puoEXWcbo58rYLNJVaINqDlPPUIxlcFcpnzzSuuxW3pxb7YVaKyVB5llMgIVLktgTGIJug2/K9/BbDMhaSaabeNBB+y/oOhC/d8u7fjq4Zgl72LGYuJf7LoC0BXWIaGzQfH/GR0WgDHURQjNQj1HKJVMNk8TBQtNC99bomvSBblxOY5z2b1j4uqMeLxIR0ajicowxiRmszqJ6pRfPFpNBb4OdpQ6WBDriy/YZMZlsmPOWH5JRdQ+1bZg1tvqiUHcFyVoFJOsvBTXUyQSvuyItNEGgsTpdH1oQc1Yp5pwpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl9A9tm5ODd+z5CWzzyagQFGQE1WJK61sW9fDPpxLQs=;
 b=mhTXVf3OYhunWjm8CyDeUAmf8gFlRJQG6jvidvWVZtwYC/s8fT8EK/+Xo8j9/9zeR4Nkaz+y+Uj1pzAQv+9ApZL8lE2AC1krng09HH7UUiFydljx06EuHxEy5adJqJVKPG5RgpxK6tL0hIZgwxR6y/ibmbjO3yBPPjlZMtiLmqcoDDF69KA/xhW3Zyu4/2DFnYZz7bspSZJuc0O1no6prb36sYn6diRaTIcQLJrtfkoNp0d2ihPpPsF4jnLXh81OLZqJX+GLvIYef3oy+zbx4+aKl4poLz4x83YaZVOICG00p8CpOcJ6St8YyP010YmLlnfQXQhQnvgMx6MBpDN4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl9A9tm5ODd+z5CWzzyagQFGQE1WJK61sW9fDPpxLQs=;
 b=E+z8GtYjZHGXhtB7m17FGOofhU9ElqwXHOzpqrPD40SxXBJ93Nek+qruhqzMaDO8ya1ZV+SiKrLJ0+OCX4uCczNYRqNVWgfkFzwiZpql1FcgEAxheK3PK0xP0sk99A+ITqTVXvJqPB503gChMxVCFHCpC4Kj3guBBxTHjk2cX3k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5110.namprd10.prod.outlook.com (2603:10b6:408:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:47:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 14:47:36 +0000
Date: Mon, 8 Sep 2025 15:47:34 +0100
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
Message-ID: <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908142011.GK616306@nvidia.com>
X-ClientProxiedBy: LO4P123CA0524.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d39c06-98fb-43d2-14df-08ddeee6a6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EySgw0jRAQCcKEBRLKB3Jqz018O6120cPWWRk+WYFP4KHnN04AFua3KnKxJe?=
 =?us-ascii?Q?YSz24Ttsor71bZL6zsC5DBYMCKL6vV5fAnoGNiGGRU2Y+82nvuGq6j61T34j?=
 =?us-ascii?Q?UA5aYbi8fnGv62MWA+pV7OCIi2947ZjWRF5SFqAYlSwaafxKFdDkHr9inGKk?=
 =?us-ascii?Q?hTr78hPWXRRQzNWq49PlZfPBpZzf/oB/9VSog7Wnwg9zMi5a73xvg9Jlf3wC?=
 =?us-ascii?Q?KeryIxlK3XIB8uSjlkdOzKQDO6M0yK+LeJE2MSBTr4VyKs+pNlXurknxinlS?=
 =?us-ascii?Q?gwKYW93ZmyTcywdzz1otmP+ET8lUOAHgznDTRuf/lvnhejztUSau4DsToma0?=
 =?us-ascii?Q?cEI2l5Ac9XqZ7QvvgFFH6dYS1fMYxHw5Ca6L1DovYMXPSl6wwv2YsN7+kEkx?=
 =?us-ascii?Q?kdhZHlptxCWMUBKHbeUdPybp5bmmv/eNWBzdyHUxdiNAAzmgXfcU3Wk+HECs?=
 =?us-ascii?Q?yqaHbo6fO0tfQrfTsxSKJM/HLbsX0uCwC2oDbHvNybVSUbh8a4cvYzt2/c68?=
 =?us-ascii?Q?D7Y1oD32ivcUjZRiBAr7jHRgOfR2WGrTwYbvPPII7bbK/BDy6uxTolk5NLQA?=
 =?us-ascii?Q?rzquBI0YFcX/Enx1m/pFSmHwB8eDN8fq/xXwgXzPikwIWD9+vT/fUhkWzIeS?=
 =?us-ascii?Q?5PvkGPExYISxeqBkW1xpUS+H0F6rfzcwhGOdsi9ug0ngQuJTRQz3sRgoVtHv?=
 =?us-ascii?Q?pfl42Yi1aDU3/eAAQEf7ZuXiCBxLQHEv/FHfeGNhc5czZCrBXyTc4mWLxFqI?=
 =?us-ascii?Q?EeKeNbUY/0bY5e4ZHqdKDKhgbcCONdaLxWT1guCYyJSnlHEwDDQVodzbYe5M?=
 =?us-ascii?Q?5FdHjQnRsex4GAgSHSgA+7lMcBtIUhvzVzBhAumpoZL2cC3bnje2C0GEl7o7?=
 =?us-ascii?Q?CwqgnsdpPsYnuTHyAht8fYUz4enjPhTQUUcCBtsDmfcS6SGVlQz2+uAZr4do?=
 =?us-ascii?Q?rfCrLrGzrFAB5GAnQtkDmWUlJd3RPIiAlDrACpsMC/pDm6wj8YLCrmtOKyVb?=
 =?us-ascii?Q?1aR4NM1/L2Nps/+xwjkoLpogbYJTY1+vkxyMxkna9ckChJ0j/bWJCDlqt9U6?=
 =?us-ascii?Q?hAwyO7OlmvnkuJNblo8GgKqY5lDndKfFbH3V2GX2/YyWE3JEHSJEV0l8IgnE?=
 =?us-ascii?Q?6/Iyq7eOQWvvGGQlwNly3F3EStru+RZJICHKy1kK+WQUDbSLh/BlagAW9zbw?=
 =?us-ascii?Q?ymXNsiodNiF9QKdasapWlXTWqq+jYmIxiVwPMj0aCyiBrGueGRccxw9IFaar?=
 =?us-ascii?Q?7rUbTfRKhHH3YMaWD3sqJOOH1Bj2etsp1u8qFKEi/XwA7aJ9c8APBrbKw0a3?=
 =?us-ascii?Q?M+22cUrA/uKnUTQ2+xjtGyAhhJgTAU3jL12Byv+/EJxy+1/X/LYManN0RJHg?=
 =?us-ascii?Q?MuAX3MUAU6ikPHVeo3aLqw3mOa8OCd7O4tLXwPvstoeZBXZAvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JNxi5SvGu5HcsisG7Q+nqaiFCsK8egXvk2fvNJWX0ySp+pR0785o6NnFK5KS?=
 =?us-ascii?Q?EePptfF4Hq2Xjp7JKR/w1uuPVnD9MKFAxyrwYvn3y9wOTjQ72j5NlTZ/SjPM?=
 =?us-ascii?Q?AuG2X0ksbDveEzx0evJeE13nhGmpusEo+f0RZhxAihBd0IfOOgaeq7ARyeYA?=
 =?us-ascii?Q?pM4p8LVI5myWyeswlU0Tp06dKR1gfMQbPC1yd0Dfq6/A6qR6BT057aT/1P1A?=
 =?us-ascii?Q?iFsaOkoWW1RMK+ea5fjg8kD+u3SEZKsXtql2Kq94EhHMD3zFaC3fRRz4hLEC?=
 =?us-ascii?Q?iIPU+/v8icuNCfvl4HN5ZssypzecSmbO8rJss/hyDDWtGFqiJHmU5hwp6f6l?=
 =?us-ascii?Q?HA2NFfRxnzjbQ0VN0uXIfiQqmRPVVS/+m1so8Q92yb2KegTnVyHY82wVz/e3?=
 =?us-ascii?Q?oaTq1X8pOYrWiPfFPmuvUT78r+v71wP4rQxkfZzYwoK62UVmVUYSc7k4CXUU?=
 =?us-ascii?Q?ciiTohY2l4O2RhOW+yLNMj8wIyyH83J+QcOm9OWIvO0p09PquJNkiCeA14xl?=
 =?us-ascii?Q?SkPGxk8SVzVj/AUNlpQB3sVUTSGFFCtnbbwR/Sxxb+7wyLSB3mqBCB9/Z/Qw?=
 =?us-ascii?Q?6jU4pivo272FxD66TkcQYMwJcH05ikeLKU8x/SyR6K3upWjgTpznEDbFGi0d?=
 =?us-ascii?Q?QZKxPimFthhF1kPAfKpy0lfntpJH/9//vDRusZOtm81BOgvllg9GBMywAjT3?=
 =?us-ascii?Q?S0vDyqN7lLVygjNohC+SkVejUoqx6hffKrJ68pqRnV8U4flCVPoe03lx3Kqq?=
 =?us-ascii?Q?mHr54Y7RIgemaU8lHccCpDeepsKUxttbTNhY+PSSRnhY2j6MPgMM5zB8+R9P?=
 =?us-ascii?Q?25ahG/ujVfszZNZQLxNBoegcF0fM1iHpg520xfm9br6absPNXHtZJS7Je75t?=
 =?us-ascii?Q?7MltipafvlJp5LAPxTFO73tRQfvuz2LPrIYcNVkkSTAhK4x2sAgEk1zH7Ieu?=
 =?us-ascii?Q?R9efwzYSoSACtA5d5SsAGpqUbByVjihDox0USCuUa5zKZA1Sj0i7wynZ3EaD?=
 =?us-ascii?Q?w5ljvTEFtSfCNQea7SZBPGvBH9zMkPoFaxWc+rfvm0Z89F8uSXiUYA2s+KYw?=
 =?us-ascii?Q?vtf9W0alXygcUqK0dyHdOVG7t5Jcr54lzUPvRSISChdPRgv377mFQnBnvOWJ?=
 =?us-ascii?Q?M6FcsdtXVf9fdvN+0DPZetmZYGE5snGn+L0GN7Gw9Wzl51MGB8mKp6Zli6Ao?=
 =?us-ascii?Q?25baiwZy4MY4L8X9t+CsIIL3Bhl7QeNmweJJBhVIiWGNunvEvV3c/QMnffdH?=
 =?us-ascii?Q?Hvpa5hwzMzLk+FveAjHSVYOwMX8emzSAQQC8qTZWC0Gk7OytRpO9tdsN7hp1?=
 =?us-ascii?Q?lB6YGEkpT+vFr8KfiP0vXv6lT5HD07qb5rRx7VeZv7Qp1y1kUvEnYYlOrrqy?=
 =?us-ascii?Q?yUbFP/WOLsC6LJaYsu70fB1uaR60hUNo9sOcyl09Hgpu2aCEUNs16GudzEaA?=
 =?us-ascii?Q?+nJNeqjQ+YB1J/gt4ZkcvLYEfHKAXNZ1WcAI/EXVuYB8osQaf4UM40vg2g2I?=
 =?us-ascii?Q?W932J3QfJej1YA2QklfHTHX9QrngVlJELWczPgr8TnWuxNMDXGxiVHwKa9gX?=
 =?us-ascii?Q?PtE7WentOQzh3/GvAqLWlTMLlcgjrxkUG8FMtIl4LpnId7HXJvGV8MDUfsTP?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LCtTVFhxOstQHexVk6m3mK+9c15uQo9dI8V4I6EWz7g9gQCNpmp14oA9QmX0dMIsYw3lYQgH7DsNKwQTrN9FByymu/u6VgCkFTEqyxAHnYl8ZvKqPu6ipo78hm1oLC6EhEQtm1dZluizZ5NMn59vg2weBaAYzfVUqTVPkfWSV3x74wNUkmt9yG5mN3x3+D3ivMKe1+b9hHSjEs9P1i8D5uPLkWJu77ZvjqY0XsOaI7oMLqcSu4u4Ij0kYOaXbTCI/KoGmDDCm4YLvglvdXbj6mYNu7dl10u+EKVDZCaSLTJReewNFnWtUwwFXqZ8VDAz6t38e7Aqy+3uBi8LYGa7oWITEpUqsqA1cG5z7XDrqdCIX1JsW1us9hM0HDrwqTOkYGMRD9MzWJTuebBmZo4di61y1V/qhSKNJ0g4yZA+7eQgPXk+qmOxWMFhR99o90gR9Emi41CXGTMAJgN+IhNcs+QIOl8orgYVnVmqq90ZHeSbhzzRrt8NuxAFBi+Qdkh1R8X2wA+GDKIu3XV9CYaLWyRtC7c4cXgLh23cZM843XkpMfWbgSysq9DJFIrjHb8+n/HhZgsd4NQLvt6jD06bAxt9S17jTM/Kh9HkkWeMSKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d39c06-98fb-43d2-14df-08ddeee6a6b7
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:47:36.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoT1Y3dZDsE9ZGlYbQl8Q5oLjRyD7g2PKbymUn3VySFAx3VbljEIZgCJq8Tf+g70bV4n+BCZzTjIzEBcEpRdv7/CSt9F9qrKDaoXzsoqIh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=839 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080148
X-Proofpoint-GUID: PFel3BpqTooO1zA9PYU895R71G4-RJZH
X-Proofpoint-ORIG-GUID: PFel3BpqTooO1zA9PYU895R71G4-RJZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE0NyBTYWx0ZWRfX6S6WCfwJL1vR
 5l5r72t1COyfEeeURErAhJMGd2wbS85XDmmwhdx+VMTwJXIPhohDD8D3bKn5Wny1nFU8E3zy2Hh
 KiJm5hi4fF7vkPf6tKxpAjOqcZ2TaDV1KzuUA/xvm4tv2N0SBdiXYRfXSmDB5uNeq9NYzAMgL7y
 xxDU9PVtGOLjDCYwW0U0q8Sf+rg1uEtV437aWg337a/kFaHb6H+DGOFofjwDK+eChUJxHShHKh1
 XLCtCCJqQQVBz3iAw2Z5CEV5FTb+M1J1AqToCRIvxweQWSYEZgW8RSWVKWuCaErr3RLZwDagu5W
 hVNKg3qtkVeU+08/+9ubtjv075qe31AyXubGdsZ9GFizufCVWBRidAHFi4HLnHNU8N3CwySGZq9
 H+vA60EKvUEIthRmh7SdJ9HwNcDXdQ==
X-Authority-Analysis: v=2.4 cv=F4xXdrhN c=1 sm=1 tr=0 ts=68beec8f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=gYB-7KtPnNzojsEmhjwA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069

On Mon, Sep 08, 2025 at 11:20:11AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 03:09:43PM +0100, Lorenzo Stoakes wrote:
> > > Perhaps
> > >
> > > !vma_desc_cowable()
> > >
> > > Is what many drivers are really trying to assert.
> >
> > Well no, because:
> >
> > static inline bool is_cow_mapping(vm_flags_t flags)
> > {
> > 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> > }
> >
> > Read-only means !CoW.
>
> What drivers want when they check SHARED is to prevent COW. It is COW
> that causes problems for whatever the driver is doing, so calling the
> helper cowable and making the test actually right for is a good thing.
>
> COW of this VMA, and no possibilty to remap/mprotect/fork/etc it into
> something that is COW in future.

But you can't do that if !VM_MAYWRITE.

I mean probably the driver's just wrong and should use is_cow_mapping() tbh.

>
> Drivers have commonly various things with VM_SHARED to establish !COW,
> but if that isn't actually right then lets fix it to be clear and
> correct.

I think we need to be cautious of scope here :) I don't want to accidentally
break things this way.

OK I think a sensible way forward - How about I add desc_is_cowable() or
vma_desc_cowable() and only set this if I'm confident it's correct?

That way I can achieve both aims at once.

>
> Jason

Cheers, Lorenzo

