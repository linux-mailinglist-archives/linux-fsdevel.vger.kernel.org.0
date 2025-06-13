Return-Path: <linux-fsdevel+bounces-51582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC5AD88F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242D53B9242
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1862D1F7E;
	Fri, 13 Jun 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NvjK0A4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D152C3773;
	Fri, 13 Jun 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809486; cv=none; b=Ljy15iAu7mL3SZl/mSOR+ToVBCjpNn6soQRMy1PhdMiVwlcDw1bYAzXA+gFNYUzOpQGGCKs1T7PWcj2XDQCDuwekVQDUk/aJ+yOdSWutBobmmb/OqMZCCN26f8WvH/2D2zaZ/MqV2W+w3AuWp77FsjzLbtQwf1ij/FJ4/qai6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809486; c=relaxed/simple;
	bh=F1Bp+O1Sq4yXgdlrMEsmrD+3X37+k99ziE9P3+ugjSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBG8rFBdxCkv2yvT/8qVU6si2DirjUhGy4t/1JiiGVF9w56uvGiKnQK5N66CxZ2jInYGZ3F7NV+B4TyMr+RGtzvlmqRFS2RmcKYqwnVT6PwK9vcf2F3iuV7HKI4vcXFejGojYX8bw8CNxW01q+kQBE39zHppzZWhYEdcZMk8w+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NvjK0A4/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gYxKXzXIak9Fpvjtc3ovkOUc5HITEe/tgyBCVkJhfAQ=; b=NvjK0A4/GlNQffNwIuM5bYoNua
	Mr4w+oViAkB/OYWyhXJOO7Lq3uTa0kXtRQcwFAftMDfHXiX0lBM4m7tw+IXqiXWRf0I3maDg6pI6m
	1R6llyLzEbPOKGyaw7jiKNSqkd9jAfoRbvgga5PALkEqymD7MjShaBJzkdsj5hFA5N2dXdsXCNXyw
	Xuio3u3gwSbq8INNtkErFRgPJH8R78LeVZ3ssEztiF/5zO6WOz/Kj1B7e/cRHsObSp9TnmcbH1JP/
	HmSXVCPNJrkteWmUB2n4fbBD7aadEkJgTLAa98OhIeiHIk1IXaQ8QrvUihz/6bg8LvLEoJ8f7Lsf3
	ivvJJJag==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQ1NV-002yBc-Hp; Fri, 13 Jun 2025 12:11:17 +0200
From: Luis Henriques <luis@igalia.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: drop assert in file_seek_cur_needs_f_lock
Date: Fri, 13 Jun 2025 11:11:11 +0100
Message-ID: <20250613101111.17716-1-luis@igalia.com>
In-Reply-To: <CAGudoHGfa28YwprFpTOd6JnuQ7KAP=j36et=u5VrEhTek0HFtQ@mail.gmail.com>
References: <CAGudoHGfa28YwprFpTOd6JnuQ7KAP=j36et=u5VrEhTek0HFtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assert in function file_seek_cur_needs_f_lock() can be triggered very
easily because there are many users of vfs_llseek() (such as overlayfs)
that do their custom locking around llseek instead of relying on
fdget_pos(). Just drop the overzealous assertion.

Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi!

As suggested by Mateusz, I'm adding a comment (also suggested by him!) to
replace the assertion.  I'm also adding the 'Suggested-by:' tags, although
I'm not sure it's the correct tag to use -- the authorship of this patch
isn't really clear at this point :-)

 fs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3a3146664cf3..b6db031545e6 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1198,8 +1198,12 @@ bool file_seek_cur_needs_f_lock(struct file *file)
 	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_shared)
 		return false;
 
-	VFS_WARN_ON_ONCE((file_count(file) > 1) &&
-			 !mutex_is_locked(&file->f_pos_lock));
+	/*
+	 * Note that we are not guaranteed to be called after fdget_pos() on
+	 * this file obj, in which case the caller is expected to provide the
+	 * appropriate locking.
+	 */
+
 	return true;
 }
 

