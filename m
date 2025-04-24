Return-Path: <linux-fsdevel+bounces-47301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5252A9B9E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D705445D83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7562820A7;
	Thu, 24 Apr 2025 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpmFFcSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641284D34;
	Thu, 24 Apr 2025 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530151; cv=none; b=Aplhd952vDP0xHiMSnSaWgLWRuXFS5YlyNf5MvX/qR1ctpLY6lSJMrFr8izZv/j4m9iCPzbzNe3+PoAlYLvWXA8cuXRakx65ih2Xbx7zRl5HIzSUKo/oNJdbeFwxANZdJh4sS3/kUr2PQSRws48mfmE9p+1sy1HxYZBRXVwb/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530151; c=relaxed/simple;
	bh=abg2dZ2AhQEghrGF3YocOLv89mpM7zs0e52Pv+Ai5NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coGbipgZqyjKgbf5+gjSaOt5SqJG8tSIyCaFGIk8ULIC3tNgh8cIQ3yxCCrAbCDiupaJttXuaHZMgRVRMnI975hYJqJVNOn+wNoeaQN/AdsgCQ2R+hz9TI4v6OxqPTHs7MzckRFGY9ohhRWIRaPy2UkdbItpgIaGv27mG8w3Aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpmFFcSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256C3C4CEE3;
	Thu, 24 Apr 2025 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530150;
	bh=abg2dZ2AhQEghrGF3YocOLv89mpM7zs0e52Pv+Ai5NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpmFFcSjQPqbHOZorcWCaLu3XY5nmbOqQYQ0QXtmYXYjemMzBxSO+YfuOYk/YaCWE
	 pclTqEQJOWZy/P+dDAJICsRixlIHuCkx4oevV7w1zzKDvs/bpLmgB56PZBbRt54HXo
	 IimKYUQH9bZDAhr4QSISrYgN4W/2DZK9yaWBD1C+Z4PlhRcD0+VMFid4+K3MO1bGE2
	 4dQbfWDdL5brtTmg6BHqx54u24nFjRkojtPeeson+0gV2dMTvlZM+/nHjO/bYqIbYw
	 3v28d5Cs4NlMkPRzIFLagjmmb63NXI7plXX2gyxsWEnEDSK5XeIOkI8WyBpfc5uvmX
	 FygFOQQZNlLtg==
Date: Thu, 24 Apr 2025 17:29:09 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/3] NFS: add RWF_DONTCACHE support to LOCALIO
Message-ID: <aAqtJazDu6NDCvJ_@kernel.org>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745381692.git.trond.myklebust@hammerspace.com>

If DONTCACHE is used by the NFS client set NFS_IOHDR_DONTCACHE.  And
update LOCALIO so that it uses DONTCACHE, as a side-effect of setting
IOCB_DONTCACHE, if NFS_IOHDR_DONTCACHE was set.

Tweaked nfs_local_iocb_alloc() so that it uses kiocb_set_rw_flags().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c         | 27 +++++++++++++++++----------
 fs/nfs/pagelist.c        |  4 ++++
 fs/nfs/read.c            |  2 ++
 fs/nfs/write.c           |  2 ++
 include/linux/nfs_page.h |  1 +
 include/linux/nfs_xdr.h  |  1 +
 6 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index b1911d9b6be21..ee46eb3f65776 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -331,26 +331,30 @@ nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
 
 static struct nfs_local_kiocb *
 nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
