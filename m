Return-Path: <linux-fsdevel+bounces-11277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51285273E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 03:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2F81C23730
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 02:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC864A2C;
	Tue, 13 Feb 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6oN4vq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03615CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789908; cv=none; b=MqD4h1mTVQ7UznzUJ4QWdb1OfFCG33hTH93QbU9u7nc3IhqJiwDCyhkuX9+b65BQtU7PljH5VvyQFWht4smj9M2hfFy2CSKP5iTlRGogbVUtUtvi4EQsOgsYlBOWgVt5lPun7R3I9DrMvoaI6eOh/o+lU57s33+axIr9NhbQjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789908; c=relaxed/simple;
	bh=QborkdBr5qe1qpX9CxpkvYhxDIqO2iJMHQhM5lpJYbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXBi2JDIr2b7N5mFf659+0mndbvaP5PzCsFbovKfEPBD8VEWw3oPunhug/l/YeNnC6Oo5zXDeRMDVaK+mZL9suMLEi3zyxpRH/zBqXgYe5yYrm7fHDDiIyhJkm7dRvBycpbUgeGhquj7G1vygqhGOCX/luP1RoDH39Ls85KK2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6oN4vq3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6077444cb51so7360757b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 18:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707789903; x=1708394703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t18iwUPgrIMFqF00PxZ8iIKrNS4wENWkpnpySINaofY=;
        b=Z6oN4vq3xNmkhyHFkqZyIYoDyNyMjyRN9KwkrxzV2sP5NEO9can8NE3S6XX0Pjybe6
         A1+QPV5Ir9KRx3zjMb4sHPyYHKLT1svfORpp4pz4ws/tklzGb3/dZUFRruE3hKbFay+A
         eGG/+FYMQvnJwztmceo2UTuWSuEca/b8NElKQopYsLWYdr0siFKaA7rjDzQGfeqa5AK2
         ffif0RjDKzgB+Dm1bA1muy6/356VfmgqFA1lLKHC/0oV+eiYlA4dHiGGaGe/lAo2AsDr
         vqPAib/wHc5t0nhXE+eAp6UHqPQqXxtfSbjPbsX5Sopm3MI0OOC2KcTifhYiTBaD3GW7
         7Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707789903; x=1708394703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t18iwUPgrIMFqF00PxZ8iIKrNS4wENWkpnpySINaofY=;
        b=aL2ygArfIY7I2xB1YeWjsL0oGIaDfNNgHYHwSWQFM6j8s+YW9ExhXh8dSId1T8pKVk
         BcAE2JI3QRKrAJfOGHxHC97gAq9A6q8Qrwa2xBQBBfn3o82/ERi/UFslXJfBi95UfAnh
         l9jwzQQD3ZXqCZcP8Iu/wfqQdPFn/8Wcc+OIjaT0YNpNZM1RM7e1s8KQz/XasShFz+yp
         100pSk8qwpoOW2hiy9GTsgVWYXAVgCFtp6uy6t2T5V13BewrJAU4j7q/PXqJTFhXhu8Z
         aiQTGXeQK7Ubf8rGOfXWW4E/4KoXTsVcUpazVLmMcjDwpJQ4hySOMa1RaSOd7JWSMmnk
         8z4A==
X-Gm-Message-State: AOJu0Ywbaj1DYUkKDB3Bahhv+EBa5+eAT5WDdwtqyXzUBZDMNTSS2E6Y
	N3vrwUF9baYJIKWrgGFRunkPLiAWczv7Tw2pGbelXgOtkAiG7DvmKl4UXbrHxrisqDVzxWWdYaz
	gjj9dS/OTtCm55NyE20RXKFCO7697wQJaBKmN
X-Google-Smtp-Source: AGHT+IHZlhILmQ80EEKHLJXrnQXKUD3seop9USmHvDp9eQctdzDsWHxPjxq0b74BO3+BCbPrT5dAegCHo2doApZY3Gk=
X-Received: by 2002:a25:dc06:0:b0:dc6:d1a9:d858 with SMTP id
 y6-20020a25dc06000000b00dc6d1a9d858mr1004949ybe.8.1707789903306; Mon, 12 Feb
 2024 18:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-11-surenb@google.com>
 <202402121419.7C4AAF27ED@keescook>
