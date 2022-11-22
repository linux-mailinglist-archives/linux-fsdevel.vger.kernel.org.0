Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD43633BC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 12:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiKVLut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 06:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiKVLuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:50:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A522649B;
        Tue, 22 Nov 2022 03:50:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 623B221DF6;
        Tue, 22 Nov 2022 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669117843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2NLPPfPbXlzc9i/UApoe0eWMkGXj0rSu14qKp78k83Q=;
        b=aaf7AvVSTti7nWTsOAhtHAbmUjXO5oF/M0gRQkqDM9n1/Kb4qfy7y2EGj4D6X5Hm8dJvr/
        iReg3lu/HilnKT6lrbqIlioO3/1KgXpI0t+F0s6Dv+U3zYfVkPSKi+h8x8YYvxXaMe34vW
        KdefrqR3x0yAZGtaIUTZOW5EWfg5exk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669117843;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2NLPPfPbXlzc9i/UApoe0eWMkGXj0rSu14qKp78k83Q=;
        b=whym30YgCMTfGJ3hGiBVRplm8FQ1g3T/JAPm7pM264eA9NzLo98RlPC2aaI23YwCUTegbp
        ncvYD4qHnMFcRaAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55EEB13AA1;
        Tue, 22 Nov 2022 11:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LajrFJO3fGMnEgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 22 Nov 2022 11:50:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D7AB3A070E; Tue, 22 Nov 2022 12:50:42 +0100 (CET)
Date:   Tue, 22 Nov 2022 12:50:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 0/5] fsnotify: fix softlockups iterating over d_subdirs
Message-ID: <20221122115042.qssn25wbtxxhaeys@quack3>
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111220614.991928-1-stephen.s.brennan@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stephen!

On Fri 11-11-22 14:06:09, Stephen Brennan wrote:
> Here's my v4 patch series that aims to eliminate soft lockups when updating
> dentry flags in fsnotify. I've incorporated Jan's suggestion of simply
> allowing the flag to be lazily cleared in the fsnotify_parent() function,
> via Amir's patch. This allowed me to drop patch #2 from my previous series
> (fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem). I
> replaced it with "fsnotify: require inode lock held during child flag
> update", patch #5 in this series. I also added "dnotify: move
> fsnotify_recalc_mask() outside spinlock" to address the sleep-during-atomic
> issues with dnotify.

Yes, the series is now much simpler. Thanks!

> Jan expressed concerns about lock ordering of the inode rwsem with the
> fsnotify group mutex. I built this with lockdep enabled (see below for the
> lock debugging .config section -- I'm not too familiar with lockdep so I
> wanted a sanity check). I ran all the fanotify, inotify, and dnotify tests
> I could find in LTP, with no lockdep splats to be found. I don't know that
> this can completely satisfy the concerns about lock ordering: I'm reading
> through the code to better understand the concern about "the removal of
> oneshot mark during modify event generation". But I'm encouraged by the
> LTP+lockdep results.

So I had a look and I think your patches could cause deadlock at least for
nfsd. The problem is with things like inotify IN_ONESHOT marks. They get
autodeleted as soon as they trigger. Thus e.g. fsnotify_mkdir() can trigger
IN_ONESHOT mark and goes on removing it by calling fsnotify_destroy_mark()
from inotify_handle_inode_event(). And nfsd calls e.g. fsnotify_mkdir()
while holding dir->i_rwsem held. So we have lock ordering like:

nfsd_mkdir()
  inode_lock(dir);
    ...
    __nfsd_mkdir(dir, ...)
      fsnotify_mkdir(dir, dentry);
        ...
        inotify_handle_inode_event()
          ...
          fsnotify_destroy_mark()
            fsnotify_group_lock(group)

So we have dir->i_rwsem > group->mark_mutex. But we also have callchains
like:

inotify_add_watch()
  inotify_update_watch()
    fsnotify_group_lock(group)
    inotify_update_existing_watch()
      ...
      fsnotify_recalc_mask()
        inode_lock(dir); -> added by your series

which creates ordering group->mark_mutex > dir->i_rwsem.

It is even worse with dnotify which (even with your patches) ends up
calling fsnotify_recalc_mask() from dnotify_handle_event() so we have a
possibility of direct A->A deadlock. But I'd leave dnotify aside, I think
that can be massaged to not need to call fsnotify_recalc_mask()
(__fsnotify_recalc_mask() would be enough there).

Still I'm not 100% sure about a proper way out of this. The simplicity of
alias->d_subdirs iteration with i_rwsem held is compeling. We could mandate
that fsnotify hooks cannot be called with inode->i_rwsem held (and fixup
nfsd) but IMO that is pushing the complexity from the fsnotify core into
its users which is undesirable. Maybe we could grab inode->i_rwsem in those
places adding / removing notification marks before we grab
group->mark_mutex, just verify (with lockdep) that fsnotify_recalc_mask()
has the inode->i_rwsem held and be done with it? That pushes a bit of
complexity into the fsnotify backends but it is not too bad.
fsnotify_recalc_mask() gets only called by dnotify, inotify, and fanotify.
Amir?

> I originally wrote this series to make the last patch (#5) optional: if for
> some reason we didn't think it was necessary to hold the inode rwsem, then
> we could omit it -- the main penalty being the race condition described in
> the patch description. I tested without the last patch and LTP passed also
> with lockdep enabled, but of course when multiple tasks did an inotifywait
> on the same directory (with many negative dentries) only the first waited
> for the flag updates, the rest of the tasks immediately returned despite
> the flags not being ready.
> 
> I agree with Amir that as long as the lock ordering is fine, we should keep
> patch #5. And if that's the case, I can reorder the series a bit to make it
> a bit more logical, and eliminate logic in
> fsnotify_update_children_dentry_flags() for handling d_move/cursor races,
> which I promptly delete later in the series.
> 
> 1. fsnotify: clear PARENT_WATCHED flags lazily
> 2. fsnotify: Use d_find_any_alias to get dentry associated with inode
> 3. dnotify: move fsnotify_recalc_mask() outside spinlock
> 4. fsnotify: require inode lock held during child flag update
> 5. fsnotify: allow sleepable child flag update
> 
> Thanks for continuing to read this series, I hope we're making progress
> toward a simpler way to fix these scaling issues!

Yeah, so I'd be for making sure i_rwsem is held where we need it first and
only after that add reschedule handling into
fsnotify_update_children_dentry_flags(). That makes the series more
logical.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
