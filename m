Return-Path: <linux-fsdevel+bounces-11241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94463852162
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4476D280F75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442B4DA06;
	Mon, 12 Feb 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ObVJOQpG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480534CE18
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776837; cv=none; b=r2S+63VvpS2fIS+tkkrdkOvMPHR1wX8HwSaM9cEAJNjkyQHvy795THKAr4LLL1GKzAjRMFoAOP0UqIkMjgrGa4+5wbUOql2aK31PzAGzz7QjaZg/DDyGDWD/odi3DhBfE9algQUURj+g6El04V6ssLXutcv6GK//JHn54uB8EAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776837; c=relaxed/simple;
	bh=G3NGZcbluaJ/zAp2XWm2vhP9ph35dO6yUDGWwypzovI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfO0fFuS0Xf3BX49wLUHw2omnNSNyX9M0qmAlYnwnkmEM1Gd6SbGphvdZhOD8t+L8V/fBQRet5Y4B/ebcuY0L2eUS96yrtYpp5BXiBiVu1y3s1Bxcpu60rjzBWh3T5HJD0JoNm/Ur47xoZu+0QR6dhz+3dixVrADqm2vnqkSjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ObVJOQpG; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-595d24ad466so2349644eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707776834; x=1708381634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fCTTjLWubBPUVqrfEz/Ix5Fohf77+LrHQ9JGOiJ25Y=;
        b=ObVJOQpGh9NMka9zzCdNe2mHZ+aFO40JshAW8P2kwkUu/bC935JpXtwhnZpqXhmdbj
         BU0nJmTmLBH6SV+p/zjyfyC3nk0Jo1ghoU6IVZrbHTRgbN27mE2BYMqTJjCKhWVA5TDI
         8Qs7ajm5YYCBul/TgywOf1ziLE4owVDEPuqgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776834; x=1708381634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fCTTjLWubBPUVqrfEz/Ix5Fohf77+LrHQ9JGOiJ25Y=;
        b=boyPAqLaFXm8/3BRNPIQLJgr8GrBJ/bw8NCxDA3KgHEQI8xtyZcVCUa72pxWfGhp9v
         mrjvt26RmyQ3MzM1IidA6cIVy+qjPc+ry2w+BKP5fucxGyfU7vbSKRInZ8+1g4gjRBPz
         XjjCQrWp0oPkptYiPS7i/k0+dqYIKYbLB9fawv30wSnKeMEPaLbsfRKFbFK6gyelkDDc
         4MPZdr9YEmN0k5hbn/I7mHZzrYMWI5fx25phn8Pgo+mDSWDTpaIqoX3/Xw+qtsCoHAv1
         oaf71k7su+vCvATJ+mFYZ73wtbWfAURaGQ8zzJAr5rKdCKTwYRqZAIqfbHA0QUdwEcsh
         V1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+TK/xyrliYxMkEbQRVb1V/sIwTlUpcJdi4v2z5G+i7aAwM0VokfI/hl+lnA4z198Ocg57gun1ZlFO8VMeqLYfxVzadL9o2Q0L3zNGg==
X-Gm-Message-State: AOJu0Yzxc+/fJ2Rm2gTY43y963YRdkDhHOVA3CwIl6M0Ium+sc+Pu5/h
	cVJonXXZZ85/kg5+bz0Ua70+jmm7sV9cSoeA539jZKTMeY+MqFRYDr4Fc3islg==
