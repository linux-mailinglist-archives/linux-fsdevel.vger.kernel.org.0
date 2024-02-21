Return-Path: <linux-fsdevel+bounces-12361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC685EA16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92425286DCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3077127B65;
	Wed, 21 Feb 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="CD/Z8BK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3A1272A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550658; cv=none; b=R0ozQwdIELBRG8E5xz008QLsYlCKlvdOKtAGC4I1WMmhRv6BrfVCcCAunoOd7zkuVCgeLFBqjKCIBMEDvWR6hts6Xxui2myj4kMrCZfkPbMsvfqEY4u3Wxc0a+Wvy/JpPoRD2sz6F8EstejPvC9nuZftqcH2hCYvWHId7hz+B3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550658; c=relaxed/simple;
	bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdNXWjVHWX6BLrVXG2k6tDpZqVRViXsfTWjCo6NfkfIzfUaau0yY+5RFGLnu2Wc6x9GLsU4sWaM+Rmpj3H9KXpSYIreCbw8TLvILdZcn3oi2O6i3WAmxuttQ0k9O7gdAzgKmMDmth41YLxgixrwxv5kly2rcnj9LDwd15iXnvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=CD/Z8BK7; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2ddc5f31eso3120970a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550656; x=1709155456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
        b=CD/Z8BK7Rp9L3i5Vl3s2KolMt7yZM3Q7SV1NrREyMTfzFMVwamp0srcydy69ptyQJn
         QXSSqU31Y95owRZ167SQF3FdA3AuKMFckDCDMgq52UyBL2DglRABg7BatfCiiEhFvdrs
         50eRs7e0ctmnkZhCHUQIzE22K+8+RjFGVMUOfer6IBBrxibv9FJqB8lZLekkBAUHlrcK
         fK7XYKOrVx125m1pLAnDgz7S9JgR3h0CmVz/xvIlHXzYcZZ/DjgPKtk+CPQ9SH3PAId+
         nvooirTukSELTOSVm+fMpwLm+WfP74t0mos9xXu9O7qBhtlU34sLNfg9keaEfyE0eDHQ
         a3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550656; x=1709155456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
        b=Q/UiKDI3aiH6LG4i70ccWgJxkX+VEu3z1HdlSUFyh6HbtCHCB4d85FOur1BZEGbB4V
         o24wO7HQh5ulJUsQHXy6ddr5xBUmrjN36opZS2NI6jVYLZWM8cGM7FNkz8paacS0LICn
         0HXl28Du3dg8AFA1FE+FrKiZPAE5mb9TNyA5mfOKPx4wtA6uEMnKIsyC4cmTAy3FL9I8
         8z0FLhBcJWJkecP249nW7nI93UaanzceI7k8GcTC1CWkUYcpXpSFQWI7En+I2NJQyKQF
         MysaKClQb6rigf4Y0Ceo75d4Dhc20TCJk47aMexPhDcp7WYxwkvhfeXSOrMD+K7NflNJ
         X86g==
X-Forwarded-Encrypted: i=1; AJvYcCV8GTChaWHOI/cLR8lBOhuh4DIZgL5iaj7vhw7XsTPyBXFRoZ/m9soBGXG6snZINxoejlAGugnaH8WSwcsPmilxXoCl3UPglRfO5VYIJQ==
X-Gm-Message-State: AOJu0YxpKUUMybnK/ySNB/YnQkZBH+E5Xt/TOGWm2LZ08iuX0qczF4RN
	lxmvxiFyujWotxCgvDdJfGRl+EVslloONB/2AyeVlgkEA1HtD96IQcXTFpEd+CzsYAxoLaopWCf
	+TrWijPCwE3+AP4I8mMD8JM8jKCLzzKiTjtzNcA==
X-Google-Smtp-Source: AGHT+IFvWKjWPK3amI8VL9W53BBk35ttzb77PzRBdxcUJJDHyxRlktLp+XaDhvA82AT8l0qmpbPOUDFRSVqjGiC7KOY=
X-Received: by 2002:a05:6830:1005:b0:6e2:eba0:ec4d with SMTP id
 a5-20020a056830100500b006e2eba0ec4dmr18796951otp.33.1708550655819; Wed, 21
 Feb 2024 13:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-6-surenb@google.com>
In-Reply-To: <20240221194052.927623-6-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:23:39 -0500
Message-ID: <CA+CK2bAAzRfsDYG+LVvp9LAJLpJoakhTAB3i6JiGDogvz8kfHg@mail.gmail.com>
Subject: Re: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> We're introducing alloc tagging, which tracks memory allocations by
> callsite. Converting alloc_inode_sb() to a macro means allocations will
> be tracked by its caller, which is a bit more useful.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

