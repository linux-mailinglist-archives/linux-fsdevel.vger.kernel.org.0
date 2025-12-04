Return-Path: <linux-fsdevel+bounces-70631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82BCA2CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 09:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B335C3078E84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9933509B;
	Thu,  4 Dec 2025 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="i+Kzrv5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97344331A45
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836745; cv=none; b=mwjcVY0eZbXXy66/mo4054q4Fg0OQRD6dAlZnlOmnK9ZXNDaOyhHz09JGYWrCp0LzAltNpzX/ldWgqkAuyUpyAEQ10vDB3N9Z9Hj53VGlBP88yJOpMG/uioWtfIkEwCL1/DzhQPaEtej48tEJVpRnsTqajt3F8SZDa1LR4T1w0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836745; c=relaxed/simple;
	bh=5Y0G6jnckk6R9YHYvTndqG1sm6ZB1/5Jdl3C17u0g7A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tVL/RSdF6OPEYxOy0UPVD1TgPUo5vQbJgjkruENEbA5AfLAq3/ji/4yhFmI3QDC2f/qbnHLIIDATYrfROe9G3PQzI8XfrEJMokOv4annMfjf21wWofBkh+U6gEJ8B8sGEKMwDe1KjZYH1nxYBPW9nyD/pjGSHPvEpJVu8lPT2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=i+Kzrv5x; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8823d5127daso6019336d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 00:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1764836740; x=1765441540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6R2HDalVGtisOhDGntnNlRJliz2gFgzU87u5ulGCRDM=;
        b=i+Kzrv5x3wbGyakrEQRXk9yqlrtNDYRJyNYuWsVX/B0do/7Cg5t9mSBiWizPeCuja3
         OYV6Qu4T2KIMcg+7UFA79r/TN5xHtYJgbGvHlOCjFV0ulxe36tlK2XQgjbUGrYlHutRE
         jSMc47urgH7J0UzRIrhgpCB6+4+3RNT6OThmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764836740; x=1765441540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R2HDalVGtisOhDGntnNlRJliz2gFgzU87u5ulGCRDM=;
        b=AZhsXXHQeHUHKFNWQnHYmKqDoEG4Q5w2fqoF0zQmZWXX8RW79+GmPRcmCyv6vp+g8Z
         k80wiMRapd4+DQizXZkPuMTv1hkDXYBFWEYBiqi4rFl7vOSn3yVLDAv0lsCI7iB177G0
         vMUJowYpF3rKzIy3VjyZT4ElyVKg4K03bkCjZ1VN5RkpWh4B/QlI3VK3qEcHlQ+tHbj6
         0mCiczIAYe9BxdsmVDH/xPIYM1tEoj/SRkl45SD46ohmkLsHDQa23Bao0krMDt2te/zP
         jFyCD0go2RDdhNOwB6/Q1IJ5fijd7Vf/ypY7jzvqXKpy3AbdENzVcKhLngbqeZCbZ/FV
         7xMw==
X-Gm-Message-State: AOJu0YxLxmlLlJ86jJZISeWMHrnJjRRDQADqQ4ygrTX9IEfARpSmIrYH
	6TV+baAR4EDjcXg5SU4qBeoANtcRnyc3dLhFEO5bZnvTDUiCN4GHhiYZO+TCABxfsfK7aer/FBh
	H/zxLEmCLWczOHz7SqJUSvxDMpiMOVdIma2aH/A6QyFAPsj5C4Up+bwjMTg==
X-Gm-Gg: ASbGnctsYWtvgLrRvNCxRHedTNZOw95xG5V0eh7fEsLSuCemOkBIsxyMSt2z18ZgHIL
	Ter+usZw78HL2CqLp65XEfkksnLmlQU7MSyGb9VaSMu0/kJtrFMAZ6qxwrhIFD+ivHOGMRlipGx
	BZa92G8HCCYMXcgS1uBEmWoNOQ3CwBUn0CiDmphISQdvhIfV73DzU7HpI/15Nq6XNBHj493YVTe
	KoP1/BmaNnbl9ZATWFPJ8J1uYmhBsomtbQO4ZWT+oHoXuIuZS/nEgblcyeKLVuWlOyE8rlgC4pi
	TpKwbQ==
X-Google-Smtp-Source: AGHT+IHu6LdWauWfDNMPSsGH3Tvtq5es6PRLFuNYhH3pWfed6yTnpXg31sM0l5QgIGbI/8JK6EZqo3Rat0YPS95w9zY=
X-Received: by 2002:ad4:5741:0:b0:882:4987:360 with SMTP id
 6a1803df08f44-8881957282bmr83477606d6.62.1764836740320; Thu, 04 Dec 2025
 00:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Dec 2025 09:25:29 +0100
X-Gm-Features: AWmQ_bkpwlxNSRF5UdbQwiHzE55DPskFSCAWo6KNca5tP4NyP7m8UqM4yu5GATE
Message-ID: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.19
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.19

- Add mechanism for cleaning out unused, stale dentries; controlled
via a module option (Luis Henriques)

- Fix various bugs

- Cleanups

The stale dentry cleanup has a patch touching dcache.c: this extracts
a helper from d_prune_aliases() that puts the unused dentry on a
dispose list.  Export this and shrink_dentry_list() to modules.

Thanks,
Miklos

---
Bernd Schubert (3):
      fuse: Fix whitespace for fuse_uring_args_to_ring() comment
      fuse: Invalidate the page cache after FOPEN_DIRECT_IO write
      fuse: Always flush the page cache before FOPEN_DIRECT_IO write

Cheng Ding (1):
      fuse: missing copy_finish in fuse-over-io-uring argument copies

Dan Carpenter (1):
      fuse: Uninitialized variable in fuse_epoch_work()

Darrick J. Wong (1):
      fuse: signal that a fuse inode should exhibit local fs behaviors

Joanne Koong (2):
      fuse: fix readahead reclaim deadlock
      fuse: fix io-uring list corruption for terminated non-committed reque=
sts

Luis Henriques (4):
      dcache: export shrink_dentry_list() and add new helper
d_dispose_if_unused()
      fuse: new work queue to periodically invalidate expired dentries
      fuse: new work queue to invalidate dentries from old epochs
      fuse: refactor fuse_conn_put() to remove negative logic.

Miklos Szeredi (1):
      fuse: add WARN_ON and comment for RCU revalidate

Miquel Sabat=C3=A9 Sol=C3=A0 (2):
      fuse: use strscpy instead of strcpy
      fuse: rename 'namelen' to 'namesize'

---
 fs/dcache.c            |  18 ++--
 fs/fuse/dev.c          |   9 +-
 fs/fuse/dev_uring.c    |  12 ++-
 fs/fuse/dir.c          | 248 +++++++++++++++++++++++++++++++++++++++++++--=
----
 fs/fuse/file.c         |  37 ++++++--
 fs/fuse/fuse_dev_i.h   |   1 +
 fs/fuse/fuse_i.h       |  28 +++++-
 fs/fuse/inode.c        |  44 +++++----
 fs/overlayfs/super.c   |  12 ++-
 include/linux/dcache.h |   2 +
 10 files changed, 340 insertions(+), 71 deletions(-)

