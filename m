Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80368760137
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 23:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGXVds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGXVdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:33:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA144D8;
        Mon, 24 Jul 2023 14:33:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64D1322709;
        Mon, 24 Jul 2023 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690234425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWFMC0OaVUBV1G7vGuGgs0gnoyzaxFVN0lnZJV+aZP4=;
        b=h+QC3MyAJ23SiY0WzKNnRfxvmo0izLYptmwRx7pbeI2L/MmYliXOdWqcAPL62h6SsENocb
        tHeIv1rVlOJODQJgOfsyBQHiRxALeA3zv3Yu3uWQDLliUHdrcTARQQqakMQm8TSMHLfH7g
        w2xNRGvNw5JgLAQGFFEopj1+lIXTHwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690234425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWFMC0OaVUBV1G7vGuGgs0gnoyzaxFVN0lnZJV+aZP4=;
        b=i23Q6f99nULPqudBdZ4v3LfsO0tGlVYYjAlFghzWRoVVq+Xve4ueHoxyzqwdVMf0toNmnS
        2YQ1lhNqgjArUpBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 299F6138E8;
        Mon, 24 Jul 2023 21:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vg7zAznuvmQBJwAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 24 Jul 2023 21:33:45 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     brauner@kernel.org, tytso@mit.edu,
        linux-f2fs-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v3 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Organization: SUSE
References: <20230719221918.8937-1-krisman@suse.de>
        <20230719221918.8937-4-krisman@suse.de>
        <20230720060657.GB2607@sol.localdomain>
        <20230720064103.GC2607@sol.localdomain> <87bkg53tr5.fsf@suse.de>
        <20230722042939.GC5660@sol.localdomain>
Date:   Mon, 24 Jul 2023 17:33:43 -0400
In-Reply-To: <20230722042939.GC5660@sol.localdomain> (Eric Biggers's message
        of "Fri, 21 Jul 2023 21:29:39 -0700")
Message-ID: <87zg3l2dvs.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Jul 21, 2023 at 04:16:30PM -0400, Gabriel Krisman Bertazi wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>> > On Wed, Jul 19, 2023 at 11:06:57PM -0700, Eric Biggers wrote:
>> >> 
>> >> I'm also having trouble understanding exactly when ->d_name is stable here.
>> >> AFAICS, unfortunately the VFS has an edge case where a dentry can be moved
>> >> without its parent's ->i_rwsem being held.  It happens when a subdirectory is
>> >> "found" under multiple names.  The VFS doesn't support directory hard links, so
>> >> if it finds a second link to a directory, it just moves the whole dentry tree to
>> >> the new location.  This can happen if a filesystem image is corrupted and
>> >> contains directory hard links.  Coincidentally, it can also happen in an
>> >> encrypted directory due to the no-key name => normal name transition...
>> >
>> > Sorry, I think I got this slightly wrong.  The move does happen with the
>> > parent's ->i_rwsem held, but it's for read, not for write.  First, before
>> > ->lookup is called, the ->i_rwsem of the parent directory is taken for read.
>> > ->lookup() calls d_splice_alias() which can call __d_unalias() which does the
>> > __d_move().  If the old alias is in a different directory (which cannot happen
>> > in that fscrypt case, but can happen in the general "directory hard links"
>> > case), __d_unalias() takes that directory's ->i_rwsem for read too.
>> >
>> > So it looks like the parent's ->i_rwsem does indeed exclude moves of child
>> > dentries, but only if it's taken for *write*.  So I guess you can rely on that;
>> > it's just a bit more subtle than it first appears.  Though, some of your
>> > explanation seems to assume that a read lock is sufficient ("In __lookup_slow,
>> > either the parent inode is locked by the caller (lookup_slow) ..."), so maybe
>> > there is still a problem.
>> 
>> I think I'm missing something on your clarification. I see your point
>> about __d_unalias, and I see in the case where alias->d_parent !=
>> dentry->d_parent we acquire the parent inode read lock:
>> 
>> static int __d_unalias(struct inode *inode,
>> 		struct dentry *dentry, struct dentry *alias)
>> {
>> ...
>> 	m1 = &dentry->d_sb->s_vfs_rename_mutex;
>> 	if (!inode_trylock_shared(alias->d_parent->d_inode))
>> 		goto out_err;
>> }

>> this __d_move Can do a dentry move and race with d_revalidate even
>> though it has the parent read lock.
>> 
>> > So it looks like the parent's ->i_rwsem does indeed exclude moves of child
>> > dentries, but only if it's taken for *write*.  So I guess you can rely on that;
>> 
>> We can get away of it with acquiring the d_lock as you suggested, I
>> think.  But can you clarify the above? I wanna make sure I didn't miss
>> anything. I am indeed relying only on the read lock here, as you can see.
>
> In my first email I thought that __d_move() can be called without the parent
> inode's i_rwsem held at all.  In my second email I realized that it is always
> called with at least a read (shared) lock.

I see. Thank you.  We are on the same page now.   I was confused by
this part of your second comment:

>> > I guess you can rely on that; it's just a bit more subtle than it
>> > first appears.  Though, some of your explanation seems to assume
>> > that a read lock is sufficient ("In __lookup_slow, either the
>> > parent inode is locked by the caller (lookup_slow) ..."),

...because I was then failing to see, after learning about the __d_move
case, how I could rely on the inode read lock.  But, as I now realize,
__d_move is not called for negative dentries, so lookup_slow is indeed
safe.

> The question is what kind of parent i_rwsem lock is guaranteed to be held by the
> caller of ->d_revalidate() when the name comparison is done.  Based on the
> above, it needs to be at least a write (exclusive) lock to exclude __d_move()
> without taking d_lock.  However, your analysis (in the commit message of "libfs:
> Validate negative dentries in case-insensitive directories") only talks about
> i_rwsem being "taken", without saying whether it's for read or write.  One thing
> you mentioned as taking i_rwsem is lookup_slow, but that only takes it for read.
> That seems like a problem, as it makes your analysis not correct.

My understanding and explanation was that a read lock should be enough
at all times, despite the __d_move case.  Any time d_revalidate is
called for a (LOOKUP_CREATE | LOOKUP_RENAME_TARGET), it holds at least
the read lock, preventing concurrent changes to d_name of negative
dentries.

I will review the places that touch ->d_name again and I will keep the
patch as-is and update my explanation to include this case.

-- 
Gabriel Krisman Bertazi
