Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB9024C75A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 23:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgHTVus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 17:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTVup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:50:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA2C061385;
        Thu, 20 Aug 2020 14:50:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j22so1715981lfm.2;
        Thu, 20 Aug 2020 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7AT6xe8X2sqCtMqnt9f+SepCQYWF9ewRZrrb25ZUrXA=;
        b=uHYHvhOVAtZD3s88MupqVp6p5JxFv0OUp77vnXiDnZnCApFK6ED2eGConlbikzoog7
         EHBnL7MWkjTHduKfJiVRlA730UtZcBFWJjnKvgOTXqLFa58iA3a/H1uSmWZBlHzD1lO6
         KJteIauUpAdZOIWOJfDF+WCh829sP2qum49l4Fn50VSwfrsF2a0NDB0FPcG8DXouCUEV
         8S00h5WfFK0zIQ+fKoJIm50OIV2KE1n2NJ0mGNYAp+vnkebg6Gsg3tQDpEmDCi3oNcG/
         qd7SNjQOQXYhcr7V1ieKgcQsOswMFOtSURuvTWXXGW2Jl8gAIqutN7uCUB3CklZyJPPl
         y8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7AT6xe8X2sqCtMqnt9f+SepCQYWF9ewRZrrb25ZUrXA=;
        b=S0tBSstj6DCKyCRf2oEZnKincDNzrXBau5QDsUyMWSOExgs5ACzpeAZ749USGyS1Gd
         3CFskXV0VufYXL9Nc4DPanRcZJhXPBnQSP+Fn8UG+vt/8b9HAVpzXQeB6cV9wRJURb5+
         DcWexmnPwR4zzqKEo74XH3VopqBizE0fQFzFU3Md4ZtUmdRNdAyjp69dA5pw7UtuAkZz
         ejd7EgYg/oeR7DG+VysAGvDBPy4mtF9LtW6aotapCGbw3EeH1b2pFNgSMg7HCfe/8J+Z
         fC2C18C9Z/jYbigzTigzavtpdOxnLdLYAC5uoxnwTaNcrlFOHLv7oM9ornfKnXbbvQm5
         Wcug==
X-Gm-Message-State: AOAM532OFi9qnvO+GvedrleKTS4Kc0y4I3WYKazoFg9v3lYLsPglmfoY
        wy4A94bQbndZZ13Sh/To4MU=
X-Google-Smtp-Source: ABdhPJxJN+zRWB5H3PbcUJeY+wulDlizc7kgOfjBePwy17SCe21+bOgb9+nLsxmVcCy6k+Pkq1IROg==
X-Received: by 2002:a05:6512:1044:: with SMTP id c4mr191023lfb.77.1597960243085;
        Thu, 20 Aug 2020 14:50:43 -0700 (PDT)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id c5sm746605lfb.24.2020.08.20.14.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:50:41 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 9F7CC1A0078; Fri, 21 Aug 2020 00:50:41 +0300 (MSK)
Date:   Fri, 21 Aug 2020 00:50:41 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>,
        Kees Cook <keescook@chromium.org>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
Message-ID: <20200820215041.GT2074@grain>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817220425.9389-9-ebiederm@xmission.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:17PM -0500, Eric W. Biederman wrote:
> As a companion to fget_task and fcheck_task implement fnext_task that
> will return the struct file for the first file descriptor show number
> is equal or greater than the fd argument value, or NULL if there is
> no such struct file.
> 
> This allows file descriptors of foreign processes to be iterated through
> safely, without needed to increment the count on files_struct.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/file.c               | 21 +++++++++++++++++++++
>  include/linux/fdtable.h |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 8d4b385055e9..88f9f78869f8 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -876,6 +876,27 @@ struct file *fcheck_task(struct task_struct *task, unsigned int fd)
>  	return file;
>  }
>  
> +struct file *fnext_task(struct task_struct *task, unsigned int *ret_fd)
> +{
> +	/* Must be called with rcu_read_lock held */
> +	struct files_struct *files;
> +	unsigned int fd = *ret_fd;
> +	struct file *file = NULL;
> +
> +	task_lock(task);
> +	files = task->files;
> +	if (files) {
> +		for (; fd < files_fdtable(files)->max_fds; fd++) {
> +			file = fcheck_files(files, fd);
> +			if (file)
> +				break;
> +		}
> +	}
> +	task_unlock(task);
> +	*ret_fd = fd;
> +	return file;
> +}

Eric, if only I'm not missing something obvious you could
escape @fd/@ret_fd operations in case if task->files = NULL,
iow

	if (files) {
		unsigned int fd = *ret_fd;
		for (; fd < files_fdtable(files)->max_fds; fd++) {
			file = fcheck_files(files, fd);
			if (file)
				break;
		}
		*ret_fd = fd;
	}
