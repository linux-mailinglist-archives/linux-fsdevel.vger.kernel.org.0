Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452CD113FEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 12:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfLELJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 06:09:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:09:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5B9OtM059330;
        Thu, 5 Dec 2019 11:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=spceSgKURiY0yP5WdlVrEb1hiHITAlyGNnoLMw+XmH4=;
 b=oZu/8YhNK5+kx/xGiQ7opEr4CZOaBt+RRqWXmVJurxsJIb2zVIObrQXsvGmNXsFItpOQ
 0W/Adc/SJogGQ1uMSxTzikImxy/sFrz3+JEmAyUNkhO4W4KOdnEWBtn+0GRpn0yTGe/E
 UrgkpkzbBYgX4AP4aqZck4TB5/eZ7q2+ggYujgBXv1iJebPOslH6Cw0avODthnvxCnS3
 3UfR6x5ay4QboNuV8WmWznlfnSNqd6GSxuNqDYS59hRNll1msimkum4ixnO2SU6XDdSe
 3b5e8MfzLOUX5Y+g+I6U5HAtIy6JUioGLr6EFlNAsO5lWlk1kggeSkr9GhzH1hgLefsW OA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wkgcqmc4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 11:09:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5B9Ma8050844;
        Thu, 5 Dec 2019 11:09:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wptpu6119-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 11:09:22 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB5B8cpg030459;
        Thu, 5 Dec 2019 11:08:39 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:08:38 -0800
Date:   Thu, 5 Dec 2019 14:08:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] io_uring: ensure async punted read/write requests
 copy iovec
Message-ID: <20191205110832.GN1787@kadam>
References: <20191205110035.pghb4acsbfr43ycw@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205110035.pghb4acsbfr43ycw@kili.mountain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=810
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=866 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I see this was fixed in today's linux-next.  That was quick.  :)

regards,
dan caprenter


On Thu, Dec 05, 2019 at 02:00:35PM +0300, Dan Carpenter wrote:
> Hello Jens Axboe,
> 
> The patch f67676d160c6: "io_uring: ensure async punted read/write
> requests copy iovec" from Dec 2, 2019, leads to the following static
> checker warning:
> 
> 	fs/io_uring.c:2919 io_req_defer()
> 	warn: inconsistent returns 'irq'.
> 
> fs/io_uring.c
>   2891  static int io_req_defer(struct io_kiocb *req)
>   2892  {
>   2893          struct io_ring_ctx *ctx = req->ctx;
>   2894          struct io_async_ctx *io;
>   2895          int ret;
>   2896  
>   2897          /* Still need defer if there is pending req in defer list. */
>   2898          if (!req_need_defer(req) && list_empty(&ctx->defer_list))
>   2899                  return 0;
>   2900  
>   2901          io = kmalloc(sizeof(*io), GFP_KERNEL);
>   2902          if (!io)
>   2903                  return -EAGAIN;
>   2904  
>   2905          spin_lock_irq(&ctx->completion_lock);
>   2906          if (!req_need_defer(req) && list_empty(&ctx->defer_list)) {
>   2907                  spin_unlock_irq(&ctx->completion_lock);
>   2908                  kfree(io);
>   2909                  return 0;
>   2910          }
>   2911  
>   2912          ret = io_req_defer_prep(req, io);
>   2913          if (ret < 0)
>   2914                  return ret;
> 
> We need to spin_unlock_irq(&ctx->completion_lock); before returning.
> The question of if we need to kfree(io) is more complicated to me
> because I'm not sure how kiocb->ki_complete gets called...
> 
>   2915  
>   2916          trace_io_uring_defer(ctx, req, req->user_data);
>   2917          list_add_tail(&req->list, &ctx->defer_list);
>   2918          spin_unlock_irq(&ctx->completion_lock);
>   2919          return -EIOCBQUEUED;
>   2920  }
> 
> regards,
> dan carpenter
