Return-Path: <linux-fsdevel+bounces-25317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E494AABB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F6FB2D7A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E2F8175F;
	Wed,  7 Aug 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPL7js9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434A8060A;
	Wed,  7 Aug 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041962; cv=fail; b=HeqO8Ot8zb7ox76UrTzVKy8A8qHATbuXSEaWEc9cUubPBRCezmyoAB4ExxxR6sPKgtYrEjPWeFqVYGPvCHbgarCtd8vPUBTQ5jMoDbtx/9WcstupRfqmQtykvR4GpPgWZsSvENSs1cyGB7rP/QuMa7rw3YPU/h5l3/kJc/WZFgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041962; c=relaxed/simple;
	bh=Uuvr3QHNsHqwcm8+EQsNnQCqalRHWPtuWNfmzZ4OJDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0gEzRs2LK1oJ0UE3u8RsXSDQEfxni85aE4sgviCrO6RRy+eSpDYrONZBFz2KizZRqllsB97aK+JNf23+Pt/tqGbTjUnKSbMqnHU4u1YO9/aFzjcygbg1k4u/8LrqWBcNP1kTJwSPMoAWtEESRKxkvylqvypV4b/JZJ7NN+GwI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pPL7js9S; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCyZR/D2x0pjDn0LqDECj4yEDxz3RGPG4YzIhH+ng1lDOG0kRCUzJfb/I+HeDhHBcy6tw1NXelUMmAjt0lj9Xmaljnj6/qFHDKvtrnfe8P6Kgw3iHLa4w628A+LKX5TjZK4MvfqVibjZh36YhKNS5RjJ8yW9XAwk0Gki9V75hv0ub49FBPtMP7m38WNY7t0kuwzNmvWO7WTelusFJRgdsQhoSdXPHTwd/nlwxdX5RNJhk8tyTsDlHpwveahyHET4blxQsy1n970XtreofjJTF+B9mPZJgAxKiBGn+p93J72iDEjuRtLz68k7RkVzQa7WYLgBTg13FSmQCLQP2Kr30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXnD6XEpmXhRbRhdfttEq0A+uWfityKw3qWhGwVeHQ0=;
 b=Ae33zF059JhIN+4VSppTAhRH/E1vb9BD0lyIH63HSYWKVDRctPpfWQoCA5eSTYSyN+ntGJnoxT4LnWABWG/x8lRw6Lu+CMk3pw1F7+b6FMPIjvygfdkv9RRF0MnPtl6LFSqyRXRN28eRW+iq8YQeQeJx1S49liUCVVsILxiweI9UNbK8h+mHRcOvLQNH3RWGZNBh9SlyT0Z0A83w2JJNsPOsp5sZx3x8owBJpdGGaRiDEHhK9MnvM3RsOwx+vKNgio+pAqzf/Mq55JUAU6ujsS3TjMn9nNYX5B9/ATQiEM5fY7j1wBbsN7lLS6XHIAR1rrOyM7dTJP0AFb+eh0ziBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXnD6XEpmXhRbRhdfttEq0A+uWfityKw3qWhGwVeHQ0=;
 b=pPL7js9SoW9EGRLWihCgGdTOIpRzErwespS1ZWXWLrzH6KrUKDw1ok/TgczPXe+G7OPbFdRwfXP+bunpTIW2jeaom4HjDnlJ7STCWvGh753up2lTxb9QVT05gdSULawcLxWCMujDTUWeQroMlvbE2JqBc8MYo42BNJzGcp1EC8eBwzZYwj2R4Y+wiadRcW7JfucrSNnNRcY1C2K15VYDBTPU++wpGyPn7FCD0C/OTXUdnvjjyboDTQutVT0dkNHlju6HleW39pv+vIUQLNPVPdSoCWIh/A/u+hwOsu5RcLu/X0DZi9xn4SEH4aLRq2p6hxUZTDfjgBeJs6eYG8fc0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11; Wed, 7 Aug
 2024 14:45:53 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:45:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
