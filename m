Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A7D6B2C51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 18:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCIRuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 12:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjCIRuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:50:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3080F6B46;
        Thu,  9 Mar 2023 09:49:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A66E5201F8;
        Thu,  9 Mar 2023 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678384194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNYZmtX9imuOnxTUoztWoeMpp9iMYfzTp6MSeU5OgnE=;
        b=lXRDm63xXB6n23XHoZpM9TRjc8yzJZL3eR2ZlTydqnmqS3G2t5YwSQDdB3JxrEY6h2ak5T
        B5Oq6Lh+nTU6gH/dZYkkrvtIXvZyAzLMDlrv6BmwJbpcy+ogz+oCbzDK76b9ozlDGeELf4
        /osyLyvfJMDVfzMxXwqMpzJ1w6QAyoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678384194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNYZmtX9imuOnxTUoztWoeMpp9iMYfzTp6MSeU5OgnE=;
        b=Sn81RpcF4/+kiswfyg5jp3skQJRNP8KJm142jGNkHUKAxWiEiQMur2pqyDqL1ZRgQDkEbH
        Xrvgl5Or0uA99MBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9165213A10;
        Thu,  9 Mar 2023 17:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qWtuI0IcCmQ1JgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 17:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0E8EAA06FF; Thu,  9 Mar 2023 18:49:54 +0100 (CET)
Date:   Thu, 9 Mar 2023 18:49:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [LSF TOPIC] online repair of filesystems: what next?
Message-ID: <20230309174954.t6kxdhgxlmeg6xcu@quack3>
References: <Y/5ovz6HI2Z47jbk@magnolia>
 <20230308171206.zuci3wdd3yg7amw5@quack3>
 <20230308215439.GM360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308215439.GM360264@dread.disaster.area>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-03-23 08:54:39, Dave Chinner wrote:
> On Wed, Mar 08, 2023 at 06:12:06PM +0100, Jan Kara wrote:
> > Hi!
> > 
> > I'm interested in this topic. Some comments below.
> > 
> > On Tue 28-02-23 12:49:03, Darrick J. Wong wrote:
> > > Five years ago[0], we started a conversation about cross-filesystem
> > > userspace tooling for online fsck.  I think enough time has passed for
> > > us to have another one, since a few things have happened since then:
> > > 
> > > 1. ext4 has gained the ability to send corruption reports to a userspace
> > >    monitoring program via fsnotify.  Thanks, Collabora!
> > > 
> > > 2. XFS now tracks successful scrubs and corruptions seen during runtime
> > >    and during scrubs.  Userspace can query this information.
> > > 
> > > 3. Directory parent pointers, which enable online repair of the
> > >    directory tree, is nearing completion.
> > > 
> > > 4. Dave and I are working on merging online repair of space metadata for
> > >    XFS.  Online repair of directory trees is feature complete, but we
> > >    still have one or two unresolved questions in the parent pointer
> > >    code.
> > > 
> > > 5. I've gotten a bit better[1] at writing systemd service descriptions
> > >    for scheduling and performing background online fsck.
> > > 
> > > Now that fsnotify_sb_error exists as a result of (1), I think we
> > > should figure out how to plumb calls into the readahead and writeback
> > > code so that IO failures can be reported to the fsnotify monitor.  I
> > > suspect there may be a few difficulties here since fsnotify (iirc)
> > > allocates memory and takes locks.
> > 
> > Well, if you want to generate fsnotify events from an interrupt handler,
> > you're going to have a hard time, I don't have a good answer for that.
> 
> I don't think we ever do that, or need to do that. IO completions
> that can throw corruption errors are already running in workqueue
> contexts in XFS.
> 
> Worst case, we throw all bios that have IO errors flagged to the
> same IO completion workqueues, and the problem of memory allocation,
> locks, etc in interrupt context goes away entire.
> 
> > But
> > offloading of error event generation to a workqueue should be doable (and
> > event delivery is async anyway so from userspace POV there's no
> > difference).
> 
> Unless I'm misunderstanding you (possible!), that requires a memory
> allocation to offload the error information to the work queue to
> allow the fsnotify error message to be generated in an async manner.
> That doesn't seem to solve anything.

I think your "punt bio completions with errors to a workqueue" is perfectly
fine for our purposes and solves all the problems I had in mind.

> > Otherwise locking shouldn't be a problem AFAICT. WRT memory
> > allocation, we currently preallocate the error events to avoid the loss of
> > event due to ENOMEM. With current usecases (filesystem catastrophical error
> > reporting) we have settled on a mempool with 32 preallocated events (note
> > that preallocated event gets used only if normal kmalloc fails) for
> > simplicity. If the error reporting mechanism is going to be used
> > significantly more, we may need to reconsider this but it should be doable.
> > And frankly if you have a storm of fs errors *and* the system is going
> > ENOMEM at the same time, I have my doubts loosing some error report is
> > going to do any more harm ;).
> 
> Once the filesystem is shut down, it will need to turn off
> individual sickness notifications because everything is sick at this
> point.

Yup.

> > > As a result of (2), XFS now retains quite a bit of incore state about
> > > its own health.  The structure that fsnotify gives to userspace is very
> > > generic (superblock, inode, errno, errno count).  How might XFS export
> > > a greater amount of information via this interface?  We can provide
> > > details at finer granularity -- for example, a specific data structure
> > > under an allocation group or an inode, or specific quota records.
> > 
> > Fsnotify (fanotify in fact) interface is fairly flexible in what can be
> > passed through it. So if you need to pass some (reasonably short) binary
> > blob to userspace which knows how to decode it, fanotify can handle that
> > (with some wrapping). Obviously there's a tradeoff to make how much of the
> > event is generic (as that is then easier to process by tools common for all
> > filesystems) and how much is fs specific (which allows to pass more
> > detailed information). But I guess we need to have concrete examples of
> > events to discuss this.
> 
> Fine grained health information will always be filesystem specific -
> IMO it's not worth trying to make it generic when there is only one
> filesystem that tracking and exporting fine-grained health
> information. Once (if) we get multiple filesystems tracking fine
> grained health information, then we'll have the information we need
> to implement a useful generic set of notifications, but until then I
> don't think we should try.

Fine grained health information is definitely always going to be fs
specific. I agree. I was just thinking loud whether the event should be all
fs-specific blob or whether we should not have event containing stuff like:
errno (EIO, EFSCORRUPTED,...), inode, offset, length, <and some fs-specific
blob here with more details> so that e.g. application monitoring service
could listen to such events and act on them (e.g. by failing over to
another node) without needing to understand fs-specific details.

> We should just export the notifications the filesystem utilities
> need to do their work for the moment.  When management applications
> (e.g Stratis) get to the point where they can report/manage
> filesystem health and need that information from multiple
> filesystems types, then we can work out a useful common subset of
> fine grained events across those filesystems that the applications
> can listen for.

And I guess this is a fair point that we should not try to craft generic
info in events for uncertain usecases because we'll almost certainly get it
wrong and need to change the info anyway for it to be useful.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
