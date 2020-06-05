Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7651EFFB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgFESLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 14:11:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52808 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFESLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:11:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055I8CQ5102490;
        Fri, 5 Jun 2020 18:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=a4XaveQpAaQa2mw3il6Qi66Kdmgjqk/04IfyDbfuZOQ=;
 b=TOJoy37INOWoUNxh4EAkC3tJJh/ECSCuvtOhWAS4NSeZyCjRrCsD3Z6EetUvUSKmEpeZ
 E3ytfPKjbZvHXMkE1Swau4LvjbD5QlmLYz+FR3/6i34071X0mYTEReOpYGAdX4KGVbCp
 myCums3m3orFSmWW+bojM2PR10BZE0EX8efh9tHMtZg2v1HwZ+JhXz3bXXzUhdErnbFe
 IK3q+Ui7W47bNb+YTwqM4kpK2eT9tP5bLdgaroFCzxRztvvp+RtWr5v7XJhA2Mxft5F2
 ozk92BhoV8J20fNyWVJGvnWMPaD/Qq3hMbyn5ImjbQFbYgh9MDypv9SYYQkDz196ksQX OA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31f926445u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 18:10:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055I88MV181261;
        Fri, 5 Jun 2020 18:08:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31f928aagq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 18:08:58 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 055I8tPQ026391;
        Fri, 5 Jun 2020 18:08:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 11:08:54 -0700
Date:   Fri, 5 Jun 2020 21:08:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jason Yan <yanaijie@huawei.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hulkci@huawei.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
Message-ID: <20200605180845.GU30374@kadam>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
 <20200605144236.GB13248@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605144236.GB13248@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 04:42:36PM +0200, Jan Kara wrote:
> On Fri 05-06-20 12:43:54, Dan Carpenter wrote:
> > I wonder if maybe the best fix is to re-add the "if (!res) " check back
> > to blkdev_get().
> 
> Well, it won't be that simple since we need to call bd_abort_claiming()
> under bdev->bd_mutex. And the fact that __blkdev_get() frees the reference
> you pass to it is somewhat subtle and surprising so I think we are better
> off getting rid of that.

Fair enough.

Jason Yan sent a v3 of this patch that frees "whole".  I've looked it
over pretty close and I think it's probably correct.

(not that my opinion should count for much because I don't know this
code very well at all).

regards,
dan carpenter

