Return-Path: <linux-fsdevel+bounces-40378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C42FA22B81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D08188861B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223391B4257;
	Thu, 30 Jan 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bxE0Uk4l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEC7E0E4;
	Thu, 30 Jan 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232178; cv=none; b=ht+YtskqX3nKW7NMUnRjU7OQn1vDw5edQ53Jn7T/UNXv0TvabqhYdRBF8u2TnfU9RGfcfWOZkwH9pvEVkN3Ec2m/LbFia1Psvphf01zZVdoIVaiQ0WL10Lw5CyNT7cWXBi7cKcuUTLAN5+EBfLfQDZUmRpLPyiVfcHwFsrKJz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232178; c=relaxed/simple;
	bh=6t2zXN4YxljRx/vXZDspOyS30N6FKKbtJQadqdSknGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHJbaoAbcM9NJVH9Hkqa3WtviOYOhvMYXBjHRM3ld470radwPcnE1x1O48l99tM3uUKCMl9ITz8gj8POwe991T7GdwrFCTFegyhyh20lY3h5sDEjb3p9qCtJQM6Ilv+23+5yiHTxmFIWqcWd6UPj464bJS6QW2ifbaGxxbOseTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bxE0Uk4l; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mIRocafbsQchaH/RmQcoc6kKoJAc9tx9mXlvXIR/IDg=; b=bxE0Uk4lunItn6M/5UfFHM28gX
	JZUa3okJOiktqEywZoiX9R8KJLAweGBd1LM6iOkpJrjAzXqYm3VlWTBEOrSmDatCF7k1H0Uw+QkP2
	NzjOhy+jH5vS5lh52QmRCBd/mkvC2bgtQF3kVORU6hGXzD+HGvqZeC4rHsXELCSsNzB4d5XyPNJNM
	ovfIZBL4TP0MTKEdXJkw/yLXljCA6vSUNQNuvVQW+eAXpBQGYK0DVX9K9W80Ubq9t2zwHsg+49Bv8
	Tnu3SQzwYgYHRFxGfbI4aw+ZTJ2nzVPQslA7D5Q07Bhi/B3dFnby5uXrnW3mzb0ptv5Alf4S6dU5c
	J4moXt5g==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tdRae-000z5R-Hy; Thu, 30 Jan 2025 11:16:10 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>,
	Luis Henriques <luis@igalia.com>,
	Teng Qin <tqin@jumptrading.com>
Subject: [RFC PATCH v2] fuse: fix race in fuse_notify_store()
Date: Thu, 30 Jan 2025 10:16:07 +0000
Message-ID: <20250130101607.21756-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace filesystems can push data for a specific inode without it being
explicitly requested.  This can be accomplished by using NOTIFY_STORE.
However, this may race against another process performing different
operations on the same inode.

If, for example, there is a process reading from it, it may happen that it
will block waiting for data to be available (locking the folio), while the
FUSE server will also block trying to lock the same folio to update it with
the inode data.

The easiest solution, as suggested by Miklos, is to allow the userspace
filesystem to skip locked folios.

Link: https://lore.kernel.org/CH2PR14MB41040692ABC50334F500789ED6C89@CH2PR14MB4104.namprd14.prod.outlook.com
Reported-by: Teng Qin <tqin@jumptrading.com>
Originally-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi!

Here's v2.  Other than fixing the bug pointed out by Bernd (thanks!), I've
also added an explanation to the 'XXX' comment.  As a matter of fact, I've
took another look at that code, and I felt compelled to remove that comment,
as using PAGE_SIZE seems to be the right thing.

Anyway, I'm still thinking that probably NOTIFY_STORE should *always* have
this behaviour, without the need for userspace to explicitly setting a flag.

Changes since v1:
- Only skip if __filemap_get_folio() returns -EAGAIN (Bernd)

 fs/fuse/dev.c             | 30 +++++++++++++++++++++++-------
 include/uapi/linux/fuse.h |  8 +++++++-
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..309651f82ca4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1630,6 +1630,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	unsigned int num;
 	loff_t file_size;
 	loff_t end;
+	int fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
 
 	err = -EINVAL;
 	if (size < sizeof(outarg))
@@ -1645,6 +1646,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 	nodeid = outarg.nodeid;
 
+	if (outarg.flags & FUSE_NOTIFY_STORE_NOWAIT)
+		fgp_flags |= FGP_NOWAIT;
+
 	down_read(&fc->killsb);
 
 	err = -ENOENT;
@@ -1668,14 +1672,26 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		struct page *page;
 		unsigned int this_num;
 
-		folio = filemap_grab_folio(mapping, index);
-		err = PTR_ERR(folio);
-		if (IS_ERR(folio))
-			goto out_iput;
+		folio = __filemap_get_folio(mapping, index, fgp_flags,
+					    mapping_gfp_mask(mapping));
+		err = PTR_ERR_OR_ZERO(folio);
+		if (err) {
+			if (!(outarg.flags & FUSE_NOTIFY_STORE_NOWAIT) ||
+			    (err != -EAGAIN))
+				goto out_iput;
+			page = NULL;
+			/* XXX is it OK to use PAGE_SIZE here? */
+			this_num = min_t(unsigned int, num, PAGE_SIZE - offset);
+		} else {
+			page = &folio->page;
+			this_num = min_t(unsigned int, num,
+					 folio_size(folio) - offset);
+		}
 
-		page = &folio->page;
-		this_num = min_t(unsigned, num, folio_size(folio) - offset);
 		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		if (!page)
+			goto skip;
+
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (this_num == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, this_num, folio_size(folio));
@@ -1683,7 +1699,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		}
 		folio_unlock(folio);
 		folio_put(folio);
-
+skip:
 		if (err)
 			goto out_iput;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e9e78292d107..59725f89340e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -576,6 +576,12 @@ struct fuse_file_lock {
  */
 #define FUSE_EXPIRE_ONLY		(1 << 0)
 
+/**
+ * notify_store flags
+ * FUSE_NOTIFY_STORE_NOWAIT: skip locked pages
+ */
+#define FUSE_NOTIFY_STORE_NOWAIT	(1 << 0)
+
 /**
  * extension type
  * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
@@ -1075,7 +1081,7 @@ struct fuse_notify_store_out {
 	uint64_t	nodeid;
 	uint64_t	offset;
 	uint32_t	size;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_notify_retrieve_out {