X-Google-Smtp-Source: AGHT+IE2JeK55iDlCCRN4E+J9NV7GNNHSEyjISvBh8H7OiyLFRqV2gY8nqKBQvUaJYNrAoodRdyGWQ==
X-Received: by 2002:a05:6358:5985:b0:179:22c:4a4d with SMTP id c5-20020a056358598500b00179022c4a4dmr12595595rwf.22.1707776834330;
        Mon, 12 Feb 2024 14:27:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWf2we3jJkyiL56yASgBeHbGuOPK/zAKFZZJqJsFjwqJCu7lSz2PkRbHqn61vy1afoTkzzmAmn2yoi4YKuYIcIlZ1tS2t5UJ6zENqQASS+g2+mdWdW87ki2qSINoYwcVnpXk9Jxt008JlKwx9H7miKUNgmktF7k+j/mqb4DUQ+3viinslH9mdFi4cWGEkRHGMnvUtguQPPOOGlm46mxoOAI3k5cB94KXG1BkZ5pt0SQDz04QK7lRZEVw/oUneJArriEPMyRm0OcJBVcxStvhzNr9gXI4uzEQdTP35qDUgahLn0bDRMyvALPl+vfA2kTZVxk3veP07es+5NNZEaxRVRGig+V1lXrRRZZL4qvlUnZjXtgc0JnBQRy0BEmnHFcDygfqN0z7dmVerwT0rtJ6At86QpSp5vrFeOO7+fSKtRHl1ADHTAqxOJesx8cIdyGa3xeQ6S67rN4ggiVRBnZkMiJUPeGTfhjJ65NI8ZbR2qaBv8+5+kd5tYCnRkUloTmtEKa8XygArH6nbnHeLpBNOBimdnHtR16l++xYDGZU18G4x0EAt+npqPt5VPb8L8D+ACAPVHEQDg4OyEpXUhnsoRw5x5AHgVvt7ALejVHGHjzBqeqR+kCNSnuC1+sUvb14cXMnLcilob5okdWqGBM5ppqCKEnks/vxYap7l1G7YIQoP24SD66xTzz40zMfX9D4istIhPUaIvFZQ/DH7lu1RJCNm/SYRrZa83KjrL3g9ZyyZy2nINGuw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t31-20020a056a00139f00b006e0a895d2e9sm4861958pfg.211.2024.02.12.14.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:27:14 -0800 (PST)
