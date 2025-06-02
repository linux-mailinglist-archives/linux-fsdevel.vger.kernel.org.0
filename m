Return-Path: <linux-fsdevel+bounces-50375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14AACBA1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 19:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7016B311
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7505622541F;
	Mon,  2 Jun 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmWqXKXL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4486344;
	Mon,  2 Jun 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748884630; cv=none; b=jMMJosdOLwx1g91NMFL5FxmoxCMyMZ1COjmAWpyAGhe4uz8ipJzRoCkCxdQYrjLG1fNpT7lC3po1hKPzHlEVDJkBsST6Xxst7k6c9ty6CNpp1W5pszIQFSqy6XYimum8qAOvHJ4C02eo4e51ubwDVe/WDj/oHH456OkPAeNakzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748884630; c=relaxed/simple;
	bh=AuLHNoRW0/8u1M1MrKewtwZsIANv0VhweCIu1Vk2HIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RD7WkIZv/yxmb5QJMqHKfbNVoVfH0F122ugu+QCuZLTBuVkenH3viTdJDqgbi7AFcMfNWKvwOw43clxsHxO57fzsetKTskGcSur4Yy9zk58R40Mlov9CokKlzk6XPHcUlOd/gugHRpnVNtk8wRabJUNPboz2bHEKxObLLjGOZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmWqXKXL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6045e69c9a8so8974400a12.3;
        Mon, 02 Jun 2025 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748884627; x=1749489427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqOjuCBBYX5b+OtBjHwsvpf6FHsGt3WDIqY7NkvGKvk=;
        b=gmWqXKXLY5OVYheeiwbjVdrSKaJW/fknYL/30Y13cFVWVToPlmxwQ+p4ZTe/X0pYCh
         qqgxqwrggxTu09fgVqZxZjFSXH/0aeTrhb0v5xzQEiZGgIq9+rxScpVH/yXyV/zNvMh3
         npIeF2XP6iwzkPLcLTi12p+DcOZSzzfjk72aW32GIqWQR7JrgIKc7EOE3LNjxfDahtZA
         WRzSnGa03ZOa2kg8Y8qAqtq6xAgoXS+oIXnq4jBBmDwlxZU6YUzqP9NQhVFK8DNKTbow
         HEkRUUUsLTHf+koW5/w5CR8/7bcmPkc3IGdv4S1R+zjmBm4o9lzFWQ83tIVmn9+FNDCm
         WDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748884627; x=1749489427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqOjuCBBYX5b+OtBjHwsvpf6FHsGt3WDIqY7NkvGKvk=;
        b=MOXrq1KvSkOiOxS/ZQSkRGfsUtV569TWMPJx/FPEQiduN8/oWiKQmv7JYwTQVL49mw
         dcTl+A+VOQHTyios630C5XelerGzsb2bGQZl9Bi7tw7WOn8xcLb8l5kum1KQUf5BdJht
         NuChpninDAFC9KdVSm9TEXLj4ePlmpgExIvUNHPvXW2PQ/XQECVgukfYvlm/evmmipNG
         zp0KwEX93TMofR4VrdmYZJSCTjAvu6bESsI0++lvNvr/mXmyUCFml6KCe/TwIPuIS/9V
         fU3VJCldtaj5J9qi7n/gZIRTO57nEOeU7A96GeLM8YtOrkEajbZ3FxHULHHgdKu3MQiv
         neQw==
X-Forwarded-Encrypted: i=1; AJvYcCWtNgjG4atJwlIIhWFOiFa//2NaNNJJ3QgoNqEE6gD4qEqkO66hxRq8f1cgeOKlWrU0STv8ZHj6NRRz0cIE@vger.kernel.org
X-Gm-Message-State: AOJu0YxOelw+s1YJb0kOOrHK+aIExiRVQOXIq0K2pyKx5KxysKEUsFqE
	mvuo+/SAsPDw2SDRhQM285Ke9soxHVmDZNZlJ1/lSOOxOxCSQ4CwAUGB
