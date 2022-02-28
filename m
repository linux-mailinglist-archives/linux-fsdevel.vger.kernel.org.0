Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F64C7BE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 22:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiB1V0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 16:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiB1V0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:26:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D21120F4D;
        Mon, 28 Feb 2022 13:26:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5D911CE18BD;
        Mon, 28 Feb 2022 21:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374C1C340F2;
        Mon, 28 Feb 2022 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646083567;
        bh=dTA7ZB6h2lpmfaVrirJXf8jiBWbprTlco10h8RcWxQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lnwE6a/P2L0p0ZkSFA/1hxsJvhdst69cgomzj0eS5+yqaRaX5vE0bomZ+yfyXb/PU
         N/hpDUj8WgaKcnKHQqj76lXCQxMQNnkWcno8K0wT0BxrykeMaXnkGm0XsdQ6Ey13Hi
         rNxbQAqYehxIQ5wqbkpLEnWaTkNUK05JraSP88ms=
Date:   Mon, 28 Feb 2022 13:26:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, apopple@nvidia.com, shy828301@gmail.com,
        rcampbell@nvidia.com, hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v3 4/6] mm: pvmw: add support for walking devmap pages
Message-Id: <20220228132606.7a9c2bc2d38c70604da98275@linux-foundation.org>
In-Reply-To: <20220228063536.24911-5-songmuchun@bytedance.com>
References: <20220228063536.24911-1-songmuchun@bytedance.com>
        <20220228063536.24911-5-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 28 Feb 2022 14:35:34 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The devmap pages can not use page_vma_mapped_walk() to check if a huge
> devmap page is mapped into a vma.  Add support for walking huge devmap
> pages so that DAX can use it in the next patch.
> 

x86_64 allnoconfig:

In file included from <command-line>:
In function 'check_pmd',
    inlined from 'page_vma_mapped_walk' at mm/page_vma_mapped.c:219:10:
././include/linux/compiler_types.h:347:45: error: call to '__compiletime_assert_232' declared with attribute error: BUILD_BUG failed
  347 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:328:25: note: in definition of macro '__compiletime_assert'
  328 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:347:9: note: in expansion of macro '_compiletime_assert'
  347 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./include/linux/huge_mm.h:307:28: note: in expansion of macro 'BUILD_BUG'
  307 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
./include/linux/huge_mm.h:104:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
  104 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^~~~~~~~~~~~~~~
./include/linux/huge_mm.h:105:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
  105 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
      |                          ^~~~~~~~~~~~~~~
mm/page_vma_mapped.c:113:20: note: in expansion of macro 'HPAGE_PMD_NR'
  113 |         if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
      |                    ^~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:288: mm/page_vma_mapped.o] Error 1
make: *** [Makefile:1971: mm] Error 2


because check_pmd() uses HPAGE_PMD_NR and

#else /* CONFIG_TRANSPARENT_HUGEPAGE */
#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })

I don't immediately see why this patch triggers it...
