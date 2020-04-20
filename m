Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0E1B16CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDTUUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:20:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35371 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTUUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:20:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id r14so5504683pfg.2;
        Mon, 20 Apr 2020 13:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1vWaAPFpe9d3hkanubiEklkGNiGAMFeNwjfGMilTAM=;
        b=LeVI8eYmduC3eSID+7FWU0p9yLY37GgrNrdLWBRe9VoJYlZn2kWImhhrT2eEXYNd76
         UBZVREbjdvmB/0/eDpPa01hkEIcGs5UqFdEoJKXAca9sKm2qRmbGmdj1xLLBBvgz0Hu3
         OEIsIBF4U5qrcINt8QH5MuJ6lBjqNHJ8cWimEzTQn6WWBsIHnSOSo0VlA/IBkG4j0gVI
         mqfizBn2XPgkf4DaNOw9U6l5d0eEciEtZeAiVbL+4HGTY6tpmik+SMiHLOYwH88Nz2Mh
         +6slvJBhQNWFJF0hUkuWtprTuGX+9isngFy6MMNprYuUQVPRVK9Cy33rQdkrx291gWhc
         aicw==
X-Gm-Message-State: AGi0PuZ6wewRQbWpNgs+cyzBq4IXUCjaAAUPkV84p1X9K+mAiG/nU7Qx
        VHKfGLKfCaWyWy7GN9VoI2I=
X-Google-Smtp-Source: APiQypKeLBYdrxP6j03MnlZSHUnvhneLWrQZJtLtlDqcB+PbOXVLX2G83VQJBNiL+R9imcwu/VBFUQ==
X-Received: by 2002:a62:dd03:: with SMTP id w3mr8749988pff.76.1587414048659;
        Mon, 20 Apr 2020 13:20:48 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f3sm337607pfd.144.2020.04.20.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:20:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 190554028E; Mon, 20 Apr 2020 20:20:46 +0000 (UTC)
Date:   Mon, 20 Apr 2020 20:20:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] blktrace: add checks for created debugfs files
 on setup
Message-ID: <20200420202046.GN11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-9-mcgrof@kernel.org>
 <38240225-e48e-3035-0baa-4929948b23a3@acm.org>
 <20200419230537.GG11244@42.do-not-panic.com>
 <c69b67d1-f887-600b-f3ab-54ab0b7dcb13@acm.org>
 <20200420114038.GE3906674@kroah.com>
 <20200420184445.GK11244@42.do-not-panic.com>
 <20200420201101.GB302402@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420201101.GB302402@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:11:01PM +0200, Greg KH wrote:
> On Mon, Apr 20, 2020 at 06:44:45PM +0000, Luis Chamberlain wrote:
> > On Mon, Apr 20, 2020 at 01:40:38PM +0200, Greg KH wrote:
> > > On Sun, Apr 19, 2020 at 04:17:46PM -0700, Bart Van Assche wrote:
> > > > On 4/19/20 4:05 PM, Luis Chamberlain wrote:
> > > > > On Sun, Apr 19, 2020 at 03:57:58PM -0700, Bart Van Assche wrote:
> > > > > > On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > > > > > > Even though debugfs can be disabled, enabling BLK_DEV_IO_TRACE will
> > > > > > > select DEBUG_FS, and blktrace exposes an API which userspace uses
> > > > > > > relying on certain files created in debugfs. If files are not created
> > > > > > > blktrace will not work correctly, so we do want to ensure that a
> > > > > > > blktrace setup creates these files properly, and otherwise inform
> > > > > > > userspace.
> > > > > > > 
> > > > > > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > > > > ---
> > > > > > >    kernel/trace/blktrace.c | 8 +++++---
> > > > > > >    1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > > > > > > index 9cc0153849c3..fc32a8665ce8 100644
> > > > > > > --- a/kernel/trace/blktrace.c
> > > > > > > +++ b/kernel/trace/blktrace.c
> > > > > > > @@ -552,17 +552,19 @@ static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
> > > > > > >    					  struct dentry *dir,
> > > > > > >    					  struct blk_trace *bt)
> > > > > > >    {
> > > > > > > -	int ret = -EIO;
> > > > > > > -
> > > > > > >    	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
> > > > > > >    					       &blk_dropped_fops);
> > > > > > > +	if (!bt->dropped_file)
> > > > > > > +		return -ENOMEM;
> > > > > > >    	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
> > > > > > > +	if (!bt->msg_file)
> > > > > > > +		return -ENOMEM;
> > > > > > >    	bt->rchan = relay_open("trace", dir, buts->buf_size,
> > > > > > >    				buts->buf_nr, &blk_relay_callbacks, bt);
> > > > > > >    	if (!bt->rchan)
> > > > > > > -		return ret;
> > > > > > > +		return -EIO;
> > > > > > >    	return 0;
> > > > > > >    }
> > > > > > 
> > > > > > I should have had a look at this patch before I replied to the previous
> > > > > > patch.
> > > > > > 
> > > > > > Do you agree that the following code can be triggered by
> > > > > > debugfs_create_file() and also that debugfs_create_file() never returns
> > > > > > NULL?
> > > > > 
> > > > > If debugfs is enabled, and not that we know it is in this blktrace code,
> > > > > as we select it, it can return ERR_PTR(-ERROR) if an error occurs.
> > > > 
> > > > This is what I found in include/linux/debugfs.h in case debugfs is disabled:
> > > > 
> > > > static inline struct dentry *debugfs_create_file(const char *name,
> > > > 	umode_t mode, struct dentry *parent, void *data,
> > > > 	const struct file_operations *fops)
> > > > {
> > > > 	return ERR_PTR(-ENODEV);
> > > > }
> > > > 
> > > > I have not found any code path that can cause debugfs_create_file() to
> > > > return NULL. Did I perhaps overlook something? If not, it's not clear to me
> > > > why the above patch adds checks that check whether debugfs_create_file()
> > > > returns NULL?
> > > 
> > > Short answer, yes, it can return NULL.  Correct answer is, you don't
> > > care, don't check the value and don't do anything about it.  It's
> > > debugging code, userspace doesn't care, so just keep moving on.
> > 
> > Thing is this code *exposes* knobs to userspace for an API that *does*
> > exepect those files to exist. That is, blktrace *relies* on these
> > debugfs files to exist. So the kconfig which enables blktrace
> > CONFIG_BLK_DEV_IO_TRACE selects DEBUG_FS.
> 
> That's nice, but again, no kernel code should do anything different
> depending on what debugfs happens to be doing at that point in time.

So even if the debugfs files were *not* created, and this code executes only
if DEBUG_FS, you don't think we should inform userspace if the blktrace
setup ioctl, which sets up these debugfs, didn't happen?

The "recovery" here would just be to destroy the blktrace setup, and
inform userspace that the blktrace setup ioctl failed.

  Luis
