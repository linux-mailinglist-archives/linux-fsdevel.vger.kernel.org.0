Return-Path: <linux-fsdevel+bounces-12265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6BB85DB44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700DBB26D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDD7BB08;
	Wed, 21 Feb 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUHdH049"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D279DD6
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522724; cv=none; b=kOuop52I9nsHh1RxQAvGXD7nIpkxex1kZbM+tn72ax40VnV4pouuefv/PdxWEXfeJQHa698ezC9wRrrOBbhG42wgJaOQKKTh84SaqMwA5VBaAjkWB2WaRbUnpX98Ubs4TndoxzGCcNGYaRXuOyMBN046OjIV4WCQmTKSYVcq2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522724; c=relaxed/simple;
	bh=vjW1tSI2YCOHS9iyo/Q6jkhR2oPIQ63fd/EtDSsExGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtKsghwrrlsxrl08mm+Tli3zaWYzHbjAdoJBp0Z7j6Q3yRgWZMoO9hkR3BfLHMqyeI8wgbXT9GRTVEA+QaJty0pWTKlv8fSP1b7rLaOxJ2aK5oAItsNZrp32CDyqWa6R3pV1wN8b4amv6loei0wlHiiMj8MVgkgee+BM87qbMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUHdH049; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564a53b8133so3597383a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708522720; x=1709127520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2ggNhJZ+8gOe2CxqkSn6OtuJ/B/sg2EScFlrM19ZUQ=;
        b=EUHdH049KeVN6WgJ4+yr2XYDp2ZmAQv8RCAgWJLTexclGwHToLM5HOIQK13S02VxAv
         yE2645x5FLafJZ9/GT42rcJhiI8wgjaN1RQQT2qxrzV0RwsKpum1BgZ0A+I/bIZB9HHx
         l02uDkV1WnTmYCths53+k+/K6sp3j/cJQaKxr4nam4BzXGojsg9me+5TMbIxH80yAUut
         9I8+Qa7cuVkuQ7VR8cBGAB0mCuoAPeVARw5eJmhu/eRhlR6XIU4h6SYAFFL53E8RydLH
         NrvU7ph+8vSSpib7iVyaXb5XSGSHQSWJOm19h24UBeXmHGQXs2hsN0eeCvKwTz79aUGU
         kZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708522720; x=1709127520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2ggNhJZ+8gOe2CxqkSn6OtuJ/B/sg2EScFlrM19ZUQ=;
        b=o+rNNwaB68mI2Em4nHf98/98ru8iZnnQAQLOuw5s97ptvWwkfLw/871a7rQGWymp3I
         4Kd25Dgy3XTmRn5kukurXZh1jvcyCqLtg3Ugwbm/yRvvbY0WCXCNeogu+7z/wAxTKDWi
         2BNZHtkglpY3qRjTsGsz1HVX3w/aj2YeK6bw381ew98+KyMsteQVIoC1gz3hYop2Z5pz
         7hdZT6oXoii9GJDTDnzmoxZBl6Nc8qaYMxcIZL8oYrdQil66f1UerRA518QJInWSu1Nf
         fj/NpclWwlpBaLW702jtGKkdWDUIlWZGNuQt4RUgSmyo8dLiKYrZ51r6RzDcOAniAeWQ
         bWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB6aezwAKYYVSG7+ByD9jQBOjKiABeYgtG9ZG6FA4DiVYqxLHf4mYvBP3QQsoJRf+ZAUXBju9D+4M9m7bNrYhtgFLJHUSOcRrFQVEcKw==
X-Gm-Message-State: AOJu0YyqlUJ/bLp2RM/iABjwtY18aZU/tSl82Gd4TKP76b9lcRt417js
	cBEix0Ca7hg1rBkAd2UlBAMRjVwp6Q/adZ1yH0l3XP+6ZFPpIBo3XAZ8QqJMvw==
