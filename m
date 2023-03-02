Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8726A7D91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 10:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCBJWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 04:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCBJWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:22:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766C3B0D6;
        Thu,  2 Mar 2023 01:21:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C93541FE69;
        Thu,  2 Mar 2023 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677748905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BmgYg0lYZnPfzsZd5pOf8kH3AqGBx1K6viQGIXslEbc=;
        b=jirM/3F5jSyGv52N/7YH83A1F36L76BW3FbxQrYB8JBSQo8vzyQ/xM+Xv/1JOIoy/nDRBb
        1umE/dkOeI0KkR2bFmT5kTeYQaOQqX7rJ9JNMhsTXTMjjM9sCZkTFEqj/u5bieUhkflr5a
        0qQnxnFhoPvXBZwT/tHH7Oj+BZ8bnVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677748905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BmgYg0lYZnPfzsZd5pOf8kH3AqGBx1K6viQGIXslEbc=;
        b=oMvbV1Jcc6pOtQJ5RFJm1BC7mfV9Cp4Ia0/Ik+xJpTR0j/aYC8T2sfFpZaqMac90lGo9If
        1DJLIk829UIf8kAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA3EF13A63;
        Thu,  2 Mar 2023 09:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pv2DKalqAGQnNAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 02 Mar 2023 09:21:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 06033A06E5; Thu,  2 Mar 2023 10:21:45 +0100 (CET)
Date:   Thu, 2 Mar 2023 10:21:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <20230302092144.yvj5rcxnbe57nqie@quack3>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <20230117214457.GG360264@dread.disaster.area>
 <Y/mEsfyhNCs8orCY@magnolia>
 <20230228015807.GC360264@dread.disaster.area>
 <20230301123628.4jghcm4wqci6spii@quack3>
 <20230302003050.GI360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302003050.GI360264@dread.disaster.area>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 02-03-23 11:30:50, Dave Chinner wrote:
> On Wed, Mar 01, 2023 at 01:36:28PM +0100, Jan Kara wrote:
> > On Tue 28-02-23 12:58:07, Dave Chinner wrote:
> > > On Fri, Feb 24, 2023 at 07:46:57PM -0800, Darrick J. Wong wrote:
> > > > So xfs_dir2_sf_replace can rewrite the shortform structure (or even
> > > > convert it to block format!) while readdir is accessing it.  Or am I
> > > > mising something?
> > > 
> > > True, I missed that.
> > > 
> > > Hmmmm. ISTR that holding ILOCK over filldir callbacks causes
> > > problems with lock ordering{1], and that's why we removed the ILOCK
> > > from the getdents path in the first place and instead relied on the
> > > IOLOCK being held by the VFS across readdir for exclusion against
> > > concurrent modification from the VFS.
> > > 
> > > Yup, the current code only holds the ILOCK for the extent lookup and
> > > buffer read process, it drops it while it is walking the locked
> > > buffer and calling the filldir callback. Which is why we don't hold
> > > it for xfs_dir2_sf_getdents() - the VFS is supposed to be holding
> > > i_rwsem in exclusive mode for any operation that modifies a
> > > directory entry. We should only need the ILOCK for serialising the
> > > extent tree loading, not for serialising access vs modification to
> > > the directory.
> > > 
> > > So, yeah, I think you're right, Darrick. And the fix is that the VFS
> > > needs to hold the i_rwsem correctly for allo inodes that may be
> > > modified during rename...
> > 
> > But Al Viro didn't want to lock the inode in the VFS (as some filesystems
> > don't need the lock)
> 
> Was any reason given?

Kind of what I wrote above. See:

https://lore.kernel.org/all/Y8bTk1CsH9AaAnLt@ZenIV
 
> We know we have to modify the ".." entry of the child directory
> being moved, so I'd really like to understand why the locking rule
> of "directory i_rwsem must be held exclusively over modifications"
> so that we can use shared access for read operations has been waived
> for this specific case.

Well, not every filesystem has physical ".." directory entry but I share
your sentiment that avoiding grabbing the directory lock in this particular
case is not worth the maintenance burden of trying to track down all the
filesystems that may need it. So I'm still all for grabbing it in VFS and
maybe Al is willing to reconsider given XFS was found to be prone to the
race as well. Al?

> Apart from exposing multiple filesystems to modifications racing
> with operations that hold the i_rwsem shared to *prevent concurrent
> directory modifications*, what performance or scalability benefit is
> seen as a result of eliding this inode lock from the VFS rename
> setup?
> 
> This looks like a straight forward VFS level directory
> locking violation, and now we are playing whack-a-mole to fix it in
> each filesystem we discover that requires the child directory inode
> to be locked...
> 
> > so in ext4 we ended up grabbing the lock in
> > ext4_rename() like:
> > 
> > +               /*
> > +                * We need to protect against old.inode directory getting
> > +                * converted from inline directory format into a normal one.
> > +                */
> > +               inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
> 
> Why are you using the I_MUTEX_NONDIR2 annotation when locking a
> directory inode? That doesn't seem right.

Because that's the only locking subclass left unused during rename and it
happens to have the right ordering for ext4 purposes wrt other i_rwsem
subclasses. In other words it is a hack to fix the race and silence lockdep
;). If we are going to lift this to VFS, we should probably add
I_MUTEX_MOVED_DIR subclass, possibly as an alias to I_MUTEX_NONDIR2. 

> Further, how do we guarantee correct i_rwsem lock ordering against
> the all the other inodes that the VFS has already locked and/or
> other multi-inode i_rwsem locking primitives in the VFS?

Well, cross directory renames are all serialized by sb->s_vfs_rename_mutex
so we don't have to be afraid of two renames racing against each other.
Also directories are locked in topological order by all operations so
grabbing moved directory lock last is the safe thing to do (because rename
is the only operation that can lock two topologically incomparable
directories).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
