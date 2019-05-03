Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D805012CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfECLoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 07:44:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42120 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfECLoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 07:44:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43BdQ35061107;
        Fri, 3 May 2019 11:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/lUSL6u6dCv+qk16245uxZt1XSGKYM9t/rlDDOHNkoM=;
 b=RxZCYN0gGG+lQ+eUhZU3ekXqD8QfSg69uur9UTnrN9aU1f9+Ggw+y5LXgk6EOXcU4JCQ
 2k83xHsdvNPIs3UiadOfmOuBfxRV3UJLAjac3a9+lnaNMCk+97wpdHWu5FS3/9U774bm
 zJyd8fDi2tZpEVzaDhsQdezf1YjUyc8DwLDrBQwcXeiQqh3GvhWz1IWvOu6oACsCwYC3
 bU79La0Rm9+XSLjl2tTglB3nuZ+keGvYxPbPQQLkC04rbKY5k9OG2nqVZbu4eg23+9KW
 8kvLfMr1+4HpVBdesZOaOnigRpEUjQUbEhwauuN03U8ZTed3Lu/wFXMh8903i3l1kMcE 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s6xhyp62p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 11:43:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43BgnR4145790;
        Fri, 3 May 2019 11:43:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2s7rtc82w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 11:43:54 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x43BhqvR005877;
        Fri, 3 May 2019 11:43:53 GMT
Received: from mwanda (/196.104.111.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 04:43:52 -0700
Date:   Fri, 3 May 2019 14:43:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] io_uring: Potential Oops in io_sq_offload_start()
Message-ID: <20190503114334.GA16540@mwanda>
References: <20190404104527.GX4038@hirez.programming.kicks-ass.net>
 <20190408081513.GB15239@kadam>
 <20190430092619.GC2239@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430092619.GC2239@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030074
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=894 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030074
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:26:19PM +0300, Dan Carpenter wrote:
> The io_uring patches are slated for v5.7 so we should figure out a
> solution for this bug.
> 

Never mind.  We merged a different fix.  975554b03edd
("io_uring: fix SQPOLL cpu validation").

regards,
dan carpenter

