Return-Path: <linux-fsdevel+bounces-71862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4622BCD7564
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCAAE305058A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D8349B0F;
	Mon, 22 Dec 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLwejnlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E433987E
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442670; cv=none; b=uUj4Kd99muaYyQI7RtdKDjAldQKLu/Gbf7OXLvT22SY9N2HcOZf+eEI0FF3DOCn6dO4slWV+yor+3uHIKncj/nP9iLFf91A87KLjNEpK2xXhkcTb4DfD6EmEIs4paWw6XxXONTfNXye0+8nxoKGT0JJBfBiUDicoss80QA7kK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442670; c=relaxed/simple;
	bh=l9zo0EXonEq03TFI/f6JGfF7B1OyrUbKh6aUqoUh/vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYWrrYHhGjahxOg5aVGmRgvhR+2mcFoC5xH5HGBJVz8WU9zMTxRCjZvtrDhk62hmLNLCsYR6q0pSKRGsSACy3f7IgBaTb2PEVb8G2DoG1GJkwChDidzbSZRjyRndze8bxxbTkqv4xY+TidVOJbCmnum2uywtoRNVRmI9IjcoTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLwejnlx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJBBsTnUoSekD8Jtjh4VEvFM2BerBPLv40YPx1hJJCY=;
	b=dLwejnlxlmadnC/IsBekgnt0mNnaSRC3PQTednj7xmUXRalR0XtJWaNovaKS/ImejKIDFn
	FlQoR3ScNYXFlVbR91vDgrQeF8n+nPsvu8EGZfvfHwo5iBxGDrAcA6wG3ezfYLv5531XFZ
	3M+cgpFthCzVIIBdAKd56tnV4RXjitg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-Rzh3mCFFPAGEh4Ne7PYyRg-1; Mon,
 22 Dec 2025 17:31:05 -0500
X-MC-Unique: Rzh3mCFFPAGEh4Ne7PYyRg-1
X-Mimecast-MFC-AGG-ID: Rzh3mCFFPAGEh4Ne7PYyRg_1766442664
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A94A8195609F;
	Mon, 22 Dec 2025 22:31:04 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC00F30001A2;
	Mon, 22 Dec 2025 22:31:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/37] cifs: Scripted clean up fs/smb/client/reparse.h
Date: Mon, 22 Dec 2025 22:29:42 +0000
Message-ID: <20251222223006.1075635-18-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


