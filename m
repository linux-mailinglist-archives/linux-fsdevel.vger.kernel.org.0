Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF355E53EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIUTq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 15:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIUTq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:46:28 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150CA024C
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3R0/g1oGmJpzM2w9fxy9DeTxLCCVxlCzYRXnJIpGmf0=; b=heSX/9g+zKJ0dqB1KfAAeg6gCf
        6v5aTwiOTh4SlOusTQoUHgPzM2MeIKtdzdE5dsss2RgTWEfRdrIc4FeOyBpWKEyvFlptR9rLJnG5I
        H8z5w1Zqw8HMCMlecsi6vV+1wX1h42YZYIr7ZTwayI/SeG1hzT6GIHn5Xnui85u1XEgCd4j7T6zH6
        Npj+Oh1XCZy3NdM0qwGc41CVJGiUunuekNhba1onXAvqoTNB1KZYutYm95hLT/rNqFIGEo0pgapSf
        zgRtvJGTDPUFlK9F/fGp6RNzf7AdeJSmzLujl1/fol+UmqxNjeSj7buZPvfKN+8lwP4piKO4hnNhp
        wzFca+tw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ob5fo-002AaL-39;
        Wed, 21 Sep 2022 19:46:21 +0000
Date:   Wed, 21 Sep 2022 20:46:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 4/9] cachefiles: use tmpfile_open() helper
Message-ID: <YytqDFxJIvu7+Ayz@ZenIV>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-5-mszeredi@redhat.com>
 <20220921082612.n5z43657f6t3z37s@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921082612.n5z43657f6t3z37s@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:26:12AM +0200, Christian Brauner wrote:
> -       /* From now path refers to the tmpfile */
> +
> +       /* prepare tmp path */
> +       path.mnt = cache->mnt;
>         path.dentry = file->f_path.dentry;

Do we even want that struct path from that point on?  Look:

	d_backing_inode(path.dentry) is a weird way to spell file_inode(file).

	cachefiles_mark_inode_in_use() is an overkill here - it *can't* fail
here, so all we want is
	inode_lock(inode);
	inode->i_flags |= S_KERNEL_FILE;
	trace_cachefiles_mark_active(object, inode);
	inode_unlock(inode);
where inode is, again, file_inode(file).

	cachefiles_do_unmark_inode_in_use() uses only inode.

	vfs_truncate() could use &file->f_path, but there's a potentially
nastier problem - theoretically, there are filesystems where we might
want struct file available for operation, especially for opened-and-unlinked
equivalents.  In any case, &file->f_path would do just as well as its copy.