Date: Mon, 12 Feb 2024 14:27:13 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 10/35] lib: code tagging framework
Message-ID: <202402121419.7C4AAF27ED@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-11-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-11-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:56PM -0800, Suren Baghdasaryan wrote:
> Add basic infrastructure to support code tagging which stores tag common
> information consisting of the module name, function, file name and line
> number. Provide functions to register a new code tag type and navigate
> between code tags.
> 
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/codetag.h |  71 ++++++++++++++
>  lib/Kconfig.debug       |   4 +
>  lib/Makefile            |   1 +
>  lib/codetag.c           | 199 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 275 insertions(+)
>  create mode 100644 include/linux/codetag.h
>  create mode 100644 lib/codetag.c
> 
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> new file mode 100644
> index 000000000000..a9d7adecc2a5
> --- /dev/null
> +++ b/include/linux/codetag.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * code tagging framework
> + */
> +#ifndef _LINUX_CODETAG_H
> +#define _LINUX_CODETAG_H
> +
> +#include <linux/types.h>
> +
> +struct codetag_iterator;
> +struct codetag_type;
> +struct seq_buf;
> +struct module;
> +
> +/*
> + * An instance of this structure is created in a special ELF section at every
> + * code location being tagged.  At runtime, the special section is treated as
> + * an array of these.
> + */
> +struct codetag {
> +	unsigned int flags; /* used in later patches */
> +	unsigned int lineno;
> +	const char *modname;
> +	const char *function;
> +	const char *filename;
> +} __aligned(8);
> +
> +union codetag_ref {
> +	struct codetag *ct;
> +};
> +
> +struct codetag_range {
> +	struct codetag *start;
> +	struct codetag *stop;
> +};
> +
> +struct codetag_module {
> +	struct module *mod;
> +	struct codetag_range range;
> +};
> +
> +struct codetag_type_desc {
> +	const char *section;
> +	size_t tag_size;
> +};
> +
> +struct codetag_iterator {
> +	struct codetag_type *cttype;
> +	struct codetag_module *cmod;
> +	unsigned long mod_id;
> +	struct codetag *ct;
> +};
> +
> +#define CODE_TAG_INIT {					\
> +	.modname	= KBUILD_MODNAME,		\
> +	.function	= __func__,			\
> +	.filename	= __FILE__,			\
> +	.lineno		= __LINE__,			\
> +	.flags		= 0,				\
> +}
> +
> +void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
> +struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
> +struct codetag *codetag_next_ct(struct codetag_iterator *iter);
> +
> +void codetag_to_text(struct seq_buf *out, struct codetag *ct);
> +
> +struct codetag_type *
> +codetag_register_type(const struct codetag_type_desc *desc);
> +
> +#endif /* _LINUX_CODETAG_H */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 975a07f9f1cc..0be2d00c3696 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -968,6 +968,10 @@ config DEBUG_STACKOVERFLOW
>  
>  	  If in doubt, say "N".
>  
> +config CODE_TAGGING
> +	bool
> +	select KALLSYMS
> +
>  source "lib/Kconfig.kasan"
>  source "lib/Kconfig.kfence"
>  source "lib/Kconfig.kmsan"
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b09731d8e61..6b48b22fdfac 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -235,6 +235,7 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) += \
>  	of-reconfig-notifier-error-inject.o
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>  
> +obj-$(CONFIG_CODE_TAGGING) += codetag.o
>  lib-$(CONFIG_GENERIC_BUG) += bug.o
>  
>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> diff --git a/lib/codetag.c b/lib/codetag.c
> new file mode 100644
> index 000000000000..7708f8388e55
> --- /dev/null
> +++ b/lib/codetag.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/codetag.h>
> +#include <linux/idr.h>
> +#include <linux/kallsyms.h>
> +#include <linux/module.h>
> +#include <linux/seq_buf.h>
> +#include <linux/slab.h>
> +
> +struct codetag_type {
> +	struct list_head link;
> +	unsigned int count;
> +	struct idr mod_idr;
> +	struct rw_semaphore mod_lock; /* protects mod_idr */
> +	struct codetag_type_desc desc;
> +};
> +
> +static DEFINE_MUTEX(codetag_lock);
> +static LIST_HEAD(codetag_types);
> +
> +void codetag_lock_module_list(struct codetag_type *cttype, bool lock)
> +{
> +	if (lock)
> +		down_read(&cttype->mod_lock);
> +	else
> +		up_read(&cttype->mod_lock);
> +}
> +
> +struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype)
> +{
> +	struct codetag_iterator iter = {
> +		.cttype = cttype,
> +		.cmod = NULL,
> +		.mod_id = 0,
> +		.ct = NULL,
> +	};
> +
> +	return iter;
> +}
> +
> +static inline struct codetag *get_first_module_ct(struct codetag_module *cmod)
> +{
> +	return cmod->range.start < cmod->range.stop ? cmod->range.start : NULL;
> +}
> +
> +static inline
> +struct codetag *get_next_module_ct(struct codetag_iterator *iter)
> +{
> +	struct codetag *res = (struct codetag *)
> +			((char *)iter->ct + iter->cttype->desc.tag_size);
> +
> +	return res < iter->cmod->range.stop ? res : NULL;
> +}
> +
> +struct codetag *codetag_next_ct(struct codetag_iterator *iter)
> +{
> +	struct codetag_type *cttype = iter->cttype;
> +	struct codetag_module *cmod;
> +	struct codetag *ct;
> +
> +	lockdep_assert_held(&cttype->mod_lock);
> +
> +	if (unlikely(idr_is_empty(&cttype->mod_idr)))
> +		return NULL;
> +
> +	ct = NULL;
> +	while (true) {
> +		cmod = idr_find(&cttype->mod_idr, iter->mod_id);
> +
> +		/* If module was removed move to the next one */
> +		if (!cmod)
> +			cmod = idr_get_next_ul(&cttype->mod_idr,
> +					       &iter->mod_id);
> +
> +		/* Exit if no more modules */
> +		if (!cmod)
> +			break;
> +
> +		if (cmod != iter->cmod) {
> +			iter->cmod = cmod;
> +			ct = get_first_module_ct(cmod);
> +		} else
> +			ct = get_next_module_ct(iter);
> +
> +		if (ct)
> +			break;
> +
> +		iter->mod_id++;
> +	}
> +
> +	iter->ct = ct;
> +	return ct;
> +}
> +
> +void codetag_to_text(struct seq_buf *out, struct codetag *ct)
> +{
> +	seq_buf_printf(out, "%s:%u module:%s func:%s",
> +		       ct->filename, ct->lineno,
> +		       ct->modname, ct->function);
> +}

