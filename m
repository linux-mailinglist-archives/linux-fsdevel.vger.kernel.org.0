Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2800C7BD850
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 12:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbjJIKPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346061AbjJIKPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:15:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7D9F;
        Mon,  9 Oct 2023 03:15:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D093C210EA;
        Mon,  9 Oct 2023 10:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696846550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9aFHFIVYD+PckYoucQFFA7Q682WFJMhzaZvRQ/S9EPY=;
        b=gsQYRTEb0njWM9TpyXer3r9WyXV9IEVCnaR6yBLYDXzmPah64iYyEWy0schTQL56j382wU
        ebeI+dR4WlXBngIzleMTZ6eFCtrOhabfilROoT2ZMSGNUw7hTXLu57wireUa9RtvXxxSBk
        IXpMHR1y6fiWpE3v0Rh2Thpix3jr7T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696846550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9aFHFIVYD+PckYoucQFFA7Q682WFJMhzaZvRQ/S9EPY=;
        b=qGEvzez2mF/FkU4Ol42KQIlRTDDiii7TYnAWg2gFBLvMprviOvhVfjy0GNDwi4Ha8aMADD
        fayHZjqOhIiP06DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE1B413905;
        Mon,  9 Oct 2023 10:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b4xZLtbSI2WNeQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Oct 2023 10:15:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 29F17A04B2; Mon,  9 Oct 2023 12:15:50 +0200 (CEST)
Date:   Mon, 9 Oct 2023 12:15:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mirsad Todorovac <mirsad.todorovac@alu.hr>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Message-ID: <20231009101550.pqnkrp5cp5zbr3lr@quack3>
References: <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <ZQhlt/EbRf3Y+0jT@yury-ThinkPad>
 <20230918155403.ylhfdbscgw6yek6p@quack3>
 <cda628df-1933-cce8-86cd-23346541e3d8@alu.unizg.hr>
 <ZQidZLUcrrITd3Vy@yury-ThinkPad>
 <ZQkhgVb8nWGxpSPk@casper.infradead.org>
 <2c7f2acd-ef37-4504-a0e3-f74b66c455ec@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7f2acd-ef37-4504-a0e3-f74b66c455ec@alu.unizg.hr>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 06-10-23 16:39:54, Mirsad Todorovac wrote:
> On 9/19/2023 6:20 AM, Matthew Wilcox wrote:
> > On Mon, Sep 18, 2023 at 11:56:36AM -0700, Yury Norov wrote:
> > > Guys, I lost the track of the conversation. In the other email Mirsad
> > > said:
> > >          Which was the basic reason in the first place for all this, because something changed
> > >          data from underneath our fingers ..
> > > 
> > > It sounds clearly to me that this is a bug in xarray, *revealed* by
> > > find_next_bit() function. But later in discussion you're trying to 'fix'
> > > find_*_bit(), like if find_bit() corrupted the bitmap, but it's not.
> > 
> > No, you're really confused.  That happens.
> > 
> > KCSAN is looking for concurrency bugs.  That is, does another thread
> > mutate the data "while" we're reading it.  It does that by reading
> > the data, delaying for a few instructions and reading it again.  If it
> > changed, clearly there's a race.  That does not mean there's a bug!
> > 
> > Some races are innocuous.  Many races are innocuous!  The problem is
> > that compilers sometimes get overly clever and don't do the obvious
> > thing you ask them to do.  READ_ONCE() serves two functions here;
> > one is that it tells the compiler not to try anything fancy, and
> > the other is that it tells KCSAN to not bother instrumenting this
> > load; no load-delay-reload.
> > 
> > > In previous email Jan said:
> > >          for any sane compiler the generated assembly with & without READ_ONCE()
> > >          will be exactly the same.
> > > 
> > > If the code generated with and without READ_ONCE() is the same, the
> > > behavior would be the same, right? If you see the difference, the code
> > > should differ.
> > 
> > Hopefully now you understand why this argument is wrong ...
> > 
> > > You say that READ_ONCE() in find_bit() 'fixes' 200 KCSAN BUG warnings. To
> > > me it sounds like hiding the problems instead of fixing. If there's a race
> > > between writing and reading bitmaps, it should be fixed properly by
> > > adding an appropriate serialization mechanism. Shutting Kcsan up with
> > > READ_ONCE() here and there is exactly the opposite path to the right direction.
> > 
> > Counterpoint: generally bitmaps are modified with set_bit() which
> > actually is atomic.  We define so many bitmap things as being atomic
> > already, it doesn't feel like making find_bit() "must be protected"
> > as a useful use of time.
> > 
> > But hey, maybe I'm wrong.  Mirsad, can you send Yury the bug reports
> > for find_bit and friends, and Yury can take the time to dig through them
> > and see if there are any real races in that mess?
> > 
> > > Every READ_ONCE must be paired with WRITE_ONCE, just like atomic
> > > reads/writes or spin locks/unlocks. Having that in mind, adding
> > > READ_ONCE() in find_bit() requires adding it to every bitmap function
> > > out there. And this is, as I said before, would be an overhead for
> > > most users.
> > 
> > I don't believe you.  Telling the compiler to stop trying to be clever
> > rarely results in a performance loss.
> 
> Hi Mr. Wilcox,
> 
> Do you think we should submit a formal patch for this data-race?

So I did some benchmarking with various GCC versions and the truth is that
READ_ONCE() does affect code generation a bit (although the original code
does not refetch the value from memory). As a result my benchmarks show the
bit searching functions are about 2% slower. This is not much but it is
stupid to cause a performance regression due to non-issue. I'm trying to
get some compiler guys look into this whether we can improve it somehow...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
