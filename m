Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15F52C7C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiERXiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiERXiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:38:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414B1BA547
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:49 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IN6DVp013743
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UfD+h75jLCqmGcJIFVAad9rZN/r0VFdoC8EFOxTjfII=;
 b=i58D+I90ENcKWDEIn+39KABa/vBhgbCZ8c1ltuuinljhAvhwZ0ffU5CjGqzEx4x/iDpK
 /nIRvKZ+hTjP7eUGroFB44Cz5Q9ISafzTsU2CDfoPxWAtyqjk65HtGVMDIl0dAVsWywY
 T5iOilpf5MaEE4iWI/xtI6kqD0z4fw6Fp38= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4d823xjw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:48 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 18 May 2022 16:37:46 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 201BEF3ED873; Wed, 18 May 2022 16:37:13 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <shr@fb.com>, <david@fromorbit.com>, <jack@suse.cz>
Subject: [RFC PATCH v3 17/18] io_uring: Add tracepoint for short writes
Date:   Wed, 18 May 2022 16:37:08 -0700
Message-ID: <20220518233709.1937634-18-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220518233709.1937634-1-shr@fb.com>
References: <20220518233709.1937634-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TKD4CCbNzkH8WcTy9tcyBZcTgh6mPFyc
X-Proofpoint-ORIG-GUID: TKD4CCbNzkH8WcTy9tcyBZcTgh6mPFyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the io_uring_short_write tracepoint to io_uring. A short write
is issued if not all pages that are required for a write are in the page
cache and the async buffered writes have to return EAGAIN.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/io_uring.c                   |  3 +++
 include/trace/events/io_uring.h | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f3aaac286509..7435a9c2007f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4032,6 +4032,9 @@ static int io_write(struct io_kiocb *req, unsigned =
int issue_flags)
 		if (ret2 !=3D req->result && ret2 >=3D 0 && need_complete_io(req)) {
 			struct io_async_rw *rw;
=20
+			trace_io_uring_short_write(req->ctx, kiocb->ki_pos - ret2,
+						req->result, ret2);
+
 			/* This is a partial write. The file pos has already been
 			 * updated, setup the async struct to complete the request
 			 * in the worker. Also update bytes_done to account for
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_ur=
ing.h
index cddf5b6fbeb4..661834361d33 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -543,6 +543,31 @@ TRACE_EVENT(io_uring_req_failed,
 		  (unsigned long long) __entry->pad2, __entry->error)
 );
=20
+TRACE_EVENT(io_uring_short_write,
+
+	TP_PROTO(void *ctx, u64 fpos, u64 wanted, u64 got),
+
+	TP_ARGS(ctx, fpos, wanted, got),
+
+	TP_STRUCT__entry(
+		__field(void *,	ctx)
+		__field(u64,	fpos)
+		__field(u64,	wanted)
+		__field(u64,	got)
+	),
+
+	TP_fast_assign(
+		__entry->ctx	=3D ctx;
+		__entry->fpos	=3D fpos;
+		__entry->wanted	=3D wanted;
+		__entry->got	=3D got;
+	),
+
+	TP_printk("ring %p, fpos %lld, wanted %lld, got %lld",
+			  __entry->ctx, __entry->fpos,
+			  __entry->wanted, __entry->got)
+);
+
 #endif /* _TRACE_IO_URING_H */
=20
 /* This part must be outside protection */
--=20
2.30.2

