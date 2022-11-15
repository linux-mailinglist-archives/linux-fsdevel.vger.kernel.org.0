Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560F9629589
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 11:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKOKQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 05:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKOKQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:16:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D4E30B
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 02:16:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B30D1F8BB;
        Tue, 15 Nov 2022 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668507376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUFgYVbqgLfGoCKbqHXopdOkeaiFbQMvFI2mSL0Bweo=;
        b=QxQtu4WlPCajTi553nYxNdOmZWEqrYvixRE1+KbAkN7Ai64Hceij4AqUAA24T5Sn4K8i56
        VO695tu1IKM9GtahDRO6Sk70MNEvfdnEi9yUtKOBeKXpDMU7tn3jS5B3cLDAnrKWfWdHDg
        n9jdxgBn51jPgLSNFThzUi77jzx461k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668507376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUFgYVbqgLfGoCKbqHXopdOkeaiFbQMvFI2mSL0Bweo=;
        b=BzQP1pWj8uftv1hZ0BgPLxwG6CkTDS2NyIZ4O1qWzIhoqoVTb3/aAkHnzNxA35bywN1TQg
        eFcL/h2iTpl7nBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 277C813273;
        Tue, 15 Nov 2022 10:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1iydCfBmc2O9dwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 15 Nov 2022 10:16:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D809FA0709; Tue, 15 Nov 2022 11:16:14 +0100 (CET)
Date:   Tue, 15 Nov 2022 11:16:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221115101614.wuk2f4dhnjycndt6@quack3>
References: <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3>
 <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3>
 <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3>
 <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3>
 <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-11-22 22:08:16, Amir Goldstein wrote:
> On Mon, Nov 14, 2022 at 9:17 PM Jan Kara <jack@suse.cz> wrote:
> > > My understanding is that
> > > synchronize_srcu(&fsnotify_mark_srcu);
> > > is needed as barrier between 3) and 4)
> > >
> > > In any case, even if CHECKPOINT_PENDING can work,
> > > with or without FAN_MARK_SYNC, to me personally, understanding
> > > the proof of correctness of alternating groups model is very easy,
> > > while proving correctness for CHECKPOINT_PENDING model is
> > > something that I was not yet able to accomplish.
> >
> > I agree the scheme with CHECKPOINT_PENDING isn't easy to reason about but I
> > don't find your scheme with two groups simpler ;) Let me try to write down
> > rationale for my scheme, I think I can even somewhat simplify it:
> >
> > Write operation consists of:
> > generate PRE_WRITE on F
> > modify data of F
> > generate POST_WRITE on F
> >
> > Checkpoint consists of:
> > clear ignore marks
> > report files for which we received PRE_WRITE or POST_WRITE until this
> > moment
> >
> > And the invariant we try to provide is: If file F was modified during
> > checkpoint T, then we report F as modified during T or some later
> > checkpoint. Where it is matter of quality of implementation that "some
> > later checkpoint" isn't too much later than T but it depends on the
> > frequency of checkpoints, the length of notification queue, etc. so it is
> > difficult to give hard guarantees.
> >
> > And the argument why the scheme maintains the invariant is that if
> > POST_WRITE is generated after "clear ignore marks" finishes, it will get
> > delivered and thus F will get reported as modified in some checkpoint once
> > the event is processed. If POST_WRITE gets generated before "clear ignore
> > marks" finishes and F is among ignored inodes, it means F is already in
> > modified set so it will get reported as part of checkpoint T. Also
> > application will already see modified data when processing list of modified
> > files in checkpoint T.
> >
> > Simple and we don't even need PRE_WRITE here. But maybe you wanted to
> > provide stronger invariant? Like "you are not able to see modified data
> > without seeing F as modified?" But what exactly would be a guarantee here?
> > I feel I'm missing something here but I cannot quite grasp it at this
> > moment...
> >
> 
> This is the very basic guarantee that the persistent change tracking snapshots
> need to provide. If a crash happens after modification is done and before
> modification is recorded, we won't detect the modification after reboot.