Thank you for using seq_buf here!

Also, will this need an EXPORT_SYMBOL_GPL()?

> +
> +static inline size_t range_size(const struct codetag_type *cttype,
> +				const struct codetag_range *range)
> +{
> +	return ((char *)range->stop - (char *)range->start) /
> +			cttype->desc.tag_size;
> +}
> +
> +static void *get_symbol(struct module *mod, const char *prefix, const char *name)
> +{
> +	char buf[64];

Why is 64 enough? I was expecting KSYM_NAME_LEN here, but perhaps this
is specialized enough to section names that it will not be a problem?
If so, please document it clearly with a comment.

> +	int res;
> +
> +	res = snprintf(buf, sizeof(buf), "%s%s", prefix, name);
> +	if (WARN_ON(res < 1 || res > sizeof(buf)))
> +		return NULL;

Please use a seq_buf here instead of snprintf, which we're trying to get
rid of.

	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
	char *buf;

	seq_buf_printf(sb, "%s%s", prefix, name);
	if (seq_buf_has_overflowed(sb))
		return NULL;

	buf = seq_buf_str(sb);

> +
> +	return mod ?
> +		(void *)find_kallsyms_symbol_value(mod, buf) :
> +		(void *)kallsyms_lookup_name(buf);
> +}
> +
> +static struct codetag_range get_section_range(struct module *mod,
> +					      const char *section)
> +{
> +	return (struct codetag_range) {
> +		get_symbol(mod, "__start_", section),
> +		get_symbol(mod, "__stop_", section),
> +	};
> +}
> +
> +static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
> +{
> +	struct codetag_range range;
> +	struct codetag_module *cmod;
> +	int err;
> +
> +	range = get_section_range(mod, cttype->desc.section);
> +	if (!range.start || !range.stop) {
> +		pr_warn("Failed to load code tags of type %s from the module %s\n",
> +			cttype->desc.section,
> +			mod ? mod->name : "(built-in)");
> +		return -EINVAL;
> +	}
> +
> +	/* Ignore empty ranges */
> +	if (range.start == range.stop)
> +		return 0;
> +
> +	BUG_ON(range.start > range.stop);
> +
> +	cmod = kmalloc(sizeof(*cmod), GFP_KERNEL);
> +	if (unlikely(!cmod))
> +		return -ENOMEM;
> +
> +	cmod->mod = mod;
> +	cmod->range = range;
> +
> +	down_write(&cttype->mod_lock);
> +	err = idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> +	if (err >= 0)
> +		cttype->count += range_size(cttype, &range);
> +	up_write(&cttype->mod_lock);
> +
> +	if (err < 0) {
> +		kfree(cmod);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +struct codetag_type *
> +codetag_register_type(const struct codetag_type_desc *desc)
> +{
> +	struct codetag_type *cttype;
> +	int err;
> +
> +	BUG_ON(desc->tag_size <= 0);
> +
> +	cttype = kzalloc(sizeof(*cttype), GFP_KERNEL);
> +	if (unlikely(!cttype))
> +		return ERR_PTR(-ENOMEM);
> +
> +	cttype->desc = *desc;
> +	idr_init(&cttype->mod_idr);
> +	init_rwsem(&cttype->mod_lock);
> +
> +	err = codetag_module_init(cttype, NULL);
> +	if (unlikely(err)) {
> +		kfree(cttype);
> +		return ERR_PTR(err);
> +	}
> +
> +	mutex_lock(&codetag_lock);
> +	list_add_tail(&cttype->link, &codetag_types);
> +	mutex_unlock(&codetag_lock);
> +
> +	return cttype;
> +}
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

-- 
Kees Cook

