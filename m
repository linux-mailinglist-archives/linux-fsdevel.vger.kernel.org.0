Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF15EBB8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 09:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiI0HfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 03:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiI0He7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:34:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44A612602;
        Tue, 27 Sep 2022 00:34:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD1C468AA6; Tue, 27 Sep 2022 09:34:54 +0200 (CEST)
Date:   Tue, 27 Sep 2022 09:34:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
Message-ID: <20220927073454.GA17224@lst.de>
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-11-brauner@kernel.org> <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com> <20220923064707.GD16489@lst.de> <20220923075752.nmloqf2aj5yhoe34@wittgenstein> <CAHC9VhS3NWfMk3uHxZSZMtDay4FqOYzTf9mKCy1=Rb22r-2P4A@mail.gmail.com> <20220923143540.howryhuygxi2hsj3@wittgenstein> <CAHC9VhRZf+OAzc96=c2s3NqkizNh2tZbLF8OFPHbFFuFXEZ8sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRZf+OAzc96=c2s3NqkizNh2tZbLF8OFPHbFFuFXEZ8sA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 01:35:08PM -0400, Paul Moore wrote:
> If a dentry is truly needed by EVM (a quick look indicates that it may
> just be for the VFS getxattr API, but I haven't traced the full code
> path), then I'm having a hard time reconciling that this isn't a
> dentry operation.  Yes, I get that the ACLs belong to the inode and
> not the dentry, but then why do we need the dentry?  It seems like the
> interfaces are broken slightly, or at least a little odd ... <shrug>

The dentry_operations are bit misnamed and should probably have been
called dcache_operations, that is they are all about managing the
dcache state and closely related operations.  ACLs aren't like that.
