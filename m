Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261842EB6A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 01:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhAFABx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 19:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbhAFABw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:01:52 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535BC061796
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jan 2021 16:01:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id q22so2896313eja.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jan 2021 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfAl9KpSkJTd6+U94OCEriXL161o3FlE2sDMdIxmbKg=;
        b=Nm/doGyRQLbdfDauhHJdBMWjqc8dfsV0Ro8t+lUY4IOId9KByo/HmTzrWnYe+azun7
         4znDTF6xd9f2RL72SvmRnRraFzK+o0ExupZGqeZ9FpLuwM9ojh68bhAvIl2Is6ZT6Ls7
         EwZgjtShg6ffB9qGAHMidgzE8KqBcdWmVaItT8V1RRd4nvVSoRwsWVMI4SxwXmAvkmw7
         6u3VoeUyEdQUB+iGPEYBoXQj/3t7J+5Hyk5gRbKG41FjIx5VK9MW3HTaT8myas7Vb8Ez
         Kvy6Jm/WVyeAELN8jKn8Iv9PqyJ/aBgB61WW/PQdS6HroeC4AQLzPGJ0jnndtWQ2D3ws
         Lxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfAl9KpSkJTd6+U94OCEriXL161o3FlE2sDMdIxmbKg=;
        b=L3JYunoQGx2Qch0H6GgGto0erJo5uqbpGoMkvJfHJjQkvi5h8ZntX++Utf9mkzPkra
         vQQssXemaoxfTnLEzwLXH1lJ291yuFBAXuUv9I2IrUpSOqC2a/yEms3mGTlFkn7WbiuC
         beZGyeczVoNHaBkX0lbC7LZicwrHTWO5p0my0xgbpboW5jEmN3b439lEPlbJf+jQ0OvA
         OerDNkLlwaG3kKKhAx8iiqYM1aFbmr1wNdmGqbVLJUaiRtiVgrWazujvmy69VF1eOAvU
         zUaTjgL975HAbH009RDppNWjUlBvkg8PB6R744zlPu3Ej0NnG3smAIR0TuFp0CL5C0Rd
         MAYg==
X-Gm-Message-State: AOAM530WOa7oIkEcZK/n5ZpPlqWH+zIxIRJUrj+SyVTkw1r41rziDcEa
        Lgahm2/eCAXSCBcQVkjONwTCxX+uTiuon0F4NtYW
X-Google-Smtp-Source: ABdhPJy2NH+qJf3iqobhjGlTY0DvacTF962UFEkfYVCmTW7lYKZyjdrP0z6+z04lqkN/DK52natckhmozbFQ2B7nwAY=
X-Received: by 2002:a17:907:4126:: with SMTP id mx6mr1206433ejb.91.1609891270677;
 Tue, 05 Jan 2021 16:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk> <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk> <87a6tnge5k.fsf@stepbren-lnx.us.oracle.com>
In-Reply-To: <87a6tnge5k.fsf@stepbren-lnx.us.oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Jan 2021 19:00:59 -0500
Message-ID: <CAHC9VhQnQW8RvTzyb4MTAvGZ7b=AHJXS8PzD=egTcpdDz73Yzg@mail.gmail.com>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 5, 2021 at 6:27 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
>
> > On Tue, Jan 05, 2021 at 04:50:05PM +0000, Al Viro wrote:
> >
> >> LSM_AUDIT_DATA_DENTRY is easy to handle - wrap
> >>                 audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
> >> into grabbing/dropping a->u.dentry->d_lock and we are done.
> >
> > Incidentally, LSM_AUDIT_DATA_DENTRY in mainline is *not* safe wrt
> > rename() - for long-named dentries it is possible to get preempted
> > in the middle of
> >                 audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
> > and have the bugger renamed, with old name ending up freed.  The
> > same goes for LSM_AUDIT_DATA_INODE...
>
> In the case of proc_pid_permission(), this preemption doesn't seem
> possible. We have task_lock() (a spinlock) held by ptrace_may_access()
> during this call, so preemption should be disabled:
>
> proc_pid_permission()
>   has_pid_permissions()
>     ptrace_may_access()
>       task_lock()
>       __ptrace_may_access()
>       | security_ptrace_access_check()
>       |   ptrace_access_check -> selinux_ptrace_access_check()
>       |     avc_has_perm()
>       |       avc_audit() // note that has_pid_permissions() didn't get a
>       |                   // flags field to propagate, so flags will not
>       |                   // contain MAY_NOT_BLOCK
>       |         slow_avc_audit()
>       |           common_lsm_audit()
>       |             dump_common_audit_data()
>       task_unlock()
>
> I understand the issue of d_name.name being freed across a preemption is
> more general than proc_pid_permission() (as other callers may have
> preemption enabled). However, it seems like there's another issue here.
> avc_audit() seems to imply that slow_avc_audit() would sleep:
>
> static inline int avc_audit(struct selinux_state *state,
>                             u32 ssid, u32 tsid,
>                             u16 tclass, u32 requested,
>                             struct av_decision *avd,
>                             int result,
>                             struct common_audit_data *a,
>                             int flags)
> {
>         u32 audited, denied;
>         audited = avc_audit_required(requested, avd, result, 0, &denied);
>         if (likely(!audited))
>                 return 0;
>         /* fall back to ref-walk if we have to generate audit */
>         if (flags & MAY_NOT_BLOCK)
>                 return -ECHILD;
>         return slow_avc_audit(state, ssid, tsid, tclass,
>                               requested, audited, denied, result,
>                               a);
> }
>
> If there are other cases in here where we might sleep, it would be a
> problem to sleep with the task lock held, correct?

I would expect the problem here to be the currently allocated audit
buffer isn't large enough to hold the full audit record, in which case
it will attempt to expand the buffer by a call to pskb_expand_head() -
don't ask why audit buffers are skbs, it's awful - using a gfp flag
that was established when the buffer was first created.  In this
particular case it is GFP_ATOMIC|__GFP_NOWARN, which I believe should
be safe in that it will not sleep on an allocation miss.

I need to go deal with dinner, so I can't trace the entire path at the
moment, but I believe the potential audit buffer allocation is the
main issue.

-- 
paul moore
www.paul-moore.com
