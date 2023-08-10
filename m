Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1B777F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjHJRwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 13:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjHJRwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:52:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A63F103;
        Thu, 10 Aug 2023 10:52:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B0C221868;
        Thu, 10 Aug 2023 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691689926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZ25GytU7V9PgZNVJFOgesoNXDMmwuqCEuLI9Og+gD0=;
        b=3K6fTy/+6iG/SrmpmBGEQBykxWplX1/caGh8yDZmqsCxPfXZ9Dzvo6bt2J7mj7ror0D9II
        /NtQ/NPTpXumjtVhH/ByfA07nTaNLtK4Y/+GgVdSMC8G8KNerhGUZIPSBrnv4bSbBSj15D
        lhlXfYsgJcLvgApKx5zsAZfWC+eCxqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691689926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZ25GytU7V9PgZNVJFOgesoNXDMmwuqCEuLI9Og+gD0=;
        b=KrZiBwadLWs7KzP/JdR/tDkEM8FIxIo7xZll2oJfT8DKJV8u+KbFPTz+K4Aob7QhULMBau
        /xPSqNaLaEb1tzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03E5C138E2;
        Thu, 10 Aug 2023 17:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7pHnAMYj1WSgWgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 17:52:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 83BE3A076F; Thu, 10 Aug 2023 19:52:05 +0200 (CEST)
Date:   Thu, 10 Aug 2023 19:52:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230810175205.gtlkydeis37xdxuk@quack3>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-08-23 11:54:53, Kent Overstreet wrote:
> > And there clearly is something very strange going on with superblock
> > handling
> 
> This deserves an explanation because sget() is a bit nutty.
> 
> The way sget() is conventionally used for block device filesystems, the
> block device open _isn't actually exclusive_ - sure, FMODE_EXCL is used,
> but the holder is the fs type pointer, so it won't exclude with other
> opens of the same fs type.
> 
> That means the only protection from multiple opens scribbling over each
> other is sget() itself - but if the bdev handle ever outlives the
> superblock we're completely screwed; that's a silent data corruption bug
> that we can't easily catch, and if the filesystem teardown path has any
> asynchronous stuff going on (and of course it does) that's not a hard
> mistake to make. I've observed at least one bug that looked suspiciously
> like that, but I don't think I quite pinned it down at the time.

This is just being changed - check Christian's VFS tree. There are patches
that make sget() use superblock pointer as a bdev holder so the reuse
you're speaking about isn't a problem anymore.

> It also forces the caller to separate opening of the block devices from
> the rest of filesystem initialization, which is a bit less than ideal.
> 
> Anyways, bcachefs just wants to be able to do real exclusive opens of
> the block devices, and we do all filesystem bringup with a single
> bch2_fs_open() call. I think this could be made to work with the way
> sget() wants to work, but it'd require reworking the locking in
> sget() - it does everything, including the test() and set() calls, under
> a single spinlock.

Yeah. Maybe the current upstream changes aren't enough to make your life
easier for bcachefs, btrfs does its special thing as well after all because
mount also involves multiple devices for it. I just wanted to mention that
the exclusive bdev open thing is changing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
