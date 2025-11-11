Return-Path: <linux-fsdevel+bounces-67972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE645C4F085
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 17:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FB3C4EA0EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D736CDF7;
	Tue, 11 Nov 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6R1kLMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A036C58E;
	Tue, 11 Nov 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878375; cv=fail; b=WrEgyi6HRuYmFibV9EmHoY8gBKri9hyDF71zYlILziDDpEwajdsDBcq4pQm2LVgHvh6+6hECEKAN36WQfa3DvHeNl2T22xwyyvBlAw8p+blu0LGcVpAUoGMG5c1aoqB0xJ9NWS4d+ziTke1340RsbBBrBIzfR9x7ZhilXukku8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878375; c=relaxed/simple;
	bh=W2tNseVPXmnmEo0BzCxeDJEeHQUplMk5p693FOZvqxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxDyC7keEdmFD1IqdaZ06PIQcifaPhXnFySbRUOprEsUeLOAy/PrDMYrP6ufmOZZa8NS8m6COFzv6D6DmH1URptnquCpvXQaCyOYHPfqhNWjdm7GeFYOadLhTi0JSGvdcVY9/LLQQB2yNO9dmcg2/0Zw6is+jlAEAQhTLYFZbqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B6R1kLMN; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taa1HD3XOifJrqcnZ/1tu1+1KOTLTwhHCXqFFBEZJ06Py5V9XUSMUKDTmWCdcSwhxdHMe5cB6pWgp/0tN6RFZWQcdamLm4RHnHZVJIjBcijxNqueRgMwUZeH5KjFDbxH6Ps/+oTV3zhqlmaMWJVxRMyR6MNdzRDh1ZkLg99QcUea2un7K/e1z7fChBtVnRW2na7MDlAAx1a0s1cGzeEgTdMFNE4bJ1cRErmU9U7LOrB52N+Xz/O6pQ/0C5r4kWgiTbq3EOk6h4sX8z5alfRx8bUVdLHy21unmp3/ZItY5LpH0zPQjZDPO8RlergJ1NSc367zvVPa41ETwpIWF6iabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2tNseVPXmnmEo0BzCxeDJEeHQUplMk5p693FOZvqxE=;
 b=HWQs1yPR1o3vvIOm6Ki0joJGXBO2kKbjaU4T/OmeAhape3r7MZfFRsZmUfS24cz8OE5O/f3dTrj3D4/qHJCazWtGhi47KcwLanhF3WyMIrwnvHMXTLZSRQf0Jla/A+8xGswgcQWkQbQ0qweFq4W2+q0JlSmVWjoL5EskzY58YC2H+YbyiE/44ZHb7zcMeso7behoaBKOS2rtR4A92b3W3NhLMYeCB9ifww5oYnQM9pipscWRcBI0bz8jOiiF3xF6DiEk0+42eMuRVAMixxDhtBk8AsbrNUuthw8OIljNi9oWfM+VfS0FjoAMif+Rpnq/1NEvHjZKrINApz35g6/Ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2tNseVPXmnmEo0BzCxeDJEeHQUplMk5p693FOZvqxE=;
 b=B6R1kLMN6409ZLvdfse/8Cnqz1fTLNrZydczW7LPspRXTvGRGHbFcfLYkaSzyWqerEuEUeHygW6g3ywUtTJp2UNkiNNk0e4P9g+Tg4nyRuglu7nbOAnJPKa12BA/QiiM7idpiZFkpXKAk/haBW82Buc/N1AVL6KYs1gankXPVXPSG0SMbqeKpoRKbUtHpc5vPdX/Y32ywDOh3oqjWyyPjSp6ynkv5+Ex2iRI/JHYrdxiYr9sEYQtb2hyTpD52b15D/2Uk4Q9XsfGAxKoG08YuS2fLaxwSIXhD2AF29lOtId+cjXquzGaYpnVMUEW5QpytEXWCqeoUCSjbjTCgPGFiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 16:26:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 16:26:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Date: Tue, 11 Nov 2025 11:26:03 -0500
