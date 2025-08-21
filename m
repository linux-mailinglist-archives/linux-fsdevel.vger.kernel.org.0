Return-Path: <linux-fsdevel+bounces-58679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965FDB306E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F70B02BF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A82D3921A2;
	Thu, 21 Aug 2025 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gNRTtKkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D751391956
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807682; cv=none; b=MX9c8xlr167MeYbNqyHUxf0uQZ3gppCOqISDtb6qxlcMPGC6oTLk9RwD/SJMsxCz4NQ5/lk6t7EfnQzCNDFM6iU9DNv6XMLAPVuORsyKjCDWRq21SUhyZjnWOGQ4v0jgszIeatOO7j5WbTyJxV91Iin7zDiV3PoNW2Ifgz9Nh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807682; c=relaxed/simple;
	bh=x0LPojx9IQXc26jVCUZk/B2yhhxr/cir7ETQSThbsBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdGUA0kzAUmhau08ApCF4AKEbtvWmJXHmy5Al4qORYEo2IpYv0KrR0AJDc+n/+kECqvAukGqsPzEkipt0vnaIc3E7+tcfFUChS9xs9gi9tmH+6HNKbzDSb6F8WTsRbouUlSBKMD1e5lvsOlubHykUcougyMEsfkwzcz7W6erQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gNRTtKkd; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e95011504d4so1458904276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807680; x=1756412480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNYt8ttislOZxvkBkAGWr4O/dXYuvufQNUeuNOJLG/o=;
        b=gNRTtKkdMvkvxvuahbNvL3tjJvNdsEghXxKMzPuhKSWuvyDSi5gLeJ2CXTVhEm3Aae
         0XaQXGRZiTQHP2JD4R2r4D8XyGwqwfx2cbP1NFthqGxHRHDOaTlQWo7O2TPi0un7zFiQ
         yw2YgbOz+E7nrMioLhlpsbE/ZVFrf6sq+hDesa41SQJNztLdAhIAFs3H3gsvr26Q4eSO
         knwmYkJhjJX9FZlDHf3U6jJfai3yJLdyaCQNXqV/UQkK88hztEuKIuCF93KTe/xOm+x1
         1NhfuFnYqm/h96WDvmzstVrPHD/EaNjM43VRExbypaOYNu9Oo1Iq6mnFnGICz846JACf
         B43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807680; x=1756412480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNYt8ttislOZxvkBkAGWr4O/dXYuvufQNUeuNOJLG/o=;
        b=J7tPDcLu2EYMYJLiIUFEJ+X+/3N8AQu3A4DgRZ179ydH4p3aygkGjvtkJeGTJviVka
         ollTVqDMnPwEp8MUlcIS94sR1kBI4ptNbGXubfM/J/s+hQof7ay3EO+0OyzAsLcQpLlj
         /uyGWHQTDzq3hznZrYwuuHXHqVCWb7NlnKsGps2CvMLBJH7L4+HEo9RhY5e5vt0/Z5Kh
         9dJvpV7Po5Y7ll8sYGieuGWc21DZVUUwX/lL8nl/oMmpLPhpaf65+B2L5f6gIn4YQTxI
         dvaKvXU47A5PMEeo5SgxIhCTFW/zrY0sfM+O9d0Iolb9N6wl4r4SUfH59aQcbviBQqdK
         JEzg==
X-Gm-Message-State: AOJu0YxCVIMxP6gFmimOpXOYs7pU6gxVOgk2sAH0a2M3tFCODWSeXcE9
	b7/7qqT36210g5+Ki7THJHiSoswGGdFN2Oo9QcP7hMc7w7hqRzFVLCXQ8rL1WoGRJHRa9U2X53M
	AzBaV19A3oJhg
X-Gm-Gg: ASbGncsd3hPs/NywhGUickv2aniN+BKzG9A+/mtEDeodNjnlH9xK74XWOagJyahygkS
	NhdykxmtTn1/kH9pQ/BLC2iobn3Y1aR/wm5aGFqJDOJIpWUhydWw12oP6sVAIqSFnJvp4/n1NGQ
	ojTx4Tp7t6kfkNeLyNNPeyVED5S8mlZ2euzHfTIyo8/GQAs4ZdJqNmYB9dNQ9j8OSZuY7EyoAkU
	pxUBtvUihrXAoT0q9aLwNbsMs4jOSulgLATMaTgg9P7qOmVkSBzOCxIXtw7yGk57a/1nRifg+pa
	3UzPSqPAzIYAIemmOOEhnERHSb+/UHHLdd93DyInSikPNmS7PuAG7nFt40BVa6SpJSWfA0lTGgp
	VP3JthFw0itBGrjV99otz68vZ44V98NFmJr5APOzP3tmUXmIUkhbY+feSXTAY9jl1RiQLbg==
X-Google-Smtp-Source: AGHT+IEdC0jxj0VQq2eeW7F/rssUiimWnvaXknuXhDlY2cRwdeuJW2P1Cj0gPVf99SnzHF6lzwYwTg==
X-Received: by 2002:a05:6902:f84:b0:e94:e1e7:fde with SMTP id 3f1490d57ef6-e951c42b49cmr876849276.52.1755807679876;
        Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e93456fa756sm5217858276.30.2025.08.21.13.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 42/50] btrfs: remove references to I_FREEING
Date: Thu, 21 Aug 2025 16:18:53 -0400
Message-ID: <36185d8a18759d2ed86fa6a0d45ffc61bce82571.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not need the BUG_ON in our evict truncate code, and in the
invalidate path we can simply check for the i_count == 0 to see if we're
evicting the inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 03fc3cbdb4af..191ded69ab38 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5338,7 +5338,6 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
@@ -7448,7 +7447,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = refcount_read(&inode->vfs_inode.i_count) == 0;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
-- 
2.49.0


