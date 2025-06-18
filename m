Return-Path: <linux-fsdevel+bounces-52093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C2ADF60A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638C57AFCCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CC2F5472;
	Wed, 18 Jun 2025 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gi+LmVxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A670830;
	Wed, 18 Jun 2025 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271888; cv=fail; b=LItKzhUvbvJBpbnXeIloT+TkwfNxHgk74wIirnFNrrTAryp4JliG9J/4ZMZg/ssBEhYU8jc1WNmbqpWbKIVeV5GwoeuoK40dRpE+E1ebWsavuuvioDFr49iYRm+sKVcFDVVtfg+sRN+rnHP5b7HX+Dtr2qtlMGmqSUMLQM3UgCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271888; c=relaxed/simple;
	bh=q4262qoSDwZ+d+VZowlliLUVnjqs82SrqMoYuRlS/7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxBdEGNWKzzX+KEhp3E2pvzcd6BACprDowXQN0rVr+qTQ8kjQ/GmmfaLX9J9vRgaX2OoDupEwK7n/TXOOaKDzRaPgK7crnplHmVW/4gsDSxKMpQTtr9ifeHuKZBBvRECVIl0/S3nSKfgwlcgVQXQlIg7oHrvmryX9DrpOb5OGkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gi+LmVxv; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umlgVuDiEyu5TEgUKTeYtht7+oQEI3wWTf/qDP/nFtvTCcUTRIJJQrVslnMO7kQuwuTOGl5tUtHeXFYBvyLzZ64uu+/Ile1lr42OntCoU+stNWk1sZOm+N1fwTBc5hZfHfjiZXT7KnXuTc4C+b9HRnByV+pXvgKH3IWVqsCWHtPpGWF4u7sIyTVA5tkZLO2zm5WCR87BQzVu/+NhmGPffmZDJUqBkbJ7t+G7vVGKHxRfxa3rglzDBCb0dfl9NpccKkqJjKrrITJCcdmaiiTeZrXx+HiXgyuczdOUrDgy+FRVyMvOlbGQZLfQC6qLVCMWetrKyJOG8pr4h07oI8bhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP9m5CTFPnSnjlInCJtGvtcIdsaEgOQLez3reN8phls=;
 b=RHyoWIuHd3uWRyQ23eEFzHF6eSiWeqFcCNFoO9igl6k7q77at44f33pqmK2b48kfnz8HHiyizKz1I0QqXNcXSq7eJI2ukOXwnfyd0YwSW6ygSISmiyB/lfZit61rgESHmxQ/c+k0pt1scZkMaguT+KMFnuPbubHIkCNEuikzpzYy/Eg9o3AnpMOjKcZAAejKOWEKAZ8sHXvTnS/JOJ5IwVNDCCmwZCiFrh6coYtxOIGN+WmgHEaIo/sZhMir14tcHvrd6Fk+kPCNC/uoBW7R6Wh3d5e4WOLCo4PZiboHcb3GByUvxt0BdeXAbnhnwNyUMUGrwKCeRrbw5V0dCFzuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP9m5CTFPnSnjlInCJtGvtcIdsaEgOQLez3reN8phls=;
 b=gi+LmVxvmrdmr5xpdAImciKkOG6Dm4kKFdyCq971DegHr3LvE7y/3pvNIBqlQKCQQtj2973PU+nJSuvpaf4v2Q2qDgQ4v0eV7pS6dPiRoYjacsIQrpE5oDw9/c2P6ilQzpjH11Kp0u7sCl8TKcDPNbrRCNmZbWjqmMY+iFlY+5ZaMz1xt+eJL1u2vaV3OIc1YTEdpWSDo4/V/Yl6CG+ybkVvg3Z7PuN+ULPwNbiD4bKQvm7/lDHwmSQXgGbYosw6whfmlHyGznumTwH0+TvloxziWUrL3F6IYfzLLNHGty1c4pR9lct0HBiQYvr3smQa1gLHrzJf/yoIIrqXm5gpog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Wed, 18 Jun 2025 18:38:04 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:38:03 +0000
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
Subject: Re: [PATCH RFC 03/29] mm/zsmalloc: drop PageIsolated() related
 VM_BUG_ONs
