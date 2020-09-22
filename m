Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698652746B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVQcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 12:32:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43768 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgIVQcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:32:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MGPUo3090827;
        Tue, 22 Sep 2020 16:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Uamm0HlPzqeUaeiDvBGet54wRZBfmf2NMh9riCx2PW0=;
 b=QJJ8QThJC3iWR6aeIgtCMNHBoFr3GF3dGkx0f8qwGVkSlAo12qwzQNsx3gESkvLoVonT
 QWiVoUxwdUIgEpe0AFiE5Utuck2dKKD8GYEHDWT4y6niEWtNP00Nz5JyGo3tLueRbDCx
 9sXMubbe4PV171YN0cOMPTuynC0QVkT7MSwTOEoWNrD8rfxn8TCyEiAHMtVno1F8XLsa
 d7gdpwaXF187pb6kded8Ae+twrQjp9ewtTNvNBYMhPgR1eRvgDG0Of7VQ3bFnkRGX1A2
 gPF5c5NIBumQX08LfYaUwtTf4hNYd9WR5duOdsx8nS5Xd36wRw/fCSpE+wKCwx4yr7OK OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33qcpttsdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 16:32:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MGQL7g157438;
        Tue, 22 Sep 2020 16:32:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33nujneqd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 16:32:00 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08MGVww1022821;
        Tue, 22 Sep 2020 16:31:58 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 09:31:58 -0700
Date:   Tue, 22 Sep 2020 09:31:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200922163156.GD7949@magnolia>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-5-rgoldwyn@suse.de>
 <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:20:11AM -0400, Josef Bacik wrote:
> On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > iomap complete routine can deadlock with btrfs_fallocate because of the
> > call to generic_write_sync().
> > 
> > P0                      P1
> > inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
> > __iomap_dio_rw()        inode_lock()
> >                          <block>
> > <submits IO>
> > <completes IO>
> > inode_unlock()
> >                          <gets inode_lock()>
> >                          inode_dio_wait()
> > iomap_dio_complete()
> >    generic_write_sync()
> >      btrfs_file_fsync()
> >        inode_lock()
> >        <deadlock>
> > 
> > inode_dio_end() is used to notify the end of DIO data in order
> > to synchronize with truncate. Call inode_dio_end() before calling
> > generic_write_sync(), so filesystems can lock i_rwsem during a sync.
> > 
> > ---
> >   fs/iomap/direct-io.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index d970c6bbbe11..e01f81e7b76f 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -118,6 +118,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> >   			dio_warn_stale_pagecache(iocb->ki_filp);
> >   	}
> > +	inode_dio_end(file_inode(iocb->ki_filp));
> >   	/*
> >   	 * If this is a DSYNC write, make sure we push it to stable storage now
> >   	 * that we've written data.
> > @@ -125,7 +126,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> >   	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
> >   		ret = generic_write_sync(iocb, ret);
> > -	inode_dio_end(file_inode(iocb->ki_filp));
> >   	kfree(dio);
> >   	return ret;
> > 
> 
> Did you verify that xfs or ext4 don't rely on the inode_dio_end() happening
> before the generic_write_sync()?  I wouldn't expect that they would, but
> we've already run into problems making those kind of assumptions.  If it's
> fine you can add

I was gonna ask the same question, but as there's no SoB on this patch I
hadn't really looked at it yet. ;)

Operations that rely on inode_dio_wait to have blocked until all the
directios are complete could get tripped up by iomap not having done the
generic_write_sync to stabilise the metadata, but I /think/ most
operations that do that also themselves flush the file.  But I don't
really know if there's a subtlety there if the inode_dio_wait thread
manages to grab the ILOCK before the generic_write_sync thread does.

--D

> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef
