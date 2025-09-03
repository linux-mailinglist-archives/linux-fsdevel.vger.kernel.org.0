Return-Path: <linux-fsdevel+bounces-60050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB5B413C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B966816F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F12D481F;
	Wed,  3 Sep 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z+M9wksb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575962D0C8C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875343; cv=none; b=lsAh+QpChieEDiUGe3TZUeWbJSwld05rIzOo+8O0MK+9zyuW3dBsfFjYC4VrwNY2N3M7sriB16npa9qRnvdK6p11fSGms2RSyf6knRXfqHpGjdR/QabIF8cSr1KTIYl6UrteTW6g5NbJrH+rc7U9Z0L6p1hUJWaK5GpDUCKxJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875343; c=relaxed/simple;
	bh=NldpMd/BG+tIzOzH9HxoPUwVNitsD6PcQw5aatofNrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qnj4V2nvS9/tFDyp5KVSN/inP6BiY6LGyz1fo9ahJCB4UhUNhUFPB0SEZPhOuzPfX2VV8bOyVSSAKyxOLYx5NSgk+dQ1msde5g9kc3K+QFFEuwxHpqt9MtJdEzHl8+1WY+RSfivibbnq7cmwV7O7WIOnQULLeDOFasCBj41QpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z+M9wksb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yWmbE6uayI4XtylEdmRFBk+j0EjXTafvRicA8BrovhY=; b=Z+M9wksb5LE2X3SMJjRaWAzIon
	tAd8O0E+fTh9fc1gMAo8D4nqHMHTBi/TdNCHElnuZes7a0Y9yn9Du3VgbDUCCnp+cobWwNXGlE86t
	Wk67Sv8ZgFI/18zlotKMA0ulEfeNXU838xicQtLsbJytZIpU9buuxV1b5lftnIynlJwd4IylP1eMV
	ywVcoYE6gP0T922u4s8OxN/5OXCLtOJ96FK/S3VnCdWzvc/EzK+X4Up17bsKsKLfkJ9an7eQjdkxV
	3oWCzDz0Nu1qwdBO2KPX6b5keZeRpUcjXG5FV2Abh/A+qk2c8W9s4HNPcClcj4CT7ER2enUgd2wBI
	UrD+7MvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfWz-0000000Ap54-3spG;
	Wed, 03 Sep 2025 04:55:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 02/65] introduced guards for mount_lock
Date: Wed,  3 Sep 2025 05:54:23 +0100
Message-ID: <20250903045537.2579614-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
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


