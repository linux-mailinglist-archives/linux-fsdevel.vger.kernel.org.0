Return-Path: <linux-fsdevel+bounces-335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72D7C8B82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F859282F6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5031D224D5;
	Fri, 13 Oct 2023 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="q0GyqJr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0E219EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:38:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B97EC0
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEtGoptCp0khpxEGj7Al5jbk043DWzVZyoo4QJEChGjLyelkIOB+1PpwLr2nQkbrPyOuU0Vks0iweq+8IBHpMDLK1AphlRWrpowX45Zz5aFqgLhYzkvRQfyXdg/euwDs68PcUxwxYz8fbCm+Imhqzn5/lbs3NEfTSlcDcvAfyHSnofCVVmYCojD6VM9jXpAdow4Evc2wMvCH3AQzrvHsXaty0jLb+a9YXD9gjtJgJ5Mo39Vh2OtxYkU8vfNFqt5pOSkf9xafoqLdKi6MTpA383J1J3QXIvX4shRk1UR+C2C4kVj7lnwVWG94gFM0cks4RTV+q5V/bUyCL65VOJCiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB52J+oVKpN4sWKVTXSlOleC4NBomuOKpwMpML2YBeU=;
 b=ECwJy85KNgpPUrXFvbmSnJqeMhfdnMw4hUaHBtufjtnqEIBJv6gOPm3NVA/tYfnElItsL/WzL2B4Npyhbw3myPqp7dDCyxfZwuy+6wxgcvwWFvEV1TQrHqRRgl9L6JZ50YDfhdeuCTZ+yk7nOd4NGzq4OU0+iy36Drv6fBVnWfKtoaB7wzc4zCD6ibkGseiIbKhNKyIEah2Esfxa9iPY+ZzBu0ZzBwmMsECmGtQz+m8mRHfnD+Lm4sxfYELX/4QbqBl3/IefDGOAr8daPHf9rHluWbCIqzxFTj09f0JGZew10k6y9qcsPN75CQeDjwuaJVngvaN+4Fp+8d9VI66+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB52J+oVKpN4sWKVTXSlOleC4NBomuOKpwMpML2YBeU=;
 b=q0GyqJr+2Ee1HRALz0yhr64yuva5Tv5862/RN9CVnM4iiyhsb/W+4k+BdQJ42FtND8hhYzv9Kr9p9TFERsq+GY/YuiOiutIpGlLI+0HqOxAnNP3OaecSd3XBtWvnCx+6QlKoVDcn7TDoRyOXI3roaNOihhyOI44BhJys+jTaVvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS7PR17MB6709.namprd17.prod.outlook.com (2603:10b6:8:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:38:30 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 16:38:30 +0000
Date: Fri, 13 Oct 2023 12:38:21 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	naoya.horiguchi@linux.dev
Subject: Re: [PATCH v14 08/39] mm/swap: Add folio_mark_accessed()
Message-ID: <ZSlyfdXsW0bmxb0T@memverge.com>
References: <20210715200030.899216-9-willy@infradead.org>
 <ZSLMFXrDFhzI5ieI@memverge.com>
 <ZSWTD1sgbM/LUKch@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSWTD1sgbM/LUKch@casper.infradead.org>
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS7PR17MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c773dbb-59dc-45b0-9701-08dbcc0ad50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CWu9g+AS8+MVOV99II7xWFvYeH2EnQuFXTOQeECgwQrSpRViwTCpeVZmRwMX33Xkv6FqoSjXCammbwV0UkdaNAIXnqyLrU8KRSvBke7kSOnvDv0TtVy9/IHAqAc4EFdFICJxivPx8sOR6otKhy+1ccYdBtDlL1Ppp/Z79V7CCMVgRpBkOSOx3S6569wsz8iD3Bev1uW2nCFudQTxmeaaCjj5Y7eiQFf+QcxGIB8WE+uDsHyNtus0XNVGP1mgfWmJPuIkGo4ZWIBf2+p62F3rJ82qAVIM1vENh5mTLEfsz8R42yA2wvHsKjHqynpnGkbCPyZ0aZBbL3UH5iBgmptwS44bRHDQ0B7o1Pq3bZOSJzPC+PdZpgkgZK38GujSXGahx5wrc8c82i4dRP3XQWM1HJL27DTbugHidnGrOzFfgr376+KRyP4MHNp6NiasnaRRUQLCcKkYlrVT1Ge87WTYsKXmHDrojlXKw8w2WsCxknBPanwCBplpqKGf9s4Kvj0shbzKvJq4BkM9MYHVXkpzOycDiTG/1lf3VVQUJaikCjmfUo/o6F7mKk8M6fE9xdse
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39830400003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6486002)(6666004)(2906002)(478600001)(4326008)(41300700001)(8936002)(8676002)(5660300002)(36756003)(44832011)(66556008)(66946007)(66476007)(6916009)(316002)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEaFRSJe/gXjEfARKHj7l8l1u5SuUKBl4UqP1x+ryYCIzXLIsLh2OY5O9s9X?=
 =?us-ascii?Q?elfrpURvgl96STgIOslYxsqVRDkKGo538qmTgyYf3whfPkSnvDNNBwJbiAv6?=
 =?us-ascii?Q?cP6aSXOi+fL4FWhByLj0V/EPEPelaE/bqbjidast9r1Bh3OZpmtSUC3UkGei?=
 =?us-ascii?Q?XA3SW2A3XNKSVAp1bCYbYfHoDHDCIZZig9HEnTLkw1Fe1NHfCGPjekxl0J16?=
 =?us-ascii?Q?MR4nGi8z6KLbrtwLLaFxaZf/5x/1DcQJ7S/QG4JLae+EX1wzzi3wDUAbGKhr?=
 =?us-ascii?Q?tf//iAKXMrye/rRIBHEk/nuHGyS8uq89COT5tuimuGH8ScBDuAvgCBTYacRM?=
 =?us-ascii?Q?BZE8f0aU8Hz/vI3at8ki4L6tf8Fs8iHUa1JoMKonJT8vbglXdBC+ZQoYqOg+?=
 =?us-ascii?Q?4A0Ve+O6Geok+zPkvQOOH9Vp2aCOSCzoBRRGFPGleeTxLoDiN7RN8HbaHvhm?=
 =?us-ascii?Q?JxbruUO1C1dAIxITI4tQCFUXeFTiWdIy+gJNS19YSQmssAE3bZc53evGjU0A?=
 =?us-ascii?Q?0PI7hZcUR1BOSBxYdent7ZpfWKvNZs61GQdLykVQAJvtC7rEL6ebTBkSuPwk?=
 =?us-ascii?Q?ygeg7WS/3X3+t6IlWa3c55xLUhFRl9f8NgK5324JihgvnximM+vN25aLmTZZ?=
 =?us-ascii?Q?zoj9Nq8QPIwEUsY1SAHyUo7EsZoP1REBzvsWBITeirT6itH208SFffbw76uS?=
 =?us-ascii?Q?osSr5t1SqasdrzfQrZir57eHhJ5qq8kOdKGiaPcLVDi+UqkITapnkuhGkOic?=
 =?us-ascii?Q?Blpyd6mAq0ZUmOkl3JFVNHNKNtWYoZqjHYVcGKjVQlQG1JnQLLCzpuHJbuRK?=
 =?us-ascii?Q?1j5P6yHhZMBDUHG/W+OsrZQaYfwnF+Bg0dTbXhaWBGsC59wdg9+eEfQ8kHrZ?=
 =?us-ascii?Q?ofzDHhF/+hMf2mR+etRLXEQ8nnVGBKbL/4DSiI8xCwhWGK6w9YlAiiDuojHz?=
 =?us-ascii?Q?V28QacV3qhCTvPecpe/sMh1Ol6by7VSwY6HdAK94tD1x64GtVP6ZFq6tPtAb?=
 =?us-ascii?Q?om1tFVWAAcYUBqCz6GGhcVmyi0MI+xexrsaGRkgeABxeKM7pJhA+/rfLhtd8?=
 =?us-ascii?Q?XoZnNW+ExEnghC9fhwR2IH1VljwJi+X8wm47GVnJs7m1O76Sy97Hi5emGidn?=
 =?us-ascii?Q?rjvmRzRB7SVXbSi82J1UHiyWc4wOJ8zQyIoh9uOe4AmERBw+4V3RVozkQmJq?=
 =?us-ascii?Q?FgCp2rUWjEeCU7uXzG7UMFsj5rkQlbuHK6iBNQnoSWs3QrOZoSRjdqHSm/7B?=
 =?us-ascii?Q?TKP+WEarbdPhoD8vyxae7gBJQCFPeBz++JNa575DwcxxfNt3CYSsa3iiMD8o?=
 =?us-ascii?Q?oVqpFWe6UJne/v5hRiXa0rNi59Ob4HUuoTrOSS+NT+YNedJk1y/fkfOvQ69f?=
 =?us-ascii?Q?hInSHp5icdhDseUag8NewrpIpDFtuTOPAL0x7uANdnh+lOxFwXwGsl/B+Xh+?=
 =?us-ascii?Q?+f5yy72ZPQ8QvoxX2OGawdhBiQpdVghPNSAtq+gFd6HBlmuaj66/u/bHYRCc?=
 =?us-ascii?Q?OpzBHo43Wv30ZRBZWLBDiFwZvcaAN2ibLsIStQccLOG5wu3HnpHpu7RNGH1G?=
 =?us-ascii?Q?9QvvOiKfEpX72LdVOieRiEb+bLJWGIIM7EgGfrn1yRdciYfJKkug4ivm5lA3?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c773dbb-59dc-45b0-9701-08dbcc0ad50d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:38:30.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcFpaVbH9G4o08kWXeITa7AWMme3EqmIunigsfS6ivKLVrqQ0WlkccIsT95iTbhPTdkN8715BMkemGitPrP8RI6S5vH0XnbNLBnKkzVtVWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR17MB6709
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 07:08:15PM +0100, Matthew Wilcox wrote:
> On Sun, Oct 08, 2023 at 11:34:45AM -0400, Gregory Price wrote:
> > a) Should we update kpageflags_read to use page_folio() and get the
> >    folio flags for the head page
> > 
> > or
> > 
> > b) the above change to mark_page_accessed() should mark both the
> >    individual page flags to accessed as well as the folio head accessed.
> 
> Hi Greg, thanks for reaching out.
> 
> The referenced bit has been tracked on what is now known as a per-folio
> basis since commit 8cb38fabb6bc in 2016.  That is, if you tried to
> SetPageReferenced / ClearPageReferenced / test PageReferenced on a tail
> page, it would redirect to the head page in order to set/clear/test
> the bit in the head page's flags field.
> 
> That's not to say that all the code which sets/checks/tests this
> really understands that!  We've definitely found bugs during the folio
> work where code has mistakenly assumed that operations on a tail
> page actually affect that page rather than the whole allocation.
> 
> There's also code which is now being exposed to compound pages for the
> first time, and is not holding up well.
> 
> I hope that's helpful in finding the bug you're chasing.
> 

