Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE6C1FADCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 12:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgFPKVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 06:21:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41704 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPKVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:21:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GAILsT154365;
        Tue, 16 Jun 2020 10:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=j5kegrmGeTDSB0ig2F5qX6z4umw1vzMFuB/NKoAL+6c=;
 b=RuElR14UanHGq5GunllI0MWA4B7q6RgiHOJOW3YtQWOASZbTsfDa/oOdMoZIw0kjutoI
 QDhuv5rQiSpn1uqvmndFDFXQInxWZ+orRLp7ZUCnMIUXBiYJ+8o9/TP7i29o/LatvYas
 DjASjtipSEKsA8361yrxMDLKeII7jhCwJCWm+9t5R3sHeVpYh9NUym/VVkpRrSTPmQP6
 NXhZrfZGleZ4vaBbWsdvK15yNCEgnv9hCOo4t1CSLiwz1iaLaHXP5v2f2PU4pBC1HclN
 BZcbrNVrDmqWXNQLIUNxsUQ5/lb5NI2KwY+2mJA2PZRztiKnIt583eDx/m2r2T9b0Ca6 Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31p6s25w66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 10:20:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GADS4S196050;
        Tue, 16 Jun 2020 10:20:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31p6dcvwxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 10:20:58 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05GAKuxB004012;
        Tue, 16 Jun 2020 10:20:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 03:20:55 -0700
Date:   Tue, 16 Jun 2020 13:20:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Hulk Robot <hulkci@huawei.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v6] block: Fix use-after-free in blkdev_get()
Message-ID: <20200616102048.GL4282@kadam>
References: <20200616034002.2473743-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616034002.2473743-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=2
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=2 spamscore=0 cotscore=-2147483648 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160077
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:40:02AM +0800, Jason Yan wrote:
>
> Fixes: e525fd89d380 ("block: make blkdev_get/put() handle exclusive access")

I still don't understand how this is the correct fixes tag...  :/

git show e525fd89d380:fs/block_dev.c | cat -n
  1208  int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
  1209  {
  1210          struct block_device *whole = NULL;
  1211          int res;
  1212  
  1213          WARN_ON_ONCE((mode & FMODE_EXCL) && !holder);
  1214  
  1215          if ((mode & FMODE_EXCL) && holder) {
  1216                  whole = bd_start_claiming(bdev, holder);
  1217                  if (IS_ERR(whole)) {
  1218                          bdput(bdev);
  1219                          return PTR_ERR(whole);
  1220                  }
  1221          }
  1222  
  1223          res = __blkdev_get(bdev, mode, 0);
  1224  
  1225          if (whole) {
  1226                  if (res == 0)
                            ^^^^^^^^

  1227                          bd_finish_claiming(bdev, whole, holder);
  1228                  else
  1229                          bd_abort_claiming(whole, holder);
                                                  ^^^^^^^^^^^^^
If __blkdev_get() then this doesn't dereference "bdev" so it's not a
use after free bug.

  1230          }
  1231  
  1232          return res;
  1233  }

So far as I can see the Fixes tag should be what I said earlier.

Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_SET_FD")

Otherwise the patch looks good to me.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter
