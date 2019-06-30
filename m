Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B105A5B005
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF3NzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33993 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfF3NzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:07 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so22805479iot.1;
        Sun, 30 Jun 2019 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbyL88War7tlisTcLGV7D4vb+5Xerz1Oy+IgjY4FXb8=;
        b=HUDBGBzdCCSeed2B8ywKy82Dby9rQVUSnj3XbsPOy38m2gMIHoXBYn0mMKq9fafBG5
         ACupvE34yjiNfrx0mY2ezdm3wFMsEDp54yw1fG/rbJZzBR7VGiwgTsuYajEUWUaWthJC
         xhDi1WEMA33kNMraoKnyBfmDYDu8qDFhnblB0UFBRpM07objedWjdtqtClT5ND712np1
         j4ncTZg3r4XL1Z2sXR1QauxiikuG/NKDACf8q7QwU5sNE8pGIOvpltvZspGDKs+Vlvsm
         eh7fa5iYH5dXF8eaW2jX+6zH/uJtkAVc+Dyk2LIf0u83wka7NoOJwVgL0X1/QX/vLAQF
         he1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbyL88War7tlisTcLGV7D4vb+5Xerz1Oy+IgjY4FXb8=;
        b=jKz/qwZi/XIL9wITA91aIdQ0gtu/j4ZrSmQoYkZgui2crVeiRaiXsXOiySZg2IPuZm
         32Fdf+/eSC4ConTkQlUlhraRdqtcQK0KPsAoE2eYyWNh+hmqsCNC4eQKdYvdp6D30/4R
         lsvEkVbrnnRgWNutigmaRbIsLaZbxgGOKQdjLMjyHHJsuZNDVmXLcYBhupmGan5uJILt
         GyMPu7XN1855w/oRlGRnmHwYoer7t4DAlvkbvgQFj6kcQWTPJKXG9hbIpc3AXGd6UPNQ
         nzFHrGTuZN1sDHgu5MkxHral9RCokmpz9HF2ToWtplVzbOK81IIEJW9QV4F9J4BClP8I
         IPkw==
X-Gm-Message-State: APjAAAUEGfhq6Hjkx2bNBLjS+8YfgJQgTVuZK9lIhWKNft7Gau/9kGfW
        n53VCoWGHjFHjBh1gibQc3VVCQ5fhA==
X-Google-Smtp-Source: APXvYqyVkzSuSUXehaGqKRuF8dWHl1HHTVG8+HJvZtvdIqFMnXSdvGq39i6a2oXcP4cXm5C8Ow+Gbg==
X-Received: by 2002:a5e:d615:: with SMTP id w21mr15890288iom.0.1561902905661;
        Sun, 30 Jun 2019 06:55:05 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:05 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/16] nfsd: hook up nfs4_preprocess_stateid_op to the nfsd_file cache
Date:   Sun, 30 Jun 2019 09:52:35 -0400
Message-Id: <20190630135240.7490-12-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-11-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
 <20190630135240.7490-7-trond.myklebust@hammerspace.com>
 <20190630135240.7490-8-trond.myklebust@hammerspace.com>
 <20190630135240.7490-9-trond.myklebust@hammerspace.com>
 <20190630135240.7490-10-trond.myklebust@hammerspace.com>
 <20190630135240.7490-11-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Have nfs4_preprocess_stateid_op pass back a nfsd_file instead of a filp.
Since we now presume that the struct file will be persistent in most
cases, we can stop fiddling with the raparms in the read code. This
also means that we don't really care about the rd_tmp_file field
anymore.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4proc.c  | 83 +++++++++++++++++++++++----------------------
 fs/nfsd/nfs4state.c | 24 ++++++-------
 fs/nfsd/nfs4xdr.c   | 14 ++++----
 fs/nfsd/state.h     |  2 +-
 fs/nfsd/xdr4.h      | 19 +++++------
 5 files changed, 68 insertions(+), 74 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beda999e134..cb51893ec1cd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -761,7 +761,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_read *read = &u->read;
 	__be32 status;
 
-	read->rd_filp = NULL;
+	read->rd_nf = NULL;
 	if (read->rd_offset >= OFFSET_MAX)
 		return nfserr_inval;
 
@@ -782,7 +782,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_filp, &read->rd_tmp_file);
+					&read->rd_nf);
 	if (status) {
 		dprintk("NFSD: nfsd4_read: couldn't process stateid!\n");
 		goto out;
@@ -798,8 +798,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_read_release(union nfsd4_op_u *u)
 {
-	if (u->read.rd_filp)
-		fput(u->read.rd_filp);
+	if (u->read.rd_nf)
+		nfsd_file_put(u->read.rd_nf);
 	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
 			     u->read.rd_offset, u->read.rd_length);
 }
@@ -954,7 +954,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL, NULL);
+				WR_STATE, NULL);
 		if (status) {
 			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!\n");
 			return status;
@@ -993,7 +993,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_write *write = &u->write;
 	stateid_t *stateid = &write->wr_stateid;
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 	__be32 status = nfs_ok;
 	unsigned long cnt;
 	int nvecs;
@@ -1005,7 +1005,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	trace_nfsd_write_start(rqstp, &cstate->current_fh,
 			       write->wr_offset, cnt);
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-						stateid, WR_STATE, &filp, NULL);
+						stateid, WR_STATE, &nf);
 	if (status) {
 		dprintk("NFSD: nfsd4_write: couldn't process stateid!\n");
 		return status;
@@ -1018,10 +1018,10 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				      &write->wr_head, write->wr_buflen);
 	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
-	status = nfsd_vfs_write(rqstp, &cstate->current_fh, filp,
+	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf->nf_file,
 				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
 				write->wr_how_written);
-	fput(filp);
+	nfsd_file_put(nf);
 
 	write->wr_bytes_written = cnt;
 	trace_nfsd_write_done(rqstp, &cstate->current_fh,
@@ -1031,8 +1031,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 static __be32
 nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
-		  stateid_t *src_stateid, struct file **src,
-		  stateid_t *dst_stateid, struct file **dst)
+		  stateid_t *src_stateid, struct nfsd_file **src,
+		  stateid_t *dst_stateid, struct nfsd_file **dst)
 {
 	__be32 status;
 
@@ -1040,22 +1040,22 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_nofilehandle;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
-					    src_stateid, RD_STATE, src, NULL);
+					    src_stateid, RD_STATE, src);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
 		goto out;
 	}
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-					    dst_stateid, WR_STATE, dst, NULL);
+					    dst_stateid, WR_STATE, dst);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
 		goto out_put_src;
 	}
 
 	/* fix up for NFS-specific error code */
-	if (!S_ISREG(file_inode(*src)->i_mode) ||
-	    !S_ISREG(file_inode(*dst)->i_mode)) {
+	if (!S_ISREG(file_inode((*src)->nf_file)->i_mode) ||
+	    !S_ISREG(file_inode((*dst)->nf_file)->i_mode)) {
 		status = nfserr_wrong_type;
 		goto out_put_dst;
 	}
@@ -1063,9 +1063,9 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	return status;
 out_put_dst:
-	fput(*dst);
+	nfsd_file_put(*dst);
 out_put_src:
-	fput(*src);
+	nfsd_file_put(*src);
 	goto out;
 }
 
@@ -1074,7 +1074,7 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
 	struct nfsd4_clone *clone = &u->clone;
-	struct file *src, *dst;
+	struct nfsd_file *src, *dst;
 	__be32 status;
 
 	status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
@@ -1082,11 +1082,11 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 
-	status = nfsd4_clone_file_range(src, clone->cl_src_pos,
-			dst, clone->cl_dst_pos, clone->cl_count);
+	status = nfsd4_clone_file_range(src->nf_file, clone->cl_src_pos,
+			dst->nf_file, clone->cl_dst_pos, clone->cl_count);
 
-	fput(dst);
-	fput(src);
+	nfsd_file_put(dst);
+	nfsd_file_put(src);
 out:
 	return status;
 }
@@ -1176,8 +1176,9 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	do {
 		if (kthread_should_stop())
 			break;
-		bytes_copied = nfsd_copy_file_range(copy->file_src, src_pos,
-				copy->file_dst, dst_pos, bytes_total);
+		bytes_copied = nfsd_copy_file_range(copy->nf_src->nf_file,
+				src_pos, copy->nf_dst->nf_file, dst_pos,
+				bytes_total);
 		if (bytes_copied <= 0)
 			break;
 		bytes_total -= bytes_copied;
@@ -1204,8 +1205,8 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
 		status = nfs_ok;
 	}
 
