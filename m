Return-Path: <linux-fsdevel+bounces-31484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC99976C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639D61C2149B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9E41E8859;
	Wed,  9 Oct 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZjNZHALZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AC1E7C3E;
	Wed,  9 Oct 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506552; cv=none; b=lROuajdjjudj3CKmxCdHZMCjb8U01UWVgSgFCHEc4fB4dulbKAakwGdJNQIzcgeLvwZvUKaGT1puvE63aYiqqCO/X3c/TerfNR65Df3g1avJXCP1QkVAlc0zQohiO1jlqHUKQvEvpUfUg94G18J7oc7xWUOHun1wROtr1qkktkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506552; c=relaxed/simple;
	bh=uMJLkf5QTDuvdiBzRMepbN6IKFXf5n7a7YM4+FwWbAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1vUdknFbtyK87O4FKY9cXmfyI+Y66fCzTFsXn2WSbHhKF2zk6LwXtzMJpqONge6TWIj0ccEfrNpc0Ia/nXvmpJq/WPs0nXlV/TVOJkcX37p8WV7waF/94ZJUJcGnHU/Cb973ndHB7e4uzDW2OPBtwZnJ4frDL9y8HszIUuWyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZjNZHALZ; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XP4ZW0rLNz9ssh;
	Wed,  9 Oct 2024 22:42:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728506547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWYXRXXrADdO6m0g06MFjKfnGjcDChbWetducV/F6Dk=;
	b=ZjNZHALZWFcrjZgV9gAg0JNFBkQlLD2SaCQY1YF2e9E23GDiBLPflEaL4boR0gyEkEggy9
	XLW0KNc2DSCBqByqxm4hir/o531UXgDTzDdW7RM3USRTyWq/7xWwMLdzLltrlm2iwi+xTu
	dnI8SqSL6O5KB6eaScMcP/O4DqJpN835gz5ToETv3Stveq+0CsK/knfKzpL9OLNz8np2nx
	Izz2LyEEKAxM1VpL1PSxeaTLgF8JS7uPy79iP8fjiq7LCGE5FXFXgkplKUkOJhJDXe01N9
	4XTdDzNYLqSzB8r/MefbtcWeIDTSPyv1RKHwKOzF4mQYmaWFpCURYPQExJqO8Q==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 10 Oct 2024 07:40:42 +1100
Subject: [PATCH RFC v3 09/10] mount_setattr: add CHECK_FIELDS flag to usize
 argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-extensible-structs-check_fields-v3-9-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=uMJLkf5QTDuvdiBzRMepbN6IKFXf5n7a7YM4+FwWbAk=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSzvQp6eOwQr3GCiIjonTCWo6sOZps53Up4lHl7G8OVC
 9vY+Q5c7ChlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATeeDB8D/p0qE1VzfuzLXq
 9HnMcv/w/70FyysO/284OdtAa9PfgsiVDP9snyots6z2r8j6EH89oeyRSUzpmdfTUz3VXkrl3as
 NsWYEAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4XP4ZW0rLNz9ssh

As with openat2(2), this allows userspace to easily figure out what
flags and fields are supported by mount_setattr(2). As with clone3(2),
for fields which are not flag-based, we simply set every bit in the
field so that a naive bitwise-and would show that any value of the field
is valid.

The intended way of using this interface to get feature information
looks something like the following:

  static bool mountattr_nosymfollow_supported;
  static bool mountattr_idmap_supported;

  int check_clone3_support(void)
  {
      int err;
      struct mount_attr attr = {};

      err = mount_attr(-EBADF, "", 0, &args, CHECK_FIELDS | sizeof(args));
      assert(err < 0);
      switch (errno) {
      case EFAULT: case E2BIG:
          /* Old kernel... */
          check_support_the_old_way();
          break;
      case EEXTSYS_NOOP:
          mountattr_nosymfollow_supported =
              ((attr.attr_clr | attr.attr_set) & MOUNT_ATTR_NOSYMFOLLOW);
          mountattr_idmap_supported =
              ((attr.attr_clr | attr.attr_set) & MOUNT_ATTR_IDMAP) &&
              (attr.userns_fd != 0);
          break;
      }
  }

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namespace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..c7ae8d96b7b7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4771,6 +4771,7 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 		size_t, usize)
 {
 	int err;
+	bool check_fields;
 	struct path target;
 	struct mount_attr attr;
 	struct mount_kattr kattr;
@@ -4783,11 +4784,27 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 		      AT_NO_AUTOMOUNT))
 		return -EINVAL;
 
+	check_fields = usize & CHECK_FIELDS;
+	usize &= ~CHECK_FIELDS;
+
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
 	if (unlikely(usize < MOUNT_ATTR_SIZE_VER0))
 		return -EINVAL;
 
+	if (unlikely(check_fields)) {
+		memset(&attr, 0, sizeof(attr));
+		attr = (struct mount_attr) {
+			.attr_set = MOUNT_SETATTR_VALID_FLAGS,
+			.attr_clr = MOUNT_SETATTR_VALID_FLAGS,
+			.propagation = MOUNT_SETATTR_PROPAGATION_FLAGS,
+			.userns_fd = 0xFFFFFFFFFFFFFFFF,
+		};
+
+		err = copy_struct_to_user(uattr, usize, &attr, sizeof(attr), NULL);
+		return err ?: -EEXTSYS_NOOP;
+	}
+
 	if (!may_mount())
 		return -EPERM;
 

-- 
2.46.1