X-Google-Smtp-Source: AGHT+IG2aAgbx/tffCu6qXqPL9X4Y2tgaTWtxuY808f8FM/gBhbkj3QLBMbqBXwBbRy7jOcG1N8WIw==
X-Received: by 2002:a05:6402:649:b0:564:5150:76a2 with SMTP id u9-20020a056402064900b00564515076a2mr6459084edx.4.1708522720465;
        Wed, 21 Feb 2024 05:38:40 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id i16-20020a0564020f1000b0056411b3fc4bsm4597347eda.30.2024.02.21.05.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:38:39 -0800 (PST)
Date: Wed, 21 Feb 2024 13:38:36 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org,
	daniel@iogearbox.net, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf-next 01/11] bpf: make bpf_d_path() helper use
 probe-read semantics
Message-ID: <ZdX83H7rTEwMYvs2@google.com>
References: <cover.1708377880.git.mattbobrowski@google.com>
 <5643840bd57d0c2345635552ae228dfb2ed3428c.1708377880.git.mattbobrowski@google.com>
 <20240220-erstochen-notwehr-755dbd0a02b3@brauner>
 <ZdSnhqkO_JbRP5lO@google.com>
 <20240221-fugen-turmbau-07ec7df36609@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-fugen-turmbau-07ec7df36609@brauner>

Hey Christian,

On Wed, Feb 21, 2024 at 08:55:25AM +0100, Christian Brauner wrote:
> On Tue, Feb 20, 2024 at 01:22:14PM +0000, Matt Bobrowski wrote:
> > On Tue, Feb 20, 2024 at 10:48:10AM +0100, Christian Brauner wrote:
> > > On Tue, Feb 20, 2024 at 09:27:23AM +0000, Matt Bobrowski wrote:
> > > > There has now been several reported instances [0, 1, 2] where the
> > > > usage of the BPF helper bpf_d_path() has led to some form of memory
> > > > corruption issue.
> > > > 
> > > > The fundamental reason behind why we repeatedly see bpf_d_path() being
> > > > susceptible to such memory corruption issues is because it only
> > > > enforces ARG_PTR_TO_BTF_ID constraints onto it's struct path
> > > > argument. This essentially means that it only requires an in-kernel
> > > > pointer of type struct path to be provided to it. Depending on the
> > > > underlying context and where the supplied struct path was obtained
> > > > from and when, depends on whether the struct path is fully intact or
> > > > not when calling bpf_d_path(). It's certainly possible to call
> > > > bpf_d_path() and subsequently d_path() from contexts where the
> > > > supplied struct path to bpf_d_path() has already started being torn
> > > > down by __fput() and such. An example of this is perfectly illustrated
> > > > in [0].
> > > > 
> > > > Moving forward, we simply cannot enforce KF_TRUSTED_ARGS semantics
> > > > onto struct path of bpf_d_path(), as this approach would presumably
> > > > lead to some pretty wide scale and highly undesirable BPF program
> > > > breakage. To avoid breaking any pre-existing BPF program that is
> > > > dependent on bpf_d_path(), I propose that we take a different path and
> > > > re-implement an incredibly minimalistic and bare bone version of
> > > > d_path() which is entirely backed by kernel probe-read semantics. IOW,
> > > > a version of d_path() that is backed by
> > > > copy_from_kernel_nofault(). This ensures that any reads performed
> > > > against the supplied struct path to bpf_d_path() which may end up
> > > > faulting for whatever reason end up being gracefully handled and fixed
> > > > up.
> > > > 
> > > > The caveats with such an approach is that we can't fully uphold all of
> > > > d_path()'s path resolution capabilities. Resolving a path which is
> > > > comprised of a dentry that make use of dynamic names via isn't
> > > > possible as we can't enforce probe-read semantics onto indirect
> > > > function calls performed via d_op as they're implementation
> > > > dependent. For such cases, we just return -EOPNOTSUPP. This might be a
> > > > little surprising to some users, especially those that are interested
> > > > in resolving paths that involve a dentry that resides on some
> > > > non-mountable pseudo-filesystem, being pipefs/sockfs/nsfs, but it's
> > > > arguably better than enforcing KF_TRUSTED_ARGS onto bpf_d_path() and
> > > > causing an unnecessary shemozzle for users. Additionally, we don't
> > > 
> > > NAK. We're not going to add a semi-functional reimplementation of
> > > d_path() for bpf. This relied on VFS internals and guarantees that were
> > > never given. Restrict it to KF_TRUSTED_ARGS as it was suggested when
> > > this originally came up or fix it another way. But we're not adding a
> > > bunch of kfuncs to even more sensitive VFS machinery and then build a
> > > d_path() clone just so we can retroactively justify broken behavior.
> > 
> > OK, I agree, having a semi-functional re-implementation of d_path() is
> > indeed suboptimal. However, also understand that slapping the
> 
> The ugliness of the duplicated code made me start my mail with NAK. It
> would've been enough to just say no.
> 
> > KF_TRUSTED_ARGS constraint onto the pre-existing BPF helper
> > bpf_d_path() would outright break a lot of BPF programs out there, so
> > I can't see how taht would be an acceptable approach moving forward
> > here either.
> > 
> > Let's say that we decided to leave the pre-existing bpf_d_path()
> > implementation as is, accepting that it is fundamentally succeptible
> > to memory corruption issues, are you saying that you're also not for
> > adding the KF_TRUSTED_ARGS d_path() variant as I've done so here
> 
> No, that's fine and was the initial proposal anyway. You're already
> using the existing d_path() anway in that bpf_d_path() thing. So
> exposing another variant with KF_TRUSTED_ARGS restriction is fine. But
> not hacking up a custom d_path() variant.

