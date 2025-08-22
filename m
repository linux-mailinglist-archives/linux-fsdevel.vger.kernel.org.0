Return-Path: <linux-fsdevel+bounces-58846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2914FB32117
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1359F7BC0D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6C31A063;
	Fri, 22 Aug 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hG5HIpVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24531353C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882502; cv=none; b=ER47jTuOVMRjDexfhDDYdrEx+r8OjoNddW/iE/hpUKm6gL2LtCZ6/r8MlvnTQ7+sGd4T8ArewT+0c/Ovaw0RPgXhKqd+75gxEa+2Cu1Lyk9hwe0mZ6eycXs/9EgxFx5uABMhI/WPBIR7FnLGvgOBHgl61MTiFeeYmeZNXuZqXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882502; c=relaxed/simple;
	bh=V2ZTsarFg/J8E5OaQui6bJ/rqih15nGa1jJfmYgVI1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uhSXQ9lHyca8oZ0FJiIHQx6Z5EP+mx2VzqRvOxY6FaGxlfIVz4fH6LKx6112vO+utKt/tRqx99JFasJ46oExWuX4swe4DcsqDTDNVVFp6xr6CemAYmc0o7T5Mg0CeLwquVlebO0aKXHsjqGZ42pMWRMotRSh/DkMc/KDJnB5hmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hG5HIpVS; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c7mpy134kzxXK;
	Fri, 22 Aug 2025 19:08:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755882489;
	bh=NUlPE+heYCOxk91D6n6N1q+wkFLg9BAFfbEyk2M2p7s=;
	h=From:To:Cc:Subject:Date:From;
	b=hG5HIpVSutSZRtsFd06T355DYxH9qGfeUrqxCfDId/uv7nj6uXVjPRBf18tBMYdh4
	 J6MiUTTm1h4vs8d4xuZbZYXJlYRjshhhkRv5DqPl8As0hFQMoU8Fji4LbbavOEzeD6
	 pu8JGqfHl0XehVrNxAaaC0/jXXueFPe5Q8Oj6srA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4c7mpw1MlWzprv;
	Fri, 22 Aug 2025 19:08:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Robert Waite <rowait@microsoft.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Date: Fri, 22 Aug 2025 19:07:58 +0200
Message-ID: <20250822170800.2116980-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

Script interpreters can check if a file would be allowed to be executed
by the kernel using the new AT_EXECVE_CHECK flag. This approach works
well on systems with write-xor-execute policies, where scripts cannot
be modified by malicious processes. However, this protection may not be
available on more generic distributions.

The key difference between `./script.sh` and `sh script.sh` (when using
AT_EXECVE_CHECK) is that execve(2) prevents the script from being opened
for writing while it's being executed. To achieve parity, the kernel
should provide a mechanism for script interpreters to deny write access
during script interpretation. While interpreters can copy script content
into a buffer, a race condition remains possible after AT_EXECVE_CHECK.

This patch series introduces a new O_DENY_WRITE flag for use with
open*(2) and fcntl(2). Both interfaces are necessary since script
interpreters may receive either a file path or file descriptor. For
backward compatibility, open(2) with O_DENY_WRITE will not fail on
unsupported systems, while users requiring explicit support guarantees
can use openat2(2).

The check_exec.rst documentation and related examples do not mention this new
feature yet.

Regards,

Mickaël Salaün (2):
  fs: Add O_DENY_WRITE
  selftests/exec: Add O_DENY_WRITE tests

 fs/fcntl.c                                |  26 ++-
 fs/file_table.c                           |   2 +
 fs/namei.c                                |   6 +
 include/linux/fcntl.h                     |   2 +-
 include/uapi/asm-generic/fcntl.h          |   4 +
 tools/testing/selftests/exec/check-exec.c | 219 ++++++++++++++++++++++
 6 files changed, 256 insertions(+), 3 deletions(-)


base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.50.1


