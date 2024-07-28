Return-Path: <linux-fsdevel+bounces-24383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD05493E93E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB231F21698
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA77581B;
	Sun, 28 Jul 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0Nw4n0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90897A957
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198577; cv=none; b=lfu8KOglvk88FR2ed8lc7brTd6V5fUfqgkdyvVLzlsOQn2nliRKoAYsTMEO3MSJCP1/fK7dpSsr2LvwSWgGh1P7ZlFxplv8ePzOaVrM3+0UoFlk1AzSKg9x6wVM1jqiDzrPx8fsQTHcEHQm02nztOuZwR8CpdZPb8iMO/IwZ8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198577; c=relaxed/simple;
	bh=C99MIr5sqDmhHDgAJNyhWFZbzausSeDzs7Urlh7Akks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXSqUTQ0zsA/zhDugBuGZZ7V+OGP2AwXfNnSYSkjHU7tn3w90alXO0Nk2WYcAmbTYaVTcN8v3xt9oFh7sFMvGr5AgU3/wsrmxN6yuD9vt0L9OoMjC5RuLkBpytbZHmLnbD5FyjjG7NmU9IfYj/ql+NF8JYYTyOzeTho3/89yWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0Nw4n0F; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so4505271a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2024 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198574; x=1722803374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cPz6VsZP4nCK1lL+97Z46SkWDcDycYzIe8S2y5sR6ds=;
        b=Q0Nw4n0FE+MMMNWSFb3eQbKX/D8N/grfm9fslSJfncFLVlOiZwbYcYak2+/bmpbfnE
         ZwYTWeuKRgKZNW2BFqtIKW2HGBMOJStngpQwIuC0zWhZl/n1OVnMB91CEMjGqIuctR8b
         siC1HEBMJmtQb3m5LszYmCQNnapiqL2C3yAUj9MHGx3qetEuGhdAy7LB0gJhe0NUDhDi
         Ev4nYHpvOGwRlidStbv3vfbOWA/aPLINtDmfONDqfAY8gvs11cbEGYeWjKBlKv2c2eAs
         p0HnxZglJchS/OQvNJR+uUuUhik8NcXa/2A0iwoyo19bHZwiK4yX2lY4maqWCqVnGrNA
         DE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198574; x=1722803374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPz6VsZP4nCK1lL+97Z46SkWDcDycYzIe8S2y5sR6ds=;
        b=UNsdNb8sHZBxb4UIYth8gA1euI/o82mxstiRWTQyc2GlLI2WMCc3gnxgYoi2g5hvr3
         /keBrnUEl6HXEcuYs0Z905d/XbfFbgmV+lIkDrJyui9NjAUUMkGzdquaooj0WI9VA0EC
         coTV9V/yuBoYx1cnVDWSY3StCdjgvMGrjWEveuzv7+ePdfVMFoYxobDGTDMYPjg5ovsx
         266XOlg49fRQ+R3PItrmM8tdeh7JKIVi89mMCnoreUIAujhvbA4cnXeIHy0am2nzL1r9
         oC7eWFg/hsvZmeC5vTT13G9VfAnajLglxdbQzEyK8ZndRmHWVZYvVgyoGnoHC9Tb46za
         41Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXjmKeRbhWcVyJCHfg8tGWNoKnRJIUkcwTizReQ/zD0OCb86QoVRafxu/0sRAhhmpbp/PDZ98Mt2/grNdZWReBHLu92UFncH4ZXR8fU3g==
X-Gm-Message-State: AOJu0YzKjoJjVOGf1SWrMSgldAQ+vbh35G3bonPuIVGehy7eXK8gkpNA
	+srqkXAEqsaqwlrrc2f/rNYAwUhOCNSu+Wx0A4drb/gyhl9tWElxme1U+sn63g==
X-Google-Smtp-Source: AGHT+IGqiSjCxBye5ZAa3rs5renJg69RYKvItbMssg0mOEUGsmI9PwwuuEfrI4ro1Fh9vkmHCqhS3g==
X-Received: by 2002:a17:906:d551:b0:a7a:93c9:3925 with SMTP id a640c23a62f3a-a7d3ffadde6mr418361366b.6.1722198573125;
        Sun, 28 Jul 2024 13:29:33 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41dd2sm420440266b.107.2024.07.28.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 13:29:32 -0700 (PDT)
Date: Sun, 28 Jul 2024 20:29:29 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
	andrii@kernel.org, jannh@google.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, jolsa@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <ZqaqKc1fCLPTOxim@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
 <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>
 <ZqQZ7EBooVcv0_hm@google.com>
 <CAPhsuW4i_+xoWXKcPvmUidNBuN7f1rLzfvn7uCSpyk9bbZb67A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4i_+xoWXKcPvmUidNBuN7f1rLzfvn7uCSpyk9bbZb67A@mail.gmail.com>

On Fri, Jul 26, 2024 at 03:48:45PM -0700, Song Liu wrote:
> On Fri, Jul 26, 2024 at 2:49 PM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 02:25:26PM -0700, Song Liu wrote:
> > > On Fri, Jul 26, 2024 at 1:56 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > >
> > > [...]
> > > > +       len = buf + buf__sz - ret;
> > > > +       memmove(buf, ret, len);
> > > > +       return len;
> > > > +}
> > > > +__bpf_kfunc_end_defs();
> > > > +
> > > > +BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> > > > +BTF_ID_FLAGS(func, bpf_get_task_exe_file,
> > > > +            KF_ACQUIRE | KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_RET_NULL)
> > > > +BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)
> > >
> > > Do we really need KF_SLEEPABLE for bpf_put_file?
> >
> > Well, the guts of fput() is annotated w/ might_sleep(), so the calling
> > thread may presumably be involuntarily put to sleep? You can also see
> > the guts of fput() invoking various indirect function calls
> > i.e. ->release(), and depending on the implementation of those, they
> > could be initiating resource release related actions which
> > consequently could result in waiting for some I/O to be done? fput()
> > also calls dput() and mntput() and these too can also do a bunch of
> > teardown.
> >
> > Please correct me if I've misunderstood something.
> 
> __fput() is annotated with might_sleep(). However, fput() doesn't not
> call __fput() directly. Instead, it schedules a worker to call __fput().
> Therefore, it is safe to call fput() from a non-sleepable context.

Oh, yes, you're absolutely right. I failed to realize that, so my
apologies. In that case, yes, technically bpf_put_file() does not need
to be annotated w/ KF_SLEEPABLE. Now that I also think of it, one of
the other and only reasons why we made this initially sleepable is
because bpf_put_file() at the time was meant to be used exclusively
within the same context as bpf_path_d_path(), and that is currently
marked as sleepable. Although technically speaking, I think we could
also make bpf_path_d_path() not restricted to only sleepable BPF LSM
program types, and in turn that could mean that
bpf_get_task_exe_file() also doesn't need to be restricted to
sleepable BPF LSM programs.

Alexei, what do you think about relaxing the sleepable annotation
across this entire set of BPF kfuncs? From a technical perspective I
think it's OK, but I'd also like someone like Christian to confirm
that d_path() can't actually end up sleeping. Glancing over it, I
believe this to be true, but I may also be naively missing something.

/M