Right, crash safety was the point I was missing ;) Thanks for reminding me.
And now I also see why you use filesystem freezing - it is a way to make
things crash safe as otherwise it is difficult to guard against a race

generate PRE_WRITE for F
				PRE_WRITE ignored because file is already
					modified
				checkpoint happens -> F reported as modified
				  contents of F fetched

modify data
transaction commit
<crash>
				POST_WRITE never seen so change to F is
				  never reported

I just think filesystem freezing is too big hammer for widespread use of
persistent change tracking. Can't we introduce some SRCU lock / unlock into
file_start_write() / file_end_write() and then invoke synchronize_srcu()
during checkpoint after removing ignore marks? It will be much cheaper as
we don't have to flush all dirty data to disk and also writes can keep
flowing while we wait for outstanding writes straddling checkpoint to
complete. What do you think?

The checkpoint would then do:
start gathering changes for both T and T+1
clear ignore marks
synchronize_srcu()
stop gathering changes for T and report them

And in this case we would not need POST_WRITE as an event.

The technical problem I see is how to deal with AIO / io_uring because
SRCU needs to be released in the same context as it is acquired - that
would need to be consulted with Paul McKenney if we can make it work. And
another problem I see is that it might not be great to have this
system-wide as e.g. on networking filesystems or pipes writes can block for
really long.

Final question is how to expose this to userspace because this
functionality would seem useful outside of filesystem notification space so
probably do not need to tie it to that.

Or we could simplify our life somewhat and acquire SRCU when generating
PRE_WRITE and drop it when generating POST_WRITE. This would keep SRCU
within fsnotify and would mitigate the problems coming from system-wide
SRCU. OTOH it will create problems when PRE_WRITE gets generated and
POST_WRITE would not for some reason. Just branstorming here, I've not
really decided what's better...

> Maybe "checkpoint" was a bad name to use for this handover between
> two subsequent change tracking snapshots.

I'm getting used to the terminology :) But to me it still seems more
natural to look at the situation as a single stream of events where we fetch
bulks of changes at certain moments, rather than looking at it as certain
entities collecting events for different time intervals.

> > > > > I am going to try to implement the PRE/POST_WRITE events and for
> > > > > POC I may start with a single group because it may be easier or I may
> > > > > implement both schemes, we'll see.
> > > >
> > > > That would be great. Thank you. Perhaps I'm missing something in my mental
> > > > model which would make things impractical :)
> > > >
> > >
> > > Me too. I won't know before I try.
> > >
> > > FYI, at the moment I am considering not allowing independent
> > > subscription for PRE/POST_XXX events, but only subscribe to
> > > XXX events and a group with class FAN_CLASS_VFS_FILTER
> > > will get both PRE/POST_XXX and won't be able to subscribe
> > > to XXX events that do not have PRE_XXX events.
> > >
> > > The rationale is that if a group subscribes to either PRE/POST_XXX
> > > XXX() operation is not going to be on the fast path anyway.
> > >
> > > This will make it easier to support more PRE/POST_XXX events
> > > without using up all the remaining 32bits namespace.
> > >
> > > Using the high 32bits of mask for PRE events and folding them
> > > in the object interest mask with the low 32bit is another thing
> > > that I was considering in case you would prefer to allow
> > > independent subscription for PRE/POST_XXX events.
> >
> > So one question: Do you see anything else than POST_WRITE as being useful?
> > For directory operations it seems pointless as they hold i_rwsem exclusively
> > so I don't see useful distinction between PRE and POST event. For OPEN and
> > CLOSE I don't see use either. ACCESS might be the only one where PRE and
> > POST would both be useful for something.
> 
> PRE_ACCESS is used to populate missing data and POST_ACCESS
> is irrelevant for that.
> 
> PRE_MODIFY is used for something completely different, it is used
> for the persistent change tracking and this has to be crash safe, so
> exclusive i_rwsem has nothing to do with it.
> 
> PRE_MODIFY is called before i_rwsem and before sb_start_write()
> so that HSM can record the change intent in the same filesystem
> that the change is going to happen (this is a journaled record).
> 
> I feel I may have not explained this correctly.
> Does this make sense?

Yes, makes sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
