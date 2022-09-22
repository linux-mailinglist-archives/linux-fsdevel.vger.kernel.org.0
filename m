Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7D5E5CD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIVIEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIVIEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:04:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F8B66
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3192B81FAE
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B13C43144;
        Thu, 22 Sep 2022 08:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663833866;
        bh=hBp7Z/E82/YG4m3yDOIZmaFPRG0Hw2c3Fs88maNy918=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uL9Udc07x4MAilF58aGt2sW5kEpaqCbpnvwPDWrIxz238TMkR89CFLkXi8k2YkR/p
         TSaV9epS4XZ03nR+5CFhZw3zi9gwqw/EObsQRQ/v45ySZ2gwfK3Ru4Ish6/E0AtILn
         YKBOLVRjSOWTYLY8PvamiXOmi1RWYHuU7B0ui0B/QFMkul8yDFb7+roanbPkHVSeEt
         JzIWHrzIyfxoDNkE9ewYa50+5sQkeDE2zaLCXFBfvTimZ9GSGaHb42LR9Yvc40DAD1
         7V1WrkOElIQfRasGbT6UHxkctw5Tjb4G71Eh6RL0f7W+4d86FFvyTmkc2734d6vt0b
         G8OuiPZTlXJ2A==
Date:   Thu, 22 Sep 2022 10:04:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 4/9] cachefiles: use tmpfile_open() helper
Message-ID: <20220922080421.h6t6myeaqtwzsu4h@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-5-mszeredi@redhat.com>
 <20220921082612.n5z43657f6t3z37s@wittgenstein>
 <YytqDFxJIvu7+Ayz@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YytqDFxJIvu7+Ayz@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:46:20PM +0100, Al Viro wrote:
> On Wed, Sep 21, 2022 at 10:26:12AM +0200, Christian Brauner wrote:
> > -       /* From now path refers to the tmpfile */
> > +
> > +       /* prepare tmp path */
> > +       path.mnt = cache->mnt;
> >         path.dentry = file->f_path.dentry;
> 
> Do we even want that struct path from that point on?  Look:
> 
> 	d_backing_inode(path.dentry) is a weird way to spell file_inode(file).
> 
> 	cachefiles_mark_inode_in_use() is an overkill here - it *can't* fail
> here, so all we want is
> 	inode_lock(inode);
> 	inode->i_flags |= S_KERNEL_FILE;
> 	trace_cachefiles_mark_active(object, inode);
> 	inode_unlock(inode);
> where inode is, again, file_inode(file).
> 
> 	cachefiles_do_unmark_inode_in_use() uses only inode.
> 
> 	vfs_truncate() could use &file->f_path, but there's a potentially
> nastier problem - theoretically, there are filesystems where we might
> want struct file available for operation, especially for opened-and-unlinked
> equivalents.  In any case, &file->f_path would do just as well as its copy.

Yeah, sounds reasonable.
