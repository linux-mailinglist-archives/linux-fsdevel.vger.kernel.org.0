Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD581B1F47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDUGzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 02:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgDUGzj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:55:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF8D2072D;
        Tue, 21 Apr 2020 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587452137;
        bh=zJ60yvTqB3tFZq6e5i0uFpw0aBM0sbkbs4gVEDscwcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOvT1pf71YXBkdb+1cDESYAuVzGz9Pfk05UHBuTjyKfXBGV8Jwl3nLgA8xfppe4Gy
         3rQRUzHq43ryklylYJLxHNa0hUAmBU4i2wDKLh3QDBBLU8xmzuY6g/vZ/rjhX3FvfR
         l9NazMlSeEbaWkalX0L3KNeQ72f9/by4M0/j7BI8=
Date:   Tue, 21 Apr 2020 08:55:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] blktrace: add checks for created debugfs files
 on setup
Message-ID: <20200421065535.GC347130@kroah.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-9-mcgrof@kernel.org>
 <38240225-e48e-3035-0baa-4929948b23a3@acm.org>
 <20200419230537.GG11244@42.do-not-panic.com>
 <c69b67d1-f887-600b-f3ab-54ab0b7dcb13@acm.org>
 <20200420114038.GE3906674@kroah.com>
 <20200420184445.GK11244@42.do-not-panic.com>
 <20200420201101.GB302402@kroah.com>
 <20200420202046.GN11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420202046.GN11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:20:46PM +0000, Luis Chamberlain wrote:
> On Mon, Apr 20, 2020 at 10:11:01PM +0200, Greg KH wrote:
> > On Mon, Apr 20, 2020 at 06:44:45PM +0000, Luis Chamberlain wrote:
> > > On Mon, Apr 20, 2020 at 01:40:38PM +0200, Greg KH wrote:
> > > > On Sun, Apr 19, 2020 at 04:17:46PM -0700, Bart Van Assche wrote:
> > > > > On 4/19/20 4:05 PM, Luis Chamberlain wrote:
> > > > > > On Sun, Apr 19, 2020 at 03:57:58PM -0700, Bart Van Assche wrote:
> > > > > > > On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > > > > > > > Even though debugfs can be disabled, enabling BLK_DEV_IO_TRACE will
> > > > > > > > select DEBUG_FS, and blktrace exposes an API which userspace uses
> > > > > > > > relying on certain files created in debugfs. If files are not created
> > > > > > > > blktrace will not work correctly, so we do want to ensure that a
> > > > > > > > blktrace setup creates these files properly, and otherwise inform
> > > > > > > > userspace.
> > > > > > > > 
> > > > > > > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > > > > > ---
> > > > > > > >    kernel/trace/blktrace.c | 8 +++++---
> > > > > > > >    1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > > > > > > > index 9cc0153849c3..fc32a8665ce8 100644
> > > > > > > > --- a/kernel/trace/blktrace.c
> > > > > > > > +++ b/kernel/trace/blktrace.c
> > > > > > > > @@ -552,17 +552,19 @@ static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
> > > > > > > >    					  struct dentry *dir,
> > > > > > > >    					  struct blk_trace *bt)
> > > > > > > >    {
> > > > > > > > -	int ret = -EIO;
> > > > > > > > -
> > > > > > > >    	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
> > > > > > > >    					       &blk_dropped_fops);
> > > > > > > > +	if (!bt->dropped_file)
> > > > > > > > +		return -ENOMEM;
> > > > > > > >    	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
> > > > > > > > +	if (!bt->msg_file)
> > > > > > > > +		return -ENOMEM;
> > > > > > > >    	bt->rchan = relay_open("trace", dir, buts->buf_size,
> > > > > > > >    				buts->buf_nr, &blk_relay_callbacks, bt);
> > > > > > > >    	if (!bt->rchan)
> > > > > > > > -		return ret;
> > > > > > > > +		return -EIO;
> > > > > > > >    	return 0;
> > > > > > > >    }
> > > > > > > 
> > > > > > > I should have had a look at this patch before I replied to the previous
> > > > > > > patch.
> > > > > > > 
> > > > > > > Do you agree that the following code can be triggered by
> > > > > > > debugfs_create_file() and also that debugfs_create_file() never returns
> > > > > > > NULL?
> > > > > > 
> > > > > > If debugfs is enabled, and not that we know it is in this blktrace code,
> > > > > > as we select it, it can return ERR_PTR(-ERROR) if an error occurs.
> > > > > 
> > > > > This is what I found in include/linux/debugfs.h in case debugfs is disabled:
> > > > > 
> > > > > static inline struct dentry *debugfs_create_file(const char *name,
> > > > > 	umode_t mode, struct dentry *parent, void *data,
> > > > > 	const struct file_operations *fops)
> > > > > {
> > > > > 	return ERR_PTR(-ENODEV);
> > > > > }
> > > > > 
> > > > > I have not found any code path that can cause debugfs_create_file() to
> > > > > return NULL. Did I perhaps overlook something? If not, it's not clear to me
> > > > > why the above patch adds checks that check whether debugfs_create_file()
> > > > > returns NULL?
> > > > 
> > > > Short answer, yes, it can return NULL.  Correct answer is, you don't
> > > > care, don't check the value and don't do anything about it.  It's
> > > > debugging code, userspace doesn't care, so just keep moving on.
> > > 
> > > Thing is this code *exposes* knobs to userspace for an API that *does*
> > > exepect those files to exist. That is, blktrace *relies* on these
> > > debugfs files to exist. So the kconfig which enables blktrace
> > > CONFIG_BLK_DEV_IO_TRACE selects DEBUG_FS.
> > 
> > That's nice, but again, no kernel code should do anything different
> > depending on what debugfs happens to be doing at that point in time.
> 
> So even if the debugfs files were *not* created, and this code executes only
> if DEBUG_FS, you don't think we should inform userspace if the blktrace
> setup ioctl, which sets up these debugfs, didn't happen?
> 
> The "recovery" here would just be to destroy the blktrace setup, and
> inform userspace that the blktrace setup ioctl failed.

Hm, ok, but comment the heck out of this saying _why_ you are testing
the return value, and how that differs from 99% of the other users of
this function in the kernel tree please.

Otherwise I will end up removing the checks again with my semi-regular
sweep of the tree...

thanks,

greg k-h
