Return-Path: <linux-fsdevel+bounces-12357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BC085E99F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C02FB234CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D993126F21;
	Wed, 21 Feb 2024 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JqGo42K0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36486AE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549904; cv=none; b=K2TPH9w69iL2cs06CvY00n34YaLmSfSbwHZl7l1asxdYYUhPDnhrcfwDAf+YEp1YIfD5dOYVImVy+WtA9vZoXDM1XaYS/y68ugqKDB3rI65WtsuYs4lMNDQON6v3suwr69YKAUwNUd9f2nZ8d3CJ6f0DD8LiTF+ReJQ6w/RJuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549904; c=relaxed/simple;
	bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfSAEkNpvtEtUv3vIXalvtk7xRf+O8hSUnhp1DQK4hj7l4dV9MiNC4FIM9LOcsZuEgZdRr7+FLR2gVmPSSzVDvcm25YaWNUUys6cY9LkAYnmR09pU99PwZznKGX/bVaXwvihB7b+nxTBlTJPS3VZk96nKhnedzyUlS2lR5YyHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JqGo42K0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42e323a2e39so1533881cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 13:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708549902; x=1709154702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
        b=JqGo42K0IIZzOOrr5BR0MyClkvN7YeDKWCfNCwv/TokZY3MsqLl3j3ldqGJ1DPOTLO
         +ynRcDLGtUomnUMTZ92ie0J+88VL3PPuba2doqpMATUePt69slO+v2jfkeCM/L3caohU
         AeG2b3uqOSss4AobANVRw0xACblRms2znrJNVRRYzWYzlQNntI81UNGjjllb1CbseJO+
         N5i/i8NwBc1feIOuQ2opLu+f0BT+qsc6jM9KE2S1K2qtVlS5Xp/f5v14BZOnLMry7Kn8
         4tDyWcKwiYHiwjWzVgAwB5bfsWEsGCzJrLNPN7Fdp65xZT7Psx1y8sljX3hfAzQWWuk3
         NjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549902; x=1709154702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
        b=tgKDFYuh8XUbgai2MZVxV2hw0TudsgDd8DIwiYYBuCbhjJwRqUJQg5fnsDYlNLj23o
         4fuRMq28ZhPT/s+3B/7K1G56cAxw1G+MOttB3M4SqTQ6GppHNDhdgxOUKuQ9BntFrmVh
         j78kRQkVd5kz1f/VdBz+KtNyDtUgs4baQb83xG/MjlQONHRAz79eOQuZy0sgJOqEAWbH
         2xb3NJHnZa+EX15hfQ+JWiZP4dR3nMj2Zme4Cp5H//zNtRipwDN+Sy2iCmCF/r2AErk/
         SBRiT8cZEzNWVl1SsrCL8r8RDIWjzVXGVI6f/ZxepU7b2szmEeGhrMtMpz49i1MWawph
         dwdw==
X-Forwarded-Encrypted: i=1; AJvYcCXAdu12amPzmmsrI+w+qkuLnhEZigWd+N6XLi4DnLNr9AxfkEZ8Fb3FrmNXbow0nKeZD6c522SlsCqm/E73aI/U03zaGrnzurMk35hUCA==
X-Gm-Message-State: AOJu0Yxe4GhyAVp01CC3d1bCYPosvwK+lCSavB/b1usM/kUmFLY8wLx0
	4icrgc+YHBkbRGb194UrFUt4ekea4492Pm7g69QElCm2XTMjhKrdd4gwQx2+EpW8W+/xFi0rj08
	5jL/kstswasEHLdc7zsC3VVpIOnIa/9IBS4M9QA==
X-Google-Smtp-Source: AGHT+IEHXmwL8Aza8YxstZPNawifsEoPmvz+hNBFt6a/ALIjCAdVsEQDIakNnjXyrMZE7cImyXSV0z0ORZ0TJZY1zT8=
X-Received: by 2002:a05:622a:1a0c:b0:42e:3f7a:819b with SMTP id
 f12-20020a05622a1a0c00b0042e3f7a819bmr1401231qtb.8.1708549901753; Wed, 21 Feb
 2024 13:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-3-surenb@google.com>
In-Reply-To: <20240221194052.927623-3-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:11:05 -0500
Message-ID: <CA+CK2bAs4t1UhLBahnG9GmFYgW2KxdO7PZkPwD4Wbv7oE+aMhA@mail.gmail.com>
Subject: Re: [PATCH v4 02/36] asm-generic/io.h: Kill vmalloc.h dependency
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
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Needed to avoid a new circular dependency with the memory allocation
> profiling series.
>
> Naturally, a whole bunch of files needed to include vmalloc.h that were
> previously getting it implicitly.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

