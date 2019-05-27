Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716F12B1D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfE0KI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 06:08:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36346 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0KI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 06:08:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4R9xvfg176866;
        Mon, 27 May 2019 10:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=7AwDZ11tjsv4yyZSMPazjv2aTAUgse+ixjzcawJvK6Q=;
 b=WPgrpcS1Yd2jjNTLQBdsbhE8wFjY6EqPa1EuLiPNNJRpXyixSy1s+t+gmu/J7+e1mV08
 UzOLdoaxO59WiKdyRkNAMQKiFR401KJ7I/cddDuKSdJz1/VZ5B8kruMm0i4dHLKqbfxk
 CnK+c69w2pzFkB4rcWT0UbfmY/GENoiaUCtEB4fmt04B1H13UFckMASgUTVI7dgOE2cv
 DCCTOk5K8iVH08c4zq85AhUvx7nODut53A33zir69lUsIWeR4U4aDPpuJk4U7sPp6PtH
 R6ERi1vlNIpSPLfk4RJbGWGN5H92xCrchIE4SYx8mZQYTpqO4eZdwOEFTfTGYu/MIWM9 Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7d5sem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 10:08:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4RA86ER166342;
        Mon, 27 May 2019 10:08:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31u5w44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 10:08:20 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4RA8JhO021937;
        Mon, 27 May 2019 10:08:19 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 03:08:19 -0700
Date:   Mon, 27 May 2019 13:08:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] io_uring: add support for sqe links
Message-ID: <20190527100808.GA31410@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905270072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905270071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jens Axboe,

The patch f3fafe4103bd: "io_uring: add support for sqe links" from
May 10, 2019, leads to the following static checker warning:

	fs/io_uring.c:623 io_req_link_next()
	error: potential NULL dereference 'nxt'.

fs/io_uring.c
   614  static void io_req_link_next(struct io_kiocb *req)
   615  {
   616          struct io_kiocb *nxt;
   617  
   618          nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
   619          list_del(&nxt->list);
                          ^^^^^^^^^
The warning is a false positive but this is a NULL dereference.

   620          if (!list_empty(&req->link_list)) {
   621                  INIT_LIST_HEAD(&nxt->link_list);
                                        ^^^^^
False positive.

   622                  list_splice(&req->link_list, &nxt->link_list);
   623                  nxt->flags |= REQ_F_LINK;
   624          }
   625  
   626          INIT_WORK(&nxt->work, io_sq_wq_submit_work);
                          ^^^^^^^^^^
   627          queue_work(req->ctx->sqo_wq, &nxt->work);
                                             ^^^^^^^^^^
Other bugs.

   628  }

regards,
dan carpenter
