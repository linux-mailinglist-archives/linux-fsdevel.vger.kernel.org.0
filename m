Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADC349D5A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 23:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiAZWtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 17:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiAZWtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:49:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF8C06173B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 14:49:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x11so896182plg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 14:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QeowK8R255Us+nKjz4BPqDxIP7O3Rv/Tsw0L3glrT4Q=;
        b=E3FWDUveRxI1hYgPJa1ZNUBSk3AJ5jItt9POskqPuQxFr1D1qDPioM9fYOVMkyazoV
         GHfnkSEGdTIWr8kQPPnyH1Btpm0xLkbqJLpqGhC7n3g49m/IHaTy1I38xtJ9NHZ6qijP
         0tmwDrgf26AoClhLLknd95bm/cYZ9qDwvxKAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QeowK8R255Us+nKjz4BPqDxIP7O3Rv/Tsw0L3glrT4Q=;
        b=oFeqjhJqWG0jWHNq4541fRryl+Tm4j7/yQNavN28JBxwDCPcNQImuIUf7oQiQ8HVPE
         04sp4DTqTMMNzDKle0JZhh2jIgU4TEzVM50qYuYncMg67bXr64YIU+WUNBKnZ78p0t3S
         s3z4oU9TvTA6fmRcs7+tJWKhitwVl8ZHDyh5alI+l3kC8d3PrMOuyRdva1tzNt+ZfILT
         D12hqGXOhxSNfrOJ2uJ6O4f8ieIlQc7Wpsgz6WrzXNSpxw5Yap731RHOfpHUZZorhFW2
         umPbA8PXGq8bFOBUjbeBhgiQxNhnjQTVRc2UyTnvCK5GOBDlLLfBgLL9HAo/TiEe4y9Y
         BOaQ==
X-Gm-Message-State: AOAM5322R53SXRqNpfUy06G9W2oVHrxuNnb4npnndKARZF99zNZT8BpR
        /c6PbRZuIWqEkyWxXF12jBseSA==
X-Google-Smtp-Source: ABdhPJx5pVg6o3rc7yEuKI/WbUq70Htq1e33E1Lf1zMoqVH2u7MbFdL+lpdosl0Yn3AehkYFwKRnrQ==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr10929856pjb.131.1643237354638;
        Wed, 26 Jan 2022 14:49:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u17sm17431673pgi.14.2022.01.26.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:49:14 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:49:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <202201261440.0C13601104@keescook>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
 <202201261202.EC027EB@keescook>
 <a8fef39-27bf-b25f-7cfe-21782a8d3132@dereferenced.org>
 <202201261239.CB5D7C991A@keescook>
 <5e963fab-88d4-2039-1cf4-6661e9bd16b@dereferenced.org>
 <202201261323.9499FA51@keescook>
 <64e91dc2-7f5c-6e8-308e-414c82a8ae6b@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e91dc2-7f5c-6e8-308e-414c82a8ae6b@dereferenced.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:30:13PM -0600, Ariadne Conill wrote:
> Hi,
> 
> On Wed, 26 Jan 2022, Kees Cook wrote:
> 
> > On Wed, Jan 26, 2022 at 03:13:10PM -0600, Ariadne Conill wrote:
> > > Looks good to me, but I wonder if we shouldn't set an argv of
> > > {bprm->filename, NULL} instead of {"", NULL}.  Discussion in IRC led to the
> > > realization that multicall programs will try to use argv[0] and might crash
> > > in this scenario.  If we're going to fake an argv, I guess we should try to
> > > do it right.
> > 
> > They're crashing currently, though, yes? I think the goal is to move
> > toward making execve(..., NULL, NULL) just not work at all. Using the
> > {"", NULL} injection just gets us closer to protecting a bad userspace
> > program. I think things _should_ crash if they try to start depending
> > on this work-around.
> 
> Is there a reason to spawn a program, just to have it crash, rather than
> just denying it to begin with, though?

I think the correct behavior here is to unconditionally reject a NULL
argv -- and I wish this had gotten fixed in 2008. :P Given the code we've
found that depends on NULL argv, I think we likely can't make the change
outright, so we're down this weird rabbit hole of trying to reject what we
can and create work-around behaviors for the cases that currently exist.
I think new users of the new work-around shouldn't be considered. We'd
prefer they get a rejection, etc.

> I mean, it all seems fine enough, and perhaps I'm just a bit picky on the
> colors and flavors of my bikesheds, so if you want to go with this patch,
> I'll be glad to carry it in the Alpine security update I am doing to make
> sure the *other* GLib-using SUID programs people find don't get exploited in
> the same way.

They "don't break userspace" guideline is really "don't break userspace
if someone notices". :P Since this is a mitigation (not strictly a
security flaw fix), changes to userspace behavior tend to be very
conservatively viewed by Linus. ;)

My preference is the earlier very simple version to fix this:

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..aabadcf4a525 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1897,6 +1897,8 @@ static int do_execveat_common(int fd, struct filename *filename,
 	}
 
 	retval = count(argv, MAX_ARG_STRINGS);
+	if (reval == 0)
+		retval = -EINVAL;
 	if (retval < 0)
 		goto out_free;
 	bprm->argc = retval;

So, I guess we should start there and send a patch to valgrind?

-- 
Kees Cook
