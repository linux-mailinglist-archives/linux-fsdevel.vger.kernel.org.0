Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21666E9DB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 23:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjDTVLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 17:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTVLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:11:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBEE9E
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q7x5kZ5TxiQIaPfXzJFB7ZtvsGLdF/4XT+qLIfeZvEs=; b=vnEtrnm74d1qMarGhJIXeyAVZo
        ha0LcHx6YBNRJx0MyW0aNoe04AR89Kt3V0rRdi3wFRTbhM8Z34te8+7glVcfP5Mn4vNlybMnPjj5b
        6w93HXlvAzp/7DCN8417gYM+pqvXI6VsWB3sC9TwH+mIalVIu/2KMVNaKxbF2PKnlM/LneXrjbxC5
        cbJbCu4jyuG52xi8Rj3ctLn4sULUtsIeeYudq/zY7oPkaZIHOGlqG5YHnpiFBb7BUC01rzWzK+e5L
        lMN9T5ywTZ103LfptXfMQ6N/4/UT7yvhe3Ut/FIEF4SU9Noxm62zcaww7d4eywkSoPRmJ5lD+7fdj
        q5r4SJNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppbYV-00Axbx-0F;
        Thu, 20 Apr 2023 21:11:03 +0000
Date:   Thu, 20 Apr 2023 22:11:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        Mark Fasheh <mark@fasheh.com>,
        Christian Brauner <brauner@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org
Subject: Re: [PATCH] vfs: allow using kernel buffer during fiemap operation
Message-ID: <20230420211103.GQ3390869@ZenIV>
References: <000000000000e2102c05eeaf9113@google.com>
 <00000000000031b80705ef5d33d1@google.com>
 <f649c9c0-6c0c-dd0d-e3c9-f0c580a11cd9@I-love.SAKURA.ne.jp>
 <bc30483b-7f9b-df4e-7143-8646aeb4b5a2@I-love.SAKURA.ne.jp>
 <20230420210045.GP3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420210045.GP3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:00:45PM +0100, Al Viro wrote:
> On Mon, Apr 17, 2023 at 11:03:26PM +0900, Tetsuo Handa wrote:
> > syzbot is reporting circular locking dependency between ntfs_file_mmap()
> > (which has mm->mmap_lock => ni->ni_lock => ni->file.run_lock dependency)
> > and ntfs_fiemap() (which has ni->ni_lock => ni->file.run_lock =>
> > mm->mmap_lock dependency), for commit c4b929b85bdb ("vfs: vfs-level fiemap
> > interface") implemented fiemap_fill_next_extent() using copy_to_user()
> > where direct mm->mmap_lock dependency is inevitable.
> > 
> > Since ntfs3 does not want to release ni->ni_lock and/or ni->file.run_lock
> > in order to make sure that "struct ATTRIB" does not change during
> > ioctl(FS_IOC_FIEMAP) request, let's make it possible to call
> > fiemap_fill_next_extent() with filesystem locks held.
> > 
> > This patch adds fiemap_fill_next_kernel_extent() which spools
> > "struct fiemap_extent" to dynamically allocated kernel buffer, and
> > fiemap_copy_kernel_extent() which copies spooled "struct fiemap_extent"
> > to userspace buffer after filesystem locks are released.
> 
> Ugh...  I'm pretty certain that this is a wrong approach.  What is going
> on in ntfs_file_mmap() that requires that kind of locking?
> 
> AFAICS, that's the part that looks odd...  Details, please.

                if (ni->i_valid < to) {
                        if (!inode_trylock(inode)) {
                                err = -EAGAIN;
                                goto out;
                        }
                        err = ntfs_extend_initialized_size(file, ni,
                                                           ni->i_valid, to);
                        inode_unlock(inode);
                        if (err)
                                goto out;
                }

See that inode_trylock() there?  That's another sign of the same
problem; it's just that their internal locks (taken by
ntfs_extend_initialized_size()) are taken without the same
kind of papering over the problem.

'to' here is guaranteed to be under the i_size_read(inode); is
that some kind of delayed allocation?  Or lazy extending
truncate(), perhaps?  I'm not familiar with ntfs codebase (or
ntfs layout, for that matter), so could somebody describe what
exactly is going on in that code?

Frankly, my impression is that this stuff is done in the wrong
place...
