Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB77107DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbjEYIrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 04:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjEYIre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 04:47:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD789E;
        Thu, 25 May 2023 01:47:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C360B21CA3;
        Thu, 25 May 2023 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685004451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuhUxhJ4qXqlC8S61jGgkZ/rePw29whTgtvzHY6sSiI=;
        b=ZrusZYsCefuMnAVLQhgd8aBN2vNvwAyrM1z1cZn9oRunL0M8JfFy92IqTRXhxJg9dyQ+3V
        Q8yHLX3wYbtbH0HYQWtQlKL9UMpQKxyFX1cHfV97/XUUa9mdp5HlUf7zSKu6aMJI3TC4fN
        /g6oWielTzMSNQo/9YenUVIHEIU6Zp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685004451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuhUxhJ4qXqlC8S61jGgkZ/rePw29whTgtvzHY6sSiI=;
        b=XdzjVSs3+TjUoFyH5X//zoHI1wt48WjIl65701RGoFiCfws+iTsL1D3tjnaB6pIYnjG35e
        Nerxvu9ESp34vGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1FAA13356;
        Thu, 25 May 2023 08:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mxRrK6Mgb2TyRAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 08:47:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 36009A075C; Thu, 25 May 2023 10:47:31 +0200 (CEST)
Date:   Thu, 25 May 2023 10:47:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>, dhowells@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
Message-ID: <20230525084731.losrlnarpbqtqzil@quack3>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzugpw7vgCFxOYL@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzugpw7vgCFxOYL@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-05-23 12:49:06, Kent Overstreet wrote:
> > > No, that's definitely handled (and you can see it in the code I linked),
> > > and I wrote a torture test for fstests as well.
> > 
> > I've checked the code and AFAICT it is all indeed handled. BTW, I've now
> > remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
> > ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
> > way (by prefaulting pages from the iter before grabbing the problematic
> > lock and then disabling page faults for the iomap_dio_rw() call). I guess
> > we should somehow unify these schemes so that we don't have two mechanisms
> > for avoiding exactly the same deadlock. Adding GFS2 guys to CC.
> 
> Oof, that sounds a bit sketchy. What happens if the dio call passes in
> an address from the same address space?

If we submit direct IO that uses mapped file F at offset O as a buffer for
direct IO from file F, offset O, it will currently livelock in an
indefinite retry loop. It should rather return error or fall back to
buffered IO. But that should be fixable. Andreas?

But if the buffer and direct IO range does not overlap, it will just
happily work - iomap_dio_rw() invalidates only the range direct IO is done
to.

> What happens if we race with the pages we faulted in being evicted?

We fault them in again and retry.

> > Also good that you've written a fstest for this, that is definitely a useful
> > addition, although I suspect GFS2 guys added a test for this not so long
> > ago when testing their stuff. Maybe they have a pointer handy?
> 
> More tests more good.
> 
> So if we want to lift this scheme to the VFS layer, we'd start by
> replacing the lock you added (grepping for it, the name escapes me) with
> a different type of lock - two_state_shared_lock in my code, it's like a
> rw lock except writers don't exclude other writers. That way the DIO
> path can use it without singlethreading writes to a single file.

Yes, I've noticed that you are introducing in bcachefs a lock with very
similar semantics to mapping->invalidate_lock, just with this special lock
type. What I'm kind of worried about with two_state_shared_lock as
implemented in bcachefs is the fairness. AFAICS so far if someone is e.g.
heavily faulting pages on a file, direct IO to that file can be starved
indefinitely. That is IMHO not a good thing and I would not like to use
this type of lock in VFS until this problem is resolved. But it should be
fixable e.g. by introducing some kind of deadline for a waiter after which
it will block acquisitions of the other lock state.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
