Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9E52C326
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 21:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiERTRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbiERTRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 15:17:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47121A7E09
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 12:17:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so6560513pjr.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7pSZ4gDx+VENEDy5UyTtlQIKK7PzzJMOZAJM4t5CZQg=;
        b=fgoj898mGrrcabwYuyrGj+2hV110iGSE30uwpPXGlhiREGUe0b2/yI2pG5b1CKGdfE
         P8HQF60tGDz7pg2qijdCIBB9S6/OBL63/D47pQ6h+iHuf4yCyl2QRqP1iSbjBsASe+4y
         1kQ/T9sasEGyxk5ZR3nXaOOjkVHEAjHfj2z3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7pSZ4gDx+VENEDy5UyTtlQIKK7PzzJMOZAJM4t5CZQg=;
        b=Gy7YJrVjT9UBaXmI/QhtdW21TYgVGN7abQlaD1/g0zNB8P8K7ZNIMbLwHlNJebkwNG
         neHYEXXDeM/QPT5gVgzDGB2C/GCL/Wm+k6bz83k3A9iJ2H2CysRwMFIh55WD8LmcC2EW
         4XEo+us53j1XFd03PxO/rJ/GuzV3Ehy/4Fj4hSR539hkEzWi+mSwejFqE60L/PCR8Gew
         Banvzco1Gw65UYen7swCyL6uiKbNxUC68EllV5SwDSbpPYLuqreYNrj/P8zNyRAlT7dL
         K+SGrHSXN+nWabh33zK+hHd6sHeyUILgsEuBOdD2/W5eRoLBh73K8Y0E/J7RZ3M/+DRT
         XWQw==
X-Gm-Message-State: AOAM532bmC4CVjXdEEIPdy3vNjPXyxx7bSlrC1XVLZrPxN0fHqo9nNua
        SX23ib4lqydgT8eCTq4u5t+HB+f5fn6Ovg==
X-Google-Smtp-Source: ABdhPJyxtdnH6BTrD9fTYRGjdho2AoPcg7/pbptofY1hp0hSyoIuktjx376JNQo2OqAAVwYRnmkcIQ==
X-Received: by 2002:a17:902:e0d4:b0:161:74ba:9def with SMTP id e20-20020a170902e0d400b0016174ba9defmr1083142pla.28.1652901466752;
        Wed, 18 May 2022 12:17:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ab8c00b0015e8d4eb22asm2063193plr.116.2022.05.18.12.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:17:46 -0700 (PDT)
Date:   Wed, 18 May 2022 12:17:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH -next] exec: Remove redundant check in
 do_open_execat/uselib
Message-ID: <202205181215.D448675BEA@keescook>
References: <20220518081227.1278192-1-chengzhihao1@huawei.com>
 <20220518104601.fc21907008231b60a0e54a8e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518104601.fc21907008231b60a0e54a8e@linux-foundation.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 10:46:01AM -0700, Andrew Morton wrote:
> On Wed, 18 May 2022 16:12:27 +0800 Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> 
> > There is a false positive WARNON happening in execve(2)/uselib(2)
> > syscalls with concurrent noexec-remount.
> > 
> >        execveat                           remount
> > do_open_execat(path/bin)
> >   do_filp_open
> >     path_openat
> >       do_open
> >         may_open
> >           path_noexec() // PASS
> > 	                            remount(path->mnt, MS_NOEXEC)
> > WARNON(path_noexec(&file->f_path)) // path_noexec() checks fail

Did you encounter this in the real world?

> 
> You're saying this is a race condition?  A concurrent remount causes
> this warning?

It seems not an unreasonable thing to warn about. Perhaps since it's
technically reachable from userspace, it could be downgraded to
pr_warn(), but I certainly don't want to remove the checks.

> 
> > Since may_open() has already checked the same conditions, fix it by
> > removing 'S_ISREG' and 'path_noexec' check in do_open_execat()/uselib(2).
> > 
> > ...
> >
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -141,16 +141,6 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
> >  	if (IS_ERR(file))
> >  		goto out;
> >  
> > -	/*
> > -	 * may_open() has already checked for this, so it should be
> > -	 * impossible to trip now. But we need to be extra cautious
> > -	 * and check again at the very end too.
> > -	 */
> > -	error = -EACCES;
> > -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> > -			 path_noexec(&file->f_path)))
> > -		goto exit;
> > -
> 
> Maybe we should retain the `goto exit'.  The remount has now occurred,
> so the execution attempt should be denied.  If so, the comment should
> be updated to better explain what's happening.
> 
> I guess we'd still be racy against `mount -o exec', but accidentally
> denying something seems less serious than accidentally permitting it.

I'd like to leave this as-is, since we _do_ want to find the cases where
we're about to allow an exec and a very important security check was NOT
handled.

-- 
Kees Cook
