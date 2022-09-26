Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1025E9CEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiIZJGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbiIZJGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:06:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3458839B9F;
        Mon, 26 Sep 2022 02:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 286BDB8076E;
        Mon, 26 Sep 2022 09:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A980C433D7;
        Mon, 26 Sep 2022 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664183118;
        bh=0g86jOVv3VeJ8lk0JCkQymoiaTts5ZO0mxnD94+cDig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNwm0JGLH6PEK2b/4/REbfim6kqxRnjv5mLiSrtb19n54sh6VVtQtx9vNJYH1kaNL
         a7H5kPypEC4KnbzDPkWGWvqsdYxdlweAHF/nmNZZa40nA2EPtdpUawy/4mkLpJwiij
         3AFkAwbWOOQvABeJMtAvbww4B/Y/UM8xbxUnpcKyKb94p/A4Ic9FRs28nWQrxtLNeJ
         qi1SaHlXgMTmCIK6b1ElKx9InThJLjT8bCRA4dAsnoFAVXQA/GMcthIVSQ0vw2Z8Mn
         VXK6e7sxxaFSEYEqmvtWp6Q2q70YbpGu8VOQE+sgCNiVxjlxw50vWvm3ZtfN+QiXrl
         oJmCu6jFzczlQ==
Date:   Mon, 26 Sep 2022 11:05:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
Message-ID: <20220926090513.hn3ylkakb5wf2rrx@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-11-brauner@kernel.org>
 <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
 <20220923064707.GD16489@lst.de>
 <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
 <CAHC9VhS3NWfMk3uHxZSZMtDay4FqOYzTf9mKCy1=Rb22r-2P4A@mail.gmail.com>
 <20220923143540.howryhuygxi2hsj3@wittgenstein>
 <CAHC9VhRZf+OAzc96=c2s3NqkizNh2tZbLF8OFPHbFFuFXEZ8sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRZf+OAzc96=c2s3NqkizNh2tZbLF8OFPHbFFuFXEZ8sA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 01:35:08PM -0400, Paul Moore wrote:
> On Fri, Sep 23, 2022 at 10:35 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Fri, Sep 23, 2022 at 10:26:35AM -0400, Paul Moore wrote:
> > > On Fri, Sep 23, 2022 at 3:57 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > On Fri, Sep 23, 2022 at 08:47:07AM +0200, Christoph Hellwig wrote:
> > > > > On Thu, Sep 22, 2022 at 01:16:57PM -0400, Paul Moore wrote:
> > > > > > properly review the changes, but one thing immediately jumped out at
> > > > > > me when looking at this: why is the LSM hook
> > > > > > "security_inode_set_acl()" when we are passing a dentry instead of an
> > > > > > inode?  We don't have a lot of them, but there are
> > > > > > `security_dentry_*()` LSM hooks in the existing kernel code.
> > > > >
> > > > > I'm no LSM expert, but isn't the inode vs dentry for if it is
> > > > > related to an inode operation or dentry operation, not about that
> > > > > the first argument is?
> > > >
> > > > Indeed. For example ...
> > >
> > > If the goal is for this LSM hook to operate on an inode and not a
> > > dentry, let's pass it an inode instead.  This should help prevent
> >
> > I would be ok with that but EVM requires a dentry being passed and as
> > evm is called from security_inode_set_acl() exactly like it is from
> > security_inode_setxattr() and similar the hook has to take a dentry.
> 
> If a dentry is truly needed by EVM (a quick look indicates that it may
> just be for the VFS getxattr API, but I haven't traced the full code
> path), then I'm having a hard time reconciling that this isn't a
> dentry operation.  Yes, I get that the ACLs belong to the inode and
> not the dentry, but then why do we need the dentry?  It seems like the
> interfaces are broken slightly, or at least a little odd ... <shrug>

There's multiple reasons for the generic xattr api to take a dentry. For
example, there are quite a few filesystems that require dentry access
during (specific or all) xattr operations. So ideally, we'd just want to
pass the dentry I'd say. But we can't do that because of security
modules. 

Some security modules call security_d_instantiate() which in turn calls
__vfs_{g,s}et_xattr() in the hook implementation. That's at least true
of SELinux and Smack iirc. They want dentry and inode but
security_d_instantiate() is called in e.g., d_instantiate and d_add()
before the inode is attached to the dentry:

selinux_d_instantiate()
-> inode_doinit_with_dentry()
   -> inode_doinit_use_xattr()
      -> __vfs_getxattr()

smack_d_instantiate()
-> __vfs_getxattr()
-> __vfs_setxattr()

So that mandates both dentry and inode in vfs xattr helpers.

I don't think we can and want to solve this in this patchset. For now we
can stick with the naming as set by precedent and then in the future the
security modules can decide whether they want to do a rename patchset
for most of the xattr hooks at some point.

> 
> > And I want to minimize - ideally get rid of at some point - separate
> > calls to security_*() and evm_*() or ima_() in the vfs. So the evm hook
> > should please stay in there.
> 
> For the record, I want to get rid of the IMA and EVM specific hooks in
> the kernel.  They were a necessity back when there could only be one
> LSM active at a given time, but with that no longer the case I see
> little reason why IMA/EVM/etc. remain separate; it makes the code
> worse and complicates a lot of things both at the LSM layer as well as
> the rest of the kernel.  I've mentioned this to a few people,
> including Mimi, and it came up during at talk at LPC this year.

Sounds good.
