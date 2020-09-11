Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240BB2655FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIKAVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 20:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIKAU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 20:20:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3DC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 17:20:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z22so11347979ejl.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 17:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyAAsSx7nFV/dq/SzL35IFpVJ+Yn15D4pJKs31u9n78=;
        b=SijTA2JBh2igQyUFhnGY43n8X9KiE/1xBjEYzMfT6RvTVPBWKIf2S98WFdxu9pntLY
         3FWTWsLcOBbZZP+uQKQQFz4ztqRQDTHyvvYDTLpZ/Yx9mHMQtmxixW2u+2Iv/F2pmzx0
         9Shwb8Rd2BYkk5HW11A7nj4k+Z9OU+m6AuaF06ISqWp+Wo0Dxl3Ftte6cYPtPbWW1yZR
         JLLqu2Dvol/xqraTUN3AMxutXgpUnMwIbPWTFot3PWxuMyymTw8Kv6tYWx+E0bQ1fw0S
         kVuDX8lq+sS+iKyOplLtlkXB4ZB4Y983W8fe/h7lUU2TIMbQmGvwGw79xY/i1sapn5fC
         JATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyAAsSx7nFV/dq/SzL35IFpVJ+Yn15D4pJKs31u9n78=;
        b=E4dtKWDn2cGcG5JuX9N8GbP++cl10W3Z8xCK7Zf3GtGNjlGendTBqfCOpRVjJU9CAH
         aVeuFdwCcj4IVMFjqvcpWqD+a2QVpw41oe48DKw+sCVQ0mYpDzouHnQi2C23CVywveL/
         +ACah4QGWGMWxvqcrHotgGDTRSTKhRt820yu6t9t6uhChQplUIzJWandr436kdlmdfR4
         ZC6VYMSGHFVjCEadUgXtTFRuNsIBBKJWUrK4mbe2ACTwgwXJ3DJAs2nCng8a/3naACb3
         FujSW+rCQX4cAxTIyCeKMzdwXkRn9//P6V/N0FSiqrq0hnJVESrQkANg2VjUm74mbyB3
         3UJw==
X-Gm-Message-State: AOAM531ay8YPHIQ56gWAbRfFSE+y7SNwnohTNENJxsKGj/El18rspmSN
        9wly4A1ZiFFk2F6HPjs9nSXI2bwiPDEX3S06Vcuggg==
X-Google-Smtp-Source: ABdhPJwL5k8zeWDPprG5Mrub7BhXpdPNFjl1twNR0wyPykMPOKHhl8JhWG8zU9BNykiHZwGZd8sG1UHbIbv8RO4puvk=
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr11898964ejb.493.1599783653707;
 Thu, 10 Sep 2020 17:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-7-keescook@chromium.org> <202009101649.2A0BF95@keescook>
In-Reply-To: <202009101649.2A0BF95@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Sep 2020 02:20:27 +0200
Message-ID: <CAG48ez2=8y7jC9vWSPyYNhwASxGrQaewSBczbr02Ri2YnBJwVA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] security/fbfam: Mitigate a fork brute force attack
To:     Kees Cook <keescook@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 1:56 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 10, 2020 at 01:21:07PM -0700, Kees Cook wrote:
> > From: John Wood <john.wood@gmx.com>
> >
> > In order to mitigate a fork brute force attack it is necessary to kill
> > all the offending tasks. This tasks are all the ones that share the
> > statistical data with the current task (the task that has crashed).
> >
> > Since the attack detection is done in the function fbfam_handle_attack()
> > that is called every time a core dump is triggered, only is needed to
> > kill the others tasks that share the same statistical data, not the
> > current one as this is in the path to be killed.
[...]
> > +     for_each_process(p) {
> > +             if (p == current || p->fbfam_stats != stats)
> > +                     continue;
> > +
> > +             do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
> > +             pr_warn("fbfam: Offending process with PID %d killed\n",
> > +                     p->pid);
[...]
> > +
> > +             killed += 1;
> > +             if (killed >= to_kill)
> > +                     break;
> > +     }
> > +
> > +     rcu_read_unlock();
>
> Can't newly created processes escape this RCU read lock? I think this
> need alternate locking, or something in the task_alloc hook that will
> block any new process from being created within the stats group.

Good point; the proper way to deal with this would probably be to take
the tasklist_lock in read mode around this loop (with
read_lock(&tasklist_lock) / read_unlock(&tasklist_lock)), which pairs
with the write_lock_irq(&tasklist_lock) in copy_process(). Thanks to
the fatal_signal_pending() check while holding the lock in
copy_process(), that would be race-free - any fork() that has not yet
inserted the new task into the global task list would wait for us to
drop the tasklist_lock, then bail out at the fatal_signal_pending()
check.
