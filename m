Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9396C04AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 21:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCSUKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 16:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCSUKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8191287C;
        Sun, 19 Mar 2023 13:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C9461184;
        Sun, 19 Mar 2023 20:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF49FC433EF;
        Sun, 19 Mar 2023 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679256649;
        bh=GM25xAbInJmMi22lVxCbz6luhUWEGHUThD45pnCz1bQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yNxNrRc2rhiT42Lt9D97o6mtGm9kpCHejWIIK5vcUDPdfQ4iiSM55mJxEnmW76xNF
         zZePObOzpHJ0dvNP7BNlNFybQfpg6YsXno1BjdpEzDqG23gckiOoYseGvwOTUnAI61
         pcjDbL0rNNygC0Qryjkig+EqI+NQKab0lgYrN3ng=
Date:   Sun, 19 Mar 2023 13:10:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-Id: <20230319131047.174fa4e29cabe4371b298ed0@linux-foundation.org>
In-Reply-To: <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
References: <cover.1679209395.git.lstoakes@gmail.com>
        <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 19 Mar 2023 07:09:31 +0000 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> vmalloc() is, by design, not permitted to be used in atomic context and
> already contains components which may sleep, so avoiding spin locks is not
> a problem from the perspective of atomic context.
> 
> The global vmap_area_lock is held when the red/black tree rooted in
> vmap_are_root is accessed and thus is rather long-held and under
> potentially high contention. It is likely to be under contention for reads
> rather than write, so replace it with a rwsem.
> 
> Each individual vmap_block->lock is likely to be held for less time but
> under low contention, so a mutex is not an outrageous choice here.
> 
> A subset of test_vmalloc.sh performance results:-
> 
> fix_size_alloc_test             0.40%
> full_fit_alloc_test		2.08%
> long_busy_list_alloc_test	0.34%
> random_size_alloc_test		-0.25%
> random_size_align_alloc_test	0.06%
> ...
> all tests cycles                0.2%
> 
> This represents a tiny reduction in performance that sits barely above
> noise.
> 
> The reason for making this change is to build a basis for vread() to be
> usable asynchronously, this eliminating the need for a bounce buffer when
> copying data to userland in read_kcore() and allowing that to be converted
> to an iterator form.
> 

I'm not understanding the final paragraph.  How and where is vread()
used "asynchronously"?
