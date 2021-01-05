Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC22EB457
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 21:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAEUjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 15:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbhAEUjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:39:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA07C061793
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jan 2021 12:38:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b26so1512997lff.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jan 2021 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fg2ptfYhMp275EJ8aZPMAK34P1NI/LW/B7PJd9XCtM=;
        b=XbqOfD/7D5bjtgFzF0RQNHSxNzsX0vBTIJAUlv110w8Ep1C+9bm8nFfgltldIE6Am5
         8mrpdAMXEwDOuIO3/ajMYWKQuH7qEeNQ1YqyUYoseneP8Y3bDQmjNsFWvaTlILPhrgug
         NsgsV3TmxKXugXsqWczid34qwfeDVB8UtgcMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fg2ptfYhMp275EJ8aZPMAK34P1NI/LW/B7PJd9XCtM=;
        b=IEisH64CF+412aL9CwHLG5VNvu1TXSGs0o1230jo9VO3L61d6dU26nGElPXzf/Y2b4
         OvylST/F9N5IOscBkvcapiGB6HSLkvTT0hIRG16TskKB35Mu3t2ApMuC9XlduTlRu0St
         HxbYbXMjsc5/9hwNJJh+n9RCEkQGNvdIwRaAs8MrapVcLP9y+IHlPx+PEtZ/k6xJEnSC
         vUEEeYqwqnCi4gvoQtAG35ubCma1T7kSaFEQ9klc3wL/zenEjrWtUJ4qvjFJAYck5iGr
         2vPpbKs/qVsJojHS0QwG+1j7dHsKe1RTTV2llR0NyEe+KyMwG6JgWrTh9FT7hSJk6Uro
         i4Tg==
X-Gm-Message-State: AOAM533YXtNJlC2Gp/Hq3x2Xi6k7QqVSjPsQr2oqJkR7G6Lmowdv1MbR
        0q+B6hlUQ04nGPqrcWUAD7fM4GuArQHhQg==
X-Google-Smtp-Source: ABdhPJyqo3ENALR50xOhO3VfWnBjqbtbITImMXzeHbZNPHqUnq2tPycM4a5SzeWtWMZCAmMiBUbIoA==
X-Received: by 2002:a19:a40b:: with SMTP id q11mr432021lfc.153.1609879128725;
        Tue, 05 Jan 2021 12:38:48 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x186sm27551lff.76.2021.01.05.12.38.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 12:38:47 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m12so1541478lfo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jan 2021 12:38:47 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr444303lfb.421.1609879127184;
 Tue, 05 Jan 2021 12:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk> <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210105195937.GX3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jan 2021 12:38:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiP9EAP=JHGKG5LUCusVjVzTQoPVyweJkrX5dP=T_NxXw@mail.gmail.com>
Message-ID: <CAHk-=wiP9EAP=JHGKG5LUCusVjVzTQoPVyweJkrX5dP=T_NxXw@mail.gmail.com>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 5, 2021 at 12:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We are not guaranteed the locking environment that would prevent
> dentry getting renamed right under us.  And it's possible for
> old long name to be freed after rename, leading to UAF here.

This whole thing isn't important enough to get the dentry lock. It's
more of a hint than anything else.

Why isn't the fix to just use READ_ONCE() of the name pointer, and do
it under RCU?

That's what dentry_name() does for the much more complex case of
actually even following parent data for a depth up to 4, much less
just a single name.

So instead of

                       spin_lock(&dentry->d_lock);
                       audit_log_untrustedstring(ab, dentry->d_name.name);
                       spin_unlock(&dentry->d_lock);

why not

                       rcu_read_lock();
                       audit_log_untrustedstring(ab,
READ_ONCE(dentry->d_name.name));
                       rcu_read_unlock();

which looks a lot more in line with the other dentry path functions.

Maybe even have this as part of fs/d_path.c and try to get rid of
magic internal dentry name knowledge from the audit code?

                  Linus
