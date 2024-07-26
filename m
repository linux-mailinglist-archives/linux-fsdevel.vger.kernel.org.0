Return-Path: <linux-fsdevel+bounces-24344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD093D9CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479982865F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C301E14EC77;
	Fri, 26 Jul 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzr9cC/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6B149DF8
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025895; cv=none; b=gkJ031EF+oxvU0NUz7GfDXKlxbuqi8WU1Cfmh/JIf7SMv+3p/01q4dYoAlehiEClcYJVj5qip4IRaHIVt8N5WVLQGpmBE8YYqRjineeg8z7E41/IUuFlZVpbuAxvjmXnnzo+DXFjlpAt2MQkM/ibSRRRJBNyz0TasFxgVg9/jak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025895; c=relaxed/simple;
	bh=n7JBBlQlTiCSmAs8UEVuH0nhRPwF6moucz/xAzt812Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrvDSKmhsdoj1pRCCzuFxt8Zu5U9ZJR0/BYqirwUmfeKyIxLd/WKTM4YB15HYutgO6FzJt32btZWeiT+4CDy97AalSTEwTvVdKEJlntyWY1ks8K1C/iM3eYgqBRaLY9k85yD9pHIL3fCxbBbsgZXx7BLpUI5ItWcHZMDScD5T6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzr9cC/q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7ab63a388bso159120566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722025892; x=1722630692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GC4Rqx6/6W/gum1zlkh9wKstYCm69gTpsSyG32Xxglg=;
        b=lzr9cC/q6SZ2xf5zJl5S+RFeS/0xm2sOhjcGxJu5Oai0APAXysghZv5iuPgayVv6un
         RTuH16FKKVf2pBUo/3Z8/dZn1LQkWZQ8KiCaupHhMTfJk17LzQxDi+OEwroCQW+7v7nB
         +Z0qfjanbkAKV0tpE9kBSooN/U+IfDdlQM8I6Y0eSGWwBCyfdUVKPfXWcxCkgVYJUhi8
         uI9CnplblVl8mB2/OOblyytZloAAD9RdCZt0ZjNT2dA32Q2s3wLuO5YXdTSAWx8wu+Ly
         NSsUHRhGjDsnGoxX+zdFFpJWm7NicwO9ujtiWntctFAb/xWtn5dQOuOApWNnouckE2l2
         y7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722025892; x=1722630692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC4Rqx6/6W/gum1zlkh9wKstYCm69gTpsSyG32Xxglg=;
        b=DOhA6QdXlB2UVHdiOWUJw34BoQRnU9Z6tvdAjErOZnZyTY4TtP2bEMSDyq8UwtHNuO
         OsbhFmf7fuDOtJdH6Ri0IIYb0aOOFojWNlhxTlbnvITtbbAb1dNblUQQi23AbrhHrG0I
         fThOCgA7twPWYnv4q0fonUtm4M8jKk50hXZvTnZiE9PxUHLNWw3WzotPkzxpcjPCiM4l
         3xJEkUcSimSNonyGt3YQKBQVe0K2KUTVYxk5bjf6CYXOoXFHDxHrBpN8K90tL9VDU073
         g4uLqhQ5atx1BN9epieoIuXQSKHGZkIQ3SV7y0oj6P2a1yD5KizeA7c2iPEC2YVIiwGI
         28PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJoykjQ3m2VxLIqJX6uDQIExXaU70n6WfkE2SDRw+JLfK7xzl5fsjqDo/Nlh9RnH57Cnd4d1cnF9onoqKpr+oflo7cQsmbYbcKctRYXA==
X-Gm-Message-State: AOJu0YxlLN7Ii0hVdL2hxZab6TJGuW2fdYkGtWp9pAUH7zJL9udjSi5c
	GQSKtnXHIHCU7L0Vt5wesEXkOBq63mW+9+d3NAJcK/g1fnGuilIO+bRn4v3SFA==
X-Google-Smtp-Source: AGHT+IESCcbtS8Hwt3cZPIv7evxRG8txhYFOI8rLakTMLFQ3ku81bPJRTf1gDtZvy5YjeXhZ6q8fJw==
X-Received: by 2002:a50:d001:0:b0:5a1:f9bc:7f13 with SMTP id 4fb4d7f45d1cf-5b021f0e05fmr388418a12.22.1722025890999;
        Fri, 26 Jul 2024 13:31:30 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91005sm212496666b.173.2024.07.26.13.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:31:30 -0700 (PDT)
Date: Fri, 26 Jul 2024 20:31:27 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
	andrii@kernel.org, jannh@google.com, linux-fsdevel@vger.kernel.org,
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <ZqQHn307VGtRzCvD@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
 <20240726-klippe-umklammern-fe099b09e075@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-klippe-umklammern-fe099b09e075@brauner>

