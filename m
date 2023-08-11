Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CB77859A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 04:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjHKCrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 22:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKCrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:47:13 -0400
Received: from out-65.mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FAA2D48;
        Thu, 10 Aug 2023 19:47:11 -0700 (PDT)
Date:   Thu, 10 Aug 2023 22:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691722030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lvvWPsjit5kb/dsuV6RnfP64pD7m4IXtEuVZ591eJhw=;
        b=SZL3Fa7GbHEvZINTmBnnO6nhRSJ2Xt/dBZY9LGS0Z7DUL3GQ1aDp4RyX2fC+g9WPSe3EwG
        aY1V8J5ifOKvMXAdv5GxPIKk4AS/D5UrhjkXO5r5XZCeLRbB5PxKlpu9guqI6ch9i7OjKU
        /UQ8/LIpYwfeUG2e0uz97+cqJH8+Sak=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811024703.7dhu5rz5ovph7uop@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810175205.gtlkydeis37xdxuk@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810175205.gtlkydeis37xdxuk@quack3>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 07:52:05PM +0200, Jan Kara wrote:
> On Thu 10-08-23 11:54:53, Kent Overstreet wrote:
> > > And there clearly is something very strange going on with superblock
> > > handling
> > 
> > This deserves an explanation because sget() is a bit nutty.
> > 
> > The way sget() is conventionally used for block device filesystems, the
> > block device open _isn't actually exclusive_ - sure, FMODE_EXCL is used,
> > but the holder is the fs type pointer, so it won't exclude with other
> > opens of the same fs type.
> > 
> > That means the only protection from multiple opens scribbling over each
> > other is sget() itself - but if the bdev handle ever outlives the
> > superblock we're completely screwed; that's a silent data corruption bug
> > that we can't easily catch, and if the filesystem teardown path has any
> > asynchronous stuff going on (and of course it does) that's not a hard
> > mistake to make. I've observed at least one bug that looked suspiciously
> > like that, but I don't think I quite pinned it down at the time.
> 
> This is just being changed - check Christian's VFS tree. There are patches
> that make sget() use superblock pointer as a bdev holder so the reuse
> you're speaking about isn't a problem anymore.

So then the question is what do you use for identifying the superblock,
and you're switching to the dev_t - interesting.

Are we 100% sure that will never break, that a dev_t will always
identify a unique block_device? Namespacing has been changing things.

> > It also forces the caller to separate opening of the block devices from
> > the rest of filesystem initialization, which is a bit less than ideal.
> > 
> > Anyways, bcachefs just wants to be able to do real exclusive opens of
> > the block devices, and we do all filesystem bringup with a single
> > bch2_fs_open() call. I think this could be made to work with the way
> > sget() wants to work, but it'd require reworking the locking in
> > sget() - it does everything, including the test() and set() calls, under
> > a single spinlock.
> 
> Yeah. Maybe the current upstream changes aren't enough to make your life
> easier for bcachefs, btrfs does its special thing as well after all because
> mount also involves multiple devices for it. I just wanted to mention that
> the exclusive bdev open thing is changing.

I like the mount_bdev() approach in your patch a _lot_ better than the
old code, I think the approach almost works for multi device
filesystems - at least for bcachefs where we always pass in the full
list of devices we want to open, there's no kernel side probing like in
btrfs.

What changes is we'd have to pass a vector of dev_t's to sget(), and
set() needs to be able to stash them in super_block (not s_fs_info, we
need that for bch_fs later and that doesn't exist yet). But that's a
minor detail.

Yeah, this could work.
