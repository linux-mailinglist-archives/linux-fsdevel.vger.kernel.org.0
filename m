Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACEA13D433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 07:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgAPGSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 01:18:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44390 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgAPGSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:18:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G6Df5J006639;
        Thu, 16 Jan 2020 06:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=thM1DU+ci72geM1S8as2qtc2X97JclnuS2KhKwDxVtM=;
 b=gbaHBSoUq9DJ0mkHpuVLRvItOlqO/0ixqhK7g0BIV5DtMWrLd0FBvD2AWyggbML1zx/s
 0/z5qydhFCw1y5nBlNLXx/5zy9ofMSb0MC5MVSvRHK0/34x9CtJTmbUwxyxuxqqG2+Fo
 JeAEKnd/nTvY5uGY5vYQNRI6yP9Dl42jo4X4Owgl+x5+G1LjsRjAlRet8eCkRUH4ubrC
 guvKTJrwjYBSGn2Jj7Jz8fUNWFCAPFiIPj1a3Z5JZlyUHxM4M+RwuSpQ94fe6iXJvfH2
 coalhiFLT9w8AjtlIeSDWK6+xN4+Eg2DOnnBGPbZRXISjcL/tcocRw4O9eTHHolbpaC8 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xf73u0d6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 06:18:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G6DdfK038228;
        Thu, 16 Jan 2020 06:18:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xhy22qh0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 06:18:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00G6I62l027636;
        Thu, 16 Jan 2020 06:18:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 22:18:06 -0800
Date:   Wed, 15 Jan 2020 22:18:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200116061804.GI8257@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz>
 <20200115173834.GD8247@magnolia>
 <20200115194512.GF23311@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
 <20200115223821.GG23311@iweiny-DESK2.sc.intel.com>
 <20200116053935.GB8235@magnolia>
 <CAPcyv4jDMsPj_vZwDOgPkfHLELZWqeJugKgKNVKbpiZ9th683g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jDMsPj_vZwDOgPkfHLELZWqeJugKgKNVKbpiZ9th683g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160052
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:05:00PM -0800, Dan Williams wrote:
> On Wed, Jan 15, 2020 at 9:39 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> [..]
> > >         attempts to minimize software cache effects for both I/O and
> > >         memory mappings of this file.  It requires a file system which
> > >         has been configured to support DAX.
> > >
> > >         DAX generally assumes all accesses are via cpu load / store
> > >         instructions which can minimize overhead for small accesses, but
> > >         may adversely affect cpu utilization for large transfers.
> > >
> > >         File I/O is done directly to/from user-space buffers and memory
> > >         mapped I/O may be performed with direct memory mappings that
> > >         bypass kernel page cache.
> > >
> > >         While the DAX property tends to result in data being transferred
> > >         synchronously, it does not give the same guarantees of
> > >         synchronous I/O where data and the necessary metadata are
> > >         transferred together.
> >
> > (I'm frankly not sure that synchronous I/O actually guarantees that the
> > metadata has hit stable storage...)
> 
> Oh? That text was motivated by the open(2) man page description of O_SYNC.

Eh, that's just me being cynical about software.  Yes, the O_SYNC docs
say that data+metadata are supposed to happen; that's good enough for
another section in the man pages. :)

--D
