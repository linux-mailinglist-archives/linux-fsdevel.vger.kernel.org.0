Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA784DC86D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 15:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiCQONZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 10:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiCQONY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:13:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F861FDFF1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 07:12:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0172F21112;
        Thu, 17 Mar 2022 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647526326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAbCmstn3v6PAUvpjCksJHTJhgmx0iEqIR4eNG4asGE=;
        b=C0o9YNssqvuv2SsGlXQhXDe9J1Z/k1VzXDWJARZB8ragmmIRc412Yn37KRYqwoLZPRrHQp
        +E8MYnCT/AhFr+bPEhoiluwbSiidEOHbzWkEJ1r0Sk3Y9epMpns+GQpUqz9HR54qnzxNgT
        OnWp4LXxn7zVyiT61co8Ca+eCNJ74Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647526326;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAbCmstn3v6PAUvpjCksJHTJhgmx0iEqIR4eNG4asGE=;
        b=dN71qwPzcJRjkijOGKwE9Eiz1Q081TtC0Xgji+lRR5FKMnNXYPfMtYsdkmvt+HAE/5SKyM
        6wjLkq9e/GtiBqAg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 19FDAA3B88;
        Thu, 17 Mar 2022 14:12:05 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B3DABA0615; Thu, 17 Mar 2022 15:12:04 +0100 (CET)
Date:   Thu, 17 Mar 2022 15:12:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Volatile fanotify marks
Message-ID: <20220317141204.hbpflysc7p5e5vdo@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307155741.1352405-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-03-22 17:57:36, Amir Goldstein wrote:
> Jan,
> 
> Following RFC discussion [1], following are the volatile mark patches.
> 
> Tested both manually and with this LTP test [2].
> I was struggling with this test for a while because drop caches
> did not get rid of the un-pinned inode when test was run with
> ext2 or ext4 on my test VM. With xfs, the test works fine for me,
> but it may not work for everyone.
> 
> Perhaps you have a suggestion for a better way to test inode eviction.

Drop caches does not evict dirty inodes. The inode is likely dirty because
you have chmodded it just before drop caches. So I think calling sync or
syncfs before dropping caches should fix your problems with ext2 / ext4.  I
suspect this has worked for XFS only because it does its private inode
dirtiness tracking and keeps the inode behind VFS's back.

								Honza

> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com/
> [2] https://github.com/amir73il/ltp/commits/fan_volatile
> 
> Amir Goldstein (5):
>   fsnotify: move inotify control flags to mark flags
>   fsnotify: pass flags argument to fsnotify_add_mark()
>   fsnotify: allow adding an inode mark without pinning inode
>   fanotify: add support for exclusive create of mark
>   fanotify: add support for "volatile" inode marks
> 
>  fs/notify/fanotify/fanotify_user.c   | 32 +++++++++--
>  fs/notify/fsnotify.c                 |  4 +-
>  fs/notify/inotify/inotify_fsnotify.c |  2 +-
>  fs/notify/inotify/inotify_user.c     | 40 +++++++++-----
>  fs/notify/mark.c                     | 83 +++++++++++++++++++++++-----
>  include/linux/fanotify.h             |  9 ++-
>  include/linux/fsnotify_backend.h     | 32 ++++++-----
>  include/uapi/linux/fanotify.h        |  2 +
>  kernel/audit_fsnotify.c              |  3 +-
>  9 files changed, 151 insertions(+), 56 deletions(-)
> 
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
