Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496804EBD1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbiC3JDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbiC3JDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:03:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0E2E0A3;
        Wed, 30 Mar 2022 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JOUQtjOVGnzMTvrAXciZzi4fdOwU/6lDJpYr4hVgSSA=; b=giUiOmZYZCJ1HxXTcMFX1ql0TH
        ixZddAicQAT4cAynhD/AArtRj4bwqDhIeBsfuE2ctVonugmaQdKTiVVZ6J/BYkmbBJmV9LpE4BkTb
        jRLYyZAa7O5Y17OHjGq72atju9rbeeUAz6RHq719Sbz2fXF/5SodeNit+8aOWvcOXAFziSoFBTuQ6
        lxCR7gcPfd7x7BQVl9ZbbslVn01uiY5ZEiosthLA0TlCujWP3FL24NhLCnp8Og20b/dyO90oyqPyH
        tcYYmFJwmGzh8bsYB/uIhrufspLgLCETvpxjx+201yTx/KjSALTKGQf/9UHt8Vqq/azrQo9wSnCaH
        WqFW4EsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZUCI-00Eu94-NA; Wed, 30 Mar 2022 09:00:58 +0000
Date:   Wed, 30 Mar 2022 02:00:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v6 3/6] mm: rmap: introduce pfn_mkclean_range() to cleans
 PTEs
Message-ID: <YkQcSusH9GCB0zLk@infradead.org>
References: <20220329134853.68403-1-songmuchun@bytedance.com>
 <20220329134853.68403-4-songmuchun@bytedance.com>
 <YkPu7XjYzkQLVMw/@infradead.org>
 <CAMZfGtWOn0a1cGd6shognp0w1HUqHoEy2eHSWHvVxh6sb4=utQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWOn0a1cGd6shognp0w1HUqHoEy2eHSWHvVxh6sb4=utQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 03:31:37PM +0800, Muchun Song wrote:
> I saw Shiyang is ready to rebase onto this patch.  So should I
> move it to linux/mm.h or let Shiyang does?

Good question.  I think Andrew has this series in -mm and ready to go
to Linus, so maybe it is best if we don't change too much.

Andrew, can you just fold in the trivial comment fix?
