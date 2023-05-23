Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3A70DD87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjEWNel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 09:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjEWNel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 09:34:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75BCA;
        Tue, 23 May 2023 06:34:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6248D222CC;
        Tue, 23 May 2023 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684848875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xe6yJPZ6RPA0ddH1QOG2qkfGCUr/gLKEvN1ZtXb/JI8=;
        b=XP37/bRndMC53jggGxEC6euD49IR80aHGZvpZuFSXmXe0vbqOSQMJxBfvsMMdQNzmUix3I
        lxtlqKHVO+Nt/cTZs6F0YhpjoNlmC5vL+qyJRsbLdUcZl2OKJwry1MBxSkYlOrYw8k+/RR
        1CJR//ei+eFbNqehI1vHQgoP01UXPN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684848875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xe6yJPZ6RPA0ddH1QOG2qkfGCUr/gLKEvN1ZtXb/JI8=;
        b=qa8Pp5VzopK/PeD9/dI4u95gxfnTLuxhTK8mhWpv4ivhwrPRzfRgKHgAFptKpeywe7m/nz
        0JaxMfKO0XFUlQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35F8B13A10;
        Tue, 23 May 2023 13:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mYAoDevAbGTfSQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 13:34:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 98FC1A075D; Tue, 23 May 2023 15:34:31 +0200 (CEST)
Date:   Tue, 23 May 2023 15:34:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>, dhowells@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
Message-ID: <20230523133431.wwrkjtptu6vqqh5e@quack3>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFs3RYgdCeKjxYCw@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-05-23 02:18:45, Kent Overstreet wrote:
> On Wed, May 10, 2023 at 03:07:37AM +0200, Jan Kara wrote:
> > On Tue 09-05-23 12:56:31, Kent Overstreet wrote:
> > > From: Kent Overstreet <kent.overstreet@gmail.com>
> > > 
> > > This is used by bcachefs to fix a page cache coherency issue with
> > > O_DIRECT writes.
> > > 
> > > Also relevant: mapping->invalidate_lock, see below.
> > > 
> > > O_DIRECT writes (and other filesystem operations that modify file data
> > > while bypassing the page cache) need to shoot down ranges of the page
> > > cache - and additionally, need locking to prevent those pages from
> > > pulled back in.
> > > 
> > > But O_DIRECT writes invoke the page fault handler (via get_user_pages),
> > > and the page fault handler will need to take that same lock - this is a
> > > classic recursive deadlock if userspace has mmaped the file they're DIO
> > > writing to and uses those pages for the buffer to write from, and it's a
> > > lock ordering deadlock in general.
> > > 
> > > Thus we need a way to signal from the dio code to the page fault handler
> > > when we already are holding the pagecache add lock on an address space -
> > > this patch just adds a member to task_struct for this purpose. For now
> > > only bcachefs is implementing this locking, though it may be moved out
> > > of bcachefs and made available to other filesystems in the future.
> > 
> > It would be nice to have at least a link to the code that's actually using
> > the field you are adding.
> 
> Bit of a trick to link to a _later_ patch in the series from a commit
> message, but...
> 
> https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs-io.c#n975
> https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs-io.c#n2454

Thanks and I'm sorry for the delay.

> > Also I think we were already through this discussion [1] and we ended up
> > agreeing that your scheme actually solves only the AA deadlock but a
> > malicious userspace can easily create AB BA deadlock by running direct IO
> > to file A using mapped file B as a buffer *and* direct IO to file B using
> > mapped file A as a buffer.
> 
> No, that's definitely handled (and you can see it in the code I linked),
> and I wrote a torture test for fstests as well.

I've checked the code and AFAICT it is all indeed handled. BTW, I've now
remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
way (by prefaulting pages from the iter before grabbing the problematic
lock and then disabling page faults for the iomap_dio_rw() call). I guess
we should somehow unify these schemes so that we don't have two mechanisms
for avoiding exactly the same deadlock. Adding GFS2 guys to CC.

Also good that you've written a fstest for this, that is definitely a useful
addition, although I suspect GFS2 guys added a test for this not so long
ago when testing their stuff. Maybe they have a pointer handy?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
