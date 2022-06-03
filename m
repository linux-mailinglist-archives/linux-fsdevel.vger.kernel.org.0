Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55EF53C51F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 08:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiFCGki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 02:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiFCGkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:40:37 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C5F38787
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jun 2022 23:40:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-30c1c9b9b6cso72825747b3.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jun 2022 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfTNEksliZ3y2poNDmDeIKONIqonojXSfIHkatdp5wA=;
        b=IzFzYEXuWY1GJiMU/NqMxDg9AH710M3ZuBEesd8VJGccuOl+bIht9xKv4Th4TqHSpc
         eWOJoiIdi/j5QAenz9PGqOifjhIfuICyi5m0hn2YYejz+TsDGSf1fFa/kyrlthrWONxq
         jDaHVXtfUkkYOwNB9qw/7Rj8QZRTrUcEUl76XejrlXfx62lG/x4lFnPHIbTdhD8MaOnG
         a9yjumLGdKWxqTkIDdkNQJdJh2OjQpuwB21L+GDVsKgYDzMDw3uTwM4xyMUQctyezlMj
         Du0QDBbyTJuhyjY3sunXEH9KxEdVVoTSV7oCOu77Q6Li9ncnngBEFE/e77ZujC/S7uxo
         ES6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfTNEksliZ3y2poNDmDeIKONIqonojXSfIHkatdp5wA=;
        b=QLmISHNNscpotUxWrbX0SG52GU7f+hHVbCV3TtkNbVHNuCsa6V0OW/BQ2rchFdDlb9
         fwaf9X5I7LEf2enYHYTSzJqRaHdtOxbonCzdhpXZ8w66FJmYCfCNO9+ygwGF+ouuKnv4
         pL0asAzsL2euO392LNw6NGKDDPeaFWGEMUTofW/jvspRR7OQmuR63HaqaMqqWyRmA/8v
         wYW0ZZyMqM31lHtIi8ZK1VDPUOuadteC7v/EhKX+WdYaDVbhk9EiPJSYFSyppf9aQB69
         936eJ5BbEJ8cnTqW5Uhj029ABgtmTX/SzCngc/kYBAef/ZX3HJiVoA9HbWIJeNl9nvLX
         DPZQ==
X-Gm-Message-State: AOAM533oW1/JhA4uWFgXilDNXbqen4j2AfnjxkZy5klLeMj3OppdVsR9
        CqMr2mKqI6Nz400Ip/GEzpkJXf71smToA78bFD2Zew==
X-Google-Smtp-Source: ABdhPJzbniNopbD7WI9L6d2fjFTtiuHbwNIZGmDW2ibkKHKW8tsgdRqstdZMqPsBAzAoBIJQEpbXcX2nDDJS7S6LUy8=
X-Received: by 2002:a81:4c8e:0:b0:300:37ba:2c1e with SMTP id
 z136-20020a814c8e000000b0030037ba2c1emr10333837ywa.141.1654238434452; Thu, 02
 Jun 2022 23:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220525065050.38905-1-songmuchun@bytedance.com>
In-Reply-To: <20220525065050.38905-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 3 Jun 2022 14:39:58 +0800
Message-ID: <CAMZfGtU_Sp28CO2ZfvO_ta2_f5V5hVax3q86TqqHbOskCJPp7Q@mail.gmail.com>
Subject: Re: [PATCH v3] sysctl: handle table->maxlen robustly for proc_dobool
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Ping guys. Any comments or objections?

On Wed, May 25, 2022 at 2:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> to sizeof(int) is counter-intuitive, it is easy to make mistakes in the
> future (When I first use proc_dobool() in my driver, I assign
> sizeof(variable) to table->maxlen.  Then I found it was wrong, it should
> be sizeof(int) which was very counter-intuitive).  For robustness,
> rework proc_dobool() robustly.  So it is an improvement not a real bug
> fix.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> ---
> v3:
>  - Update commit log.
>
> v2:
>  - Reimplementing proc_dobool().
>
>  fs/lockd/svc.c  |  2 +-
>  kernel/sysctl.c | 38 +++++++++++++++++++-------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 59ef8a1f843f..6e48ee787f49 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -496,7 +496,7 @@ static struct ctl_table nlm_sysctls[] = {
>         {
>                 .procname       = "nsm_use_hostnames",
>                 .data           = &nsm_use_hostnames,
> -               .maxlen         = sizeof(int),
> +               .maxlen         = sizeof(nsm_use_hostnames),
>                 .mode           = 0644,
>                 .proc_handler   = proc_dobool,
>         },
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e52b6e372c60..50a2c29efc94 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -423,21 +423,6 @@ static void proc_put_char(void **buf, size_t *size, char c)
>         }
>  }
>
> -static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
> -                               int *valp,
> -                               int write, void *data)
> -{
> -       if (write) {
> -               *(bool *)valp = *lvalp;
> -       } else {
> -               int val = *(bool *)valp;
> -
> -               *lvalp = (unsigned long)val;
> -               *negp = false;
> -       }
> -       return 0;
> -}
> -
>  static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
>                                  int *valp,
>                                  int write, void *data)
> @@ -708,16 +693,31 @@ int do_proc_douintvec(struct ctl_table *table, int write,
>   * @lenp: the size of the user buffer
>   * @ppos: file position
>   *
> - * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> - * values from/to the user buffer, treated as an ASCII string.
> + * Reads/writes up to table->maxlen/sizeof(bool) bool values from/to
> + * the user buffer, treated as an ASCII string.
>   *
>   * Returns 0 on success.
>   */
>  int proc_dobool(struct ctl_table *table, int write, void *buffer,
>                 size_t *lenp, loff_t *ppos)
>  {
> -       return do_proc_dointvec(table, write, buffer, lenp, ppos,
> -                               do_proc_dobool_conv, NULL);
> +       struct ctl_table tmp = *table;
> +       bool *data = table->data;
> +       unsigned int val = READ_ONCE(*data);
> +       int ret;
> +
> +       /* Do not support arrays yet. */
> +       if (table->maxlen != sizeof(bool))
> +               return -EINVAL;
> +
> +       tmp.maxlen = sizeof(val);
> +       tmp.data = &val;
> +       ret = do_proc_douintvec(&tmp, write, buffer, lenp, ppos, NULL, NULL);
> +       if (ret)
> +               return ret;
> +       if (write)
> +               WRITE_ONCE(*data, val ? true : false);
> +       return 0;
>  }
>
>  /**
> --
> 2.11.0
>
