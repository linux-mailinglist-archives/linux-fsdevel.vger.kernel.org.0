Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6F56A938
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 19:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiGGRPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiGGRPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:15:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D95A46F;
        Thu,  7 Jul 2022 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bQvzG7GSULWCHMUDgIUkqtSeMjgbgkuAudufNvUWbQU=; b=mLDor1rOK+bf4kw7dXtv26VEGF
        bAWCnhZ/QjHAk4k/10SsnQhc1yvei36xhZW97OWJfglAWGzYgyPezRIdmyTElrj1XBbJirPvOBO2X
        WH6ILJ3tBhtNkW5AdvvWuEhXfLQF/qW7IM3RAg9Cq7FBdrj2exitlHll4AsDi8xd32iwR5XE54PZE
        7++7fk2PU3XwD6sWovgn95vp0ERjiOdmKhflkZgDuJzMbjgpS4CiG/u4VOD2kTqtoAxRKTnXkna2A
        6fz6Rf4wxYN4hVTomsmyBexSYLlueUvUBEopBXI9aNB7CLlCP0vjlym0v7KrB5iiyAPxNYjRL1rZJ
        wwhMLPTg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9V6D-00HB6V-5O; Thu, 07 Jul 2022 17:15:33 +0000
Date:   Thu, 7 Jul 2022 10:15:33 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hejianet@gmail.com, Kees Cook <keescook@chromium.org>,
        Pan Xinhui <xinhui@linux.vnet.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v3] sysctl: handle table->maxlen robustly for proc_dobool
Message-ID: <YscUtVytP/fWyrkP@bombadil.infradead.org>
References: <20220525065050.38905-1-songmuchun@bytedance.com>
 <YqIU3U+l1EDy7OgZ@bombadil.infradead.org>
 <CAMZfGtXj29Q-VeYRmU5VnW51tSyqCKbXsHCa9bi2z5WifEK_9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXj29Q-VeYRmU5VnW51tSyqCKbXsHCa9bi2z5WifEK_9w@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:38:28AM +0800, Muchun Song wrote:
> On Thu, Jun 9, 2022 at 11:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Please Cc the original authors of code if sending some follow up
> > possible enhancements.
> 
> Will do. +Jia He
> 
> >
> > On Wed, May 25, 2022 at 02:50:50PM +0800, Muchun Song wrote:
> > > Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> > > to sizeof(int) is counter-intuitive, it is easy to make mistakes in the
> > > future (When I first use proc_dobool() in my driver, I assign
> > > sizeof(variable) to table->maxlen.  Then I found it was wrong, it should
> > > be sizeof(int) which was very counter-intuitive).
> >
> > How did you find this out? If I change fs/lockd/svc.c's use I get
> > compile warnings on at least x86_64.
> 
> I am writing a code like:
> 
> static bool optimize_vmemmap_enabled;
> 
> static struct ctl_table hugetlb_vmemmap_sysctls[] = {
>         {
>                 .procname = "hugetlb_optimize_vmemmap",
>                 .data = &optimize_vmemmap_enabled,
>                 .maxlen = sizeof(optimize_vmemmap_enabled),
>                 .mode = 0644,
>                 .proc_handler = proc_dobool,
>         },
>         { }
> };
> 
> At least I don't see any warnings from compiler. And I found
> the assignment of ".data" should be "sizeof(int)", otherwise,
> it does not work properly. It is a little weird to me.

This is still odd to me but please clarify in your commit logs
how you found an issue. You don't need to specify the exact code
snippet, but just mentioning how you found it helps during
patch review.

