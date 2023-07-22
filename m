Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9905375D9AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 06:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGVE3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jul 2023 00:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVE3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:29:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7FF2D46;
        Fri, 21 Jul 2023 21:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7C660A38;
        Sat, 22 Jul 2023 04:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78390C433C9;
        Sat, 22 Jul 2023 04:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690000181;
        bh=KBzG5bolVWZz3VdJ21H1CdN4OdjZ+jv8Wok+YIRRtaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmY7ZCVl6UKWNvfLhwuerzICgHNPsKEXC/FamYqipG6pCKnUsYQIyCcIFkrOExufl
         5onwwtqAeVw2LwsT69R8gDc4q3rd0vu7OncHVb15Qp7HCVpwzNf3o0iyxKH6LpWLB/
         xTBMOGfLvcnft4+poJKLEELPnbz4Wsh+9VLWIQDmNtA/LDk0vXbcw0Si91Mn4g6Vgn
         Bf8eqGbAqi/P/CuiG0D1HD9l7IwgvjxSEV1c8lcO8d4QS5nCZQeuU7J1GnF9veA9IL
         0TnUXzHRYeVgZd/DoxskbGLuHjvP1zjRDKzMDVDou4yxKgdIL97+d4c9Tgj7qYMVyB
         3mAdc3RH1bMNg==
Date:   Fri, 21 Jul 2023 21:29:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     brauner@kernel.org, tytso@mit.edu,
        linux-f2fs-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v3 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230722042939.GC5660@sol.localdomain>
References: <20230719221918.8937-1-krisman@suse.de>
 <20230719221918.8937-4-krisman@suse.de>
 <20230720060657.GB2607@sol.localdomain>
 <20230720064103.GC2607@sol.localdomain>
 <87bkg53tr5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkg53tr5.fsf@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:16:30PM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Wed, Jul 19, 2023 at 11:06:57PM -0700, Eric Biggers wrote:
> >> 
> >> I'm also having trouble understanding exactly when ->d_name is stable here.
> >> AFAICS, unfortunately the VFS has an edge case where a dentry can be moved
> >> without its parent's ->i_rwsem being held.  It happens when a subdirectory is
> >> "found" under multiple names.  The VFS doesn't support directory hard links, so
> >> if it finds a second link to a directory, it just moves the whole dentry tree to
> >> the new location.  This can happen if a filesystem image is corrupted and
> >> contains directory hard links.  Coincidentally, it can also happen in an
> >> encrypted directory due to the no-key name => normal name transition...
> >
> > Sorry, I think I got this slightly wrong.  The move does happen with the
> > parent's ->i_rwsem held, but it's for read, not for write.  First, before
> > ->lookup is called, the ->i_rwsem of the parent directory is taken for read.
> > ->lookup() calls d_splice_alias() which can call __d_unalias() which does the
> > __d_move().  If the old alias is in a different directory (which cannot happen
> > in that fscrypt case, but can happen in the general "directory hard links"
> > case), __d_unalias() takes that directory's ->i_rwsem for read too.
> >
> > So it looks like the parent's ->i_rwsem does indeed exclude moves of child
> > dentries, but only if it's taken for *write*.  So I guess you can rely on that;
> > it's just a bit more subtle than it first appears.  Though, some of your
> > explanation seems to assume that a read lock is sufficient ("In __lookup_slow,
> > either the parent inode is locked by the caller (lookup_slow) ..."), so maybe
> > there is still a problem.
> 
> I think I'm missing something on your clarification. I see your point
> about __d_unalias, and I see in the case where alias->d_parent !=
> dentry->d_parent we acquire the parent inode read lock:
> 
> static int __d_unalias(struct inode *inode,
> 		struct dentry *dentry, struct dentry *alias)
> {
> ...
> 	m1 = &dentry->d_sb->s_vfs_rename_mutex;
> 	if (!inode_trylock_shared(alias->d_parent->d_inode))
> 		goto out_err;
> }
> 
> And it seems to use that for __d_move. In this case, __d_move changes
> from under us even with a read lock, which is dangerous.  I think I
> agree with your first email more than the clarification.
> 
> In the lookup_slow then:
> 
> lookup_slow()
>   d_lookup()
>     d_splice_alias()
>       __d_unalias()
>         __d_move()
> 
> this __d_move Can do a dentry move and race with d_revalidate even
> though it has the parent read lock.
> 
> > So it looks like the parent's ->i_rwsem does indeed exclude moves of child
> > dentries, but only if it's taken for *write*.  So I guess you can rely on that;
> 
> We can get away of it with acquiring the d_lock as you suggested, I
> think.  But can you clarify the above? I wanna make sure I didn't miss
> anything. I am indeed relying only on the read lock here, as you can see.

In my first email I thought that __d_move() can be called without the parent
inode's i_rwsem held at all.  In my second email I realized that it is always
called with at least a read (shared) lock.

The question is what kind of parent i_rwsem lock is guaranteed to be held by the
caller of ->d_revalidate() when the name comparison is done.  Based on the
above, it needs to be at least a write (exclusive) lock to exclude __d_move()
without taking d_lock.  However, your analysis (in the commit message of "libfs:
Validate negative dentries in case-insensitive directories") only talks about
i_rwsem being "taken", without saying whether it's for read or write.  One thing
you mentioned as taking i_rwsem is lookup_slow, but that only takes it for read.
That seems like a problem, as it makes your analysis not correct.

- Eric
