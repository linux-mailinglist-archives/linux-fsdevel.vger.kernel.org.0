Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE37222B2F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgGWPvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 11:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgGWPvo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:51:44 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4902071A;
        Thu, 23 Jul 2020 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595519503;
        bh=s7fnhlfkAZ4BDqciAV1UteqeFEi6PoF3meXFtsJ2XFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbdjRk7AcTzuJnPWMqvcsWQgsIHa3kfOVWA+356lKqVZTJjaILnpro156gOY6GZbc
         5cDbaDxYKYjar5G12tA63PKyQeaPpJcZ0A5jAEhJLrIDbYXonDtHAi7YUI6ASXKOxP
         BZtEIIII3j49elO102+UnQihS0xM3XF34dQkue7E=
Date:   Thu, 23 Jul 2020 08:51:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, v9fs-developer@lists.sourceforge.net,
        syzbot <syzbot+d012ca3f813739c37c25@syzkaller.appspotmail.com>
Subject: Re: WARNING in __kernel_read
Message-ID: <20200723155142.GA870@sol.localdomain>
References: <00000000000003d32b05aa4d493c@google.com>
 <20200714110239.GE16178@lst.de>
 <455c6bf929ea197a7c18ba3f9e8464148b333297.camel@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455c6bf929ea197a7c18ba3f9e8464148b333297.camel@kernel.wtf>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Cengiz,

On Thu, Jul 23, 2020 at 05:17:25PM +0300, Cengiz Can wrote:
> Hello,
> 
> I'm trying to help clean up syzkaller submissions and this caught my
> attention and I wanted to get your advice.
> 
> With commit: 6209dd9132e8ea5545cffc84483841e88ea8cc5b `kernel_read` was
> modified to use `__kernel_read` by Christoph Hellwig.
> 
> One of the syzkaller tests executes following system calls:
> 
> open("./file0", O_WRONLY|O_CREAT|O_EXCL|O_DIRECT|0x4, 000) = 5
> open("/dev/char/4:1", O_RDWR)           = 6
> mount(NULL, "./file0", "9p", 0,
> "trans=fd,rfdno=0x0000000000000005,wfdno=0x0000000000000006,"
> 
> This initiates a `__kernel_read` call from `p9_read_work` (and
> `p9_fd_read`) and since the `file->f_mode` does not contain FMODE_READ
> , a WARN_ON_ONCE is thrown.
> 
> ```
> if (WARN_ON_ONCE(!(file->f_mode & FMODE_READ)))
>          return -EINVAL;
> ```
> 
> Can you help me understand what's wrong and fix this issue? 
> Is it already being worked on?
> 

Looks like this was already fixed in linux-next by:

	commit a39c46067c845a8a2d7144836e9468b7f072343e
	Author: Christoph Hellwig <hch@lst.de>
	Date:   Fri Jul 10 10:57:22 2020 +0200

	    net/9p: validate fds in p9_fd_open

Let's tell syzbot so that it closes this bug report:

#syz fix: net/9p: validate fds in p9_fd_open
