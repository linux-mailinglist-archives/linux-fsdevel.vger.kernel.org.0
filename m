Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B6481F5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 20:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbhL3TE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 14:04:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36775 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240323AbhL3TE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:04:57 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BUJ4kKD005541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 14:04:47 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3ECBF15C33A3; Thu, 30 Dec 2021 14:04:46 -0500 (EST)
Date:   Thu, 30 Dec 2021 14:04:46 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Hans Montero <hjm2133@columbia.edu>
Cc:     linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
        Xijiao Li <xl2950@columbia.edu>,
        OS-TA <cucs4118-tas@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Question about `generic_write_checks()` FIXME comment
Message-ID: <Yc4Czk5A+p5p2Y4W@mit.edu>
References: <CAMqPytVSCD+6ER+uXa-SrXQCpY-U-34G1jWmprR1Zgag+wBqTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMqPytVSCD+6ER+uXa-SrXQCpY-U-34G1jWmprR1Zgag+wBqTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 30, 2021 at 03:07:25AM -0500, Hans Montero wrote:
> We noticed the FIXME comment and we weren't sure exactly what it meant so we
> kept tracing through older versions of `generic_write_checks()`, going as far as
> Linux 2.5.75, before it was implemented for `write_iter()` usage:
> 
>   if (!isblk) {
>           /* FIXME: this is for backwards compatibility with 2.4 */
>           if (file->f_flags & O_APPEND)
>                   *pos = inode->i_size;
>           ...
>   }

I was able to trace it back farther, to v2.4.14.8 -> v2.4.14.9.  And it
looks like the mysterious FIXME is about the block device:

commit 1040c54c3b98ac4f8d91bc313cdc9d6669481da3
Author: Linus Torvalds <torvalds@athlon.transmeta.com>
Date:   Mon Feb 4 20:33:54 2002 -0800
	...
@@ -2765,7 +2876,8 @@ generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
 
 	written = 0;
 
-	if (file->f_flags & O_APPEND)
+	/* FIXME: this is for backwards compatibility with 2.4 */
+	if (!S_ISBLK(inode->i_mode) && file->f_flags & O_APPEND)
 		pos = inode->i_size;
 
 	/*

 But as Al Viro pointed out, O_APPEND really can't have any real
 meaning for a block device.  It would be neat if we could magically
 make a 10TB HDD to become as 12TB HDD by writing 2TB using
 O_APPEND, but reality doesn't work that way.  :-)

It probably makes sense just to remove the FIXME from the current
kernel sources so that future people don't get confused, asking the
same questions you have.

Cheers,

						- Ted
