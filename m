Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4D1FAF80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFPLuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 07:50:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40966 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPLuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:50:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GBbelB098648;
        Tue, 16 Jun 2020 11:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Y9/FOWmEEqBP6lXX9J5VN2ObB6C/XvgQK6xWy2d/FXA=;
 b=GPGQEEU5JyVtFBAnqhplyAqsm2gn+7qCzTrMiaDFvSu97CRT1eaU4UTIfmabljSYmi4W
 Db26KIUj2IGBWFabh2e9mpWLWCIrilJ/KK9go8dVcWAnuj9itOVQxer4myRo5NSlME0r
 FhlVV/k1Z8xd3FnxlxFvzKw4XfvS2p2HBO19eBuNPTq/LMIpCSRS6Ts2BEoQQRH9ux24
 vvQygbu5OdLDZqeYAWMg+F8AGTBIa8VbQVeVChnKxlgYeqd0pXKoDsyWm16vCsNbxg4g
 TBKEVaDargMmg9YqS8aacvjYoLMkrpqPPgxWith2dynGOE0I4SjtcUGYTtjRZJN4oS9R FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31p6e5xbb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 11:49:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GBX676139009;
        Tue, 16 Jun 2020 11:49:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31p6dgcevk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 11:49:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05GBnn2N030373;
        Tue, 16 Jun 2020 11:49:50 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 04:49:49 -0700
Date:   Tue, 16 Jun 2020 14:49:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Hulk Robot <hulkci@huawei.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v6] block: Fix use-after-free in blkdev_get()
Message-ID: <20200616114942.GM4282@kadam>
References: <20200616034002.2473743-1-yanaijie@huawei.com>
 <20200616102048.GL4282@kadam>
 <3d0d8b5e-2adc-dc53-0bd2-7e28a58931f8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d0d8b5e-2adc-dc53-0bd2-7e28a58931f8@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 suspectscore=2 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160088
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 07:24:07PM +0800, Jason Yan wrote:
> This commit added accessing bdev->bd_mutex before checking res, which will
> cause use-after-free. So I think the fixes tag should be:
> 
> Fixes: 77ea887e433a ("implement in-kernel gendisk events handling")

Yeah.  That looks right.  I'm surprised it goes back so far.

regards,
dan carpenter

