Return-Path: <linux-fsdevel+bounces-52595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA3AE46DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06824167C6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF4524BBFD;
	Mon, 23 Jun 2025 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/wl7KDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50B14A0B7;
	Mon, 23 Jun 2025 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688764; cv=fail; b=PbzV7DYRq1Yz7bYfdbxsjZ4A08qtTyxbzgtppapUfLaL28y8FJB47rIsAQjK/q+k+4Q5xQPTKvQ2jgfTqbLcSqATw1x7+TdEoYbNXBIAgYhxpFdOv2BSIiXC9hStapLIp1B58UM0tDsuDFXA/I1RjdjCxUXi6+T3SiNQo8vHEkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688764; c=relaxed/simple;
	bh=R0AOOUAqdX22+o2daU4ZMLHL1mkH+CB4CxrLAljesLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eATCiIn1W9dv0ifj0UfVGTuT43Jh04iuQ/A6vjjWeinpvqtcIDIoEevkbEAvFEFO4vQC8TwiK/OzJRUl4sAS4ar/UephH4ZR3LKMuEkxlO1ENq97FgBBSv9w4NDW130wthblaQhGRDdTH3gQ1XM+JcbC01yLHvPIQldPMp+8S7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/wl7KDa; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gphfujz0DxLyaeXJJpY2cYZ6SfNN5/ayKyzp0UScdO35qYk/eHce4uFxbknZDYEN4BH2ouKKBRuSGQoeQMCEUERWBgpbe0efxlc56i54MAVOnW2qdNWAoS0lR3PhYCLNTAxtHnHPkcmragZ39YhEjkttibjndQWNKtwt+v9vleowhgML5iuETpkCzGoNsqLy6BtHNbyRuo1mMn6Py6jtZUN+roS1Q2GNu5r/bZQXIQtQ9jxkCl28nHUG4Xibarnnngw5hG/+t/kZ1barYaFirl3NcxshRIsV6KRIcpiYHY15twjcYaXrNzMbGx2fn6yP6JV1VsKnI8gmsRcHL/Gmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNfydmNgm+UZ8U84r0LnXvrAzrqc6VWWeKKCGu8t2IA=;
 b=eR78wemRk+V1ipXuYz/XUBIRRdXry7cg2XBiJAoi66dB4madkbftEU2es6z1eFZHA9LDJ+GHoo36u1Yi7G95nvyp9u9U6iQK4GtmyIMxipBpCYZR03j8qyhzwrI2Br6db0KzQkuiSh07s6vMZoDKETn6Hz7dg1aL0nt2Uwdzp2EoPFH7ghO/uewqdq9/IRCY2chSAz/JlJ1E6FvheR1ypCVl4jeNbiBdUYFa5SwZumJyIZE/hUu+LNoqdhl5B0OK95xAj3LpgzrMjUMFrKsL7T4A8o065P2N6robV76zQcKgK3uSOCURqRfWyJPu1v/9Czvr4CApVH6fEi1phfPxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNfydmNgm+UZ8U84r0LnXvrAzrqc6VWWeKKCGu8t2IA=;
 b=O/wl7KDacnPOt5WQdPERbxDswPIuxtF9F390Lkr/oCIk56GdQPAGZjG35BJNaE1tnJ3HqW287XpUtFE7DYyoOzAS6JTa+aQt5s9CYTHudhFOiyw8Z4i7TU49uH6pekzvdLLoYeBc6jMt9bZqfwOJ+or0k+u29sjKWrgbGRIsXxV59iiBfnnlDuIT9cwOpTh0RwjfFiPdteCpcjHpAwPlGkjdZgDvS9H1Wa4cljl6k0xt/xW8dCKbWovgfi+p9Ko9Ozfa6L67DxuEwUSvH0wEIqRzW7y/HCmsNYInXFLIX+XzOdjnBR1/Jk9QmLL9f3x5AGnriaJ4Zzrotf9sRjKY5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 14:26:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:26:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Subject: Re: [PATCH RFC 26/29] mm: rename PAGE_MAPPING_* to FOLIO_MAPPING_*
