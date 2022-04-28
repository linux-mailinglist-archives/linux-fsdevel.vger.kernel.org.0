Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC129512963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 04:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiD1CSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 22:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbiD1CSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:18:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB30224BDA;
        Wed, 27 Apr 2022 19:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9WPJrDp4vG9FlOJS//5VdBXDAGeLkFPrDLuD3sjhCN0=; b=O5sz5XamWaKSxXisFEfSJDFcdW
        aVS7cWKN0MxqAC5mOZtQ9LhMUTv5a76pULETietq/AkwCEnt59h2Zmub6E13e/2g8VkfzWyC72kvn
        kF6aGPSK5b0GytQMmz70RE1z/YfxMjTz7QETSdzN/ydAXyzpV/wYYCvlurK/oZ9v2px4zOKFFna3e
        3iZfFo7FzAn1ePYOPpTCkrBfR8mQLAJYM55PkRQeY6dlzQ5D9NmJSMk1kU1ajxQPLlkbPmACgDkTy
        liT3o+YLP5KVLUC1yhixVSrsrpueqwgUkrAlywLh2+FwbrQOrxZvEm39fD+N300Z6e9E+kC0wGfPg
        15iCT+MQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njtgq-00A6Ho-8z; Thu, 28 Apr 2022 02:15:32 +0000
Date:   Thu, 28 Apr 2022 02:15:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        david@fromorbit.com, djwong@kernel.org, brauner@kernel.org,
        willy@infradead.org, jlayton@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:59:01AM +0000, Al Viro wrote:
> On Tue, Apr 26, 2022 at 07:11:27PM +0800, Yang Xu wrote:
> > Add a dedicated helper to handle the setgid bit when creating a new file
> > in a setgid directory. This is a preparatory patch for moving setgid
> > stripping into the vfs. The patch contains no functional changes.
> > 
> > Currently the setgid stripping logic is open-coded directly in
> > inode_init_owner() and the individual filesystems are responsible for
> > handling setgid inheritance. Since this has proven to be brittle as
> > evidenced by old issues we uncovered over the last months (see [1] to
> > [3] below) we will try to move this logic into the vfs.
> 
> First of all, inode_init_owner() is (and always had been) an optional helper.
> Filesystems are *NOT* required to call it, so putting any common functionality
> in there had always been a mistake.
> 
> That goes for inode_fsuid_set() and inode_fsgid_set() calls as well.
> Consider e.g. this:
> struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
>                              const struct qstr *qstr)
> {
> 	...
>         if (test_opt(sb, GRPID)) {
> 		inode->i_mode = mode;
> 		inode->i_uid = current_fsuid();
> 		inode->i_gid = dir->i_gid;
> 	} else
> 		inode_init_owner(&init_user_ns, inode, dir, mode);
> 
> Here we have an explicit mount option, selecting the way S_ISGID on directories
> is handled.  Mount ext2 with -o grpid and see for yourself - no inode_init_owner()
> calls there.
> 
> The same goes for ext4 - that code is copied there unchanged.
> 
> What's more, I'm not sure that Jann's fix made any sense in the first place.
> After all, the file being created here is empty; exec on it won't give you
> anything - it'll simply fail.  And modifying that file ought to strip SGID,
> or we have much more interesting problems.
> 
> What am I missing here?

BTW, xfs has grpid option as well:
	if (dir && !(dir->i_mode & S_ISGID) && xfs_has_grpid(mp)) {
		inode_fsuid_set(inode, mnt_userns);
		inode->i_gid = dir->i_gid;
		inode->i_mode = mode;
	} else {
		inode_init_owner(mnt_userns, inode, dir, mode);
	}

We could lift that stuff into VFS, but it would require lifting that flag
(BSD vs. SysV behaviour wrt GID - BSD *always* inherits GID from parent
and ignores SGID on directories) into generic superblock.  Otherwise we'd
be breaking existing behaviour for ext* and xfs...
