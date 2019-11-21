Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA131054E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 15:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUOyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 09:54:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53209 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUOyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:54:18 -0500
Received: from [193.96.224.244] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iXnqY-000291-AI; Thu, 21 Nov 2019 14:54:14 +0000
Date:   Thu, 21 Nov 2019 15:54:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <christian@brauner.io>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Feature bug with the new mount API: no way of doing read only
 bind mounts
Message-ID: <20191121145410.lxrkxzmfioxbll37@wittgenstein>
References: <1574295100.17153.25.camel@HansenPartnership.com>
 <17268.1574323839@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17268.1574323839@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 08:10:39AM +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > I was looking to use the read only bind mount as a template for
> > reimplementing shiftfs when I discovered that you can't actually create a
> > read only bind mount with the new API.  The problem is that fspick() will
> > only reconfigure the underlying superblock, which you don't want because you
> > only want the bound subtree to become read only and open_tree()/move_mount()
> > doesn't give you any facility to add or change options on the bind.
> 
> You'd use open_tree() with OPEN_TREE_CLONE and possibly AT_RECURSIVE rather
> than fspick().  fspick() is, as you observed, more for reconfiguring the
> superblock.
> 
> What is missing is a mount_setattr() syscall - something like:
> 
> 	mount_setattr(int dfd, const char *path, unsigned int at_flags,
> 		      unsigned int attr_change_mask, unsigned int attrs);
> 
> which would allow what you want to be done like:
> 
> 	fd = open_tree(AT_FDCWD, "/my/source/", OPEN_TREE_CLONE);
> 	mount_setattr(fd, "", AT_EMPTY_PATH | AT_RECURSIVE,
> 		      MOUNT_ATTR_RDONLY, MOUNT_ATTR_RDONLY);
> 	move_mount(fd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> 
> Christian: you said you wanted to have a look at doing this - is that still
> your intention?

Yes, it is. I can't put an exact time-frame on this rn.
Also, I thought we've agreed a while back that the flags would move into
a struct since mount is gaining flags quickly too. :)

Christian