Date: Mon, 23 Jun 2025 10:25:55 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <6518A8F2-C932-43EB-AC21-AEC008F243BF@nvidia.com>
In-Reply-To: <20250618174014.1168640-27-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-27-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:36e::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9054a0-00a5-4ef0-7569-08ddb261e00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6K+j+x+yROsNUsB0fdmVv4yiCsqxOuHL4XHmHn3TiGvFOKdL/idNRFjbokk0?=
 =?us-ascii?Q?tO6rdykdmj12LQ2ZtebO4l5T1Onpa8SSV0LP6TFc3qRTT6I78yJW8kERcoPM?=
 =?us-ascii?Q?LlYWk/HzhZDFmM6Qs/4Ze6wbVfu7iI2h0VgZex2sVuoQguL3RnhXAgpPQo/r?=
 =?us-ascii?Q?zCwYkRsO4fUEpPRsFaiXPTfQ8GQTcyCSG3I6D6w1zXo2rRk6xl10LNmG7Q9e?=
 =?us-ascii?Q?dxPyPvy7ecA4H3ZxpHnG5H6R14m6EkQ383yVsmLt0SjqfyuiUlZFmVLSZdwo?=
 =?us-ascii?Q?zg1BAqKvH6JYSdq5NC4q9sZgGwgjxTrKn2MYHCyHhOPhgoYAdZeAqy+NUY70?=
 =?us-ascii?Q?F6UFbYuEF9YbXCubWkGDbdGIKvbF3lgm01qjRD9hU5uoyt1YzPW8GO/F4CSA?=
 =?us-ascii?Q?wVJ6Wuo25OqP/81X96XmY7D39TPCCctkwTin5qDRNGAFY8RNUlvALqZHOmta?=
 =?us-ascii?Q?VkHgP8O8WQ6ZbviOiZDR+0JpVlT3mfHRv8wkVFF4rJEaeL4RWb/7VnFq8q7V?=
 =?us-ascii?Q?FyiQ/mqWIWDygSGEAAyKGASCPCsz/WT1CfdbP06WuCxKgWoJqGRRU6DKyw0F?=
 =?us-ascii?Q?+OzfeRqyhKU+TixTKQObhq6+XNb1acMw1h/XJNbafOWd2JB0mOuAwkhwG51U?=
 =?us-ascii?Q?86Vtse6Lh3p2eHQA24usLlpaNE5TdONWQ6f6tUr3I7E4bfXef1x+8mWqD6aJ?=
 =?us-ascii?Q?nDrwpMquOWOdT8If9YzKEUH8ILspG6GSopVUBUUUNdthmnQ5Bo0KmZlVJZ6t?=
 =?us-ascii?Q?bUL228mfSkVdpyV4xfZF1aBfkhiMFv2WsZZ813xgRKCLRjWRB/p/reLD7zoY?=
 =?us-ascii?Q?qDAqxxJKyMaEig3izgHZhTCQUoU2K3xl3Ng2/f2tC/5ATVmiDuanUE4SaJ4o?=
 =?us-ascii?Q?35n3O8ioaVgZ3UY2RqLMKwn5FguA9dt7/Y/u/8/AkXZM8CNn3zfSShoduyTc?=
 =?us-ascii?Q?0HWKk7OCSWrziwVm0rpKQv+hCSahNheuH5UvpRogZlaISe9e0h8ruDqmfiTb?=
 =?us-ascii?Q?4IogqkJplIEr0UGaX8gkDYySziMlaDLYKUS2m0Zvf9MasR5dAnEtLPsib4yT?=
 =?us-ascii?Q?613gAWIJu3QElYGtZ/O1xRsoBYfqYCb9ToTlX730whzwas70iOJBOKWcFwAk?=
 =?us-ascii?Q?rIZLOmK/a9pkTTSOg8O8HdWNlsCuYrxyuMnU2gIdWTD25xi5CMMgJmNWIiFU?=
 =?us-ascii?Q?OGorRtI1it4T4GowAToks+FuK4CNy/umZOqS1OgXgFQ5Weau9RsRY+VB/sV7?=
 =?us-ascii?Q?a7Z4wu6Wx1PbHmXwjNcAY8RepjYog+UjgShKryF7y8TbAEoy3Q85sQHzbvNc?=
 =?us-ascii?Q?JJjbZDvZza/nBpXFNMCEuL/Ev+yiyeMLNdbPamAYo9aGr+uUiQUjDCfKURNh?=
 =?us-ascii?Q?1qcahbvlsajxGN+FIHKiE/Bgl0F6VfOuL2UeLSuiMtMQ7L9P0EsJxSKdZuMT?=
 =?us-ascii?Q?aiLFw9FF1WI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?myggUg29g0xTNJAdxFdH07QPUUHYQU1L+ZLe2ZOJL2jjRLM0vynNr/q7oQH4?=
 =?us-ascii?Q?BQgNt24S+Gl5ew4qJJsNQgkQeSpBiXWec05LRUTGKAF6XI4ziw6erjOJSKGM?=
 =?us-ascii?Q?9nPQP6OtG35cwHQstUIjuRmwRW4Pp3BYqs/B2T6KCijRQJif4lMorNpArlXL?=
 =?us-ascii?Q?6kpFjihkv+AvvQxwrL8DhY42GPniBnA+NK3E8kdTOJ+gST4kWfJcRUw8965t?=
 =?us-ascii?Q?lyQJTnpcaHVXmIVvqKKIpIg4u28oX8cdbzbwTmoBBDjVhJ1ohBFF4vPUhHqy?=
 =?us-ascii?Q?c8nBD1IvyJiZjtSagSWrsN+apgtrAg2wPDs9u321L1DbIylQy5+pdiYEp2I/?=
 =?us-ascii?Q?MMMZlMAsi+dRy5Jdp3DmyjDy05NvGeDImBTDVz86N7m/d65+FhxvhfaSDiQO?=
 =?us-ascii?Q?C5NtV6+IX1a6X6TExG2HX11cD5NPa2tNATX3UYFv6wKKzuYv5WJ0LT218pMn?=
 =?us-ascii?Q?752UxXumLJb2ecgGlOdwBJqy5NaWAkj0eysy1uWNlwXOZaPwgvHL2X+rQQHT?=
 =?us-ascii?Q?W/GQqmYn0DKmlqNg5OotcyV7RZenv9alI+JpyhrUXGbtQUJJsA1UemTBtExQ?=
 =?us-ascii?Q?gz1021/eATjNerJ52C8dk9S9oW2X+IzCj+VIG2LMAK2vgKpEKqWwg0dta3Md?=
 =?us-ascii?Q?9CHFyDZZNrTPMDYsnjgvu4dnrwoRdsdbBOKmKlPlygoJHq7oqf0LYCrR6yJG?=
 =?us-ascii?Q?AofTxY1d1wiwm82lqNjt5Kjq4lhlr0tHHmFVUeoYL/6Lpd60efzoxDBT3R6Z?=
 =?us-ascii?Q?7Otcmo68Jg6WWxPknXoyORPCySJerAvKqs9TKe1PLoTTwiBTF+CmCKhg8yD0?=
 =?us-ascii?Q?rpWncVb1pskesE+gQSuJZnMEpVxmuesfhv7vU4SehAnMApgh1ApG8JCVLPoS?=
 =?us-ascii?Q?Kh4fE5XIv4yj46XUauP0c1CZ/4xT+MhB7b0wgu3akgn2qYhAmTiekatzo+s2?=
 =?us-ascii?Q?4CLYgaxgH1O8dTcPLEgMNj0jJOichscfl9zswOx6+oN8KZdjRvBVs6fU3UY6?=
 =?us-ascii?Q?jOz8j5/Hf/4IsR8mPyg2lNoCUq6qAUiCcdvoL1nqZRekERDGCDQWWtFbVo+e?=
 =?us-ascii?Q?OMlNUuYWn7IP8CMHjrgEji8oGs5Z9b9j2nwyIkSDXAweveiPAlzt6QcGVvLz?=
 =?us-ascii?Q?j2FGQJDp0SUgUNZCi7IgiZWyNimmRqHvqj9GSBwFUsImfYRVuVRKHTNdBXxc?=
 =?us-ascii?Q?TOMX8KmQDl+2bwFjNsAqXMlWRI26FrOMFg7hHTee0gw3/1zX1LdQNB053FnK?=
 =?us-ascii?Q?7OriEz7lY+I7anbm652JytKPda2CdFkg274feyGc39yFhu8mv7dWFoYyb3Yn?=
 =?us-ascii?Q?RqPo8soTOYzwwozV8pZPbKHWa70Zm28AO4jwy6eDN3UodiEt+xt/dyAeFF6E?=
 =?us-ascii?Q?6LcwLDEsxwriDWz534TheEth+M0LpsUUazaitw7fx4HR4O7+Uzs5MkM7D8mF?=
 =?us-ascii?Q?DthKJ1s/d4U6EQmKXiqFGzFwx9yOFeKa2JfUi9fRCFSg6WynlEzhtCIahWqt?=
 =?us-ascii?Q?6U4DSsVjD+yjDfkZAawRPIjVRCA/HXOKjzyG1hzBi+wtFs98+DrzXIKLXZst?=
 =?us-ascii?Q?nCk7ofF+jzIPr5XhkoM/0nHChxeTk1+yN+OKYUrG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9054a0-00a5-4ef0-7569-08ddb261e00d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:26:00.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhAtJcRj67dYSl4Oy4xAwTtPsnIWFsT+OyizIVFRCPUOrwMqEm5rvGXFckpmuGoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358

On 18 Jun 2025, at 13:40, David Hildenbrand wrote:

> Now that the mapping flags are only used for folios, let's rename the
> defines.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/page.c             |  4 ++--
>  include/linux/fs.h         |  2 +-
>  include/linux/mm_types.h   |  1 -
>  include/linux/page-flags.h | 20 ++++++++++----------
>  include/linux/pagemap.h    |  2 +-
>  mm/gup.c                   |  4 ++--
>  mm/internal.h              |  2 +-
>  mm/ksm.c                   |  4 ++--
>  mm/rmap.c                  | 16 ++++++++--------
>  mm/util.c                  |  6 +++---
>  10 files changed, 30 insertions(+), 31 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

