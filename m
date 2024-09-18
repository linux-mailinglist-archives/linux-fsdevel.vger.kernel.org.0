Return-Path: <linux-fsdevel+bounces-29656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C372597BDD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CD81F23C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33801531CB;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/xAPLhF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43130189B9B;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668769; cv=none; b=hBraI8QfXOffT/5WLs0KrRJU4H68T49Oc8VrLExjeGY+8JnH3neg8x/mhO1NUODOC4/Ft+fgb/RTcyJC/BJB7Gvp/sAEYHugJ1B/5cmu7K9ZIyaVWXEAJqTWL8yYVRHyrB68Xsz3biQnFbqVfzvbI40sp1F/MTrpGv+BIwXsbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668769; c=relaxed/simple;
	bh=MWja5gq1myzI/hKB8LURe6H7sCXfI8wL1RS650wd8Nk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N02p6/HgOpo8zMuge1BKjTnt/CRCZHzmZgdlgfkfRPqRmBY8qWKq/rXIV+zlgfmi5Bl1t6oM8AB1ONO5+ANOc/Gd8bKpjr3Crv/YZbLHGvqkzutKQc39RCE75MwQaBbZiWT0XK7gaXaBnHzIWykUeih+K71YhQmVJN+2lO/5dtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/xAPLhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D786EC4CEC3;
	Wed, 18 Sep 2024 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668768;
	bh=MWja5gq1myzI/hKB8LURe6H7sCXfI8wL1RS650wd8Nk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l/xAPLhFIPYiulw8zkkoV9Gei+nkq8POiJk15KsrG1GJEcTd9WaHVzvNYmQYi/R6C
	 4Z1VsM8A3OGE8BbPZMjOUTeY9MLTllWCxqNt90u7/qCWrqi4Xl002OCDt68pBajDbq
	 IifBK+iCEggJY0eBqiGk0W2nMjMl4GGMGTwQNCYpcVORpL/sD2hbf+aOJW9RgtKOpI
	 VWO+LcvMqDuuOTL1s1Qv8e180x87Zvl7bwU8kJD3Dj/9KWTeA5r6YaTYl96TAKAKfs
	 oHBwkxkPmRafFKWWGCzaX33ww6RPB7XPLtYJBRM1nyc045nQO4GY2ZEPGIxAFiNPYO
	 mRiTPtWgTqKWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E38CCD1B3;
	Wed, 18 Sep 2024 14:12:48 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Subject: [PATCH 0/6] Backport statx(..., NULL, AT_EMPTY_PATH, ...)
Date: Wed, 18 Sep 2024 22:12:19 +0800
Message-Id: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMPf6mYC/x2MQQqDMBAAvyJ77koSVmv6FekhbVa7IGlJbEgR/
 27qZWAOMxskjsIJbs0GkbMkeYcq+tLA8+XCzCi+OhhlSFk9YFrdWv58LIyLhG/BDgl/6K7Wk+m
 HXikPNf9EnqSc6xFy1xJmarWF+74frUPbBnYAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mateusz Guzik <mjguzik@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=MWja5gq1myzI/hKB8LURe6H7sCXfI8wL1RS650wd8Nk=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t/cJqKOM6uWkaZUkmOyn7cxe0TFjXwAm+NAJ
 Qt2UNoFUtCJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurf3AAKCRCwMePKe/7Z
 bgLDD/wNnNJSwdDp7lUTdgM0o7IpmdpNVUbiCyQ6k9P90DFf4oBjy3icLJWsec5kK7lpAh+CfKo
 xEV60OI0+9W+LpgU+TP0wYjFUR4r1sOePGEPrwR4EXAkP5sS1HmdByT0/E4koN9k5VrEr5ltBn9
 SZxyVRJ9aOYbPu4nIjEcA4rudQhLHDgSieSeputBvF1/DDAIt/LgWdCJ83gj+Axjy99FXU09w+C
 ZWG2W3shPo7N9Erpu/5AdrR6P7tFvDYYzftyFgpinBarZ83S4x5IGR8eR2bBZR3th7aHwu3h3fk
 0TbtsJ6np8MHDLVrNzeLTQlU60FtGHvy8bUtfrruYBcI5BPMqPeqctlPSVXjdGRWaHrHVHhKr0e
 d1wVkkZuFGQBx5GaoJuD6dN0jifWomgU3sbXLtaBQtIPItt7gxCpNcidZkGBvMOXxBJ+m/o0TSW
 y5RkqKG1OdUla8rLqBfBcFksZ1Ygn4M4mMeSsoc7dH/ZnjHn+hZadCqm/zr5FjNYdiiEdshjmR7
 B8Fr0bufcnK/th+AXIbARaBWycGEcnxNUEsT7YiElxphqWlJVkF5rY8k6aV97qmc8mPgBVjaOy/
 rd4L4/Yf7t7NItQrwIEjmbs5HRz26pz3bv5F2La7z4DqH2CHTJjPw+5h+w5iqYPAw+3+9BU5c26
 IaTTtKQ4+MWns6A==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
...)") added support for passing in NULL when AT_EMPTY_PATH is given,
improving performance when statx is used for fetching stat informantion
from a given fd, which is especially important for 32-bit platforms.
This commit also improved the performance when an empty string is given
by short-circuiting the handling of such paths.

This series is based on the commits in the Linus’ tree. Comparing to the
original patches, the helper vfs_empty_path() is moved to stat.c from
linux/fs.h, because get_user() is only available in fs.h since v5.7,
where commit 80fbaf1c3f29 ('rcuwait: Add @State argument to
rcuwait_wait_event()') added linux/sched/signal.h to rcuwait.h, and
uaccess.h finally got its way to fs.h along the path uaccess.h -> 
sched/task.h -> sched/signal.h -> rcuwait.h -> percpu-rwsem.h -> fs.h.
uaccess.h cannot be directly included in fs.h before v5.7, where commit
df23e2be3d24 ('acpi: Remove header dependency') removed proc_fs.h from
acpi/acpi_bus.h, preventing arch/x86/boot/compressed/cmdline.c from
indirectly including fs.h. Otherwise, the function set_fs() defined in
asm/uaccess.h will get into cmdline.c, which contains another set_fs(),
resulting conflicting function definations. There is no users of
vfs_empty_path() except stat.c, and as a result, putting it in stat.c is
acceptable.

The existing vfs_statx_fd(), which is removed since v5.10, is utilized
to implement short-circuit handling of NULL and "" paths, instead of
introducing vfs_statx_path(), simplifying the implementation.

Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
Christian Brauner (2):
      fs: new helper vfs_empty_path()
      stat: use vfs_empty_path() helper

Christoph Hellwig (2):
      fs: implement vfs_stat and vfs_lstat in terms of vfs_fstatat
      fs: move vfs_fstatat out of line

Linus Torvalds (1):
      vfs: mostly undo glibc turning 'fstat()' into 'fstatat(AT_EMPTY_PATH)'

Mateusz Guzik (1):
      vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)

 fs/stat.c          | 58 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h | 26 ++++++++++--------------
 2 files changed, 63 insertions(+), 21 deletions(-)
---
base-commit: 661f109c057497c8baf507a2562ceb9f9fb3cbc2
change-id: 20240918-statx-stable-linux-5-4-y-a79d4268600d

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



