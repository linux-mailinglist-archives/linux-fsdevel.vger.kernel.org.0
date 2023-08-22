Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E036E783DAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjHVKMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjHVKMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:12:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A4ECE5;
        Tue, 22 Aug 2023 03:11:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 088FF1F85D;
        Tue, 22 Aug 2023 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692699115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/YVbyySg18i1uOcXQyWAmhlJyYaSjI/9UDD6WDlIg8=;
        b=YmFXLYz60sM43jQ35BHS0DpJGS+pbpD/YkOGc8ozVsTw9QrRV2NAFxu6jTa2uLsLLPGK3C
        GSPEFXf4PoS5ugPCGV4les6nNMhs91QLNErbtN8UmXK/6XqjYCAmO4lboDKUc05A08J+zX
        vJIeRCy2nZXRlDuqPFhkLemU4eBN5aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692699115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/YVbyySg18i1uOcXQyWAmhlJyYaSjI/9UDD6WDlIg8=;
        b=Uu+o2ZWQ04qkPbjOHmAVDVp279Yb56IyaNeaeqQhNgmODiEvBDrmf3anfekHf3xaqLQrsk
        N9b2hPyjQSKScQCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB7CD13919;
        Tue, 22 Aug 2023 10:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gbZzOeqJ5GQWHQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 22 Aug 2023 10:11:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7A73FA0774; Tue, 22 Aug 2023 12:11:54 +0200 (CEST)
Date:   Tue, 22 Aug 2023 12:11:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230822101154.7udsf4tdwtns2prj@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
 <20230822053523.GA8949@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822053523.GA8949@sol.localdomain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric!

On Mon 21-08-23 22:35:23, Eric Biggers wrote:
> On Tue, Jul 04, 2023 at 02:56:49PM +0200, Jan Kara wrote:
> > Writing to mounted devices is dangerous and can lead to filesystem
> > corruption as well as crashes. Furthermore syzbot comes with more and
> > more involved examples how to corrupt block device under a mounted
> > filesystem leading to kernel crashes and reports we can do nothing
> > about. Add tracking of writers to each block device and a kernel cmdline
> > argument which controls whether writes to block devices open with
> > BLK_OPEN_BLOCK_WRITES flag are allowed. We will make filesystems use
> > this flag for used devices.
> > 
> > Syzbot can use this cmdline argument option to avoid uninteresting
> > crashes. Also users whose userspace setup does not need writing to
> > mounted block devices can set this option for hardening.
> > 
> > Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Can you make it clear that the important thing this patch prevents is
> writes to the block device's buffer cache, not writes to the underlying
> storage?  It's super important not to confuse the two cases.

Right, I've already updated the description of the help text in the kconfig
to explicitely explain that this does not prevent underlying device content
from being modified, it just prevents writes the the block device itself.
But I guess I can also explain this (with a bit more technical details) in
the changelog. Good idea.

> Related to this topic, I wonder if there is any value in providing an option
> that would allow O_DIRECT writes but forbid buffered writes?  Would that be
> useful for any of the known use cases for writing to mounted block devices?

I'm not sure how useful that would be but it would be certainly rather
difficult to implement. The problem is we can currently fallback from
direct to buffered IO as we see fit, also we need to invalidate page cache
while doing direct IO which can fail etc. So it will be a rather nasty can
of worms to open...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
