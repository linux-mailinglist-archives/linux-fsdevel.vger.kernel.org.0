Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6718F62BB05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKPLKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 06:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiKPLKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:10:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C3C30F51
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:56:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6812E336F0;
        Wed, 16 Nov 2022 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668596170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbccDuTXZxM9IQCgaZWvupx+sDLs9qz6i7Z+ypkhAGg=;
        b=mcdg9IK3H5XioN1KcklFts13x6c86oLVLnvj9oDWmZUJ7Ee/YPgUhhGM2QYOH5+Dtn8AG6
        gUKpIDF3veADYksAZo/o96O9sUKTHKFiNPj54fWXMbf2ib2XEXcuiax9fjLmbB9+PjoD/g
        B3RYVhEdJlx9a32pV5PPmj8GHnaUskI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668596170;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbccDuTXZxM9IQCgaZWvupx+sDLs9qz6i7Z+ypkhAGg=;
        b=HxcTzRX9NzsbmX3jtvXWg7ckqt5UyJchw6IoOSuYlqmsXQckDwWZSqgH7sNXWEFMTAXAlR
        ftDvF96486OtHXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E7AC13480;
        Wed, 16 Nov 2022 10:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IEwgE8rBdGOgXgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Nov 2022 10:56:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D39FCA0709; Wed, 16 Nov 2022 11:56:09 +0100 (CET)
Date:   Wed, 16 Nov 2022 11:56:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221116105609.ctgh7qcdgtgorlls@quack3>
References: <20220922104823.z6465rfro7ataw2i@quack3>
 <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3>
 <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3>
 <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3>
 <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3>
 <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-11-22 15:08:17, Amir Goldstein wrote:
> On Tue, Nov 15, 2022 at 12:16 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 14-11-22 22:08:16, Amir Goldstein wrote:
> > > On Mon, Nov 14, 2022 at 9:17 PM Jan Kara <jack@suse.cz> wrote:
> > > > > My understanding is that
> > > > > synchronize_srcu(&fsnotify_mark_srcu);
> > > > > is needed as barrier between 3) and 4)
> > > > >
> > > > > In any case, even if CHECKPOINT_PENDING can work,
> > > > > with or without FAN_MARK_SYNC, to me personally, understanding
> > > > > the proof of correctness of alternating groups model is very easy,
> > > > > while proving correctness for CHECKPOINT_PENDING model is
> > > > > something that I was not yet able to accomplish.
> > > >
> > > > I agree the scheme with CHECKPOINT_PENDING isn't easy to reason about but I
> > > > don't find your scheme with two groups simpler ;) Let me try to write down
> > > > rationale for my scheme, I think I can even somewhat simplify it:
> > > >
> > > > Write operation consists of:
> > > > generate PRE_WRITE on F
> > > > modify data of F
> > > > generate POST_WRITE on F
> > > >
> > > > Checkpoint consists of:
> > > > clear ignore marks
> > > > report files for which we received PRE_WRITE or POST_WRITE until this
> > > > moment
> > > >
> > > > And the invariant we try to provide is: If file F was modified during
> > > > checkpoint T, then we report F as modified during T or some later
> > > > checkpoint. Where it is matter of quality of implementation that "some
> > > > later checkpoint" isn't too much later than T but it depends on the
> > > > frequency of checkpoints, the length of notification queue, etc. so it is
> > > > difficult to give hard guarantees.
> > > >
> > > > And the argument why the scheme maintains the invariant is that if
> > > > POST_WRITE is generated after "clear ignore marks" finishes, it will get
> > > > delivered and thus F will get reported as modified in some checkpoint once
> > > > the event is processed. If POST_WRITE gets generated before "clear ignore
> > > > marks" finishes and F is among ignored inodes, it means F is already in
> > > > modified set so it will get reported as part of checkpoint T. Also
> > > > application will already see modified data when processing list of modified
> > > > files in checkpoint T.
> > > >
> > > > Simple and we don't even need PRE_WRITE here. But maybe you wanted to
> > > > provide stronger invariant? Like "you are not able to see modified data
> > > > without seeing F as modified?" But what exactly would be a guarantee here?
> > > > I feel I'm missing something here but I cannot quite grasp it at this
> > > > moment...
> > > >
> > >
> > > This is the very basic guarantee that the persistent change tracking snapshots
> > > need to provide. If a crash happens after modification is done and before
> > > modification is recorded, we won't detect the modification after reboot.
> >
> > Right, crash safety was the point I was missing ;) Thanks for reminding me.
> > And now I also see why you use filesystem freezing - it is a way to make
> > things crash safe as otherwise it is difficult to guard against a race
> >
> > generate PRE_WRITE for F
> >                                 PRE_WRITE ignored because file is already
> >                                         modified
> >                                 checkpoint happens -> F reported as modified
> >                                   contents of F fetched
> >
> > modify data
> > transaction commit
> > <crash>
> >                                 POST_WRITE never seen so change to F is
> >                                   never reported
> >
> > I just think filesystem freezing is too big hammer for widespread use of
> > persistent change tracking.
> 
> Note that fsfreeze is also needed to flush dirty data after modify data,
> not only to wait for modify data transaction commit.
> 
> Otherwise the fetched contents of F will differ from contents of F
> after reboot even if we did wait for POST_WRITE.
> 
> However, in this case, file contents can be considered corrupted
> and rsync, for example, will not detect the change either, because
> mtime does match the previously fetched value.
> 
> As long as applications write files safely (with rename) fsfreeze is not
> needed, but for strict change tracking, fsfreeze is needed, so fsfreeze
> is a policy decision of HSM.

