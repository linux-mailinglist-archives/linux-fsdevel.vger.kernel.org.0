Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14501EF634
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgFELLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 07:11:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgFELLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:11:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055B83lh168014;
        Fri, 5 Jun 2020 11:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ewGA2tK1MJb/nDf13NL3fAygRBoRCzb/PU2eg7IcvtE=;
 b=vmHgHKU/GHGV9FwOTVWJEitxYR5oZ2OjM82lWn8jXPLys/J2hiBKL/3FoLQ8kSDMMEN8
 dTraEpCr8zciqFBLj2owYktLWrf4eA+oi16DRSk0JJMpavfV8rEzbXYLcWLyMoPHcElV
 Cia620ZygGjCXpI88uJ03FIG9IbTmj7pFntrS0xlwG+E7IftFERD6SNqWVsef10ua/Oy
 0Jgona1+QEVAUVSXm7OUlOQqW1MB9CD3+5eAjkXUg0dpzbXo1l0rOk3nqy5vdHq9Gzlb
 2XRCJRXoq3kMj1DT3R+KgZImRieAoMT/KiN02IAzWBApRjDZ5S+Ye4pGXzgi3t8GILzp nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31f9242b9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 11:10:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055B7bj3036919;
        Fri, 5 Jun 2020 11:10:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31f925af9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 11:10:51 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055BAmZG002688;
        Fri, 5 Jun 2020 11:10:48 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 04:10:47 -0700
Date:   Fri, 5 Jun 2020 14:10:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Jason Yan <yanaijie@huawei.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
Message-ID: <20200605111039.GL22511@kadam>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
 <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=908
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=942 mlxscore=0 bulkscore=0
 lowpriorityscore=0 cotscore=-2147483648 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050086
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 12:56:45PM +0200, Markus Elfring wrote:
> > A lot of maintainers have blocked Markus and asked him to stop trying
> > to help people write commit message.
> 
> I am trying to contribute a bit of patch review as usual.
> 

We have asked you again and again to stop commenting on commit messages.
New kernel developers have emailed me privately to say that your review
comments confused and discouraged them.  Greg has created a email bot to
respond to your commit message reviews.

regards,
dan carpenter

