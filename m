Return-Path: <linux-fsdevel+bounces-16627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B48A04BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDAFB22259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43BE567;
	Thu, 11 Apr 2024 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KwuOKFgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72B2C80;
	Thu, 11 Apr 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794242; cv=none; b=HyqiqvdGbeFv4WyuARBmxh+jDQc44FDmsFUaOk+eZqOd+3q8Ksccscw6TQzRuPwh3kWJdIr2G6HyBKrGWXoqBldrxCfhizGF0rm/kN6HYwqaVb9GEEOefzAarngZEWPbjxtBrGNpWBHK/TX+radyTnzdDVpGc2kSCVHvUHCidPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794242; c=relaxed/simple;
	bh=sGbIuL6+Qheb+6D9rz95VwEJtWh1KSDnG3kudzXCjRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2LU9pTk/QMUSy5VfV4+85g4QTisRMrXddpq/W4+30c2BOJu4zoS4w622mfljZEcxwNsFmwdzQ66O26aTayGJZGYo/bYgCUfiHN8ga+7eTBVLE1azHf120TBPwLZeVBVgAZ7OUuL4wKesx6viUzKhYrSpM2cG/jW0QdPBiQRQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KwuOKFgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B87C433F1;
	Thu, 11 Apr 2024 00:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712794241;
	bh=sGbIuL6+Qheb+6D9rz95VwEJtWh1KSDnG3kudzXCjRo=;
	h=From:To:Cc:Subject:Date:From;
	b=KwuOKFgkIgTQdLFDTnJa0Bsml2RpWX1CAq08rrv7v7YpXElHck7P/f/rb2hbZCLvt
	 OytoFF+urComDnfd7euAaTLxr5w2vkal9O4El4k5wUKoOujuAWdrSjGv0QS8lOblzE
	 IimnDjqbOJYcz60K99x1tjb7xnaiA6N/XzYv4KUo=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Lutomirski <luto@kernel.org>,
	Peter Anvin <hpa@zytor.com>
Subject: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
Date: Wed, 10 Apr 2024 17:10:12 -0700
Message-ID: <20240411001012.12513-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.44.0.330.g4d18c88175
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

   "The definition of insanity is doing the same thing over and over
    again and expecting different results”

We've tried to do this before, most recently with commit bb2314b47996
("fs: Allow unprivileged linkat(..., AT_EMPTY_PATH) aka flink") about a
decade ago.

But the effort goes back even further than that, eg this thread back
from 1998 that is so old that we don't even have it archived in lore:

    https://lkml.org/lkml/1998/3/10/108

which also points out some of the reasons why it's dangerous.

Or, how about then in 2003:

    https://lkml.org/lkml/2003/4/6/112

where we went through some of the same arguments, just wirh different
people involved.

In particular, having access to a file descriptor does not necessarily
mean that you have access to the path that was used for lookup, and
there may be very good reasons why you absolutely must not have access
to a path to said file.

For example, if we were passed a file descriptor from the outside into
some limited environment (think chroot, but also user namespaces etc) a
'flink()' system call could now make that file visible inside a context
where it's not supposed to be visible.

In the process the user may also be able to re-open it with permissions
that the original file descriptor did not have (eg a read-only file
descriptor may be associated with an underlying file that is writable).

Another variation on this is if somebody else (typically root) opens a
file in a directory that is not accessible to others, and passes the
file descriptor on as a read-only file.  Again, the access to the file
descriptor does not imply that you should have access to a path to the
file in the filesystem.

So while we have tried this several times in the past, it never works.

The last time we did this, that commit bb2314b47996 quickly got reverted
again in commit f0cc6ffb8ce8 (Revert "fs: Allow unprivileged linkat(...,
AT_EMPTY_PATH) aka flink"), with a note saying "We may re-do this once
the whole discussion about the interface is done".

Well, the discussion is long done, and didn't come to any resolution.
There's no question that 'flink()' would be a useful operation, but it's
a dangerous one.

However, it does turn out that since 2008 (commit d76b0d9b2d87: "CRED:
Use creds in file structs") we have had a fairly straightforward way to
check whether the file descriptor was opened by the same credentials as
the credentials of the flink().

That allows the most common patterns that people want to use, which tend
to be to either open the source carefully (ie using the openat2()
RESOLVE_xyz flags, and/or checking ownership with fstat() before
linking), or to use O_TMPFILE and fill in the file contents before it's
exposed to the world with linkat().

But it also means that if the file descriptor was opened by somebody
else, or we've gone through a credentials change since, the operation no
longer works (unless we have CAP_DAC_READ_SEARCH capabilities, as
before).

Note that the credential equality check is done by using pointer
equality, which means that it's not enough that you have effectively the
same user - they have to be literally identical, since our credentials
are using copy-on-write semantics.

So you can't change your credentials to something else and try to change
it back to the same ones between the open() and the linkat().  This is
not meant to be some kind of generic permission check, this is literally
meant as a "the open and link calls are 'atomic' wrt user credentials"
check.

It also means that you can't just move things between namespaces,
because the credentials aren't just a list of uid's and gid's: they
includes the pointer to the user_ns that the capabilities are relative
to.

So let's try this one more time and see if maybe this approach ends up
being workable after all.

Cc: Andrew Lutomirski <luto@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Peter Anvin <hpa@zytor.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/namei.c            | 17 ++++++++++++-----
 include/linux/namei.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c5b2a25be7d0..3c684014eb40 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2422,6 +2422,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		if (!f.file)
 			return ERR_PTR(-EBADF);
 
+		if (flags & LOOKUP_DFD_MATCH_CREDS) {
+			if (f.file->f_cred != current_cred() &&
+			    !capable(CAP_DAC_READ_SEARCH)) {
+				fdput(f);
+				return ERR_PTR(-ENOENT);
+			}
+		}
+
 		dentry = f.file->f_path.dentry;
 
 		if (*s && unlikely(!d_can_lookup(dentry))) {
@@ -4641,14 +4649,13 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 		goto out_putnames;
 	}
 	/*
-	 * To use null names we require CAP_DAC_READ_SEARCH
+	 * To use null names we require CAP_DAC_READ_SEARCH or
+	 * that the open-time creds of the dfd matches current.
 	 * This ensures that not everyone will be able to create
 	 * handlink using the passed filedescriptor.
 	 */
-	if (flags & AT_EMPTY_PATH && !capable(CAP_DAC_READ_SEARCH)) {
-		error = -ENOENT;
-		goto out_putnames;
-	}
+	if (flags & AT_EMPTY_PATH)
+		how |= LOOKUP_DFD_MATCH_CREDS;
 
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 74e0cc14ebf8..678ffe4acf99 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -44,6 +44,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_BENEATH		0x080000 /* No escaping from starting point. */
 #define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
 #define LOOKUP_CACHED		0x200000 /* Only do cached lookup */
+#define LOOKUP_DFD_MATCH_CREDS	0x400000 /* Require that dfd creds match current */
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
-- 
2.44.0.330.g4d18c88175


