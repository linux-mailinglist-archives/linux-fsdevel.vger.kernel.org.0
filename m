Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C016B5E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfGQF0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:26:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57886 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfGQF0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:26:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5Nn6d195628;
        Wed, 17 Jul 2019 05:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7Mqeu+q9XRNb38h+UJByUWeJBB24xXhRpmyFlmaDRv4=;
 b=ylVjWYf2eLBUlAHyjD/JOsnFKuaHrzTm38FcFAs9nVoxIAHaBnyLC+kUpmnkkyWx5G1y
 pBGoC0nSPowDnoIgWnnowfhni7jCDJqzP797XHJ+I8k4vV5PcUIFTqW9lXxWuMNFNnqd
 EeD64fUia8cCIhk7ejsC0oDaJJ5PETImtDsDrez+njtUN4nz0PRTuOVpy7pRfVe70Law
 ys5JBlV5xJSdZFE+g2J9GQNMFEkgcAaIAmFaxevm/n5CVayCgjggADm+NYaFIT10stah
 MPfU4K0oY7o7z/VNu5+WtySS2QMNzQJDiJMldqidxLvmjkF3hPM6NeWC1M9RV+COV1MY LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tq6qtrb5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:26:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5N8Mf027038;
        Wed, 17 Jul 2019 05:26:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tsctwru4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:26:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6H5QEIH007644;
        Wed, 17 Jul 2019 05:26:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 05:26:14 +0000
Date:   Tue, 16 Jul 2019 22:26:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Subject: Re: [PATCH 1/9] iomap: start moving code to fs/iomap/
Message-ID: <20190717052613.GA7093@magnolia>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321356685.148361.4004787941003993925.stgit@magnolia>
 <20190717045901.GA7113@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717045901.GA7113@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170066
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 16, 2019 at 09:59:01PM -0700, Christoph Hellwig wrote:
> On Mon, Jul 15, 2019 at 10:59:26AM -0700, Darrick J. Wong wrote:
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-newer
> > +#
> > +# Copyright (c) 2019 Oracle.
> > +# All Rights Reserved.
> > +#
> > +
> > +ccflags-y += -I $(srctree)/$(src)/..
> 
> Is this for the fs/internal.h include?  Can't we just include that
> using #include "../internal.h" ?

Er... yes, it would seem so.

--D
