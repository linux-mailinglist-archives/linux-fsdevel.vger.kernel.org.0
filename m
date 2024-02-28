Return-Path: <linux-fsdevel+bounces-13115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDD886B6B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A901C25C0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530779B9F;
	Wed, 28 Feb 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07Nj3u52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61079B80
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143523; cv=none; b=uP9SjFsUo8/5H5wDa7IEwVVtsRRO5XpfEkDSKBiDUOiY3mHE+8hOF4Uz5jpL82M31r7yhOIlVOxKZgzGpcJKgGOiV74SR/R9RpFIJdWMWy9MZ10VvNw18YDZlQoTOwIChiPd0edytmZwmogKVuaZjeN2nOhrqX7NoW32rUgBDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143523; c=relaxed/simple;
	bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSqyJoyqsoNWvVpcrtPwbKSMOS5yb1W4zx2Ab0zmUnBJVvWB+bc77qKJNipNDUxMYF5Cmymbr2IQaJckR3g8fuipE2qXoDFt8lQPuAITW5OBJuNdBdU64wYml1r5IsV9cUbTOEgDKQnpHPiE/qAAAvZSvJuisQsA3rfIArKAx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07Nj3u52; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so51489276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 10:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143520; x=1709748320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
        b=07Nj3u52kU5HkNbHmQi6GSJlFvm+hwSmH23kU9J3YIdBUAZcfVKU5HQ3RCYnYic0v6
         QLRHfuCjI9k+jiAG3w+DoaSoumtOezIBDz1r8Kz8fHtyP7r7SZx31n43NzTdmop/PO2A
         8mM/4NeVzeoWdN0ez7/q13ruSZDGpAfWv4C6Jt0Y0ZDccQI15hWg5epL5i0sGXGwRR2Z
         QyHgs217g8YnqC7+n46M+BhjmuNXp3pKxFMqFRf5dLwy6cELVZXPEu+Ogd7PlX5F4r/Y
         GY/qYMx/nxnzCGNBgbHCEaaY4EPWcJbvRoW29RCrocuMaX6hzZjZnlqLuzHzfEmrYQi9
         uEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143520; x=1709748320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
        b=vXg3xuzepSr0Ed3kn4Q7fUhW8Dn53OWj09152VvFQhtOKz0lQWp5Dh9wFNXB/n2zYx
         +DC3+I6xzHHHYXXtwOYsl4K8SvpY1cOHia0phf3o6Har/Ej/AK3xTKuigr4ZAhtIJKp4
         FcrPCxHQCN2vER25feJIdf7av3tntxjDG8wP2EqZ3UmhIiRLZ8bGqhRpbebRqnExCEv2
         sFpvIjxYJD6tmvTYflDWy/fF2OquYhndMMIDOljQ1XovICJ4vaOIdkZLh/Yu+CdW+0lf
         ld1Rca3qAzaK7lWK6Ork+dFCZzcMfxMsqrKMl/DmQ+JH4WZa04MlroR+3iOu2WMdyvJe
         DuMw==
X-Forwarded-Encrypted: i=1; AJvYcCVBraRs3B9G3dTo0mJoirw1yj2F+QZiyDnyCHqXnD5zIyKCBq6TdjNQpdstgnnfqAuyK53YTUOSkY+6vWibak6nsDEwvES7XAlY+N9/RQ==
X-Gm-Message-State: AOJu0Yzz7Yts1rt0vnc1/hbmrUcKnp36rYjAxrFIUQ8xa4PoePxZCaxn
	dEzHBAd7R/q+9WlV1KzAon0h9GCiwBqvF+tFm2M7NzMnkIyY/q2Cyxd/ge/lnwhQ7QvA/90dhPB
	mO4coOCTyQ/mjP2KeqmvzZ/+mza1iMBY8yuTH
X-Google-Smtp-Source: AGHT+IGXC8lezvXLfyLFgurkGO2/8+xbMmbLbWU2Dhx0X772e49nOZcLM0/mejcqQER1kvdSNB2vVup4Slt3VEZ2U4I=
X-Received: by 2002:a25:4687:0:b0:dc2:398b:fa08 with SMTP id
 t129-20020a254687000000b00dc2398bfa08mr21101yba.31.1709143520037; Wed, 28 Feb
 2024 10:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-15-surenb@google.com>
 <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
In-Reply-To: <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Feb 2024 18:05:08 +0000
Message-ID: <CAJuCfpGSNut2st7vKYJE7NXb6BPjd=DFW_VEUKfw=hGyzUpqJw@mail.gmail.com>
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:29=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> >
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > +{
> > + __alloc_tag_sub(ref, bytes);
> > +}
> > +
> > +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_=
t bytes)
> > +{
> > + __alloc_tag_sub(ref, bytes);
> > +}
> > +
>
> Nit: just notice these are now the same and maybe you could just drop bot=
h
> wrappers and rename __alloc_tag_sub to alloc_tag_sub?

Ack.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