X-Gm-Gg: ASbGncuf+SCTsY5MGjnRavKROSQjmAOxUy7r1n6B8LaDXeP934UJcTBe0o1L0s8AvpR
	MhhrhnAKiu9U4gFtKj1I4+aULpSi2fefakaetAcrneE5yt8JJdoglDVNm4bzZtnYkCtu090FppB
	XUrBLeJdGRSbHI923lnAIYLWaDI3pRNC5oaHflRh0rYHp7qA3KWKQjfNQ+Da1paq8KvKmK0Itd0
	myOVtwoVgx9TW55yqBZZjobExw0iIK3cOSVDG8Kap7nM/hMxmmwY1hJkfBruea9PeC23e31kZzq
	rkJ8rIUpMy4SY072GfsIvYUt5p4h2OWvfVVkUEBu478L3bT/kuiLw4ynF9TwYFlwnv4RGMseDwg
	zFs8wNx0b2WQk3M9J5WmtZ0v54Bl1XndHFKlUNDg8l0MGfsCu
X-Google-Smtp-Source: AGHT+IESAMFIt1VXRCF2s0KyZRm52w3y+EQOPUI6YxuYuL0yWVqhEX0yTfYgvcxnYgQyDfUfwDlHxw==
X-Received: by 2002:a05:6402:2549:b0:602:a0:1f0f with SMTP id 4fb4d7f45d1cf-605b796dc26mr8127762a12.18.1748884626834;
        Mon, 02 Jun 2025 10:17:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-605d9615806sm3178105a12.41.2025.06.02.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 10:17:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v3] ovl: support layers on case-folding capable filesystems
Date: Mon,  2 Jun 2025 19:17:02 +0200
Message-Id: <20250602171702.1941891-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Case folding is often applied to subtrees and not on an entire
filesystem.

Disallowing layers from filesystems that support case folding is over
limiting.

Replace the rule that case-folding capable are not allowed as layers
with a rule that case folded directories are not allowed in a merged
directory stack.

Should case folding be enabled on an underlying directory while
overlayfs is mounted the outcome is generally undefined.

Specifically in ovl_lookup(), we check the base underlying directory
and fail with -ESTALE and write a warning to kmsg if an underlying
directory case folding is enabled.

Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-kent.overstreet@linux.dev/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

This is my solution to Kent's request to allow overlayfs mount on
bcachefs subtrees that do not have casefolding enabled, while other
subtrees do have casefolding enabled.

I have written a test to cover the change of behavior [1].
This test does not run on old kernel's where the mount always fails
with casefold capable layers.

Let me know what you think.

Kent,

I have tested this on ext4.
Please test on bcachefs.

Thanks,
Amir.

Changes since v1,v2:
- Add ratelimited warnings for the lookup error cases
- Add helper ovl_dentry_casefolded()
- Write fstest [1]

