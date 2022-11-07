Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1661F190
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 12:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiKGLLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 06:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiKGLKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:10:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE0B6343
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 03:10:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D12F21CE4;
        Mon,  7 Nov 2022 11:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667819409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gWCXNO+2FFP05IqWbjEIxFF2Y5RXkoolt2Eo4qyaEYI=;
        b=PB8ngg4l5LD7XIc0i2Sp7PZmSe1PdRqdxisiGMcfqy/3Um/d9yx8Mo5tQg+cRfAm0Fjk6T
        21LC1H1XfDW4azPTOZb+P6p8dy3IBsgbVZYzXF8FmN64t9XYuIJJtEwn13kWLy7GmtxYhi
        XKwoiqjVjyDaqMgf3ktwTBFESxghst0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667819409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gWCXNO+2FFP05IqWbjEIxFF2Y5RXkoolt2Eo4qyaEYI=;
        b=+p+IHbNoUJ0z3Rag7AO1zk8yUqOAwXoGqiWrnMmPp8PILB9Ww7ub7ingJpUZmyMUPlypEJ
        zeADUjWvJooxu/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6961F13494;
        Mon,  7 Nov 2022 11:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wqa1GZHnaGPLCQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 11:10:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F2EF8A0704; Mon,  7 Nov 2022 12:10:08 +0100 (CET)
Date:   Mon, 7 Nov 2022 12:10:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221107111008.wt4s4hjumxzl5kqj@quack3>
References: <20220912125734.wpcw3udsqri4juuh@quack3>
 <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3>
 <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3>
 <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3>
 <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 04-11-22 10:17:54, Amir Goldstein wrote:
> On Thu, Nov 3, 2022 at 6:30 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 28-10-22 15:50:04, Amir Goldstein wrote:
> > > On Thu, Sep 22, 2022 at 1:48 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > > Questions:
> > > > > - What do you think about the direction this POC has taken so far?
> > > > > - Is there anything specific that you would like to see in the POC
> > > > >   to be convinced that this API will be useful?
> > > >
> > > > I think your POC is taking a good direction and your discussion with Dave
> > > > had made me more confident that this is all workable :). I liked your idea
> > > > of the wiki (or whatever form of documentation) that summarizes what we've
> > > > discussed in this thread. That would be actually pretty nice for future
> > > > reference.
> > > >
> > >
> > > The current state of POC is that "populate of access" of both files
> > > and directories is working and "race free evict of file content" is also
> > > implemented (safely AFAIK).
> > >
> > > The technique involving exclusive write lease is discussed at [1].
> > > In a nutshell, populate and evict synchronize on atomic i_writecount
> > > and this technique can be implemented with upstream UAPIs.
> >
> > Not so much i_writecount AFAIU but the generic lease mechanism overall. But
> > yes, the currently existing APIs should be enough for your purposes.
> >
> 
> Right. Do note that the write lease is not reliable enough by itself
> to provide exclusive access to the content, because:
> 1. The lease break signal is delivered asynchronously to content evict
>     program
> 2. After the lease break timeout expires, reader will get access
>     to the content even if content eviction is in progress
> 
> The actual strong exclusive access is provided by the sequence:
> 1. Open file for write
> 2. Deny future FAN_OPEN_PERM
> 3. Take write lease, but just to verify that i_writecount == 1
> 
> Notice one thing odd is that in do_dentry_open() the sequence is:
> 1. increment i_writecount
> 2. security_file_open() => FAN_OPEN_PERM
> 3. break_lease()
> 
> However, FAN_OPEN_PERM is blocking and when listener
> reads the event, you get to:
> created_fd() => ... do_dentry_open(f_mode=FMODE_NONOTIFY):
> 4. may increment i_writecount
> 5. security_file_open() => FAN_OPEN_PERM skipped
> 6. break_lease() => send lease break signal
> 
> The result is a bit non intuitive:
> 
> If a new open is attempted during content evict, the new open will be
> blocked for the lease timeout, before the listener even gets a chance
> to respond.
>
> But if lease timeout has expired and the event listener denied the open,
> the lease break signal will still be delivered to the content evict program,
> despite the fact that the open is not going to proceed.

