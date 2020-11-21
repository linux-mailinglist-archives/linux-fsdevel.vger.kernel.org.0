Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3242BC160
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgKUSTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 13:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgKUSTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:19:38 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C1C0613CF;
        Sat, 21 Nov 2020 10:19:37 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v20so13533381ljk.8;
        Sat, 21 Nov 2020 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vQCmFX/umPbiMsZoXWe+X5y6oNK3IuEAPLs+n2uAmo4=;
        b=U6l/rAIjaxTbciXjBAeL1qc2fuhrtnhaqnQSy4rdmFAGct51Jsboj7/YV3lor8izCI
         OXMpm02R1gKg4WSW574P57QHbboJGngAIK730MkBWxswxPCJM11r0XHzJd8lFEqq8BL1
         xTx98BquRqahs/1MSJJoGxHgJYW/bxRsnlYhrVn6w9+WJ6fdjmzX4X6gdfEL2aL8mxwA
         +Hw6jjmTTtkyN0xI23RQVZ08otUS88GfIdWw3LYL64RLHiSN2CUidiRmW5XLMMbAl+yV
         PfVNXnFF9nyUZiumCUYOeEZmnbH5VW3DPy8rACqCnn+u90Svtnh19/ePlCrjVWEoqXGC
         8yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQCmFX/umPbiMsZoXWe+X5y6oNK3IuEAPLs+n2uAmo4=;
        b=L9MkMpZabNz+SbPUznQPpXMWnB2RLU9d94LMJYGXAhkiqxCvd2CQCEpQCpSUTuYuHc
         oPkS+vF/Plb/72mmHzR/d/Ew9ZJU5+K3hzHnmgvtiS/eRDuxbu+iu+UPULyI/oGvXKOw
         HwYEuCt/w/CeQCdFIwUpkIjkZXtjZlyo/u6saY60hjULpSjQrWpjl/xiISgEj1hCww8B
         5sRzq0lnS7cdXE11Mt6XHhrH1HgEt+eUJgznU7qAqpb9P501t2RA7pHwkN+iplONnlma
         4DWJ7kkkdQSxX/6++qz1Y/BprSxER302dm3/Am6HXG0gPPTp1X53rAHojeOCnkRdNS3w
         439A==
X-Gm-Message-State: AOAM533mihiReCA0alPlrDMhevJQ6HeRG+0URn/zYGnp2W8ndM5EgpWV
        iEuUcrs2TwE89L2A+ruSwcw=
X-Google-Smtp-Source: ABdhPJymdebhWpdCthC1P6kzH7+x5uwWxx3Uw9cIWhTIrOvZX45MvWqWzA7naD4V/DPv+IZsUcvh2g==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr10576302lja.294.1605982776262;
        Sat, 21 Nov 2020 10:19:36 -0800 (PST)
Received: from grain.localdomain ([5.18.91.94])
        by smtp.gmail.com with ESMTPSA id r19sm785566lfi.41.2020.11.21.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 10:19:34 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 73BDE1A008D; Sat, 21 Nov 2020 21:19:33 +0300 (MSK)
Date:   Sat, 21 Nov 2020 21:19:33 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>,
        Kees Cook <keescook@chromium.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH v2 11/24] file: Implement task_lookup_fd_rcu
Message-ID: <20201121181933.GH875895@grain>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-11-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120231441.29911-11-ebiederm@xmission.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 05:14:28PM -0600, Eric W. Biederman wrote:
> 
> diff --git a/fs/file.c b/fs/file.c
> index 5861c4f89419..6448523ca29e 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -865,6 +865,21 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
>  	return file;
>  }
>  
> +struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd)
> +{
> +	/* Must be called with rcu_read_lock held */

Eric, maybe worth to have something like

	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
			 "suspicious task_lookup_fd_rcu() usage");

here?
