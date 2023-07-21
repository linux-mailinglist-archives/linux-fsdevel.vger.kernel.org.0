Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0675D561
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGUUQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 16:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGUUQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:16:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6E3272C;
        Fri, 21 Jul 2023 13:16:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82AE31F45F;
        Fri, 21 Jul 2023 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689970591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+3XV/m/wutn1BSKHTosdH9uZC2velfSXaZJesszQtA=;
        b=HrxIAbhGLWdpGDDiDBx0VURnTA7UwcQvC7+Prk5xgB9teOCVx6Atmqz/L6XQ7pZjeGoh6H
        dABX9P0cchQs5hHktNwqiZi1QtQBOO2TMG5AuvK2frOoJliwwkktdsFzY+FVmIISkb/KoZ
        5x/xifmlHJmBzePhqOZ95F0Gnr+/6cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689970591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+3XV/m/wutn1BSKHTosdH9uZC2velfSXaZJesszQtA=;
        b=3wyh95/nmrmuLtQ2O2njeLLNw43OlE660K1uYRlbN0gN/Wdlb3eMKXtZ8rxNUnyqL1arjW
        9MAmFpSKG6XgJ5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F89D134B0;
        Fri, 21 Jul 2023 20:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tEvjCZ/numSdJAAAMHmgww
        (envelope-from <krisman@suse.de>); Fri, 21 Jul 2023 20:16:31 +0000
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
        <20230720064103.GC2607@sol.localdomain>
Date:   Fri, 21 Jul 2023 16:16:30 -0400
In-Reply-To: <20230720064103.GC2607@sol.localdomain> (Eric Biggers's message
        of "Wed, 19 Jul 2023 23:41:03 -0700")
Message-ID: <87bkg53tr5.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, Jul 19, 2023 at 11:06:57PM -0700, Eric Biggers wrote:
>> 
>> I'm also having trouble understanding exactly when ->d_name is stable here.
>> AFAICS, unfortunately the VFS has an edge case where a dentry can be moved
>> without its parent's ->i_rwsem being held.  It happens when a subdirectory is
>> "found" under multiple names.  The VFS doesn't support directory hard links, so
>> if it finds a second link to a directory, it just moves the whole dentry tree to
>> the new location.  This can happen if a filesystem image is corrupted and
>> contains directory hard links.  Coincidentally, it can also happen in an
>> encrypted directory due to the no-key name => normal name transition...
>
> Sorry, I think I got this slightly wrong.  The move does happen with the
> parent's ->i_rwsem held, but it's for read, not for write.  First, before
> ->lookup is called, the ->i_rwsem of the parent directory is taken for read.
> ->lookup() calls d_splice_alias() which can call __d_unalias() which does the
> __d_move().  If the old alias is in a different directory (which cannot happen
> in that fscrypt case, but can happen in the general "directory hard links"
> case), __d_unalias() takes that directory's ->i_rwsem for read too.
>
> So it looks like the parent's ->i_rwsem does indeed exclude moves of child
> dentries, but only if it's taken for *write*.  So I guess you can rely on that;
> it's just a bit more subtle than it first appears.  Though, some of your
> explanation seems to assume that a read lock is sufficient ("In __lookup_slow,
> either the parent inode is locked by the caller (lookup_slow) ..."), so maybe
> there is still a problem.

I think I'm missing something on your clarification. I see your point
about __d_unalias, and I see in the case where alias->d_parent !=
dentry->d_parent we acquire the parent inode read lock:

static int __d_unalias(struct inode *inode,
		struct dentry *dentry, struct dentry *alias)
{
...
	m1 = &dentry->d_sb->s_vfs_rename_mutex;
	if (!inode_trylock_shared(alias->d_parent->d_inode))
		goto out_err;
}

And it seems to use that for __d_move. In this case, __d_move changes
from under us even with a read lock, which is dangerous.  I think I
agree with your first email more than the clarification.

In the lookup_slow then:

lookup_slow()
  d_lookup()
    d_splice_alias()
      __d_unalias()
        __d_move()

this __d_move Can do a dentry move and race with d_revalidate even
though it has the parent read lock.

> So it looks like the parent's ->i_rwsem does indeed exclude moves of child
> dentries, but only if it's taken for *write*.  So I guess you can rely on that;

We can get away of it with acquiring the d_lock as you suggested, I
think.  But can you clarify the above? I wanna make sure I didn't miss
anything. I am indeed relying only on the read lock here, as you can see.

-- 
Gabriel Krisman Bertazi
