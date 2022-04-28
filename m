Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF951292E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 03:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiD1CCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 22:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiD1CCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:02:16 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D4B5DA75;
        Wed, 27 Apr 2022 18:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vIEyyyUKJd74cDHCrWq4r5eal6qL9XuP5zN2hfnktRA=; b=eUvkO+oAuZh1zd0iy5EtZz5oX6
        A5Bn+Szk1s8uftZWcx+J/JVR9gxCo01JtGamqcJb6y+thOm8aJNABE8F+B22BI/EBTaK0+pfNYoBg
        injkaqHuXMUx7R4jAaKUjp5hqV1Eo0HSVGkFGe9GdUzXmxtx6fXrq4V+H5t+mJG16YhoOD151+rkg
        1q7EwMhXpKySfxUbtN5BwE2FRg6iMU4ewc9som6wBj2a0YkJPVEr0u5wip0UrG/76/KLdPEPk2skB
        R993XsEwfKj8VZRYeVKLPgvrXTNCULfJf+yyv4c8wzRWX2fwmxFDCnA/Qs5Tk85u6UYNvj3h07t7u
        l4JBrXOg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njtQr-00A66m-TY; Thu, 28 Apr 2022 01:59:02 +0000
Date:   Thu, 28 Apr 2022 01:59:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        david@fromorbit.com, djwong@kernel.org, brauner@kernel.org,
        willy@infradead.org, jlayton@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:11:27PM +0800, Yang Xu wrote:
> Add a dedicated helper to handle the setgid bit when creating a new file
> in a setgid directory. This is a preparatory patch for moving setgid
> stripping into the vfs. The patch contains no functional changes.
> 
> Currently the setgid stripping logic is open-coded directly in
> inode_init_owner() and the individual filesystems are responsible for
> handling setgid inheritance. Since this has proven to be brittle as
> evidenced by old issues we uncovered over the last months (see [1] to
> [3] below) we will try to move this logic into the vfs.

First of all, inode_init_owner() is (and always had been) an optional helper.
Filesystems are *NOT* required to call it, so putting any common functionality
in there had always been a mistake.

That goes for inode_fsuid_set() and inode_fsgid_set() calls as well.
Consider e.g. this:
struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
                             const struct qstr *qstr)
{
	...
        if (test_opt(sb, GRPID)) {
		inode->i_mode = mode;
		inode->i_uid = current_fsuid();
		inode->i_gid = dir->i_gid;
	} else
		inode_init_owner(&init_user_ns, inode, dir, mode);

Here we have an explicit mount option, selecting the way S_ISGID on directories
is handled.  Mount ext2 with -o grpid and see for yourself - no inode_init_owner()
calls there.

The same goes for ext4 - that code is copied there unchanged.

What's more, I'm not sure that Jann's fix made any sense in the first place.
After all, the file being created here is empty; exec on it won't give you
anything - it'll simply fail.  And modifying that file ought to strip SGID,
or we have much more interesting problems.

What am I missing here?
