Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA000228710
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgGURQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgGURQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:16:31 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06411C061794;
        Tue, 21 Jul 2020 10:16:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxvsR-00HKQ5-3Y; Tue, 21 Jul 2020 17:16:27 +0000
Date:   Tue, 21 Jul 2020 18:16:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 05/24] devtmpfs: open code ksys_chdir and ksys_chroot
Message-ID: <20200721171627.GZ2786714@ZenIV.linux.org.uk>
References: <20200721162818.197315-1-hch@lst.de>
 <20200721162818.197315-6-hch@lst.de>
 <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 09:49:17AM -0700, Linus Torvalds wrote:
> On Tue, Jul 21, 2020 at 9:28 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > +
> > +       /* traverse into overmounted root and then chroot to it */
> > +       if (!kern_path("/..", LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path) &&
> > +           !inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR) &&
> > +           ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
> > +           !security_path_chroot(&path)) {
> > +               set_fs_pwd(current->fs, &path);
> > +               set_fs_root(current->fs, &path);
> > +       }
> > +       path_put(&path);
> 
> This looks wrong.

It is wrong.  kern_path() leaves *path unmodified in case of error, and
that struct path is uninitialized here.
