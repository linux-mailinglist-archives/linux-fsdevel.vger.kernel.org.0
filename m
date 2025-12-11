Return-Path: <linux-fsdevel+bounces-71111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D285CB5D67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2D3303FE7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01CC311946;
	Thu, 11 Dec 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvZwf5EM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52593101DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455538; cv=none; b=DVs/Fz31u/rphzhFEOvE0p3atCBNKMfkjEXR4/T8g/xRpiylstk6gg5MAYoE7LSj0ksSZ0bSi9z6zhM9aEycuFSMCfEd7fpTdKkl/YyVidKlM5JCq2mWzlTXSMy87u1ujs22HRb6xY+m6VWR5QT21u58lfWQl4BEVHrTUn4kPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455538; c=relaxed/simple;
	bh=l9zo0EXonEq03TFI/f6JGfF7B1OyrUbKh6aUqoUh/vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWBAKEOnxEcWpAyQBPrQWCtg1+Vl2z+SRlHLZiKfO2T3t7ykoZPiav7OQ/HCLwG3wz0rZzSpU2DCHetC0p7O5/RdGD5VSPQR1K1oFJymQ2k6QyuE1AokvwG4SPoaPmO6cRO9LG0LAEb0pqQSoASn8yRypBrZ4HNttIG9XdE/aIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvZwf5EM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJBBsTnUoSekD8Jtjh4VEvFM2BerBPLv40YPx1hJJCY=;
	b=NvZwf5EMsW4Ytbg2o2kYJ9XeRV41AnjmD1eVDOGp6xx+7nuzEkBdxcETBSgVfTAYj3831f
	lljGG7yYyEeFmhB3gQkQ0kCvMZ6j6ajm6B7p0HnhbELx6Ati8wAdC7VVCTykIg1HeIb+2F
	ATuapA7xIE6tAjCqFIBTs2XnEeINT2U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-YtZfbOEFOAGZpslpj4TF5w-1; Thu,
 11 Dec 2025 07:18:49 -0500
X-MC-Unique: YtZfbOEFOAGZpslpj4TF5w-1
X-Mimecast-MFC-AGG-ID: YtZfbOEFOAGZpslpj4TF5w_1765455528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4BAC18009C0;
	Thu, 11 Dec 2025 12:18:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F8531956056;
	Thu, 11 Dec 2025 12:18:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] cifs: Scripted clean up fs/smb/client/reparse.h
Date: Thu, 11 Dec 2025 12:17:11 +0000
Message-ID: <20251211121715.759074-19-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/reparse.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index 19caab2fd11e..cfbb7dd28958 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -130,11 +130,12 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 				 struct cifs_fattr *fattr,
 				 struct cifs_open_info_data *data);
 int create_reparse_symlink(const unsigned int xid, struct inode *inode,
-				struct dentry *dentry, struct cifs_tcon *tcon,
-				const char *full_path, const char *symname);
-int mknod_reparse(unsigned int xid, struct inode *inode,
-		       struct dentry *dentry, struct cifs_tcon *tcon,
-		       const char *full_path, umode_t mode, dev_t dev);
-struct reparse_data_buffer *smb2_get_reparse_point_buffer(const struct kvec *rsp_iov, u32 *len);
+			   struct dentry *dentry, struct cifs_tcon *tcon,
+			   const char *full_path, const char *symname);
+int mknod_reparse(unsigned int xid, struct inode *inode, struct dentry *dentry,
+		  struct cifs_tcon *tcon, const char *full_path, umode_t mode,
+		  dev_t dev);
+struct reparse_data_buffer *smb2_get_reparse_point_buffer(const struct kvec *rsp_iov,
+							  u32 *plen);
 
 #endif /* _CIFS_REPARSE_H */


