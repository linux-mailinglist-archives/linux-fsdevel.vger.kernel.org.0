Return-Path: <linux-fsdevel+bounces-79500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMkKId6lqWnwBgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:48:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A4214D29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4290030F6CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59F3CB2F3;
	Thu,  5 Mar 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAX0d2xs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75EB3CF68C;
	Thu,  5 Mar 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725044; cv=none; b=Ka4IeSGFn67QnB4Z9k75aBkDrWcTSG9rVPb0IpSjZN+xIYZ/eVT4V8Q/x1+63zcIMuW/5gRjpP6Ag2v0PhQvrAUWIwjDfVddXgYyauTyI19dQdwRYn31rQQPWzGpw8cwslEry77qYkj1aqOdodI90UI8yrK3YJgA8xVI6PCdeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725044; c=relaxed/simple;
	bh=XFt9mQ0GoAaRGLyHFbiJBRtbs41U6XC+bGWSWZaeqBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6JkaMSZr3Qcp4avDikyAjXmv0FA2HI7WSLjFTMHCPS4ToYmSZbT2su+0dZbdpRW95DrdEBJ4u5iu3MfKWIb6OmXjokYlhE8SBR8Vlk13jSa9Vk7kqE1f7DxaDI+IeJwQHKbU/jOxbKpoqlf9qtgzYel4N+ltvdyTSt4h10Eha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAX0d2xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2894C116C6;
	Thu,  5 Mar 2026 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725044;
	bh=XFt9mQ0GoAaRGLyHFbiJBRtbs41U6XC+bGWSWZaeqBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAX0d2xsd+dWP58XDaYd+b2pAg7W6azVXtBh07m+h4ow/F7Ro44PigDc+XZTv3Eow
	 NIy6wmsvn8I9LxA6wJdNlj7Osxpuirdg+jgPYnIVM3pTzeWDUp5y+wJaW0m7pxKdaA
	 APSd2TWDoPkaM4dOEjhXQ36qFuDJ2osGU2jUjpQUxHziZMEosnLHZYZeoadKQZl04q
	 F+ssm3LKPRQ0eNLIcVE+PRWoE1a/QsoRaBlhn2NS/qxKh7Qz6Szgc5HW5BgOmXJ87h
	 6VEMe9AFTrs1sN4DVllqzTpCpcskoJ8EXm4cTDW4dBTMCT6bx0/J3Yk+RoqUJHubps
	 QFYCX17MdQe/Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] fs: init flags_valid before calling vfs_fileattr_get
Date: Thu,  5 Mar 2026 10:36:56 -0500
Message-ID: <20260305153704.106918-13-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305153704.106918-1-sashal@kernel.org>
References: <20260305153704.106918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D69A4214D29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[qq.com,syzkaller.appspotmail.com,kernel.org,zeniv.linux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79500-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,7c31755f2cea07838b0c];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,qq.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit cb184dd19154fc486fa3d9e02afe70a97e54e055 ]

syzbot reported a uninit-value bug in [1].

Similar to the "*get" context where the kernel's internal file_kattr
structure is initialized before calling vfs_fileattr_get(), we should
use the same mechanism when using fa.

[1]
BUG: KMSAN: uninit-value in fuse_fileattr_get+0xeb4/0x1450 fs/fuse/ioctl.c:517
 fuse_fileattr_get+0xeb4/0x1450 fs/fuse/ioctl.c:517
 vfs_fileattr_get fs/file_attr.c:94 [inline]
 __do_sys_file_getattr fs/file_attr.c:416 [inline]

Local variable fa.i created at:
 __do_sys_file_getattr fs/file_attr.c:380 [inline]
 __se_sys_file_getattr+0x8c/0xbd0 fs/file_attr.c:372

Reported-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7c31755f2cea07838b0c
Tested-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Link: https://patch.msgid.link/tencent_B6C4583771D76766D71362A368696EC3B605@qq.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This confirms the bug: `fuse_fileattr_get()` reads `fa->flags_valid`
(line 517), but in the `file_getattr` syscall, `fa` was declared
uninitialized. The `flags_valid` field could contain any stack garbage,
leading to the KMSAN report. The fix initializes it to `{ .flags_valid =
true }`, matching the pattern used by `ioctl_getflags()` at line 313.

## Analysis

**What the commit fixes:** An uninitialized memory read (KMSAN uninit-
value) in the `file_getattr` syscall path. The `struct file_kattr fa`
variable is declared on the stack without initialization, then passed to
`vfs_fileattr_get()` which calls filesystem-specific `fileattr_get()`
implementations. The FUSE implementation (`fuse_fileattr_get`) reads
`fa->flags_valid` before writing to it, triggering use of uninitialized
memory.

**Bug severity:** This is a real bug reportable by KMSAN. The
uninitialized `flags_valid` field determines which code path is taken in
`fuse_fileattr_get()` (line 517). If `flags_valid` happens to be false
(zero), the fuse driver takes the wrong code path (xattr-based instead
of ioctl-based), potentially returning incorrect or garbage data to
userspace.

**Fix quality:** The fix is a one-line change - initializing the struct
with `{ .flags_valid = true }`. This exactly matches the existing
pattern at line 313 (`ioctl_getflags`), making it obviously correct. The
`/* hint only */` comment also matches.

**Scope:** Only the 6.19 stable tree is affected. The `file_getattr`
syscall was introduced in commit `be7efb2d20d67` which first appeared in
v6.17-rc1. The code was moved to `fs/file_attr.c` as part of that
series. Older stable trees (6.12.y, 6.6.y, 5.15.y, etc.) don't have this
syscall and are unaffected.

**Risk:** Extremely low. The change only adds initialization of a single
struct field, matching an existing pattern in the same file.

**Stable criteria check:**
- Obviously correct: Yes, matches existing pattern
- Fixes a real bug: Yes, KMSAN-detected uninit read, syzbot-reported
- Small and contained: Yes, one-line change
- No new features: Correct
- Tested: Yes, syzbot Tested-by tag

## Verification

- Read `fs/file_attr.c:380` - confirmed `struct file_kattr fa;` is
  uninitialized in `file_getattr` syscall
- Read `fs/file_attr.c:313` - confirmed `ioctl_getflags` uses `{
  .flags_valid = true }` (the pattern the fix replicates)
- Read `fs/file_attr.c:82-94` - confirmed `vfs_fileattr_get()` passes
  `fa` directly to filesystem's `fileattr_get` callback without
  initializing it
- Read `fs/fuse/ioctl.c:517` - confirmed `fuse_fileattr_get` reads
  `fa->flags_valid` before writing, triggering the KMSAN report
- `git tag --contains be7efb2d20d67` showed the syscall was introduced
  in v6.17-rc1 (not v6.19-rc1 as might be assumed)
- `git show v6.19.6:fs/file_attr.c` confirmed the fix is NOT yet in
  6.19.6 stable
- `git log v6.12.75 -- fs/file_attr.c` returned empty, confirming older
  stable trees don't have this file/code

**YES**

 fs/file_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e947..4889cf59b2562 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -377,7 +377,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct filename *name __free(putname) = NULL;
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = { .flags_valid = true }; /* hint only */
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
-- 
2.51.0


