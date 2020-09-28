Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8727B183
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1QNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 12:13:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55050 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1QNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:13:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SG9jTF138051;
        Mon, 28 Sep 2020 16:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lte5bOGdEskw4lr0WR3UEmqrvhwsygZf+aPNo5MZL7M=;
 b=LdFAV6UEvOaEI5xhhonJLvraOzNkqfyJy2i2vwgn5Yl1hvK+NiNlAafEqhGk0joOz0b2
 29OadgEY6KjYEaYpSNVVQVyPIRWUSsVuG4ye49X7mV4ijdRA3K+YUCcSDDzowpOKBNi3
 Ybh3FZuYUoJ3POuqfhpdalRRl2zEwkGmCVrBgLcOhKzEu0WMjB8Ej7YYJv6JN2he7CUv
 8c/8axCoJHBbYEkCZckdcVTx/0ktZCX2LNsKVHC/y5pq6yJw9+MiVeEp1StXK02jtYBa
 XnS4lPQdLv51vfZ84jzO8zO/VTjP8+N57LxCnGpZMHwhFtS/KqxSDiqt5yWSS2zp//gC 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33su5ap366-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 16:12:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SGAl1U154383;
        Mon, 28 Sep 2020 16:12:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33tf7khbrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Sep 2020 16:12:49 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08SGCht6015028;
        Mon, 28 Sep 2020 16:12:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Sep 2020 09:12:42 -0700
Date:   Mon, 28 Sep 2020 09:12:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/14] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200928161240.GA49559@magnolia>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
 <20200924163922.2547-5-rgoldwyn@suse.de>
 <20200926015108.GQ7964@magnolia>
 <20200928150418.GC6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928150418.GC6756@twin.jikos.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=1 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280124
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:04:19PM +0200, David Sterba wrote:
> On Fri, Sep 25, 2020 at 06:51:08PM -0700, Darrick J. Wong wrote:
> > On Thu, Sep 24, 2020 at 11:39:11AM -0500, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > iomap complete routine can deadlock with btrfs_fallocate because of the
> > > call to generic_write_sync().
> > > 
> > > P0                      P1
> > > inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
> > > __iomap_dio_rw()        inode_lock()
> > >                         <block>
> > > <submits IO>
> > > <completes IO>
> > > inode_unlock()
> > >                         <gets inode_lock()>
> > >                         inode_dio_wait()
> > > iomap_dio_complete()
> > >   generic_write_sync()
> > >     btrfs_file_fsync()
> > >       inode_lock()
> > >       <deadlock>
> > > 
> > > inode_dio_end() is used to notify the end of DIO data in order
> > > to synchronize with truncate. Call inode_dio_end() before calling
> > > generic_write_sync(), so filesystems can lock i_rwsem during a sync.
> > > 
> > > This matches the way it is done in fs/direct-io.c:dio_complete().
> > > 
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Looks ok (at least with the fses that use either iomap or ye olde
> > directio) to me...
> > 
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > So, uh, do you want me to pull these two iomap patches in for 5.10?
> 
> That would be great, thanks. Once they land in 5.10-rc we'll be able to
> base the rest on some master snapshot and target 5.11 for release.

Ok, done. :)

--D
