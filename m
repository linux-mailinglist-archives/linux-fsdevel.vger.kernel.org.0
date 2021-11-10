Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1787044CA6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 21:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhKJUUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 15:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhKJUUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:20:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A9C06127A
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 12:17:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x7so2439384pjn.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJ30f4yltU8P9D1vIvrgm4JmaUKFVTUymd542MzbX34=;
        b=g9lNF+pd24Lg+MqAqHCV7wh24XIQNX4IMaEiJo9WPFtT4ECrdlVpmAPO8QVV2WHbFK
         nQ+O9QSeWTirPqQxEh3uFPZ+WLk8Q0CYxvBO5RUARXtXksYhPr4lmu5668PzlePyOmcl
         As4OgFb6VXL9nsV00X1BkxHIuNlUxiMXmbd8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJ30f4yltU8P9D1vIvrgm4JmaUKFVTUymd542MzbX34=;
        b=Akf75zrCEGRr97n/GZomgNE5NQiy6ul1URTwP2tl+xzR12yIh098banqNwIbgIf2Rq
         5MbN5Kn0hRuTahgjbwEEeo2xdSQyYrSNr/IPMfp0ZjgL4/RWl+L3OuPFkjqMAkOpEzjj
         6qamaPkfYDnfgxZSy2eI7vukqoddOAZ41PxSni40TThCYWQP29lExbE2QaRMgdJ9sl5Z
         SLagvF1tHvMi+XFEcCjBldx8yBoHpijBegVTpitzFwbSZTQyAEIZmbH8YpTJ3OG35urg
         ++aUQNtxF15ry0UnkyelFew7jVBp/+O6v5Ha2mFseGbkvI+lhg4aq6oCMGW+J2xtbQUi
         nFNw==
X-Gm-Message-State: AOAM531ITDHwrjfeswrqMmyH9YGv6VMl7GfKQEQwj+Nu2j9gmp+ngPOE
        z5M5uAPA6RwwJT7sJfXH6h/QxQ==
X-Google-Smtp-Source: ABdhPJy9OJ/YGW/eEJO6u7l+llSGLL86Mlc82irnMKIDFwKNMwM8Slu26rVYUZa6XKnHewItU9EAMw==
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr1928527pjb.66.1636575455497;
        Wed, 10 Nov 2021 12:17:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fw21sm6200587pjb.25.2021.11.10.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:17:35 -0800 (PST)
Date:   Wed, 10 Nov 2021 12:17:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/7] fs/exec: make __set_task_comm always set a nul
 terminated string
Message-ID: <202111101215.A42612FEC@keescook>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-2-laoar.shao@gmail.com>
 <c3571571-320a-3e25-8409-5653ddca895c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3571571-320a-3e25-8409-5653ddca895c@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:28:12AM +0100, David Hildenbrand wrote:
> On 08.11.21 09:38, Yafang Shao wrote:
> > Make sure the string set to task comm is always nul terminated.
> > 
> 
> strlcpy: "the result is always a valid NUL-terminated string that fits
> in the buffer"
> 
> The only difference seems to be that strscpy_pad() pads the remainder
> with zeroes.
> 
> Is this description correct and I am missing something important?

Yes, this makes sure it's zero padded just to be robust against full
tsk->comm copies that got noticed in other places.

The only other change is that we want to remove strlcpy() from the
kernel generally since it can trigger out-of-bound reads on the source
string[1].

So, in this case, the most robust version is to use strscpy_pad().

-Kees

[1] https://github.com/KSPP/linux/issues/89

> 
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl> 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Petr Mladek <pmladek@suse.com>
> > ---
> >  fs/exec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index a098c133d8d7..404156b5b314 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1224,7 +1224,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
> >  {
> >  	task_lock(tsk);
> >  	trace_task_rename(tsk, buf);
> > -	strlcpy(tsk->comm, buf, sizeof(tsk->comm));
> > +	strscpy_pad(tsk->comm, buf, sizeof(tsk->comm));
> >  	task_unlock(tsk);
> >  	perf_event_comm(tsk, exec);
> >  }
> > 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Kees Cook
