Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5E1CBDAC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 07:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgEIFPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 01:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 01:15:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A571C061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 22:15:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so5229321pjd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XTxB7TBhsdShdMgjzI9wbmAEL1VN9eGtCUOLpw0Dhqo=;
        b=EZYGP6IlZ48o0TQdSs6Rjb7rstE0z1btnrdJwP1ASjQuWWwN6dEFHb6yilUPeejzxz
         rhuwaxho4siY7FArIroEkqBIyXBAl++Hyx511EtIGoHsdQt+xbbRHtVkyBz7dTxFwdqX
         ojevI5WbAgRXwgB13i1uiQOLG4uc4wDw7IGdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XTxB7TBhsdShdMgjzI9wbmAEL1VN9eGtCUOLpw0Dhqo=;
        b=JP1KnqB8Y9yXF70ytpvcNfwFffXj2i8Hw6zjE/Es5QUmVfyQEl1Fan7UoYrhIvqn7v
         8+Geu54pPmQ6VFqys+G5VcNNaSoY11G7u2qCzgyTyN7h6dpNJwUnj+Zhz2HRQxL0ljZX
         9ZBsNYjSDEsFzm/XqGWMd6jSUQN1Y68520bP4u/rYu29Vy8PJA3ul/eoCJaPh1c3sWOF
         8rllCN52al/S6nKxW5hsafaq3C2J5I8KlJQHnkbq6A7R0BB0BwYW7jolkfi/UbzBqihr
         KU5DC7pfr9BVTL5bR/OdJVfuoCy9RuAu1IQgQU8tn0IEoppOQoc6bNEAK5biEIZw+2q1
         jNVg==
X-Gm-Message-State: AGi0PubAJ/G3uHA8ZBv9eXF+tIdyT4nbV1ijWJDGr2KHG5qOd3Aq0/f9
        8iDr6OzXHgqb3ooX7yXsLeO73Q==
X-Google-Smtp-Source: APiQypK6wLtLdxZAif3gmVAMTp7xe+iZZJ4zwls4FEvEiEtFuQFuOD+9KWmYvNRLQSK/BppSvDffFg==
X-Received: by 2002:a17:902:8f8b:: with SMTP id z11mr5553423plo.208.1589001344731;
        Fri, 08 May 2020 22:15:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 20sm3429761pfx.116.2020.05.08.22.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:15:43 -0700 (PDT)
Date:   Fri, 8 May 2020 22:15:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/6] exec: Run sync_mm_rss before taking exec_update_mutex
Message-ID: <202005082213.8BDD4AC0CC@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <875zd66za3.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zd66za3.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 01:45:56PM -0500, Eric W. Biederman wrote:
> Like exec_mm_release sync_mm_rss is about flushing out the state of
> the old_mm, which does not need to happen under exec_update_mutex.
> 
> Make this explicit by moving sync_mm_rss outside of exec_update_mutex.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Additional thoughts below...

> ---
>  fs/exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 11a5c073aa35..15682a1dfee9 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1051,13 +1051,14 @@ static int exec_mmap(struct mm_struct *mm)
>  	tsk = current;
>  	old_mm = current->mm;
>  	exec_mm_release(tsk, old_mm);
> +	if (old_mm)
> +		sync_mm_rss(old_mm);
>  
>  	ret = mutex_lock_killable(&tsk->signal->exec_update_mutex);
>  	if (ret)
>  		return ret;
>  
>  	if (old_mm) {
> -		sync_mm_rss(old_mm);
>  		/*
>  		 * Make sure that if there is a core dump in progress
>  		 * for the old mm, we get out and die instead of going

$ git grep exec_mm_release
fs/exec.c:      exec_mm_release(tsk, old_mm);
include/linux/sched/mm.h:extern void exec_mm_release(struct task_struct *, struct mm_struct *);
kernel/fork.c:void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)

kernel/fork.c:

void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
{
        futex_exit_release(tsk);
        mm_release(tsk, mm);
}

void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
{
        futex_exec_release(tsk);
        mm_release(tsk, mm);
}

$ git grep exit_mm_release
include/linux/sched/mm.h:extern void exit_mm_release(struct task_struct *, struct mm_struct *);
kernel/exit.c:  exit_mm_release(current, mm);
kernel/fork.c:void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)

kernel/exit.c:

        exit_mm_release(current, mm);
        if (!mm)
                return;
        sync_mm_rss(mm);

It looks to me like both exec_mm_release() and exit_mm_release() could
easily have the sync_mm_rss(...) folded into their function bodies and
removed from the callers. *shrug*

-- 
Kees Cook
