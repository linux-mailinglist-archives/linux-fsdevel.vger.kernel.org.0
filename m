Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3677E2B3AA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 00:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKOXv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 18:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgKOXvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 18:51:55 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8CC0613CF;
        Sun, 15 Nov 2020 15:51:55 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id p68so824018pga.6;
        Sun, 15 Nov 2020 15:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=01m0cOcFI71mVs+9lBinrDWRRm8biXQ0bPXJ4x3qNNc=;
        b=Mp9zLGQiX5AE3ACYtNkAKEnscwvdI9V81xyEQzS9jB7EZIHJqccHj/Zz4lJWC/zhDr
         O4652kVtn/5HAGomJsX0Qroot6FHA4ohPo8gzDA4nXg1BsU5dCF0S4i6rZPUL1cvzNzu
         Hflh7W0RCthNfrYxWOfHt0jdwyafgSHyu26zYWTegFtT22/KXMlPyGjVLdsDeN172s/X
         EvsE2GRnJcfeSDpkfyhYoEw1VWx/gIvJfeReB0RxJqMtMqRl1tCrev2sikdacYHyhUar
         rDkYbRm20HyzOrMM29aSOciGKbCKPkU/nxQiQKUVgPxya0zIAuRJUSNslinwWn1BZ83j
         VJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=01m0cOcFI71mVs+9lBinrDWRRm8biXQ0bPXJ4x3qNNc=;
        b=jCx4mxrNNQIuWSNke4X4ZORxmmgH2tBSIknUnqABbz7DaZDk0ixqS6fZeLpfMq+geO
         KXgQOmCXNxCGfhnHCt3XsCq7fYv6s4nP5eHB9uxgGoYXfknAePFNYbbSPLO/ri50xPfe
         9WGqPfl/OOFystlkM9fAOfOcQRYJLkybNawxMcwWi17GBHNSS8764fXFGOWcie/zVyrc
         joOSzpYWu5NkANAly7yeltzAQ+szvCBfJIS1easGkeukC8QIQxQoOrUFTBx2YG1+CUYM
         crHnMGizz01P/eFjSsyL40CW7F5bg/0PdTOORIHXoU06GTnwUDKN7tJqxJmSEv0ktpzh
         0L0g==
X-Gm-Message-State: AOAM530inmkK9ekmc9CW3j4TWq6LwutOmfBIvrq/XrsHu7YVICfGKVTY
        LonzuBxTL23E9BoQlOJRtKo=
X-Google-Smtp-Source: ABdhPJzTTmVnd28frKNfyiN9BhJ9hbSM5YJH3xYeysjNu+l3RqhIFjf7Zi6F0zSfIHO2pyANekXS/g==
X-Received: by 2002:a63:7847:: with SMTP id t68mr11010094pgc.422.1605484314830;
        Sun, 15 Nov 2020 15:51:54 -0800 (PST)
Received: from Ryzen-9-3900X.localdomain (ip68-98-75-144.ph.ph.cox.net. [68.98.75.144])
        by smtp.gmail.com with ESMTPSA id r4sm15667311pgs.54.2020.11.15.15.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 15:51:52 -0800 (PST)
Date:   Sun, 15 Nov 2020 16:51:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201115235149.GA252@Ryzen-9-3900X.localdomain>
References: <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk>
 <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk>
 <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk>
 <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
 <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115233814.GT3576660@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 11:38:14PM +0000, Al Viro wrote:
> On Sun, Nov 15, 2020 at 02:41:25PM -0700, Nathan Chancellor wrote:
> > Hi Al,
> > 
> > Apologies for the delay.
> > 
> > On Sun, Nov 15, 2020 at 03:53:55PM +0000, Al Viro wrote:
> > > On Sat, Nov 14, 2020 at 08:50:00PM +0000, Al Viro wrote:
> > > 
> > > OK, I think I understand what's going on.  Could you check if
> > > reverting the variant in -next and applying the following instead
> > > fixes what you are seeing?
> > 
> > The below diff on top of d4d50710a8b46082224376ef119a4dbb75b25c56 does
> > not fix my issue unfortunately.
> 
> OK...  Now that I have a reproducer[1], I think I've sorted it out.
> And yes, it had been too subtle for its own good ;-/
> 
> [1] I still wonder what the hell in the userland has come up with the
> idea of reading through a file with readv(), each time with 2-element
> iovec array, the first element covering 0 bytes and the second one - 1024.
> AFAICS, nothing is systemd git appears to be _that_ weird...  Makes for
> a useful testcase, though...
> 
> Anyway, could you test this replacement?

