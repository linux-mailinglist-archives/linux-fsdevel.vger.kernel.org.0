Return-Path: <linux-fsdevel+bounces-58903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9FDB33568
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A683AB66A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A8D276049;
	Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EPJH2niv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208311D130E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097039; cv=none; b=h3hA6W0U5CyfcRv2vSM4Grl3k/bKVtIuhJygbCgKe0asJJ3kUIlsgqjWQYxVRGM1LJcoM2tefMMSsrEKHZH28uhCMiJ1hCBZ5to4yy5qhu85yB3aGJoJF1ug3WqaW1FUXjSJb3Y5J+K5KgaT5KD/lqzJwIN29K2oyOGrKifGfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097039; c=relaxed/simple;
	bh=CzQrmpEbELJgaSqw2DsqlBJbXpOsr0TrnJEUbT4u66U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqNWP6VygaQXhEpI7IJ4DJry9PpVTWQzgJSl8QsaNlVNVf9+TGxnIe+dMJOItDq0Y6K5DlS6nBtpiCYoFYvxhzIbQiZDxStbHjLnqNcsOIWUKI/2ww7QBJRrLyoyFi+3+NSRWAzvCymvJjNhjNdFgAlWKDVYiGv+kDVuh5XBnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EPJH2niv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N4gJ4l8FdaRiUW/HlyTUwYAWphPSBZ/HZ8suRgfc8YQ=; b=EPJH2nivwjw3wb8AjkmLRbUp75
	W3Xe/U5cpkIzdMOYieT7xbPA19Xx6EK4F+vdyaLEIKr40wqeJpTfkhGQC6rdFRWZnhuT4xZZCSoaW
	z/nHkPLJxvQ+lmy9yqt0Jcx5G+IBoKx3SpK/TAysogYen+nkl8BE6x8R3pYTQjZcwq08Zjr7QjgA9
	KL6Oa78gAawLOHS3ig/xXdBhclq+hzc9ZG788503kYK1hwB5z93EIM30ARz2is1fQm2Cs1QlLKa4n
	tLcuVak6S9V60/L9IQJyhDHYd2NrzrvSXHqAo87QNXMWf2nFJ8snUJU0Ozk0x5WViVA8o+KTE4N15
	KQNn9e2A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3j-00000006T8F-3Ngz;
	Mon, 25 Aug 2025 04:43:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 02/52] introduced guards for mount_lock
Date: Mon, 25 Aug 2025 05:43:05 +0100
Message-ID: <20250825044355.1541941-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

mount_writer: write_seqlock; that's an equivalent of {un,}lock_mount_hash()
mount_locked_reader: read_seqlock_excl; these tend to be open-coded.

No bulk conversions, please - if nothing else, quite a few places take
use mount_writer form when mount_locked_reader is sufficent.  It needs
to be dealt with carefully.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 97737051a8b9..ed8c83ba836a 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -154,6 +154,11 @@ static inline void get_mnt_ns(struct mnt_namespace *ns)
 
 extern seqlock_t mount_lock;
 
+DEFINE_LOCK_GUARD_0(mount_writer, write_seqlock(&mount_lock),
+		    write_sequnlock(&mount_lock))
+DEFINE_LOCK_GUARD_0(mount_locked_reader, read_seqlock_excl(&mount_lock),
+		    read_sequnlock_excl(&mount_lock))
+
 struct proc_mounts {
 	struct mnt_namespace *ns;
 	struct path root;
-- 
2.47.2


