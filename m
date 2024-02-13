Return-Path: <linux-fsdevel+bounces-11393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81596853669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360001F26F15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFC55FDB5;
	Tue, 13 Feb 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF2rLyxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D45FBB9
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842753; cv=none; b=rWQTeELfiCR6wzuXFN5T3P48w6MeQsVKa1BoeuAjKJCxconBPEWqtxrQ+cDZOjaubXOsMyIM2HJXXBMDrZxg/J+fp5PRZLaSKNYspVmFQI+yuNXkHhPEA/1LQC9RqkncnfBcgiTRxnUfxrgcQYg2qYsO51JsZDHDlpScsle4QyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842753; c=relaxed/simple;
	bh=1XfUHqbU/50ueZ6381Y6dxy8pCRF8RvqC7cpzOW3vys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KSt+sZFrcjKwQU8ZoyLQVwKsGrz7LnoP1BfvJsnsCT45zFqpzmPFK21LapAkrRZ6GyS7TJ5xd09YIpFloCC2OxCY+drKPjWnBMdwPIKyB0K7IkmtBS6tCxCZBQLehHt2bSNzRZgUtBbJ8jdJ+8XvARTS62U1cNakyZZHK/RS8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF2rLyxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6938C43390;
	Tue, 13 Feb 2024 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842752;
	bh=1XfUHqbU/50ueZ6381Y6dxy8pCRF8RvqC7cpzOW3vys=;
	h=From:Subject:Date:To:Cc:From;
	b=MF2rLyxuySJ0VdLw3AwJcT7x6mMB4W2teXb/h2ICSIu1IKE9BGsHFm+EJEq0QTNCz
	 yRQnlrY3hJG4vm5i3N/uCYFuK1klEmafwi1ZGZ+71uCRotEJEcOzudpfvTbOt1kWgo
	 QX6THNLAIPKchEddRZnUqAr7AuHiAWM55wFAL/zo/3d7YeCKevbP8H/3TfAzWOCcFE
	 N2WnYwLLe8T1KBZJ5IupSj2QIiJxhJyQTj480bpo8PaaNUl82iBa3hUkbARaHKHLgP
	 laKBhgPMrI6fdZlbQJtQ+mKN4G3z27KPJ4NQOGkMj3xhEysb1/W710fdKpQawaJwKV
	 ggWigtlxPQCLA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] Move pidfd to tiny pseudo fs
Date: Tue, 13 Feb 2024 17:45:45 +0100
Message-Id: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALmcy2UC/x2MQQ5AMBAAvyJ7Vqklgq+ISOmWvZR0E5GIv1tuM
 4eZG4QSk0Cf3ZDoZOE9qpR5Bsvm4kqGvTqgxdpiieYMYg72wU8KnWuo7rCtfGtBkyNR4OvfDaP
 67ITMnFxctm+ibfG38Dwvq1kO+XoAAAA=
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1XfUHqbU/50ueZ6381Y6dxy8pCRF8RvqC7cpzOW3vys=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSenrMveWr+LLXGZPW8mcydwdNrt9Wdv5x8jOXwU/sq1
 jezbaXKO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSWc/wv1giMvtN7MQGFdfL
 6fYCKoZFTdUeOzvZ/cUr11/wFL+WwPA/WUs2+lqEvue+lZr9xzd/D7t//XJg7isb413+feVfnwh
 yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This moves pidfds from the anonymous inode infrastructure to a tiny
pseudo filesystem. This has been on my todo for quite a while as it will
unblock further work that we weren't able to do so far simply because of
the very justified limitations of anonymous inodes. So yesterday I sat
down and wrote it down.

Back when I added pidfds the concept was new (on Linux) and the
limitations were acceptable but now it's starting to hurt us. And with
the concept of pidfds having been around quite a while and being widely
used this is worth doing. This makes it so that:

* statx() on pidfds becomes useful for the first time.
* pidfds can be compared simply via statx() for equality.
* pidfds have unique inode numbers for the system lifetime.
* struct pid is now stashed in inode->i_private instead of
  file->private_data. This means it is now possible to introduce
  concepts that operate on a process once all file descriptors have been
  closed. A concrete example is kill-on-last-close.
* file->private_data is freed up for per-file options for pidfds.
* Each struct pid will refer to a different inode but the same struct
  pid will refer to the same inode if it's opened multiple times. In
  contrast to now where each struct pid refers to the same inode. Even
  if we were to move to anon_inode_create_getfile() which creates new
  inodes we'd still be associating the same struct pid with multiple
  different inodes.
* Pidfds now go through the regular dentry_open() path which means that
  all security hooks are called unblocking proper LSM management for
  pidfds. In addition fsnotify hooks are called and allow for listening
  to open events on pidfds.

The tiny pseudo filesystem is not visible anywhere in userspace exactly
like e.g., pipefs and sockfs. There's no lookup, there's no inode
operations in general, so nothing complex. It's hopefully the best kind
of dumb there is. Dentries and inodes are always deleted when the last
pidfd is closed.

I've made the new code optional and placed it under CONFIG_FS_PIDFD but
I'm confident we can remove that very soon. This takes some inspiration
from nsfs which uses a similar stashing mechanism.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>

---
base-commit: 3f643cd2351099e6b859533b6f984463e5315e5f
change-id: 20240212-vfs-pidfd_fs-9a6e49283d80


