Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDDF248DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHRSMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 14:12:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgHRSL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:11:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IHvQ4w166027;
        Tue, 18 Aug 2020 18:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SViOGRVArP/KoUalqZ8HkB896YXmn3zWbyaQ3dkSGF0=;
 b=m4aZNhMAiQoYHwr13aXjaOvwnRPuFK7m04YUi5w+drh/DcnlOHhpM1s7DjHDHP5dvavI
 yh65ifgMa+tVKcSL7/SuRSIcB0Wbfepi09qYB3Yec9HIjdcOfbOIGrasmF0ThoGxzF9+
 MzExASVfFXD63E0dekktr/wHC06OibTupvz2ywRG0kjSJ22F2ue2ZJXDiklm1cbuc9Jq
 Ds74+j3V9C1ouiN3ysXAdAKBqEsqYJnZVWsiGWmNcEbOIGffZKR+vUoKj2Pxeanc0QKT
 wivyxPgOuc4bbYcJh0VMAvx80XX5H+8TB62m5dp8ERRbi4wQDJX6gfm2CNY7hPrHEx/A Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32x7nmeecy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 18:11:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IHwuD3040002;
        Tue, 18 Aug 2020 18:11:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32xsmxjcwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 18:11:45 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IIBhFe026233;
        Tue, 18 Aug 2020 18:11:43 GMT
Received: from localhost (/10.159.135.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 11:11:43 -0700
Date:   Tue, 18 Aug 2020 11:11:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V2] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200818181141.GE6090@magnolia>
References: <20200818134618.2345884-1-yukuai3@huawei.com>
 <20200818155305.GR17456@casper.infradead.org>
 <20200818161229.GK6107@magnolia>
 <20200818165019.GT17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818165019.GT17456@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 05:50:19PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 18, 2020 at 09:12:29AM -0700, Darrick J. Wong wrote:
> > On Tue, Aug 18, 2020 at 04:53:05PM +0100, Matthew Wilcox wrote:
> > > It would be better to use the same wording as below:
> > > 
> > > > +	bitmap_zero(iop->state, PAGE_SIZE * 2 / SECTOR_SIZE);
> > 
> > ISTR there was some reason why '512' was hardcoded in here instead of
> > SECTOR_SIZE.  I /think/ it was so that iomap.h did not then have a hard
> > dependency on blkdev.h and everything else that requires...
> 
> That ship already sailed.  I over-trimmed this line:
> 
> -       bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> 
> Looks like Christoph changed his mind sometime between that message
> and the first commit: 9dc55f1389f9569acf9659e58dd836a9c70df217

Aha, I think the complaint was about SECTOR_SIZE use in iomap.h, not the
fs/iomap/ code.  This patch doesn't touch the header.  I will stop
babbling and go back to reading it. ;)

--D

> My THP patches convert the bit array to be per-block rather than
> per-sector, so this is all going to go away soon ;-)
> 
> > https://lore.kernel.org/linux-xfs/20181215105155.GD1575@lst.de/
