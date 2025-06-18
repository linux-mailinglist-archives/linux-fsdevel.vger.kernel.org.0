Return-Path: <linux-fsdevel+bounces-52089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9D8ADF58D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF4916704C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B37285CA7;
	Wed, 18 Jun 2025 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3/oq1vJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFF3085A4;
	Wed, 18 Jun 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270158; cv=fail; b=KJjPqsnzNmvXD+f2cSrtJv3HtBf7ETfPig+cLQqoctnYDuANQpEIZlHx+VN9/72BvQ3fxCplXQ0a0BofPVSsu8zd/vfdCkUjBIQIIeGnp4yGhTIEBwHr1UyCsnVP8B5eYd4JD26cQV9F5bNj0y5ygMri0g/hXQUr896oQy7Y8zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270158; c=relaxed/simple;
	bh=q4Y41iz9UvEF66E0SM8CT0183/+D/bO4ZUk73ZcFI54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gInVDF85DltBNmrM3p/KNTfXYAFUdpZGUtDw2iMd/Y3+jw5ZggvsWSp63ySmA0EWBMU0ic75gOgbGGEJ13+1ROoLeC8pQSDlUpol+InxnWjdg2beRFCe3GEIV/TM2Ke8EmM8TwP+FcAWB5Kteqb2bYGI5PwRK/NXauxSFKJx1to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W3/oq1vJ; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIhI8oQz/5iXUJaJ7hfzfYzhals+Id7XY+VBPA+6khL7d9lXlKzgTbKrNpX2Il8tXxgYgL7NYS/8sAyCNkAetvt4t0+UAiQH0iTHQ5syqvpNeTmvPPBalbubIDMJ9iWyAUw7AvSF2XedRu5Su70BfSASIn4awm4BLI9zOQZdINl7MmppN34ci3clofehybn7DMpCZgZyGJQOsAMDX5dcypBgjgNkdnWyajoIdJDcVpdSFeTLFaV9LBBbUli3xaFpRH91H4W2R7pk74GukaLNlYSonMTtvOpCmzUENczHuq/5E8F3Z/3/qfjzjn3J8b6BGETXVUAu2Q783t6xqh2UiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+GXxB1Tq7mCmScygQjpE44maxziYmg6zmfKMtEqFsE=;
 b=FxTtCpP0N86i16Syh/5ADwK1pnCctJG4fOlrUKgbz3JwZbwuBE0vIDrMeXeP01pcCg3voATz1H+/+Odnd93FUBj5PqXPrSkZQfW5jev4Y97x1mIJh7LvETbWzgKYKACFB3vW+Cnj6FChpn8wTsiEFn3JW6KP3C5adCTSchn/qtvCYGIFeiQ+CPlWTWDMwW20L34eAXJE+RfBZoeT0hushgcIGk8eCRr33djaA2E/1QmIXXXS0QDUmz0T6SCNFc2wqhbGBPXwsavCSdGd7t4phINqNJYsxe7LTRBU7jMAAmTXSsAf1TsROUZ/fYRd8pxcVmSb+VP83hYZMfOQ4xiqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+GXxB1Tq7mCmScygQjpE44maxziYmg6zmfKMtEqFsE=;
 b=W3/oq1vJKxSIQDhh8SOCkAy9dQMgMRQlKGjNNVKHWXGrVc7PZl5dWyerEtO0ewOJlWSN57JxXJ6A92pkHLPcCHXjnA8lCwxUS/Jf1LDGUR1Oxu2ZLWV+n8crrzlownZmBkSAnrSqVDL8r7zIXK+6ZMAaQD7MaP/kKWbe/YuSB4j1ooZJmyt9PjsrC7bqa1+Msd5pvw9A6Y8KMqdMmfy6sOmGzhYDWlXEyxkNVTFnnq6quTQNF5UFtDembvyCFgmf8ug7frJmM00VThbbVariAKNlxIiS5MaS+0w+kQ7au/EaFFiX+P6gIuL2U7ujNIqcySdO3VyzT0Mcaihr1VX4EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Wed, 18 Jun 2025 18:09:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:09:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH RFC 04/29] mm/page_alloc: allow for making page types
 sticky until freed