Yeah, I agree. It is a policy decision.

> > Can't we introduce some SRCU lock / unlock into
> > file_start_write() / file_end_write() and then invoke synchronize_srcu()
> > during checkpoint after removing ignore marks? It will be much cheaper as
> > we don't have to flush all dirty data to disk and also writes can keep
> > flowing while we wait for outstanding writes straddling checkpoint to
> > complete. What do you think?
> 
> Maybe, but this is not enough.
> Note that my patches [1] are overlapping fsnotify_mark_srcu with
> file_start_write(), so we would need to overlay fsnotify_mark_srcu
> with this new "modify SRCU".
> 
> [1] https://github.com/amir73il/linux/commits/fanotify_pre_content

Yes, I know that and frankly, that is what I find somewhat ugly :) I'd rather
have the "modify SRCU" cover the whole region we need - which means
including the generation of PRE_MODIFY event.

> > The checkpoint would then do:
> > start gathering changes for both T and T+1
> > clear ignore marks
> > synchronize_srcu()
> > stop gathering changes for T and report them
> >
> > And in this case we would not need POST_WRITE as an event.
> >
> 
> Why then give up on the POST_WRITE events idea?
> Don't you think it could work?

So as we are discussing, the POST_WRITE event is not useful when we want to
handle crash safety. And if we have some other mechanism (like SRCU) which
is able to guarantee crash safety, then what is the benefit of POST_WRITE?
I'm not against POST_WRITE, I just don't see much value in it if we have
another mechanism to deal with events straddling checkpoint.

> > The technical problem I see is how to deal with AIO / io_uring because
> > SRCU needs to be released in the same context as it is acquired - that
> > would need to be consulted with Paul McKenney if we can make it work. And
> > another problem I see is that it might not be great to have this
> > system-wide as e.g. on networking filesystems or pipes writes can block for
> > really long.
> >
> > Final question is how to expose this to userspace because this
> > functionality would seem useful outside of filesystem notification space so
> > probably do not need to tie it to that.
> >
> > Or we could simplify our life somewhat and acquire SRCU when generating
> > PRE_WRITE and drop it when generating POST_WRITE. This would keep SRCU
> > within fsnotify and would mitigate the problems coming from system-wide
> > SRCU. OTOH it will create problems when PRE_WRITE gets generated and
> > POST_WRITE would not for some reason. Just branstorming here, I've not
> > really decided what's better...
> >
> 
> What if checkpoint only acquired (and released) exclusive sb_writers without
> flushing dirty data.
> Wouldn't that be equivalent to the synchronize_srcu() you suggested?

In terms of guarantees it would be equivalent. In terms of impact on the
system it will be considerably worse. Because SRCU allows new SRCU readers
to start while synchronize_srcu() is running - so in our case new writes
can freely run while we are waiting for pending writes to complete. So
impact of the synchronize_srcu() on system activity will be practically
unnoticeable. If we use sb_writers as you suggest, it will block all write
activity until all writes finish. Which can be significant amount of time
if you have e.g. write(1 GB of data) running.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