Date: Wed, 18 Jun 2025 14:37:58 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <70A74008-C336-4CFD-A074-35C9E2F2C279@nvidia.com>
In-Reply-To: <20250618174014.1168640-4-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-4-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 848af818-114e-42e8-f1c8-08ddae974208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vAsLkfU4UVX3CPiU9tO/d1cw9q6SwJkxOTf9NoW78LPUBeqyI0Ss4bb8gUhS?=
 =?us-ascii?Q?jJs8ezF7Dbr+KDmIMdCIIDrXQzrOEjF9lHBqMvxoEdR9Uq9E+j8CdwOeHhKI?=
 =?us-ascii?Q?UOShTaNGdjsdfCnedxvq4yqdrKcfp5PTXG6H4ldsddM4IDpxxbzvZ7rNIMF1?=
 =?us-ascii?Q?MSsSsTN3CMIx+tukTRZIEKEBdRmD/VWK6PqU0x6LEB05Ppc3YaaNtUzOkPVs?=
 =?us-ascii?Q?DpvRr8AeNFEC6Fv4g8AwkhcNJBXPnJxbtPtg9wegJ2Zm684+E/meEP6hgIPt?=
 =?us-ascii?Q?p/yuaeiNdRRVhYjOPr6/qykf2MWoReJKr30sb1EozKTJaXEBCwWTef4qts5D?=
 =?us-ascii?Q?w+sBDIt7IM1UMutqCKE8H8VABiGeAEcOOM4HY6D75y4tPM8fAFW7xEIf8CSv?=
 =?us-ascii?Q?hCvZ/q/QfqNoajek+TRsvIgqY2/lm5tEysmnCHEk18dt7Jz1g/S37BSlBPTR?=
 =?us-ascii?Q?6rz6tZB6PypAL8D+Auuo45dPufTf7v0RFZpKezd6eu2I6yeknIc5iD15r2jX?=
 =?us-ascii?Q?9lt7QrWZu0d6rhjRoJy+oKE6rYpte2YypyuhC1Mer08egiJ31//GVkZ4/QZ9?=
 =?us-ascii?Q?l9pO6p/irqcshyZSTOyS5NZE0uv5tvjYuJvXCKpGXTKZpWVsao0ja7kuUiCO?=
 =?us-ascii?Q?kCJWAqIXLMnoEOPKpu4EPmoj8rLGPSog6ZagwFxDtzDZrVdRq4M2rYnS11cI?=
 =?us-ascii?Q?HXXdI7yULM/F4ON/XP13OBIoMSBwtQVCVCpopFErgTnGD9GsY8yfwdgbzx+F?=
 =?us-ascii?Q?obMSR8cZNWQ69i0LOMxuNpEN0jS0XDyqc/ME93NjQjutVJLxCVERbCJxW/SU?=
 =?us-ascii?Q?ZSWV4raDsl9YBzb9ZWa34d4f5Q4aRe5W8+KNgh4HVRKqCkbz6CwsnQGpr1c4?=
 =?us-ascii?Q?JmEaJ8ssZDNCeAKltYLmGm1mRI522ERm76MAqoPhhbu44B+i47frKxbUxJEu?=
 =?us-ascii?Q?4X1/kTXCY9/L1ox2SBTDT2Qyr5psbRYwoQMo1QxR484XA435O9HbAQiQyXCo?=
 =?us-ascii?Q?SgwyGUX5xAdf2jgwHEGcQR2ljD+qhq8QbV5KPCQ9lY1/VQMmfUuJIuO0QFQ5?=
 =?us-ascii?Q?pabp4UbFdj2FZmRTzOF8tjO1iAi9wAg28h6ch7GSk4hKGTKcsKCerFMM1AsF?=
 =?us-ascii?Q?gCRGtiFEpmJJEBFONAuPh2qVs/2DZwALDTATPEjUJ/wqZky29k60eJolaqTa?=
 =?us-ascii?Q?bDN554JB17V6vE5nvaKJ0kyHxGn3mNjx7C97rJk53xqA4+G+OpUgmSLKI3Z2?=
 =?us-ascii?Q?daL5d0D2kGwDTxVDMXDlku0mj+FBI5DAGH5jdsSznWmiRR1zd15QQlOjzoKt?=
 =?us-ascii?Q?9r6hb/R57ifKAMhrl9Fi8OggT9Puo62NfyzMfuRtP20tU/j7FRy+NCCz4kMh?=
 =?us-ascii?Q?bzyYtHe2jEa1TlKmXfh7pXS3WOTfnl0KAnqRinHZe9A9oRcXw6McXVyX3k4G?=
 =?us-ascii?Q?pSVEUvXMQhA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lhw8fHwQZEvEOaFEbaFQ82bI4WfVuOOpLId3qWTUqhguNdhZxwNHwybprmnx?=
 =?us-ascii?Q?MeYxAp2Ttcg4ONpEW13KFck0bQxqV2wRsiJ8jl2jVU7tY4vwT8dhQpAMcQXC?=
 =?us-ascii?Q?GnkKPJ68nuDf03j6vnUGefb1F6lIj59l7RUrbDjQUvM1BOJfHMKlaMHQ1Afj?=
 =?us-ascii?Q?aek3pKKPahc064u7U8YgVtPuEPiKGY5G4KyXB2KPPna39dS9UlFzrtL+sghz?=
 =?us-ascii?Q?By723isw8b+jBhsuDQ7cXL5PgQsfJAgwEUY/GJkC4J3PulYtYw/aNh616IlD?=
 =?us-ascii?Q?MQGRdWtA+c/8IfNXBHZIhCqu+oj0TM/BdwOtQJPTZZAe0VlYhBPHsQKqPpkW?=
 =?us-ascii?Q?FbpsGs3Y30KRJNOeizPAkK+abJvbitOk4KfCiiTqUfseVVtk+litokne4QNM?=
 =?us-ascii?Q?403DNEpLyRJvs1z+dKFuwFdgWUOdPZzhNPggGmEsbKIIgBbmy5ORAUHOWIUf?=
 =?us-ascii?Q?tFN8/nGzbA2sNC9bhH1igM+4ReZy5BaGa6fMNXoLp35W08haitdMeToiG7gU?=
 =?us-ascii?Q?sjBo+K+Xn3+EjCusttt+asnGtMeTTNPTB0fNEhuTHeNVjnMc0YKARQrDnqn6?=
 =?us-ascii?Q?bqxDXnGO2zTh20qv14hSI3V7/DJDNKCem6VdmkxfBUEsBmXSvV9wgE3f8Ezi?=
 =?us-ascii?Q?U6IYF2Ai8D543fRLLKdtfnnUePf+aJ5O7+eRKPH00276qtvAWsT/49XrAF+s?=
 =?us-ascii?Q?w72vruQraWJMGPj6a1tJ4FzxwiLleTCsKhJ/M/Gc/dINREKRHAO+LyxNqF8A?=
 =?us-ascii?Q?NFfwgyKzrxTsALfOkAXDTWEqxUyYzkFRRzA+sa0S4cybCJTKPoIScG1aYfoJ?=
 =?us-ascii?Q?PkNAHE6Hve6XfQn6eAsRNlP6H8LiFi+8ZuQSQU4iNL5/rDuzxaUzrmuhh7sl?=
 =?us-ascii?Q?ZJ+tMz7P2+0jD4LFRAwhbYpfP0o3F3SnuQlKMPpw6OHyrRBnxp9/8czM0T0a?=
 =?us-ascii?Q?YFuFx90JnmJU3VDsKFXBIPRFl3ZuTA4Zkx/x2dfMen0aiyWjCt0CU0DUiZUk?=
 =?us-ascii?Q?+Ge6QY89uVFe2ldGF8t0ZrkxBLfjeKAGfNWBSloUbyBHtDa4d/u7LXxvrmda?=
 =?us-ascii?Q?60hoymPB38ZwjazCl581OqA3QFts1gyUtsX2yZbxF6umaEbkrPZaKrCQhuu8?=
 =?us-ascii?Q?2KRMA5bOUR/u6+gPNfA2VqVSZxlOUWIZ3hAcgyEF6BFTApOsaKzvtUAnuXjx?=
 =?us-ascii?Q?tTI3RBgQTZ/41shA4RlIvlyZT1pDD36OPvv8RdWJJLTcVEDB3H6yb4C3C+zC?=
 =?us-ascii?Q?bqyUhp+vp/D+Rou20WOmjQb/1pOC0G4RxEgKx6hMkwoudG56diIkvaRxURKY?=
 =?us-ascii?Q?BMhScfK96+qj+YBy1lWJUCsFQ7m7GaCoHniOeRbZXd4rcZljda4JMW+Uevtj?=
 =?us-ascii?Q?iFq0rdRqdUgZlsWJm7m8ZaVWFPh/7kndC6ywQaxrWMiVDNZ0XvoiS/ZsNsRy?=
 =?us-ascii?Q?1/XDSG+9zicJAxpJtZBNlLNtRE09AHQXaXX9F83rLUZzicus8PdE1Kv6k4wD?=
 =?us-ascii?Q?ec4DIZWQVUrOCTY5V0BHtF7Yd7X8ZfkH8YM/LMTAiycY5kjuuqHDRtAxzNFD?=
 =?us-ascii?Q?UobMKIb9skRhnOE3vF7OQ/dQr51eHYZ4VAOfi5Ah?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848af818-114e-42e8-f1c8-08ddae974208
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:38:03.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSiXM6PhuBR14wDIAOIlJA+M+nE1fvVLGiQygSa+zfhOwGcrsuRt9h72x0m07WN4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> Let's drop these checks; these are conditions the core migration code
> must make sure will hold either way, no need to double check.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/zpdesc.h   | 5 -----
>  mm/zsmalloc.c | 5 -----
>  2 files changed, 10 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

