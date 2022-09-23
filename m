Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C691B5E7D40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiIWOfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIWOft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:35:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1471FF2749;
        Fri, 23 Sep 2022 07:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6CDBFCE1D99;
        Fri, 23 Sep 2022 14:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BB1C433D6;
        Fri, 23 Sep 2022 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663943745;
        bh=DdF96u5j6/L8HBsQnaNvzSkm4TyDzMSKWOuoTtKxJMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCjic3MXr5dJG0qd9tx58fwBrtDo6SJ9DgJSMHZ0xrWfnwdk2hAwhoIW2DPTxK6G/
         DAQnnRhlo8CthAJ29Pn0hOcameuOy+ykMPXHgSL7727t3okjeLaqJEVa7qZuYVlBMF
         BT+qdmeUIQHDJVt67rBdWTIFmHpslOc4WVI4cKEuKQJUFKj+BxyQxNWj4Y1MFNRDet
         5iFuGCQOMFtJSpqkiApBhlTxfN4+SnZKN4uSWg/CtDORPIee4InIkf/uy6jwBRaYIO
         /zlrpYTKpS85ZCrAbPghczSfMUWjSTfvWOePR0QdIrcreFH3tL5LOHD0QjLy162M0D
         P6npr/rZSxxvg==
Date:   Fri, 23 Sep 2022 16:35:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
Message-ID: <20220923143540.howryhuygxi2hsj3@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-11-brauner@kernel.org>
 <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
 <20220923064707.GD16489@lst.de>
 <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
 <CAHC9VhS3NWfMk3uHxZSZMtDay4FqOYzTf9mKCy1=Rb22r-2P4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhS3NWfMk3uHxZSZMtDay4FqOYzTf9mKCy1=Rb22r-2P4A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:26:35AM -0400, Paul Moore wrote:
> On Fri, Sep 23, 2022 at 3:57 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Fri, Sep 23, 2022 at 08:47:07AM +0200, Christoph Hellwig wrote:
> > > On Thu, Sep 22, 2022 at 01:16:57PM -0400, Paul Moore wrote:
> > > > properly review the changes, but one thing immediately jumped out at
> > > > me when looking at this: why is the LSM hook
> > > > "security_inode_set_acl()" when we are passing a dentry instead of an
> > > > inode?  We don't have a lot of them, but there are
> > > > `security_dentry_*()` LSM hooks in the existing kernel code.
> > >
> > > I'm no LSM expert, but isn't the inode vs dentry for if it is
> > > related to an inode operation or dentry operation, not about that
> > > the first argument is?
> >
> > Indeed. For example ...
> 
> If the goal is for this LSM hook to operate on an inode and not a
> dentry, let's pass it an inode instead.  This should help prevent

I would be ok with that but EVM requires a dentry being passed and as
evm is called from security_inode_set_acl() exactly like it is from
security_inode_setxattr() and similar the hook has to take a dentry.

And I want to minimize - ideally get rid of at some point - separate
calls to security_*() and evm_*() or ima_() in the vfs. So the evm hook
should please stay in there.
