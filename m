Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA96F4AAA56
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380522AbiBERET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:04:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39856 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380520AbiBERES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:04:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A8060F35;
        Sat,  5 Feb 2022 17:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA4BC340E8;
        Sat,  5 Feb 2022 17:04:17 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/7] NFSD: Fix the behavior of READ near OFFSET_MAX
Date:   Sat,  5 Feb 2022 12:04:16 -0500
Message-Id:  <164408065651.3707.4991448334075576326.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
References:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153; h=from:subject:message-id; bh=mb0hVoMUywrkxJabWUlyIKENjk3YXQvFJ5VJMWyoMF4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh/q4QZGekyBIb5oYjRAcjCqCy5s0MoLzhiIClRHoy zy8zMnyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYf6uEAAKCRAzarMzb2Z/l0UHEA CdC09XeyoJtNDZ5cFOhJVx16XQDxS3VF9Rv8DCd0wMcjXQ6i7ANVFg6BIfnfMPVGTdG4+VosC8H8Hr z/S2RO8dKbeqriEE9wrqUFNhoDA6fGohrKEi3CkmuNyPs0fZTb4xssVXvWa/S4FAqgt27mlLDEEuM9 dBb0EiaWNJ5QeSu34OMitpk/K9t8jElvWBgpFG9Jhss4ConpHf8lujjGEiRzByI2sXzmuIRIakIyge 0g2vrqiIBnRWxkxj6OkGMxIUcmGnlRIe4s6w2oOJUiyCoK66IHeMUrWXScEyfjqdiAcsCz3jB28jU6 qPcQaZMZbQ8OZPRTCrLqgiOKsTzqQcZVEoJ84+wN4vvnjq2HyrNfgZpk1nLFngQt8q+PB9gRZGBaSv vg73KG9DCWimXJTqPCP6JUjU/8R6aiW/kMa1VaLRJzZjdiFMzfN6FvZ0Ykpjm7k8meUN/YE0s6vqHM eZovQa/m6XYlLi+qAvHoLvNhtMYvmRH5rDSBZK6CHWDrb2ywUzpl0CnmYr2LYBfrjHBkIBBnbtUrYV lxuSAO7Hel+H762350ua/cKKoZ+FddIt5QEgdQx5HkWL9HQ8dlSlQVWM9PwoLpPtpot2X4fwUYb3J5 zfFOs59tasbtFQmvKRpEd61gX2OVPrUtMTZlLWGr+zqg9bEEvts5aBM++1QA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Aloni reports:
> Due to commit 8cfb9015280d ("NFS: Always provide aligned buffers to
> the RPC read layers") on the client, a read of 0xfff is aligned up
> to server rsize of 0x1000.
>
> As a result, in a test where the server has a file of size
> 0x7fffffffffffffff, and the client tries to read from the offset
> 0x7ffffffffffff000, the read causes loff_t overflow in the server
> and it returns an NFS code of EINVAL to the client. The client as
> a result indefinitely retries the request.

The Linux NFS client does not handle NFS?ERR_INVAL, even though all
NFS specifications permit servers to return that status code for a
READ.

Instead of NFS?ERR_INVAL, have out-of-range READ requests succeed
and return a short result. Set the EOF flag in the result to prevent
the client from retrying the READ request. This behavior appears to
be consistent with Solaris NFS servers.

Note that NFSv3 and NFSv4 use u64 offset values on the wire. These
must be converted to loff_t internally before use -- an implicit
type cast is not adequate for this purpose. Otherwise VFS checks
against sb->s_maxbytes do not work properly.

Reported-by: Dan Aloni <dan.aloni@vastdata.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    8 ++++++--
 fs/nfsd/nfs4proc.c |    8 ++++++--
 fs/nfsd/nfs4xdr.c  |    8 ++------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 2c681785186f..b5a52528f19f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -150,13 +150,17 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	unsigned int len;
 	int v;
 
-	argp->count = min_t(u32, argp->count, max_blocksize);
-
 	dprintk("nfsd: READ(3) %s %lu bytes at %Lu\n",
 				SVCFH_fmt(&argp->fh),
 				(unsigned long) argp->count,
 				(unsigned long long) argp->offset);
 
+	argp->count = min_t(u32, argp->count, max_blocksize);
+	if (argp->offset > (u64)OFFSET_MAX)
+		argp->offset = (u64)OFFSET_MAX;
+	if (argp->offset + argp->count > (u64)OFFSET_MAX)
+		argp->count = (u64)OFFSET_MAX - argp->offset;
+
 	v = 0;
 	len = argp->count;
 	resp->pages = rqstp->rq_next_page;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ed1ee25647be..71d735b125a0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -782,12 +782,16 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 
 	read->rd_nf = NULL;
-	if (read->rd_offset >= OFFSET_MAX)
-		return nfserr_inval;
 
 	trace_nfsd_read_start(rqstp, &cstate->current_fh,
 			      read->rd_offset, read->rd_length);
 
+	read->rd_length = min_t(u32, read->rd_length, svc_max_payload(rqstp));
+	if (read->rd_offset > (u64)OFFSET_MAX)
+		read->rd_offset = (u64)OFFSET_MAX;
+	if (read->rd_offset + read->rd_length > (u64)OFFSET_MAX)
+		read->rd_length = (u64)OFFSET_MAX - read->rd_offset;
+
 	/*
 	 * If we do a zero copy read, then a client will see read data
 	 * that reflects the state of the file *after* performing the
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 899de438e529..f5e3430bb6ff 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3986,10 +3986,8 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	}
 	xdr_commit_encode(xdr);
 
-	maxcount = svc_max_payload(resp->rqstp);
-	maxcount = min_t(unsigned long, maxcount,
+	maxcount = min_t(unsigned long, read->rd_length,
 			 (xdr->buf->buflen - xdr->buf->len));
-	maxcount = min_t(unsigned long, maxcount, read->rd_length);
 
 	if (file->f_op->splice_read &&
 	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
@@ -4826,10 +4824,8 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		return nfserr_resource;
 	xdr_commit_encode(xdr);
 
-	maxcount = svc_max_payload(resp->rqstp);
-	maxcount = min_t(unsigned long, maxcount,
+	maxcount = min_t(unsigned long, read->rd_length,
 			 (xdr->buf->buflen - xdr->buf->len));
-	maxcount = min_t(unsigned long, maxcount, read->rd_length);
 	count    = maxcount;
 
 	eof = read->rd_offset >= i_size_read(file_inode(file));

