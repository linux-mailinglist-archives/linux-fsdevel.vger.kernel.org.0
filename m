Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D273077A44A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 02:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjHMAMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 20:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHMAMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA861BF;
        Sat, 12 Aug 2023 17:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6468760C0D;
        Sun, 13 Aug 2023 00:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D50C433C8;
        Sun, 13 Aug 2023 00:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691885524;
        bh=bwqubNE/BEVz53GnFxj6+8ZGHKYg4LZCw5dTVbguT4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dStYOOztzsFwc0Qxjkol+hoJsqrvN/bQsOHfhIXkdK9duUiOYzqcqT0zIJZNxpdnh
         D2Ph2T6XFQWMqLw4+FVLn7NN/sgwRslI2716muY8y/1bb8oytaHU7zvKY4zsCDRUpC
         XoAXgxaCgDMeBw2NOpbLB/jd6mKiQfFK5uXhuaatW8B6F7uos14KklFd7D49b8e39J
         VGnJ18n685UlW0I1M0RwOe7aYF6T+AcTQYFdc/k0DmXyZp0UMFZxEiO9FZ2CcDRx0h
         FgPwOW0w1/J7WqcfSVISdbRbGNnnC+couVhqrr2zt4qF1by1eQA9oWwgoYUGVYK31x
         0mZOdTAWbYf5Q==
Date:   Sat, 12 Aug 2023 17:12:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <20230813001202.GE41642@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
 <20230812015915.GA971@sol.localdomain>
 <20230812230647.GB2247938@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812230647.GB2247938@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 12, 2023 at 07:06:47PM -0400, Theodore Ts'o wrote:
> On Fri, Aug 11, 2023 at 06:59:15PM -0700, Eric Biggers wrote:
> > 
> > To be honest I've always been confused about why the ->s_encoding check is
> > there.  It looks like Ted added it in 6456ca6520ab ("ext4: fix kernel oops
> > caused by spurious casefold flag") to address a fuzzing report for a filesystem
> > that had a casefolded directory but didn't have the casefold feature flag set.
> > It seems like an unnecessarily complex fix, though.  The filesystem should just
> > reject the inode earlier, in __ext4_iget().  And likewise for f2fs.  Then no
> > other code has to worry about this problem.
> 
> the casefold flag can get set *after* the inode has been fetched, but before
> you try to use it.  This can happen because syzbot has opened the block device
> for writing, and edits the superblock while it is mounted.

I don't see how that is relevant here.

I think the actual problem you're hinting at is that checking the casefold
feature after the filesystem has been mounted is not guaranteed to work
properly, as ->s_encoding will be NULL if the casefold feature was not present
at mount time.  If we'd like to be robust in the event of the casefold feature
being concurrently enabled by a write to the block device, then all we need to
do is avoid checking the casefold feature after mount time, and instead check
->s_encoding.  I believe __ext4_iget() is still the only place it's needed.

> One could say that this is an insane threat model, but the syzbot team
> thinks that this can be used to break out of a kernel lockdown after a
> UEFI secure boot.  Which is fine, except I don't think I've been able
> to get any company (including Google) to pay for headcount to fix
> problems like this, and the unremitting stream of these sorts of
> syzbot reports have already caused one major file system developer to
> burn out and step down.
> 
> So problems like this get fixed on my own time, and when I have some
> free time.  And if we "simplify" the code, it will inevitably cause
> more syzbot reports, which I will then have to ignore, and the syzbot
> team will write more "kernel security disaster" slide deck
> presentations to senior VP's, although I'll note this has never
> resulted in my getting any additional SWE's to help me fix the
> problem...
> 
> > So just __ext4_iget() needs to be fixed.  I think we should consider doing that
> > before further entrenching all the extra ->s_encoding checks.
> 
> If we can get an upstream kernel consensus that syzbot reports caused
> by writing to a mounted file system aren't important, and we can
> publish this somewhere where hopefully the syzbot team will pay
> attention to it, sure...

But, more generally, I think it's clear that concurrent writes to the block
device's page cache is not something that filesystems can be robust against.  I
think this needs to be solved by providing an option to forbid this, as Jan
Kara's patchset "block: Add config option to not allow writing to mounted
devices" does, and then transitioning legacy use cases to new APIs.

Yes, "transitioning legacy use cases" will be a lot of work.  And if The Linux
Filesystem Maintainers(TM) do not have time for it, that's the way it is.
Someone who cares about it (such as someone who actually cares about the
potential impact on the Lockdown feature) will need to come along and do it.

But I think that should be the plan, and The Linux Filesystem Maintainers(TM) do
not need to try to play whack-a-mole with "fixing" filesystem code to be
consistently revalidating already-validated cached metadata.

- Eric
