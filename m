Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079111C6606
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 04:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgEFCvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 22:51:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33344 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgEFCvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 22:51:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0462lltK077198;
        Wed, 6 May 2020 02:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=jCqqKgpM8asHKf+svhKFWSe81G8Bv13YBWGByFY+J9M=;
 b=ZcTHlLcLIT5vNoDNCTaKg7hDbZqQWylFMqWFn6f9RlozbO0/OdUUAl7UKRkQxMPwNolW
 G8HxwJcZ8+Ht63DTGn5jUzatth1PZSNoJK5r5yVAXJnB9XspqLzA7xusMrZ/5LOYT1wq
 +eKfqQPs/tGv4jtD06/CeG4Zzu9pvIapOmIi0voH3wISGwZqjkgOgZ3/9BYWEV+lKXmA
 iLh0zPvxj+glCbMjMYw0qdrV1nYT31bchQnslNdHorvaiKsVGypIOJDI7XvCNpOe+CZ5
 G2ru7Z1fTdelOJMusrwQ5Tgc4ZJkH/u0WgXg8tTdHzY2Xo6H+Q75h6x/88pQPgV4fNoJ ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gn7s4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 02:51:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0462pQTN005223;
        Wed, 6 May 2020 02:51:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjngpdy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 02:51:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0462pPFb000300;
        Wed, 6 May 2020 02:51:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 May 2020 19:51:25 -0700
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v9 02/11] block: provide fallbacks for
 blk_queue_zone_is_seq and blk_queue_zone_no
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
        <20200428104605.8143-3-johannes.thumshirn@wdc.com>
Date:   Tue, 05 May 2020 22:51:22 -0400
In-Reply-To: <20200428104605.8143-3-johannes.thumshirn@wdc.com> (Johannes
        Thumshirn's message of "Tue, 28 Apr 2020 19:45:56 +0900")
Message-ID: <yq1pnbhai8l.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=922 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=967
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Johannes,

> blk_queue_zone_is_seq() and blk_queue_zone_no() have not been called
> with CONFIG_BLK_DEV_ZONED disabled until now.
>
> The introduction of REQ_OP_ZONE_APPEND will change this, so we need to
> provide noop fallbacks for the !CONFIG_BLK_DEV_ZONED case.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
