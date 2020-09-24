Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06362775CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgIXPub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:50:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgIXPub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:50:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OFZLxn125776;
        Thu, 24 Sep 2020 15:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=vn1696U5CRhKmLmc6mdwCozBnLCLObO7LgftVl1wh2o=;
 b=jGpN8isNZtCM5z7nsb1wBtRcRov8B0bLS4Y8Jgq8H3hJMgkHBgpw+B0j+n0iQtU6oW4a
 QX84oMRfxrda29DxxN+D1WO6Juo95LBcan1pWECxN045bzOeYSFit8QXthhoJDaQRbnU
 seFTga76zsuEvub1vBYax7ppb/U+L6mAumw2Mhgx2mEcIYPYMg5hWrJvCiudE1KCKong
 6dgAASGoNxvU+gi3A53HQylRFymVIzYtV5b4NqtIoeyAAlCFpl+JO5CMpcTFKUHNrPPx
 wq25IEd46NnTfcYJ10+Cju65COp21F54g/3/Y9TEogN0+CpBlb7kUPWjmg4Oti/cRVCh Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33q5rgqf43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 15:50:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OFUZHt054350;
        Thu, 24 Sep 2020 15:49:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33nurwbrpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 15:49:59 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OFnq1D012263;
        Thu, 24 Sep 2020 15:49:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 08:49:51 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@tron.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 03/13] bcache: inherit the optimal I/O size
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ft77maz5.fsf@ca-mkp.ca.oracle.com>
References: <20200924065140.726436-1-hch@lst.de>
        <20200924065140.726436-4-hch@lst.de>
Date:   Thu, 24 Sep 2020 11:49:48 -0400
In-Reply-To: <20200924065140.726436-4-hch@lst.de> (Christoph Hellwig's message
        of "Thu, 24 Sep 2020 08:51:30 +0200")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Inherit the optimal I/O size setting just like the readahead window,
> as any reason to do larger I/O does not apply to just readahead.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
