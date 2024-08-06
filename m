Return-Path: <linux-fsdevel+bounces-25148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1739496C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0041C228D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E18249F;
	Tue,  6 Aug 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8M8M1pP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B522A7E0F4;
	Tue,  6 Aug 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965339; cv=none; b=LvDvaAOcjz4YQsj2HJb1qSRnE1stdl9whS5V5Ctg8dFpdeX+gDt/TNMH2hbaj//Bj64xvq2pm88sexauzrCLivnwViu8Y2wzy5gyVr4B3OCDMar9doOlVgtya+Spfi0cnIjIt2JB3c/eF00YW5go2OdEMN6J00ymB6g7dh4G4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965339; c=relaxed/simple;
	bh=X842CkaX8ejeaW2YO0SgZZKAjE8EILrUDqN98w2j1rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gohAw4chWKueQgwMOU9d/G+8zylJ29DN+JpeaxLOXKTBeAdgOcu2WnCc52+3d11GbKA9p/SM9Pj/CTyisDk5xWzbJU7Vq0medVattYjAr9V/pbERhXZlTnlnNQ+nu9+aELWuU0RnRRmcRZrxkXLZK/ehSFIB99s7z37xSGhpTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8M8M1pP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so104785a12.1;
        Tue, 06 Aug 2024 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965336; x=1723570136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujnAwmdGFvuyJq9MA7ZWWv+B03DWbj05+2k+MGpkGkE=;
        b=C8M8M1pPh8FZNRoOBf57AqPuKprJdibrE0cX6a5RaDUwQ7vylL5dEyr20DwxDsdwYi
         4YZYDBZWLnXh+v6FPqYY7O2fnlp/pWO9nMojzUp8XcOyBD3JiP3L9IwQO1uVlsUnkSCP
         CmeAaE8LAv/M6mc7Q+3/caqwNPexvRa9jERAwCiFdsOoyk5XizQvjJE2aA026Q3GgGOQ
         Ulb0Ckr5voQoBGnfZJO4UMTVXgF+AzZyXiyZXHlzgpiKWpmT/LoOIT6P8sFNrkSYsUBY
         bneRAs0vk6ja4RxnuIcrNysW66EdsAyzJM5vhu9Gz2DGU1wmTbsns4rlLp3HM3/9J4/2
         nbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965336; x=1723570136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujnAwmdGFvuyJq9MA7ZWWv+B03DWbj05+2k+MGpkGkE=;
        b=AMTbqYLvOSzTdF3kI66DPZXdi/9FAYTjf3W9SJYjgHrdAEA2ixBvD3Hys0E8qs+4XY
         XSCWCElOkWiAnj9CqtuX+yYHX9aqV/A621BoBpBFW1y7sDWe3MpxVTrngWITwlhPB0jt
         hjVqgJbZ7Wo21krjJ9M/nuksYGP5zqHnpJ/OxEJN5MPu0qLog7aF+3jg1dV2CUQGPQXG
         0ZQd2gm2rHZzkxnqhz9mZ7LAWqDc88SOmLi+BTM2t2vt0rTl4xqeGiZWH1J4jJJzPbcF
         a7smMEky582DhacMnekl0PZJty+PrO7m73PXun8swfiUckxmvJDxa3Oh1EigNaAF6Keg
         VXWw==
X-Forwarded-Encrypted: i=1; AJvYcCWWFkjWlP5yh8rrIxuh0tHjf4IyprbAJJ99LXWbV3InqBsbTJrf/ez+b3ycOqRdiSVVybBL3G6oA3hyi1cK8/vEfv4womxlSdfbSHTF3fNz9ldPcTkBc5wR8AjLls4H0FU+kejQv6xMx01QqQ==
X-Gm-Message-State: AOJu0YxCP7BdVJC/nHkWGXH8ufVKdQFcYe6DFFywzkODm72gMudiO8/y
	Fl1HebKxQ3afj7TvDIRRQ9EDpaeJMJ81Ot4TU2wAbpIrfvwRYxZK
X-Google-Smtp-Source: AGHT+IFKPhCdfkk+wH8CaxeVrNRwW/5koTrkAnQVDIZjCas7Nj+w8AtD16+K7fpR41oXtEtCnkyghw==
X-Received: by 2002:a17:907:868d:b0:a77:cdae:6a59 with SMTP id a640c23a62f3a-a7dbe6302e4mr1469581866b.21.1722965335899;
        Tue, 06 Aug 2024 10:28:55 -0700 (PDT)
Received: from f.. (cst-prg-92-246.cust.vodafone.cz. [46.135.92.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437f5sm560098466b.125.2024.08.06.10.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:28:55 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: dodge smp_mb in break_lease and break_deleg in the common case
Date: Tue,  6 Aug 2024 19:28:46 +0200
Message-ID: <20240806172846.886570-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These inlines show up in the fast path (e.g., in do_dentry_open()) and
induce said full barrier regarding i_flctx access when in most cases the
pointer is NULL.

The pointer can be safely checked before issuing the barrier, dodging it
in most cases as a result.

It is plausible the consume fence would be sufficient, but I don't want
to go audit all callers regarding what they before calling here.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

the header file has locks_inode_context and i even found users like
this (lease_get_mtime):

ctx = locks_inode_context(inode);
if (ctx && !list_empty_careful(&ctx->flc_lease)) {

however, without looking further at the code I'm not confident this
would be sufficient here -- for all I know one consumer needs all stores
to be visible before looking further after derefing the pointer

keeping the full fence in place makes this reasonably easy to reason
about the change i think, but someone(tm) willing to sort this out is
most welcome to do so

 include/linux/filelock.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index daee999d05f3..bb44224c6676 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -420,28 +420,38 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
 #ifdef CONFIG_FILE_LOCKING
 static inline int break_lease(struct inode *inode, unsigned int mode)
 {
+	struct file_lock_context *flctx;
+
 	/*
 	 * Since this check is lockless, we must ensure that any refcounts
 	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
 	 * could end up racing with tasks trying to set a new lease on this
 	 * file.
 	 */
+	flctx = READ_ONCE(inode->i_flctx);
+	if (!flctx)
+		return 0;
 	smp_mb();
-	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
+	if (!list_empty_careful(&flctx->flc_lease))
 		return __break_lease(inode, mode, FL_LEASE);
 	return 0;
 }
 
 static inline int break_deleg(struct inode *inode, unsigned int mode)
 {
+	struct file_lock_context *flctx;
+
 	/*
 	 * Since this check is lockless, we must ensure that any refcounts
 	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
 	 * could end up racing with tasks trying to set a new lease on this
 	 * file.
 	 */
+	flctx = READ_ONCE(inode->i_flctx);
+	if (!flctx)
+		return 0;
 	smp_mb();
-	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
+	if (!list_empty_careful(&flctx->flc_lease))
 		return __break_lease(inode, mode, FL_DELEG);
 	return 0;
 }
-- 
2.43.0


