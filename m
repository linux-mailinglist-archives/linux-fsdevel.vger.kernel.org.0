Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD26A8CBD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCBXOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBXOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:14:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6656526
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 15:14:33 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l1so746861pjt.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 15:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677798873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dK5xBsNL80qIVhQ78+b+C534EV7ZA+MEtH4IecrU8fs=;
        b=dQa60YkNB2aHmO2eQcUKKkWMpQNb0V1GmMgzCtjajumKPoUa34DT1KW4VyAmnDllnW
         tBCca31eWsY8i/Th0ibNmqeeF5yKTzOum5xPC8aoXRqxuyQgj9C/JlnCifC4KCtAwKb8
         v4pqyQ4ZiU+89CoZ5Y65rTyJozDPpo4HdJgXVwtmjxF22wLTfQyCouIvPQxV5uYQuCrw
         P/jszesABAwdcZOuQmfKH1fSIxYPeLX27XyemZD3D40bp1QyeRTI9GkjDnwy80Yz6mZP
         Y/v9wqkSOnnwI/cKXAGsP8HdbUugB3KtD44ZKRukUPs4uhA9J+HxV/G+qQp6JCvY/BCl
         suAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677798873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dK5xBsNL80qIVhQ78+b+C534EV7ZA+MEtH4IecrU8fs=;
        b=yYfoZdnTaB8VWumnrxEu6oqvaGTiBY+aEWM3v3HvbpjfRFXNa+SyIGSrQu7SVV9yyn
         woctVYQBFCcl1QRHWXVbJw1xF4T5p3rdprsFmtC28rndbZroK2pp4vzp/L/gRFmM9fwR
         8Gc6oK0qR4VVPYFbe3IFKeDl7Mv2P+t8+Gzux2hW/EQ4TzFa/tdMe1yF7ntAhXBKwxDv
         Mi90mzBOLlO3cnQoo4RGBSU/h44kDTJAGecN3kNlj8I1NGkc9eNmG4SWostXGP0ou24f
         ze1kRo1ZmqHWnj+uoANUG0HTEeTR8md4b0/mDmr50acXwqyVW1wHXKzzOYTYSoO0SuPm
         IW2Q==
X-Gm-Message-State: AO0yUKXtVBsVjdi9/gH1yu6EcxqYDsLXMfHCrwatgjajeXQIcRje9HS6
        gLbdUJLBi48YtXwWdfAXSMWUu1tndKZ0GW6P5fEUxQ==
X-Google-Smtp-Source: AK7set/wy4RYTpF9DE9+esAO3swTwx9AMlMSD7Y2MF1LhQ+HmQO3b//lY81QPmALZdw979D/M11S681c0YXmtKI/bVE=
X-Received: by 2002:a17:903:2591:b0:19a:8bc7:d814 with SMTP id
 jb17-20020a170903259100b0019a8bc7d814mr4441125plb.13.1677798872570; Thu, 02
 Mar 2023 15:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20230302202826.776286-1-mcgrof@kernel.org> <20230302202826.776286-9-mcgrof@kernel.org>
In-Reply-To: <20230302202826.776286-9-mcgrof@kernel.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 2 Mar 2023 15:13:54 -0800
Message-ID: <CALmYWFucv6-9yfS=gamwSsqjgxSKZS0nvVjj_QfBmsLmQD5XOQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] kernel: pid_namespace: simplify sysctls with register_sysctl()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, ebiggers@kernel.org,
        tytso@mit.edu, guoren@kernel.org, j.granados@samsung.com,
        zhangpeng362@huawei.com, tangmeng@uniontech.com,
        willy@infradead.org, nixiaoming@huawei.com, sujiaxun@uniontech.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 2, 2023 at 12:28=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> register_sysctl_paths() is only required if your child (directories)
> have entries and pid_namespace does not. So use register_sysctl_init()
> instead where we don't care about the return value and use
> register_sysctl() where we do.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/pid_namespace.c | 3 +--
>  kernel/pid_sysctl.h    | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 46e0d5a3f91f..b43eee07b00c 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -314,7 +314,6 @@ static struct ctl_table pid_ns_ctl_table[] =3D {
>         },
>         { }
>  };
> -static struct ctl_path kern_path[] =3D { { .procname =3D "kernel", }, { =
} };
>  #endif /* CONFIG_CHECKPOINT_RESTORE */
>
>  int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
> @@ -473,7 +472,7 @@ static __init int pid_namespaces_init(void)
>         pid_ns_cachep =3D KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACC=
OUNT);
>
>  #ifdef CONFIG_CHECKPOINT_RESTORE
> -       register_sysctl_paths(kern_path, pid_ns_ctl_table);
> +       register_sysctl_init("kernel", pid_ns_ctl_table);
>  #endif
>
>         register_pid_ns_sysctl_table_vm();
> diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
> index e22d072e1e24..d67a4d45bb42 100644
> --- a/kernel/pid_sysctl.h
> +++ b/kernel/pid_sysctl.h
> @@ -46,10 +46,9 @@ static struct ctl_table pid_ns_ctl_table_vm[] =3D {
>         },
>         { }
>  };
> -static struct ctl_path vm_path[] =3D { { .procname =3D "vm", }, { } };
>  static inline void register_pid_ns_sysctl_table_vm(void)
>  {
> -       register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
> +       register_sysctl("vm", pid_ns_ctl_table_vm);
>  }
>  #else
>  static inline void initialize_memfd_noexec_scope(struct pid_namespace *n=
s) {}
> --
> 2.39.1
>
Acked-by: Jeff Xu <jeffxu@google.com>