I see. I'd just note that allowing FID mode for permission events would
solve both these problems, won't it?

> > > I did use persistent xattr marks for the POC, but this is not a must.
> > > Evictable inode marks would have worked just as well.
> >
> > OK.
> >
> > > Now I have started to work on persistent change tracking.
> > > For this, I have only kernel code, only lightly tested, but I did not
> > > prove yet that the technique is working.
> > >
> > > The idea that I started to sketch at [2] is to alternate between two groups.
> > >
> > > When a change is recorded, an evictable ignore mark will be added on the
> > > object.  To start recording changes from a new point in time
> > > (checkpoint), a new group will be created (with no ignore marks) and the
> > > old group will be closed.
> >
> > So what I dislike about the scheme with handover between two groups is that
> > it is somewhat complex and furthermore requiring fs freezing for checkpoint
> > is going to be rather expensive (and may be problematic if persistent
> > change tracking is used by potentially many unpriviledged applications).
> >
> > As a side note I think it will be quite useful to be able to request
> > checkpoint only for a subtree (e.g. some app may be interested only in a
> > particular subtree) and the scheme with two groups will make any
> > optimizations to benefit from such fact more difficult - either we create
> > new group without ignore marks and then have to re-record changes nobody
> > actually needs or we have to duplicate ignore marks which is potentially
> > expensive as well.
> >
> 
> For the records, checkpoint of a subtree is already requested by
> git-fsmonitor hook and already implemented using inotify recursive
> watches and in-memory change tracking by watchman and soon
> to be implemented as a git built-in fsmonitor [1].
> 
> The known caveats are the need to do a "full crawl" after fsmonitor
> service start or after event queue overflow and pinning of too many
> inodes to cache.
> 
> Should we implement a systemd-fsmonitor service to serve
> git-fsmonitor hooks of all the users in the system, it will solve the
> scalability issue of recursive inode marks by using fanotify
> filesystem marks.
> 
> It is understandable that one would expect the fsmonitor system
> service checkpoints to align with the local user checkpoints (i.e. git status).
> But this doesn't have to be this way.
> 
> Imagine that the system change tracking service takes only
> nightly persistent checkpoints with fsfreeze regardless of the
> users git fsmonitor queries.
> 
> The service can continue to use async events and in-memory
> change tracking to provide accurate subtree change queries,
> but in case of overflow/restart, instead of falling back to "full crawl",
> the queries will fall back to "changes since last persistent checkpoint".
> 
> For some of our customers "full crawl" can take weeks.
> We have been using this scheme to address scalability of "full crawl"
> since the first version of Overlayfs snapshots in 2017.
> 
> So our customers incur a maintenance penalty of fsfreeze during
> idle times (weekly by default) and in return, the worst case time for
> changed files query was reduced from weeks to minutes.
> It's all about making the right trade offs ;-)
> 
> [1] https://lore.kernel.org/all/pull.1352.git.git.1665326258.gitgitgadget@gmail.com/

Right. I just suspect that with systemd-fsmonitor when more applications
start using it, it will be more difficult to tune this as e.g. for
git-status I can imagine daily snapshots will not be that much useful (not
save that much time) and users would rather see something like hourly
snapshots or even more frequent at which point things become somewhat
inconvenient and performance heavy.  

So we don't have to implement this now but I'd prefer we keep this as a
possibilty for future API extension...

