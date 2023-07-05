Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1C74855C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjGENq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGENq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C80BA;
        Wed,  5 Jul 2023 06:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6756C61569;
        Wed,  5 Jul 2023 13:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBB4C433C8;
        Wed,  5 Jul 2023 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688564784;
        bh=fF4OTK0l/0gKFko4faovv/YXnqcMhxu3JD/4SmKhjkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cnu6fNY96eKxSAg6ligcBUWu0R4BbWpP8c9+nAST6TkPS1KYK0YdxPGJiM3hWnXeY
         u8zQDC/oLviyGtFrfpQZ8wpRi9LFELjqMCX5XiMzhb+XvGZRtYG5pipUNKhE7joI/S
         wpBTuGUI807UsHESXyZRvHl8QYVMjc1VrHm6Nv0vrGd45mmh8pOryEdeZJ08l8oCmx
         iSjEJFgZ9oVwaLOiStgwkDRjHk+T9cti+RO4M29ac7hYxUdEzrhnyKeQ2hX1cBCKaK
         4iJrSbaATo3lOHyCcd1PMS0PFdGMxXk5T3/ES+oycwZ56/XTXIF0vdbRjv4mlGLJ1z
         KwjlFjJMIlDVg==
Date:   Wed, 5 Jul 2023 15:46:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <20230705-pumpwerk-vielversprechend-a4b1fd947b65@brauner>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
 <20230704-fasching-wertarbeit-7c6ffb01c83d@brauner>
 <20230705130033.ttv6rdywj5bnxlzx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230705130033.ttv6rdywj5bnxlzx@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 05, 2023 at 03:00:33PM +0200, Jan Kara wrote:
> On Tue 04-07-23 15:59:41, Christian Brauner wrote:
> > On Tue, Jul 04, 2023 at 02:56:54PM +0200, Jan Kara wrote:
> > > When we don't allow opening of mounted block devices for writing, bind
> > > mounting is broken because the bind mount tries to open the block device
> > 
> > Sorry, I'm going to be annoying now...
> > 
> > Afaict, the analysis is misleading but I'm happy to be corrected ofc.
> 
> I'm not sure what your objection exactly is. Probably I was imprecise in my
> changelog description. What gets broken by not allowing RW open of a
> mounted block device is:
> 
> mount -t ext4 /dev/sda1 /mnt1
> mount -t ext4 /dev/sda1 /mnt2
> 
> The second mount should create another mount of the superblock created by
> the first mount but before that is done, get_tree_bdev() tries to open the
> block device and fails when only patches 1 & 2 are applied. This patch
> fixes that.

My objection is that this has nothing to do with mounts but with
superblocks. :) No mount need exist for this issue to appear. And I would
prefer if we keep superblock and mount separate as this leads to unclear
analysis and changelogs.

> 
> > Finding an existing superblock is independent of mounts. get_tree_bdev()
> > and mount_bdev() are really only interested in finding a matching
> > superblock independent of whether or not a mount for it already exists.
> > IOW, if you had two filesystem contexts for the same block device with
> > different mount options:
> > 
> > T1								T2
> > fd_fs = fsopen("ext4");						fd_fs = fsopen("ext4");
> > fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");	fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");
> > 
> > // create superblock
> > fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
> > 								// finds superblock of T1 if opts are compatible
> > 								fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
> > 
> > you should have the issue that you're describing.
> 
> Correct, this will get broken when not allowing RW open for mounted block
> devices as well because the second fsconfig(fd_fs, FSCONFIG_CMD_CREATE,
> ...) will fail to open the block device in get_tree_bdev(). But again this
> patch should fix that.
> 
> > But for neither of them does a mount already exist as the first mount
> > here would only be created when:
> > 
> > T1								T2
> > fsmount(fd_fs);							fsmount(fd_fs);
> > 
> > is called at which point the whole superblock issue is already settled.
> > Afterwards, both mounts of both T1 and T2 refer to the same superblock -
> > as long as the fs and the mount options support this ofc.
> 
> I guess the confusion comes from me calling "mount" an operation as
> performed by the mount(8) command but which is in fact multiple operations
> with the new mount API. Anyway, is the motivation of this patch clearer
> now?

I'm clear about what you're doing here. I would just like to not have
mounts brought into the changelog. Even before the new mount api what
you were describing was technically a superblock only issue. If someone
reads the changelog I want them to be able to clearly see that this is a
fix for superblocks, not mounts.

Especially, since the code you touch really only has to to with
superblocks.
Let me - non ironically - return the question: Is my own request clearer
now?
