Return-Path: <linux-fsdevel+bounces-78097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AAsGDrhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8840317F3B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F557302D685
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84137F74B;
	Mon, 23 Feb 2026 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLxtgPq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB62125D0;
	Mon, 23 Feb 2026 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888904; cv=none; b=OVwsomAjUdZM9xe1dca4KNNNOe0E61/ZT9pfjAZsXpXNVcIJ/6REFWdLOEARpQxOVKjqKB/nLiOMtkmMATg9z701KzW8nlhvrHcWayQCUaAEpUBC7XZhPmpAWD79sfi5VJGpUOndOSWokXC4FVKB/6YSaKlgTjGDwtKg7ZYzhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888904; c=relaxed/simple;
	bh=2ExXhiQ7LSf7ejFkvpYrk1+pf8I1uwXW4N+XYOSkWPo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPsIprVsU80MlaUnQNhFMa/zqOnXhIeSdbu/hVd00k+1wPcroHzKNKv5I24mkQkMJ0lWScOhh1+8zl2nf51GIS+iNe2iYIh4ByXdkEAk5o7eduOkpgHH3D+FhaMF8FSBnPRaDNku44v5V44wDgZewTR9EmJU/CiqjE/3f4QvuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLxtgPq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901DEC116C6;
	Mon, 23 Feb 2026 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888903;
	bh=2ExXhiQ7LSf7ejFkvpYrk1+pf8I1uwXW4N+XYOSkWPo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cLxtgPq/ORbH6FUHST+p0ZRmAfWVgowfayZZY6VLOZAZ0BKXSl8TEaCrCB8YceUTE
	 VOsTaT4xnpiB3Gs0dMOgue/Ikz9sN7ykmE9b2ASc61s32FLzs/C5FsC4gw45Io6cXJ
	 0vbE2xBH1AAeAlASvdg57NZOOiyOQhbKmhaGW8w9mifedyqY/tt2FaaQhiuJ6aghdO
	 BSsClBhNXpsTNt11T/9uwo2eGIsembiLQCofRKO3Jf8orNGRSpjiZpLhdi+5Ycij8A
	 yaGQmsMncb5lg4teKhjAZS4RK55+1J5epuUkyG3jwwlHwC3DlFJ+NmT5fpEkCXwARi
	 sAXW8oVgFb85w==
Date: Mon, 23 Feb 2026 15:21:43 -0800
Subject: [PATCH 05/12] fuse: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736133.3937557.17194631382423434085.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
References: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78097-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8840317F3B7
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

The kernel doesn't know what the fuse server might have done in response
to truncate, fallocate, or ioend events.  Therefore, it must invalidate
the mapping cache after those operations to ensure cache coherency.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h       |    3 +++
 fs/fuse/fuse_iomap_cache.h |    9 +++++++++
 fs/fuse/file.c             |   18 ++++++++++--------
 fs/fuse/fuse_iomap.c       |   26 ++++++++++++++++++++++++--
 fs/fuse/fuse_iomap_cache.c |   27 +++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 10 deletions(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index bf6640c36465e1..efc8adbc4f31dc 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -68,6 +68,8 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  u64 written);
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
@@ -100,6 +102,7 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
diff --git a/fs/fuse/fuse_iomap_cache.h b/fs/fuse/fuse_iomap_cache.h
index dcd52c183f22ab..eba90d9519b8c3 100644
--- a/fs/fuse/fuse_iomap_cache.h
+++ b/fs/fuse/fuse_iomap_cache.h
@@ -99,6 +99,15 @@ enum fuse_iomap_lookup_result
 fuse_iomap_cache_lookup(struct inode *inode, enum fuse_iomap_iodir iodir,
 			loff_t off, uint64_t len,
 			struct fuse_iomap_lookup *mval);
+
+int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
+				      uint64_t length);
+static inline int fuse_iomap_cache_invalidate(struct inode *inode,
+					      loff_t offset)
+{
+	return fuse_iomap_cache_invalidate_range(inode, offset,
+						 FUSE_IOMAP_INVAL_TO_EOF);
+}
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_CACHE_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0b21fcdefffeb7..771885adf8a5e1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -101,7 +101,7 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync)
+static void fuse_file_put(struct fuse_file *ff, struct inode *inode, bool sync)
 {
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_release_args *ra = &ff->args->release_args;
@@ -385,7 +385,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, false);
+	fuse_file_put(ff, inode, false);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -416,7 +416,7 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 {
 	WARN_ON(refcount_read(&ff->count) > 1);
 	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
-	fuse_file_put(ff, true);
+	fuse_file_put(ff, fi ? &fi->inode : NULL, true);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -1043,7 +1043,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false);
+		fuse_file_put(ia->ff, inode, false);
 
 	fuse_io_free(ia);
 }
