Return-Path: <linux-fsdevel+bounces-59249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D762B36E49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511B38E3595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E08435E4D8;
	Tue, 26 Aug 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UZ2Ilx5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29622F90F9
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222878; cv=none; b=MWSkcH294mVXYOEmGqpmqp0iT3CZpql+KFqKYUp/Xz1FQdTkY5Mu2dnRoGHkkB9++ffYuMlSRh/9iwamQz5z90JH7Dpudl0ZG+SIGprCPXebU0xNbGvRxzXWkXP5S6b9Or/GttOUOX/d+zvp4eKxp0krWyzh0FqDXPnh+QbS4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222878; c=relaxed/simple;
	bh=VwsDvHLoXX1uKTN5GqLXpMQ6MRvXRWQZwSKzj05otD0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJZ9kG9p/IjBRJ9pICAFBno/FXwhCN1TtaTJ+kbRdAqZWo3yntDDnSUFfx7rHDyxTJ7tgFZdL0QyTdLwHJoHHvgcxl1fQcwknr0rZLLsKmmKRXlMlPr+aDIfJiAeSctOoH74gBZfc5SIxjEfPCWVzVTonvcj7Q/0ZgbHQ+Y2cfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UZ2Ilx5X; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60504bf8so47165257b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222872; x=1756827672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2LHx31lTtBHtYaRln9gOaHDdksI8aSH74+SGcGPP5E=;
        b=UZ2Ilx5XYrI6h7DZdgdXxsM7wqEqa9/YxK3DSxpz3AWYFZatt9JwfV0Ei/YIUE8UWx
         QYb9beu+HB59eu15RwEarmcNsr6P2wZvFuUJ3D9SFAmiefPV7x3nmChdd6+okD/Nys7a
         7wfGfOXUPYTuHuNRcDFJsBEIysA/GmA/E+42PRwG/j9NgaE262btjHzNpzgTDNbIUMly
         2apjbW/dCF9+qWSHgUIY6mXZte7xH0uRcwB8nhyPw9P7dyizZ5+zn4ufAhh9kQwNFbQ7
         Ve+zXsJKfPjdHZleXzMv6cU0P3WOvXlY9sQk9zdFgZwBrl0qPn78T74YV4YO+joJhhz4
         5qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222872; x=1756827672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2LHx31lTtBHtYaRln9gOaHDdksI8aSH74+SGcGPP5E=;
        b=xBB8eB28r4uurn9Sn6IRN+/EKdwsibJWEuAxX4nDXRrRPZwNNiOwXqQ37l5mCTyW3I
         hIitziwmLA8lewogQYEiyD0M8GUVOorVSPwWYmeh7ljriyKkqlC4o+ENHZ06Fa00OjHl
         D3Z4YBgEcHgZ1NCks/LaoMOIXvKI4uUuiaXnJcytxGHpwUnGzCdLhtQpyM8up8PPuAQX
         4cSdbDEzQw9/jOLV1XpXTbjAfCKG/dtO962YDHyW9TlDvjQ0ucf6NXZKmz8ft6XV+t/2
         hjRq5mjrBsn4VWB/RdFSLuxuw9F+cOOSAdEx6lUGfjbPsr1FHVx6xyRpG1esQ/Y6DyEs
         EfLQ==
X-Gm-Message-State: AOJu0YyCwOkMra31m4GseaAsILfsZhJ3cYNYc6rdzzv22czofEv4xCBp
	38O4GWoKdmv4GKQw0qo8DOeb++vJ+Gjp179gzdmKJd38MXfQ9UgvugLrk38t2glugac9nv19pCB
	vCtm0
X-Gm-Gg: ASbGnctrG+GfyavqTWHQvjS5RQBZQstB5pPAfggCNYRGOvpQ85cisN8czcPE6/XIP2x
	+QGw4r5s9Ub0WIKl9qThEMOz0svHM7HwgQauuR5fsMGwV1vQVcUHXbLz/Kd9CVjmDS4DptWnNgM
	k1vA5Vb08sZmXymmOKx0A354NHrQbnPpO0SJp9TGOjW2Y1IsC2WPEC75Erv8QhgRwzVGRwHrllx
	s7ELYdiMD2Nv/1YkZ3wVhWaXfIxsIKXRwZaoEJaO3PSbiI98t2i7PfGKwMgbjSAdRE0gnne8g78
	/cwy7kY5akRXuJaUQobC/f0RAtPAF3IJX0VnbMOhf7JAD3BJW+HAHcHuXSBtDZ4TwomaXfdyV/r
	rcL4vWWwzBR69c9BrKBzuSec7fCI1npyIlKkTRjxpixLyLCKJTzYXOuEw9+s=
X-Google-Smtp-Source: AGHT+IGT/XuD8mmhvooE8E8UkA6256XoF7vusI/+JGpOkFM0b1RNjbEYVhkocKaciv/nEIMzWHJRFQ==
X-Received: by 2002:a05:690c:7684:b0:721:10a3:65ae with SMTP id 00721157ae682-72110a37a2bmr69440357b3.11.1756222871810;
        Tue, 26 Aug 2025 08:41:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff188b0f1sm25303157b3.42.2025.08.26.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 16/54] fs: delete the inode from the LRU list on lookup
Date: Tue, 26 Aug 2025 11:39:16 -0400
Message-ID: <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>
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

When we move to holding a full reference on the inode when it is on an
LRU list we need to have a mechanism to re-run the LRU add logic. The
use case for this is btrfs's snapshot delete, we will lookup all the
inodes and try to drop them, but if they're on the LRU we will not call
->drop_inode() because their refcount will be elevated, so we won't know
that we need to drop the inode.

Fix this by simply removing the inode from it's respective LRU list when
we grab a reference to it in a way that we have active users.  This will
ensure that the logic to add the inode to the LRU or drop the inode will
be run on the final iput from the user.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 4d39f260901f..399598e90693 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1146,6 +1146,7 @@ static struct inode *find_inode(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1187,6 +1188,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1653,6 +1655,7 @@ struct inode *igrab(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
 		__iget(inode);
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 	} else {
 		spin_unlock(&inode->i_lock);
-- 
2.49.0


