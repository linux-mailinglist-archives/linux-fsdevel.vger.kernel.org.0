Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1CB79FDD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbjINIIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjINIIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:08:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7949DF;
        Thu, 14 Sep 2023 01:08:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84B541F74A;
        Thu, 14 Sep 2023 08:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694678891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/ecNnDz5zq7YMrO/wGOI+Yrvu8MsC3RqtEZg7CpzAM=;
        b=iXF2lvqeeTY41pqwpGIemAJn92B8uB5HcwimMF79k17rki4IDOuG1/fmhxDgQ3kC61Bp+x
        yxyEUd5bebZABOd1QmuX0W2vqETPHVFlnso1SBeRTQ3ApaSYDX1pbLbTa/BKf3mAqIvwUI
        v+BIRzsZwQeJMjS/Q01Pr60A6dWISbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694678891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/ecNnDz5zq7YMrO/wGOI+Yrvu8MsC3RqtEZg7CpzAM=;
        b=Fv6WEmj+HG5HKo9vjKsLPyeE94ke481HEVXYKrauseWBxcq4Ov02zl13ywJRyZL6ZLfhaG
        IuFuzeoj2CZPnlCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72EB813580;
        Thu, 14 Sep 2023 08:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1nsCHGu/AmVpIQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 14 Sep 2023 08:08:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0D158A07C2; Thu, 14 Sep 2023 10:08:11 +0200 (CEST)
Date:   Thu, 14 Sep 2023 10:08:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [BUG] KCSAN: data-race in xas_clear_mark / xas_find_marked
Message-ID: <20230914080811.465zw662sus4uznq@quack3>
References: <06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr>
 <ZN9iPYTmV5nSK2jo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN9iPYTmV5nSK2jo@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-08-23 13:21:17, Matthew Wilcox wrote:
> On Fri, Aug 18, 2023 at 10:01:32AM +0200, Mirsad Todorovac wrote:
> > [  206.510010] ==================================================================
> > [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
> > 
> > [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
> > [  206.510081]  xas_clear_mark+0xd5/0x180
> > [  206.510097]  __xa_clear_mark+0xd1/0x100
> > [  206.510114]  __folio_end_writeback+0x293/0x5a0
> > [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
> > [  206.520735]  xas_find_marked+0xe5/0x600
> > [  206.520750]  filemap_get_folios_tag+0xf9/0x3d0
> Also, before submitting this kind of report, you should run the
> trace through scripts/decode_stacktrace.sh to give us line numbers
> instead of hex offsets, which are useless to anyone who doesn't have
> your exact kernel build.
> 
> > [  206.510010] ==================================================================
> > [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
> > 
> > [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
> > [  206.510081] xas_clear_mark (./arch/x86/include/asm/bitops.h:178 ./include/asm-generic/bitops/instrumented-non-atomic.h:115 lib/xarray.c:102 lib/xarray.c:914)
> > [  206.510097] __xa_clear_mark (lib/xarray.c:1923)
> > [  206.510114] __folio_end_writeback (mm/page-writeback.c:2981)
> 
> This path is properly using xa_lock_irqsave() before calling
> __xa_clear_mark().
> 
> > [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
> > [  206.520735] xas_find_marked (./include/linux/xarray.h:1706 lib/xarray.c:1354)
> > [  206.520750] filemap_get_folios_tag (mm/filemap.c:1975 mm/filemap.c:2273)
> 
> This takes the RCU read lock before calling xas_find_marked() as it's
> supposed to.
> 
> What garbage do I have to write to tell KCSAN it's wrong?  The line
> that's probably triggering it is currently:
> 
>                         unsigned long data = *addr & (~0UL << offset);

I don't think it is actually wrong in this case. You're accessing xarray
only with RCU protection so it can be changing under your hands. For
example the code in xas_find_chunk():

                        unsigned long data = *addr & (~0UL << offset);
                        if (data)
                                return __ffs(data);

is prone to the compiler refetching 'data' from *addr after checking for
data != 0 and getting 0 the second time which would trigger undefined
behavior of __ffs(). So that code should definitely use READ_ONCE() to make
things safe.

BTW, find_next_bit() seems to need a similar treatment and in fact I'm not
sure why xas_find_chunk() has a special case for XA_CHUNK_SIZE ==
BITS_PER_LONG because find_next_bit() checks for that and handles that in a
fast path in the same way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
