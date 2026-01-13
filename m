Return-Path: <linux-fsdevel+bounces-73364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4079D163A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1148F305FC52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3D51F3B85;
	Tue, 13 Jan 2026 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AtKhp3Nz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56EE285CA9;
	Tue, 13 Jan 2026 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269115; cv=none; b=YYTpzwRbp77ZZrAbmIT3pQOL1YJNOvTP2ZxRtrIvheyE8rkJWuT/vlwDrGWFJSn9SSs1Z1hhuwn0xWAzyB832RoNXawbT76YhxWBWetr/x0KTay085GkrfIOv8rfqyxOHho72bjnNDIJeTyOBATPY9f157WgOLu0wZOfnEoDEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269115; c=relaxed/simple;
	bh=sLCPq0OcSGPqPYmGCSndEj0RGX9tSBGu+ndjRmXoPM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJDxvNUQZbxL370HxUy7Y5nH5SkgUx3PcuXLwRtoYmY6qXhaH3Am69SlGTq1/QBjcqHVT00kuUAMShWqLgchDiCtQuPErBf2UOJODqK7ucmkvhCaRDeo2StJdVJbMHvUtc+4rzM0bDy7KFfUoqxEhHXlbFcPkTrk+Ykh/kDjwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AtKhp3Nz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q3KY/QclWt7xEzREN3uba7eKw5lgckSwPwxnU2hYqew=; b=AtKhp3Nz/TH5GP/i2KVG2TOs9G
	UX2Nr78Jbu/XV1VxNZdRz0AHOrDADSr39SWgRNp/YtGvckbmegFWYLtNkcem7ezre1Bmmnx8EclBj
	ayI6b4HrBWbACsTtL4isH402cwHxoBqTJHccPzkY12STKAmYjMZaeH0dzFnVIUO80R4XnB809r8Or
	SZhYJ7Aio8/70Iw16AAAFwq2TjC2js6/svCcRLcEVGrQWTyMwo9wbAlGxwUBPAy4QVBgCDj80K1Z8
	82xjVbT5342CWbGQrevsy2PfON2qZ2GUSIWdEHHiqofufzjRTvrcAyZ+8a1bTNN+DOQHLIU35N/Sn
	3Wi1lD8Q==;
Received: from [179.118.187.16] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfTZS-004eIK-K1; Tue, 13 Jan 2026 02:51:46 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 12 Jan 2026 22:51:25 -0300
Subject: [PATCH 2/4] exportfs: Mark struct export_operations functions at
 kernel-doc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-tonyk-fs_uuid-v1-2-acc1889de772@igalia.com>
References: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
In-Reply-To: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Adding a `@` before the function names make then recognizable as
kernel-docs, so they get correctly rendered in the documentation.

Even if they are already marked with `@` in the short one-line summary,
the kernel-docs will correctly favor the more detailed definition here.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Should I just remove the short descriptions?
---
 include/linux/exportfs.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 599ea86363e1..bed370b9f906 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -203,7 +203,7 @@ struct handle_to_path_ctx {
  * See Documentation/filesystems/nfs/exporting.rst for details on how to use
  * this interface correctly.
  *
- * encode_fh:
+ * @encode_fh:
  *    @encode_fh should store in the file handle fragment @fh (using at most
  *    @max_len bytes) information that can be used by @decode_fh to recover the
  *    file referred to by the &struct dentry @de.  If @flag has CONNECTABLE bit
@@ -215,7 +215,7 @@ struct handle_to_path_ctx {
  *    greater than @max_len*4 bytes). On error @max_len contains the minimum
  *    size(in 4 byte unit) needed to encode the file handle.
  *
- * fh_to_dentry:
+ * @fh_to_dentry:
  *    @fh_to_dentry is given a &struct super_block (@sb) and a file handle
  *    fragment (@fh, @fh_len). It should return a &struct dentry which refers
  *    to the same file that the file handle fragment refers to.  If it cannot,
@@ -227,29 +227,29 @@ struct handle_to_path_ctx {
  *    created with d_alloc_root.  The caller can then find any other extant
  *    dentries by following the d_alias links.
  *
- * fh_to_parent:
+ * @fh_to_parent:
  *    Same as @fh_to_dentry, except that it returns a pointer to the parent
  *    dentry if it was encoded into the filehandle fragment by @encode_fh.
  *
- * get_name:
+ * @get_name:
  *    @get_name should find a name for the given @child in the given @parent
  *    directory.  The name should be stored in the @name (with the
  *    understanding that it is already pointing to a %NAME_MAX + 1 sized
  *    buffer.   get_name() should return %0 on success, a negative error code
  *    or error.  @get_name will be called without @parent->i_rwsem held.
  *
- * get_parent:
+ * @get_parent:
  *    @get_parent should find the parent directory for the given @child which
  *    is also a directory.  In the event that it cannot be found, or storage
  *    space cannot be allocated, a %ERR_PTR should be returned.
  *
- * permission:
+ * @permission:
  *    Allow filesystems to specify a custom permission function.
  *
- * open:
+ * @open:
  *    Allow filesystems to specify a custom open function.
  *
- * commit_metadata:
+ * @commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
  *
  * Locking rules:

-- 
2.52.0


