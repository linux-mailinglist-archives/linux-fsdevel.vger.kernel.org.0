Return-Path: <linux-fsdevel+bounces-30569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5798C6AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 22:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF90E1C231F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D0F1CEAA3;
	Tue,  1 Oct 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Gav4q8hn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715E1CCED2;
	Tue,  1 Oct 2024 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813943; cv=none; b=lsRFalQH9eXkz689iPhEqiFHJ1dLDnqCu37WdmOv7eVAu2ap8oUzPTdYMc2nZ46m7FxVShmQFgyjgjWv/n1MGrgaA9CsNmgFVFA1aZs2I5onpW4E4aYCzZxE1tCOAKKs2J3f24u4ZlS62trXdtrcLBca9ShFQY1rY62Y5FjAE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813943; c=relaxed/simple;
	bh=WHSeu36YYDeAR7t8fRMQ1RqDbdEG9rP8gtPP9nxG704=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrVvWMPWAZL/OvcA0ZfI6A2pR4iecHkmxtifuavazKHQSPldIK6AwiST7n6ps+KaiavXpJmPniUL3qozMIoYSAeDnLAKQh0QKuYAO+gria4iA5Dus1N8hWK68LH6mMX/1lQ5th9QYkueu+AI43Mq02CkN0zwkjhOWYawCy5C0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Gav4q8hn; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id F2CC863AA0;
	Tue,  1 Oct 2024 23:13:12 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3b0f:0:640:9181:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 2CF2E608E4;
	Tue,  1 Oct 2024 23:13:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1DhPnWAMbCg0-IC0MOBqb;
	Tue, 01 Oct 2024 23:13:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1727813583; bh=wpve//yw/aM5VisuFaR4Q9jmRtS+exuTk91SdXEuo9I=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Gav4q8hnTkkPJ3VYnqEduLlzUy59qfI+aqS9N3LvwKR+ljsVKXw84/cPOy824+5JH
	 zLStglEAGzrqHiPfDwVUYFHJI972FCkV2kFd6gzDWl4SDKP00wt4bzK2P32rada4pX
	 58KdoTX7ndA54+S30poyWf6E0O7D0Xfyg4/bToK0=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Florent Revest <revest@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v4] add group restriction bitmap
Date: Tue,  1 Oct 2024 23:12:57 +0300
Message-ID: <20241001201257.771832-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

This patch adds the group restriction bitmap.
This bitmap is normally 0 (all bits clear), which means the normal
handling of the group permission check. When either bit is set, the
corresponding entry in supplementary group list is treated differently:
- if group access denied, then deny, as before
- if group access allowed, then proceed to checking Other perms.

Added 3 prctl calls: PR_GET_GRBITMAP, PR_SET_GRBITMAP and PR_CLR_GRBITMAP
to manipulate the bitmap. This implementation only allows to manipulate
31 bits. PR_CLR_GRBITMAP needs CAP_SETGID, meaning that the user can
only set the restriction bits but never clear (unless capable).

Q: Why is this needed?
A: When you want to lower the privs of your process, you may use
suid/sgid bits to switch to some home-less (no home dir) unprivileged
user that can't touch any files of the original user. But the
supplementary group list ruins that possibility, and you can't drop it.

The ability to drop the group list was proposed by Josh Tripplett:
https://lore.kernel.org/all/0895c1f268bc0b01cc6c8ed4607d7c3953f49728.1416041823.git.josh@joshtriplett.org/

But it wasn't considered secure enough because the group may restrict
an access, not only allow. My solution avoids that problem, as when you
set a bit in the restriction bitmap, the group restriction still
applies - only the permission is withdrawn. Another advantage is that
you can selectively restrict groups from the list, rather than to drop
them all at once.

Changes in v4: check bitmap directly in groups_search() (Oleg Nesterov)
Changes in v3: add may_setgroups() for !CONFIG_MULTIUSER
  (fixes test bot problem)
