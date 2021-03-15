Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5233C4B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 18:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhCORk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 13:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhCORkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:40:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01F7C061762
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 10:40:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so2294117pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u9ZJZrVbjHX+sPNQkFOuO7kEAmZWytlGCPF2PK2JOqU=;
        b=Y3zm8mn+hcguMv8v3TdJ/RgMcPs5ZhEjRfzBRw18H4RtgOixdvOeYslQC6QFBHIF23
         AA1p+wG/RubaVeVlBcWxpLU7U0/BWFwEGlDW4JLwJoM37zfQhXUauiOjyGUWdfeYvS6s
         yXZWHyaRyosLIrsEkk8Izy8TiNIr4mLSm1GN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u9ZJZrVbjHX+sPNQkFOuO7kEAmZWytlGCPF2PK2JOqU=;
        b=txV0pjOgy9tW4ppFoAeelwyLkQXnvffgW51vS38vFIGiuIYa3rT5OVNo2SadE8xtxh
         la2uHFBQqiwVPjbV7lzPx8/UngONrDN7RzWuy/9jPSBigRseY3zVFmn2RtdIHC2UhoRp
         ByrXCntutcQ6FCsXrkwtezc1tqPmwJnQP/6hPlHVFXIdwKNPZj2B8wDCWURIChbrVs1x
         rX9nrOmI+OmaELtMna2RjBZxb9rx85/Jy8TV+clfRq7UkwP4heGFWpWDRbyFHKuOfe3C
         TmI9dI3NJRTKXfcuDr11kH7ojimHPplG4985DTYEYU8SUqCXb8KxMdLyr12z093h4idx
         PuUQ==
X-Gm-Message-State: AOAM531hHbsavFeZbOgTadvlxN6+PgG6jwKqQv/MX0734dL5ODQ6ZtPt
        9I+Go3+CpHbotPIIbHs/CVElIQ==
X-Google-Smtp-Source: ABdhPJyhiuHpYtDv/Lna03qrgA/JUfdkRRDVSKn6FkSn7ext1b4iqZwUEjQ+rc0ABzDdqGzkF8arjQ==
X-Received: by 2002:a17:90a:e542:: with SMTP id ei2mr218020pjb.134.1615830049338;
        Mon, 15 Mar 2021 10:40:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l22sm275837pjl.14.2021.03.15.10.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:40:48 -0700 (PDT)
Date:   Mon, 15 Mar 2021 10:40:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <202103151032.53E48DC@keescook>
References: <20210312205558.2947488-1-keescook@chromium.org>
 <YE8cCslnGkgmKTsY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE8cCslnGkgmKTsY@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:34:18AM +0100, Michal Hocko wrote:
> On Fri 12-03-21 12:55:58, Kees Cook wrote:
> > The sysfs interface to seq_file continues to be rather fragile, as seen
> > with some recent exploits[1]. Move the seq_file buffer to the vmap area
> > (while retaining the accounting flag), since it has guard pages that
> > will catch and stop linear overflows. This seems justified given that
> > seq_file already uses kvmalloc(), that allocations are normally short
> > lived, and that they are not normally performance critical.
> 
> What is the runtime effect of this change? The interface is widely used

I haven't been able to measure any differences yet, but maybe I lack
imagination about workloads that are heavy on /sys or /proc accesses.

> for many other interfaces - e.g. in proc. While from the correctness POV
> this should be OK (ish for 64b it is definitely problem for kernels with
> lowmem and limited vmalloc space). Vmalloc is also to be expected to
> regress in performance for small allocations which is the most usual
> case.

seq_file's default size is PAGE_SIZE (and just goes up by powers of 2
from there), with the rare (3 callers) exception of single_open_size(),
which for at least 1 case is always >PAGE_SIZE. (I realize PAGE_SIZE may
be considered "small" for vmalloc, but I think gaining the guard page is
worth it, given the recurring flaws we see with at least sysfs handlers.)

-Kees

>  
> > [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/seq_file.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/seq_file.c b/fs/seq_file.c
> > index cb11a34fb871..ad78577d4c2c 100644
> > --- a/fs/seq_file.c
> > +++ b/fs/seq_file.c
> > @@ -32,7 +32,7 @@ static void seq_set_overflow(struct seq_file *m)
> >  
> >  static void *seq_buf_alloc(unsigned long size)
> >  {
> > -	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
> > +	return __vmalloc(size, GFP_KERNEL_ACCOUNT);
> >  }
> >  
> >  /**
> > @@ -130,7 +130,7 @@ static int traverse(struct seq_file *m, loff_t offset)
> >  
> >  Eoverflow:
> >  	m->op->stop(m, p);
> > -	kvfree(m->buf);
> > +	vfree(m->buf);
> >  	m->count = 0;
> >  	m->buf = seq_buf_alloc(m->size <<= 1);
> >  	return !m->buf ? -ENOMEM : -EAGAIN;
> > @@ -237,7 +237,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  			goto Fill;
> >  		// need a bigger buffer
> >  		m->op->stop(m, p);
> > -		kvfree(m->buf);
> > +		vfree(m->buf);
> >  		m->count = 0;
> >  		m->buf = seq_buf_alloc(m->size <<= 1);
> >  		if (!m->buf)
> > @@ -349,7 +349,7 @@ EXPORT_SYMBOL(seq_lseek);
> >  int seq_release(struct inode *inode, struct file *file)
> >  {
> >  	struct seq_file *m = file->private_data;
> > -	kvfree(m->buf);
> > +	vfree(m->buf);
> >  	kmem_cache_free(seq_file_cache, m);
> >  	return 0;
> >  }
> > @@ -585,7 +585,7 @@ int single_open_size(struct file *file, int (*show)(struct seq_file *, void *),
> >  		return -ENOMEM;
> >  	ret = single_open(file, show, data);
> >  	if (ret) {
> > -		kvfree(buf);
> > +		vfree(buf);
> >  		return ret;
> >  	}
> >  	((struct seq_file *)file->private_data)->buf = buf;
> > -- 
> > 2.25.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Kees Cook
