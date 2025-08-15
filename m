Return-Path: <linux-fsdevel+bounces-58049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C329CB285CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 20:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B7BBA0505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866212F9C27;
	Fri, 15 Aug 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DugA1NA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21020E31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282350; cv=none; b=XDgA8FcGnJXMqOvpHgtw++KkIuC1YkQZPdIH0KsrKiQKrQ3ODza2bHocT6henxqNSX5/96hTjNeH/j+xdZkLZviYFoKOXekCpTrd6WZ3uOLh7CBxRRX++/683zKNNCGFQ0dtZ9x8o1TWiNNBDXwaSPdvbqDSn3pAGkD/g5Qsmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282350; c=relaxed/simple;
	bh=9V7VGOjvP6GS43mnapvn1JfO1SNJaJF85nFxM+kdqe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQByDnH9rISmnF9oegC3rsW+mwifkR3cZJ+hd8anyp9i6uW03da/5rAJh/yHo7DVI6J4RgqBwJrLiLxi5f233Tar18vI2CkByIY6JCxDMLvkjqrZGdQXfXLtjJeJJ1oYBcIG41urr+qWVu8HpKdzlkYEeSBkP2rjqINFDV3tXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DugA1NA6; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b471756592cso1554357a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755282349; x=1755887149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wehxI6c/5B4WBk2GUiN+WjAvK7+QeQikj5QqIwz1y2E=;
        b=DugA1NA6xsGlCTMaLLaR184uA5wS7+dYxoy0AroK4HJNEM9zC1BH6spK9H1Dt6LW83
         JjnORLYGqm2vf45Q6AJpN2JaRX+INzcSz9Y+jYkSvBC0qnK83RLOK3eRJA3LxbE1yZV+
         5pd3F0ENkyJWr5kAy7zcZuT4/o9vN8TmMfKmVuZDKVVwVtdXC0WlpwaUlGdg7izlnwt7
         LOnWM5d4cwHTgU3MVxB251fleZ15sB9PzgaXHYwscG5+s6JnkjkDMhhJSfj6aJkR2js0
         0DLALnHXgo2zDwqhHLAYep3YRR2pu5FYBsF26EQRvY+0vnm4H+CfzBPwL4BYpHpaSMyQ
         5NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755282349; x=1755887149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wehxI6c/5B4WBk2GUiN+WjAvK7+QeQikj5QqIwz1y2E=;
        b=mw+AwWnEMX5Voaewp0WBEIsi2s+RBxOrjnZqvDo5qkHuGXc+gdqnrYdgOo9wfLGEhk
         cJJGZM2yGOBhSImC/IcxQsEQ1XseHooKG3yycARV/zKc+jAgPVYyXZqYIeRaE4Nxx34B
         iXrgVBn6YcSPaCBk7E66eJDTIDezmX41YR7hr1VR1FMAVk3ui0W/oDx39631Tipb3UC9
         /MbC4S8Hmf3AbkLWfqoLzSgvCgzKB0Nlbj74fqQGWCpYuCRDOqMq0K3mCFSqqjP2g0hH
         x9mNxKWsXxpfSdqcz31gb2+6cFegcSsdYgslobgmqoORIEakozFXhR+axHJLpPl8wl5Z
         747A==
X-Forwarded-Encrypted: i=1; AJvYcCVFGv86OUFAIfOyt4ttMHkKz7m5dx8oAxkt54CVX2zeFSAhd0klNMycrq5JqFi/UtfxyNsx8e6lj5cXAGg8@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUGO0gcqwDMLrdF0BEqb+jVYvBbZE3UwzKpPDSMTh20PgBEkN
	7wLOtK///AxSgWeUHP4wieVAx9EB1Fr4CPSHMtb/ElLPERCMjAanYT2P
X-Gm-Gg: ASbGnctVGitQtBKBreNQ0hv1+YUB+qA73eRg31zOdTE5sunExCm0f4X1s625QQZqv/I
	Bj6jVu6ywb4fqVlwtNRSnTk8MatZtasCWmBf6YNMTBVAtyRMBRb75yX+Gk/Z6x2LiOgSyUICamm
	mtAaRg9QbaQXBOhb7nyYucZ2fiIK334+BwLlmiuxQqKKGJ+393Zmu6d5C0NtZFsRfGEWgOkeI3Y
	a62XtsOncJ4+FkB1gqRZ8kLfF8tGLfr2kQcrXws0qM0p5W/kNHUhTxd+XTxG28y8edPgPWhxbPU
	8RUesYBljIhKhgyLNH5toQ91CdIJtYAMcceVsQEMjj3JCgnyHjBXNICoTAkZih0KjoG/s2NOy3X
	E4X505b03BPO+zbbBEw==
X-Google-Smtp-Source: AGHT+IGeYsKMbyz14exVWAMauos4L9dhTMURE0UfjLPiP9d/t1ajeLb6GKyG6gdZHOWi5bDUUWxQQA==
X-Received: by 2002:a17:903:2285:b0:240:49bf:6332 with SMTP id d9443c01a7336-2446d939889mr47485595ad.47.1755282348861;
        Fri, 15 Aug 2025 11:25:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f56asm19129475ad.94.2025.08.15.11.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 11:25:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 1/2] fuse: reflect cached blocksize if blocksize was changed
Date: Fri, 15 Aug 2025 11:25:38 -0700
Message-ID: <20250815182539.556868-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250815182539.556868-1-joannelkoong@gmail.com>
References: <20250815182539.556868-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out by Miklos[1], in the fuse_update_get_attr() path, the
attributes returned to stat may be cached values instead of fresh ones
fetched from the server. In the case where the server returned a
modified blocksize value, we need to cache it and reflect it back to
stat if values are not re-fetched since we now no longer directly change
inode->i_blkbits.

Link: https://lore.kernel.org/linux-fsdevel/CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com/ [1]

Fixes: 542ede096e48 ("fuse: keep inode->i_blkbits constant)
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/fuse/dir.c    | 1 +
 fs/fuse/fuse_i.h | 6 ++++++
 fs/fuse/inode.c  | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab26..ebee7e0b1cd3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1377,6 +1377,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 		generic_fillattr(idmap, request_mask, inode, stat);
 		stat->mode = fi->orig_i_mode;
 		stat->ino = fi->orig_ino;
+		stat->blksize = 1 << fi->cached_i_blkbits;
 		if (test_bit(FUSE_I_BTIME, &fi->state)) {
 			stat->btime = fi->i_btime;
 			stat->result_mask |= STATX_BTIME;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ec248d13c8bf..1647eb7ca6fa 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -210,6 +210,12 @@ struct fuse_inode {
 	/** Reference to backing file in passthrough mode */
 	struct fuse_backing *fb;
 #endif
+
+	/*
+	 * The underlying inode->i_blkbits value will not be modified,
+	 * so preserve the blocksize specified by the server.
+	 */
+	u8 cached_i_blkbits;
 };
 
 /** FUSE inode state bits */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 67c2318bfc42..3bfd83469d9f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -289,6 +289,11 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		}
 	}
 
+	if (attr->blksize)
+		fi->cached_i_blkbits = ilog2(attr->blksize);
+	else
+		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
+
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
 	 * to check permissions.  This prevents failures due to the
-- 
2.47.3


