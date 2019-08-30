Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B07CA3F66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 23:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfH3VGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 17:06:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43824 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfH3VGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:06:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UL4OP3052181;
        Fri, 30 Aug 2019 21:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=X0qTs6quRkeDzh6JsWpMpr4j3/R7HoLuineFF9PtkUM=;
 b=B6J8WGrLpX/O5g43lTMjZEkpBTejd35tNxHNpt0F+VEYkvu1AIzN3AX/f8mey1uyZGXe
 eGpblgYW9tYltwOQAhSbMDbi1nt6LfAkI2dRyIIm1DAnIfR1I7RP52+IYw6zTxr0Wxa+
 FMSAOFow9EtauioLvdND+3KysoaQirxMuZ95dGexrLWqmnAWAtGEC7ZbyTNhYpbhI5fi
 P8fzfNg5ztl8U7A3Jfv+ur1kG7CSObqkH4yoq5zqO99UKknvpuVeqdQ0F3FSJSyNunjs
 WXyGfuJHQ4Sf8m7KnmwF9w7ikDse1lMTKglkWdjb6M53fa0awMuoqyJRjnVgX3JBHy1Q mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uqbcx005j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 21:06:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UL4EII066304;
        Fri, 30 Aug 2019 21:06:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uphavq7k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 21:06:05 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7UL64xQ019365;
        Fri, 30 Aug 2019 21:06:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 14:06:04 -0700
Date:   Fri, 30 Aug 2019 14:06:03 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     viro@zeniv.linux.org.uk, andreas.gruenbacher@gmail.com
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2] splice: only read in as much information as there is pipe
 buffer space
Message-ID: <20190830210603.GB5340@magnolia>
References: <20190829161155.GA5360@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190829161155.GA5360@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300202
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300202
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Andreas Grünbacher reports that on the two filesystems that support
iomap directio, it's possible for splice() to return -EAGAIN (instead of
a short splice) if the pipe being written to has less space available in
its pipe buffers than the length supplied by the calling process.

Months ago we fixed splice_direct_to_actor to clamp the length of the
read request to the size of the splice pipe.  Do the same to do_splice.

Fixes: 17614445576b6 ("splice: don't read more than available pipe space")
Reported-by: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
v2: tidy up the other call site per Andreas' request
---
 fs/splice.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..2ddbace9129f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -945,12 +945,13 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	WARN_ON_ONCE(pipe->nrbufs != 0);
 
 	while (len) {
+		unsigned int pipe_pages;
 		size_t read_len;
 		loff_t pos = sd->pos, prev_pos = pos;
 
 		/* Don't try to read more the pipe has space for. */
-		read_len = min_t(size_t, len,
-				 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
+		pipe_pages = pipe->buffers - pipe->nrbufs;
+		read_len = min(len, (size_t)pipe_pages << PAGE_SHIFT);
 		ret = do_splice_to(in, &pos, pipe, read_len, flags);
 		if (unlikely(ret <= 0))
 			goto out_release;
@@ -1101,6 +1102,7 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 	struct pipe_inode_info *ipipe;
 	struct pipe_inode_info *opipe;
 	loff_t offset;
+	unsigned int pipe_pages;
 	long ret;
 
 	ipipe = get_pipe_info(in);
@@ -1123,6 +1125,10 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
+		/* Don't try to read more the pipe has space for. */
+		pipe_pages = opipe->buffers - opipe->nrbufs;
+		len = min(len, (size_t)pipe_pages << PAGE_SHIFT);
+
 		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
 	}
 
@@ -1180,8 +1186,13 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 
 		pipe_lock(opipe);
 		ret = wait_for_space(opipe, flags);
-		if (!ret)
+		if (!ret) {
+			/* Don't try to read more the pipe has space for. */
+			pipe_pages = opipe->buffers - opipe->nrbufs;
+			len = min(len, (size_t)pipe_pages << PAGE_SHIFT);
+
 			ret = do_splice_to(in, &offset, opipe, len, flags);
+		}
 		pipe_unlock(opipe);
 		if (ret > 0)
 			wakeup_pipe_readers(opipe);