X-Mailer: MailMate (2.0r6283)
Message-ID: <B02ECB62-606A-471A-8139-81327D2F6B5A@nvidia.com>
In-Reply-To: <6c7c5f86-a9d5-4b7e-aa08-968077f66ace@kernel.org>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
 <CBBF1711-5881-4B5A-ADE6-1D86C0E94296@nvidia.com>
 <6c7c5f86-a9d5-4b7e-aa08-968077f66ace@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:208:234::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d8b9d7-0de8-4be0-d383-08de213f05bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0Nhc3BQaURCLzFoOFdLeE5kWlJXcEJweStVYnc2RVBUaHNydW1ya1JnQUwy?=
 =?utf-8?B?NEMvL1FYK2IrOHBYU09kQmVMNFVpMVBkaW1CeXMyTXIrRzhlOU1sb01Qbi9h?=
 =?utf-8?B?bFJ5NklISkFXWWpoT2lUR2dzcFY3d1JtWit4cnBLS1FWaVB2L2JSb2dMd0Nz?=
 =?utf-8?B?WS95WFJBZS82Q0drMnhlbmdqQzNGaEFDSldIRjY1MmJzMFR6amtDR2wycG5R?=
 =?utf-8?B?Y01VdmZrcTl4OUNBQjVMazFYVThhTXFOa2JLUTltcE5UTTl4Q1lseEpxUHRs?=
 =?utf-8?B?S0oycGhhaFlmZ3ErZVhxZjE2UThEUDhSUjZvTnVqT0QvbG5vVEZWRTdvTk1G?=
 =?utf-8?B?TWs2cjNDZFVmalNYTFVNdTl5bTBTMzRGa04xZUx6ZkZvTGlndXQxVFRrU1kx?=
 =?utf-8?B?dEdLZm1uMUFHamQ5QkZ0cWVmVHkyeWVxNmRCb3RhdktyZnQvZjg5YXQ4c3BW?=
 =?utf-8?B?QkJyakswVWhLRXA0UEEvOTFFbDlCMEtNNmp4Zk9JY0RvdG5OQW9BN1IwcGl2?=
 =?utf-8?B?NUh0Tlk2Z3hFRHY2emlIclhVRUI1cG5QdHFrWTFvTXRST09xOHhkQnhvQmY2?=
 =?utf-8?B?aTZWWUlEeHZJc2ozNFlWNmpOckZ1UWViSytxaFlEQnRKbTFnWmwvUXhTRFNJ?=
 =?utf-8?B?Tm13c2JMdERKMUpkTjBTNVJpdzdrd1RiQzBLbFhUQlpJaWg4WkdhRXZBWWw0?=
 =?utf-8?B?S05XZHNVTHlBajV0ODRmR2pQOEhjcnZkdUU5Rmx2SGcvZXI3QXY1TGUvRFd4?=
 =?utf-8?B?N1I0Q1dXd05JdURiR2QxLzRuU1dxdjAwVVFNbGs1b3R4MktTcWlFVDlGc1hs?=
 =?utf-8?B?NHNIN1hUV1J0RGE0Wll6dld3SEJDRlhOQXNpL0RpbjhRZTgxMktSNnlrenZk?=
 =?utf-8?B?WUl5ZWVJdmxWTDZNQWtBRzA2NDVPd0hTRDZLcE1aV1ZsRUl2WDNlYVd3Q1g0?=
 =?utf-8?B?ODNzNmJRRmo3Wmt4RU5TUWZ3UnBOdHJQZk96VmNGcFpnNEpqaThzaDY4SVho?=
 =?utf-8?B?eUZObGp2YnlpbldEa0xwUW1NaVBMUnl5Y3lMd3lUSitDZ3FQZDNJVmtoREZJ?=
 =?utf-8?B?a0laSFhvdHVRa3hNSGhJaG1JMWFNaktya3h4OGhFUVhvUWkrUmtPdnplbUcv?=
 =?utf-8?B?ZlcwMlNPZzUzZ2pSQStFWFE5L2JRVjFhbW9oTXNjTmNmZWo0and3blFwTnFa?=
 =?utf-8?B?WU00ZkJPUUVjNHRwZmpua2lwVmVhdDRRaUlYNjErVzJDNkN6QVk4ekE2aVJV?=
 =?utf-8?B?TzRNK3FHWlMvblB5UFkxaGVLWDB4bjZySGl6VnZyWU81TGg1YjBGQVJ4UTgv?=
 =?utf-8?B?YkxWdm54dDBBTTluNDZMaFlyZktncDlwWHhOZGFSZ095bzh0Q0xsSmpsM3dW?=
 =?utf-8?B?L0pBbDNWdXFGc05BTGVwT1R3M214V2tuY0xHVDVTc1NzSElMYk80UVhRdXht?=
 =?utf-8?B?K0dkRVdmQnQyNGFIb0toeUZwb1h0OGRaVURGVkxpYzlLUjlSeVZpMFdRVVdR?=
 =?utf-8?B?MDNJeUp2QlU4Q1RvV2YzVDRqOXBQdFhNSW5oeHZQNkM4c0tGSlRGV0FqcGhD?=
 =?utf-8?B?enJ0c0R5MHJOSjkrUFoxS3NiUWN4V2xuK1ZNblpMSEZjRWN0RGt1S1p0QVE4?=
 =?utf-8?B?KzJXM0txbi8xdytEWDNZTkxSVWQ0OThQM3dpRlVkMTJGM3cyUEVNK09COG5B?=
 =?utf-8?B?Y0ljbHVabWduQjNLQm5pZGJDSjl4ZjQ5VUphWHlzaXdCRVZqQXhqc1pWS0px?=
 =?utf-8?B?UnVCMDhSRUFZOXVxc1E4R2w0djRXR2psU1pTZW9RNTlGMDlwSUZMMTVzc2h6?=
 =?utf-8?B?c2hYSEdTMVlWRExwRGx2b1VpLytZT01iQkNKTzlvSVlGMXkyY2NHcThua3FT?=
 =?utf-8?B?ZVJJRi9qM2pqdkJrLyt0NmcwQVZmaUpSQkd1Tk1wQzBncDk1S3NnNXE0am1w?=
 =?utf-8?Q?/pkq9bcLoUCwVRuSYI5cqZXYsnieMhLq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TENYeTA5WWtQSnIyb1FESnlnVCtjTzVENlhKVzNpb1V5QkxoakVFNkJhcFYw?=
 =?utf-8?B?SitmQlFJbU1Fb3c0dEk1bkVQdStFQ1FIUGpEbEVicTBRdVpoUlJ4SXlQUTI0?=
 =?utf-8?B?dDkwQ2lyRUsybUpSN0psaytsZS9LZG5UVFYyTTQ0TUlRdys5UGZzRUZTSExx?=
 =?utf-8?B?YUpwRklnbFdMQS9wQkRlMU9wR2QvL3NiNitycWNkeUZGL3EzcytxRHAxWDZD?=
 =?utf-8?B?dWdRK0ppbW9ZbnhxVldNQmo3Sis5TEJpeVBwS3loWVU0VjZZZXJjL3V4eWw3?=
 =?utf-8?B?MWNGRldsRXhFMWF6L3pQeXgzVmhzeWdxWTZ5UVl3LzV0Z3ExWXBiYnVMc0JI?=
 =?utf-8?B?SktqbHk3ZC9oZ3NLc01uNTExUmVKMitSS29ZVWwrNHo3RkQ2ZC84VGRxaXhQ?=
 =?utf-8?B?ZEFDZDlqUDkvTzl1YXU5YTJqUStvNkVYY3g4MFVZcFZhZkpJeUZ6N0NaQWlD?=
 =?utf-8?B?VVFCWHZBaXFVWTJodDZkQzYzWEVYdFQyVDB4K3A0byt2NUJUTzhFTlByS1I1?=
 =?utf-8?B?RnFOczV4SStRYUNhVnEwTXJzbDVzSmV6MkJzWFZ1VGN2TUZuOUViQ29lUS9P?=
 =?utf-8?B?MlZRTnliUjc5dGF4WENpOVd0L1V5RzBJWnF1MmtwaFg4K1k3TTBkcHcxdU5a?=
 =?utf-8?B?UGxsWDhRbnBuUEtOU1hDWDNxWkZVSGYvTjI2d0EzQ20xRm5hbWc2ZFA0YmlR?=
 =?utf-8?B?czlYZStBd0RUbHlWYzJYWGRPcFJSUUlmcVZxNTcvSXB1MjZ1Wnl0K1B0ZXVK?=
 =?utf-8?B?dThtbXpKeFRuVWhNU3NsR0QrcTNnU2FmVmJWeWpleUtnNlhselJoaEVnMWZT?=
 =?utf-8?B?TnNSTU9IK1FaU3BqdjI2YnQrUVVXZmx2VFhSY0xrajhuMjBWSmFFZHZVSTlJ?=
 =?utf-8?B?bDB2K3NlUkV5bENMZ1FEUGxDUlZBZHBCZ3ZVei9kM1JNcEtJTmtFbUVJaHJq?=
 =?utf-8?B?dWFsZ08wOGJaNDhEaVR6d1VDd01CSXFjOGtEL1pCd2tMOU9Ddis1Y1YycGN1?=
 =?utf-8?B?cFZBOTI4Zmo4TDlqNHNSMlBxV21KYmJwdVhXbEMxejNFa2N0RWZQRmh2YVR3?=
 =?utf-8?B?eXRobzk4QnV6SGQ1U1U5aWlZK3p5VEJSeVRmR2dNWklLZENKOGREa0pRRk5P?=
 =?utf-8?B?ZHBvbEJTTFF1NmtKbDZQWGpSc3BFVnBkTmx2WUlJVkpXemZCTEljTmFFODJ0?=
 =?utf-8?B?dWVPeEZFMG1JQWgvL1JWbitQK1dKZnNHTWR6NW5DTDU1dUQ3b3lVdEx0VFN2?=
 =?utf-8?B?S1VlNVRPaWNkT3pqTXdZREJuSGRBb1k5RkVqQjRhVlRLMGRyZjJMb0lNemVH?=
 =?utf-8?B?anhtVGQ1ekU3bmhZQUpURzNSZXhNTzdZZ3lmUWx2RTI5S29qNDhvMHMyUVZr?=
 =?utf-8?B?Y1NaZHFIMEs3a1BSWFNZZnBGNUJzaGw4c0N1N293VGUyUnlDek1tajc0SzMv?=
 =?utf-8?B?S1FPK1VmWWp5VnYySUpWMUtzTkZ2emZ3RDNKMmp3L1A5T3JTSXRUTDQyWEZ4?=
 =?utf-8?B?SmUzN0RmdWlGZHpUclVXalg0dVgxSGhTdHNmaFVadEM2aG9WK09wOHR2RGln?=
 =?utf-8?B?dytvZVQ0NXNJTFJ3NUNSekNCUmRPZXRKbnpJOG1KWit1ZDN5MjEwY29scCsx?=
 =?utf-8?B?aldwemxDMTFQYTRLdGpPRE9NUjFVZURySStZNHBrRDJ5Y3VCTEoxbnV0b2RI?=
 =?utf-8?B?YXlsWjdFRHdZeUJ0OGk0WXBrYkNBbkZua1hNWUNuTjlPVXZHZyt3ODc2a1lW?=
 =?utf-8?B?bXhDemR6dldBOFRUYWZJRlRLOVpiT0t6dS9uVjU1aWtsN1kwcWhvMU5SRVVa?=
 =?utf-8?B?UlVjQjFRRUZBZHdsYThOM29JR3dlblZtWmI2RTE2WitId0RBS2EvOFlrZTda?=
 =?utf-8?B?cytQUndWOUwxVENKaTNjZCtBVi9vekdrY0FpdGlHcjhWV0tFOUtlVXNlQ1Za?=
 =?utf-8?B?bXF2Rno1eHdsYWRBRGJERHAraDZYSlBvWTZ0M0dCbThMbjFlWlplMFBJQmc5?=
 =?utf-8?B?UWJoK2tyeUhhek4zWnByMWw0eG1iWW1SbnZ4eFAvQVE4MmhmR2NMVWdOUEtz?=
 =?utf-8?B?UURsUDlKNk84YUNmbVlLcTc0MFZCWGVRVzVFZWpwc2R3aWh6VCs4YVZnd1FU?=
 =?utf-8?Q?cZ6hymm6C6UfVza5mBpLVVqvw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d8b9d7-0de8-4be0-d383-08de213f05bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:26:09.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mK2cbAxMOpuOADCSjEN3HIoMfUXOJh7FPM83s0wo6ERCeRRcI3Cl/dd69usoKLrO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010