> > Let's think about the race:
> >
> > > To clarify, the race that I am trying to avoid is:
> > > 1. group B got a pre modify event and recorded the change before time T
> > > 2. The actual modification is performed after time T
> > > 3. group A does not get a pre modify event, so does not record the change
> > >     in the checkpoint since T
> >
> > AFAIU you are worried about:
> >
> > Task T                          Change journal          App
> >
> > write(file)
> >   generate pre_modify event
> >                                 record 'file' as modified
> >                                                         Request changes
> >                                                         Records 'file' contents
> >   modify 'file' data
> >
> > ...
> >                                                         Request changes
> >                                                         Nothing changed but
> > App's view of 'file' is obsolete.
> >
> > Can't we solve this by creating POST_WRITE async event and then use it like:
> >
> 
> I like the idea of using POST_WRITE instead of holding sb_writers.
> 
> > 1) Set state to CHECKPOINT_PENDING
> > 2) In state CHECKPOINT_PENDING we record all received modify events into a
> >    separate 'transition' stream.
> > 3) Remove ignore marks we need to remove.
> 
> Our customer use cases may have many millions of dirs.
> I don't think this solution will be scalable, which is why I use the
> alternating groups to invalidate all the existing ignore marks at once.

I see. Well, we could also extend FAN_MARK_FLUSH so that you can just
remove all ignore marks from a group so that you don't have to remove them
one-by-one and don't have to switch to a new group. In principle group
teardown does the same. It would allow large scale as well as small scale
users use very similar scheme with single group for switching periods.

> But I agree that alternating groups should not be a requirement for HSM
> and that for watching smaller subtrees, your suggestion makes more sense.
> 
> > 4) Switch to new period & clear CHECKPOINT_PENDING, all events are now
> >    recorded to the new period.
> > 5) Merge all events from 'transition' stream to both old and new period
> >    event streams.
> > 6) Events get removed from the 'transition' stream only once we receive
> >    POST_WRITE event corresponding to the PRE_WRITE event recorded there (or
> >    on crash recovery). This way some events from 'transition' stream may
> >    get merged to multiple period event streams if the checkpoints are
> >    frequent and writes take long.
> >
> > This should avoid the above race, should be relatively lightweight, and
> > does not require major API extensions.
> >
> 
> If I am not mistaken, CHECKPOINT_PENDING vs. alternating groups
> is an implementation detail for the HSM.
>
> PRE_WRITE/POST_WRITE and FAN_MARK_SYNC APIs are needed
> for both the implementations (single group scheme needs to flush all
> ignore marks with FAN_MARK_SYNC).

So why would be FAN_MARK_SYNC needed for the single group scheme? From the
kernel POV the scheme I have proposed does not require any new API changes
besides the POST_WRITE event AFAICT. And possibly FAN_MARK_FLUSH tweak for
more efficient removal of ignore marks. We don't even need the filesystem
freezing (modulo the buffered vs direct IO discussion below).

> I am going to try to implement the PRE/POST_WRITE events and for
> POC I may start with a single group because it may be easier or I may
> implement both schemes, we'll see.

That would be great. Thank you. Perhaps I'm missing something in my mental
model which would make things impractical :)

> > BTW, while thinking about this I was wondering: How are the applications
> > using persistent change journal going to deal with buffered vs direct IO? I
> > currently don't see a scheme that would not loose modifications for some
> > combinations...
> 
> This question is circling back to nfsd discussion about when to update
> i_version and when to update mtime, before the change is observed
> in core? on disk? both before and after?
> 
> My only answer to that is a hybrid combination of using async
> events to track in-core changes and persistent change tracking
> for on-disk changes.
> 
> fsfreeze before completion of the checkpoint is optional, but if
> fsfreeze is performed then it should answer your question about
> buffered vs direct IO and it makes the questions about in-memory
> vs. on-disk moot.
> 
> Or maybe I did not understand the problem with buffered vs direct IO?
> Can you give an example for losing modification that does involve
> fsfreeze for completion of the checkpoint?

You're right fsfreeze during period transision also solves the issue with
buffered vs direct IO and I'm not aware of any other reliable solution. It
just seems as a rather big (and expensive) hammer. Probably fine for
certain applications (such as daily system backup) but not so much for
others (such as each of your desktop apps wanting to efficiently check
for changes in their config directories on startup). So probably there's
market for both solutions with and without fsfreeze ;)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