OK, thank you for clarifying. Perhaps we should just make a remark in
the form of a comment against bpf_d_path() stating that this BPF
helper is considered unsafe and users should look to migrate to the
newly added KF_TRUSTED_ARGS variant if at all possible.

> > [0]. Or, is it the other supporting reference counting based BPF
> > kfuncs [1, 2] that have irked you and aren't supportive of either?
> 
> Yes, because you're exposing fs_root, fs_pwd, path_put() and fdput(),
> get_task_exe_file(), get_mm_exe_file(). None of that I see being turned
> into kfuncs.

Hm, OK, but do know that BPF kfuncs do not make any promises around
being a stable interface, they never have and never will. Therefore,
it's not like introducing this kind of dependency on such APIs from
BPF kfuncs would hinder you from fundamentally modifying them moving
forward?

Additionally, given that these new acquire/release based BPF kfuncs
which rely on APIs like get_fs_root() and path_put() are in fact
restricted to BPF LSM programs, usage of such BPF kfuncs from the
context of a BPF LSM program would rather be analogous to a
pre-existing LSM module calling get_fs_root() and path_put()
explicitly within one of its implemented hooks, no? IOW, once a BPF
LSM program is loaded and JITed, what's the fundamental difference
between a baked in LSM module hook implementation which calls
get_fs_root() and a BPF LSM program which calls
bpf_get_task_fs_root()?  They're both being used in a perfectly
reasonable and sane like-for-like context, so what's the issue with
exposing such APIs as BPF kfuncs if they're being used appropriately?
It really doesn't make sense to provide independent reference counting
implementations just for BPF if there's some pre-existing
infrastructure in the kernel that does it the right way.

Also note that without such new reference counting BPF kfuncs which
I've proposed within this patch series the KF_TRUSTED_ARGS variant of
bpf_d_path() that we've agreed on becomes somewhat difficult to use in
practice. It'd essentially only be usable from LSM hooks that pass in
a struct path via the context parameter. Whilst in reality, it's
considered rather typical to also pass a struct path like
&current->mm->exe_file->f_path and &current->fs->pwd to bpf_d_path()
and friends from within the the implementation of an LSM hook. Such
struct path objects nested some levels deep isn't considered as being
trusted and therefore cannot be passed to a BPF kfunc that enforces
the KF_TRUSTED_ARGS constraint. The only way to acquire trust on a
pointer after performing such a struct walk is by grabbing a reference
on it, and hence why this KF_TRUSTED_ARGS change to d_path() and these
new BPF kfuncs go hand in hand.

Apologies about all the questions and comments here, but I'm really
just trying to understand why there's so much push back with regards
adding these reference counting BPF kfuncs?

/M

