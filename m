Return-Path: <linux-fsdevel+bounces-52625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17B5AE4927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E13188D3B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67A279DB3;
	Mon, 23 Jun 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mYBVpqGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAA54758;
	Mon, 23 Jun 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693336; cv=fail; b=lrxlstNxSsSZ9nzNFCFimSKlHsmKI+YSbCJIuW2yHnyALo+F8vKEiqqssirIXUqCG+ksURziKulZIP8bvRFWpZmVpA9FFpUEJ32X7h3VOF9wq6cnL0hiXRLYD6LFJRCseDjKUhuwDpyFDzuJcM9FeCDfcysxXaHbgwG4sIGmOgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693336; c=relaxed/simple;
	bh=0xB8xwJXNbPKfd8c2A6UpOnu/bDvdU6kVinLwzhG4yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rF4MUZswddUkOygSwh4fgLYCZTXtTE4Yhyn/rUsv9z2NN3tdmknDKHX2AzG3pKlfu3B307vOW+/Du/Dn8VnRkMHs/vzxb37aZnYUW+8erh9skjqS7UehZKEZhGSG1YkUjRwjJBcoSxpl174tCMVM17hyAInPj7CgqmGRtSgEqqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mYBVpqGM; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNHaUhkvHKurRP71Ie9XQjar2c2gVmXHnlESvsNTFPeT1F7dQIlpotDslqlTAw0g+Ex0WLq1Z+g8VP4sqjPbBolmre8agtwWABQD6LZQ4C0rJW0u8JwMmhm36IWbbvzjf7mIJ6SrPPic4UszK6fo2VtPqJV/qnJ65K51B0mm49ojIDriUcN+2eH67AmYVHJ5D/A4Kj+sZhFi6XOr1aP3zb10ItiLF5F+HUpNUrAS5TV3mAh2vXGydzyNLMBLVTUa+FYpJBaQhLKRX8tsfQScEK/vU45y+Y2nFdd7vLcBEnAJbV1syto9MXoPRcCHofEpZdsA0Y4hpywwFlIou5k+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xB8xwJXNbPKfd8c2A6UpOnu/bDvdU6kVinLwzhG4yM=;
 b=KA7yADePPhuLrPTU33IkJo88SUj1FzS3kjQh/3HIAloGu2pwUUni56jiRK2Tc4bMhukr6zjYryW1J67jP2pLO2/k5Ko7a5cDEQ89iZi1coouBXnIU7tBxXh+CMIY57wA+IqVlmKjvYLBgrtgo1TVQKrdZV7GIGfSYqmW2S8G1Zlmo0msGH7WUy0QvIo9oeAFuo+K3W+gwf0/DORHa88veczLYoAH718IQaDDZ1P0CSdYrwg6dEQHkkc0F3Uu8VrKf6KuO7ejV61+VmSwnhWsgwM15fjZzRgwu/ERZ6sHz5LQtMRutGST2qxXwlas3ZxRMfcEIOcTXKQxkcxO1G+2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xB8xwJXNbPKfd8c2A6UpOnu/bDvdU6kVinLwzhG4yM=;
 b=mYBVpqGMBuusjHxELShTg7szaOE4cP3hG7W8bXF5bV3z0H94fymBmpuCAS2heO9up7j6PQlcepOExlcEPY03Bpu/AqW7e5YYnVbM7VIgAWS2OM+FEav+3KxYL/9N72FusbAX0kBjjF49TebGHSYN8ITBwPlFg9C6xSfcGTffCmsYLWhpc4QctwjmZSXSoI17NSZzS9lxrgaoQ1ann7fqocwxexeYoU+vqBO5qJAGlah1wIL4dB9HBEhlbo2SgQKOMvztImw0MGpJ08C07eJJAcp3iVb0X0GfQIPJvjZI8d+rTmuSdWOPyzTh9Rm9XXDLnuU0p256usq2HHfLIm44SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 15:42:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 15:42:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