In-Reply-To: <202402121419.7C4AAF27ED@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 18:04:51 -0800
Message-ID: <CAJuCfpFpKKqCtU2EJM28fbYRYUbBLR9XuDONmS21zeTc2Z6nxw@mail.gmail.com>
Subject: Re: [PATCH v3 10/35] lib: code tagging framework
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:27=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:38:56PM -0800, Suren Baghdasaryan wrote:
> > Add basic infrastructure to support code tagging which stores tag commo=
n
> > information consisting of the module name, function, file name and line
> > number. Provide functions to register a new code tag type and navigate
> > between code tags.
> >
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/codetag.h |  71 ++++++++++++++
> >  lib/Kconfig.debug       |   4 +
> >  lib/Makefile            |   1 +
> >  lib/codetag.c           | 199 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 275 insertions(+)
> >  create mode 100644 include/linux/codetag.h
> >  create mode 100644 lib/codetag.c
> >
> > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > new file mode 100644
> > index 000000000000..a9d7adecc2a5
> > --- /dev/null
> > +++ b/include/linux/codetag.h
> > @@ -0,0 +1,71 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * code tagging framework
> > + */
> > +#ifndef _LINUX_CODETAG_H
> > +#define _LINUX_CODETAG_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct codetag_iterator;
> > +struct codetag_type;
> > +struct seq_buf;
> > +struct module;
> > +
> > +/*
> > + * An instance of this structure is created in a special ELF section a=
t every
> > + * code location being tagged.  At runtime, the special section is tre=
ated as
> > + * an array of these.
> > + */
> > +struct codetag {
> > +     unsigned int flags; /* used in later patches */
> > +     unsigned int lineno;
> > +     const char *modname;
> > +     const char *function;
> > +     const char *filename;
> > +} __aligned(8);
> > +
> > +union codetag_ref {
> > +     struct codetag *ct;
> > +};
> > +
> > +struct codetag_range {
> > +     struct codetag *start;
> > +     struct codetag *stop;
> > +};
> > +
> > +struct codetag_module {
> > +     struct module *mod;
> > +     struct codetag_range range;
> > +};
> > +
> > +struct codetag_type_desc {
> > +     const char *section;
> > +     size_t tag_size;
> > +};
> > +
> > +struct codetag_iterator {
> > +     struct codetag_type *cttype;
> > +     struct codetag_module *cmod;
> > +     unsigned long mod_id;
> > +     struct codetag *ct;
> > +};
> > +
> > +#define CODE_TAG_INIT {                                      \
> > +     .modname        =3D KBUILD_MODNAME,               \
> > +     .function       =3D __func__,                     \
> > +     .filename       =3D __FILE__,                     \
> > +     .lineno         =3D __LINE__,                     \
> > +     .flags          =3D 0,                            \
> > +}
> > +
> > +void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
> > +struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttyp=
e);
> > +struct codetag *codetag_next_ct(struct codetag_iterator *iter);
> > +
> > +void codetag_to_text(struct seq_buf *out, struct codetag *ct);
> > +
> > +struct codetag_type *
> > +codetag_register_type(const struct codetag_type_desc *desc);
> > +
> > +#endif /* _LINUX_CODETAG_H */
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 975a07f9f1cc..0be2d00c3696 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -968,6 +968,10 @@ config DEBUG_STACKOVERFLOW
> >
> >         If in doubt, say "N".
> >
> > +config CODE_TAGGING
> > +     bool
> > +     select KALLSYMS
> > +
> >  source "lib/Kconfig.kasan"
> >  source "lib/Kconfig.kfence"
> >  source "lib/Kconfig.kmsan"
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 6b09731d8e61..6b48b22fdfac 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -235,6 +235,7 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) +=
=3D \
> >       of-reconfig-notifier-error-inject.o
> >  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) +=3D error-inject.o
> >
> > +obj-$(CONFIG_CODE_TAGGING) +=3D codetag.o
> >  lib-$(CONFIG_GENERIC_BUG) +=3D bug.o
> >
> >  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) +=3D syscall.o
> > diff --git a/lib/codetag.c b/lib/codetag.c
> > new file mode 100644
> > index 000000000000..7708f8388e55
> > --- /dev/null
> > +++ b/lib/codetag.c
> > @@ -0,0 +1,199 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/codetag.h>
> > +#include <linux/idr.h>
> > +#include <linux/kallsyms.h>
> > +#include <linux/module.h>
> > +#include <linux/seq_buf.h>
> > +#include <linux/slab.h>
> > +
> > +struct codetag_type {
> > +     struct list_head link;
> > +     unsigned int count;
> > +     struct idr mod_idr;
> > +     struct rw_semaphore mod_lock; /* protects mod_idr */
> > +     struct codetag_type_desc desc;
> > +};
> > +
> > +static DEFINE_MUTEX(codetag_lock);
> > +static LIST_HEAD(codetag_types);
> > +
> > +void codetag_lock_module_list(struct codetag_type *cttype, bool lock)
> > +{
> > +     if (lock)
> > +             down_read(&cttype->mod_lock);
> > +     else
> > +             up_read(&cttype->mod_lock);
> > +}
> > +
> > +struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttyp=
e)
> > +{
> > +     struct codetag_iterator iter =3D {
> > +             .cttype =3D cttype,
> > +             .cmod =3D NULL,
> > +             .mod_id =3D 0,
> > +             .ct =3D NULL,
> > +     };
> > +
> > +     return iter;
> > +}
> > +
> > +static inline struct codetag *get_first_module_ct(struct codetag_modul=
e *cmod)
> > +{
> > +     return cmod->range.start < cmod->range.stop ? cmod->range.start :=
 NULL;
> > +}
> > +
> > +static inline
> > +struct codetag *get_next_module_ct(struct codetag_iterator *iter)
> > +{
> > +     struct codetag *res =3D (struct codetag *)
> > +                     ((char *)iter->ct + iter->cttype->desc.tag_size);
> > +
> > +     return res < iter->cmod->range.stop ? res : NULL;
> > +}
> > +
> > +struct codetag *codetag_next_ct(struct codetag_iterator *iter)
> > +{
> > +     struct codetag_type *cttype =3D iter->cttype;
> > +     struct codetag_module *cmod;
> > +     struct codetag *ct;
> > +
> > +     lockdep_assert_held(&cttype->mod_lock);
> > +
> > +     if (unlikely(idr_is_empty(&cttype->mod_idr)))
> > +             return NULL;
> > +
> > +     ct =3D NULL;
> > +     while (true) {
> > +             cmod =3D idr_find(&cttype->mod_idr, iter->mod_id);
> > +
> > +             /* If module was removed move to the next one */
> > +             if (!cmod)
> > +                     cmod =3D idr_get_next_ul(&cttype->mod_idr,
> > +                                            &iter->mod_id);
> > +
> > +             /* Exit if no more modules */
> > +             if (!cmod)
> > +                     break;
> > +
> > +             if (cmod !=3D iter->cmod) {
> > +                     iter->cmod =3D cmod;
> > +                     ct =3D get_first_module_ct(cmod);
> > +             } else
> > +                     ct =3D get_next_module_ct(iter);
> > +
> > +             if (ct)
> > +                     break;
> > +
> > +             iter->mod_id++;
> > +     }
> > +
> > +     iter->ct =3D ct;
> > +     return ct;
> > +}
> > +
> > +void codetag_to_text(struct seq_buf *out, struct codetag *ct)
> > +{
> > +     seq_buf_printf(out, "%s:%u module:%s func:%s",
> > +                    ct->filename, ct->lineno,
> > +                    ct->modname, ct->function);
> > +}
>
> Thank you for using seq_buf here!
>
> Also, will this need an EXPORT_SYMBOL_GPL()?
>
> > +
> > +static inline size_t range_size(const struct codetag_type *cttype,
> > +                             const struct codetag_range *range)
> > +{
> > +     return ((char *)range->stop - (char *)range->start) /
> > +                     cttype->desc.tag_size;
> > +}
> > +
> > +static void *get_symbol(struct module *mod, const char *prefix, const =
char *name)
> > +{
> > +     char buf[64];
>
> Why is 64 enough? I was expecting KSYM_NAME_LEN here, but perhaps this
> is specialized enough to section names that it will not be a problem?

This buffer is being used to hold the name of the section containing
codetags appended with "__start_" or "__stop_" and the only current
user is alloc_tag_init() which sets the section name to "alloc_tags".
So, this buffer currently holds either "alloc_tags__start_" or
"alloc_tags__stop_". When more codetag applications are added (like
the ones we have shown in the original RFC [1]), there would be more
section names. 64 was chosen as a big enough value to reasonably hold
the section name with the suffix. But you are right, we should add a
check for the section name size to ensure it always fits. Will add
into my TODO list.

[1] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.com/
> If so, please document it clearly with a comment.

Will do.

>
> > +     int res;
> > +
> > +     res =3D snprintf(buf, sizeof(buf), "%s%s", prefix, name);
> > +     if (WARN_ON(res < 1 || res > sizeof(buf)))
> > +             return NULL;
>
> Please use a seq_buf here instead of snprintf, which we're trying to get
> rid of.
>
>         DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
>         char *buf;
>
>         seq_buf_printf(sb, "%s%s", prefix, name);
>         if (seq_buf_has_overflowed(sb))
>                 return NULL;
>
>         buf =3D seq_buf_str(sb);

Will do. Thanks!

>
> > +
> > +     return mod ?
> > +             (void *)find_kallsyms_symbol_value(mod, buf) :
> > +             (void *)kallsyms_lookup_name(buf);
> > +}
> > +
> > +static struct codetag_range get_section_range(struct module *mod,
> > +                                           const char *section)
> > +{
> > +     return (struct codetag_range) {
> > +             get_symbol(mod, "__start_", section),
> > +             get_symbol(mod, "__stop_", section),
> > +     };
> > +}
> > +
> > +static int codetag_module_init(struct codetag_type *cttype, struct mod=
ule *mod)
> > +{
> > +     struct codetag_range range;
> > +     struct codetag_module *cmod;
> > +     int err;
> > +
> > +     range =3D get_section_range(mod, cttype->desc.section);
> > +     if (!range.start || !range.stop) {
> > +             pr_warn("Failed to load code tags of type %s from the mod=
ule %s\n",
> > +                     cttype->desc.section,
> > +                     mod ? mod->name : "(built-in)");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Ignore empty ranges */
> > +     if (range.start =3D=3D range.stop)
> > +             return 0;
> > +
> > +     BUG_ON(range.start > range.stop);
> > +
> > +     cmod =3D kmalloc(sizeof(*cmod), GFP_KERNEL);
> > +     if (unlikely(!cmod))
> > +             return -ENOMEM;
> > +
> > +     cmod->mod =3D mod;
> > +     cmod->range =3D range;
> > +
> > +     down_write(&cttype->mod_lock);
> > +     err =3D idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> > +     if (err >=3D 0)
> > +             cttype->count +=3D range_size(cttype, &range);
> > +     up_write(&cttype->mod_lock);
> > +
> > +     if (err < 0) {
> > +             kfree(cmod);
> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +struct codetag_type *
> > +codetag_register_type(const struct codetag_type_desc *desc)
> > +{
> > +     struct codetag_type *cttype;
> > +     int err;
> > +
> > +     BUG_ON(desc->tag_size <=3D 0);
> > +
> > +     cttype =3D kzalloc(sizeof(*cttype), GFP_KERNEL);
> > +     if (unlikely(!cttype))
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     cttype->desc =3D *desc;
> > +     idr_init(&cttype->mod_idr);
> > +     init_rwsem(&cttype->mod_lock);
> > +
> > +     err =3D codetag_module_init(cttype, NULL);
> > +     if (unlikely(err)) {
> > +             kfree(cttype);
> > +             return ERR_PTR(err);
> > +     }
> > +
> > +     mutex_lock(&codetag_lock);
> > +     list_add_tail(&cttype->link, &codetag_types);
> > +     mutex_unlock(&codetag_lock);
> > +
> > +     return cttype;
> > +}
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >
>
> --
> Kees Cook

