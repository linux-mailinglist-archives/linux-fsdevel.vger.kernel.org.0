Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8304A6CFAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbfGRO2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 10:28:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47056 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRO2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:28:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IENx2Y044084;
        Thu, 18 Jul 2019 14:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=J9r9JlAuxE2aGKKJvVgk3Ep1Ee4jBkvxOBZiuSQLEgw=;
 b=rqBRRSXbS0tG1LrKio7DzJPy/LyEfaplc/ky1grlZEUhSaEYkIHbfVC2e6AilMFy7K4H
 DiOhnnKdvUHXgpjmB2yK9pHJJhxaw4q7ArWho7WHqzREa7hB6G9X9jBMTO1UIAEw15CF
 fyAOf9p/H9jQJhaUNsfVzdcL/mP/fNSX9z/Wgc4vivGnthkeb8D0lfqlPEC92bIXEbdh
 d7GZ4CTsG1WrbdI+MAtNYh0qZc600PTRsXOAVi6Va8QWyNEJDYG/VwuYEvSJ+XI2O4Jd
 mUkgGDcWjkN0m1wXgEXmW2s9AouGGIuRTXHKmXCivyI2gLQrW81RHWNBTgGmVRIzokH4 WQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tq7xr96vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 14:27:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IEMo2N041534;
        Thu, 18 Jul 2019 14:25:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ttc8fm6na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 14:25:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6IEPQMX020269;
        Thu, 18 Jul 2019 14:25:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jul 2019 14:25:26 +0000
Date:   Thu, 18 Jul 2019 07:25:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] iomap: hide iomap_sector with CONFIG_BLOCK=n
Message-ID: <20190718142525.GE7116@magnolia>
References: <20190718125509.775525-1-arnd@arndb.de>
 <20190718125703.GA28332@lst.de>
 <CAK8P3a2k3ddUD-b+OskpDfAkm6KGAGAOBabkXk3Uek1dShTiUA@mail.gmail.com>
 <20190718130835.GA28520@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718130835.GA28520@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907180150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907180150
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 03:08:35PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 18, 2019 at 03:03:15PM +0200, Arnd Bergmann wrote:
> > The inclusion comes from the recently added header check in commit
> > c93a0368aaa2 ("kbuild: do not create wrappers for header-test-y").
> > 
> > This just tries to include every header by itself to see if there are build
> > failures from missing indirect includes. We probably don't want to
> > add an exception for iomap.h there.
> 
> I very much disagree with that check.  We don't need to make every
> header compilable with a setup where it should not be included.

Seconded, unless there's some scenario where someone needs iomap when
CONFIG_BLOCK=n (???)

--D

> That being said if you feel this is worth fixing I'd rather define
> SECTOR_SIZE/SECTOR_SHIFT unconditionally.