Date: Mon, 23 Jun 2025 11:42:06 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <8FE2EDF1-DF20-4DC4-A179-83E598508748@nvidia.com>
In-Reply-To: <bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com>
 <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
 <aFMH0TmoPylhkSjZ@casper.infradead.org>
 <4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
 <bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d2a679-eeb3-4e83-1d15-08ddb26c84e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gztkjYBmY0mjCYYuZl0MwaFJ4sUvbg1C1cd5dxLnRTyJxq/Pg0izTJL0QfPV?=
 =?us-ascii?Q?xaonYBzE5eftSGGrgPFUzmH8TrMJdLXQb2mu8xUvCVAZ6Kl7gEM3dyPeMDoM?=
 =?us-ascii?Q?bkpO+UCc5at7l6yn9lDzIJICvEMO9b+5BYy9dihCsnfr2RC25Cgi62ALpE9I?=
 =?us-ascii?Q?NjtrOKRZwOcEiaihRPafAV1eN4zWGczU6NbtY6R+i/gVM+iObmIeniPeAZy1?=
 =?us-ascii?Q?FGE+QL0TqUI6PNQyeisTTKcOAAk1wEvqJhWrXnoNfVQf3jgkN3MWf4xcffCx?=
 =?us-ascii?Q?uZx/988Wi5+gnI5tBhitmSQKgVoQoWGpBGvPjO/m0U3u/Q2BYFIYM1pClUpd?=
 =?us-ascii?Q?ESqGeevuDyw1EE1QU8w24+v+sdhekJTW9MPHEqkJZbagEzRURD/I3HRqMUoO?=
 =?us-ascii?Q?Ous44zf8e5p0V3hKvSX1xjIOfrTVBfVyhki7GsOQDo5SwQWOA6bxLPnVcMDs?=
 =?us-ascii?Q?9gpY0rrgNx3nj30XKkkLzdm/7PaowDtOCUr0JVbqYLohECHt35h3G3D+MQms?=
 =?us-ascii?Q?syIhdf8o3UHdMiyMwaftJgCKBlheXHGsiT+HQVn+4cSNnVv4hGKJbxZ92Q5N?=
 =?us-ascii?Q?sZv/OLd2fxafJdkdmKB1fBBZHRSgkNHXJ6JIkpJTNDw1MZTEwgw++hAwcHt/?=
 =?us-ascii?Q?00ilNqaHIa+U133Do/a29AimXbJqY18RiOyyy7hqnNPszrtrrB4aPrFjasxi?=
 =?us-ascii?Q?FYMaBcPUMRdspPYmf7N9lJDrhcf3Pn1vcuL9q8yzFOyx8rMH5zkS+lMVCdsJ?=
 =?us-ascii?Q?Sp7iK3IJd4kycyc783gMBcBSgDcYGy2MiV8J486itmnxX6vK3O2Z2uCd5QHA?=
 =?us-ascii?Q?WCrzE1Uju9ZSil6hEUqjtaOKgbXDUl5fwusUBgZaSsMWAcqMwi3r52MV2c33?=
 =?us-ascii?Q?oMSeh55YAi3HsTcselQoQ2eFFAPwUk1dAZ7v+S7zWr0feBZzD/HXlc0sXRpE?=
 =?us-ascii?Q?QBj2RFI0fL0e0XWjv4hkqNgnHyLWizqCcIpyKOXjWZQ9xg7R1GYtP2aKSEfB?=
 =?us-ascii?Q?yll3S5lNzhtIgRbpN8FyLTQlnN6AVuywrQ++jcCdOGZjANF+AP0Kp3olxVwH?=
 =?us-ascii?Q?GzBMytq2Vn7kQXY2/32rq6170lLgNOp2u1OCS93g6bdi39ewJKvjWsZHETB7?=
 =?us-ascii?Q?qOgv2Sq0rJ6oVwaMw+MHUldy02Q87wxA9s7MG4cBFzvGx5mvfiVHG/SIaWj5?=
 =?us-ascii?Q?+ZUSx3HJ54m/lbSCHsqOT/l4pp5JdoeLcACoTOy540zNaWtNCHdRnfw6/TdO?=
 =?us-ascii?Q?P2p/6bPF90nLqtabKNrTQ/+O4tfowRrIEJSHv0LlhggrxPcS5goAXjvkPMh0?=
 =?us-ascii?Q?SWCfyuAyXIcHlmA6WnQvSmy9UxWmk/k5LqhjNSxg81YCuvz7XEEdNCISHkHw?=
 =?us-ascii?Q?jkv9/Ts6cB2+ZpSF45WdAhR1o5fF7nrbvHPo5PV00h+2vK3yCQiCZKXBEaQS?=
 =?us-ascii?Q?jxzvvBXEZYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jyzqmRxMfUlRqvTgEViASMGzKJdEl47LLHynvBnHKlfGimWImFuq9nfYytYq?=
 =?us-ascii?Q?WftoXSsupKVUYit6QoC4rd4ilVhEnE/uXYtul2ehJs9jRstiBUMflMuB6M7u?=
 =?us-ascii?Q?78HZ56KhkrR+5WVcGAmMbDQFPqlpSv+GcVMzUL231/XI/3ZH9tPeo5ZO/G/W?=
 =?us-ascii?Q?lGs9sWds8d8o8duIkMDY4tFp3Oe5hNqh94cLELcCauSvLIjJ5AMab+7Xm3ue?=
 =?us-ascii?Q?kY/JOyxc9TNWdEqrqaAup2KPxCje7kaXmBN1TGMpaMuSBb9UaQ8qvJ2Ud2Ig?=
 =?us-ascii?Q?HpGJKo210D257vr6TovBHbr0MLq8ZvLP/RCYLUCjaJnXAwiRoqGAoKiT5fwq?=
 =?us-ascii?Q?VuT/mVedEzPEArAFok6kGVIcXBI2++Brw8DyCIBIkQNaZDWpfEFXRn+mic2R?=
 =?us-ascii?Q?2wkOC2u171Prb0796qEVrCgGCYWmswRVqMtOLHvFPxHkjGnSBrArQTXFBymH?=
 =?us-ascii?Q?K/li6jFyisao/706B0Sx15+Gdz3NmSMSPRQCw5uJUibCnWE0bo1F+AKfo7CU?=
 =?us-ascii?Q?1SvppB+IO8uVhOdHCPgktBc5DQ0hUdGoFZSp939I/p9IMw4X0DhhMLtP1DAO?=
 =?us-ascii?Q?SevX1NdGW8TINGZ9yJ8tFxfbl4gaCJsQufFBD2fHoI7yi+hfAgqdywW34SQ2?=
 =?us-ascii?Q?WWevO3NhcvFegIGNg7kTLchAsyMpWOfv0LyZYEZZ6PhxctONKRR8Pg4GdCd2?=
 =?us-ascii?Q?8zdsjXixzGmrdQSD1FhI9Bp3vKwwQVIUTab80fn84Zv7Y5VlutUFTs+yGFAD?=
 =?us-ascii?Q?h2yE6z5qL2ycBUaExY5E7l3kuWIFE7O0lYmrtlYNbJ/eSho6Raw+c6yTLnhr?=
 =?us-ascii?Q?QIXaT7nCv2HtzPzbIXTSb6oDxkDC0BrtY7QT83EtskeRZOgEcZdFmouDrrgd?=
 =?us-ascii?Q?5s2RyrYfx5pX/qHUF3Wqn9pzC6kPevAWNM8X2Mc10zaS1TaF3vlxdtDKnMTB?=
 =?us-ascii?Q?cfHhb78r0Xk3Jj9nuBY4isFRHXMjNvLrIuI2XsUz7TLEWBcpe/xLwi0wVrsd?=
 =?us-ascii?Q?wnrQiZQRUv1TzS9dTb2yXffB2aV29VksbIBT+v9tFKke9jWo8NXCXhmtFrPC?=
 =?us-ascii?Q?bGkYbcjFpWMoB9X2a6wD+WYL2I+C1OuQQtl1hWrGmS4rf3EgbNlEFdH36AbH?=
 =?us-ascii?Q?CIc/YyZaSBS0/prsgPUEUm9Q829y9gSrf85zXQUonJWrJQKWM8j2yk6FdQwd?=
 =?us-ascii?Q?olJYR5OfPbCaMvSawkBHm4zfcVpwLKZxCX/+IM0wTvoG0T1xfWf8OJodzLtS?=
 =?us-ascii?Q?2XwnJlXq1LJoypHTqyQ3Qc29poj3u7zEIZZTJwOZKcu2VUzryFPySYPMx9r5?=
 =?us-ascii?Q?3483k9QjMhWMzoA1Z1/9GjH/VfcSKhJQE5lyC944QeXp5wflCywa/MOOuY0B?=
 =?us-ascii?Q?EfLJGVqFSX/nEqEDUACivprtMIP969lcV0GVHuwOQiF1THHrY180t4SNe5VR?=
 =?us-ascii?Q?j6IWW1Lerf0VozxIcX0DC1P5l5FjC7Z10frDtPiz42F9rwUGFJ8fpUyGJ8jb?=
 =?us-ascii?Q?6i4BQcijyNqMyH6SsjPPNCwZOZtrA8tyVUA9dmti+86vYuNXBR7It5PLFoKc?=
 =?us-ascii?Q?msGgqPewmZHgTgbMitM89YKzjs9f6jx4aZMWG9lV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d2a679-eeb3-4e83-1d15-08ddb26c84e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:42:11.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxpB/HcmwTzZl/oUJeqUQfAAYa4KRO44FknvTJwf99qwP3ZXevnSuKiHovdht6XA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

