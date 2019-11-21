Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39EDB1054FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfKUPAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:00:18 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48120 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfKUPAS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:00:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 781958EE259;
        Thu, 21 Nov 2019 07:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574348417;
        bh=A5sjuk9ASfqimvU/4AwuQqsYwREcK9kJESCBGZO9iC8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jVoa3S3s4lV46GCgRyTuyxxhQ3y1hKu0KtPto0E1GTNhRyVLN/KQADtUO8qYCX0va
         MByAqb+g9+5r+YbhhZj4uH4aEWAPslbe1sDqykW0Odx3MLyFOWsu5gX6wULfAucKFg
         39/nuY2XsZV9JC0yev9w3klZqmu0WWcqHom/q8cE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L0wKrncopjRl; Thu, 21 Nov 2019 07:00:17 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 30CAB8EE10C;
        Thu, 21 Nov 2019 07:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574348416;
        bh=A5sjuk9ASfqimvU/4AwuQqsYwREcK9kJESCBGZO9iC8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rdqbPWYLOJn+0SNuIPXxgRn/+ORzvDv0+/tDytPRUp0MtTbOtRp7LpRjEkw+ZFM3F
         MzMpeuXWavSigZSam4BMC65nmI3sk6hNj65sDqp2Easkmidc8TMOtgibdKsGuCw7IR
         UAlfQ0NOtGG7ISBEBwy6vu6cNvdsaNj6K5WSjNRo=
Message-ID: <1574348414.3277.6.camel@HansenPartnership.com>
Subject: Re: Feature bug with the new mount API: no way of doing read only
 bind mounts
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Nov 2019 07:00:14 -0800
In-Reply-To: <17268.1574323839@warthog.procyon.org.uk>
References: <1574295100.17153.25.camel@HansenPartnership.com>
         <17268.1574323839@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-11-21 at 08:10 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > I was looking to use the read only bind mount as a template for
> > reimplementing shiftfs when I discovered that you can't actually
> > create a read only bind mount with the new API.  The problem is
> > that fspick() will only reconfigure the underlying superblock,
> > which you don't want because you only want the bound subtree to
> > become read only and open_tree()/move_mount() doesn't give you any
> > facility to add or change options on the bind.
> 
> You'd use open_tree() with OPEN_TREE_CLONE and possibly AT_RECURSIVE
> rather than fspick().  fspick() is, as you observed, more for
> reconfiguring the superblock.
> 
> What is missing is a mount_setattr() syscall - something like:
> 
> 	mount_setattr(int dfd, const char *path, unsigned int at_flags,
> 		      unsigned int attr_change_mask, unsigned int
> attrs);
> 
> which would allow what you want to be done like:
> 
> 	fd = open_tree(AT_FDCWD, "/my/source/", OPEN_TREE_CLONE);
> 	mount_setattr(fd, "", AT_EMPTY_PATH | AT_RECURSIVE,
> 		      MOUNT_ATTR_RDONLY, MOUNT_ATTR_RDONLY);
> 	move_mount(fd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

That would work for read only, which is a simple mount attribute flag,
but wouldn't work for anything more complex like shiftfs which wants
more complex parameters.  What I'm looking for in that case is the
ability to reconfigure the bind mount in the same way you would
reconfigure the superblock.

James