Date: Wed, 07 Aug 2024 10:45:48 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <2D2B77E0-66BE-4ECE-8262-3E28D7D073E6@nvidia.com>
In-Reply-To: <a612c83f-071e-437f-99e1-d1fb157b62d7@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
 <20240802155524.517137-8-david@redhat.com>
 <e1d44e36-06e4-4d1c-8daf-315d149ea1b3@arm.com>
 <ac97ccdc-ee1e-4f07-8902-6360de80c2a0@redhat.com>
 <a5f059a0-32d6-453e-9d18-1f3bfec3a762@redhat.com>
 <c75d1c6c-8ea6-424f-853c-1ccda6c77ba2@redhat.com>
 <5BEF38E0-359C-4927-98EF-A0EE7DC81251@nvidia.com>
 <a612c83f-071e-437f-99e1-d1fb157b62d7@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_25768A0B-705E-49FF-83F3-CB66AE39AA81_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:335::28) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 288df178-0742-49aa-978a-08dcb6efa354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URv99x9m3NrwWzJm1sLquNWWxYK62iXntWGp4JMEq6iPIDInZQescRdHJQna?=
 =?us-ascii?Q?3Gb36TuuFqMlap0flvfhXNNOH5ccqioDPuIfmm8/DAdtQd6tcqDKMRGNHyCr?=
 =?us-ascii?Q?C2EHJf0Yybsaq9eyiesVaTVmEHFtm+oLLeiWpW0CQlfLkSLgFNfd5fiq4GYJ?=
 =?us-ascii?Q?z7/CObGD43mV4WQqF5jPgdScbvigntyqnUnvczXIEVd9a5VThlQfhL5HL6ZD?=
 =?us-ascii?Q?6+zv7UVJLiie2K5BidRsLU4IX3X2vNIfslH9u/NnaTDkdwdvtF9s48cZhKKN?=
 =?us-ascii?Q?zc8rzChbb/qRteJ6pAsFbO/WCJgt0eJhzlAXTnd28fV8TZIAthBp5eh3cbtd?=
 =?us-ascii?Q?wzHpJzCymrFvCZiNn7he6xhyWgPA0GME/XXcof16rDFGEQ7Q0zPq0jeUW3hN?=
 =?us-ascii?Q?Qipdw6t+ujc+PzXpZabyEkemVYSaA80Lmc0SfFVJ4bXBZ3P/wOpJhPZkhGVW?=
 =?us-ascii?Q?R52pQfzJeX89hnifdJ8vmNb88WKoCX3yd5h8fnnNHCqe86FO82mrHJb0/FG5?=
 =?us-ascii?Q?c6O4Pe41KZ8f7+TG1da45lVMSD3L8nHsJ+XxNYJT54XSwSBzBQYUSca1DXrh?=
 =?us-ascii?Q?heaa9WX/XayNlf1yUVSnKaMLrvZsbieihw2DBgKeoi4zQNg6tIxexRtwdpcI?=
 =?us-ascii?Q?WGwi5lh1f4nFEnRDMnEVTjpmCI7gfejt987nzsHvZIW/JoEaOLuCRMKKC2bo?=
 =?us-ascii?Q?/xXDRoeoJVmzQJu+lxzeZa53zv2vc9UtnD7/VysMdD2IkNnU+BGL4Ah8nig+?=
 =?us-ascii?Q?aanKiwW5uWhti2uJ1NtNuTddy8dcYMhETO68G01so32I/+giP0fZlKpLCyPm?=
 =?us-ascii?Q?XqAkblb/BcvlTCZElpp/a51WZ1H8vqpdubFIPbD1bbc1pgRIXXRg4mOPMOUg?=
 =?us-ascii?Q?2aJ7CJh6iTmM7njpXRfOAw+Ua/cLnhOW83A5dyKcbptM2K6EwZuR9mv+v03q?=
 =?us-ascii?Q?p0vw5eK7jza9VJl44Sz3fcCJTQCuvxqAs2+GNPf9dth2A5RNUhCXQKMABq6V?=
 =?us-ascii?Q?fu9QmTTAPJiIIauqrZowMNrW14L/r7GUfaq05+vEuyR/UI3mPob/OBTR8kcE?=
 =?us-ascii?Q?NmW16uqSlGsebhMiCztolrZMJfW2ujxc0gqtIjFWleLBgL3WMU6oYsKNEQ//?=
 =?us-ascii?Q?X56obz8Zd000jIHQ5bzbQ+9oiUij3v5X77owMO+IpjDNumSjK+Mrb+N6qEQI?=
 =?us-ascii?Q?1ElGVYPzvXHI3zpRMoLx1+wqU4rn9ADqW0AKJ6yv8GOHnHDO++A1dwEqfGLh?=
 =?us-ascii?Q?McCTndRZctUeywzmtGf/fuSyci0pdkXcE9P96TDtaorQAS3vstv11dcvk1kt?=
 =?us-ascii?Q?iHZmhFSbraSpaNuA7ReQygu98NZ31c0kiJMr+q/oSC+P7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9AnnI0J1taUIL1hvak9HdYPuhfRTs6GXzp5lFe8vmUJF++LgX6PmYlukB9Qa?=
 =?us-ascii?Q?OlK6ngDrqe2zjqFT79eCARVcN66cFFRfE8oWEK9/FSzF6WWNnpQfuQahtOAI?=
 =?us-ascii?Q?jyfiDNm+uixNMS/22Wv7fOHZV5+ZE6sJ13JQcQc1Z/QMrChWuTYQiwW2+WWY?=
 =?us-ascii?Q?6HJRaPO/IIMoq74POw6WkGa+xWyfWk19kFrX9YEDFZJHoR0rDU4Rt9+5VAv7?=
 =?us-ascii?Q?o8IqLHsDjy6fWKAXE9hX/Ocbcu+iO9WGXZhWIBN7ehZfjH6x9ex9rynGy2W8?=
 =?us-ascii?Q?ymKKxE8OpUB0w6oDci4Za0G8zLolc7KNQKsiIR88CIFn9mjBemUQMix2MbRl?=
 =?us-ascii?Q?qm3x7cuGo+SLdPF6ijK9fxZelbN3v0aVAofTZrHTew21mzr8aNtCD8EYn31f?=
 =?us-ascii?Q?58vveVIpm4jJRE3+q/p5Q+eRHzTorsx/wZaNhp92BjK6ojakTLjQ9obs3kFO?=
 =?us-ascii?Q?nEPAkYjazYYC3ej5V0MT7V2NLzjRU2lZOniFAts0k5OSAOq4XSXY3sCgs0Il?=
 =?us-ascii?Q?/mNCon6QOjqp6CANCv+hQVKqHDK1JNA+aOVpanQNQixjfQZb4/O3OXu8+322?=
 =?us-ascii?Q?pTF7IlVK1ZUSSzpit5fZmYmwKeKA4oD/uCcP4orbmaNkWG09uZtP/V9Hp4XM?=
 =?us-ascii?Q?0+DeINnxGzPBQQZMN5rF8frXwgWxP0USu2t7xXci79NBAuE+NTctWg15b17B?=
 =?us-ascii?Q?RPF9yaRti9QeOH6QaSRCUDfEiTVpERvdv3Sa2nKRQdc6OqjquUzKp2Y/DySr?=
 =?us-ascii?Q?KK2yWEi/ro3nT4mwfJ5YiHoSn4nbkRQkOEs6cddZZs4e89TPa9dxT8Pci8g3?=
 =?us-ascii?Q?01FoL0BEEpUr2vUU/wxC0m0ZUoRxlc0raYmy4DhtbWpEQkyGOIYXfoREssyo?=
 =?us-ascii?Q?rbNv8OQEwojXWZysPv4sHWl8LR3ojJg8/Xv/fLdkEBASAo7adOsCZ5p4KBUE?=
 =?us-ascii?Q?mNJfj6cAkAwvqGH3i981Kk7foC3Os8xC4v19/kdS6Go3vl3dVUtI35HezpP6?=
 =?us-ascii?Q?y9eEem34z0rQdRcNLYWP2C92USlZisfxXZ106DlstHACAbvimq6+sKqvY8s3?=
 =?us-ascii?Q?N9ChfIDVty6/Kfkbt6rts5RjviR/1NPb/ebIk98VYeIAGAG8ZMsKVu22DGAR?=
 =?us-ascii?Q?fSQkBWmF3EvwnnC4PcvHaMrtxQ7mkgD7rLAbhz47RVy/0eTpI/aPauH/G51J?=
 =?us-ascii?Q?LvjfIv5r4KvZDjpXY6WlxeYAmw/4qgDS6fnW0TA/Dhfmq+UeTVGGyjg4T8dj?=
 =?us-ascii?Q?2Z54T2dkVGESsxMg8pJn8if+Y5k/q6bP3xlX8s6q5A19jfi4jMqDQ/dx6zmw?=
 =?us-ascii?Q?ypBBVab4G3p7Dxj1lp4F85pcj3Vk/X3kzhC95igAQtkkYBc7h/qsHDcriIYo?=
 =?us-ascii?Q?8/6hezeB2hlcdd0Jaymt0lnYsmLR2xDzzoj2Sc1wJzyjtRrUGXZ+Nyn9YkAU?=
 =?us-ascii?Q?Fi0AEr+jl4bNq80MA8r1oZstSF97S4U9eioOhhakV1DA1Rx0dbl1ailLy3Uy?=
 =?us-ascii?Q?wuqRyhUBJLvdQ/ZNUSUSVZuUxYQHT6vaRpGOcshBWFtSSygpKTlJ1o6j6Xiy?=
 =?us-ascii?Q?90eEOREjxh/tQwciHsfrkGZorLIGpCgGWYI8dXkR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288df178-0742-49aa-978a-08dcb6efa354
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:45:53.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ3iVXdjrVRDdc9E6lggCzNSdciAxfDfIK8vLmEO0Nzp4drmr5X0Go5BJhzPILp2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486