@@ -1907,7 +1907,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	fuse_file_put(wpa->ia.ff, false);
+	fuse_file_put(wpa->ia.ff, wpa->inode, false);
 
 	kfree(ap->folios);
 	kfree(wpa);
@@ -2064,7 +2064,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false);
+		fuse_file_put(ff, inode, false);
 
 	return err;
 }
@@ -2290,7 +2290,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 	}
 
 	if (data->ff)
-		fuse_file_put(data->ff, false);
+		fuse_file_put(data->ff, wpc->inode, false);
 
 	return error;
 }
@@ -3202,7 +3202,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		goto out;
 	}
 
-	if (!is_iomap)
+	if (is_iomap)
+		fuse_iomap_copied_file_range(inode_out, pos_out, bytes_copied);
+	else
 		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 59a2481f89626d..98e6db197a01d3 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -891,6 +891,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			fuse_iomap_inline_free(iomap);
 			if (err)
 				return err;
+			fuse_iomap_cache_invalidate_range(inode, pos, written);
 		} else {
 			fuse_iomap_inline_free(iomap);
 		}
@@ -979,7 +980,7 @@ fuse_iomap_setsize_finish(
 	trace_fuse_iomap_setsize_finish(inode, newsize, 0);
 
 	fi->i_disk_size = newsize;
-	return 0;
+	return fuse_iomap_cache_invalidate(inode, newsize);
 }
 
 /*
@@ -1064,10 +1065,12 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 
 	/*
 	 * If there weren't any ioend errors, update the incore isize, which
-	 * confusingly takes the new i_size as "pos".
+	 * confusingly takes the new i_size as "pos".  Invalidate cached
+	 * mappings for the file range that we just completed.
 	 */
 	fi->i_disk_size = outarg.newsize;
 	fuse_write_update_attr(inode, pos + written, written);
+	fuse_iomap_cache_invalidate_range(inode, pos, written);
 	return 0;
 }
 
@@ -1772,6 +1775,7 @@ void fuse_iomap_open_truncate(struct inode *inode)
 	trace_fuse_iomap_open_truncate(inode);
 
 	fi->i_disk_size = 0;
+	fuse_iomap_cache_invalidate(inode, 0);
 }
 
 struct fuse_writepage_ctx {
@@ -2466,6 +2470,14 @@ fuse_iomap_fallocate(
 
 	trace_fuse_iomap_fallocate(inode, mode, offset, length, new_size);
 
+	if (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE))
+		error = fuse_iomap_cache_invalidate(inode, offset);
+	else
+		error = fuse_iomap_cache_invalidate_range(inode, offset,
+							  length);
+	if (error)
+		return error;
+
 	/*
 	 * If we unmapped blocks from the file range, then we zero the
 	 * pagecache for those regions and push them to disk rather than make
@@ -2483,6 +2495,8 @@ fuse_iomap_fallocate(
 	 */
 	if (new_size) {
 		error = fuse_iomap_setsize_start(inode, new_size);
+		if (!error)
+			error = fuse_iomap_setsize_finish(inode, new_size);
 		if (error)
 			return error;
 
@@ -2604,3 +2618,11 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp)
 		return -EINVAL;
 	}
 }
+
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  u64 written)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fuse_iomap_cache_invalidate_range(inode, offset, written);
+}
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index 7fb5dd1198819f..4f30a27360b029 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -1444,6 +1444,33 @@ fuse_iomap_cache_remove(
 	return ret;
 }
 
+int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
+				      uint64_t length)
+{
+	loff_t aligned_offset;
+	const unsigned int blocksize = i_blocksize(inode);
+	int ret, ret2;
+
+	if (!fuse_inode_caches_iomaps(inode))
+		return 0;
+
+	aligned_offset = round_down(offset, blocksize);
+	if (length != FUSE_IOMAP_INVAL_TO_EOF) {
+		length += offset - aligned_offset;
+		length = round_up(length, blocksize);
+	}
+
+	fuse_iomap_cache_lock(inode);
+	ret = fuse_iomap_cache_remove(inode, READ_MAPPING,
+				      aligned_offset, length);
+	ret2 = fuse_iomap_cache_remove(inode, WRITE_MAPPING,
+				       aligned_offset, length);
+	fuse_iomap_cache_unlock(inode);
+	if (ret)
+		return ret;
+	return ret2;
+}
+
 static void
 fuse_iext_add_mapping(
 	struct fuse_iomap_cache		*ic,


