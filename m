Return-Path: <linux-fsdevel+bounces-59245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406F0B36E37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE8C686029
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B093568E7;
	Tue, 26 Aug 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oyYvhPk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534772FD1A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222872; cv=none; b=i4qJTcs3m2O/oRh6eWqvKxgCtEpfpj9vPEL6RvoSd7fSYcF5T5BJpP+UCBZnPGO0ksChTsua+U8tynYDE/xp+6rIby8GQxr/YxsYvIpzw6i3m8h4cUC5R6kshOF7NXuVlAZb48EaDs+Y7yMRc6bmQy5vFPbKhl3Z7AWnP8W21u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222872; c=relaxed/simple;
	bh=ai2oUzPAcRJzj4bWGdjdsYHnumyQaMH/ub0qR04Gbgw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVi6thwRG/66p5DE+XVIoDQFV1LuHjJ74xPOYJ7vLuvjINHF7ge0Y4cZemTv4hvOUvaPwNWBwjWl95/ox5oZ9whhhrhcKMBkQnB3b2dTTBa++aVCQiiHz7RJTEvF9MXjgeSyO6I7btho4JpnfUpv2ZWyByelS7ZGCXnrZLVXGdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oyYvhPk2; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d5fb5e34cso135707b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222866; x=1756827666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opvoMbW1BQLT38gew8BsXyJcIC3tejqT6ZRE2IoYWVw=;
        b=oyYvhPk2YaNC1odUj7rgCZKb5iynD0eaF/vlt+SymQ1CUWOk2WSNg4VaLryjGYWRCN
         VayktaAMWZ8ajM4yZC9tp/sHB1J7eHISkQaeliGR6LYDdEOo4wkKegKUuQHGetxkK+97
         Ej/wo1xo8R5XfpzPThcqcms3xUtsUt3fxyYFY5vPFlg9r2OdkdjCyTl+m6evGvEpiRAR
         U8i+S9JhHWZsTvVoQubBlSPANZxpPy/z+i90o2vx4vXTjuBqG8SSZQCOKnQwk3qLLuBx
         cH3ifIlaTIv2V0MSzJ5sM4MynwjVcv3o2j8g1jRD/ibS8kTISWTLiiQ9rgTtEpnfz8gE
         7HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222866; x=1756827666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opvoMbW1BQLT38gew8BsXyJcIC3tejqT6ZRE2IoYWVw=;
        b=jmjgkKmYLuEUOUXO8Rx0j332dNAer5HB/5G3PpHRRkg4PdY3BMXvVvPgljzTlnCex/
         7Oq/dutdNZwzGD5aMZ9VYVxb9QdhR/N3NJLCcvwu1eEwdCzPmkladtpKXk0xgtXP8kl7
         DcXncj3xVUSg0RrxE4vhcRhZoIPjLasQqo9RAI+JpYgW5caBoRyqKIpwVQpo+inzcm/x
         vDxLMxYNu06DLFGEX5/qVo+aMm9yXAG9hxWUxP1IvqG38OORrOFSDpzRRUeDlDxfGP2a
         mXL/7JWTSHjlGaTtF44KZv0ANaj/4svZz+HyCnPbAtjgo6Vbc86WGiSosaP5hcXRSo+/
         HvKA==
X-Gm-Message-State: AOJu0YwrL7eogSexL8w4SLvG40wyIp90U5OIddkLUogz0gVkIfBoeUK8
	O+pvlI3q+op/SpEjNkXGg7JxhEwMZH61FnKYhfKlBafK84x+qs5NlGceSxR9MYYdLWbt3tQEwiq
	EKo1l
X-Gm-Gg: ASbGncuHJvNiBmASe4GZuM5d+2K0AW3E1WmAiPZi2tUQKbgdI21W9Si9vD4SNPGFl2h
	TBaaJUxpR9f4QNPfFDY45ljmHJeWlt2Q8dEAQYykEjXhipWfgbm3JyU4cq6yJC5gF47ME4Gq+xp
	EM0XH4LSFSChnL+5mFLqc+1i5d1B+E3ewjuPLSTOiIGR7btE0D04VZLq9AXJkFWeHDDbnISkqiG
	px8limYPgQfmQ6301upXPFPjLdOdiOexKFVB6+itfH+xOWT2HQAqiVmMn9llabHuk6j8nOfUhIg
	ztgEu7VWdxX+gShCpkqyR+hXbjVE4xqtAPJEFr/V2K7A57m9XQDGesklNv/W3Kk2aYNBJ5EoUxW
	5UQI8sfJ71LntfDHr4OPE+p4GNnu6rW9u5LJ+xFH4LOY6Ps3AESA17VTbJ58=
X-Google-Smtp-Source: AGHT+IG4drM57yr5jMHRmPhNbnuKvEUQzsF2UJZDEJ+LiNoGRh2wEepMQoCloxW+Hw7+pj8HTKplcA==
X-Received: by 2002:a05:690c:2021:b0:720:58e:fadc with SMTP id 00721157ae682-72132cda591mr16089637b3.4.1756222865991;
        Tue, 26 Aug 2025 08:41:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721243ea829sm7815797b3.68.2025.08.26.08.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 12/54] fs: stop accessing ->i_count directly in f2fs and gfs2
Date: Tue, 26 Aug 2025 11:39:12 -0400
Message-ID: <2bd8123db2547032fdc5bf80748c7d9d02336443.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of accessing ->i_count directly in these file systems, use the
appropriate __iget and iput helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/f2fs/super.c      | 4 ++--
 fs/gfs2/ops_fstype.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1db024b20e29..2045642cfe3b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1750,7 +1750,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
-			atomic_inc(&inode->i_count);
+			__iget(inode);
 			spin_unlock(&inode->i_lock);
 
 			/* should remain fi->extent_tree for writepage */
@@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_end_intwrite(inode->i_sb);
 
 			spin_lock(&inode->i_lock);
-			atomic_dec(&inode->i_count);
+			iput(inode);
 		}
 		trace_f2fs_drop_inode(inode, 0);
 		return 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index efe99b732551..c770006f8889 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1754,7 +1754,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		atomic_inc(&inode->i_count);
+		__iget(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
-- 
2.49.0


