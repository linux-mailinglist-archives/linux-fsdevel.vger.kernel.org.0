Return-Path: <linux-fsdevel+bounces-14650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4387DF4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0767B281734
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95021106;
	Sun, 17 Mar 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmEFOjAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD30208D7
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700935; cv=none; b=eM7p1pPxUTa0rKbIRpnYBp/tdBuXzbuh7faIkCKNKHFe7Jj3NQNihGKPua799sfS+hH4X2AcZ+kJSt82wnYuIoSeQPysuZ3qGlUhZ+GNiCBDoy2/wypMGwQ76kQZnNZashTVlvQR7Z5YwTPEblQYrfB/Q6u/U+hxtIqIXbnIg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700935; c=relaxed/simple;
	bh=eLMhAxZ7X9XAP78u8qtA3ZWzkrFjGPMJZl7c5hsJ80o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXiVt0xqzeTo8AQ+thvKZuKoSs4mnAj5MnRKmWY+DH1nnYi+yfsm3UCJhpY9aNVETIxLJTkakx6jrJxb5fjev+mzvesiXvxAMXqrsmReXdktjXhjEmTwjpsj3pk+CbKefK0bFcvQeQ3w/rMCCd+DGGf6wwwv8ay9LDA1Ji++aKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmEFOjAe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341730bfc46so194349f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700932; x=1711305732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sl5ZPuOEnLGPgFl7XDyh7HPKN//XZ708139+PbsBYio=;
        b=OmEFOjAefHJpGY5nX/xfKpbivst4VfDvzvx/Pb6qeh4TYp11cbALYhJKmscRNE4Yr6
         AI9oyFCp+yFIG9xQlUIQUmpm5bxt+ID+ePiKg1LerJ5/zXUuJGQrB/uE5JJ5A3q0MaBE
         v++7+EsxNYvn5kXmZdpJpunPhUzQxSSMcsuH8d7dN7a4HjCPbQZqAOp0o0oNSQtgpZRR
         aD60vxrlFsNmMJRrXtxjxbeV1GOIh9fRj8Un143N6fyhrpR7WPrQUpD1m9D84QIzetEP
         c3U4ikGJKoBhdeL5J7RxzGM0wbMK1xI7RjYe8QOtYezZpoZO3VrYWFsoHxQM8AbgLNj/
         6KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700932; x=1711305732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl5ZPuOEnLGPgFl7XDyh7HPKN//XZ708139+PbsBYio=;
        b=g7FdbakjLFj069aidxh+DmH1ltXdnUQjiuRVLI7mxsF+FD+9f8vX9+eH1Hn466V5LC
         0nMIR8eiU6wAzZhICLA8/YJ7/r/UXKnTZ7QqEu4cFICZFhvEOWAcxUIKnK7F3KHG7Ler
         PbTmJIXmEft3H53YolICr4Ou2HkeNJg4pjCg/Rj58GwkAI9pxFAn7SlUdH59bZvXhMsz
         Sw0Amgpt7+Itjh6TTBlyW0wSyLbuodxd1hKaWfqk5XwV1CMZdM1EmYUor91EHnyYOQ0O
         zh0zYDtwp0Q1nLOIkOgEhAPCoLi+6oV2ufM9U340nAqZmf1A0Rz4Jki8bo3HgLFdDe7n
         CCOw==
X-Forwarded-Encrypted: i=1; AJvYcCXz9T7ERxeG6aD6GxxN7GEmWMghs7sYALwEfQb3ZnN/FunMYH7YKUfQ0nyR27GobHEU5p8ndzQulATxRVaNI0qK0Oyt9nvexaeLF4Yk2A==
X-Gm-Message-State: AOJu0YxuCuWL3GAPomSvXn++fQZm3lDuVtL0vhB3BiTvezYgEKL+ZCai
	x3buT+1RTnv3w++9WvckslWDvzSRLzV2BKNak5GRfkn3g+tqLhAn
X-Google-Smtp-Source: AGHT+IF99iKKeZmsbIxxNwbwcvyIuEc9tws6T0Tyh6pIhDPHTtokXbXi5780552GL6JqqgDaFx67KQ==
X-Received: by 2002:a5d:4c51:0:b0:33e:7d03:5fc3 with SMTP id n17-20020a5d4c51000000b0033e7d035fc3mr7082625wrt.13.1710700932242;
        Sun, 17 Mar 2024 11:42:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:11 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/10] fsnotify: move s_fsnotify_connectors into fsnotify_sb_info
Date: Sun, 17 Mar 2024 20:41:52 +0200
Message-Id: <20240317184154.1200192-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184154.1200192-1-amir73il@gmail.com>
References: <20240317184154.1200192-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the s_fsnotify_connectors counter into the per-sb fsnotify state.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h               | 6 ------
 include/linux/fsnotify.h         | 8 +++++++-
 include/linux/fsnotify_backend.h | 7 ++++++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7f40b592f711..c36c2f8fdbe3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1302,12 +1302,6 @@ struct super_block {
 	/* Number of inodes with nlink == 0 but still referenced */
 	atomic_long_t s_remove_count;
 
-	/*
-	 * Number of inode/mount/sb objects that are being watched, note that
-	 * inodes objects are currently double-accounted.
-	 */
-	atomic_long_t s_fsnotify_connectors;
-
 	/* Read-only state of the superblock is being changed */
 	int s_readonly_remount;
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index e470bb67c9a3..48dc65702415 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -20,7 +20,13 @@
 /* Are there any inode/mount/sb objects that are being watched at all? */
 static inline bool fsnotify_sb_has_watchers(struct super_block *sb)
 {
-	return atomic_long_read(fsnotify_sb_watched_objects(sb));
+	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+
+	/* Were any marks ever added to any object on this sb? */
+	if (!sbinfo)
+		return false;
+
+	return atomic_long_read(&sbinfo->watched_objects);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index c9f2b2f6b493..ec592aeadfa3 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -483,6 +483,11 @@ struct fsnotify_mark_connector {
  */
 struct fsnotify_sb_info {
 	struct fsnotify_mark_connector __rcu *sb_marks;
+	/*
+	 * Number of inode/mount/sb objects that are being watched in this sb.
+	 * Note that inodes objects are currently double-accounted.
+	 */
+	atomic_long_t watched_objects;
 };
 
 static inline struct fsnotify_sb_info *fsnotify_sb_info(struct super_block *sb)
@@ -496,7 +501,7 @@ static inline struct fsnotify_sb_info *fsnotify_sb_info(struct super_block *sb)
 
 static inline atomic_long_t *fsnotify_sb_watched_objects(struct super_block *sb)
 {
-	return &sb->s_fsnotify_connectors;
+	return &fsnotify_sb_info(sb)->watched_objects;
 }
 
 /*
-- 
2.34.1


