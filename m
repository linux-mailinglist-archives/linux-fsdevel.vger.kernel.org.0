Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43C4D15FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 19:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfJIRYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 13:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbfJIRYi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BDA121BE5;
        Wed,  9 Oct 2019 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641876;
        bh=4gK/LzpMDS9Bgrs71RKk83qsArALAz7u/lkI0LldCTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZukqYZb8IXAOapYDVdbi6Fa+fUQfCqt5TVwyLXT30HbMSTAptEK9gqbsltL5V9xx
         sSyHQp7XpGlZeKlZbbxQ+KwHpjlWkg5kY3ecpA2RYy5wgIzZnWZCYQ22EikFLMlhO7
         fdLrDTvmy3+GxsH1M8BmWYcQgLrpE/W4PE6XFhYU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 21/21] Make filldir[64]() verify the directory entry filename is valid
Date:   Wed,  9 Oct 2019 13:06:14 -0400
Message-Id: <20191009170615.32750-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170615.32750-1-sashal@kernel.org>
References: <20191009170615.32750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 8a23eb804ca4f2be909e372cf5a9e7b30ae476cd ]

This has been discussed several times, and now filesystem people are
talking about doing it individually at the filesystem layer, so head
that off at the pass and just do it in getdents{64}().

This is partially based on a patch by Jann Horn, but checks for NUL
bytes as well, and somewhat simplified.

There's also commentary about how it might be better if invalid names
due to filesystem corruption don't cause an immediate failure, but only
an error at the end of the readdir(), so that people can still see the
filenames that are ok.

There's also been discussion about just how much POSIX strictly speaking
requires this since it's about filesystem corruption.  It's really more
"protect user space from bad behavior" as pointed out by Jann.  But
since Eric Biederman looked up the POSIX wording, here it is for context:

 "From readdir:

   The readdir() function shall return a pointer to a structure
   representing the directory entry at the current position in the
   directory stream specified by the argument dirp, and position the
   directory stream at the next entry. It shall return a null pointer
   upon reaching the end of the directory stream. The structure dirent
   defined in the <dirent.h> header describes a directory entry.

  From definitions:

   3.129 Directory Entry (or Link)

   An object that associates a filename with a file. Several directory
   entries can associate names with the same file.

  ...

   3.169 Filename

   A name consisting of 1 to {NAME_MAX} bytes used to name a file. The
   characters composing the name may be selected from the set of all
   character values excluding the slash character and the null byte. The
   filenames dot and dot-dot have special meaning. A filename is
   sometimes referred to as a 'pathname component'."

Note that I didn't bother adding the checks to any legacy interfaces
that nobody uses.

Also note that if this ends up being noticeable as a performance
regression, we can fix that to do a much more optimized model that
checks for both NUL and '/' at the same time one word at a time.

We haven't really tended to optimize 'memchr()', and it only checks for
one pattern at a time anyway, and we really _should_ check for NUL too
(but see the comment about "soft errors" in the code about why it
currently only checks for '/')

See the CONFIG_DCACHE_WORD_ACCESS case of hash_name() for how the name
lookup code looks for pathname terminating characters in parallel.

Link: https://lore.kernel.org/lkml/20190118161440.220134-2-jannh@google.com/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jann Horn <jannh@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/readdir.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/readdir.c b/fs/readdir.c
index d336db65a33ea..9a3dc6620c542 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -65,6 +65,40 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 }
 EXPORT_SYMBOL(iterate_dir);
 
+/*
+ * POSIX says that a dirent name cannot contain NULL or a '/'.
+ *
+ * It's not 100% clear what we should really do in this case.
+ * The filesystem is clearly corrupted, but returning a hard
+ * error means that you now don't see any of the other names
+ * either, so that isn't a perfect alternative.
+ *
+ * And if you return an error, what error do you use? Several
+ * filesystems seem to have decided on EUCLEAN being the error
+ * code for EFSCORRUPTED, and that may be the error to use. Or
+ * just EIO, which is perhaps more obvious to users.
+ *
+ * In order to see the other file names in the directory, the
+ * caller might want to make this a "soft" error: skip the
+ * entry, and return the error at the end instead.
+ *
+ * Note that this should likely do a "memchr(name, 0, len)"
+ * check too, since that would be filesystem corruption as
+ * well. However, that case can't actually confuse user space,
+ * which has to do a strlen() on the name anyway to find the
+ * filename length, and the above "soft error" worry means
+ * that it's probably better left alone until we have that
+ * issue clarified.
+ */
+static int verify_dirent_name(const char *name, int len)
+{
+	if (WARN_ON_ONCE(!len))
+		return -EIO;
+	if (WARN_ON_ONCE(memchr(name, '/', len)))
+		return -EIO;
+	return 0;
+}
+
 /*
  * Traditional linux readdir() handling..
  *
@@ -174,6 +208,9 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
 
+	buf->error = verify_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return buf->error;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -260,6 +297,9 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
 
+	buf->error = verify_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return buf->error;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
-- 
2.20.1

