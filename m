Return-Path: <linux-fsdevel+bounces-41204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A45A2C50D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C275D3AAD4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66229222579;
	Fri,  7 Feb 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2EewEUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48922068B
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937451; cv=none; b=YSAB9hYi6MxnIPdYpL6wFXsFO2rrAA55KqtpNUblzoNHzRr2D9rhQ79atAcblehos31ZpNv/MvinQl1Ca+6JNnmNnIf437lBI4WIWJywhqw+RJCSnCBOYURTsE9VRSEzbOSXz/9S/++qouDLTBNQhzwLflx57Thc1xq9fT+yuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937451; c=relaxed/simple;
	bh=YOoh57KRzpNIqKH6m8cmjwV3Q4DhSp5RHZ1bSgr0oqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U080H+/5xu0Wo7f2JUR8rMQ3YW9EyTfgJYGsCVgPV+41UKEkeVPPuHB59Srsdrgme8u0cIOFEWPfqEKZlxemYnTcRmI7gCYpOJCbeg5IOh7iryte73sNwIEf6bS0d1QJYHGS0nGCxqBdfmiQdOWQJwCESq6KqOOER9V53v0zFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2EewEUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A383C4CED1;
	Fri,  7 Feb 2025 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738937451;
	bh=YOoh57KRzpNIqKH6m8cmjwV3Q4DhSp5RHZ1bSgr0oqU=;
	h=From:To:Cc:Subject:Date:From;
	b=V2EewEUmqFGH4Y3L19GVD0A/Hz77A/bGdHtAjy7Y9hVYkYznhWmVuMD2Qnzco0Hxi
	 8CPFiHt0gpmX2azjvygzrEXy+i42qK2c4IBDEBmHjvGTkJkNPfgMnOaEIk0i248xP2
	 go0xi1iSCDAdO/CoHd2QTZT2kkOy9Jzrtgt088Qo94coiuZYOehBE8BKiqidtN+Jpo
	 WOGrzSFTcOGPM+flN4Q2GdGDIHKth1bxB8WliB5A7d2axqaDUngiBYAfGIRbWO3lbA
	 lOVTK9Ep9/EB6u3mPMdQbdy0Zd7dRDfTg0khX/OYQBEK+6FWFKtCxjruiTW4SjSqMm
	 nvo549RQ6zeYA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: don't needlessly acquire f_lock
Date: Fri,  7 Feb 2025 15:10:33 +0100
Message-ID: <20250207-daten-mahlzeit-99d2079864fb@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=brauner@kernel.org; h=from:subject:message-id; bh=YOoh57KRzpNIqKH6m8cmjwV3Q4DhSp5RHZ1bSgr0oqU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvE0nd2fD7n2/7srJrRqFbrNfKfXt4xfGV9M3D2f8jz A/3fplxvqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiL8oZ/hlFdIpHN977f5BJ Vefsk5iInX6/lJKfPlQTzduekBeswsPwV+acuFmggtyRU0att9crCJdnTPetvVOt8zP/VYkrn/Y vHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Before 2011 there was no meaningful synchronization between
read/readdir/write/seek. Only in commit
ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
synchronization was added for SEEK_CUR by taking f_lock around
vfs_setpos().

Then in 2014 full synchronization between read/readdir/write/seek was
added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
for directories. At that point taking f_lock became unnecessary for such
files.

So only acquire f_lock for SEEK_CUR if this isn't a file that would have
acquired f_pos_lock if necessary.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/read_write.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index a6133241dfb8..816189f9c56d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -168,13 +168,23 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 		return offset;
 
 	if (whence == SEEK_CUR) {
+		bool locked;
+
 		/*
-		 * f_lock protects against read/modify/write race with
-		 * other SEEK_CURs. Note that parallel writes and reads
-		 * behave like SEEK_SET.
+		 * If the file requires locking via f_pos_lock we know
+		 * that mutual exclusion for SEEK_CUR on the same file
+		 * is guaranteed. If the file isn't locked, we take
+		 * f_lock to protect against f_pos races with other
+		 * SEEK_CURs.
 		 */
-		guard(spinlock)(&file->f_lock);
-		return vfs_setpos(file, file->f_pos + offset, maxsize);
+		locked = (file->f_mode & FMODE_ATOMIC_POS) ||
+			 file->f_op->iterate_shared;
+		if (!locked)
+			spin_lock(&file->f_lock);
+		offset = vfs_setpos(file, file->f_pos + offset, maxsize);
+		if (!locked)
+			spin_unlock(&file->f_lock);
+		return offset;
 	}
 
 	return vfs_setpos(file, offset, maxsize);
-- 
2.47.2


