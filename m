Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E980477BE3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjHNQk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 12:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjHNQjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:39:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28091113;
        Mon, 14 Aug 2023 09:39:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C830021885;
        Mon, 14 Aug 2023 16:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692031191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5/rpAVnFlU5HcJqLfLhAr998FujJ4CT+zGKnzFZKh8=;
        b=yTHMbFDAc4CcCBwa6sxKMnDkqTqZG6CUeE7wH7YXr58CdKYko7ycw5Cl8iU6H6q35/ouRU
        V+DtrenC518JU9WtV8nKA0HPWQl6on5zw/IBa4UirO6NB1lRXCwBgRzZx4W7wuZ6gJ339o
        ksAYZSRwn1wXCjgDuukLRHd9HCPGVZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692031191;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5/rpAVnFlU5HcJqLfLhAr998FujJ4CT+zGKnzFZKh8=;
        b=agZa/XAPfqFrFlBYfDZhniuV111ShOHnuQiJI/ztjkLFFOgJ8Kein/WirFb7TrGRZHUwnE
        yeq3EfTm4MqHDhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B39D7138EE;
        Mon, 14 Aug 2023 16:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1jF1K9dY2mSCOQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 16:39:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 313C1A0769; Mon, 14 Aug 2023 18:39:51 +0200 (CEST)
Date:   Mon, 14 Aug 2023 18:39:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mike Fleetwood <mike.fleetwood@googlemail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH RFC 0/6 v2] block: Add config option to not allow writing
 to mounted devices
Message-ID: <20230814163951.zhrpuplkkqhi6dyw@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <CAMU1PDj7f4RGBKLaN5zLFTTERnF9NFPq3RxuWygSWnzUthnKWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMU1PDj7f4RGBKLaN5zLFTTERnF9NFPq3RxuWygSWnzUthnKWQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 13:27:03, Mike Fleetwood wrote:
> On Tue, 4 Jul 2023 at 13:57, Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > This is second version of the patches to add config option to not allow writing
> > to mounted block devices. For motivation why this is interesting see patch 1/6.
> > I've been testing the patches more extensively this time and I've found couple
> > of things that get broken by disallowing writes to mounted block devices:
> > 1) Bind mounts get broken because get_tree_bdev() / mount_bdev() first try to
> >    claim the bdev before searching whether it is already mounted. Patch 6
> >    reworks the mount code to avoid this problem.
> > 2) btrfs mounting is likely having the same problem as 1). It should be fixable
> >    AFAICS but for now I've left it alone until we settle on the rest of the
> >    series.
> > 3) "mount -o loop" gets broken because util-linux keeps the loop device open
> >    read-write when attempting to mount it. Hopefully fixable within util-linux.
> > 4) resize2fs online resizing gets broken because it tries to open the block
> >    device read-write only to call resizing ioctl. Trivial to fix within
> >    e2fsprogs.
> >
> > Likely there will be other breakage I didn't find yet but overall the breakage
> > looks minor enough that the option might be useful. Definitely good enough
> > for syzbot fuzzing and likely good enough for hardening of systems with
> > more tightened security.
> 
> 5) Online e2label will break because it directly writes to the ext2/3/4
>    superblock while the FS is mounted to set the new label.  Ext4 driver
>    will have to implement the SETFSLABEL ioctl() and e2label will have
>    to use it, matching what happens for online labelling of btrfs and
>    xfs.

Thanks, added to the description.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
