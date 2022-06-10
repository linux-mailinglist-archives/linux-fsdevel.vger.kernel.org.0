Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD328545AA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 05:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiFJDjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 23:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiFJDjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:39:07 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B404443DA
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 20:39:05 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r82so44922134ybc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 20:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKw0uO7QI+SLEJQrKmhl0Q0W4zGjPXzOlDM5V0CLD9w=;
        b=MQAOYziTqRJOpn8uP86L+Yhq28lQ0zRe//K3A14IUSrCThzwYu2sqN1VBLMaKM+XEc
         Ba1WHdOnkBTKqApuwjQRLQx+W+XZjOWevZKW3UaJJUA/RdSAFZzhobKd3Gc6pV8+NQEl
         JGK1NmcX1dUeTEMBmQuMT6fHsoci2IFvf+r4eJOaOWTVx9o/IUijmIwvNAWrLprC2Xwv
         pet0ezznIhBscy9pPRK/1CMS2GowU+0wdGKhfyi2zUtz+LtA1Ozhu0pHHF0kW4Sz/lPQ
         320qAJex2LRq9jDFnBEndWMZiz7AVXIbf5E+PIAZrN0e2LefJqQPITybU5mU0NUmjomc
         iVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKw0uO7QI+SLEJQrKmhl0Q0W4zGjPXzOlDM5V0CLD9w=;
        b=XG8tsl4uuj00bMHPmYmnbnqUNcySX0Ciw2Ni0UBdhm05FAcWoZjVQftwOx/eZNeA3O
         rjx2Fs6RiL/fmsOiIrkOnEiqPtVHd2Hwu4z2fhMSo5bxlsVEmFyh/ybQlYaNi+KKbwrF
         kpyZdo0b+zUOttorrzbHo5Q97VMPNL886T4bbRQPJZtbQ0Cd0SyGRO7aBPq6WJATZ9ZE
         LGURvhivegimPgKlrKFdbPKOS+Ih3D1QR+VMv8Mm9vl4u/o2n2KEUCNulayZ50i7vLCK
         9KAmEQZTW5vWeo5m5NQE1WnQm7li+3uXm8RcpRA1T+j9W4ZVTLAI0hPu+Acj2fbhRRzm
         Kz9w==
X-Gm-Message-State: AOAM531tlH2kp5ar+sFqenOdIBbRxWFoRftVf6saswGUkbIsiCNv6iiB
        HDl9MmjCCXWyrOD/wAMNSAzyusO8aqRaO2mUAl0Zgw==
X-Google-Smtp-Source: ABdhPJxU9pRWVsp8kAR6FO1/7scAqsG0euxgoxRZ2fTcght7vZ9UsBX5XwK4nS+12q5jrzcq1GMY3/ui79yj/GX/ZxU=
X-Received: by 2002:a05:6902:c9:b0:641:1998:9764 with SMTP id
 i9-20020a05690200c900b0064119989764mr42150800ybs.427.1654832344369; Thu, 09
 Jun 2022 20:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220525065050.38905-1-songmuchun@bytedance.com> <YqIU3U+l1EDy7OgZ@bombadil.infradead.org>
In-Reply-To: <YqIU3U+l1EDy7OgZ@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 10 Jun 2022 11:38:28 +0800
Message-ID: <CAMZfGtXj29Q-VeYRmU5VnW51tSyqCKbXsHCa9bi2z5WifEK_9w@mail.gmail.com>
Subject: Re: [PATCH v3] sysctl: handle table->maxlen robustly for proc_dobool
To:     Luis Chamberlain <mcgrof@kernel.org>, hejianet@gmail.com
Cc:     Kees Cook <keescook@chromium.org>,
        Pan Xinhui <xinhui@linux.vnet.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 9, 2022 at 11:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Please Cc the original authors of code if sending some follow up
> possible enhancements.

Will do. +Jia He

>
> On Wed, May 25, 2022 at 02:50:50PM +0800, Muchun Song wrote:
> > Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> > to sizeof(int) is counter-intuitive, it is easy to make mistakes in the
> > future (When I first use proc_dobool() in my driver, I assign
> > sizeof(variable) to table->maxlen.  Then I found it was wrong, it should
> > be sizeof(int) which was very counter-intuitive).
>
> How did you find this out? If I change fs/lockd/svc.c's use I get
> compile warnings on at least x86_64.

