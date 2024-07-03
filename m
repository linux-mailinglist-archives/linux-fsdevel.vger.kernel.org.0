Return-Path: <linux-fsdevel+bounces-22988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC17924CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 03:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A935FB22C23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CB81FAA;
	Wed,  3 Jul 2024 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwD6txZR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC895228
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968640; cv=none; b=e8Jq8qwgnWGnPVgGtV3L69hcIRma8AQRQHp7ySHPIZRPRiD5exgYSbQGq0UcO4QEVxf/j6DZz39Y8d01HsHOIVaM68gBE5Pr7rvOBF93fKn7lFUlUwhGU6I9/abuYOt+3Hpf8dCmdG763MTLwHfsnQ7vA9dD9hLJlrz6rANzVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968640; c=relaxed/simple;
	bh=N5Ae9rGoE3GKngiy/Tj9+RKRVssoTFMAU66isGG61rg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IDttRSON4JMyH1SRLhRhH4OCUnFEl6zczdsju3OF5kyywep1QLBirMPbJIIz7rXC9uni6esSaFe+bbMYxiZw+zHLDVL6BMihte/Vv5v0oXWNPeUovckA2UcIApxZwkYeRW3aMV/vXrFWp7MUSHcob0xuZowRIM1cghnMVIOYPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwD6txZR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b5588bcafso70633257b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719968638; x=1720573438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FyIaT//Jdg7f/8MKV1vKBRmhvJGqM0s2j18nW8bQEiY=;
        b=WwD6txZR1umu7OaMpP2iHFxLErv67xDOwVw4wkv7/N3RF+aXhGfYwCxgKpLxsu+vdf
         yDjWVsgJsEGaAphCy0FEzILvF23P2FN0yT5+tfCoAYLEtHx24XOnj6j80XpgToXYdmVo
         xLfmQXhYJK3SM/YhAoCs4slP8nMXyqWs8DKvKePUUJ8wjEtNHFXF1HzKWwZCivhxQW37
         mU28kw1QQRzF8LyOS841o645rdVNv7rcMvg24fatFoFMRQhi1Al/s4gpLtHl31Giz6m5
         8xsko30VSys6dYS3s7ncE5YX5/lH2rvZHbW61b5cQ93aF4ELhDtIEyF1LAi8Pn/E3YAV
         9G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719968638; x=1720573438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyIaT//Jdg7f/8MKV1vKBRmhvJGqM0s2j18nW8bQEiY=;
        b=QO6DRl3yFVQHTjw7vdQNXzNnkUmHdDWt9zPpWRgYCmdCWWz+noYJBcemsKfQzU4a8H
         I+hBE8cZ/Wf8qiqqddD0EVgAaUqe1DSHFLoy7XRAa+pWjSlKsYnw1iB/mqRFfZ2TOLHK
         VAoOSNHFAetH7NZEYKKi6ts65IOO5yyC5JR3DMERDp22LHIeGupjzPnp5e1vYQF7fG5L
         GUbAOI/U//ml+JWkEc23lkat6Bw6eIfNHPtlirQRbJH6l7evmQeo6Wq33OA3SO9tWIbQ
         H/k1dN1p6kQkgqBZpNF/d26dffoy9LcrB5LblkIkEVkylvTL2G9VPCsdPCpPHyChrsoi
         KlGg==
X-Forwarded-Encrypted: i=1; AJvYcCWL8ZZxnMAtcOV1esFbXcQAj/e7svSPEUVSlNXsEl5wcVjxqysBvKki79Sjkpjhn4m+v1hWc2PpJujuPRFQsjb81NV/bMqUHhRhYoHixA==
X-Gm-Message-State: AOJu0YwDrIMJweX2HUCq1WYxuBAwy+ADLp7TjjzcWg3aHbWOiILxABOk
	R18nzeaxrurBaQmWw/jLnMuYKRY856Dh/TqMk0OLQVash41rE+GG1lxd6sgKT2wO9AHl27WU3Bn
	krg==
X-Google-Smtp-Source: AGHT+IGV/NvoJUuArfID21GmDZBYGZ36B6phTaS0vo7MrU7Ut8oKdvUBr5uZ4z0FMUGS8o2DHX2qxiyBQyo=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:2ca5:53d1:2309:2615])
 (user=drosen job=sendgmr) by 2002:a05:690c:480c:b0:62c:fb55:aeab with SMTP id
 00721157ae682-6512ff21046mr20307b3.8.1719968637718; Tue, 02 Jul 2024 18:03:57
 -0700 (PDT)
Date: Tue,  2 Jul 2024 18:02:14 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703010215.2013266-1-drosen@google.com>
Subject: [PATCH 0/1] Fuse Passthrough cache issues
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

I've been attempting to recreate Android's usage of Fuse Passthrough with the
version now merged in the kernel, and I've run into a couple issues. The first
one was pretty straightforward, and I've included a patch, although I'm not
convinced that it should be conditional, and it may need to do more to ensure
that the cache is up to date.

If your fuse daemon is running with writeback cache enabled, writes with
passthrough files will cause problems. Fuse will invalidate attributes on
write, but because it's in writeback cache mode, it will ignore the requested
attributes when the daemon provides them. The kernel is the source of truth in
this case, and should update the cached values during the passthrough write.

The other issue I ran into is the restriction on opening a file in passthrough
and non passthrough modes. In Android, one of our main usecases for passthrough
is location metadata redaction. Apps without the location permission get back
nulled out data when they read image metadata location. If an app has that
permission, it can open the file in passthrough mode, but otherwise the daemon
opens the file in normal fuse mode where it can do the redaction.

Currently in passthrough, this behavior is explicitly blocked. What's needed to
allow this? The page caches can contain different data, but in this case that's
a feature, not a bug. They could theoretically be backed by entirely different
things, although that would be fairly confusing. I would think the main thing
we'd need would be to invalidate areas of the cache when writing in passthrough
mode to give the daemon the opportunity to react to what's there now, and also
something in the other direction. Might make more sense as something the daemon
can opt into.

Any thoughts on these issues? And does the proposed fix make sense to you?



Daniel Rosenberg (1):
  fuse: Keep attributes consistent with Passthrough

 fs/fuse/passthrough.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)


base-commit: 73e931504f8e0d42978bfcda37b323dbbd1afc08
-- 
2.45.2.803.g4e1b14247a-goog


