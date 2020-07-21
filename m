Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E022882A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 20:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgGUS0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 14:26:12 -0400
Received: from verein.lst.de ([213.95.11.211]:53384 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUS0M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:26:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 209F968B05; Tue, 21 Jul 2020 20:26:08 +0200 (CEST)
Date:   Tue, 21 Jul 2020 20:26:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 05/24] devtmpfs: open code ksys_chdir and ksys_chroot
Message-ID: <20200721182607.GA14450@lst.de>
References: <20200721162818.197315-1-hch@lst.de> <20200721162818.197315-6-hch@lst.de> <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com> <20200721171627.GZ2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721171627.GZ2786714@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 06:16:27PM +0100, Al Viro wrote:
> On Tue, Jul 21, 2020 at 09:49:17AM -0700, Linus Torvalds wrote:
> > On Tue, Jul 21, 2020 at 9:28 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > +
> > > +       /* traverse into overmounted root and then chroot to it */
> > > +       if (!kern_path("/..", LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path) &&
> > > +           !inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR) &&
> > > +           ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
> > > +           !security_path_chroot(&path)) {
> > > +               set_fs_pwd(current->fs, &path);
> > > +               set_fs_root(current->fs, &path);
> > > +       }
> > > +       path_put(&path);
> > 
> > This looks wrong.
> 
> It is wrong.  kern_path() leaves *path unmodified in case of error, and
> that struct path is uninitialized here.

Yep.  Only saving grace is that the error just doesn't happen during
early init.
