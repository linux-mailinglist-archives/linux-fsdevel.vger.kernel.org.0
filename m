Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD76359DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 11:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiKWK2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 05:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiKWK1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:27:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35451369FD
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 02:10:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D0761F8C8;
        Wed, 23 Nov 2022 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669198222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4e+dzwZ3x9zFj2YI8h+vzvy1KZEdTkqpvJGMwAviV8=;
        b=j5Q/4Ch6eZHkA2bnt7zIAFUjDspgFv45AkajyX86KB3Ec64WW2RgfcNMarRLlFEms+VBte
        QjcM0JGmoOqNghYczWs1XQWiGC28AyJxlakBGsIqkmv59axSdN1ATuF/8uF2GF6ehXoDL/
        19VXLd9pkkKjZIHZMD0FGJaHY8HmK3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669198222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4e+dzwZ3x9zFj2YI8h+vzvy1KZEdTkqpvJGMwAviV8=;
        b=MipA9On/SvxUIKKVvI4RrFw1sF/cfsNYVzQxZ53kBzNKXwvfUYQVznhDO7+6H7Hud9HyA1
        x9SEHUattfGn7VCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A19513AE7;
        Wed, 23 Nov 2022 10:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4w/DHY7xfWP4IwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Nov 2022 10:10:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F3AF3A0709; Wed, 23 Nov 2022 11:10:21 +0100 (CET)
Date:   Wed, 23 Nov 2022 11:10:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221123101021.7a65fgjop3d45ryq@quack3>
References: <20221103163045.fzl6netcffk23sxw@quack3>
 <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3>
 <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3>
 <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3>
 <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3>
 <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-11-22 18:24:06, Amir Goldstein wrote:
> > > Why then give up on the POST_WRITE events idea?
> > > Don't you think it could work?
> >
> > So as we are discussing, the POST_WRITE event is not useful when we want to
> > handle crash safety. And if we have some other mechanism (like SRCU) which
> > is able to guarantee crash safety, then what is the benefit of POST_WRITE?
> > I'm not against POST_WRITE, I just don't see much value in it if we have
> > another mechanism to deal with events straddling checkpoint.
> >
> 
> Not sure I follow.
> 
> I think that crash safety can be achieved also with PRE/POST_WRITE:
> - PRE_WRITE records an intent to write in persistent snapshot T
>   and add to in-memory map of in-progress writes of period T
> - When "checkpoint T" starts, new PRE_WRITES are recorded in both
>   T and T+1 persistent snapshots, but event is added only to
>   in-memory map of in-progress writes of period T+1
> - "checkpoint T" ends when all in-progress writes of T are completed

So maybe I miss something but suppose the situation I was mentioning few
emails earlier:

PRE_WRITE for F			-> F recorded as modified in T
modify F
POST_WRITE for F

PRE_WRITE for F			-> ignored because F is already marked as
				   modified

				-> checkpoint T requested, modified files
				   reported, process modified files
modify F
--------- crash

Now unless filesystem freeze or SRCU is part of checkpoint, we will never
notify about the last modification to F. So I don't see how PRE +
POST_WRITE alone can achieve crash safety...

And if we use filesystem freeze or SRCU as part of checkpoint, then
processing of POST_WRITE events does not give us anything new. E.g.
synchronize_srcu() during checkpoing before handing out list of modified
files makes sure all modifications to files for which PRE_MODIFY events
were generated (and thus are listed as modified in checkpoint T) are
visible for userspace.

So am I missing some case where POST_WRITE would be more useful than SRCU?
Because at this point I'd rather implement SRCU than POST_WRITE.

> The trick with alternating snapshots "handover" is this
> (perhaps I never explained it and I need to elaborate on the wiki [1]):
> 
> [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#Modified_files_query
> 
> The changed files query results need to include recorded changes in both
> "finalizing" snapshot T and the new snapshot T+1 that was started in
> the beginning of the query.
> 
> Snapshot T MUST NOT be discarded until checkpoint/handover
> is complete AND the query results that contain changes recorded
> in T and T+1 snapshots have been consumed.
> 
> When the consumer ACKs that the query results have been safely stored
> or acted upon (I called this operation "bless" snapshot T+1) then and
> only then can snapshot T be discarded.
> 
> After snapshot T is discarded a new query will start snapshot T+2.
> A changed files query result includes the id of the last blessed snapshot.
> 
> I think this is more or less equivalent to the SRCU that you suggested,
> but all the work is done in userspace at application level.
> 
> If you see any problem with this scheme or don't understand it
> please let me know and I will try to explain better.

So until now I was imagining that query results will be returned like a one
big memcpy. I.e. one off event where the "persistent log daemon" hands over
the whole contents of checkpoint T to the client. Whatever happens with the
returned data is the bussiness of the client, whatever happens with the
checkpoint T records in the daemon is the daemon's bussiness. The model you
seem to speak about here is somewhat different - more like readdir() kind
of approach where client asks for access to checkpoint T data, daemon
provides the data record by record (probably serving the data from its
files on disk), and when the client is done and "closes" checkpoint T,
daemon's records about checkpoint T can be erased. Am I getting it right?

This however seems somewhat orthogonal to the SRCU idea. SRCU essentially
serves the only purpose - make sure that modifications to all files for
which we have received PRE_WRITE event are visible in respective files.

> > > > The technical problem I see is how to deal with AIO / io_uring because
> > > > SRCU needs to be released in the same context as it is acquired - that
> > > > would need to be consulted with Paul McKenney if we can make it work. And
> > > > another problem I see is that it might not be great to have this
> > > > system-wide as e.g. on networking filesystems or pipes writes can block for
> > > > really long.
> > > >
> > > > Final question is how to expose this to userspace because this
> > > > functionality would seem useful outside of filesystem notification space so
> > > > probably do not need to tie it to that.
> > > >
> > > > Or we could simplify our life somewhat and acquire SRCU when generating
> > > > PRE_WRITE and drop it when generating POST_WRITE. This would keep SRCU
> > > > within fsnotify and would mitigate the problems coming from system-wide
> > > > SRCU. OTOH it will create problems when PRE_WRITE gets generated and
> > > > POST_WRITE would not for some reason. Just branstorming here, I've not
> > > > really decided what's better...
> 
> Seems there are several non trivial challenges to surmount with this
> "userspace modification SRCU" idea.
> 
> For now, I will stay in my comfort zone and try to make the POC
> with PRE/POST_WRITE work and write the proof of correctness.
> 
> I will have no objection at all if you figure out how to solve those
> issues and guide me to a path for implementing sb_write_srcu.
> It will make the userspace implementation much simpler, getting rid
> of the in-progress writes in-memory tracking.

It seems you have progressed on this front yourself so let's continue there
:).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
