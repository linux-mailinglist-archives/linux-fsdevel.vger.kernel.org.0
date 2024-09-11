Return-Path: <linux-fsdevel+bounces-29104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B1E9755E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A7328A1F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22914185952;
	Wed, 11 Sep 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JM3ErL2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05961AC436;
	Wed, 11 Sep 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065944; cv=none; b=n4OthD2s/GdQMpBlowG0tePaHMFMy8l38wjnG4+Eq8qFAvJd7HiFOclq0Yw4FJYXidz6NdTyIz2Jocj1rLBw1j3NyvIWfdXwW4VyWZ9LHwcgp9i3kfxNWKzfuK1AupS9FQKWHDHDjn5PvMmqYjGoE1U/jxU3/gvWJtNZITj4DFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065944; c=relaxed/simple;
	bh=W9Wi8Y+3FyQ4n9+LPtbm+LEcdkX09Opva/ZdK2u5bRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzPffUFool6qK/juZG02/8nv5JvDqsNF0Aj5HNf6dzd7am2xcWakeN3n6b3l1hhDndUeKqL8wdflXpaHOneW1LLIPzcOBBwLJDaXrJyGBDZQA339EuRVaExWPu9kN8Gmw9zMkN4wzBIPaJR07lMpcep8aLhkln1b83zYQXhvvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JM3ErL2m; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3FFQIAuGvH/0A1mPCgj4xlU1M+Y3nXSW60dESGxKvsQ=; b=JM3ErL2mdbpqkr+KcUJ1aszMzB
	jLUIm09KwRkExt16iFaCVWUoYp+LQYa1M8VbtDybGticsjAqAlWcY2NjwguRMr8P3SiiqOT+fbESB
	3KQTsCcWkDhdfP0wvYJ9Vge/dkxu7H24NfFYEYPIZmMHqhv7hW80CTFZQ94DizqdnAvx9ruoU02MG
	tAc2qt6fQ24oNqy7UUU6FxcXymXkkPUVxqlCjU9lrA6CjR+R7J546lGLArpOb7MISi5m+tQyBPemd
	+KDsSJsXEv+xrk2OD2lZ2WZpAziErf0cxqXrKqtZLXWYgrIq8V+vCRArNAZnX0WkvFBZKEqQJk5Ih
	m6IL6OTw==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1soOb6-00CTwi-Pc; Wed, 11 Sep 2024 16:45:33 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 05/10] libfs: Check for casefold dirs on simple_lookup()
Date: Wed, 11 Sep 2024 11:44:57 -0300
Message-ID: <20240911144502.115260-6-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911144502.115260-1-andrealmeid@igalia.com>
References: <20240911144502.115260-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On simple_lookup(), do not create dentries for casefold directories.
Currently, VFS does not support case-insensitive negative dentries and
can create inconsistencies in the filesystem. Prevent such dentries to
being created in the first place.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/libfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 99fb36b48708..838524314b1b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -77,6 +77,10 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
 		return ERR_PTR(-ENAMETOOLONG);
 	if (!dentry->d_sb->s_d_op)
 		d_set_d_op(dentry, &simple_dentry_operations);
+
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		return NULL;
+
 	d_add(dentry, NULL);
 	return NULL;
 }
-- 
2.46.0