I am writing a code like:

static bool optimize_vmemmap_enabled;

static struct ctl_table hugetlb_vmemmap_sysctls[] = {
        {
                .procname = "hugetlb_optimize_vmemmap",
                .data = &optimize_vmemmap_enabled,
                .maxlen = sizeof(optimize_vmemmap_enabled),
                .mode = 0644,
                .proc_handler = proc_dobool,
        },
        { }
};

At least I don't see any warnings from compiler. And I found
the assignment of ".data" should be "sizeof(int)", otherwise,
it does not work properly. It is a little weird to me.

>
> > For robustness,
> > rework proc_dobool() robustly.
>
> You mention robustness twice. Just say something like:
>
> To help make things clear, make the logic used by proc_dobool() very
> clear with regards to its requirement with working with bools.

Clearer! Thanks.

>
> > So it is an improvement not a real bug
> > fix.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Iurii Zaikin <yzaikin@google.com>
> > ---
> > v3:
> >  - Update commit log.
> >
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
> Should this be a separate patch? What about the rest of the kernel?

I afraid not. Since this change of proc_dobool will break the
"nsm_use_hostnames". It should be changed to
sizeof(nsm_use_hostnames) at the same time.

> I see it is only used once so the one commit should mention that also.

Well, will do.

>
> Or did chaning this as you have it now alter the way the kernel
> treats this sysctl? All these things would be useful to clarify
> in the commit log.

Make sense. I'll mention those things into commit log.

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
>
> Previously do_proc_douintvec() is called, and that checks if table->data
> is NULL previously before reading it and if so bails on
> __do_proc_dointvec() as follows:
>
>         if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write)) {
>                 *lenp = 0;
>                 return 0;
>         }
>
> Is it possible to have table->data be NULL? I think that's where the
> above check comes from.

At least now it cannot be NULL (no users do this now).

>
> And, so if it was false but not NULL, would it never do anything?

I think we can add the check of NULL in the future if it could be
happened, just like proc_dou8vec_minmax and proc_do_static_key
do (they do not check ->data as well).

>
> You can use lib/test_sysctl.c for this to proove / disprove correct
> functionality.

I didn't see the test for proc_bool in lib/test_sysctl.c. I think we can
add a separate patch later to add a test for proc_bool.

>
> > +     unsigned int val = READ_ONCE(*data);
> > +     int ret;
> > +
> > +     /* Do not support arrays yet. */
> > +     if (table->maxlen != sizeof(bool))
> > +             return -EINVAL;
>
> This is a separate change, and while I agree with it, as it simplifies
> our implementation and we don't want to add more array crap support,
> this should *alone* should be a separate commit.

If you agree reusing do_proc_douintvec to implement proc_dobool(),
I think a separate commit may be not suitable since do_proc_douintvec()
only support non-array. Mentioning this in commit log makes sense to me.

>
> > +
> > +     tmp.maxlen = sizeof(val);
>
> Why even set this as you do when we know it must be sizeof(bool)?
> Or would this break things given do_proc_douintvec() is used?

Since we reuse do_proc_douintvec(), which requires a uint type, to
get/set the value from/to the users. I think you can refer to the implementation
of proc_dou8vec_minmax().

>
> > +     tmp.data = &val;
> > +     ret = do_proc_douintvec(&tmp, write, buffer, lenp, ppos, NULL, NULL);
>
> Ugh, since we are avoiding arrays and we are only dealing with bools
> I'm inclined to just ask we simpify this a bool implementation which
> does something like do_proc_do_bool() but without array and is optimized
> just for bools.

The current implementation of __do_proc_douintvec() is already only deal
with non-array. Maybe it is better to reuse __do_proc_douintvec()? Otherwise,
we need to implement a similar functionality (do_proc_do_bool) like it but just
process bool type. I suspect the changes will be not small. I am wondering is it
value to do this? If yes, should we also rework proc_dou8vec_minmax() as well?

Thanks.

>
> The current hoops to read this code is simplly irritating
>
>   Luis
>
> > +     if (ret)
> > +             return ret;
> > +     if (write)
> > +             WRITE_ONCE(*data, val ? true : false);
> > +     return 0;
> >  }
> >
> >  /**
> > --
> > 2.11.0
> >
