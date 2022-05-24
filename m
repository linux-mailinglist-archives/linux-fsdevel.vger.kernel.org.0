Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF546532114
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 04:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiEXCl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 22:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiEXCl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 22:41:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1541F61B
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 19:41:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i11so28615772ybq.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 19:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZK/LIj/HmIKuwXlrjzuY0xVYI4ZQoH/y1QWOLzPiDs=;
        b=fDGfFSmM6IwKD9Bwy3Vbjs5q0zo++Yssf/Twwxbsj6rtaD4lf9KPR4hRKzRGxJu0Z/
         GMTlLKofZv7ym+eDgCLHzWEx2+jjJn90uiGOvR6N6R8hHAVXOGXh+zQHUQ8zczlZvxzE
         Jm253Or7yrL5QuDlq4Z+X9b6RVaUwb1Fwi8WJPgQN9WmlwPEBI7d2NwdPRDtevU2waT4
         cAP2AmgytQPM3j1J7VMxImjt4eklby19Y935kh5mrCDQOQ6wjGaP4lVHBAz+HIiqHmNj
         4EX8W8rDQYo84FDGKlHRYh6P1mDySLZ5nutESL0v6ngM1G86xpJYGxIJo4WBDcl1RiVv
         jggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZK/LIj/HmIKuwXlrjzuY0xVYI4ZQoH/y1QWOLzPiDs=;
        b=F2RWYUN0Z33P9OhjRCfyYYWWc1etvY6KAER8EJl8A5uVA+fGofzVil1kPaXOfg5+J8
         zipslseZpqUKeXhKBxXZy7v6ZtsMJ/uTHvB4S03HoSCRY61NpuPOoLxnKlZQ5KZmADfU
         9hLApuVLdL7szOpRzVVhCnugE3BqjmOWnQ7l/q9iSddayduHss5Odr/lKlW1K9cQzDP8
         3CPr94xMH5CLHjeEekHbfpLzfmqjGnPZmN2EXB/4txUu9jLIbwNntY+/MJfjFOxIz3pA
         JUlgb51QstGZunTW2iTyZot1nUzVucJAzhIf+aFgCde7+SV/1vxpE0oO3/Jz6OB/mX6m
         qb+w==
X-Gm-Message-State: AOAM5322V0XHZ5DeCTOKL5V9Nw1H8iZHbAm223E4NSijnfvqtFSIfx+D
        gfebv6waCtmHCaUEEfTiOcDxa7q0etktsaZ0kImP+A==
X-Google-Smtp-Source: ABdhPJyQiAgqee0mEcshKFUmX0Jszav+XGkGtIOWt3IFQhjkCvtAp6nxMN17Po35qVDTGKQ+LlLz81HpxbaQwQ+SUcQ=
X-Received: by 2002:a25:3452:0:b0:64e:1776:ce90 with SMTP id
 b79-20020a253452000000b0064e1776ce90mr24814077yba.261.1653360116001; Mon, 23
 May 2022 19:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220522052624.21493-1-songmuchun@bytedance.com> <202205231233.EE3AB926@keescook>
In-Reply-To: <202205231233.EE3AB926@keescook>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 24 May 2022 10:41:20 +0800
Message-ID: <CAMZfGtWw6bnpDcdjgQnsW8MMPy0BmHTtHdnX4codMdqk1b5wJg@mail.gmail.com>
Subject: Re: [PATCH v2] sysctl: handle table->maxlen properly for proc_dobool
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
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

On Tue, May 24, 2022 at 3:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, May 22, 2022 at 01:26:24PM +0800, Muchun Song wrote:
> > Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> > to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
> > robustness, fix it by reimplementing proc_dobool() properly.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Iurii Zaikin <yzaikin@google.com>
> > ---
> > v2:
> >  - Reimplementing proc_dobool().
> >
> >  fs/lockd/svc.c  |  2 +-
> >  kernel/sysctl.c | 38 +++++++++++++++++++-------------------
> >  2 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index 59ef8a1f843f..6e48ee787f49 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -496,7 +496,7 @@ static struct ctl_table nlm_sysctls[] = {
> >       {
> >               .procname       = "nsm_use_hostnames",
> >               .data           = &nsm_use_hostnames,
> > -             .maxlen         = sizeof(int),
> > +             .maxlen         = sizeof(nsm_use_hostnames),
> >               .mode           = 0644,
> >               .proc_handler   = proc_dobool,
> >       },
>
> This hunk is fine -- it's a reasonable fix-up.
>
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index e52b6e372c60..50a2c29efc94 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -423,21 +423,6 @@ static void proc_put_char(void **buf, size_t *size, char c)
> >       }
> >  }
> >
> > -static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
> > -                             int *valp,
> > -                             int write, void *data)
> > -{
> > -     if (write) {
> > -             *(bool *)valp = *lvalp;
> > -     } else {
> > -             int val = *(bool *)valp;
> > -
> > -             *lvalp = (unsigned long)val;
> > -             *negp = false;
> > -     }
> > -     return 0;
> > -}
> > -
> >  static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
> >                                int *valp,
> >                                int write, void *data)
> > @@ -708,16 +693,31 @@ int do_proc_douintvec(struct ctl_table *table, int write,
> >   * @lenp: the size of the user buffer
> >   * @ppos: file position
> >   *
> > - * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> > - * values from/to the user buffer, treated as an ASCII string.
> > + * Reads/writes up to table->maxlen/sizeof(bool) bool values from/to
> > + * the user buffer, treated as an ASCII string.
> >   *
> >   * Returns 0 on success.
> >   */
> >  int proc_dobool(struct ctl_table *table, int write, void *buffer,
> >               size_t *lenp, loff_t *ppos)
> >  {
> > -     return do_proc_dointvec(table, write, buffer, lenp, ppos,
> > -                             do_proc_dobool_conv, NULL);
> > +     struct ctl_table tmp = *table;
> > +     bool *data = table->data;
> > +     unsigned int val = READ_ONCE(*data);
> > +     int ret;
> > +
> > +     /* Do not support arrays yet. */
> > +     if (table->maxlen != sizeof(bool))
> > +             return -EINVAL;
> > +
> > +     tmp.maxlen = sizeof(val);
> > +     tmp.data = &val;
> > +     ret = do_proc_douintvec(&tmp, write, buffer, lenp, ppos, NULL, NULL);
> > +     if (ret)
> > +             return ret;
> > +     if (write)
> > +             WRITE_ONCE(*data, val ? true : false);
> > +     return 0;
> >  }
>
> This part I don't understand -- it just inlines do_proc_dobool_conv(),
> and I think detracts from readability.
>

I think do_proc_dobool_conv() is an abuse of do_proc_dointvec()
since do_proc_dointvec() expects a "int" type data instead of a "bool".
As you can see, there is some cast from bool to int or int to bool
in do_proc_dobool_conv().  And do_proc_dobool_conv() supports
arrays, while proc_dobool() does not support. It is a little ugly to
fix this in __do_proc_dointvec() (I have fixed it in v1 [1]).

This version refers to proc_dou8vec_minmax(). For me, I think it
is cleaner than v1, any thoughts?

[1] https://lore.kernel.org/all/20220519125505.92400-1-songmuchun@bytedance.com/
