Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7212B2960
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 00:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKMXy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 18:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMXy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:54:57 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF674C0613D1;
        Fri, 13 Nov 2020 15:54:56 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id x13so5693772qvk.8;
        Fri, 13 Nov 2020 15:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xKlWX5sJu4sZOoZ9K5CyZiFGJMGh7jY2PGRdiy6fiqQ=;
        b=PLMW2b5Dur5YVJJjAt4mxJuWZZJ7UtsxLfuWcKkKc/XI+gUX4MGNKcNw75W7ocwYBu
         W3ca2Qsm3LdXD05q8akIEtfLWLAq9vLwBppeibNxF7nevcY3tXaO9UzCG1SDZJkyBH2q
         yJBTNzX7br+KLDsEwEv2vFUEu2Ds6QgdLm5Lji9TtPh7c4AwGe3qKSf2dzkhtIPGw9RG
         gZjbMQOWSUlAs9C1iIs3gmql4iZdgLQAJE67tbarVbstbuD72/gub8lRUfH63Y4ktEsJ
         omGxwEORG/mpeXeph5s6apaSzCLQgeSRY6J8Y7+7A2NkNoHfUEFEmuw3ofOcdUrezuBG
         XyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xKlWX5sJu4sZOoZ9K5CyZiFGJMGh7jY2PGRdiy6fiqQ=;
        b=UwVSmiOsp9tjKvN0Llv+znXTvYAAd3qNWA0rwURWTUeHvblifZ3/QxG2OVQ+aMvvE3
         iaeB1gkWQ0fNZoqdy/I0fGvewI69f4A4hOaLONZhXho5qWkU6DPbBq2oKJk52XReWEui
         cAr0PvxqdDwvzXmJM581wz6BQaqytMJ80wcEEpqMqC5UO1K5VRw54s+G3gtiyat5RHkT
         e9S19n60ub6Fv/Wr+hlf07aU6udJlCBkBQSbDRFFg1E1BnM6NDMseer3QRiqfm7AMUKy
         KLd604HMH62cxXDkfgH0y4pI78wilQmOBcuqPOV9/5nqKWuzwgxv4j673k5Wweq/b+ra
         rwUQ==
X-Gm-Message-State: AOAM533xyNeghKyYaesw6OyZMnB5T6rFdDoloZQhNCJrl1YR8nvDt8mh
        YFD2QdBx/VVGpeIbAUrhQkI8CEzrlIZwLQ==
X-Google-Smtp-Source: ABdhPJzAtn3Kf7aYFaBD+N5MeiVashIxbrIrgPLnVylphEuD+GN98DTqOJ8Rsk0ILYfSoJW70Yo8rg==
X-Received: by 2002:ad4:45e6:: with SMTP id q6mr5163804qvu.28.1605311696001;
        Fri, 13 Nov 2020 15:54:56 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id g19sm6416914qkl.86.2020.11.13.15.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 15:54:54 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:54:53 -0700
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
Message-ID: <20201113235453.GA227700@ubuntu-m3-large-x86>
References: <20201104082738.1054792-1-hch@lst.de>
 <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111222116.GA919131@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Wed, Nov 11, 2020 at 10:21:16PM +0000, Al Viro wrote:
> On Wed, Nov 11, 2020 at 09:52:20PM +0000, Al Viro wrote:
> 
> > That can be done, but I would rather go with
> > 		n = copy_to_iter(m->buf + m->from, m->count, iter);
> > 		m->count -= n;
> > 		m->from += n;
> >                 copied += n;
> >                 if (!size)
> >                         goto Done;
> > 		if (m->count)
> > 			goto Efault;
> > if we do it that way.  Let me see if I can cook something
> > reasonable along those lines...
> 
> Something like below (build-tested only):
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 3b20e21604e7..07b33c1f34a9 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -168,7 +168,6 @@ EXPORT_SYMBOL(seq_read);
>  ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct seq_file *m = iocb->ki_filp->private_data;
> -	size_t size = iov_iter_count(iter);
>  	size_t copied = 0;
>  	size_t n;
>  	void *p;
> @@ -208,14 +207,11 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
> +		if (!iov_iter_count(iter) || m->count)
>  			goto Done;
>  	}
>  	/* we need at least one record in buffer */
> @@ -249,6 +245,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	goto Done;
>  Fill:
>  	/* they want more? let's try to get some more */
> +	/* m->count is positive and there's space left in iter */
>  	while (1) {
>  		size_t offs = m->count;
>  		loff_t pos = m->index;
> @@ -263,7 +260,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  			err = PTR_ERR(p);
>  			break;
>  		}
> -		if (m->count >= size)
> +		if (m->count >= iov_iter_count(iter))
>  			break;
>  		err = m->op->show(m, p);
>  		if (seq_has_overflowed(m) || err) {
> @@ -273,16 +270,14 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
> @@ -291,9 +286,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  Enomem:
>  	err = -ENOMEM;
>  	goto Done;
> -Efault:
> -	err = -EFAULT;
> -	goto Done;
>  }
>  EXPORT_SYMBOL(seq_read_iter);
>  

This patch in -next (6a9f696d1627bacc91d1cebcfb177f474484e8ba) breaks
WSL2's interoperability feature, where Windows paths automatically get
added to PATH on start up so that Windows binaries can be accessed from
within Linux (such as clip.exe to pipe output to the clipboard). Before,
I would see a bunch of Linux + Windows folders in $PATH but after, I
only see the Linux folders (I can give you the actual PATH value if you
care but it is really long).

I am not at all familiar with the semantics of this patch or how
Microsoft would be using it to inject folders into PATH (they have some
documentation on it here:
https://docs.microsoft.com/en-us/windows/wsl/interop) and I am not sure
how to go about figuring that out to see why this patch breaks something
(unless you have an idea). I have added the Hyper-V maintainers and list
to CC in case they know someone who could help.

Cheers,
Nathan