Date: Wed, 18 Jun 2025 14:09:08 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <0CFA6160-04EA-45D6-AC50-D10D659F916E@nvidia.com>
In-Reply-To: <aFMAQs25hGnAq-hn@casper.infradead.org>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-5-david@redhat.com>
 <D80D504B-20FC-4C2B-98EB-7694E9BAD64C@nvidia.com>
 <aFMAQs25hGnAq-hn@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e9cdd5-bc87-4bca-ee9d-08ddae933a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHpBVXRES3RUQWtKdU9URW1TRjhXdXU5dTR0V3BFQ2Y3a3ZoV0t0UmdGV1J5?=
 =?utf-8?B?Q2h0ZkNKVTN5aGd4eU02MHVzRlJlenBxU1BPYWVvanJZWk50T2FTVUt0QWFy?=
 =?utf-8?B?ZzZOZDlncDVFc0FDRXo3aHYwaGxOZllMejF4eHFJNUtHVDFPaEdCSnVpbzBJ?=
 =?utf-8?B?NE1FZmJSWmY2TjdZQzhHZDRDczNtQi9teG0zMVg2NDhBYVhlYnlscXlRUTA0?=
 =?utf-8?B?NkdpL3ZmSFRDaFR2Tlp1cXZoNWtBdVRzeEVDRnJuUk9sZUdkYWNhTk9xY2sv?=
 =?utf-8?B?eW5yUU0wZWRKdVdtWk9vRW9mMjY3WGxBdmZaUlFkU0tJVkV2REh5TmRyK21N?=
 =?utf-8?B?T2RML2dQQzlmRlQ3SzU4T0VLVEpZYkZNZHNKQXFSWEE5V2tzUXdkRWZxQ2gw?=
 =?utf-8?B?dEp2K3gvVGU0V1E4eHlTWGozTldxVVdZQnNJL1ptK2JCeWtuN3prbkFGdkVq?=
 =?utf-8?B?eHpJNDZrbUs4UCtES2tuT3QrWnBLL2tMMUtjOWxlRjhMVThsWHYyTlR0cDBu?=
 =?utf-8?B?dHhNcmprdHRoWExxbU5EcmM1OFNWZElhb2pYNDVUK3BtQ1p1UFZxRGdNRDNG?=
 =?utf-8?B?cUlvUHN3WitkYXZxV1Q1d1BNOURBdUlKMzBxRWxxOUx4a2UrVExJN01rUGpq?=
 =?utf-8?B?SXVrd3NtRzZtaTZZV25wRWkwcDZYazRJWWVlTDhRcXZCQStEcjZva2dGcG1q?=
 =?utf-8?B?OVJ2NjVNbVNOQVdpbTFaNzZ4L0x4Q2c2Vi9ycHEvZTROZVNaWUZ3dzQrN0FP?=
 =?utf-8?B?anoxZm11STZzM3VOenRoUzMxN0JwMTdldjR6dFJQRzdNY0g3aG1TQy9KdE9D?=
 =?utf-8?B?ZlhneHo4ak16OW9LVmNVRDRKc25HZWlyaXpYU2ZlU1NQeWFKaUNQQnRuSEJS?=
 =?utf-8?B?anhKbXdBNVQxQi81QkwyNjZZZFE1c09HRlhKeXZGTVFuQ0JiZkR5TXIxRDV1?=
 =?utf-8?B?Uk92NmpUWVN5dGdWdExEWjJQZ2JsZnFuVS9uM082YXZ6cGNQRXoyVW9wSlN6?=
 =?utf-8?B?bDFnVmxsbkNDRlIzK2cvRkR2a0xuL1ZyN3dSV042ckg5aDZGQ3pFRDAvem5G?=
 =?utf-8?B?cGdtYStxR3dLNlBaUGxUQ3YyaTQzd2drZ0ZiVkY1NWowRWJTU1hYNnNkOHVs?=
 =?utf-8?B?SGQ0bUlDWmFYZTI0NzNBL3NwNkF3T0pIT1o3bUcrNXlnYytoMHlyNmtHbkkr?=
 =?utf-8?B?elRhV0ZkMVdsVlhZRm1FYU5qWHlFL21FdDdub1RHSVpSb09DWWVIMzJocGRC?=
 =?utf-8?B?UFB0TzQ0UE9pYVlrTUNRSitDUDFpdzR2SEx5NEMwWDlmMGRiVTlXZDdUYUNz?=
 =?utf-8?B?eGF5NVpvQ0RmRnpXdTJCeHhtWmI0QmhtK0gyZVY2MzZCTFBTbHU2YXl1SjZ5?=
 =?utf-8?B?TnpYY3gxVCtCdFBRYzYzTVFXb2dxSzE1MlBUcnVBdjRaVWo1YVFVWmNRdGtp?=
 =?utf-8?B?T1BNVUJpZ0ViR0R0cUM5UlViUGsycWdyQXp3YTRMQXozdDNackc0NVBMYjY0?=
 =?utf-8?B?V1dxakhoQ2R0aVhkS0Rtd3ZIRnM0Mm9TQTBwZ2V6VS9qYmR5dVVlcDNnb25Y?=
 =?utf-8?B?alRKaWpENmxBbXhWM2prYVFPMUhxTGdsL3FWZEJLTStnQ0t0N3N1K0RuMW8r?=
 =?utf-8?B?NWFLeFU3cjdzbWpXcld3NnNCajJKdHQ5L1JuZXhNcDdlTXY0RERITEpUODZR?=
 =?utf-8?B?cloyN005U253aWJyVi9xUCt1MG5wdUhpYUFTTzJwbjU4bGI2OS9tQi9zNVBZ?=
 =?utf-8?B?d0hCT0hScUhRVkRHaTdHV0hmY1FTdklFV24xcTlaK3JEd21kVVV6ajBNcUVN?=
 =?utf-8?B?RzFiamdBR2ovSFg1NlEzc3YwOXp2WHJ5d05IcGd1RURxam9XM20weDh6RTJG?=
 =?utf-8?B?NDlXY012UUpsd0FVcFFXeWlBSHdycjJ3TE5CTldqRUtjREhmNkdqZUZUV2F2?=
 =?utf-8?Q?atV0xXfjrgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2VqNFk2eVNMdjZlYWRDVE5IVkt4UnpLR0kvVW1hSi9qV2hIZ2pTT1lCYkZV?=
 =?utf-8?B?ZW5rN3pxVTdEeThGbGZiRzJ2azFCSHZnbDhFOU5SLzVDQi92Y3FwdmoxK09M?=
 =?utf-8?B?eTErT2Z0TGdJRldGa1hxK0xXVUdaOFZ5QVFxSHVQK2RUbnVTcVUzYVd5aXlO?=
 =?utf-8?B?Wk9LRU8vSDVjNFVQSEovdHFJVWVDL09Md2EvN09icEdnbGVmZTR4YzNaWDUx?=
 =?utf-8?B?R0JrSzJnOVZEZXhaZTVOYmlPYmYzTkw4aVd4MkpmZnBsRVlHR0NzL2haWUx6?=
 =?utf-8?B?TkgwTTJMZlNmOTVXdnVoakt0S0J2cGJod1RQcWJmNVFUZmxzRnZzK25lSmlq?=
 =?utf-8?B?b00vU1lEWUJ2QjFiMGxjRXJrNnlud1ZDeUN0MDVaWnZYanZJMi9wczVwcURV?=
 =?utf-8?B?NFNCMnBWRUJZVFREc3loL2E3b2o1VStZSzZJYVNabXkrYm5FK0RoaEd4czRF?=
 =?utf-8?B?Unc0aXlhMExYMTg5Z212eEZUd3NhY3ZzeC9qY2trV1YzUXZiTGhjZ01CRHha?=
 =?utf-8?B?N055cjQ2REZXTklsdUgxRjY3ZU81MVRKenBNQ0NDRlNieS9xRHdCRFIrb2Q3?=
 =?utf-8?B?TGpTNTFPRi9lRDlVODZhZlpLMnYycGk4RHplZVAyM0dTbkhDSzJzQ3pFRWd5?=
 =?utf-8?B?YjBuRzRtU2hVVTNGUVU0TzMrMWY3MWhUTXBEUFZ4MjhkYWM0UWxPZ0d2YmRJ?=
 =?utf-8?B?MnZNV1ArQ2Fxd2ZYVEVZRE5TSEx4cE9Fdk8vZWloOTdKN0tXZkU5SHRBZzFP?=
 =?utf-8?B?RTZOQmIzemlmU0JUQXFWWWZRbmRONHpyZEdaVWoyRVIyMTZEVEFFZ1NmNm01?=
 =?utf-8?B?U0JJdmR2WmhQamRuNFh4MURPRnNJUVl3TkFXd2U3cC9PSWszZkdvb0g3SUVF?=
 =?utf-8?B?UWEvYUNyN1hIWXJrMTZsUVNYdm9BWkVza3JPV1ZRYU4wWW90bjljTVZEbmFr?=
 =?utf-8?B?b0RWbTFSTzUzMVJuOCtOT1Fua3NEZFhZYnU4NnpxQ2JGSy9mWDVaR3Q2d0xR?=
 =?utf-8?B?U0ZnVnRxZTV6SnNrUGRnL0FQQnpiRGZRQzVZOWtUY1VMb0oycXUvRExXREpo?=
 =?utf-8?B?YlYvdW5UUjcxOVlyb2cvd0VxNTNOb0taYnlXOGFpcnJGdmZKNW9DQVlyS2Fx?=
 =?utf-8?B?dE02bm80ZVc4aWZKUWFBeUt1SElYYm1pSnBIZUxhOFFzelVLZHIraENNOXFJ?=
 =?utf-8?B?UXF0aHFnYVFsM2ZNNnVYTlBIMXd0UitZVjAxYURwTkw5U2p2TjlGMExaQVRL?=
 =?utf-8?B?d0YrREF4NWRlY0VwelRSazVmeTNaSXlLY3JCMnk2VkttcWZoZnFOQlc3dUVL?=
 =?utf-8?B?dnNPUERmbkozQ0xBQk9EdUdzNGZaQnF0elBYalFZSjZmeFk3dlc3NStJdUJs?=
 =?utf-8?B?R1ZSdGJMRmN5bzE5OWVVQ2FnOXZ5aTNjOUllNWRwY3RwdFd0TzFFQlJIOFVn?=
 =?utf-8?B?b1VkSXBVQjdoczJVWUxDV2cwZE9hNnZqOGM3RVpONm5vVnNEbXZZK3VsRXJm?=
 =?utf-8?B?cU5XQk1qSGF3cGM4RjFvSi9MdnpvcEVVWnhoMGpUQ3A4RkpqcU54WjQxTHlH?=
 =?utf-8?B?U2JmT0dacnBKV0tUUUtCOGFZNHIvRU1YTi9yMGo1UzdiQTFocUZkSzBKemg1?=
 =?utf-8?B?a2kwVDB2eEd2dmN4U0hJZXA2RFMwaEkwM1BvK3ZYSFM0cVRIM0dXbWN1NUFl?=
 =?utf-8?B?VnE3U0YvU3lrUGNCK09SdlVwVXBsYml6OEFGcmZ0TU8zOHRBSWlxdWZISXkz?=
 =?utf-8?B?UWN2ZDE5bzN2WnBqRENhOXBMaExQYlBZOUQ4TUwvMG4xUy9xaTlJeVlOZ0lV?=
 =?utf-8?B?T01lMnNKUmVhd0FWWDh4bnRHcGJNVGk5empnSUlYRCsvcUI3RG5sZENjNW1E?=
 =?utf-8?B?QnJoQ1NwL1NHblhJdlV4NkxFQ1pnSXV0eGw4dUpVSmF0bjBDLzdhdGxhVlYr?=
 =?utf-8?B?UzFhM09rZmJqWnk5UVRwRjNuL3pPYVQ3MXdzSCtzN211Qm5lS2RqNlczWG5J?=
 =?utf-8?B?b3FoMHZoVFN6T29YeVh3SmFLdHgxdWlnUDlwN3RMSVhud1VQV3lWTVJlSmwz?=
 =?utf-8?B?ejhyQklBOFZEZUlhdmpYOS83UE5xOCtGelMzZ2YveEhYRUlDSU5vVDQrVGwv?=
 =?utf-8?Q?v3eQWc5jXt25EmM25/ML/vv9A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e9cdd5-bc87-4bca-ee9d-08ddae933a7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:09:12.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bij0dKL6BSgi0l7hge2wgaqTdkhRmLc//ghAQdrEc6M9UDO8MKgD2mUfmZ3Xtbrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

On 18 Jun 2025, at 14:06, Matthew Wilcox wrote:

> On Wed, Jun 18, 2025 at 02:04:18PM -0400, Zi Yan wrote:
>>> Let's allow for not clearing a page type before freeing a page to the
>>> buddy.
>>>
>>> We'll focus on having a type set on the first page of a larger
>>> allocation only.
>>>
>>> With this change, we can reliably identify typed folios even though
>>> they might be in the process of getting freed, which will come in handy
>>> in migration code (at least in the transition phase).
>
>>> +	if (unlikely(page_has_type(page)))
>>> +		page->page_type = UINT_MAX;
>>> +
>>>  	if (is_check_pages_enabled()) {
>>>  		if (free_page_is_bad(page))
>>>  			bad++;
>>> -- 
>>> 2.49.0
>>
>> How does this preserve page type? Isn’t page->page_type = UINT_MAX clearing
>> page_type?
>
> The point is that the _caller_ used to have to clear the page type.
> This patch allows the caller to free the page without clearing
> the page type first.

Yep, find that out when I read the next patch.

I think the change is fine, but the commit message is unclear.

Best Regards,
Yan, Zi

