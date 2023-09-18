Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0915D7A4CCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjIRPlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIRPlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:41:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C24CE9;
        Mon, 18 Sep 2023 08:37:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A4B751FF30;
        Mon, 18 Sep 2023 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695046643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CzilwYZQ4Jc72fuQtoAbSWLiLUf2pcHd4c41aRTXJU=;
        b=gTXIPXVMhLb/LF0YpGzOEeYsjv3Lr4csi2hL+oimZIQeoP/z/KNsoN4Q+twIQap9MQqtz7
        1kIpKIRSQ2uelNAqCffvG59ryNJKmtfUNrqeJ2urH7KUse2lSQm/l2hrtCXPyjMqgLp4/n
        E0x8wazKcKNGeEbqXV6JA8ZvOsR3fGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695046643;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CzilwYZQ4Jc72fuQtoAbSWLiLUf2pcHd4c41aRTXJU=;
        b=Uhf3JhdM3e4goIwB0O9dO8JBxhx30tZalcAOWCg446Jw47oyqFKtY/1e0P0ztDVAQFLsL2
        nra2CSmQGKJNcDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8580B13480;
        Mon, 18 Sep 2023 14:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c2yRIPNbCGUDMgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 14:17:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9362BA0759; Mon, 18 Sep 2023 16:17:22 +0200 (CEST)
Date:   Mon, 18 Sep 2023 16:17:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Message-ID: <20230918141722.gasntomhkkp2fwy2@quack3>
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <20230918131815.otjqgu3zhigsst64@quack3>
 <c50b5eb4-afcd-d810-4411-c43e373a5a95@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50b5eb4-afcd-d810-4411-c43e373a5a95@alu.unizg.hr>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-09-23 15:34:46, Mirsad Todorovac wrote:
> On 9/18/23 15:18, Jan Kara wrote:
> > On Mon 18-09-23 14:46:02, Mirsad Todorovac wrote:
> > > Hi,
> > > 
> > > I tried this patch and the
> > > 
> > > > >    95 _find_first_and_bit (lib/find_bit.c:114 (discriminator 10))
> > > > >    31 _find_first_zero_bit (lib/find_bit.c:125 (discriminator 10))
> > > > > 173 _find_next_and_bit (lib/find_bit.c:171 (discriminator 2))
> > > > > 655 _find_next_bit (lib/find_bit.c:133 (discriminator 2))
> > > > >     5 _find_next_zero_bit
> > > 
> > > data-races do not seem to appear any longer.
> > 
> > Yup. You've just missed one case in _find_last_bit() and then all the
> > functions in include/linux/find.h need a similar treatment...
> 
> I seem to have this:
> 
> -----------------------------------------------------------------------------------
> #ifndef find_last_bit
> unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
> {
>         if (size) {
>                 unsigned long val = BITMAP_LAST_WORD_MASK(size);
>                 unsigned long idx = (size-1) / BITS_PER_LONG;
> 
>                 do {
>                         val &= READ_ONCE(addr[idx]);
>                         if (val)
>                                 return idx * BITS_PER_LONG + __fls(val);
> 
>                         val = ~0ul;
>                 } while (idx--);
>         }
>         return size;
> }
> EXPORT_SYMBOL(_find_last_bit);
> #endif
> -----------------------------------------------------------------------------------
> 
> Is there something I did not notice?

No, this looks correct. I just somehow didn't see this hunk in the diff
you've posted.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