--=_MailMate_25768A0B-705E-49FF-83F3-CB66AE39AA81_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 7 Aug 2024, at 5:57, David Hildenbrand wrote:

> On 06.08.24 17:36, Zi Yan wrote:
>> On 6 Aug 2024, at 6:24, David Hildenbrand wrote:
>>
>>> On 06.08.24 12:03, David Hildenbrand wrote:
>>>> On 06.08.24 11:56, David Hildenbrand wrote:
>>>>> On 06.08.24 11:46, Ryan Roberts wrote:
>>>>>> On 02/08/2024 16:55, David Hildenbrand wrote:
>>>>>>> Let's remove yet another follow_page() user. Note that we have to=
 do the
>>>>>>> split without holding the PTL, after folio_walk_end(). We don't c=
are
>>>>>>> about losing the secretmem check in follow_page().
>>>>>>
>>>>>> Hi David,
>>>>>>
>>>>>> Our (arm64) CI is showing a regression in split_huge_page_test fro=
m mm selftests from next-20240805 onwards. Navigating around a couple of =
other lurking bugs, I was able to bisect to this change (which smells abo=
ut right).
>>>>>>
>>>>>> Newly failing test:
>>>>>>
>>>>>> # # ------------------------------
>>>>>> # # running ./split_huge_page_test
>>>>>> # # ------------------------------
>>>>>> # # TAP version 13
>>>>>> # # 1..12
>>>>>> # # Bail out! Still AnonHugePages not split
>>>>>> # # # Planned tests !=3D run tests (12 !=3D 0)
>>>>>> # # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>>>> # # [FAIL]
>>>>>> # not ok 52 split_huge_page_test # exit=3D1
>>>>>>
>>>>>> It's trying to split some pmd-mapped THPs then checking and findin=
g that they are not split. The split is requested via /sys/kernel/debug/s=
plit_huge_pages, which I believe ends up in this function you are modifyi=
ng here. Although I'll admit that looking at the change, there is nothing=
 obviously wrong! Any ideas?