ah, very interesting.  So the kpageflags code doesn't appear to respect
flag locations defined in 8cb38fabb6bc

We tested this hack of a patch which swaps the page flags for the folio
head flags according to the flag locations defined in page-flags.h.

The result was that the referenced bit was almost *never* set on an
anonymous pages, no matter where we look, even when we have a program
constantly touching every page in a large chunk of memory.

Head scratcher.

Thank you for the response.  We're still very much confused, but it
looks like there are potentially many problems (unless we're
misunderstanding the reference bit).

(cc Naoya since I saw you were actively working on kpageflags for folio
 support not sure what else you're seeing).

~Gregory


diff --git a/fs/proc/page.c b/fs/proc/page.c
index 195b077c0fac..8022a41d7899 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -110,6 +110,7 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
 u64 stable_page_flags(struct page *page)
 {
        u64 k;
+       u64 fh;
        u64 u;

        /*
@@ -119,7 +120,7 @@ u64 stable_page_flags(struct page *page)
        if (!page)
                return 1 << KPF_NOPAGE;

-       k = page->flags;
+       fh = *folio_flags(page_folio(folio), 0);
        u = 0;

        /*
@@ -188,20 +189,20 @@ u64 stable_page_flags(struct page *page)
                u |= 1 << KPF_SLAB;

        u |= kpf_copy_bit(k, KPF_ERROR,         PG_error);
-       u |= kpf_copy_bit(k, KPF_DIRTY,         PG_dirty);
+       u |= kpf_copy_bit(fh, KPF_DIRTY,        PG_dirty);
        u |= kpf_copy_bit(k, KPF_UPTODATE,      PG_uptodate);
        u |= kpf_copy_bit(k, KPF_WRITEBACK,     PG_writeback);

-       u |= kpf_copy_bit(k, KPF_LRU,           PG_lru);
-       u |= kpf_copy_bit(k, KPF_REFERENCED,    PG_referenced);
-       u |= kpf_copy_bit(k, KPF_ACTIVE,        PG_active);
+       u |= kpf_copy_bit(fh, KPF_LRU,          PG_lru);
+       u |= kpf_copy_bit(fh, KPF_REFERENCED,   PG_referenced);
+       u |= kpf_copy_bit(fh, KPF_ACTIVE,       PG_active);
        u |= kpf_copy_bit(k, KPF_RECLAIM,       PG_reclaim);

        if (PageSwapCache(page))
                u |= 1 << KPF_SWAPCACHE;
        u |= kpf_copy_bit(k, KPF_SWAPBACKED,    PG_swapbacked);

-       u |= kpf_copy_bit(k, KPF_UNEVICTABLE,   PG_unevictable);
+       u |= kpf_copy_bit(fh, KPF_UNEVICTABLE,  PG_unevictable);
        u |= kpf_copy_bit(k, KPF_MLOCKED,       PG_mlocked);

 #ifdef CONFIG_MEMORY_FAILURE


