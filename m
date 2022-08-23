Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE86859E85A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbiHWRBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbiHWQ7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642F331EC4
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661263983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvJBDnayJvUqadukdvJ+aiDopuGVk3vgU1r1hwgbino=;
        b=iAXZdRwoPsrEYTk6uS4l2mr6+xWHOr3oDR7wHoPjHvUj8yGaV11JTB7qbsORbzEgtKnEYB
        C48+SOjoEvIkNe+dFtbeiaLi1gyz6Lm0bFV/d5Ub+j3RuCu2eaksMRjamGjQXdZLYFjyrX
        sbqF36rlFhOJjyN5VQYeMg5JgXue7r0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-yYU6UjgkMmaDtPw6gXNbxw-1; Tue, 23 Aug 2022 10:12:58 -0400
X-MC-Unique: yYU6UjgkMmaDtPw6gXNbxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC50D38005CA;
        Tue, 23 Aug 2022 14:12:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB5BF2026D4C;
        Tue, 23 Aug 2022 14:12:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 7/7] cifs: Add some RDMA send tracepoints
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Aug 2022 15:12:56 +0100
Message-ID: <166126397621.708021.17666049570505935252.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some tracepoints to help trace RDMA in cifs.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cifs/smbdirect.c |   15 +++++++-
 fs/cifs/trace.h     |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 578c24d5a941..711beb3722e3 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1945,6 +1945,8 @@ static ssize_t smbd_post_send_iter_scanner(struct iov_iter *iter, const void *p,
 	ctx->len += len;
 	log_write(INFO, "sending page i=%d offset=%zu size=%zu remaining_data_length=%d\n",
 		  ix, offset, len, *ctx->_remaining_data_length);
+	trace_smb3_rdma_page(ctx->num_rqst, ctx->rqst_idx, ix, offset, len,
+			     iov_iter_count(iter), *ctx->_remaining_data_length);
 	*ctx->_remaining_data_length -= len;
 	ctx->nsg++;
 	return len;
@@ -2043,19 +2045,27 @@ int smbd_send(struct TCP_Server_Info *server,
 		klen += rqst->rq_iov[i].iov_len;
 	iov_iter_kvec(&iter, WRITE, rqst->rq_iov, rqst->rq_nvec, klen);
 
+	trace_smb3_rdma_send(num_rqst, rqst_idx, rqst->rq_nvec, klen,
+			     iov_iter_count(&rqst->rq_iter), remaining_data_length);
+
 	rc = smbd_post_send_iter(info, &iter, num_rqst, rqst_idx,
 				 &remaining_data_length);
-	if (rc < 0)
+	if (rc < 0) {
+		trace_smb3_rdma_fail(num_rqst, rqst_idx, 1, rc);
 		goto done;
+	}
 
 	if (iov_iter_count(&rqst->rq_iter) > 0) {
 		/* And then the data pages if there are any */
 		rc = smbd_post_send_iter(info, &rqst->rq_iter, num_rqst, rqst_idx,
 					 &remaining_data_length);
-		if (rc < 0)
+		if (rc < 0) {
+			trace_smb3_rdma_fail(num_rqst, rqst_idx, 2, rc);
 			goto done;
+		}
 	}
 
+	trace_smb3_rdma_done(num_rqst, rqst_idx, 3);
 	rqst_idx++;
 	if (rqst_idx < num_rqst)
 		goto next_rqst;
@@ -2282,6 +2292,7 @@ static ssize_t smbd_iter_to_mr_scanner(struct iov_iter *iter, const void *p,
 	sg_set_buf(&ctx->sgl[ix], p, len);
 	log_write(INFO, "sending page i=%d offset=%zu size=%zu\n",
 		  ix, offset, len);
+	trace_smb3_rdma_page(0, 0, ix, offset, len, iov_iter_count(iter), 0);
 	ctx->nsg++;
 	return len;
 }
diff --git a/fs/cifs/trace.h b/fs/cifs/trace.h
index 6b88dc2e364f..70640232b572 100644
--- a/fs/cifs/trace.h
+++ b/fs/cifs/trace.h
@@ -1055,6 +1055,101 @@ DEFINE_SMB3_CREDIT_EVENT(waitff_credits);
 DEFINE_SMB3_CREDIT_EVENT(overflow_credits);
 DEFINE_SMB3_CREDIT_EVENT(set_credits);
 
+TRACE_EVENT(smb3_rdma_send,
+	    TP_PROTO(unsigned int nr_rqst, unsigned int sub_rqst,
+		     unsigned int nr_kvec, unsigned int kvec_len,
+		     unsigned int iter_len, unsigned int remaining_len),
+	    TP_ARGS(nr_rqst, sub_rqst, nr_kvec, kvec_len, iter_len, remaining_len),
+	    TP_STRUCT__entry(
+		    __field(u8, nr_rqst)
+		    __field(u8, sub_rqst)
+		    __field(u8, nr_kvec)
+		    __field(unsigned int, kvec_len)
+		    __field(unsigned int, iter_len)
+		    __field(unsigned int, remaining_len)
+			     ),
+	    TP_fast_assign(
+		    __entry->nr_rqst = nr_rqst;
+		    __entry->sub_rqst = sub_rqst;
+		    __entry->nr_kvec = nr_kvec;
+		    __entry->kvec_len = kvec_len;
+		    __entry->iter_len = iter_len;
+		    __entry->remaining_len = remaining_len;
+			   ),
+	    TP_printk("nrq=%u/%u nkv=%u kvl=%u iter=%u rem=%u",
+		      __entry->sub_rqst + 1, __entry->nr_rqst,
+		      __entry->nr_kvec, __entry->kvec_len,
+		      __entry->iter_len, __entry->remaining_len)
+	    )
+
+TRACE_EVENT(smb3_rdma_page,
+	    TP_PROTO(unsigned int nr_rqst, unsigned int sub_rqst,
+		     unsigned int i, size_t offset, ssize_t len,
+		     unsigned int iter_len, unsigned int remaining_len),
+	    TP_ARGS(nr_rqst, sub_rqst, i, offset, len, iter_len, remaining_len),
+	    TP_STRUCT__entry(
+		    __field(u8, nr_rqst)
+		    __field(u8, sub_rqst)
+		    __field(unsigned int, iter_len)
+		    __field(unsigned int, remaining_len)
+		    __field(unsigned int, i)
+		    __field(size_t, offset)
+		    __field(ssize_t, len)
+			     ),
+	    TP_fast_assign(
+		    __entry->nr_rqst = nr_rqst;
+		    __entry->sub_rqst = sub_rqst;
+		    __entry->i = i;
+		    __entry->offset = offset;
+		    __entry->len = len;
+		    __entry->iter_len = iter_len;
+		    __entry->remaining_len = remaining_len;
+			   ),
+	    TP_printk("nrq=%u/%u pg=%u o=%zx l=%zx iter=%u rem=%u",
+		      __entry->sub_rqst + 1, __entry->nr_rqst,
+		      __entry->i, __entry->offset, __entry->len,
+		      __entry->iter_len, __entry->remaining_len)
+	    )
+
+TRACE_EVENT(smb3_rdma_done,
+	    TP_PROTO(unsigned int nr_rqst, unsigned int sub_rqst,
+		     unsigned int where),
+	    TP_ARGS(nr_rqst, sub_rqst, where),
+	    TP_STRUCT__entry(
+		    __field(u8, nr_rqst)
+		    __field(u8, sub_rqst)
+		    __field(u8, where)
+			     ),
+	    TP_fast_assign(
+		    __entry->nr_rqst = nr_rqst;
+		    __entry->sub_rqst = sub_rqst;
+		    __entry->where = where;
+			   ),
+	    TP_printk("nrq=%u/%u where=%u",
+		      __entry->sub_rqst + 1, __entry->nr_rqst, __entry->where)
+	    )
+
+TRACE_EVENT(smb3_rdma_fail,
+	    TP_PROTO(unsigned int nr_rqst, unsigned int sub_rqst,
+		     unsigned int where, int rc),
+	    TP_ARGS(nr_rqst, sub_rqst, where, rc),
+	    TP_STRUCT__entry(
+		    __field(u8, nr_rqst)
+		    __field(u8, sub_rqst)
+		    __field(u8, where)
+		    __field(short, rc)
+			     ),
+	    TP_fast_assign(
+		    __entry->nr_rqst = nr_rqst;
+		    __entry->sub_rqst = sub_rqst;
+		    __entry->where = where;
+		    __entry->rc = rc;
+			   ),
+	    TP_printk("nrq=%u/%u where=%u rc=%d",
+		      __entry->sub_rqst + 1, __entry->nr_rqst,
+		      __entry->where, __entry->rc)
+	    )
+
 #endif /* _CIFS_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