-	fput(copy->file_src);
-	fput(copy->file_dst);
+	nfsd_file_put(copy->nf_src);
+	nfsd_file_put(copy->nf_dst);
 	return status;
 }
 
@@ -1218,16 +1219,16 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 	memcpy(&dst->cp_res, &src->cp_res, sizeof(src->cp_res));
 	memcpy(&dst->fh, &src->fh, sizeof(src->fh));
 	dst->cp_clp = src->cp_clp;
-	dst->file_dst = get_file(src->file_dst);
-	dst->file_src = get_file(src->file_src);
+	dst->nf_dst = nfsd_file_get(src->nf_dst);
+	dst->nf_src = nfsd_file_get(src->nf_src);
 	memcpy(&dst->cp_stateid, &src->cp_stateid, sizeof(src->cp_stateid));
 }
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
 	nfs4_free_cp_state(copy);
-	fput(copy->file_dst);
-	fput(copy->file_src);
+	nfsd_file_put(copy->nf_dst);
+	nfsd_file_put(copy->nf_src);
 	spin_lock(&copy->cp_clp->async_lock);
 	list_del(&copy->copies);
 	spin_unlock(&copy->cp_clp->async_lock);
@@ -1264,8 +1265,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_copy *async_copy = NULL;
 
 	status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
-				   &copy->file_src, &copy->cp_dst_stateid,
-				   &copy->file_dst);
+				   &copy->nf_src, &copy->cp_dst_stateid,
+				   &copy->nf_dst);
 	if (status)
 		goto out;
 
@@ -1347,21 +1348,21 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		struct nfsd4_fallocate *fallocate, int flags)
 {
 	__be32 status;
-	struct file *file;
+	struct nfsd_file *nf;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &fallocate->falloc_stateid,
-					    WR_STATE, &file, NULL);
+					    WR_STATE, &nf);
 	if (status != nfs_ok) {
 		dprintk("NFSD: nfsd4_fallocate: couldn't process stateid!\n");
 		return status;
 	}
 
-	status = nfsd4_vfs_fallocate(rqstp, &cstate->current_fh, file,
+	status = nfsd4_vfs_fallocate(rqstp, &cstate->current_fh, nf->nf_file,
 				     fallocate->falloc_offset,
 				     fallocate->falloc_length,
 				     flags);
-	fput(file);
+	nfsd_file_put(nf);
 	return status;
 }
 static __be32
@@ -1406,11 +1407,11 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_seek *seek = &u->seek;
 	int whence;
 	__be32 status;
-	struct file *file;
+	struct nfsd_file *nf;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &seek->seek_stateid,
-					    RD_STATE, &file, NULL);
+					    RD_STATE, &nf);
 	if (status) {
 		dprintk("NFSD: nfsd4_seek: couldn't process stateid!\n");
 		return status;
@@ -1432,14 +1433,14 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * Note:  This call does change file->f_pos, but nothing in NFSD
 	 *        should ever file->f_pos.
 	 */
-	seek->seek_pos = vfs_llseek(file, seek->seek_offset, whence);
+	seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
 	if (seek->seek_pos < 0)
 		status = nfserrno(seek->seek_pos);
-	else if (seek->seek_pos >= i_size_read(file_inode(file)))
+	else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
 		seek->seek_eof = true;
 
 out:
-	fput(file);
+	nfsd_file_put(nf);
 	return status;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0e578ce11d1b..efd63bfbbcd0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5158,7 +5158,7 @@ nfs4_check_olstateid(struct nfs4_ol_stateid *ols, int flags)
 
 static __be32
 nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
-		struct file **filpp, bool *tmp_file, int flags)
+		struct nfsd_file **nfp, int flags)
 {
 	int acc = (flags & RD_STATE) ? NFSD_MAY_READ : NFSD_MAY_WRITE;
 	struct nfsd_file *nf;
@@ -5168,19 +5168,17 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 	if (nf) {
 		status = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
 				acc | NFSD_MAY_OWNER_OVERRIDE);
-		if (status)
+		if (status) {
+			nfsd_file_put(nf);
 			goto out;
+		}
 	} else {
 		status = nfsd_file_acquire(rqstp, fhp, acc, &nf);
 		if (status)
 			return status;
-
-		if (tmp_file)
-			*tmp_file = true;
 	}