Looks good to me on top of d4d50710a8b46082224376ef119a4dbb75b25c56,
thanks for quickly looking into this!

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 3b20e21604e7..c0dfe2861b35 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -168,12 +168,14 @@ EXPORT_SYMBOL(seq_read);
>  ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct seq_file *m = iocb->ki_filp->private_data;
> -	size_t size = iov_iter_count(iter);
>  	size_t copied = 0;
>  	size_t n;
>  	void *p;
>  	int err = 0;
>  
> +	if (!iov_iter_count(iter))
> +		return 0;
> +
>  	mutex_lock(&m->lock);
>  
>  	/*
> @@ -208,34 +210,32 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	}
>  	/* if not empty - flush it first */
>  	if (m->count) {
> -		n = min(m->count, size);
> -		if (copy_to_iter(m->buf + m->from, n, iter) != n)
> -			goto Efault;
> +		n = copy_to_iter(m->buf + m->from, m->count, iter);
>  		m->count -= n;
>  		m->from += n;
> -		size -= n;
>  		copied += n;
> -		if (!size)
> +		if (m->count)	// hadn't managed to copy everything
>  			goto Done;
>  	}
> -	/* we need at least one record in buffer */
> +	/* we need at least one non-empty record in the buffer */
>  	m->from = 0;
>  	p = m->op->start(m, &m->index);
>  	while (1) {
>  		err = PTR_ERR(p);
> -		if (!p || IS_ERR(p))
> +		if (!p || IS_ERR(p))	// EOF or an error
>  			break;
>  		err = m->op->show(m, p);
> -		if (err < 0)
> +		if (err < 0)		// hard error
>  			break;
> -		if (unlikely(err))
> +		if (unlikely(err))	// ->show() says "skip it"
>  			m->count = 0;
> -		if (unlikely(!m->count)) {
> +		if (unlikely(!m->count)) { // empty record
>  			p = m->op->next(m, p, &m->index);
>  			continue;
>  		}
> -		if (m->count < m->size)
> +		if (!seq_has_overflowed(m)) // got it
>  			goto Fill;
> +		// need a bigger buffer
>  		m->op->stop(m, p);
>  		kvfree(m->buf);
>  		m->count = 0;
> @@ -244,11 +244,14 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  			goto Enomem;
>  		p = m->op->start(m, &m->index);
>  	}
> +	// EOF or an error
>  	m->op->stop(m, p);
>  	m->count = 0;
>  	goto Done;
>  Fill:
> -	/* they want more? let's try to get some more */
> +	// one non-empty record is in the buffer; if they want more,
> +	// try to fit more in, but in any case we need to advance
> +	// the iterator at least once.
>  	while (1) {
>  		size_t offs = m->count;
>  		loff_t pos = m->index;
> @@ -259,11 +262,9 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  					    m->op->next);
>  			m->index++;
>  		}
> -		if (!p || IS_ERR(p)) {
> -			err = PTR_ERR(p);
> +		if (!p || IS_ERR(p))	// no next record for us
>  			break;
> -		}
> -		if (m->count >= size)
> +		if (m->count >= iov_iter_count(iter))
>  			break;
>  		err = m->op->show(m, p);
>  		if (seq_has_overflowed(m) || err) {
> @@ -273,16 +274,14 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		}
>  	}
>  	m->op->stop(m, p);
> -	n = min(m->count, size);
> -	if (copy_to_iter(m->buf, n, iter) != n)
> -		goto Efault;
> +	n = copy_to_iter(m->buf, m->count, iter);
>  	copied += n;
>  	m->count -= n;
>  	m->from = n;
>  Done:
> -	if (!copied)
> -		copied = err;
> -	else {
> +	if (unlikely(!copied)) {
> +		copied = m->count ? -EFAULT : err;
> +	} else {
>  		iocb->ki_pos += copied;
>  		m->read_pos += copied;
>  	}
> @@ -291,9 +290,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  Enomem:
>  	err = -ENOMEM;
>  	goto Done;
> -Efault:
> -	err = -EFAULT;
> -	goto Done;
>  }
>  EXPORT_SYMBOL(seq_read_iter);
>  
