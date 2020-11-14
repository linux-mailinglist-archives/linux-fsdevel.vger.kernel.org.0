Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211EF2B310F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 22:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKNVow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 16:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNVov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 16:44:51 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA833C0613D1;
        Sat, 14 Nov 2020 13:44:50 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ke3LZ-0063sy-Tb; Sat, 14 Nov 2020 21:44:38 +0000
Date:   Sat, 14 Nov 2020 21:44:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201114214437.GQ3576660@ZenIV.linux.org.uk>
References: <20201104082738.1054792-1-hch@lst.de>
 <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113235453.GA227700@ubuntu-m3-large-x86>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:54:53PM -0700, Nathan Chancellor wrote:
> Hi Al,
> 
> On Wed, Nov 11, 2020 at 10:21:16PM +0000, Al Viro wrote:
> > On Wed, Nov 11, 2020 at 09:52:20PM +0000, Al Viro wrote:
> > 
> > > That can be done, but I would rather go with
> > > 		n = copy_to_iter(m->buf + m->from, m->count, iter);
> > > 		m->count -= n;
> > > 		m->from += n;
> > >                 copied += n;
> > >                 if (!size)
> > >                         goto Done;
> > > 		if (m->count)
> > > 			goto Efault;
> > > if we do it that way.  Let me see if I can cook something
> > > reasonable along those lines...
> > 
> > Something like below (build-tested only):
> > 
> > diff --git a/fs/seq_file.c b/fs/seq_file.c
> > index 3b20e21604e7..07b33c1f34a9 100644
> > --- a/fs/seq_file.c
> > +++ b/fs/seq_file.c
> > @@ -168,7 +168,6 @@ EXPORT_SYMBOL(seq_read);
> >  ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  {
> >  	struct seq_file *m = iocb->ki_filp->private_data;
> > -	size_t size = iov_iter_count(iter);
> >  	size_t copied = 0;
> >  	size_t n;
> >  	void *p;
> > @@ -208,14 +207,11 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  	}
> >  	/* if not empty - flush it first */
> >  	if (m->count) {
> > -		n = min(m->count, size);
> > -		if (copy_to_iter(m->buf + m->from, n, iter) != n)
> > -			goto Efault;
> > +		n = copy_to_iter(m->buf + m->from, m->count, iter);
> >  		m->count -= n;
> >  		m->from += n;
> > -		size -= n;
> >  		copied += n;
> > -		if (!size)
> > +		if (!iov_iter_count(iter) || m->count)
> >  			goto Done;
> >  	}
> >  	/* we need at least one record in buffer */
> > @@ -249,6 +245,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  	goto Done;
> >  Fill:
> >  	/* they want more? let's try to get some more */
> > +	/* m->count is positive and there's space left in iter */
> >  	while (1) {
> >  		size_t offs = m->count;
> >  		loff_t pos = m->index;
> > @@ -263,7 +260,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  			err = PTR_ERR(p);
> >  			break;
> >  		}
> > -		if (m->count >= size)
> > +		if (m->count >= iov_iter_count(iter))
> >  			break;
> >  		err = m->op->show(m, p);
> >  		if (seq_has_overflowed(m) || err) {
> > @@ -273,16 +270,14 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  		}
> >  	}
> >  	m->op->stop(m, p);
> > -	n = min(m->count, size);
> > -	if (copy_to_iter(m->buf, n, iter) != n)
> > -		goto Efault;
> > +	n = copy_to_iter(m->buf, m->count, iter);
> >  	copied += n;
> >  	m->count -= n;
> >  	m->from = n;
> >  Done:
> > -	if (!copied)
> > -		copied = err;
> > -	else {
> > +	if (unlikely(!copied)) {
> > +		copied = m->count ? -EFAULT : err;
> > +	} else {
> >  		iocb->ki_pos += copied;
> >  		m->read_pos += copied;
> >  	}
> > @@ -291,9 +286,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  Enomem:
> >  	err = -ENOMEM;
> >  	goto Done;
> > -Efault:
> > -	err = -EFAULT;
> > -	goto Done;
> >  }
> >  EXPORT_SYMBOL(seq_read_iter);
> >  
> 
> This patch in -next (6a9f696d1627bacc91d1cebcfb177f474484e8ba) breaks
> WSL2's interoperability feature, where Windows paths automatically get
> added to PATH on start up so that Windows binaries can be accessed from
> within Linux (such as clip.exe to pipe output to the clipboard). Before,
> I would see a bunch of Linux + Windows folders in $PATH but after, I
> only see the Linux folders (I can give you the actual PATH value if you
> care but it is really long).
> 
> I am not at all familiar with the semantics of this patch or how
> Microsoft would be using it to inject folders into PATH (they have some
> documentation on it here:
> https://docs.microsoft.com/en-us/windows/wsl/interop) and I am not sure
> how to go about figuring that out to see why this patch breaks something
> (unless you have an idea). I have added the Hyper-V maintainers and list
> to CC in case they know someone who could help.

FWIW, just to make sure:
	1) does reverting just that commit recover the desired behaviour?
	2) could you verify that your latest tests had been done with
the incremental I'd posted (shifting the if (....) goto Done; out of the if
body)?
	3) does the build with that commit reverted produce any warnings
related to mountinfo?
	4) your posted log with WARN_ON unfortunately starts *after*
the mountinfo accesses; could you check which process had been doing those?
The Comm: ... part in there, that is.
	5) in the "I don't believe that could happen, but let's make sure"
department: turn the
        /* m->count is positive and there's space left in iter */
comment in seq_read_iter() into an outright
	BUG_ON(!m->count || !iov_iter_count(iter));
