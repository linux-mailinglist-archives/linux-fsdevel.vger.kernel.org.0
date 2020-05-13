Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713D11D1447
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbgEMNNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 09:13:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46917 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgEMNNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 09:13:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id p21so1908150pgm.13;
        Wed, 13 May 2020 06:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uq9dGFS0JVEQgrQR7OlP7twEZ+C/lLS/sMFl5mNJPHU=;
        b=Q7ttVilNlu+0UxHRSUg7h2tBi0EnQxJFitrkJkJeV8bATveqhijQRuG7USaliPTZ04
         vyEzxvQA4nV1V//9jCcM3ifCH2RkzEK7CgQOdvho1hvN/1qvxFOpwwe3MkKYvd+sxhxu
         8AP/cwTn0/4R8vpqykva99/GfhJZO2MGOPmHae/l5n70aViy0nnHJtnxO9aXddbNiuxi
         PeanzS73DjhbmvlJhBImSGTAEGMYKd+I5E+gJ6RfuyZmX2Nyu+kps4wAb1xv9Nl9EGr5
         0rHPwRjLSmj6GtMWWJEtHFcgQi1x/t/Xe1+t31a1yc2lOPrCBediE+eJ4tvQRj8vNF9C
         84Tw==
X-Gm-Message-State: AGi0PuayJdtyH4SRdDIc+kIMSGyRItjO9wX3XW1FauYwE4YsRzE30494
        C7B3gVmKeTj278nfTLVYB0w=
X-Google-Smtp-Source: APiQypKxV8QSG1pho/PpbgmnF61eWRfmHsoySCpOwBrcsRDeAgIsQVdeiZfuuDmDB1tV1uEtV4xZlg==
X-Received: by 2002:a63:d24a:: with SMTP id t10mr24091301pgi.326.1589375617458;
        Wed, 13 May 2020 06:13:37 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d20sm15112860pjs.12.2020.05.13.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:13:36 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4C2B54063E; Wed, 13 May 2020 13:13:35 +0000 (UTC)
Date:   Wed, 13 May 2020 13:13:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, axboe@kernel.dk,
        zohar@linux.vnet.ibm.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in
 kernel_read_file_from_fd()
Message-ID: <20200513131335.GN11244@42.do-not-panic.com>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
 <20200513054950.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513054950.GT23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 06:49:50AM +0100, Al Viro wrote:
> On Tue, May 12, 2020 at 01:43:05PM -0600, Shuah Khan wrote:
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 06b4c550af5d..ea24bdce939d 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> >  		goto out;
> >  
> >  	ret = kernel_read_file(f.file, buf, size, max_size, id);
> > -out:
> >  	fdput(f);
> > +out:
> >  	return ret;
> 
> Incidentally, why is that thing exported?

Both kernel_read_file_from_fd() and kernel_read_file() are exported
because they have users, however kernel_read_file() only has security
stuff as a user. Do we want to get rid of the lsm hook for it?

I also have some non-posted patches which tucks away these kernel_read*()
exports under a symbol namespace, to avoid wide-spread use / abuse on
areas in the kernel, so I'd be happy to take this on if we want to
remove it export / lsm hook as part of my series. I did this as there
is another series of patches for a new driver which extend these family
of functions with a now pread() variant....

  Luis
