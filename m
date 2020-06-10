Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30D1F5B73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgFJSpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 14:45:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51410 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgFJSpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:45:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AIgJmh014952;
        Wed, 10 Jun 2020 18:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1i2A2+9puBFKPLIMqJKi2z6v2w00qEnRXR6SgosD4Nk=;
 b=mOayfhFPxbzJTIR5PVPB66eBwURPEVcdoyhgp96sIR9ddE3+gfG68MS9jmhd+HaDEoz5
 nmtpJ9c8LSWzvC6P3Gko0Oex4F21F/rcBmBN9lkJlUFkMAAh4LF6Ey4fOrHDhQNikHzY
 BBcEyPUJyWzAhrGsHxE5fF8qLJJXDXaU0H66QoHFcHBuAFlM6RscYP6qYrqvBYkPljRC
 LNd2PcOpRsSBfoYZzKZl1MyO5CvSYSxMH5uJ+EDItIAN0oFZPQ4hZifvFK2Ony6BrPu2
 tBHhLXNzA+5aDjAZ52sPS/IC6dkScbJhqQ4A5BBqQdSn4IvS9d9wvfYoaslKXRfiXZvp 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jrc1np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 18:45:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AIcQoU031618;
        Wed, 10 Jun 2020 18:45:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31gn29rb2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 18:45:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05AIjRHg009707;
        Wed, 10 Jun 2020 18:45:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 11:45:26 -0700
Date:   Wed, 10 Jun 2020 21:45:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH v2] exfat: add missing brelse() calls on error paths
Message-ID: <20200610184517.GC4282@kadam>
References: <20200610172213.GA90634@mwanda>
 <740ce77a-5404-102b-832f-870cbec82d56@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <740ce77a-5404-102b-832f-870cbec82d56@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100140
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:12:46PM +0200, Markus Elfring wrote:
> > If the second exfat_get_dentry() call fails then we need to release
> > "old_bh" before returning.  There is a similar bug in exfat_move_file().
> 
> Would you like to convert any information from this change description
> into an imperative wording?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=5b14671be58d0084e7e2d1cc9c2c36a94467f6e0#n151

I really feel like imperative doesn't add anything.  I understand that
some people feel really strongly about it, but I don't know why.  It
doesn't make commit messages more understandable.

The important thing is that the problem is clear, the fix is clear and
the runtime impact is clear.

regards,
dan carpenter

