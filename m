Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F216A6C6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCAMgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 07:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCAMgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:36:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928B3BD97;
        Wed,  1 Mar 2023 04:36:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1D7D1FE14;
        Wed,  1 Mar 2023 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677674196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdqcoCLeQ7SiWsFxWlApKOERlF4GamHsipQsEiy1FiY=;
        b=iRFL13q3CiKewiH36KyPitRm/6jGOsdE/U5ICeUBrDgwC7/N2aDeByq3uLxqPsS+znuKl/
        S9uaL9/3lTFZ5s8kIm4rzrj1YCmLyG/Fr978dgc3mR0xe3WNtSlqZi74+EnuAq+5W8/ESA
        XtG86ZNlElfbAVT+eRVM+aNWdc0xaKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677674196;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdqcoCLeQ7SiWsFxWlApKOERlF4GamHsipQsEiy1FiY=;
        b=Ea+rAoREpahggwoA0sVGSBQPyyc68ZeHoeNC36lZf1RDru8V1qqzZ1Xs0TuMs5z8o4yo6r
        cqa1j94FCp5cZsDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9241A13A63;
        Wed,  1 Mar 2023 12:36:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v7GoI9RG/2MGdQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 12:36:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C2E15A06E5; Wed,  1 Mar 2023 13:36:28 +0100 (CET)
Date:   Wed, 1 Mar 2023 13:36:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <20230301123628.4jghcm4wqci6spii@quack3>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <20230117214457.GG360264@dread.disaster.area>
 <Y/mEsfyhNCs8orCY@magnolia>
 <20230228015807.GC360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228015807.GC360264@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-02-23 12:58:07, Dave Chinner wrote:
> On Fri, Feb 24, 2023 at 07:46:57PM -0800, Darrick J. Wong wrote:
> > So xfs_dir2_sf_replace can rewrite the shortform structure (or even
> > convert it to block format!) while readdir is accessing it.  Or am I
> > mising something?
> 
> True, I missed that.
> 
> Hmmmm. ISTR that holding ILOCK over filldir callbacks causes
> problems with lock ordering{1], and that's why we removed the ILOCK
> from the getdents path in the first place and instead relied on the
> IOLOCK being held by the VFS across readdir for exclusion against
> concurrent modification from the VFS.
> 
> Yup, the current code only holds the ILOCK for the extent lookup and
> buffer read process, it drops it while it is walking the locked
> buffer and calling the filldir callback. Which is why we don't hold
> it for xfs_dir2_sf_getdents() - the VFS is supposed to be holding
> i_rwsem in exclusive mode for any operation that modifies a
> directory entry. We should only need the ILOCK for serialising the
> extent tree loading, not for serialising access vs modification to
> the directory.
> 
> So, yeah, I think you're right, Darrick. And the fix is that the VFS
> needs to hold the i_rwsem correctly for allo inodes that may be
> modified during rename...

But Al Viro didn't want to lock the inode in the VFS (as some filesystems
don't need the lock) so in ext4 we ended up grabbing the lock in
ext4_rename() like:

+               /*
+                * We need to protect against old.inode directory getting
+                * converted from inline directory format into a normal one.
+                */
+               inode_lock_nested(old.inode, I_MUTEX_NONDIR2);

(Linus didn't merge the ext4 pull request so the change isn't upstream
yet).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