-	*filpp = get_file(nf->nf_file);
+	*nfp = nf;
 out:
-	nfsd_file_put(nf);
 	return status;
 }
 
@@ -5190,7 +5188,7 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 __be32
 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct file **filpp, bool *tmp_file)
+		stateid_t *stateid, int flags, struct nfsd_file **nfp)
 {
 	struct inode *ino = d_inode(fhp->fh_dentry);
 	struct net *net = SVC_NET(rqstp);
@@ -5198,10 +5196,8 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	struct nfs4_stid *s = NULL;
 	__be32 status;
 
-	if (filpp)
-		*filpp = NULL;
-	if (tmp_file)
-		*tmp_file = false;
+	if (nfp)
+		*nfp = NULL;
 
 	if (grace_disallows_io(net, ino))
 		return nfserr_grace;
@@ -5238,8 +5234,8 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	status = nfs4_check_fh(fhp, s);
 
 done:
-	if (!status && filpp)
-		status = nfs4_check_file(rqstp, fhp, s, filpp, tmp_file, flags);
+	if (status == nfs_ok && nfp)
+		status = nfs4_check_file(rqstp, fhp, s, nfp, flags);
 out:
 	if (s)
 		nfs4_put_stid(s);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 52c4f6daa649..80bace0271bb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -49,6 +49,7 @@
 #include "cache.h"
 #include "netns.h"
 #include "pnfs.h"
+#include "filecache.h"
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #include <linux/security.h>
@@ -3586,11 +3587,14 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	unsigned long maxcount;
 	struct xdr_stream *xdr = &resp->xdr;
-	struct file *file = read->rd_filp;
+	struct file *file;
 	int starting_len = xdr->buf->len;
-	struct raparms *ra = NULL;
 	__be32 *p;
 
+	if (nfserr)
+		return nfserr;
+	file = read->rd_nf->nf_file;
+
 	p = xdr_reserve_space(xdr, 8); /* eof flag and byte count */
 	if (!p) {
 		WARN_ON_ONCE(test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags));
@@ -3608,18 +3612,12 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
 
-	if (read->rd_tmp_file)
-		ra = nfsd_init_raparms(file);
-
 	if (file->f_op->splice_read &&
 	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
 
-	if (ra)
-		nfsd_put_raparams(file, ra);
-
 	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 90baf5f2dd66..f0e9ee7fc62b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -607,7 +607,7 @@ struct nfsd4_copy;
 
 extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct file **filp, bool *tmp_file);
+		stateid_t *stateid, int flags, struct nfsd_file **filp);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		     stateid_t *stateid, unsigned char typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index feeb6d4bdffd..5eb3895afe0b 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -273,15 +273,14 @@ struct nfsd4_open_downgrade {
 
 
 struct nfsd4_read {
-	stateid_t	rd_stateid;         /* request */
-	u64		rd_offset;          /* request */
-	u32		rd_length;          /* request */
-	int		rd_vlen;
-	struct file     *rd_filp;
-	bool		rd_tmp_file;
+	stateid_t		rd_stateid;         /* request */
+	u64			rd_offset;          /* request */
+	u32			rd_length;          /* request */
+	int			rd_vlen;
+	struct nfsd_file	*rd_nf;
 	
-	struct svc_rqst *rd_rqstp;          /* response */
-	struct svc_fh * rd_fhp;             /* response */
+	struct svc_rqst		*rd_rqstp;          /* response */
+	struct svc_fh		*rd_fhp;             /* response */
 };
 
 struct nfsd4_readdir {
@@ -535,8 +534,8 @@ struct nfsd4_copy {
 
 	struct nfs4_client      *cp_clp;
 
-	struct file             *file_src;
-	struct file             *file_dst;
+	struct nfsd_file        *nf_src;
+	struct nfsd_file        *nf_dst;
 
 	stateid_t		cp_stateid;
 
-- 
2.21.0

