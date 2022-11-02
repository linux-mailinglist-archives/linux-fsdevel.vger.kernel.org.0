Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF0616F14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 21:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiKBUrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 16:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiKBUrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7546C65D9;
        Wed,  2 Nov 2022 13:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1071861C12;
        Wed,  2 Nov 2022 20:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313B6C433C1;
        Wed,  2 Nov 2022 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667422035;
        bh=d734KrkzRNIacBzb1OxFoYKzAgC7fEMj8hqfCbnvm9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a0q4o12/JDOBGm2H3Mr5hdID6PSu7nJbDbyNqRR3UC6NdO0H0C77bKf9PirJUZmE8
         NDv9gR7zrJmOS6xFY5g6WrKhND3T3wKJu9rfgU9FfvFCPYyNPavKz9xmx+ZctKsNV8
         hOvf0mQX01v5paVELSSwg3HLEhsq3Fgg9W/cPjsQ=
Date:   Wed, 2 Nov 2022 13:47:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
Message-Id: <20221102134714.c72bea3c997ba3ef90d72c53@linux-foundation.org>
In-Reply-To: <Y2K+y7wnhC4vbnP2@x1n>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
        <20221101175326.13265-4-vishal.moola@gmail.com>
        <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
        <Y2K+y7wnhC4vbnP2@x1n>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2 Nov 2022 15:02:35 -0400 Peter Xu <peterx@redhat.com> wrote:

> mfill_atomic_install_pte() checks page->mapping to detect whether one page
> is used in the page cache.  However as pointed out by Matthew, the page can
> logically be a tail page rather than always the head in the case of uffd
> minor mode with UFFDIO_CONTINUE.  It means we could wrongly install one pte
> with shmem thp tail page assuming it's an anonymous page.
> 
> It's not that clear even for anonymous page, since normally anonymous pages
> also have page->mapping being setup with the anon vma. It's safe here only
> because the only such caller to mfill_atomic_install_pte() is always
> passing in a newly allocated page (mcopy_atomic_pte()), whose page->mapping
> is not yet setup.  However that's not extremely obvious either.
> 
> For either of above, use page_mapping() instead.
> 
> And this should be stable material.

I added

Fixes: 153132571f02 ("userfaultfd/shmem: support UFFDIO_CONTINUE for shmem")

