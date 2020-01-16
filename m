Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0004B13D3D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 06:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAPFkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 00:40:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPFkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:40:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G5d5VM174531;
        Thu, 16 Jan 2020 05:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ZvhUMad29Q7lSqgVCA5o0Rvkn84v5bmJgkpac83lhOw=;
 b=Xwz8WLjsjRYhW7x+YlXoHgXJ1rLTWNix812/W9nXlfXTwm/gMJoMyfoO0hO0pe+sOQea
 3yjMk2iw+MVORoBxt30KWwzlMr7bqH0hmoo9vyvC1SWnRbW9pB3kXcAiEgbix1Yu65HR
 xLLd+Z30bDonOev13PvgbLHzqy9/Iwv5nSTcCpVVo/QAX/oGRPyvHsbYu0daPGI+/9su
 PzAWtRJ/bGr9Pt77spupAQ5FjBYqtPyyI82xZ2FS8H47+mmo6l5zRJq+mklQ/o9b3J4k
 F06qGYgtdT8PquY+zR3x4S3qluI9Lv1BJQg2Z5Q9vrdRq1FeDuVhz7tysitrbgo9i/AU rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xf73u0706-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 05:39:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G5d1te153489;
        Thu, 16 Jan 2020 05:39:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xhy22nqg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 05:39:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00G5dbMg027086;
        Thu, 16 Jan 2020 05:39:37 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 21:39:37 -0800
Date:   Wed, 15 Jan 2020 21:39:35 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200116053935.GB8235@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz>
 <20200115173834.GD8247@magnolia>
 <20200115194512.GF23311@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
 <20200115223821.GG23311@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115223821.GG23311@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160047
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:38:21PM -0800, Ira Weiny wrote:
> On Wed, Jan 15, 2020 at 12:10:50PM -0800, Dan Williams wrote:
> > On Wed, Jan 15, 2020 at 11:45 AM Ira Weiny <ira.weiny@intel.com> wrote:
> > >
> > > On Wed, Jan 15, 2020 at 09:38:34AM -0800, Darrick J. Wong wrote:
> > > > On Wed, Jan 15, 2020 at 12:37:15PM +0100, Jan Kara wrote:
> > > > > On Fri 10-01-20 11:29:31, ira.weiny@intel.com wrote:
> > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > >
> 
> [snip]
> 
> > > Ok I changed a couple of things as well.  How does this sound?
> > >
> > >
> > > STATX_ATTR_DAX
> > >
> > >         DAX (cpu direct access) is a file mode that attempts to minimize
> > 
> > s/mode/state/?
> 
> DOH!  yes state...  ;-)
> 
> > 
> > >         software cache effects for both I/O and memory mappings of this
> > >         file.  It requires a block device and file system which have
> > >         been configured to support DAX.
> > 
> > It may not require a block device in the future.
> 
> Ok:
> 
> "It requires a file system which has been configured to support DAX." ?
> 
> I'm trying to separate the user of the individual STATX DAX flag from the Admin
> details of configuring the file system and/or devices which supports it.
> 
> Also, I just realized that we should follow the format of the other STATX_*
> attributes.  They all read something like "the file is..."
> 
> So I'm adding that text as well.
> 
> > 
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
> > 
> > Maybe use "O_SYNC I/O" explicitly to further differentiate the 2
> > meanings of "synchronous" in this sentence?
> 
> Done.
> 
> > 
> > >         transferred together.
> > >
> > >         A DAX file may support being mapped with the MAP_SYNC flag,
> > >         which enables a program to use CPU cache flush operations to
> > 
> > s/operations/instructions/
> 
> Done.
> 
> > 
> > >         persist CPU store operations without an explicit fsync(2).  See
> > >         mmap(2) for more information.
> > 
> > I think this also wants a reference to the Linux interpretation of
> > platform "persistence domains" we were discussing that here [1], but
> > maybe it should be part of a "pmem" manpage that can be referenced
> > from this man page.
> 
> Sure, but for now I think referencing mmap for details on MAP_SYNC works.
> 
> I suspect that we may have some word smithing once I get this series in and we
> submit a change to the statx man page itself.  Can I move forward with the
> following for this patch?
> 
> <quote>
> STATX_ATTR_DAX
> 
>         The file is in the DAX (cpu direct access) state.  DAX state

Hmm, now that I see it written out, I <cough> kind of like "DAX mode"
better now. :/

"The file is in DAX (CPU direct access) mode.  DAX mode attempts..."

>         attempts to minimize software cache effects for both I/O and
>         memory mappings of this file.  It requires a file system which
>         has been configured to support DAX.
> 
>         DAX generally assumes all accesses are via cpu load / store
>         instructions which can minimize overhead for small accesses, but
>         may adversely affect cpu utilization for large transfers.
> 
>         File I/O is done directly to/from user-space buffers and memory
>         mapped I/O may be performed with direct memory mappings that
>         bypass kernel page cache.
> 
>         While the DAX property tends to result in data being transferred
>         synchronously, it does not give the same guarantees of
>         synchronous I/O where data and the necessary metadata are
>         transferred together.

(I'm frankly not sure that synchronous I/O actually guarantees that the
metadata has hit stable storage...)

--D

>         A DAX file may support being mapped with the MAP_SYNC flag,
>         which enables a program to use CPU cache flush instructions to
>         persist CPU store operations without an explicit fsync(2).  See
>         mmap(2) for more information.
> </quote>
> 
> Ira
> 
> > 
> > [1]: http://lore.kernel.org/r/20200108064905.170394-1-aneesh.kumar@linux.ibm.com
