Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42672214D5D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgGEPK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGEPKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:10:25 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5AC08C5DF
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2020 08:10:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so25703570edz.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2020 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3JwZGbweZ3BK0fV1w8xzrYzjR5xwU4JCV9NoTN0jpw=;
        b=GcrA9u3XQk81/TniBplyKkAjm8wSs/ff0vsRZHh3DKuIveCLBPMVL+Z6ZCiFjXfWmg
         ddC3N7tQKou47DFA+sR9hhxez1FzrW4QjGL8pWnP4Hvy+APGQanoS7HNLs/qLJehhjQM
         iIerje15vJyGXFq2OPWtEuh0BVoTAZCgk9hYuKR0p/4MT17M3rcXUcQO+MfSHzWitlvx
         ZqQ2KaIKWZv5cyy2J1mGOjqiRQHJWgqLJqqPaJW1LwXsQsJG6jtgajhkSjK63ABx+w9A
         bO2lgiHvh6hbKlwxyXaX6L6ABKbvuYQn4K8tICxWDO4ylY7rhP27I50FAfrCxhe0aN0i
         epwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3JwZGbweZ3BK0fV1w8xzrYzjR5xwU4JCV9NoTN0jpw=;
        b=c+y9hxbN0WK2BDYFuQL/spgsVc9XfvCpx8wFB9yttZPzOHRnSQ40Tl4tme/wVylBRI
         iGNP0IxAoAcwfvq7u14TFGyepOOlLlZkMbiMekvtfJbyXBIFcgNY3pUgk4a9qKRnxMiM
         4klSGuGxG9q664VNnHdQqvppDppd/89UTN+9/wxcJbpuzADfejCovr73+4jbiCRfM4NJ
         h2a9OuTRXONtVk2HglwbZpG8k80VHr7ViWQz5apg7HTpBsnfvhj0E3gUwd0k1cn/n4/D
         fachEV28jdM0Xj6guzp6Rwdc89PxXaTB/SajFuThmB5TF+AOonQF1CNi+tgZVdwlsK/N
         7PbQ==
X-Gm-Message-State: AOAM532Oll3pDbTW/rP9pq5/dvoVMC8IZES0Yg8vAymG908h0a7rq/Oq
        jD9CZZAFQ5VnfL2gxkNI7jH5O5ZNwcm4v+DnuYrO
X-Google-Smtp-Source: ABdhPJxmCW6mI05l3xIDHLx8qBO/0qPoQYIx6tUcpj0AgBk4IDP/Xb+w50SWr/wKbjgl+/Q/V05f4AkowPSQxVt5Db8=
X-Received: by 2002:a05:6402:1d89:: with SMTP id dk9mr39302382edb.31.1593961823707;
 Sun, 05 Jul 2020 08:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <e9310d6d9d909f4ac7ef1b688fbb0263711f9a24.1593198710.git.rgb@redhat.com>
In-Reply-To: <e9310d6d9d909f4ac7ef1b688fbb0263711f9a24.1593198710.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Jul 2020 11:10:12 -0400
Message-ID: <CAHC9VhQsg8zCMCEwKFFchebTPSHZOC+oYoUAEKeAFm248OXsOQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 04/13] audit: log drop of contid on exit of last task
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 27, 2020 at 9:22 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Since we are tracking the life of each audit container indentifier, we
> can match the creation event with the destruction event.  Log the
> destruction of the audit container identifier when the last process in
> that container exits.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c   | 20 ++++++++++++++++++++
>  kernel/audit.h   |  2 ++
>  kernel/auditsc.c |  2 ++
>  3 files changed, 24 insertions(+)

If you end up respinning this patchset it seems like this should be
merged in with patch 2/13.  This way patch 2/13 would include both the
"set" and "drop" records, making that patch a bit more useful on it's
own.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 6d387793f702..9e0b38ce1ead 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2558,6 +2558,26 @@ int audit_set_contid(struct task_struct *task, u64 contid)
>         return rc;
>  }
>
> +void audit_log_container_drop(void)
> +{
> +       struct audit_buffer *ab;
> +       struct audit_contobj *cont;
> +
> +       rcu_read_lock();
> +       cont = _audit_contobj_get(current);
> +       _audit_contobj_put(cont);
> +       if (!cont || refcount_read(&cont->refcount) > 1)
> +               goto out;
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONTAINER_OP);

You may want to check on sleeping with RCU locks held, or just use
GFP_ATOMIC to be safe.


> +       if (!ab)
> +               goto out;
> +       audit_log_format(ab, "op=drop opid=%d contid=%llu old-contid=%llu",
> +                        task_tgid_nr(current), cont->id, cont->id);
> +       audit_log_end(ab);
> +out:
> +       rcu_read_unlock();
> +}
> +
>  /**
>   * audit_log_end - end one audit record
>   * @ab: the audit_buffer
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 182fc76ea276..d07093903008 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -254,6 +254,8 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  extern struct tty_struct *audit_get_tty(void);
>  extern void audit_put_tty(struct tty_struct *tty);
>
> +extern void audit_log_container_drop(void);
> +
>  /* audit watch/mark/tree functions */
>  #ifdef CONFIG_AUDITSYSCALL
>  extern unsigned int audit_serial(void);
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index f00c1da587ea..f03d3eb0752c 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1575,6 +1575,8 @@ static void audit_log_exit(void)
>
>         audit_log_proctitle();
>
> +       audit_log_container_drop();
> +
>         /* Send end of event record to help user space know we are finished */
>         ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
>         if (ab)

--
paul moore
www.paul-moore.com
