Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8194731BBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjFOOs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbjFOOs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:48:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50EF273C
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 07:48:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BD241FDC5;
        Thu, 15 Jun 2023 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686840535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L+quBdiadS9BM4RZFEdLTOLQvJOXYMfOzYj18fETyBc=;
        b=1Zm6gbYqM0/imkA9LG7sKtZYMeXEFBvhtRkmFqDXFkyknSNAdQHtaW/InFxm5uEZjeNM6o
        Gr2N8TzgDYTRgXUvsV+wK6i+OEWjh8C2Gqi7vUtqAnSA9hZqcBseGk+WhJxWPBwcVL/c/U
        xaW6OKzDyeaxqtV/2kTdV8SwSw7FvJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686840535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L+quBdiadS9BM4RZFEdLTOLQvJOXYMfOzYj18fETyBc=;
        b=T4NHkIEq3v5eHkMg0vTlEWO3az+GpRMaONgrr2OlDWzm8CKEaD2JvynBxgIzFuOV7LGnZ4
        uJslFau7NvqM51DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39D8513A32;
        Thu, 15 Jun 2023 14:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h2YZDtcki2TFAQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Jun 2023 14:48:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC0A2A0755; Thu, 15 Jun 2023 16:48:54 +0200 (CEST)
Date:   Thu, 15 Jun 2023 16:48:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Protect reconfiguration of sb read-write from racing
 writes
Message-ID: <20230615144854.63ssybyufhqfwoc2@quack3>
References: <20230615113848.8439-1-jack@suse.cz>
 <20230615-zarte-locher-075323828cd1@brauner>
 <20230615141040.GG51259@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615141040.GG51259@mit.edu>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-06-23 10:10:40, Theodore Ts'o wrote:
> On Thu, Jun 15, 2023 at 02:53:53PM +0200, Christian Brauner wrote:
> > 
> > So looking at the ext4 code this can only happen when you clear
> > SB_RDONLY in ->reconfigure() too early (and the mount isn't
> > MNT_READONLY). Afaict, this was fixed in:
> > 
> > a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled")
> > 
> > by clearing SB_RDONLY late, right before returning from ->reconfigure()
> > when everything's ready. So your change is not about fixing that bug in
> > [1] it's about making the vfs give the guarantee that an fs is free to
> > clear SB_RDONLY because any ro<->rw transitions are protected via
> > s_readonly_remount. Correct? It seems ok to me just making sure.
> 
> Unfortunately we had to revert that commit because that broke
> r/o->r/w writes when quota was enabled.  The problem is we need a way
> of enabling file system writes for internal purposes (e.g., because
> quota needs to set up quota inodes) but *not* allow userspace file
> system writes to occur until we are fully done with the remount process.
> 
> See the discussion here:
> 
> 	https://lore.kernel.org/all/20230608044056.GA1418535@mit.edu/
> 
> The problem with the current state of the tree is commit dea9d8f7643f
> ("ext4: only check dquot_initialize_needed() when debugging") has
> caught real bugs in the past where the caller of
> ext4_xattr_block_set() failed to call dquot_initialize(inode).  In
> addition, shutting up the warning doesn't fix the problem that while
> we hit this race where we have started remounting r/w, quota hasn't
> been initialized, quota tracking will get silently dropped, leading to
> the quota usage tracking no longer reflecting reality.
> 
> Jan's patch will fix this problem.

Yes, and to fully reveal the situation, we can indeed introduce
ext4-private superblock state "only internal writes allowed" which can be
used for quota setup. It just requires a bit of tidying and helper
adjustment (in fact I have such patches on my private branch). But it has
occured to me that generally it is easier if the filesystem's remount code
doesn't have to care about racing writers on rw<->ro transitions since we
have many filesystems and making sure all are getting this correct is ...
tedious.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
