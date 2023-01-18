Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F55671875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjARKEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjARKCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:02:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC955C0EC;
        Wed, 18 Jan 2023 01:10:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 16D4B21008;
        Wed, 18 Jan 2023 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674033037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sYf0I/w6JuWYkzGVkseG3wppzKMRwYJVj/+zNP8Ra4=;
        b=gu5fonY/PXsDJC6ZqlQk+8ME1jV58LQopC0NBgaVmvt2A3fsZHn/DkA5/Ezqb7AxsH0oV6
        vzdoTMOTOzmsidJfZ187rCTgrfizJb5nfe2475JpitZMFUtvYggPiw4Kj8ufSZkkG0GWga
        eo7oKgZFiKvc6PTCWFJP/PcmXU8s6cE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674033037;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sYf0I/w6JuWYkzGVkseG3wppzKMRwYJVj/+zNP8Ra4=;
        b=t4geP6QmsGVatK5X3Ay7mgvoInl7/ZqmfZ//X9Upvn+ydMagiJDDSDoqCBIgl/q9KbRoti
        uRuTDWjQ1E2ESXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04FE4139D2;
        Wed, 18 Jan 2023 09:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3AQ1AY23x2OcLgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 18 Jan 2023 09:10:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6411FA06B2; Wed, 18 Jan 2023 10:10:36 +0100 (CET)
Date:   Wed, 18 Jan 2023 10:10:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <20230118091036.qqscls22q6htxscf@quack3>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <Y8bTk1CsH9AaAnLt@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8bTk1CsH9AaAnLt@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 17-01-23 16:57:55, Al Viro wrote:
> On Tue, Jan 17, 2023 at 01:37:35PM +0100, Jan Kara wrote:
> > Hello!
> > 
> > I've some across an interesting issue that was spotted by syzbot [1]. The
> > report is against UDF but AFAICS the problem exists for ext4 as well and
> > possibly other filesystems. The problem is the following: When we are
> > renaming directory 'dir' say rename("foo/dir", "bar/") we lock 'foo' and
> > 'bar' but 'dir' is unlocked because the locking done by vfs_rename() is
> > 
> >         if (!is_dir || (flags & RENAME_EXCHANGE))
> >                 lock_two_nondirectories(source, target);
> >         else if (target)
> >                 inode_lock(target);
> > 
> > However some filesystems (e.g. UDF but ext4 as well, I suspect XFS may be
> > hurt by this as well because it converts among multiple dir formats) need
> > to update parent pointer in 'dir' and nothing protects this update against
> > a race with someone else modifying 'dir'. Now this is mostly harmless
> > because the parent pointer (".." directory entry) is at the beginning of
> > the directory and stable however if for example the directory is converted
> > from packed "in-inode" format to "expanded" format as a result of
> > concurrent operation on 'dir', the filesystem gets corrupted (or crashes as
> > in case of UDF).
> > 
> > So we'd need to lock 'source' if it is a directory. Ideally this would
> > happen in VFS as otherwise I bet a lot of filesystems will get this wrong
> > so could vfs_rename() lock 'source' if it is a dir as well? Essentially
> > this would amount to calling lock_two_nondirectories(source, target)
> > unconditionally but that would become a serious misnomer ;). Al, any
> > thought?
> 
> FWIW, I suspect that majority of filesystems that do implement rename
> do not have that problem.  Moreover, on cross-directory rename we already
> have
> 	* tree topology stabilized
> 	* source guaranteed not to be an ancestor of target or either of
> the parents
> so the method instance should be free to lock the source if it needs to
> do so.

Yes, we can lock the source inode in ->rename() if we need it. The snag is
that if 'target' exists, it is already locked so when locking 'source' we
are possibly not following the VFS lock ordering of i_rwsem by inode
address (I don't think it can cause any real dealock but still it looks
suspicious). Also we'll have to lock with I_MUTEX_NONDIR2 lockdep class to
make lockdep happy but that's just a minor annoyance. Finally, we'll have
to check for RENAME_EXCHANGE because in that case, both source and target
will be already locked. Thus if we do the additional locking in the
filesystem, we will leak quite some details about rename locking into the
filesystem which seems undesirable to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
