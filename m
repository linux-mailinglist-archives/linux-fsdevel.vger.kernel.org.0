Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89315672741
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 19:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjARSlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 13:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARSlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:41:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842C10F0;
        Wed, 18 Jan 2023 10:41:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E665A3F194;
        Wed, 18 Jan 2023 18:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674067301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPccA2uuS0AFrMoJ1hmVgCf/qhWS0ww6ghIk/2y8wLY=;
        b=b/pkxr7DosgKELvvNrVDH0z2KcxsZSjlKVMYlx3CQsQzmNO65aEnMSCaCGXZYLAuufi/oY
        kXdz5mFM7rFz5DtsNjUEncMrqMiUAZL3Cnvb1q95udiVdULoelZWmoMN3cb5WNAPwNwVLV
        CKNN1gnxH2y9xNihyDYEID/QuWdPsoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674067301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPccA2uuS0AFrMoJ1hmVgCf/qhWS0ww6ghIk/2y8wLY=;
        b=SzeoPBoe8vwR4dd+NU0w5W/ZPuVM/8pUjYK4lgM5isVBad6ThwD7KYYLaXyQVBA0hFTgUc
        gowffcp8nqQ1h4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D00BE138FE;
        Wed, 18 Jan 2023 18:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tv/AMmU9yGP3bAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 18 Jan 2023 18:41:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 34CDFA06B2; Wed, 18 Jan 2023 19:41:41 +0100 (CET)
Date:   Wed, 18 Jan 2023 19:41:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <20230118184141.pppaeg7wcj3ierae@quack3>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <Y8bTk1CsH9AaAnLt@ZenIV>
 <20230118091036.qqscls22q6htxscf@quack3>
 <Y8gejpDqxV6Uo/xY@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gejpDqxV6Uo/xY@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-01-23 16:30:06, Al Viro wrote:
> On Wed, Jan 18, 2023 at 10:10:36AM +0100, Jan Kara wrote:
> 
> > 
> > Yes, we can lock the source inode in ->rename() if we need it. The snag is
> > that if 'target' exists, it is already locked so when locking 'source' we
> > are possibly not following the VFS lock ordering of i_rwsem by inode
> > address (I don't think it can cause any real dealock but still it looks
> > suspicious). Also we'll have to lock with I_MUTEX_NONDIR2 lockdep class to
> > make lockdep happy but that's just a minor annoyance. Finally, we'll have
> > to check for RENAME_EXCHANGE because in that case, both source and target
> > will be already locked. Thus if we do the additional locking in the
> > filesystem, we will leak quite some details about rename locking into the
> > filesystem which seems undesirable to me.
> 
> Rules for inode locks are simple:
> 	* directories before non-directories
> 	* ancestors before descendents
> 	* for non-directories the ordering is by in-core inode address
> 
> So the instances that need that extra lock would do that when source is
> a directory and non RENAME_EXCHANGE is given.  Having the target already
> locked is irrelevant - if it exists, it's already checked to be a directory
> as well, and had it been a descendent of source, we would have already
> found that and failed with -ELOOP.
> 
> If A and B are both directories, there's no ordering between them unless
> one is an ancestor of another - such can be locked in any order.
> However, one of the following must be true:
> 	* C is locked and both A and B had been observed to be children of C
> after the lock on C had been acquired, or
> 	* ->s_vfs_rename_mutex is held for the filesystem containing both
> A and B.
> 
> Note that ->s_vfs_rename_mutex is there to stabilize the tree topology and
> make "is A an ancestor of B?" possible to check for more than "A is locked,
> B is a child of A, so A will remain its ancestor until unlocked"...

OK, fair enough. I'll fix things inside UDF and ext4.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
