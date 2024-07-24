Return-Path: <linux-fsdevel+bounces-24194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D8193B168
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35DA1C232BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF31158A34;
	Wed, 24 Jul 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jczVHM8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CC157A59
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826970; cv=none; b=rFDu6xHCSlh3FkZI3FrxSIoB/9vBvhVRi/jXUzucm8LRpSsnXka4wSU7KuPVj1AAF8ZgvCpGR/F8FKbBDXcqAhbwXtrMABFCmMQdoLJyKMx1KqoIFnpYkWSVBbyULklL9QrgJqjll1+tGPHaoHryR2jVomKwQUFmJSKsG4SYoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826970; c=relaxed/simple;
	bh=A8fzrbGyzrgvy+XXVMIyFYIj9GfZkQuQKyiT1Yy3BOM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A49EitKQQhaKXtSUIHcNplGMs81WgSLbwjm+KmclCjwTqxJHH5f0zxbJgmYgfvrJx3+FZdfdWopKN2mKlHABKJ54qj0KFLs+K9eRF5hhkDct4BslPtyeyVJR/xIejUId90nx1P55FRPfEtDCXU+fEVMKogLnf+8Y4H+hOh8FTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jczVHM8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D671C32782;
	Wed, 24 Jul 2024 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721826969;
	bh=A8fzrbGyzrgvy+XXVMIyFYIj9GfZkQuQKyiT1Yy3BOM=;
	h=From:Subject:Date:To:Cc:From;
	b=jczVHM8p75lMiFLJAIMUDgqpaSf2FyBmUemgbU3LPJNBY47g07FWE7bCE9Uc7HD/m
	 XUYIptp4Dd2dD+rpLKXdIsE1U7q6dr5kNYIq7JzgNNEjMWDKV2FZfQT8nD7Ka+ar7u
	 pHkHJ2S/yCdW/vuRNXtCthEyhxO7cBXLtXuMRbT8aasY1SF1U8y2bAGKOzgZLDqs6t
	 gaDKkke+srj1r/jgScb6wc8epnLP0japXj9wTVd/gpqZdhISjBrTwyNoQvIaofch3D
	 WOuG2genM8jAkT32xe1JsGqBtJZ6NBGQKLOA4P5CZHnN36EH81/tZS13LnGUuzzx8Y
	 Rh/ZLCg7bKMwA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/2] Add an fcntl() to check file creation
Date: Wed, 24 Jul 2024 15:15:34 +0200
Message-Id: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHb+oGYC/x3MQQrCMBCF4auUWTsSh0jQreAB3EoX02Rig5qWS
 alC6d1NXf4P3rdAEU1S4NwsoDKnkoZc47BrwPecH4Ip1AYyZI0ji59Bnxh9nl54CsRM7sgxBqi
 HUSWm7x+7w+16gbaOHRfBTjn7fnPeXCbR/cahcUgW1vUHhIPFIoUAAAA=
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3081; i=brauner@kernel.org;
 h=from:subject:message-id; bh=A8fzrbGyzrgvy+XXVMIyFYIj9GfZkQuQKyiT1Yy3BOM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQt+DfNp0J8wr/X51TvJku8cjKpVboR3Np9+xZj2hGWm
 Y91s75+7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiILRMjQ2+QWfav+HNM0w8b
 Pg/7GXm0bNaFC82HeZ5OylrzuyRwNi/Df/8bb3/dEUxtqDwuqne8w2edTHPBnVuRC88uEd6Z+/n
 MBn4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Systemd has a helper called openat_report_new() that returns whether a
file was created anew or it already existed before for cases where
O_CREAT has to be used without O_EXCL (cf. [1]). That apparently isn't
something that's specific to systemd but it's where I noticed it.

The current logic is that it first attempts to open the file without
O_CREAT | O_EXCL and if it gets ENOENT the helper tries again with both
flags. If that succeeds all is well. If it now reports EEXIST it
retries.

That works fairly well but some corner cases make this more involved. If
this operates on a dangling symlink the first openat() without O_CREAT |
O_EXCL will return ENOENT but the second openat() with O_CREAT | O_EXCL
will fail with EEXIST. The reason is that openat() without O_CREAT |
O_EXCL follows the symlink while O_CREAT | O_EXCL doesn't for security
reasons. So it's not something we can really change unless we add an
explicit opt-in via O_FOLLOW which seems really ugly.

The caller could try and use fanotify() to register to listen for
creation events in the directory before calling openat(). The caller
could then compare the returned tid to its own tid to ensure that even
in threaded environments it actually created the file. That might work
but is a lot of work for something that should be fairly simple and I'm
uncertain about it's reliability.

The caller could use a bpf lsm hook to hook into security_file_open() to
figure out whether they created the file. That also seems a bit wild.

So let's add F_CREATED which allows the caller to check whether they
actually did create the file. That has caveats of course but I don't
think they are problematic:

* In multi-threaded environments a thread can only be sure that it did
  create the file if it calls openat() with O_CREAT. In other words,
  it's obviously not enough to just go through it's fdtable and check
  these fds because another thread could've created the file.

* If there's any codepaths where an openat() with O_CREAT would yield
  the same struct file as that of another thread it would obviously
  cause wrong results. I'm not aware of any such codepaths from openat()
  itself. Imho, that would be a bug.

* Related to the previous point, calling the new fcntl() on files created
  and opened via special-purpose system calls or ioctl()s would cause
  wrong results only if the affected subsystem a) raises FMODE_CREATED
  and b) may return the same struct file for two different calls. I'm
  not seeing anything outside of regular VFS code that raises
  FMODE_CREATED.

  There is code for b) in e.g., the drm layer where the same struct file
  is resurfaced but again FMODE_CREATED isn't used and it would be very
  misleading if it did.

[1]: https://github.com/systemd/systemd/blob/11d5e2b5fbf9f6bfa5763fd45b56829ad4f0777f/src/basic/fs-util.c#L1078

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
---
base-commit: 933069701c1b507825b514317d4edd5d3fd9d417
change-id: 20240724-work-fcntl-9d2aa275affd


