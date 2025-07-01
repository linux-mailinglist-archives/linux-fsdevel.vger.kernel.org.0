Return-Path: <linux-fsdevel+bounces-53471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEAAAEF596
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A60A7ADB02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72B27056A;
	Tue,  1 Jul 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pWu+baHy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aHiKc+xr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F331D5CDE;
	Tue,  1 Jul 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367121; cv=fail; b=ewIC1FRHz7XXA+Jz7EFAlkRnzJUMUfZFZO+/Ie9HHrNMffTa8aFf/A8NRyXOwuPOT8sQe5KgwrJepM19obsTOqDk9FCTlgHm5lLCqLsvLL+Hd4fDOQBZGK7M9VICvlOGQIsikbB+5CCFm4AoWFAXOnKw7P/KuaZ9n9ncfVbqbk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367121; c=relaxed/simple;
	bh=gThMcasDy2Ffef2gqRCgBK2v96npAC6HL+EMQDnKcBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aRXh9tsm6fVvO2twX2xiD5mJJhPBLecvIf9l/xOdRUcE6W4SkY6LLYEi4Rco/QSkW5CHoikN1DpIIZFPbCuqwTf+pp2UlY68kHNPquYH2vHKDGorF2aj6mZxJToCMz1Bwv/92Nn+ll7Hra4HT1ZrGf4oP8yQDAaDmr081V5HEug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pWu+baHy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aHiKc+xr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MrkF005833;
	Tue, 1 Jul 2025 10:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AvufiYCOSINoEHV10u
	Tkw7uta8e91k0LfesGk+8YmXs=; b=pWu+baHyq7TzH/U6HDU8ug5BU3PahbCOWA
	r3uuvP/osM2e80UWBT6722bmtGmJYUhmyTBCnGCDpvmFYoMif/R7xp01l/vm9UZa
	8JQqpdSwjkj6yhnLqeB5AMufHsdJS8/99BhN9JWuyVbDmYu4baJs3qqrBjHrvym8
	wtXXONFtuYNYC7NiJI6V2dH2kIGguRAGQx+nw7DfsI9zytKYUTn1cafqj/dNU9aN
	OhUA9gB1vYbU7NkBUu1qfV49sCCgH0nGbQlXXUBjstCMoHBk5AYfdUUOaUSCyKuW
	pCGoUqJMPCEzPnuiyousi0cglEScw9X39UhNoBY3hevKrBHf3GxQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7ut82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:50:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5619aJJG025831;
	Tue, 1 Jul 2025 10:50:27 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011026.outbound.protection.outlook.com [40.93.199.26])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9k8sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtkW8Q72zGkONFY8KHlnN9s7PukXglxGEUSGy+g/6jDGL4gJejQgUNrICc1BJ6yOy6vHDcOxU8XQSJeiojabqPnXFMKlmwZdir5d/qunJQAuHDP2fQvHYQW5nleO4QSN3AtIU3cXfo8oSw5flY/ytcuDigaVSg4e/KM6hF5/fTj1RJatqPb29VNvbHpBWDOoTjd+/mKbabUPbmHtdBn16qAEXqgjDSo/ppPQEawH4PdD8IfcEW3rc3hbg780TN74SnKmIVEDMD3e6mJyPH0EVAMJibnkFp9wk0lCnq6yjJVELwBraZ1zFGdCNhklYWVQawmQgbzCjW8AuraTtS5F1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvufiYCOSINoEHV10uTkw7uta8e91k0LfesGk+8YmXs=;
 b=cjbo3VDrzZkmFrE22cHtOvsvSAQEwMeFabn/u/+V4ysq7aZQnqIaDDL+54oZuLwq0YLxLhPlay8MsTTWR9puMFcHb83VFXTy2QnKGK6PFFemFeZHEptfsRqYDuShobMnl859q4t29C5fwj6XENpl+LezseEPiFw16tyi+z60gz6W0+DTUU5mwlnI0gJfyVKlu+44R5dGP0bBWoxyHUIpJ74PI0pCd0P/eW8n1EUQVnJQQbPjODNj0zVN60s+ZSWaEhaXolk7CCngQ3DNYxKhN2pTGHOZwv/w9yQYHaEF5VIxxiIkEdgYfCIvHUcpPV+rrc57/go2W1ejQO/PL3T+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvufiYCOSINoEHV10uTkw7uta8e91k0LfesGk+8YmXs=;
 b=aHiKc+xrSUd7aIcg9rTpUHdjwDbP6OPN7L/IMcyLvvXKbpMxXY43kkdU5brdHTJYLi/t2A34OP2GP+23vAi6BMHQFdKsjz08db6Jmb3qpNXQyq3qoUZOhoyT1X8t7ntg/wmTXvjaxgwS16G7jqMdb/uQPpLABJrRMDtERgNG7Fw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4550.namprd10.prod.outlook.com (2603:10b6:510:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 10:50:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 10:50:24 +0000
Date: Tue, 1 Jul 2025 11:50:20 +0100
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
Subject: Re: [PATCH v1 15/29] mm/migration: remove PageMovable()
Message-ID: <38e19e3a-e46b-4a50-8a34-dc04fc4a3c3c@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-16-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-16-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0521.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4550:EE_
X-MS-Office365-Filtering-Correlation-Id: 03830eea-3802-4d68-7300-08ddb88d1523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gWc6VA//ty0LqtPf1uV1mUx8VtK9DfEjWD/EGi0ddDa6miZPOydwP3IgI4Yx?=
 =?us-ascii?Q?RXgo+nm2XFFaOTtBIMFbtPZgfhcpm5ebOzIBd+Qt8MjTp53VU/YiHdOWeSey?=
 =?us-ascii?Q?60uwbXTbywRehYgrNfe470WggfhZb3Igh0Wc8zyXJcs8cXXKoqmtLCliOoCv?=
 =?us-ascii?Q?tToQCnFbUn29OYuPPUwKZimOTcOa2NEY9vKIMcNK9fkPD7mocaU13FJjwi5N?=
 =?us-ascii?Q?fPh9tQtNMXudVToY40Yru7msn3B6+Q3vswmBxHqUzXG2/fbPOyKCwmsBXVRM?=
 =?us-ascii?Q?3fmZadHkSkQDS1MjbyDgyyWXVfOie557Qia8taftNnckcXNAsIX8LY80Gct3?=
 =?us-ascii?Q?BkFkHaIYlaVbLUAAc7VZM+84tOUQuuBTh18G7Ygx/5uwz5LpFn1vO6PKg8DU?=
 =?us-ascii?Q?DpfBQDjMADcpC1MLPRSE95XpoLL1/ePiUY5hsmDlX5naYocfoONrj4Ir+n+k?=
 =?us-ascii?Q?WVntZQ7xPEUi87Qp6lgOMRnmQCe1dvsxNR3fMlYtpCTpi9dSE/duH0yOYlU6?=
 =?us-ascii?Q?mdaVUDy3Z8ITZ81iHE3kKd7fVLwfremopjGYHDl2gpCydJeQNGmYdo63dowU?=
 =?us-ascii?Q?GVQuwCmELYCL3aXX9xY9slnAg5PFdm/SzypOAex6btQhwsNIKv1bbB5OkhwY?=
 =?us-ascii?Q?brkM9RfiNERHO742r+xOdTaqvD4xnwHjJ1fDJFSn6TORGCEKe+NCr50Ulbst?=
 =?us-ascii?Q?HnaEeLHo1Zs8o/sHMjQrYP/AiophJ5ApzLp+4eYwtLkAgskr5DQlfZscg8cA?=
 =?us-ascii?Q?QFkZJHm74WWw9eGMoGbBfyfiCjEtB8WliuCMWUt+xrBnL0+s34JNBsZiqMhc?=
 =?us-ascii?Q?z0sSFPM81eCXWn1BC/EWv4FK8VTgEDJo5uFwpb3tMhOFcVSTPb0+PaW6vmMW?=
 =?us-ascii?Q?n8KwYdUZnsBgv5r0Q8sbmm+jrsRJ9/+LHMlPD4e2oj9aG/wzgqSqWKRZ+hZm?=
 =?us-ascii?Q?BwTJMHw/ddFsUIu41cwj47p92Rdr81emUBjks5RY+Ev1NiGJsswVgItC+mmb?=
 =?us-ascii?Q?GPL1sQlQQeJtvAzdW5wbBX1SGvzb2pdhJlBpTPVJmjS/Pyrs4Gz8w5VG5FtB?=
 =?us-ascii?Q?//phJoFXwL2e0On5r7Q6/ix0n2QDLtSkjvlexBbuqLRhjqChmYGbKyOSzgBZ?=
 =?us-ascii?Q?8DUg9uz/fETnMWQNiDI/sPpILRFFTjm6jPcQt6IAm5RVvm7PAimHMvCz6+F3?=
 =?us-ascii?Q?vIT0wzPa6H1hlrxM8cgPaaCP7wN95+oao9YbsPNSI23D1ffBj57rIoUgwCIk?=
 =?us-ascii?Q?m0Unknwwhcopy13xbmuz1y82izg88YKoPksbgYpKTm7MIphHK/88Xqgcnsnv?=
 =?us-ascii?Q?DUKh8++PYo7aXmzOroIxQLssKnLY19TqVV+FyMpG0x7eQuMuIeFK/4wBTrKn?=
 =?us-ascii?Q?lq64ywBcZzzgGEiK6MGox+T2tvNpQkbhMYnZHjczsENnTKrmxEqtCVbWTtHw?=
 =?us-ascii?Q?t0UxrjOIhwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uhP14XvezG8jiZpfmWvIG3mmpNXgNgoXHn36w1LSOLag+lb9Ba9fQdQQKua?=
 =?us-ascii?Q?AP3WNfkkPnd8YOauWPc91HjVmOCKaAhRU0K18G9NeMJMAEEQbjATLXJAHFC/?=
 =?us-ascii?Q?GlN8rd13saiMIloDlLL1XA6M04WSxZmluW5qIhy4UpplwrJEWxG3P461TitZ?=
 =?us-ascii?Q?ept8a388AZ7LeTzzkvEQbUVq2z2g869m9zjmV7gj7a0dUH+07wx5NhBUo4oJ?=
 =?us-ascii?Q?LSv+FxjeeRYAFr0MyRtfdhKRZGcRogD07gh5HWtvQ2myGHyBg2E+b/PlTq5X?=
 =?us-ascii?Q?PQPT8eyFzSikNfmqzfnQuHG0koDAxwb/1N4M7J2Whu54UDAkeq3czMHw53pI?=
 =?us-ascii?Q?aS/5f7OgfdSO9Q9wT+bgMuZX1NCmSscrsUhBNRUY3mg5H9mAMOYyfB8CGRrq?=
 =?us-ascii?Q?h4XdlfMTw9jXPjJY81ADIHIedhhnmTo5kwhA4iQegtmDQnXcppGsU2QSfLeE?=
 =?us-ascii?Q?KdnxECM595gxRcaPFUtwDxF5QI8lOMJaMlMRCAQYPo7bCRuSPQFLMwXAsWui?=
 =?us-ascii?Q?DnSO/XN2Mfp7GGA6Z9Exv9rKWr5Q8HeSra4aXZMvEg1FKP3bY4vHmchJD2Mv?=
 =?us-ascii?Q?kmQ8S7zl8Mj4ce4iRlnfXxRacmTkWIkuSxp5eM+smDeBO2seRVPN68QHVo5G?=
 =?us-ascii?Q?zm0hHCnJyjSaclZ8E2GZR6dgWIY9Bvyz2rnnYPR20QEDI1/MDZUOR82WkBzl?=
 =?us-ascii?Q?cgrJ2VQv0EKzEsBu7DXcvzbuh2cgITDgHYg/Vp0/1KwOjonEGlqYDzyB2Zmn?=
 =?us-ascii?Q?5p15QqtmNUS9aZwXPvj1Y8vjsgc3fpJbbdOHIEa8sZU5vpc0i+5gbZZtq+OE?=
 =?us-ascii?Q?M3KhdbSbu3nHXS5535WrauHLGLXU1l+N/WMbsVhc81KMhQPTPTDggMdimtDN?=
 =?us-ascii?Q?qGj48gQE0FPlfkQpRvTutYqif1tDVT1Yi/z4B5a8+bMDiJi7Ir2PzHT8B/tT?=
 =?us-ascii?Q?W3irKuUup4lDmG1LaryrJZfscYpmSifw1TCaFf9KnIra4PelqnyKMdxszCak?=
 =?us-ascii?Q?pzOGoUViK79HjgzahH7q7qefmM+2HjlYcv2zUdKhCuzuOPTFKqWQ2U+upCMe?=
 =?us-ascii?Q?7XMFuhpkNrcAeKQqDOBtnkj9VcgKh0c8X/fba9gz8UCWGmXVtwW6AkFENI5z?=
 =?us-ascii?Q?33cTspvEeShetpgwjckMgEPQ1phXS+ZS1OKkmimHWdqDQzKBKP0298HtV2ds?=
 =?us-ascii?Q?F9xNYiWcPOTNCvcEt7+icA+4OYCz+OXkdwloAlfNq3QnA6G15uel+3gPor0q?=
 =?us-ascii?Q?r+ly1CAWAGaa1TXLzmjFbHEj3MQC11VdUmE4HAMqrl6pXuR1F2c3yRS6ogPj?=
 =?us-ascii?Q?DbwvnBQ4j2QhcM6Is/jKETsHT781fZ12yGpAREwKJUv+mMrG6g1dOfSkBWLQ?=
 =?us-ascii?Q?RjHir8y0d99ECy1/ETyEk7VipscPtVLkz1U2GVliAcrkCCFNdWrk3EmuRamT?=
 =?us-ascii?Q?1sk4Ff3amnFXvlrap6NGotuC4fsADhmThWLVgutWNKPLteOeUM2/EftR+C/R?=
 =?us-ascii?Q?1bptkAKOZd4PoBDVGI1RzCxEjS41jgQEQRMjVX2KttPWWZvjmjlpSShC/pax?=
 =?us-ascii?Q?qxvZ+L7h6LF01uaJ+kAsjnU2MIqgoErP86jkb2nFpM190lkM7pwGxDlmMmYL?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7QwzFyzE2xNDVegNMRbJo69JABkvU5hrg5zyMnl4Drcfoq1FCr5l6dKgrG6Prj6kBUlL7YMKOxA4oOWrPpPGAtuBgOpT4JCw1UB999R7r/7vh59Q9bJQ7JZn+jHPpmOmqpZN6e5AL7aX5Zaemw7FICRdNPer9XWGuztNfTItsuz3murKlo/JI1oXMzjDDtR2JQe/ryVzB4H8S9jIBGBA/BTbcG8B88QWJ0A2l5+iczsul+hnytP1IZHkVALh8ElUIfIuutkHmI1JTyW3l1zB1Tgp3kgbolgzhKmKiQ1yPAJyZsdUN06NYGSHy8gyrkbRRU+eDaZdkXfA2BohJJYq0LfTz7D9TXVJOloxMoenYRGKGMw4nGUqb+odWkYpSMpJFFrGXxEBlUrdKQvGvx04kaUfVy/w8BvhLIhRgONqDpQGakudK8VNgc19s+iTR8TKUqQ4X9N3WnK4c1GbuJ0KqoiwEqcDjGmuqfqSdEA3oqirSNfB4sJoV4lbNFnbVRGrXz3bFVY7yHGZptxyMI8SP6XweOsnhMTTODdsyaomaDh5EB+52qPW1f/NaBMMGp51GkKcOhZQ3bnsItuLQVgJYs0TiKbfBbBJOMh0YYIf5gg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03830eea-3802-4d68-7300-08ddb88d1523
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:50:24.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSrdbMztLsjmJHMhvP3lFyku1pg6ggQ8mH0N3HNEypVjsmpPJTWjj/y5O5AX4w+J0e71aNfNybFFMsgdkhHIhCKi2xcRbR3sJSpV0oqNZbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010065
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NSBTYWx0ZWRfXxHTQpLEUSjVK XHgl8D9krLJigD9PIm53HM0Kf1wJrwJaXBIStVsq0Bosj0z5a6pyk+D8rJhSPXnRw+xc0ovowtK f35CdvutT5lpPnF6BntxwKRgZQizuvvMo9C7tj/5dYe6YGi2vhj2bxFX/AxD983KO44YfZclQ3D
 q8b9S4kDWJ8edQrs46cryOi5g787NDXn8BmxVk5/gGrWnDPoKf4mvQL3F3Ud86hpYVbzcRuHOrs +XrfJbrU846x3hSDHX/NqjsRsYDHfNJx6PZHknpiYGaq17ssYY2UI+PvEehCsTZDNvrqxTQtuqe plEL6mLMTX4wILWQE/POGgpUcUzlGUFON/9ZgFozYGFp1L8a0YHlLxoX2eLvguX60vr4vHA6HeW
 QN4mpgLPBUkRGgTSzLAPCDZRsJ1K088egZh76e2sslO7S/yOOWBzHkblOVIdHWhvn3fPJxUb
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6863bd74 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=NmMTF4fJywJNwu3Ep9UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: N5XiG8v2JlSWNMZWmNyMezC3kUiacKIS
X-Proofpoint-GUID: N5XiG8v2JlSWNMZWmNyMezC3kUiacKIS

On Mon, Jun 30, 2025 at 02:59:56PM +0200, David Hildenbrand wrote:
> As __ClearPageMovable() is gone that would have only made
> PageMovable()==false but still __PageMovable()==true, now
> PageMovable() == __PageMovable().

I think this could be rephrased to be clearer, something like:

	Previously, if __ClearPageMovable() were invoked on a page, this would
	cause __PageMovable() to return false, but due to the continued
	existance of page movable ops, PageMovable() would have returned true.

	With __ClearPageMovable() gone, the two are exactly equivalent.

>
> So we can replace PageMovable() checks by __PageMovable(). In fact,
> __PageMovable() cannot change until a page is freed, so we can turn
> some PageMovable() into sanity checks for __PageMovable().

Deferring the clear does seem to simplify things!

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/migrate.h |  2 --
>  mm/compaction.c         | 15 ---------------
>  mm/migrate.c            | 18 ++++++++++--------
>  3 files changed, 10 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 6eeda8eb1e0d8..25659a685e2aa 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -104,10 +104,8 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>  #endif /* CONFIG_MIGRATION */
>
>  #ifdef CONFIG_COMPACTION
> -bool PageMovable(struct page *page);
>  void __SetPageMovable(struct page *page, const struct movable_operations *ops);
>  #else
> -static inline bool PageMovable(struct page *page) { return false; }
>  static inline void __SetPageMovable(struct page *page,
>  		const struct movable_operations *ops)
>  {
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 889ec696ba96a..5c37373017014 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -114,21 +114,6 @@ static unsigned long release_free_list(struct list_head *freepages)
>  }
>
>  #ifdef CONFIG_COMPACTION
> -bool PageMovable(struct page *page)
> -{
> -	const struct movable_operations *mops;
> -
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	if (!__PageMovable(page))
> -		return false;
> -
> -	mops = page_movable_ops(page);
> -	if (mops)
> -		return true;
> -
> -	return false;
> -}
> -
>  void __SetPageMovable(struct page *page, const struct movable_operations *mops)
>  {
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 22c115710d0e2..040484230aebc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -87,9 +87,12 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>  		goto out;
>
>  	/*
> -	 * Check movable flag before taking the page lock because
> +	 * Check for movable_ops pages before taking the page lock because
>  	 * we use non-atomic bitops on newly allocated page flags so
>  	 * unconditionally grabbing the lock ruins page's owner side.
> +	 *
> +	 * Note that once a page has movable_ops, it will stay that way
> +	 * until the page was freed.
>  	 */
>  	if (unlikely(!__PageMovable(page)))
>  		goto out_putfolio;
> @@ -108,7 +111,8 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>  	if (unlikely(!folio_trylock(folio)))
>  		goto out_putfolio;
>
> -	if (!PageMovable(page) || PageIsolated(page))
> +	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
> +	if (PageIsolated(page))
>  		goto out_no_isolated;
>
>  	mops = page_movable_ops(page);
> @@ -149,11 +153,10 @@ static void putback_movable_ops_page(struct page *page)
>  	 */
>  	struct folio *folio = page_folio(page);
>
> +	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
>  	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
>  	folio_lock(folio);
> -	/* If the page was released by it's owner, there is nothing to do. */
> -	if (PageMovable(page))
> -		page_movable_ops(page)->putback_page(page);
> +	page_movable_ops(page)->putback_page(page);
>  	ClearPageIsolated(page);
>  	folio_unlock(folio);
>  	folio_put(folio);
> @@ -189,10 +192,9 @@ static int migrate_movable_ops_page(struct page *dst, struct page *src,
>  {
>  	int rc = MIGRATEPAGE_SUCCESS;
>
> +	VM_WARN_ON_ONCE_PAGE(!__PageMovable(src), src);
>  	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
> -	/* If the page was released by it's owner, there is nothing to do. */
> -	if (PageMovable(src))
> -		rc = page_movable_ops(src)->migrate_page(dst, src, mode);
> +	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
>  	if (rc == MIGRATEPAGE_SUCCESS)
>  		ClearPageIsolated(src);
>  	return rc;
> --
> 2.49.0
>

