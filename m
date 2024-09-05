Return-Path: <linux-fsdevel+bounces-28754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997B96DD06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A214A1C237C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D631A3AAB;
	Thu,  5 Sep 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="h9ABOC4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B219DFB9;
	Thu,  5 Sep 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548315; cv=none; b=szPKpMx99mzMI/bOT6do86GY5QGa8R3SO+X6omaR0++EuhLZQtGGZB5X7gfX7J7KAVP0oH05OXnFGY6rBtmcFNGOJThNmXVxfQabUbRLPoLe+WzcdaXVx7dHHjpeGFDNjbssvulyts8oZtLbO4jCKekkLGU7S7kJN52Zp9+EcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548315; c=relaxed/simple;
	bh=m/kukrXbUb2iR1VdL6T6wbbPdJMNl29jeGapuUY2L5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dmgno5pMTytnSuX3/JGXKFQRDBtLy4a8ic/CDwTqgNLgGLzMkpItuJDqLDO8zWuzE0ISPf3Ce7hFZLRO88e94qq362SaLGBkIRwZPuvbwGsJ0XFsTpjybgqmQ79TPJHHALHVCsO/Ib+w5yAet+g9O8SYn4HqX0kmbsbD374+mOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=h9ABOC4I; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4X02YL187Gz9t6V;
	Thu,  5 Sep 2024 16:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4cJ+jIxm5+97OBbjnL0YlZHGQ1e5+nIetwERzw4CVk=;
	b=h9ABOC4IWs3rhQ9sv/s3TmMzqPvEviQ5eNZ1cT+uloarFLJwXwwNRPx113OFs/s4yLWBVK
	hUZACIEbMjWswqP7AJ67HB0xmXH70GTWqhzugLvED1bbpZs0cfRpsYHWQW45wA49qqPmF5
	XJsZhCXl6z/ly65zMx1pI9KOLg3Bi9cinRlhMDc+TwcThNZR/dNdx/HoCLdChJY3/8Z4Wl
	IJJubFY0QzMW6BAof2nXIDj3NjsaTC5D52cEjiBGDfLNs9h95cwaifqwmn+cfHMCO2FnsG
	Iy+9aOlHXF859S+CLLQWvD3hgop2UKccvRevwDUwgkRaOYcI0Nv12PvhpWFe6w==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 06 Sep 2024 00:56:41 +1000
Subject: [PATCH RFC v2 09/10] mount_setattr: add CHECK_FIELDS flag to usize
 argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-extensible-structs-check_fields-v2-9-0f46d2de9bad@cyphar.com>
References: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
In-Reply-To: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
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
 h=from:subject:message-id; bh=m/kukrXbUb2iR1VdL6T6wbbPdJMNl29jeGapuUY2L5E=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLYl7PEi3vcOX9/56+0I+xnwYqdLxGORuw79Gx+8X
 prcNuO0SkcpC4MYF4OsmCLLNj/P0E3zF19J/rSSDWYOKxPIEAYuTgGYSPpVhv8RCtu35f7aHTCF
 eeYhf9Mje61npykZz54sdPHU+6+SMQW6DL9Za+99zuy7dqQ9YsbHX8/C90U9WLhM7rdAppCGdaL
 A0U8MAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

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
2.46.0


