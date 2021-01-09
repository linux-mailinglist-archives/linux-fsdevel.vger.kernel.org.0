Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0DC2F0200
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 18:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAIREm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 12:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbhAIREm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 12:04:42 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B661C061786;
        Sat,  9 Jan 2021 09:04:02 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kyHeh-008iFa-1l; Sat, 09 Jan 2021 17:03:59 +0000
Date:   Sat, 9 Jan 2021 17:03:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iov_iter: optimise iter type checking
Message-ID: <20210109170359.GT3579531@ZenIV.linux.org.uk>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 09, 2021 at 04:09:08PM +0000, Pavel Begunkov wrote:
> On 06/12/2020 16:01, Pavel Begunkov wrote:
> > On 21/11/2020 14:37, Pavel Begunkov wrote:
> >> The problem here is that iov_iter_is_*() helpers check types for
> >> equality, but all iterate_* helpers do bitwise ands. This confuses
> >> compilers, so even if some cases were handled separately with
> >> iov_iter_is_*(), corresponding ifs in iterate*() right after are not
> >> eliminated.
> >>
> >> E.g. iov_iter_npages() first handles discards, but iterate_all_kinds()
> >> still checks for discard iter type and generates unreachable code down
> >> the line.
> > 
> > Ping. This one should be pretty simple
> 
> Ping please. Any doubts about this patch?

Sorry, had been buried in other crap.  I'm really not fond of the
bitmap use; if anything, I would rather turn iterate_and_advance() et.al.
into switches...

How about moving the READ/WRITE part into MSB?  Checking is just as fast
(if not faster - check for sign vs. checking bit 0).  And turn the
types into straight (dense) enum.

Almost all iov_iter_rw() callers have the form (iov_iter_rw(iter) == READ) or
(iov_iter_rw(iter) == WRITE).  Out of 50-odd callers there are 5 nominal
exceptions:
fs/cifs/smbdirect.c:1936:                        iov_iter_rw(&msg->msg_iter));
fs/exfat/inode.c:442:   int rw = iov_iter_rw(iter);
fs/f2fs/data.c:3639:    int rw = iov_iter_rw(iter);
fs/f2fs/f2fs.h:4082:    int rw = iov_iter_rw(iter);
fs/f2fs/f2fs.h:4092:    int rw = iov_iter_rw(iter);

The first one is debugging printk
        if (iov_iter_rw(&msg->msg_iter) == WRITE) {
                /* It's a bug in upper layer to get there */
                cifs_dbg(VFS, "Invalid msg iter dir %u\n",
                         iov_iter_rw(&msg->msg_iter));
                rc = -EINVAL;
                goto out;
        }
and if you look at the condition, the quality of message is
underwhelming - "Data source msg iter passed by caller" would
be more informative.

Other 4...  exfat one is
        if (rw == WRITE) {
...
	}
...
        if (ret < 0 && (rw & WRITE))
                exfat_write_failed(mapping, size);
IOW, doing
	bool is_write = iov_iter_rw(iter) == WRITE;
would be cleaner.  f2fs.h ones are
	int rw = iov_iter_rw(iter);
	....
	if (.... && rw == WRITE ...
so they are of the same sort (assuming we want that local
variable in the first place).

f2fs/data.c is the least trivial - it includes things like
                if (!down_read_trylock(&fi->i_gc_rwsem[rw])) {
and considering the amount of other stuff done there,
I would suggest something like
	int rw = is_data_source(iter) ? WRITE : READ;

I'll dig myself from under ->d_revalidate() code review, look
through the iov_iter-related series and post review, hopefully
by tonight.