[1] https://github.com/amir73il/xfstests/commits/ovl-casefold/

 fs/overlayfs/namei.c     | 31 ++++++++++++++++++++++++++++---
 fs/overlayfs/overlayfs.h |  6 ++++++
 fs/overlayfs/params.c    | 10 ++++------
 fs/overlayfs/util.c      | 15 +++++++++++----
 4 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index d489e80feb6f..733beef7b810 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -230,13 +230,26 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 			     struct dentry **ret, bool drop_negative)
 {
 	struct ovl_fs *ofs = OVL_FS(d->sb);
-	struct dentry *this;
+	struct dentry *this = NULL;
+	const char *warn;
 	struct path path;
 	int err;
 	bool last_element = !post[0];
 	bool is_upper = d->layer->idx == 0;
 	char val;
 
+	/*
+	 * We allow filesystems that are case-folding capable but deny composing
+	 * ovl stack from case-folded directories. If someone has enabled case
+	 * folding on a directory on underlying layer, the warranty of the ovl
+	 * stack is voided.
+	 */
+	if (ovl_dentry_casefolded(base)) {
+		warn = "case folded parent";
+		err = -ESTALE;
+		goto out_warn;
+	}
+
 	this = ovl_lookup_positive_unlocked(d, name, base, namelen, drop_negative);
 	if (IS_ERR(this)) {
 		err = PTR_ERR(this);
@@ -246,10 +259,17 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		goto out_err;
 	}
 
+	if (ovl_dentry_casefolded(this)) {
+		warn = "case folded child";
+		err = -EREMOTE;
+		goto out_warn;
+	}
+
 	if (ovl_dentry_weird(this)) {
 		/* Don't support traversing automounts and other weirdness */
+		warn = "unsupported object type";
 		err = -EREMOTE;
-		goto out_err;
+		goto out_warn;
 	}
 
 	path.dentry = this;
@@ -283,8 +303,9 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 	} else {
 		if (ovl_lookup_trap_inode(d->sb, this)) {
 			/* Caught in a trap of overlapping layers */
+			warn = "overlapping layers";
 			err = -ELOOP;
-			goto out_err;
+			goto out_warn;
 		}
 
 		if (last_element)
@@ -316,6 +337,10 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 	this = NULL;
 	goto out;
 
+out_warn:
+	pr_warn_ratelimited("failed lookup in %s (%pd2, name='%.*s', err=%i): %s\n",
+			    is_upper ? "upper" : "lower", base,
+			    namelen, name, err, warn);
 out_err:
 	dput(this);
 	return err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index aef942a758ce..6c51103d9305 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -446,6 +446,12 @@ void ovl_dentry_init_reval(struct dentry *dentry, struct dentry *upperdentry,
 void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperdentry,
 			   struct ovl_entry *oe, unsigned int mask);
 bool ovl_dentry_weird(struct dentry *dentry);
+
+static inline bool ovl_dentry_casefolded(struct dentry *dentry)
+{
+	return sb_has_encoding(dentry->d_sb) && IS_CASEFOLDED(d_inode(dentry));
+}
+
 enum ovl_path_type ovl_path_type(struct dentry *dentry);
 void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index f42488c01957..2b9b31524c38 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -282,13 +282,11 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 		return invalfc(fc, "%s is not a directory", name);
 
 	/*
-	 * Root dentries of case-insensitive capable filesystems might
-	 * not have the dentry operations set, but still be incompatible
-	 * with overlayfs.  Check explicitly to prevent post-mount
-	 * failures.
+	 * Allow filesystems that are case-folding capable but deny composing
+	 * ovl stack from case-folded directories.
 	 */
-	if (sb_has_encoding(path->mnt->mnt_sb))
-		return invalfc(fc, "case-insensitive capable filesystem on %s not supported", name);
+	if (ovl_dentry_casefolded(path->dentry))
+		return invalfc(fc, "case-insensitive directory on %s not supported", name);
 
 	if (ovl_dentry_weird(path->dentry))
 		return invalfc(fc, "filesystem on %s not supported", name);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index dcccb4b4a66c..593c4da107d6 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -206,10 +206,17 @@ bool ovl_dentry_weird(struct dentry *dentry)
 	if (!d_can_lookup(dentry) && !d_is_file(dentry) && !d_is_symlink(dentry))
 		return true;
 
-	return dentry->d_flags & (DCACHE_NEED_AUTOMOUNT |
-				  DCACHE_MANAGE_TRANSIT |
-				  DCACHE_OP_HASH |
-				  DCACHE_OP_COMPARE);
+	if (dentry->d_flags & (DCACHE_NEED_AUTOMOUNT | DCACHE_MANAGE_TRANSIT))
+		return true;
+
+	/*
+	 * Allow filesystems that are case-folding capable but deny composing
+	 * ovl stack from case-folded directories.
+	 */
+	if (sb_has_encoding(dentry->d_sb))
+		return IS_CASEFOLDED(d_inode(dentry));
+
+	return dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE);
 }
 
 enum ovl_path_type ovl_path_type(struct dentry *dentry)
-- 
2.34.1


