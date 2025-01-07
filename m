Return-Path: <linux-fsdevel+bounces-38601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A50A0494C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 19:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FFE16478C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8591F4E29;
	Tue,  7 Jan 2025 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hxx+ugME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072561EBFE2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274914; cv=none; b=KwQglqdJwSDNT4v6fv/ZfMb/Qtq6PhZuQoY7n9Q6jwDlh0tG4Vpe9jgJ5HQXKsvQL1WzMjhORSaI7+Qt9b/HqZz3xhAFFgaKBR3OnSgGolDwHoT5eEAchQwghIQwH3BmbdegrVZcZWw/wQ03m+Rl7WvZzTem66TVXLqIKVvrXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274914; c=relaxed/simple;
	bh=M5p7ePPBNkYpcoERczixf1W0gMGDRFLHkB2szaz9aN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ox6TrQVXjjDGW0a9G8X9g0IYmIy6TEPTjU87XMUAoR92qRET6CYrN5iwkCB4+ZBq3QfeIxjRQ1Cm0KtD5T0ISJbL/R13vaOyP2ReS0LSlQBAAPA4USU5819F4Pkt3KyQs8XZe9MQ2cKizbsMBP6vNKMgHnIaVgGcf50Xitzf7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hxx+ugME; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736274910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HAy8KP8uW8+fxVBQ0kDAUsn1FGBX/4TFL4u84KCiPA=;
	b=Hxx+ugMEPwYNkPDkOqdWTIm1K1Ah31+8c7tPeurxHwBV3zPu37HCxqzsUDcyxWoTbPGZh/
	i5hqlNUUh9FySm8TbXgfNsnsHNCbsJU9jtyi87+uO9DX3vQ8DEZcbz3Ti+DZTL4tzC4ZAD
	nE1b84SA9Cgk6iEJliTQr4wV47xUwj4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-LeYqNbBwMlqCCf2BqVWjXQ-1; Tue,
 07 Jan 2025 13:35:06 -0500
X-MC-Unique: LeYqNbBwMlqCCf2BqVWjXQ-1
X-Mimecast-MFC-AGG-ID: LeYqNbBwMlqCCf2BqVWjXQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E2BA19560B8;
	Tue,  7 Jan 2025 18:35:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 805BF1956053;
	Tue,  7 Jan 2025 18:35:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] afs: Add rootcell checks
Date: Tue,  7 Jan 2025 18:34:50 +0000
Message-ID: <20250107183454.608451-3-dhowells@redhat.com>
In-Reply-To: <20250107183454.608451-1-dhowells@redhat.com>
References: <20250107183454.608451-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add some checks for the validity of the cell name.  It's may get put into a
symlink, so preclude it containing any slashes or "..".  Also disallow
starting/ending with a dot.  This makes /afs/@cell/ as a symlink less of a
security risk.

Also disallow multiple setting of /proc/net/afs/rootcell for any given
network namespace.  Once set, the value may not be changed.  This makes it
easier to only create /afs/@cell and /afs/.@cell if there's a rootcell.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c | 8 ++++++++
 fs/afs/proc.c | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 1aba6d4d03a9..cee42646736c 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -367,6 +367,14 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 		len = cp - rootcell;
 	}
 
+	if (len == 0 || !rootcell[0] || rootcell[0] == '.' || rootcell[len - 1] == '.')
+		return -EINVAL;
+	if (memchr(rootcell, '/', len))
+		return -EINVAL;
+	cp = strstr(rootcell, "..");
+	if (cp && cp < rootcell + len)
+		return -EINVAL;
+
 	/* allocate a cell record for the root cell */
 	new_root = afs_lookup_cell(net, rootcell, len, vllist, false);
 	if (IS_ERR(new_root)) {
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 15eab053af6d..e7614f4f30c2 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -240,7 +240,13 @@ static int afs_proc_rootcell_write(struct file *file, char *buf, size_t size)
 	/* determine command to perform */
 	_debug("rootcell=%s", buf);
 
-	ret = afs_cell_init(net, buf);
+	ret = -EEXIST;
+	inode_lock(file_inode(file));
+	if (!net->ws_cell)
+		ret = afs_cell_init(net, buf);
+	else
+		printk("busy\n");
+	inode_unlock(file_inode(file));
 
 out:
 	_leave(" = %d", ret);