On 23 Jun 2025, at 11:33, David Hildenbrand wrote:

> On 18.06.25 20:48, Zi Yan wrote:
>> On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:
>>
>>> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
>>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>>>
>>>>> ... and start moving back to per-page things that will absolutely n=
ot be
>>>>> folio things in the future. Add documentation and a comment that th=
e
>>>>> remaining folio stuff (lock, refcount) will have to be reworked as =
well.
>>>>>
>>>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and hand=
le
>>>>> it gracefully (relevant with further changes), and convert a
>>>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>>>
>>>> The reason is that there is no upstream code, which use movable_ops =
for
>>>> folios? Is there any fundamental reason preventing movable_ops from
>>>> being used on folios?
>>>
>>> folios either belong to a filesystem or they are anonymous memory, an=
d
>>> so either the filesystem knows how to migrate them (through its a_ops=
)
>>> or the migration code knows how to handle anon folios directly.
>
> Right, migration of folios will be handled by migration core.
>
>>
>> for device private pages, to support migrating >0 order anon or fs fol=
ios
>> to device, how should we represent them for devices? if you think foli=
o is
>> only for anon and fs.
>
> I assume they are proper folios, so yes. Just like they are handled tod=
ay (-> folios)
>
> I was asking a related question at LSF/MM in Alistair's session: are we=
 sure these things will be folios even before they are assigned to a file=
system? I recall the answer was "yes".
>
> So we don't (and will not) support movable_ops for folios.

Got it. (I was abusing it to help develop alloc_contig_range() at pageblo=
ck
granularity, since it was easy to write a driver to allocate a compound p=
age
at a specific PFN and claim the page is movable, then do page online/offl=
ine
the range containing the PFNs. :) )

For the patch, Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

