Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49210113FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 12:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfLELAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 06:00:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43636 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLELAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:00:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5Ap380038844;
        Thu, 5 Dec 2019 11:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=OJb+dI0KFb5+WLfPdVCTohlJEeAitQ7WsoSNALKskHA=;
 b=hlNwbXoBMJzKGdTBeDtmJRt9WoRV6G8daTyt2oHmfvQ1yLDsHzOdmsDdLYkRqX0eoj+l
 n+c67SYnJALVnGox4OomRH6JP6CsclHnI7OlcNFvIhC8mJWMfBuK4cEP+QDZtUy1uwMV
 qIsZ8Tkse63PQjGOrsj1rBxyGRDkaKcWXTDSRDDQfhxJPvbKSIr1sJDwOC1Gqy8qXhZR
 j3JAlBEMgvGoYxaT6lNdhZL96J3SCPbEbCGnTT75+s35ah5ccS6+u3ZxeFRNaysI8/6n
 Y2/QV2dSZZR/FyhIfOiYVp2NuGXnsfmKpqQInqLEmE5/uIePtpN0qjslOBmbpyF/TlUw Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wkh2rm91r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 11:00:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5Ao5SB000835;
        Thu, 5 Dec 2019 11:00:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wptpu52ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 11:00:48 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB5B0jBb005609;
        Thu, 5 Dec 2019 11:00:46 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:00:45 -0800
Date:   Thu, 5 Dec 2019 14:00:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [bug report] io_uring: ensure async punted read/write requests copy
 iovec
Message-ID: <20191205110035.pghb4acsbfr43ycw@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=565
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=628 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050089
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jens Axboe,

The patch f67676d160c6: "io_uring: ensure async punted read/write
requests copy iovec" from Dec 2, 2019, leads to the following static
checker warning:

	fs/io_uring.c:2919 io_req_defer()
	warn: inconsistent returns 'irq'.

fs/io_uring.c
  2891  static int io_req_defer(struct io_kiocb *req)
  2892  {
  2893          struct io_ring_ctx *ctx = req->ctx;
  2894          struct io_async_ctx *io;
  2895          int ret;
  2896  
  2897          /* Still need defer if there is pending req in defer list. */
  2898          if (!req_need_defer(req) && list_empty(&ctx->defer_list))
  2899                  return 0;
  2900  
  2901          io = kmalloc(sizeof(*io), GFP_KERNEL);
  2902          if (!io)
  2903                  return -EAGAIN;
  2904  
  2905          spin_lock_irq(&ctx->completion_lock);
  2906          if (!req_need_defer(req) && list_empty(&ctx->defer_list)) {
  2907                  spin_unlock_irq(&ctx->completion_lock);
  2908                  kfree(io);
  2909                  return 0;
  2910          }
  2911  
  2912          ret = io_req_defer_prep(req, io);
  2913          if (ret < 0)
  2914                  return ret;

We need to spin_unlock_irq(&ctx->completion_lock); before returning.
The question of if we need to kfree(io) is more complicated to me
because I'm not sure how kiocb->ki_complete gets called...

  2915  
  2916          trace_io_uring_defer(ctx, req, req->user_data);
  2917          list_add_tail(&req->list, &ctx->defer_list);
  2918          spin_unlock_irq(&ctx->completion_lock);
  2919          return -EIOCBQUEUED;
  2920  }

regards,
dan carpenter
