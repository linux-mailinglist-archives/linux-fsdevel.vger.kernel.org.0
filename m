Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB80780BB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 14:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376832AbjHRMVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376823AbjHRMVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:21:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14F30E6;
        Fri, 18 Aug 2023 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0oDwOIByjOVDOfLy6f21qg8nkzlLOXNjWABFE+sxO4M=; b=wL97AF5hG0hd7cgO4tOtTA/aUM
        UkSguRmrpSl/BpltRzs1pu1psVpf2BFoeOvfy//3P+7xmjcYlDKxZ4FAPqcHzrfAv+OH7VwseKE6U
        rMXPjbNvhCEQ53yjmXKwwE0sW17V3qVpX4bR4l56PJWgUxIjtb6lp/IbHlF/ncpKl/YPV3Nob0rqt
        ksrOC3A6w4+1cv0iAzY66KD8BnWPVB8SaGEvMg7Bbxh7FmVrbcxosBYffj83kS8JARN/qg7Sc+Ukr
        dXwMnR9JhXrqWBaxuEdDDRcZj82f/DcwDzKrFG2/oG5ZJPK6RbudSU7Jn/nq8K5y+Iq48rIxP2d95
        e8Mgxa3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWyTd-009N6I-UG; Fri, 18 Aug 2023 12:21:17 +0000
Date:   Fri, 18 Aug 2023 13:21:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [BUG] KCSAN: data-race in xas_clear_mark / xas_find_marked
Message-ID: <ZN9iPYTmV5nSK2jo@casper.infradead.org>
References: <06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:01:32AM +0200, Mirsad Todorovac wrote:
> [  206.510010] ==================================================================
> [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
> 
> [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
> [  206.510081]  xas_clear_mark+0xd5/0x180
> [  206.510097]  __xa_clear_mark+0xd1/0x100
> [  206.510114]  __folio_end_writeback+0x293/0x5a0
> [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
> [  206.520735]  xas_find_marked+0xe5/0x600
> [  206.520750]  filemap_get_folios_tag+0xf9/0x3d0
Also, before submitting this kind of report, you should run the
trace through scripts/decode_stacktrace.sh to give us line numbers
instead of hex offsets, which are useless to anyone who doesn't have
your exact kernel build.

> [  206.510010] ==================================================================
> [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
> 
> [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
> [  206.510081] xas_clear_mark (./arch/x86/include/asm/bitops.h:178 ./include/asm-generic/bitops/instrumented-non-atomic.h:115 lib/xarray.c:102 lib/xarray.c:914)
> [  206.510097] __xa_clear_mark (lib/xarray.c:1923)
> [  206.510114] __folio_end_writeback (mm/page-writeback.c:2981)

This path is properly using xa_lock_irqsave() before calling
__xa_clear_mark().

> [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
> [  206.520735] xas_find_marked (./include/linux/xarray.h:1706 lib/xarray.c:1354)
> [  206.520750] filemap_get_folios_tag (mm/filemap.c:1975 mm/filemap.c:2273)

This takes the RCU read lock before calling xas_find_marked() as it's
supposed to.

What garbage do I have to write to tell KCSAN it's wrong?  The line
that's probably triggering it is currently:

                        unsigned long data = *addr & (~0UL << offset);