>>>>>
>>>>> Nothing jumps at me as well. Let me fire up the debugger :)
>>>>
>>>> Ah, very likely the can_split_folio() check expects a raised refcoun=
t
>>>> already.
>>>
>>> Indeed, the following does the trick! Thanks Ryan, I could have sworn=

>>> I ran that selftest as well.
>>>
>>> TAP version 13
>>> 1..12
>>> ok 1 Split huge pages successful
>>> ok 2 Split PTE-mapped huge pages successful
>>> # Please enable pr_debug in split_huge_pages_in_file() for more info.=

>>> # Please check dmesg for more information
>>> ok 3 File-backed THP split test done
>>>
>>> ...
>>>
>>>
>>> @Andrew, can you squash the following?
>>>
>>>
>>>  From e5ea585de3e089ea89bf43d8447ff9fc9b371286 Mon Sep 17 00:00:00 20=
01
>>> From: David Hildenbrand <david@redhat.com>
>>> Date: Tue, 6 Aug 2024 12:08:17 +0200
>>> Subject: [PATCH] fixup: mm/huge_memory: convert split_huge_pages_pid(=
) from
>>>   follow_page() to folio_walk
>>>
>>> We have to teach can_split_folio() that we are not holding an additio=
nal
>>> reference.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   include/linux/huge_mm.h | 4 ++--
>>>   mm/huge_memory.c        | 8 ++++----
>>>   mm/vmscan.c             | 2 +-
>>>   3 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index e25d9ebfdf89..ce44caa40eed 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -314,7 +314,7 @@ unsigned long thp_get_unmapped_area_vmflags(struc=
t file *filp, unsigned long add
>>>   		unsigned long len, unsigned long pgoff, unsigned long flags,
>>>   		vm_flags_t vm_flags);
>>>   -bool can_split_folio(struct folio *folio, int *pextra_pins);
>>> +bool can_split_folio(struct folio *folio, int caller_pins, int *pext=
ra_pins);
>>>   int split_huge_page_to_list_to_order(struct page *page, struct list=
_head *list,
>>>   		unsigned int new_order);
>>>   static inline int split_huge_page(struct page *page)
>>> @@ -470,7 +470,7 @@ thp_get_unmapped_area_vmflags(struct file *filp, =
unsigned long addr,
>>>   }
>>>    static inline bool
>>> -can_split_folio(struct folio *folio, int *pextra_pins)
>>> +can_split_folio(struct folio *folio, int caller_pins, int *pextra_pi=
ns)
>>>   {
>>>   	return false;
>>>   }
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 697fcf89f975..c40b0dcc205b 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3021,7 +3021,7 @@ static void __split_huge_page(struct page *page=
, struct list_head *list,
>>>   }
>>>    /* Racy check whether the huge page can be split */
>>> -bool can_split_folio(struct folio *folio, int *pextra_pins)
>>> +bool can_split_folio(struct folio *folio, int caller_pins, int *pext=
ra_pins)
>>>   {
>>>   	int extra_pins;
>>>   @@ -3033,7 +3033,7 @@ bool can_split_folio(struct folio *folio, int=
 *pextra_pins)
>>>   		extra_pins =3D folio_nr_pages(folio);
>>>   	if (pextra_pins)
>>>   		*pextra_pins =3D extra_pins;
>>> -	return folio_mapcount(folio) =3D=3D folio_ref_count(folio) - extra_=
pins - 1;
>>> +	return folio_mapcount(folio) =3D=3D folio_ref_count(folio) - extra_=
pins - caller_pins;
>>>   }
>>>    /*
>>> @@ -3201,7 +3201,7 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
>>>   	 * Racy check if we can split the page, before unmap_folio() will
>>>   	 * split PMDs
>>>   	 */
>>> -	if (!can_split_folio(folio, &extra_pins)) {
>>> +	if (!can_split_folio(folio, 1, &extra_pins)) {
>>>   		ret =3D -EAGAIN;
>>>   		goto out_unlock;
>>>   	}
>>> @@ -3537,7 +3537,7 @@ static int split_huge_pages_pid(int pid, unsign=
ed long vaddr_start,
>>>   		 * can be split or not. So skip the check here.
>>>   		 */
>>>   		if (!folio_test_private(folio) &&
>>> -		    !can_split_folio(folio, NULL))
>>> +		    !can_split_folio(folio, 0, NULL))
>>>   			goto next;
>>>    		if (!folio_trylock(folio))
>>
>> The diff below can skip a folio with private and extra pin(s) early in=
stead
>> of trying to lock and split it then failing at can_split_folio() insid=
e
>> split_huge_page_to_list_to_order().
>>
>> Maybe worth applying on top of yours?
>>
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index a218320a9233..ce992d54f1da 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3532,13 +3532,10 @@ static int split_huge_pages_pid(int pid, unsig=
ned long vaddr_start,
>>                          goto next;
>>
>>                  total++;
>> -               /*
>> -                * For folios with private, split_huge_page_to_list_to=
_order()
>> -                * will try to drop it before split and then check if =
the folio
>> -                * can be split or not. So skip the check here.
>> -                */
>> -               if (!folio_test_private(folio) &&
>> -                   !can_split_folio(folio, 0, NULL))
>> +
>> +               if (!can_split_folio(folio,
>> +                                    folio_test_private(folio) ? 1 : 0=
,
>> +                                    NULL))
>
> Hmm, it does look a bit odd. It's not something from the caller (caller=
_pins), but a
> folio property. Likely should be handled differently.
>
> In vmscan code, we only call can_split_folio() on anon folios where
> folio_test_private() does not apply.
>
> But indeed, in split_huge_page_to_list_to_order() we'd have to fail if
> folio_test_private() still applies after
>
> Not sure if that is really better:

Yeah, not worth the code churn to optimize for that debugfs code.

As I looked at this patch and the fix long enough, feel free to add
Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi

--=_MailMate_25768A0B-705E-49FF-83F3-CB66AE39AA81_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaziJwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKia0QAKfId6EHqNme9NQTHnfifrtthibI+P67+J4M
nadxlgcUoaSQqkoPacztwXMr3BcIBOu7zQCkG71Odxynd0ByjBiu+bMT0uVfHPg6
6Gu+amGevb9StcrryIfqUOvoFmfpx5pAQ3GoAttQnW7GlO+/7CNz+P32+1WKl1qm
WS70GE932Tsiqt1nl/el0IdmbM59OWlbVnC23KczyDYnpfT+um6YVVT+0wJqo92f
2PUuuppx6zmOCUN3B7wWIymRZGFoXDSLLwHUQKeZnW3BKdDH0ZJO6Tk+soxetKuF
KHtzKWk234k8Rl9e527JzjCHkiNli6q/h33EdqtWM9SpWNeLmBixDhBh0yPcqc6o
IpMW7Pu3TOV++oNokdujBvGoVt9ca/SCWte9pjiJOkqSU8Xc4eL9dk4dR6bjdu9V
u5fC8RxaT94+06N+2dzV3epU9z9ROHNyc7d0slj7D54lq80tiB+Zp45k2jSJvxNz
fj45Al+12wjdf/cacfad2QtrI3Z/MQKIGmV5sLj5YdI9F0sKP8dAt/R5ebX3Dxm3
cXi5aAz8Rle7hakzEasOz+RbdGeiv5ICO3/kFmja7N7QkP1z5lJVIxfvCdIXoixF
+cXL1+Em4uUjNa70t62qEXeufm0+RXdBof4UlEuY9phLUj2oHdJrisRSsMBJiMhd
fXYuizlG
=rxJC
-----END PGP SIGNATURE-----

--=_MailMate_25768A0B-705E-49FF-83F3-CB66AE39AA81_=--

