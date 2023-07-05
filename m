Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7B4748488
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGENAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGENAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:00:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC6BDA;
        Wed,  5 Jul 2023 06:00:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EB711FDD2;
        Wed,  5 Jul 2023 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688562034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B43XnS/ZC1dC/Q82yVjjHxQcDLXFBbYmz36IV5qBZW4=;
        b=oyEibUT1rTLVIdcA8+kOa4o0o7mcQcUcFrLDtxju7pCpVuGS35ZKXm6wjn1ciY+UgQU5VT
        jzl0077R+cjRERPw49A9e1rcgV6V+unm4vE/5MlbjsRso8q49Y1Uj3Ua5ziT2NH9axGekX
        RE4VKsGYGI3dPaAsHUNuyTVUInr+6J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688562034;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B43XnS/ZC1dC/Q82yVjjHxQcDLXFBbYmz36IV5qBZW4=;
        b=tReyCRoIyEJyNNW2hx+gbIb9Dz8Cl02PYpeWjq/j6tkU+gnhlAcPcGiVyycv63YUPCj4YS
        qgmt2A26iRtaaUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E62813460;
        Wed,  5 Jul 2023 13:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fQN/A3JppWTWXwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 05 Jul 2023 13:00:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 99CBEA0707; Wed,  5 Jul 2023 15:00:33 +0200 (CEST)
Date:   Wed, 5 Jul 2023 15:00:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <20230705130033.ttv6rdywj5bnxlzx@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
 <20230704-fasching-wertarbeit-7c6ffb01c83d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704-fasching-wertarbeit-7c6ffb01c83d@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-07-23 15:59:41, Christian Brauner wrote:
> On Tue, Jul 04, 2023 at 02:56:54PM +0200, Jan Kara wrote:
> > When we don't allow opening of mounted block devices for writing, bind
> > mounting is broken because the bind mount tries to open the block device
> 
> Sorry, I'm going to be annoying now...
> 
> Afaict, the analysis is misleading but I'm happy to be corrected ofc.

I'm not sure what your objection exactly is. Probably I was imprecise in my
changelog description. What gets broken by not allowing RW open of a
mounted block device is:

mount -t ext4 /dev/sda1 /mnt1
mount -t ext4 /dev/sda1 /mnt2

The second mount should create another mount of the superblock created by
the first mount but before that is done, get_tree_bdev() tries to open the
block device and fails when only patches 1 & 2 are applied. This patch
fixes that.

> Finding an existing superblock is independent of mounts. get_tree_bdev()
> and mount_bdev() are really only interested in finding a matching
> superblock independent of whether or not a mount for it already exists.
> IOW, if you had two filesystem contexts for the same block device with
> different mount options:
> 
> T1								T2
> fd_fs = fsopen("ext4");						fd_fs = fsopen("ext4");
> fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");	fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");
> 
> // create superblock
> fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
> 								// finds superblock of T1 if opts are compatible
> 								fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
> 
> you should have the issue that you're describing.

Correct, this will get broken when not allowing RW open for mounted block
devices as well because the second fsconfig(fd_fs, FSCONFIG_CMD_CREATE,
...) will fail to open the block device in get_tree_bdev(). But again this
patch should fix that.

> But for neither of them does a mount already exist as the first mount
> here would only be created when:
> 
> T1								T2
> fsmount(fd_fs);							fsmount(fd_fs);
> 
> is called at which point the whole superblock issue is already settled.
> Afterwards, both mounts of both T1 and T2 refer to the same superblock -
> as long as the fs and the mount options support this ofc.

I guess the confusion comes from me calling "mount" an operation as
performed by the mount(8) command but which is in fact multiple operations
with the new mount API. Anyway, is the motivation of this patch clearer
now?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