-		     struct file *file, gfp_t flags)
+		     struct file *file, int type, gfp_t gfp)
 {
+	rwf_t flags = 0;
 	struct nfs_local_kiocb *iocb;
 
-	iocb = kmalloc(sizeof(*iocb), flags);
+	iocb = kmalloc(sizeof(*iocb), gfp);
 	if (iocb == NULL)
 		return NULL;
 	iocb->bvec = nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pagevec,
-			hdr->page_array.npages, flags);
-	if (iocb->bvec == NULL) {
-		kfree(iocb);
-		return NULL;
-	}
+			hdr->page_array.npages, gfp);
+	if (iocb->bvec == NULL)
+		goto out;
 
 	if (localio_O_DIRECT_semantics &&
 	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
 		iocb->kiocb.ki_filp = file;
 		iocb->kiocb.ki_flags = IOCB_DIRECT;
-	} else
+	} else {
 		init_sync_kiocb(&iocb->kiocb, file);
+		if (test_bit(NFS_IOHDR_DONTCACHE, &hdr->flags))
+			flags |= RWF_DONTCACHE;
+		if (flags && kiocb_set_rw_flags(&iocb->kiocb, flags, type))
+			goto out;
+	}
 
 	iocb->kiocb.ki_pos = hdr->args.offset;
 	iocb->hdr = hdr;
@@ -358,6 +362,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	iocb->aio_complete_work = NULL;
 
 	return iocb;
+out:
+	kfree(iocb);
+	return NULL;
 }
 
 static void
@@ -499,7 +506,7 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
 
-	iocb = nfs_local_iocb_alloc(hdr, file, GFP_KERNEL);
+	iocb = nfs_local_iocb_alloc(hdr, file, READ, GFP_KERNEL);
 	if (iocb == NULL)
 		return -ENOMEM;
 	iocb->localio = localio;
@@ -698,7 +705,7 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
 
-	iocb = nfs_local_iocb_alloc(hdr, file, GFP_NOIO);
+	iocb = nfs_local_iocb_alloc(hdr, file, WRITE, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
 	iocb->localio = localio;
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 11968dcb72431..eefda82c1ece8 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -824,6 +824,7 @@ void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
 		     int io_flags)
 {
 	desc->pg_moreio = 0;
+	desc->pg_dontcache = 0;
 	desc->pg_inode = inode;
 	desc->pg_ops = pg_ops;
 	desc->pg_completion_ops = compl_ops;
@@ -932,6 +933,9 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 		return desc->pg_error;
 	}
 
+	if (desc->pg_dontcache)
+		set_bit(NFS_IOHDR_DONTCACHE, &hdr->flags);
+
 	if ((desc->pg_ioflags & FLUSH_COND_STABLE) &&
 	    (desc->pg_moreio || nfs_reqs_to_commit(&cinfo)))
 		desc->pg_ioflags &= ~FLUSH_COND_STABLE;
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 81bd1b9aba176..51f4eaa1512bb 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -316,6 +316,8 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 		nfs_readpage_release(new, error);
 		goto out;
 	}
+	if (folio_test_dropbehind(folio))
+		pgio->pg_dontcache = 1;
 	return 0;
 out:
 	return error;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index e0ac439ab211b..88b7bd64c7864 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -684,6 +684,8 @@ static int nfs_page_async_flush(struct folio *folio,
 static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 			    struct nfs_pageio_descriptor *pgio)
 {
+	if (folio_test_dropbehind(folio))
+		pgio->pg_dontcache = 1;
 	nfs_pageio_cond_complete(pgio, folio->index);
 	return nfs_page_async_flush(folio, wbc, pgio);
 }
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 1a017b5b476fa..44bd9141820c4 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -118,6 +118,7 @@ struct nfs_pageio_descriptor {
 	u32			pg_mirror_idx;	/* current mirror */
 	unsigned short		pg_maxretrans;
 	unsigned char		pg_moreio : 1;
+	unsigned char		pg_dontcache : 1;
 };
 
 /* arbitrarily selected limit to number of mirrors */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 4f0d89893bcb8..3e82dea65c8c9 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1634,6 +1634,7 @@ enum {
 	NFS_IOHDR_RESEND_MDS,
 	NFS_IOHDR_UNSTABLE_WRITES,
 	NFS_IOHDR_ODIRECT,
+	NFS_IOHDR_DONTCACHE,
 };
 
 struct nfs_io_completion;
-- 
2.44.0


