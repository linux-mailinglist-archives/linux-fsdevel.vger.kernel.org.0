Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC008BF1C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfIZLdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 07:33:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58446 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIZLdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:33:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QBXe8O067365;
        Thu, 26 Sep 2019 11:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zWXdMe+A/TotuM/50XpV6/Om9WZNyrsPWTih8I2CTNM=;
 b=ki1vXU2JOb2GaUNwCwsg02FN6HjI4TP7r7IdeK6rPSmXAkQCns/OHNeBIAY8nNWosBJg
 qHwVXxOoy113lfqGJz45+tgz5uL4bYmVT1E5rD6r7OB8ZKin5j4z3Dk1dvj2Kf92evp9
 vxAtOplMqnYggY5n6SguunckV2kbImTWGdyQSeY+GWGVoyxT2CMD5Us6FwTwUIr1/WBq
 fVGnV5OMxYPdOoAFmanYiBfHXmn2wuWdQ+M2QDaA8WIQ7mnSXvy9NK/D4Vjd/gBX8gUB
 KSXX8mi1D1lBoOewq9Uc6PHc74k/rZFIfWI0CICtYVZyJDglaJ+34xbd2HMZ3ZASbkic +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v5btqb1ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 11:33:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QBX58o049230;
        Thu, 26 Sep 2019 11:33:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2v82tn018u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 11:33:40 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8QBXdSI020726;
        Thu, 26 Sep 2019 11:33:39 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 04:33:38 -0700
Date:   Thu, 26 Sep 2019 14:33:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] io_uring: ensure variable ret is initialized to
 zero
Message-ID: <20190926113329.GE27389@kadam>
References: <20190926095012.31826-1-colin.king@canonical.com>
 <3aa821ea-3041-fb56-2458-ec643963c511@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa821ea-3041-fb56-2458-ec643963c511@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260111
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 11:56:30AM +0200, Jens Axboe wrote:
> On 9/26/19 11:50 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > In the case where sig is NULL the error variable ret is not initialized
> > and may contain a garbage value on the final checks to see if ret is
> > -ERESTARTSYS.  Best to initialize ret to zero before the do loop to
> > ensure the ret does not accidentially contain -ERESTARTSYS before the
> > loop.
> 
> Oops, weird it didn't complain. I've folded in this fix, as that commit
> isn't upstream yet. Thanks!

There is a bug in GCC where at certain optimization levels, instead of
complaining, it initializes it to zero.

regards,
dan carpenter

