Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81D49CFE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 17:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbiAZQkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 11:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbiAZQkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:40:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C5C06173B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 08:40:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g20so3443565pgn.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xlvtukPzO3AbDCendFmDfyQYe8h/PUQ59az8EWEzUIM=;
        b=Tme9WIGcNwKUvBZLe5uBmYfLFGOUWTb7ZOBDb6YzaqQHeVFLZ/Kf02fTmy5XUTXhtz
         Vdrs7J4JICea53k0jExmgiNaqeAXDYYh60NDrFiruQpSe0jHriYTNcGGwpr73CM3WH0Y
         aYLHRNmqdcXvH5ys19iNwkqCZFu86lMdSOkgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xlvtukPzO3AbDCendFmDfyQYe8h/PUQ59az8EWEzUIM=;
        b=fiEp7CswKFZhcGzCwUF0Jl9e8zKSNhJD3LplVhUUzgD8isB2bKLEZsQwHJ7hEDSFdA
         JWliDVlfgZfmZgGcrx9gCXnJRdG+gCyANkHzFqvejFZGFNU9DTXp8TcHBbEA385C9ZZO
         0RhntKcgXojGuMfoJhVM8J6ImuGI979qN+782ILRGR4MkhqNwP+U93Dm2ubqRcV2ZaLS
         xcPEDuHDRg0fAucIbDc7shf/2xDV1dXsMDPx4KJBELPkYmNraMk1Tanypgn3PNGGm3An
         dvG5CKywcuWCarLznYB3iFzcibo0IcPCZSgNpv/eU81zERvfvsN0mDeA7tYn3yQwyS8h
         99QQ==
X-Gm-Message-State: AOAM533W27wAS7jlOWSwJCyudWHnpoaMJfk+G1XYPfj9H43n2M0nhfVV
        Hd0lHy4ZdPylWPZbmSkilxBl2w==
X-Google-Smtp-Source: ABdhPJyazfih2Ue5JGMq/Tmv4ifP9hOFAC5jiPtgcSiXBdga/ZIDhLSQyaX3VcP8OzF1HUiV9tIBJg==
X-Received: by 2002:a63:2023:: with SMTP id g35mr19834474pgg.432.1643215250805;
        Wed, 26 Jan 2022 08:40:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mn2sm3393097pjb.38.2022.01.26.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:40:50 -0800 (PST)
Date:   Wed, 26 Jan 2022 08:40:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <202201260832.CCC8BB9@keescook>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
 <YfFh6O2JS6MybamT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFh6O2JS6MybamT@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:59:52PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
> > Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
> > but there was no consensus to support fixing this issue then.
> > Hopefully now that CVE-2021-4034 shows practical exploitative use
> > of this bug in a shellcode, we can reconsider.
> > 
> > [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
> 
> Having now read 8408 ... if ABI change is a concern (and I really doubt
> it is), we could treat calling execve() with a NULL argv as if the
> caller had passed an array of length 1 with the first element set to
> NULL.  Just like we reopen fds 0,1,2 for suid execs if they were closed.

I was having similar thoughts this morning. We can't actually change the
argc, though, because of the various tests (see the debian code search
links) that explicitly tests for argc == 0 in the child. But, the flaw
is not the count, but rather that argv == argp in the argc == 0 case.
(Or that argv NULL-checking iteration begins at argv[1].)

But that would could fix easily by just adding an extra NULL. e.g.:

Currently:

argc = 1
argv = "foo", NULL
envp = "bar=baz", ..., NULL

argc = 0
argv = NULL
envp = "bar=baz", ..., NULL

We could just make the argc = 0 case be:

argc = 0
argv = NULL, NULL
envp = "bar=baz", ..., NULL

We need to be careful with the stack utilization counts, though, so I'm
thinking we could actually make this completely unconditional and just
pad envp by 1 NULL on the user stack:

argv = "what", "ever", NULL
       NULL
envp = "bar=baz", ..., NULL

My only concern there is that there may be some code out there that
depends on envp immediately following the trailing argv NULL, so I think
my preference would be to pad only in the argc == 0 case and correctly
manage the stack utilization.

-- 
Kees Cook