Changes in v2: add PR_CLR_GRBITMAP and make the bits otherwise unclearable.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Jens Axboe <axboe@kernel.dk>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Florent Revest <revest@chromium.org>
CC: Kees Cook <kees@kernel.org>
CC: Palmer Dabbelt <palmer@rivosinc.com>
CC: Charlie Jenkins <charlie@rivosinc.com>
CC: Benjamin Gray <bgray@linux.ibm.com>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Helge Deller <deller@gmx.de>
CC: Zev Weiss <zev@bewilderbeest.net> (commit_signer:1/12=8%)
CC: Samuel Holland <samuel.holland@sifive.com>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Eric Biederman <ebiederm@xmission.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Josh Triplett <josh@joshtriplett.org>
---
 fs/namei.c                 | 13 +++++++++++--
 include/linux/cred.h       |  5 +++++
 include/uapi/linux/prctl.h |  4 ++++
 kernel/groups.c            | 15 +++++++++++----
 kernel/sys.c               | 18 ++++++++++++++++++
 5 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4a4a22a08ac2..7818aed7b02f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -373,8 +373,17 @@ static int acl_permission_check(struct mnt_idmap *idmap,
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
 		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
-		if (vfsgid_in_group_p(vfsgid))
-			mode >>= 3;
+		int rc = vfsgid_in_group_p(vfsgid);
+
+		if (rc) {
+			unsigned int mode_grp = mode >> 3;
+
+			if (mask & ~mode_grp)
+				return -EACCES;
+			if (rc > 0)
+				return 0;
+			/* If we hit restrict_bitmap (rc==-1), then check Others. */
+		}
 	}
 
 	/* Bits in 'mode' clear that we require? */
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..97fc0a2105dc 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -25,6 +25,7 @@ struct inode;
  */
 struct group_info {
 	refcount_t	usage;
+	unsigned int	restrict_bitmap;
 	int		ngroups;
 	kgid_t		gid[];
 } __randomize_layout;
@@ -83,6 +84,10 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
 {
 	return 1;
 }
+static inline bool may_setgroups(void)
+{
+	return 1;
+}
 #endif
 
 /*
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879..2a9f3e0c9845 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,8 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
 # define PR_PPC_DEXCR_CTRL_MASK		0x1f
 
+#define PR_GET_GRBITMAP			74
+#define PR_SET_GRBITMAP			75
+#define PR_CLR_GRBITMAP			76
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/groups.c b/kernel/groups.c
index 9b43da22647d..700fe980e82b 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -20,6 +20,7 @@ struct group_info *groups_alloc(int gidsetsize)
 		return NULL;
 
 	refcount_set(&gi->usage, 1);
+	gi->restrict_bitmap = 0;
 	gi->ngroups = gidsetsize;
 	return gi;
 }
@@ -88,7 +89,9 @@ void groups_sort(struct group_info *group_info)
 }
 EXPORT_SYMBOL(groups_sort);
 
-/* a simple bsearch */
+/* a simple bsearch
+ * Return: 0 if not found, 1 if found, -1 if found but restricted.
+ */
 int groups_search(const struct group_info *group_info, kgid_t grp)
 {
 	unsigned int left, right;
@@ -104,8 +107,12 @@ int groups_search(const struct group_info *group_info, kgid_t grp)
 			left = mid + 1;
 		else if (gid_lt(grp, group_info->gid[mid]))
 			right = mid;
-		else
-			return 1;
+		else {
+			if (mid >= 31 || !((1 << mid) &
+					group_info->restrict_bitmap))
+				return 1;
+			return -1;
+		}
 	}
 	return 0;
 }
@@ -222,7 +229,7 @@ SYSCALL_DEFINE2(setgroups, int, gidsetsize, gid_t __user *, grouplist)
 }
 
 /*
- * Check whether we're fsgid/egid or in the supplemental group..
+ * Check whether we're fsgid/egid or in the supplemental group.
  */
 int in_group_p(kgid_t grp)
 {
diff --git a/kernel/sys.c b/kernel/sys.c
index 4da31f28fda8..ed12ac6f5a8a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2784,6 +2784,24 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
 		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
 		break;
+	case PR_GET_GRBITMAP:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = current_cred()->group_info->restrict_bitmap;
+		break;
+	case PR_SET_GRBITMAP:
+		/* Allow 31 bits to avoid setting sign bit. */
+		if (arg2 > (1U << 31) - 1 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		current_cred()->group_info->restrict_bitmap |= arg2;
+		break;
+	case PR_CLR_GRBITMAP:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		if (!may_setgroups())
+			return -EPERM;
+		current_cred()->group_info->restrict_bitmap = 0;
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.46.2


