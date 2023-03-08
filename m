Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6016B0FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 18:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCHRMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 12:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCHRMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:12:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5E5C4E85;
        Wed,  8 Mar 2023 09:12:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86C1F21A6D;
        Wed,  8 Mar 2023 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678295527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VoLUBOTj+2wOOT9gojYTnc048S/CpdP8U6xaXJdOoRQ=;
        b=WQcIeXgIxvKvCqlDniZcyPtNPc890uHl1Hh9sXCyHvKMZhnnNFwzzB9AQm/Oprw+a3xRNi
        j19CmkhXCuMhfOAvv6S+2Ms+Pv20PfgKNTaBIFQKC5ZI6FbfsXiWk3rgUF/VPaZLt/sGuX
        KMwVnQow5m4C4PXk1/FuUQp3+Y3QGl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678295527;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VoLUBOTj+2wOOT9gojYTnc048S/CpdP8U6xaXJdOoRQ=;
        b=bJPv7LW87gduXY6cx5LZcqwoJ1/uNwUZbRE2FgXAFrMeyW3CGfmozcQNCtIlrxs1DnGdPB
        q50siObtpTEkGUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7889F1348D;
        Wed,  8 Mar 2023 17:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q2ZjHefBCGQFTAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Mar 2023 17:12:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 00A45A06FF; Wed,  8 Mar 2023 18:12:06 +0100 (CET)
Date:   Wed, 8 Mar 2023 18:12:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [LSF TOPIC] online repair of filesystems: what next?
Message-ID: <20230308171206.zuci3wdd3yg7amw5@quack3>
References: <Y/5ovz6HI2Z47jbk@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/5ovz6HI2Z47jbk@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

I'm interested in this topic. Some comments below.

On Tue 28-02-23 12:49:03, Darrick J. Wong wrote:
> Five years ago[0], we started a conversation about cross-filesystem
> userspace tooling for online fsck.  I think enough time has passed for
> us to have another one, since a few things have happened since then:
> 
> 1. ext4 has gained the ability to send corruption reports to a userspace
>    monitoring program via fsnotify.  Thanks, Collabora!
> 
> 2. XFS now tracks successful scrubs and corruptions seen during runtime
>    and during scrubs.  Userspace can query this information.
> 
> 3. Directory parent pointers, which enable online repair of the
>    directory tree, is nearing completion.
> 
> 4. Dave and I are working on merging online repair of space metadata for
>    XFS.  Online repair of directory trees is feature complete, but we
>    still have one or two unresolved questions in the parent pointer
>    code.
> 
> 5. I've gotten a bit better[1] at writing systemd service descriptions
>    for scheduling and performing background online fsck.
> 
> Now that fsnotify_sb_error exists as a result of (1), I think we
> should figure out how to plumb calls into the readahead and writeback
> code so that IO failures can be reported to the fsnotify monitor.  I
> suspect there may be a few difficulties here since fsnotify (iirc)
> allocates memory and takes locks.

Well, if you want to generate fsnotify events from an interrupt handler,
you're going to have a hard time, I don't have a good answer for that. But
offloading of error event generation to a workqueue should be doable (and
event delivery is async anyway so from userspace POV there's no
difference). Otherwise locking shouldn't be a problem AFAICT. WRT memory
allocation, we currently preallocate the error events to avoid the loss of
event due to ENOMEM. With current usecases (filesystem catastrophical error
reporting) we have settled on a mempool with 32 preallocated events (note
that preallocated event gets used only if normal kmalloc fails) for
simplicity. If the error reporting mechanism is going to be used
significantly more, we may need to reconsider this but it should be doable.
And frankly if you have a storm of fs errors *and* the system is going
ENOMEM at the same time, I have my doubts loosing some error report is
going to do any more harm ;).

> As a result of (2), XFS now retains quite a bit of incore state about
> its own health.  The structure that fsnotify gives to userspace is very
> generic (superblock, inode, errno, errno count).  How might XFS export
> a greater amount of information via this interface?  We can provide
> details at finer granularity -- for example, a specific data structure
> under an allocation group or an inode, or specific quota records.

Fsnotify (fanotify in fact) interface is fairly flexible in what can be
passed through it. So if you need to pass some (reasonably short) binary
blob to userspace which knows how to decode it, fanotify can handle that
(with some wrapping). Obviously there's a tradeoff to make how much of the
event is generic (as that is then easier to process by tools common for all
filesystems) and how much is fs specific (which allows to pass more
detailed information). But I guess we need to have concrete examples of
events to discuss this.

> With (4) on the way, I can envision wanting a system service that would
> watch for these fsnotify events, and transform the error reports into
> targeted repair calls in the kernel.  This of course would be very
> filesystem specific, but I would also like to hear from anyone pondering
> other usecases for fsnotify filesystem error monitors.

I think when we do report IO errors (or ENOSPC, EDQUOT errors for that
matter) through fsnotify, there would be some interesting system-health
monitoring usecases. But I don't know about anybody working on this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