On 11 Nov 2025, at 8:06, David Hildenbrand (Red Hat) wrote:

> On 11.11.25 04:25, Zi Yan wrote:
>> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
>>
>>> The kernel maintains leaf page table entries which contain either:
>>>
>>> - Nothing ('none' entries)
>>> - Present entries (that is stuff the hardware can navigate without faul=
t)
>>
>> This is not true for:
>>
>> 1. pXX_protnone(), where _PAGE_PROTNONE flag also means pXX_present() is
>> true, but hardware would still trigger a fault.
>> 2. pmd_present() where _PAGE_PSE also means a present PMD (see the comme=
nt
>> in pmd_present()).
>
> I'll note that pte_present/pmd_present etc is always about "soft-present"=
.
>
> For example, if the hardware does not have a hw-managed access bit, doing=
 a pte_mkyoung() would also clear the hw-valid/hw-present bit because we ha=
ve to catch any next access done by hardware.
>
> [fun fact: some hardware has an invalid bit instead of a valid/present bi=
t :) IIRC s390x falls into that category]
>
> Similar things happen on ordinary PROT_NONE of course (independent of pte=
_protnone).
>
> A better description might be "there is a page/pfn mapped here, but it mi=
ght not be accessible by the CPU right now".
>
> We have device-exclusive/device-private nonswap (before this series) entr=
ies that fall into the same category, unfortunately ("there is something ma=
pped there that is not accessible by the CPU")

I agree. I am fine with the categorization using pte_none(), pte_present(),
and softleaf. It is =E2=80=9Chardware can navigate without fault=E2=80=9D t=
hat causes
confusion. Removing this comment would work for me, since people can look
at the definition of pXX_present() for further clarification.

Best Regards,
Yan, Zi

