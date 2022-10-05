Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5825F503A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 09:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJEHP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 03:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJEHPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F811F612;
        Wed,  5 Oct 2022 00:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA4161591;
        Wed,  5 Oct 2022 07:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BC1C433D6;
        Wed,  5 Oct 2022 07:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664954113;
        bh=jHllR/gyYN/9+h7RHJKtJlpYxKNsfGctLD7XiiybBnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGb8Ci/7XvGiVBsfghO4RYoI8qMvWh5rpO8rsCHQA/aJ4apgzRDCKUbhlAsXsfhta
         xmY6+s4PYxNkBcYAP4wFFvWo1bzidaS8KdQQrhm/w4NR97hq/mFhRjva8+bHRgb5w3
         r6Oc/Q7InlHMhqN/n7iMoNY2ALIo1YdTJk5Z+jmG+EUQ4R5kHtVotFTXJRnWQdn32r
         hzLTp6bzvgvvdow6/oCaNckXmK5CUT+dANAlfMIisN2TNRlApfEcKSbrP+U0uHQUfO
         qKOJGivJtAXxcPRQOWCcxaMOufuPdOCKsyfryxsBVOD1s+lxGwXzI/THus0eG8EnQe
         pwg35EVchR6KA==
Date:   Wed, 5 Oct 2022 09:15:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
Message-ID: <20221005071508.lc7qg6cffqrhbc4d@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
 <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <CAH2r5muRDdy1s4xS7bHePEF3t84qGaX3rDXUgGLY1k_XG4vuAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5muRDdy1s4xS7bHePEF3t84qGaX3rDXUgGLY1k_XG4vuAg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:53:41PM -0500, Steve French wrote:
> On Fri, Sep 30, 2022 at 5:06 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, 30 Sept 2022 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Fri, Sep 30, 2022 at 10:53:05AM +0200, Miklos Szeredi wrote:
> > > > On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > > This adds a new ->get_acl() inode operations which takes a dentry
> > > > > argument which filesystems such as 9p, cifs, and overlayfs can implement
> > > > > to get posix acls.
> ...
> > > > So what's the difference and why do we need both?  If one can retrive
> > > > the acl without dentry, then why do we need the one with the dentry?
> > >
> > > The ->get_inode_acl() method is called during generic_permission() and
> > > inode_permission() both of which are called from various filesystems in
> > > their ->permission inode operations. There's no dentry available during
> > > the permission inode operation and there are filesystems like 9p and
> > > cifs that need a dentry.
> >
> > This doesn't answer the question about why we need two for overlayfs
> > and what's the difference between them.
> > >
> > > > If a filesystem cannot implement a get_acl() without a dentry, then
> > > > what will happen to caller's that don't have a dentry?
> > >
> > > This happens today for cifs where posix acls can be created and read but
> > > they cannot be used for permission checking where no inode is available.
> > > New filesystems shouldn't have this issue.
> 
> Can you give an example of this?   How can you read an ACL without an
> inode or open file struct?  ACL wouldn't fit in a dentry right?  By

We're just talking about thet fact that
{g,s}etxattr(system.posix_acl_{access,default}) work on cifs but
getting acls based on inode operations isn't supported. Consequently you
can't use the acls for permission checking in the vfs for cifs. If as
you say below that's intentional because the client doesn't perform
access checks then that's probably fine.