> > > For robustness,
> > > rework proc_dobool() robustly.
> >
> > You mention robustness twice. Just say something like:
> >
> > To help make things clear, make the logic used by proc_dobool() very
> > clear with regards to its requirement with working with bools.
> 
> Clearer! Thanks.
> 
> >
> > > So it is an improvement not a real bug
> > > fix.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Iurii Zaikin <yzaikin@google.com>
> > > ---
> > > v3:
> > >  - Update commit log.
> > >
> > > v2:
> > >  - Reimplementing proc_dobool().
> > >
> > >  fs/lockd/svc.c  |  2 +-
> > >  kernel/sysctl.c | 38 +++++++++++++++++++-------------------
> > >  2 files changed, 20 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > > index 59ef8a1f843f..6e48ee787f49 100644
> > > --- a/fs/lockd/svc.c
> > > +++ b/fs/lockd/svc.c
> > > @@ -496,7 +496,7 @@ static struct ctl_table nlm_sysctls[] = {
> > >       {
> > >               .procname       = "nsm_use_hostnames",
> > >               .data           = &nsm_use_hostnames,
> > > -             .maxlen         = sizeof(int),
> > > +             .maxlen         = sizeof(nsm_use_hostnames),
> > >               .mode           = 0644,
> > >               .proc_handler   = proc_dobool,
> > >       },
> >
> > Should this be a separate patch? What about the rest of the kernel?
> 
> I afraid not. Since this change of proc_dobool will break the
> "nsm_use_hostnames". It should be changed to
> sizeof(nsm_use_hostnames) at the same time.

OK!

> > I see it is only used once so the one commit should mention that also.
> 
> Well, will do.

OK

> > Or did chaning this as you have it now alter the way the kernel
> > treats this sysctl? All these things would be useful to clarify
> > in the commit log.
> 
> Make sense. I'll mention those things into commit log.
> 
> >
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index e52b6e372c60..50a2c29efc94 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -423,21 +423,6 @@ static void proc_put_char(void **buf, size_t *size, char c)
> > >       }
> > >  }
> > >
> > > -static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
> > > -                             int *valp,
> > > -                             int write, void *data)
> > > -{
> > > -     if (write) {
> > > -             *(bool *)valp = *lvalp;
> > > -     } else {
> > > -             int val = *(bool *)valp;
> > > -
> > > -             *lvalp = (unsigned long)val;
> > > -             *negp = false;
> > > -     }
> > > -     return 0;
> > > -}
> > > -
> > >  static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
> > >                                int *valp,
> > >                                int write, void *data)
> > > @@ -708,16 +693,31 @@ int do_proc_douintvec(struct ctl_table *table, int write,
> > >   * @lenp: the size of the user buffer
> > >   * @ppos: file position
> > >   *
> > > - * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> > > - * values from/to the user buffer, treated as an ASCII string.
> > > + * Reads/writes up to table->maxlen/sizeof(bool) bool values from/to
> > > + * the user buffer, treated as an ASCII string.
> > >   *
> > >   * Returns 0 on success.
> > >   */
> > >  int proc_dobool(struct ctl_table *table, int write, void *buffer,
> > >               size_t *lenp, loff_t *ppos)
> > >  {
> > > -     return do_proc_dointvec(table, write, buffer, lenp, ppos,
> > > -                             do_proc_dobool_conv, NULL);
> > > +     struct ctl_table tmp = *table;
> > > +     bool *data = table->data;
> >
> > Previously do_proc_douintvec() is called, and that checks if table->data
> > is NULL previously before reading it and if so bails on
> > __do_proc_dointvec() as follows:
> >
> >         if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write)) {
> >                 *lenp = 0;
> >                 return 0;
> >         }
> >
> > Is it possible to have table->data be NULL? I think that's where the
> > above check comes from.
> 
> At least now it cannot be NULL (no users do this now).

It does not mean new users where it is NULL can't be introduced.

> > And, so if it was false but not NULL, would it never do anything?
> 
> I think we can add the check of NULL in the future if it could be
> happened, just like proc_dou8vec_minmax and proc_do_static_key
> do (they do not check ->data as well).

Preventing bad uses ahead of time is definitely prefered.

> > You can use lib/test_sysctl.c for this to proove / disprove correct
> > functionality.
> 
> I didn't see the test for proc_bool in lib/test_sysctl.c. I think we can
> add a separate patch later to add a test for proc_bool.

Yes please.

> >
> > > +     unsigned int val = READ_ONCE(*data);
> > > +     int ret;
> > > +
> > > +     /* Do not support arrays yet. */

BTW I'd go furether. We don't want to add any more array
support for anything new. So "we don't support arrays" is better.

> > > +     if (table->maxlen != sizeof(bool))
> > > +             return -EINVAL;
> >
> > This is a separate change, and while I agree with it, as it simplifies
> > our implementation and we don't want to add more array crap support,
> > this should *alone* should be a separate commit.
> 
> If you agree reusing do_proc_douintvec to implement proc_dobool(),
> I think a separate commit may be not suitable since do_proc_douintvec()
> only support non-array. Mentioning this in commit log makes sense to me.
> 
> >
> > > +
> > > +     tmp.maxlen = sizeof(val);
> >
> > Why even set this as you do when we know it must be sizeof(bool)?
> > Or would this break things given do_proc_douintvec() is used?
> 
> Since we reuse do_proc_douintvec(), which requires a uint type, to
> get/set the value from/to the users. I think you can refer to the implementation
> of proc_dou8vec_minmax().
> 
> >
> > > +     tmp.data = &val;
> > > +     ret = do_proc_douintvec(&tmp, write, buffer, lenp, ppos, NULL, NULL);
> >
> > Ugh, since we are avoiding arrays and we are only dealing with bools
> > I'm inclined to just ask we simpify this a bool implementation which
> > does something like do_proc_do_bool() but without array and is optimized
> > just for bools.
> 
> The current implementation of __do_proc_douintvec() is already only deal
> with non-array. Maybe it is better to reuse __do_proc_douintvec()? Otherwise,
> we need to implement a similar functionality (do_proc_do_bool) like it but just
> process bool type. I suspect the changes will be not small. I am wondering is it
> value to do this? If yes, should we also rework proc_dou8vec_minmax() as well?

I hate code which is obfuscates. Even if it s longer. My preference is
to open code a few things here even if it is adding new code.

  Luis
