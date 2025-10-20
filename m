Return-Path: <linux-fsdevel+bounces-64777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954CEBF3CE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8CE18C0849
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F3C2F12C3;
	Mon, 20 Oct 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1JZPQGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363412C0F7D;
	Mon, 20 Oct 2025 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997679; cv=none; b=XDFRRz5I10q5dmlLNhqOV5pQ1HhFTJlzz9HW1S81XKqTQ2zNN1WtgFmjIwLg44lYM7yTztXEFFZwbr/OQdfA5fHs1s2gIVlskPMLPnTbgBS6Vxv+GklMGCQdvNTUEjMkye+iyeGMlcfrbNCxpx3MRnFi9EEz9imKN6RAqWaOeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997679; c=relaxed/simple;
	bh=FqAKHZqMuzDEW10o2dQqCkhBLpLFxrSKB3g8MqH8eaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEyx4rfd1VZM0Sv0Sg1dQ/98XBes9JaTfN+2Ppbz7u7jlr0boHGKCwj1R66IjBZOsL+YB1xvIBP+WT5wqWT4TNPM9q72ycOkdNhpcjFm/sQwribmVW3pO7iiPaplmIHro0MJPIHH6A+eLh4cv0Uhps0C6h9kJQd/ZTemwvmTRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1JZPQGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9180C116C6;
	Mon, 20 Oct 2025 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997678;
	bh=FqAKHZqMuzDEW10o2dQqCkhBLpLFxrSKB3g8MqH8eaY=;
	h=From:To:Cc:Subject:Date:From;
	b=X1JZPQGZH7GkB5HYIL0MyTpX3qJtK/+0UJrqW8trTtSmpDcnuWo/WEUoSi0oe2582
	 Gwjr2vkm61sKZa1eYnfPRIjyomx6lkSr05zdTMLbwbgaq9AUi248/xueLj/3lDm3vK
	 0FIGLChmdoLVhSoU+mImoKPvjcwjTzEbgUSf9zAhA+dFWi5KxE3yUWDWoz5SNp/HpW
	 V1BrvGJ4jNXa+CZJ9pc02JKGTIVxjHKNl94TKnSvsR6TKdYvDACgQa7i1HS6XJw/Rv
	 BzuOOrznFdKXWHW/5bB8oMXYR69mttKKkc3rRVjnO5zE6+fa61WMKpumneE5egctIk
	 auaaQzlbVXseQ==
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Tamir Duberstein <tamird@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	kernel test robot <lkp@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Yafang Shao <laoar.shao@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Christopher Ferris <cferris@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] compiler_types: Introduce __counted_by_ptr()
Date: Mon, 20 Oct 2025 15:01:14 -0700
Message-Id: <20251020220005.work.095-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=kees@kernel.org; h=from:subject:message-id; bh=FqAKHZqMuzDEW10o2dQqCkhBLpLFxrSKB3g8MqH8eaY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfNmpPvjlDMiVQ40QYGzu7Z5sma+pZe0fZ5ISikEJXt o9btT06SlkYxLgYZMUUWYLs3ONcPN62h7vPVYSZw8oEMoSBi1MAJrIkjeGv6Lo0tg07mVJ7tgUF bOaL4RFl//7mluGm9t7MlzxZ8/b3Mvzh+mZ7Qv/wzb469UrVlbffLNZlPz3/lf/B+4G35jQo+/v yAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Add the __counted_by_ptr() macro for annotating pointer struct members
with the "counted_by" attribute. Add LKDTM test, and a first user.

-Kees

Kees Cook (3):
  compiler_types: Introduce __counted_by_ptr()
  lkdtm/bugs: Add __counted_by_ptr() test PTR_BOUNDS
  coredump: Use __counted_by_ptr for struct core_name::corename

 init/Kconfig                            | 11 +++
 Makefile                                |  4 ++
 include/linux/compiler_types.h          | 21 +++++-
 include/uapi/linux/stddef.h             |  4 ++
 drivers/misc/lkdtm/bugs.c               | 90 ++++++++++++++++++++++---
 fs/coredump.c                           |  8 +--
 tools/testing/selftests/lkdtm/tests.txt |  2 +
 7 files changed, 127 insertions(+), 13 deletions(-)

-- 
2.34.1


