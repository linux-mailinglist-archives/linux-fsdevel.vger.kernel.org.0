Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B87A4DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjIRQAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRQAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:00:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C52FE;
        Mon, 18 Sep 2023 08:57:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC00F21E21;
        Mon, 18 Sep 2023 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695052444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BO0o7mc51KvupjydrTvNuZTowoiGCihD2MFz1LzYzPM=;
        b=hPyVo6xQ/5JYBEGBWzgWV1gR7wcLXkl8skxnWsiADUcukIRsswrZlRp4H7Q2rp2y0rLPYf
        hy20KmHGuedlI5a1O1IQkctlT7ysTSghj1lN6N9TCyvl3PQFNq2gUlUhgXbfpMRUYal5O4
        vIbr/uLGwth4ZwbOXcZgs+b2058Z0rI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695052444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BO0o7mc51KvupjydrTvNuZTowoiGCihD2MFz1LzYzPM=;
        b=K/YCBDd4H1NBX1EBhbtAbx3l0jAwQCKJS6k+0RRGk+UHsy/dvQVFn9Xz60jhP24bmToRnW
        /NBs6u4t2V4yr2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A966A13480;
        Mon, 18 Sep 2023 15:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id llpRKZxyCGWsaQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 15:54:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EF583A0759; Mon, 18 Sep 2023 17:54:03 +0200 (CEST)
Date:   Mon, 18 Sep 2023 17:54:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Message-ID: <20230918155403.ylhfdbscgw6yek6p@quack3>
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <ZQhlt/EbRf3Y+0jT@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhlt/EbRf3Y+0jT@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-09-23 07:59:03, Yury Norov wrote:
> On Mon, Sep 18, 2023 at 02:46:02PM +0200, Mirsad Todorovac wrote:
> > --------------------------------------------------------
> >  lib/find_bit.c | 33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> > 
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index 32f99e9a670e..56244e4f744e 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/math.h>
> >  #include <linux/minmax.h>
> >  #include <linux/swab.h>
> > +#include <asm/rwonce.h>
> >  /*
> >   * Common helper for find_bit() function family
> > @@ -98,7 +99,7 @@ out:                                                                          \
> >   */
> >  unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
> >  {
> > -       return FIND_FIRST_BIT(addr[idx], /* nop */, size);
> > +       return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
> >  }
> >  EXPORT_SYMBOL(_find_first_bit);
> >  #endif
> 
> ...
> 
> That doesn't look correct. READ_ONCE() implies that there's another
> thread modifying the bitmap concurrently. This is not the true for
> vast majority of bitmap API users, and I expect that forcing
> READ_ONCE() would affect performance for them.
> 
> Bitmap functions, with a few rare exceptions like set_bit(), are not
> thread-safe and require users to perform locking/synchronization where
> needed.

Well, for xarray the write side is synchronized with a spinlock but the read
side is not (only RCU protected).

> If you really need READ_ONCE, I think it's better to implement a new
> flavor of the function(s) separately, like:
>         find_first_bit_read_once()

So yes, xarray really needs READ_ONCE(). And I don't think READ_ONCE()
imposes any real perfomance overhead in this particular case because for
any sane compiler the generated assembly with & without READ_ONCE() will be
exactly the same. For example I've checked disassembly of _find_next_bit()
using READ_ONCE(). The main loop is:

   0xffffffff815a2b6d <+77>:	inc    %r8
   0xffffffff815a2b70 <+80>:	add    $0x8,%rdx
   0xffffffff815a2b74 <+84>:	mov    %r8,%rcx
   0xffffffff815a2b77 <+87>:	shl    $0x6,%rcx
   0xffffffff815a2b7b <+91>:	cmp    %rcx,%rax
   0xffffffff815a2b7e <+94>:	jbe    0xffffffff815a2b9b <_find_next_bit+123>
   0xffffffff815a2b80 <+96>:	mov    (%rdx),%rcx
   0xffffffff815a2b83 <+99>:	test   %rcx,%rcx
   0xffffffff815a2b86 <+102>:	je     0xffffffff815a2b6d <_find_next_bit+77>
   0xffffffff815a2b88 <+104>:	shl    $0x6,%r8
   0xffffffff815a2b8c <+108>:	tzcnt  %rcx,%rcx

So you can see the value we work with is copied from the address (rdx) into
a register (rcx) and the test and __ffs() happens on a register value and
thus READ_ONCE() has no practical effect. It just prevents the compiler
from doing some stupid de-optimization.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
