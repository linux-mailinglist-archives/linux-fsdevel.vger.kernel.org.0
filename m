Return-Path: <linux-fsdevel+bounces-45434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35399A7793F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04E916A9C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AC91EF0BB;
	Tue,  1 Apr 2025 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Nvyh6TOI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A201F0986
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505370; cv=none; b=D2xaoZjVMYa0qrQ49vfajUZJzjXSOvmLpgginD+K7xX/JH6izI3GjJA6VuO0AtbRH2k1+Zdh+/MZpGbxcjqIqKCLTTumLOJ0spzyQ2EPj5gitPS1I/WMkvtJrxkyZ0OX7EWCgUjCNZGLKRa15AYGliKoe430v/EufG1HaOjarpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505370; c=relaxed/simple;
	bh=91I7VCwI2OaO+lKf2oma9fDOGHKZ0uGAqM9i5HzTw+s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TsLVs4SnPrKgr2wR0Fn/s3bPUxt5E5pj+GxuWkhvuPpgzum0Rljx6K272YQc9wkJcEWnODehTEYRJuYFG2bWXcGiSkhNv8lEYdGrHawYWpUGuOAgg1QVP8A0OgfhnxMCYjDOHc6t+EqUN17kXXWHdI22earmNNOiBF1ANj/X2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Nvyh6TOI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769b16d4fbso29971941cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743505366; x=1744110166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eZLpPVcVgTYBqMo2PsNN2kP6ptf4HAnoNVh2L3glhRc=;
        b=Nvyh6TOIC4wPGZJo6k/wfjCaz8vADPIrxxaN9s+mo1M+1/u9dbH8uH9OGd1pC0RsCR
         lZLYzPmhm+RiYVDmh80Y03YDWsz3gbpVfuD32HTu9+qH4hqTkZ4toxusu2f0SDL73K01
         29mpXti+DgXWvuHngJkXIViV6ixrxof4jOMQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743505366; x=1744110166;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZLpPVcVgTYBqMo2PsNN2kP6ptf4HAnoNVh2L3glhRc=;
        b=Jnli8j6bmg4FSbobjXeQEZLHpzUv96e0FGpFAzps0E18vK0tjl2hA5hdEejQNmPvLe
         Y3yA5YOQYjpv7d8EtkIVwYbrm7LmyFvap6XyhjYD7Pa8O2K03FO3CofMuXFAMGmJNcsX
         NrsPogCUajo+ASodg07RdMcw7de5S4BTcIdF8yuWfmgfR0X1tlB3Kv/WYSmImLSZLZhe
         SguyTzdonRPWL5SxB/xJEOCirDakdEZkwjDyGUHhVgahoOg8V7lvDdCsJH+c0Yx+ikL9
         UZDu8Er/cgN4v+h/FCdQZmwEJeAixH3FL5M4zn9ExefC+CybpesaMse29AfP1Qy6J8JO
         16sQ==
X-Gm-Message-State: AOJu0YxZNAM6h/R+ksqT1n9cz9EWAdBXrQk99ZSCSFY1GvN9UxhPInZj
	Btoy2Ekf9MoydWDHYSO+Xv/8SDSSBSIKxXnhhwHCI1P/yzdw2DgWtLeJ7GikI9A9EpJrylzhJLz
	33uFVMvSYKMKToZc01viQmubpQeiVU0gCgyXkJg==
X-Gm-Gg: ASbGnctII+YLs7/msBDm3i/skKSHB6zI+V7TzxeTSaUJVeqB5IVSBIVc8oT9HSAwwwC
	FnF3vGYfQo4kLOiE0CDtOEBF4zBF0GVYoYnB6zFvB/VCtjHIaTBlsUEv4DFrDEZO4shtRF97B1+
	lVDOYX4Ux9mlGStvHn8RxA0qnXtw==
X-Google-Smtp-Source: AGHT+IFPzf50qEAiKAO3bJ55C+KdbNpjVoY2R+/BGwqhN6U1ohO1vzS/251ziWBwEk//3hNtrSTEJhH7mHBWNV/lxF4=
X-Received: by 2002:a05:622a:11c4:b0:476:8a83:960f with SMTP id
 d75a77b69052e-477ed7cbda0mr170062431cf.17.1743505366268; Tue, 01 Apr 2025
 04:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 1 Apr 2025 13:02:35 +0200
X-Gm-Features: AQ5f1JphLYzOgtO2AjzpTqDO3lmO0DAlyHRcxy5cT4T4ZmLJYDIHHwELhtEkICw
Message-ID: <CAJfpegsQDTYsEWHMK9skpNzUO=GA_DR7zGHftyO2sZH5wjaZLA@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.15
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.15

- Allow connection to server to time out (Joanne Koong)

- If server doesn't support creating a hard link, return EPERM rather
than ENOSYS (Matt Johnston)

- Allow file names longer than 1024 chars (Bernd Schubert)

- Fix a possible race if request on io_uring queue is interrupted
(Bernd Schubert)

- Misc fixes and cleanups

Commit 1dfe2a220e9c ("fuse: fix uring race condition for null
dereference of fc") in this queue has already been merged into
v6.14-final through Christian's tree (commit d9ecc77193ca).   For some
reason this causes a merge conflict, the resolution of which is to
just take the version from this pull (i.e. remove the atomic_set()).

Thanks,
Miklos
---

Bernd Schubert (3):
      fuse: {io-uring} Fix a possible req cancellation race
      fuse: Allocate only namelen buf memory in fuse_notify_
      fuse: Increase FUSE_NAME_MAX to PATH_MAX

Joanne Koong (4):
      fuse: add kernel-enforced timeout option for requests
      fuse: add default_request_timeout and max_request_timeout sysctls
      fuse: fix uring race condition for null dereference of fc
      fuse: remove unneeded atomic set in uring creation

Luis Henriques (1):
      fuse: removed unused function fuse_uring_create() from header

Matt Johnston (1):
      fuse: Return EPERM rather than ENOSYS from link()

Miklos Szeredi (1):
      fuse: optmize missing FUSE_LINK support

---
 Documentation/admin-guide/sysctl/fs.rst |  25 +++++
 fs/fuse/dev.c                           | 162 +++++++++++++++++++++++++++-----
 fs/fuse/dev_uring.c                     |  47 +++++++--
 fs/fuse/dev_uring_i.h                   |  18 ++--
 fs/fuse/dir.c                           |  11 ++-
 fs/fuse/fuse_dev_i.h                    |   4 +
 fs/fuse/fuse_i.h                        |  47 ++++++++-
 fs/fuse/inode.c                         |  51 +++++++++-
 fs/fuse/sysctl.c                        |  24 +++++
 include/uapi/linux/fuse.h               |  12 ++-
 10 files changed, 358 insertions(+), 43 deletions(-)

