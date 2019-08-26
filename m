Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4276B9D3FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfHZQ3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 12:29:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43882 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfHZQ3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:29:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2HsL-0004RY-O7; Mon, 26 Aug 2019 16:29:49 +0000
Date:   Mon, 26 Aug 2019 17:29:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Subject: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190826162949.GA9980@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826024838.GN1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 03:48:38AM +0100, Al Viro wrote:

> 	We might be able to paper over that mess by doing what /dev/st does -
> checking that file_count(file) == 1 in ->flush() instance and doing commit
> there in such case.  It's not entirely reliable, though, and it's definitely
> not something I'd like to see spreading.

	This "not entirely reliable" turns out to be an understatement.
If you have /proc/*/fdinfo/* being read from at the time of final close(2),
you'll get file_count(file) > 1 the last time ->flush() is called.  In other
words, we'd get the data not committed at all.

	And that problem is shared with /dev/st*, unfortunately ;-/
We could somewhat mitigate that by having fs/proc/fd.c:seq_show() call
->flush() before fput(), but that would still hide errors from close(2)
(and still have close(2) return before the data is flushed).

	read() on /proc/*/fdinfo/* does the following:

find the task_struct
grab its descriptor table, drop task_struct
lock the table, pick struct file out of it
bump struct file refcount, unlock the table
        seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
                   (long long)file->f_pos, f_flags,
                   real_mount(file->f_path.mnt)->mnt_id);
        show_fd_locks(m, file, files);
        if (seq_has_overflowed(m))
                goto out;
        if (file->f_op->show_fdinfo)
                file->f_op->show_fdinfo(m, file);
drop the file reference (with fput()).

	Before "procfs: Convert /proc/pid/fdinfo/ handling routines to
seq-file v2" (in 2012), we did just snprintf() while under the lock on
descriptor table.  That commit moved the printf part from under the lock,
at the cost of grabbing and dropping file reference.  Shortly after that
"procfs: add ability to plug in auxiliary fdinfo providers" has added
->show_fdinfo() there, making it impossible to call under the descriptor
table lock - that method can block (and does so for eventpoll, idiotify,
etc.)

	We really want ->show_fdinfo() to happen before __fput() gets
anywhere near ->release().  And even the non-blocking cases can be too
costly to do under the descriptor table lock.  OTOH, it can very well be
done after or during ->flush(); the only problematic case right now
is /dev/st* that has its ->flush() do nothing in case if file_count(file)
is greater than 1.

	One kludgy way to handle that would be to have something like
FMODE_SUCKY_FLUSH that would have fs/proc/fd.c:seq_show() just do
the damn thing still under descriptor table lock and skip the rest
of it - /dev/st* has nothing in ->show_fdinfo(), and show_fd_locks()
is not too terribly costly.  Still best avoided in default case,
but...

	Another possibility is to have a secondary counter, with
__fput() waiting for it to go down to zero and fdinfo reads bumping
(and then dropping) that instead of the primary counter.  Not sure
which approach is better - adding extra logics in __fput() for the
sake of one (and not terribly common) device is not nice, but another
variant really is an ugly kludge ;-/  OTOH, this kind of "take
a secondary reference, ->release() will block until you drop it"
interface can breed deadlocks; procfs situation, AFAICS, allows to
use it safely, but it's begging to be abused...

	Ideas?  I don't like either approach, to put it very mildly,
so any cleaner suggestions would be very welcome.

PS: just dropping the check in st_flush() is probably a bad idea -
as it is, it can't overlap with st_write() and after such change it
will...
