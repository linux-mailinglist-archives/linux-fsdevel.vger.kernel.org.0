Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B9190D1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 13:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgCXMNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 08:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgCXMNT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:13:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3F420870;
        Tue, 24 Mar 2020 12:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585051998;
        bh=C4wlqkM3wVp35mo1kxHTuS8DOA3/s4vUyNZ91PUlg0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mi3iMe0prSHQGaRwCcAy9PMzwJjZlo3yYG6ABbg8yvL4l/EEIuwFMMYrASKQyqWG4
         tUo8AWE//Wao9D0y9sM4LPCntZ5Ygaan//Zdw/PlijaAr1BLLKs25WbGuj0XK/rI4t
         pqR3TxOyOUzCerPQG4RWHJ9uvmSLHX2bEzJMSUNs=
Date:   Tue, 24 Mar 2020 13:13:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        glider@google.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] libfs: fix infoleak in simple_attr_read()
Message-ID: <20200324121314.GC2333340@kroah.com>
References: <CAG_fn=WvVp7Nxm5E+1dYs4guMYUV8D1XZEt_AZFF6rAQEbbAeg@mail.gmail.com>
 <20200308023849.988264-1-ebiggers@kernel.org>
 <20200313164511.GB907@sol.localdomain>
 <20200318163940.GB2334@sol.localdomain>
 <20200322035620.GB111151@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322035620.GB111151@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 21, 2020 at 08:56:20PM -0700, Eric Biggers wrote:
> On Wed, Mar 18, 2020 at 09:39:40AM -0700, Eric Biggers wrote:
> > On Fri, Mar 13, 2020 at 09:45:11AM -0700, Eric Biggers wrote:
> > > On Sat, Mar 07, 2020 at 06:38:49PM -0800, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Reading from a debugfs file at a nonzero position, without first reading
> > > > at position 0, leaks uninitialized memory to userspace.
> > > > 
> > > > It's a bit tricky to do this, since lseek() and pread() aren't allowed
> > > > on these files, and write() doesn't update the position on them.  But
> > > > writing to them with splice() *does* update the position:
> > > > 
> > > > 	#define _GNU_SOURCE 1
> > > > 	#include <fcntl.h>
> > > > 	#include <stdio.h>
> > > > 	#include <unistd.h>
> > > > 	int main()
> > > > 	{
> > > > 		int pipes[2], fd, n, i;
> > > > 		char buf[32];
> > > > 
> > > > 		pipe(pipes);
> > > > 		write(pipes[1], "0", 1);
> > > > 		fd = open("/sys/kernel/debug/fault_around_bytes", O_RDWR);
> > > > 		splice(pipes[0], NULL, fd, NULL, 1, 0);
> > > > 		n = read(fd, buf, sizeof(buf));
> > > > 		for (i = 0; i < n; i++)
> > > > 			printf("%02x", buf[i]);
> > > > 		printf("\n");
> > > > 	}
> > > > 
> > > > Output:
> > > > 	5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a30
> > > > 
> > > > Fix the infoleak by making simple_attr_read() always fill
> > > > simple_attr::get_buf if it hasn't been filled yet.
> > > > 
> > > > Reported-by: syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com
> > > > Reported-by: Alexander Potapenko <glider@google.com>
> > > > Fixes: acaefc25d21f ("[PATCH] libfs: add simple attribute files")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > ---
> > > >  fs/libfs.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/libfs.c b/fs/libfs.c
> > > > index c686bd9caac6..3759fbacf522 100644
> > > > --- a/fs/libfs.c
> > > > +++ b/fs/libfs.c
> > > > @@ -891,7 +891,7 @@ int simple_attr_open(struct inode *inode, struct file *file,
> > > >  {
> > > >  	struct simple_attr *attr;
> > > >  
> > > > -	attr = kmalloc(sizeof(*attr), GFP_KERNEL);
> > > > +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> > > >  	if (!attr)
> > > >  		return -ENOMEM;
> > > >  
> > > > @@ -931,9 +931,11 @@ ssize_t simple_attr_read(struct file *file, char __user *buf,
> > > >  	if (ret)
> > > >  		return ret;
> > > >  
> > > > -	if (*ppos) {		/* continued read */
> > > > +	if (*ppos && attr->get_buf[0]) {
> > > > +		/* continued read */
> > > >  		size = strlen(attr->get_buf);
> > > > -	} else {		/* first read */
> > > > +	} else {
> > > > +		/* first read */
> > > >  		u64 val;
> > > >  		ret = attr->get(attr->data, &val);
> > > >  		if (ret)
> > > > -- 
> > > > 2.25.1
> > > 
> > > Any comments on this?  Al, seems this is something you should pick up?
> > > 
> > > - Eric
> > 
> > Ping.
> > 
> 
> Andrew, can you consider taking this patch?  Al has been ignoring it, and this
> seems like a fairly important fix.  This bug affects many (most?) debugfs files,
> and it affects years old kernels too not just recent ones.

As it affects debugfs files, I'll grab it now, thanks.

greg k-h
