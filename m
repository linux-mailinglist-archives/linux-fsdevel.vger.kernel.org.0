Return-Path: <linux-fsdevel+bounces-22252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40099152E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD212820F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1CC19DF40;
	Mon, 24 Jun 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lHYtiONw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E319D8AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244248; cv=none; b=M0vfazNok6Oph2QebsUEfaV6Ezp+T/ggoYTL7flM9X8AOqxBIwbQA69gTFYtOpCjRVfj7NU+e+PG4D4k97fgXef3F6JXtFPo89anxkiCpKP+4Trg53SAti3H27zFPAlh7h9/DG6c5vmMmguMHheFaUrFS+zXwAJDQvEUkjehUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244248; c=relaxed/simple;
	bh=GWwnakjkuG1wF7ZPqr9VZkWVkliKt//yimgDB+eDC6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD6WVTsCchhtI06Ruz2cxJRhs8EN7CMo9UlAL4IbuyQpSdnpLIvprOvTTsAlbmzw0HHB0rDzwMyP8JZo9+S94BROvwKIfAbR48SHE2q/f0OullIMnbZPmwyPfC/QW49xzRzaOblXl6nB1m4Q66yGeFAtr18P5AkW3RA996cciWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lHYtiONw; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62fe76c0a61so41325917b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244246; x=1719849046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aP/ldgWbu2+XT8YO2t/nVvVclNabe2RrR4wVmboSZo=;
        b=lHYtiONwpU4ln2GDhFHbWE9FozR14XnOrwxaG6THcb3oA10UOKu7g0F0m27pM5v8Hm
         Ul3wLSCQaqc66mOAN7yTGiw9NJxWyUZKSNUNSx4CHx2pNQmZ+g1dYhEuzOw9pazn0yND
         UoFIsrvMlIChLWBGcQh6mLJDIc5Foglb1W5a6pBsqDQ8yBF0/mxZoienHCV6maAU1t+s
         oQVKu5BQJuIg+FmMIO2+fgXYXuXGhZhyrDkPoEzkz6hkKRJ+LvAodRoRSkhLATss7bYs
         d2raTCN1ygOaOMozLJlIMih1DzMHQtSl/lrlMJeIEbPb4rnhVcCt57ydtjE7Tr3GfMfi
         1gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244246; x=1719849046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aP/ldgWbu2+XT8YO2t/nVvVclNabe2RrR4wVmboSZo=;
        b=ZX19M7vOEOZBsKnxphfH9D80iki0IgFDs5eLVdUzWgr/6WAV7IcD+C4Rc87wkbkxl+
         LdrU0vrRETSBfXR2IRmjjJMRifL1buC7xNqXYsokgR+gV1GN9rhUpbOHnk3PikAxpsz6
         Y4uE4I5uBprvV0icgAYntBaJLiy4ugwKirHG8TRvCJDXXY0+mgYHthNW/MBtEcoySUML
         sSRIHW9KohyDdxh3UQUyRiU2crPDswoCq11AT3kfY6Ob0QR6i6qLoU6NzNKqFAw3enVH
         RBz9ScosmvOX5VK/X+d/hbXaJ9TOHtuqrXUiL0Fnig04DbgJRQ7jnsjq5hNPELQaCuZM
         vaLg==
X-Gm-Message-State: AOJu0Yx2xqFDdXvPGf6FpIPreqSvA2/V30NZ8jAUUI2yiBfVteP5OxEf
	ox8hDq4UhxGW/lzU+4L8d3TmIs+NtwOt5ttFal1qomdLJLIOUseJIXZXPmBetXGe1un98cQ/9DM
	Q
X-Google-Smtp-Source: AGHT+IFcs18Fh0C+uER0RjZHd4S0uGPnIGPl54a1zVQndbkivmVpaqrO120CPd6ku5cvS0ILPXvI9Q==
X-Received: by 2002:a81:848f:0:b0:622:c892:6ae7 with SMTP id 00721157ae682-643af6ebd94mr24990347b3.12.1719244245856;
        Mon, 24 Jun 2024 08:50:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f14a3cd92sm29354037b3.102.2024.06.24.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 6/8] fs: Allow statmount() in foreign mount namespace
Date: Mon, 24 Jun 2024 11:49:49 -0400
Message-ID: <52a2e17e50ba7aa420bc8bae1d9e88ff593395c1.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

This patch makes use of the new mnt_ns_id field in struct mnt_id_req to
allow users to stat mount entries not in their mount namespace.  The
rules are the same as listmount(), the user must have CAP_SYS_ADMIN in
their user namespace and the target mount namespace must be a child of
the current namespace.

Co-developed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1b422fd5f267..6d44537fd78c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4977,10 +4977,8 @@ static int statmount_fs_type(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
-static void statmount_mnt_ns_id(struct kstatmount *s)
+static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
-	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
-
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
 	s->sm.mnt_ns_id = ns->seq;
 }
@@ -5082,7 +5080,7 @@ static int do_statmount(struct kstatmount *s)
 		err = statmount_string(s, STATMOUNT_MNT_POINT);
 
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
-		statmount_mnt_ns_id(s);
+		statmount_mnt_ns_id(s, ns);
 
 	if (err)
 		return err;
@@ -5199,6 +5197,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 		struct statmount __user *, buf, size_t, bufsize,
 		unsigned int, flags)
 {
+	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
 	struct vfsmount *mnt;
 	struct mnt_id_req kreq;
 	struct kstatmount ks;
@@ -5213,13 +5212,28 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	if (ret)
 		return ret;
 
+	ns = grab_requested_mnt_ns(kreq.mnt_ns_id);
+	if (!ns)
+		return -ENOENT;
+
+	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
+	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
+		return -ENOENT;
+
 retry:
 	ret = prepare_kstatmount(&ks, &kreq, buf, bufsize, seq_size);
 	if (ret)
 		return ret;
 
 	down_read(&namespace_sem);
-	mnt = lookup_mnt_in_ns(kreq.mnt_id, current->nsproxy->mnt_ns);
+	/* Has the namespace already been emptied? */
+	if (kreq.mnt_ns_id && RB_EMPTY_ROOT(&ns->mounts)) {
+		up_read(&namespace_sem);
+		kvfree(ks.seq.buf);
+		return -ENOENT;
+	}
+
+	mnt = lookup_mnt_in_ns(kreq.mnt_id, ns);
 	if (!mnt) {
 		up_read(&namespace_sem);
 		kvfree(ks.seq.buf);
@@ -5227,7 +5241,12 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	}
 
 	ks.mnt = mnt;
-	get_fs_root(current->fs, &ks.root);
+	ret = grab_requested_root(ns, &ks.root);
+	if (ret) {
+		up_read(&namespace_sem);
+		kvfree(ks.seq.buf);
+		return ret;
+	}
 	ret = do_statmount(&ks);
 	path_put(&ks.root);
 	up_read(&namespace_sem);
-- 
2.43.0


