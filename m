Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AAB1E473A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgE0PXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgE0PXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 11:23:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9ECC05BD1E;
        Wed, 27 May 2020 08:23:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so28602936ejb.3;
        Wed, 27 May 2020 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sOraBazhvT2a0mZdINuhAPimqgAtYkj9MdJtgUZJzFA=;
        b=nXjJXfG5ZIYYXzjKpVe0Ao5guKxaTq6eG1ms+swzDkTfYBMipFk9L6GsrvKFislxJs
         dBIqxvOTsPbV0TTUjqpMCXCahV2uT2OMBmIjopMyLUpGgnN3dzgrX3K9ruMP7+zvWJHa
         6Q9ESTx09Ghp2n8X9aWA8f0oq9k4DFfE668nw/6ESO0q1kCNk8QKWAeTx9jkANIQc5h7
         v/HgPqlVJojQNOhVF4rWPXpYBh7sCOqWckXWaNkz1tRW4OVoMIM6t3KVhwqxSrMWEYuR
         0Eq7ucpSbnC3F/NLXbJW47KZZ7LuMVM7Y9LqMRBaTegrqbGRgmxu1y7g6FfADkD02yN5
         jJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sOraBazhvT2a0mZdINuhAPimqgAtYkj9MdJtgUZJzFA=;
        b=d26Mnrh13I084PkdvG2a5z6gi5ov5L3LyKsnct5kp54O2et1ugfmx/HHj3npWEA+V9
         XMzf9a1l2MRbwdUsU8AafXIeeUI3VWB8ZWoocQuFf6OvLuPwO2OA/12HuxwV5GXJPZOR
         91kdiCm9/7pegrsp3dmAbPbWjPXtzDuW+6tGLvgoekRhViZob0+vlXPxuJDU2fYO8qa4
         VJXYkkyLorv4MUajlPNWYHMLn1dVIxZEwCxcCY3/yDO2JLEHS734ZD+rsHStKsuEd7Rh
         6ZleVFrMKe4hnu5nndjR84oAxjsDP4acDDTBvOzBiZNnJxZX+IiW3ctxpuiOxYf8WkdS
         /cMA==
X-Gm-Message-State: AOAM5335zXrccktsbH8npKrdeBtR7b6Kl2xEkT6MWy6gsb8kcY2zPVps
        jHfovtI0pJdbowqXh8T2RA==
X-Google-Smtp-Source: ABdhPJzI8Z1ajzX61gxQw4uLhe7lK2uddCIzmaZ4nEH9DK6bQgMgfzSTmkBvrii4Sfm5dPEUTs3noA==
X-Received: by 2002:a17:906:be2:: with SMTP id z2mr6458926ejg.169.1590593022923;
        Wed, 27 May 2020 08:23:42 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.218])
        by smtp.gmail.com with ESMTPSA id b15sm2436073edk.90.2020.05.27.08.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:23:42 -0700 (PDT)
Date:   Wed, 27 May 2020 18:23:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, christian@brauner.io,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com, guro@fb.com,
        walken@google.com, avagin@gmail.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/base: Skip assignment to len when there is no error
 on d_path in do_proc_readlink.
Message-ID: <20200527152340.GA19985@localhost.localdomain>
References: <20200527141155.47554-1-pilgrimtao@gmail.com>
 <87k10x5tji.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k10x5tji.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 09:41:53AM -0500, Eric W. Biederman wrote:
> Kaitao Cheng <pilgrimtao@gmail.com> writes:
> 
> > we don't need {len = PTR_ERR(pathname)} when IS_ERR(pathname) is false,
> > it's better to move it into if(IS_ERR(pathname)){}.
> 
> Please look at the generated code.
> 
> I believe you will find that your change will generate worse assembly.

I think patch is good.

Super duper CPUs which speculate thousands instructions forward won't
care but more embedded ones do. Or in other words 1 unnecessary instruction
on common path is more important for slow CPUs than for fast CPUs.

This style separates common path from error path more cleanly.

And finally "len" here is local, so the issue barely deserves mention
but if target is in memory code like this happens:

	static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
	{
	        struct fd f = fdget(fd);
	        struct socket *sock;
	
	        *err = -EBADF;
	        if (f.file) {
	
			// unconditionally write to *err as well.

	                sock = sock_from_file(f.file, err);
	                if (likely(sock)) {
	                        *fput_needed = f.flags;
	                        return sock;
	                }
	                fdput(f);
	        }
	        return NULL;
	}

so current style promotes more memory dirtying than necessary.

There is another place like this in sk_buff.c (search for ENOBUFS).

> >  	pathname = d_path(path, tmp, PAGE_SIZE);
> > -	len = PTR_ERR(pathname);
> > -	if (IS_ERR(pathname))
> > +	if (IS_ERR(pathname)) {
> > +		len = PTR_ERR(pathname);
> >  		goto out;
> > +	}