On Fri, Jul 26, 2024 at 03:18:25PM +0200, Christian Brauner wrote:
> On Fri, Jul 26, 2024 at 08:56:02AM GMT, Matt Bobrowski wrote:
> > Add a new variant of bpf_d_path() named bpf_path_d_path() which takes
> > the form of a BPF kfunc and enforces KF_TRUSTED_ARGS semantics onto
> > its arguments.
> > 
> > This new d_path() based BPF kfunc variant is intended to address the
> > legacy bpf_d_path() BPF helper's susceptibility to memory corruption
> > issues [0, 1, 2] by ensuring to only operate on supplied arguments
> > which are deemed trusted by the BPF verifier. Typically, this means
> > that only pointers to a struct path which have been referenced counted
> > may be supplied.
> > 
> > In addition to the new bpf_path_d_path() BPF kfunc, we also add a
> > KF_ACQUIRE based BPF kfunc bpf_get_task_exe_file() and KF_RELEASE
> > counterpart BPF kfunc bpf_put_file(). This is so that the new
> > bpf_path_d_path() BPF kfunc can be used more flexibility from within
> > the context of a BPF LSM program. It's rather common to ascertain the
> > backing executable file for the calling process by performing the
> > following walk current->mm->exe_file while instrumenting a given
> > operation from the context of the BPF LSM program. However, walking
> > current->mm->exe_file directly is never deemed to be OK, and doing so
> > from both inside and outside of BPF LSM program context should be
> > considered as a bug. Using bpf_get_task_exe_file() and in turn
> > bpf_put_file() will allow BPF LSM programs to reliably get and put
> > references to current->mm->exe_file.
> > 
> > As of now, all the newly introduced BPF kfuncs within this patch are
> > limited to sleepable BPF LSM program types. Therefore, they may only
> > be called when a BPF LSM program is attached to one of the listed
> > attachment points defined within the sleepable_lsm_hooks BTF ID set.
> > 
> > [0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
> > [1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
> > [2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com/
> > 
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > ---
> >  fs/Makefile        |   1 +
> >  fs/bpf_fs_kfuncs.c | 133 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 134 insertions(+)
> >  create mode 100644 fs/bpf_fs_kfuncs.c
> > 
> > diff --git a/fs/Makefile b/fs/Makefile
> > index 6ecc9b0a53f2..61679fd587b7 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
> >  obj-$(CONFIG_EROFS_FS)		+= erofs/
> >  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
> >  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> > +obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > new file mode 100644
> > index 000000000000..3813e2a83313
> > --- /dev/null
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -0,0 +1,133 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Google LLC. */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/dcache.h>
> > +#include <linux/err.h>
> > +#include <linux/fs.h>
> > +#include <linux/file.h>
> > +#include <linux/init.h>
> > +#include <linux/mm.h>
> > +#include <linux/path.h>
> > +#include <linux/sched.h>
> > +
> > +__bpf_kfunc_start_defs();
> > +/**
> > + * bpf_get_task_exe_file - get a reference on the exe_file struct file member of
> > + *                         the mm_struct that is nested within the supplied
> > + *                         task_struct
> > + * @task: task_struct of which the nested mm_struct exe_file member to get a
> > + * reference on
> > + *
> > + * Get a reference on the exe_file struct file member field of the mm_struct
> > + * nested within the supplied *task*. The referenced file pointer acquired by
> > + * this BPF kfunc must be released using bpf_put_file(). Failing to call
> > + * bpf_put_file() on the returned referenced struct file pointer that has been
> > + * acquired by this BPF kfunc will result in the BPF program being rejected by
> > + * the BPF verifier.
> > + *
> > + * This BPF kfunc may only be called from sleepable BPF LSM programs.
> > + *
> > + * Internally, this BPF kfunc leans on get_task_exe_file(), such that calling
> > + * bpf_get_task_exe_file() would be analogous to calling get_task_exe_file()
> > + * directly in kernel context.
> > + *
> > + * Return: A referenced struct file pointer to the exe_file member of the
> > + * mm_struct that is nested within the supplied *task*. On error, NULL is
> > + * returned.
> > + */
> > +__bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
> > +{
> > +	return get_task_exe_file(task);
> > +}
> > +
> > +/**
> > + * bpf_put_file - put a reference on the supplied file
> > + * @file: file to put a reference on
> > + *
> > + * Put a reference on the supplied *file*. Only referenced file pointers may be
> > + * passed to this BPF kfunc. Attempting to pass an unreferenced file pointer, or
> > + * any other arbitrary pointer for that matter, will result in the BPF program
> > + * being rejected by the BPF verifier.
> > + *
> > + * This BPF kfunc may only be called from sleepable BPF LSM programs. Though
> > + * fput() can be called from IRQ context, we're enforcing sleepability here.
> > + */
> > +__bpf_kfunc void bpf_put_file(struct file *file)
> > +{
> > +	fput(file);
> > +}
> > +
> > +/**
> > + * bpf_path_d_path - resolve the pathname for the supplied path
> > + * @path: path to resolve the pathname for
> > + * @buf: buffer to return the resolved pathname in
> > + * @buf__sz: length of the supplied buffer
> > + *
> > + * Resolve the pathname for the supplied *path* and store it in *buf*. This BPF
> > + * kfunc is the safer variant of the legacy bpf_d_path() helper and should be
> > + * used in place of bpf_d_path() whenever possible. It enforces KF_TRUSTED_ARGS
> > + * semantics, meaning that the supplied *path* must itself hold a valid
> > + * reference, or else the BPF program will be outright rejected by the BPF
> > + * verifier.
> > + *
> > + * This BPF kfunc may only be called from sleepable BPF LSM programs.
> > + *
> > + * Return: A positive integer corresponding to the length of the resolved
> > + * pathname in *buf*, including the NUL termination character. On error, a
> > + * negative integer is returned.
> > + */
> > +__bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
> > +{
> > +	int len;
> > +	char *ret;
> > +
> > +	if (buf__sz <= 0)
> > +		return -EINVAL;
> 
> size_t is unsigned so this should just be !buf__sz I can fix that
> though.

Sure, that would be great if you wouldn't mind?

> The __sz thing has meaning to the verifier afaict so I guess that's
> fine as name then.

That's right, it's used to signal that a buffer and it's associated
size exists within the BPF kfuncs argument list. Using the __sz
annotation specifically allows the BPF verifier to deduce which size
argument is meant to be bounded to a given buffer.

/M

