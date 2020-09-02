Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8718A25B1B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgIBQaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 12:30:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57802 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIBQaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:30:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082GOurw176649;
        Wed, 2 Sep 2020 16:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=y7Mp7j1orF3+oK7VZtWW77lCVm44UkHFr4DM1FKSR1E=;
 b=nCG547R9bM8S2wO25Y8Vsr+WfxPGqsd+06SV47tG/gDMPoXTJR2HgEiHCa+7pW33N+V2
 d65TgLL+7AmJSoDhnimzlm9HJBA9p7Hr2hWdot1r9gttEMCigUTrIOXkGgLImxPy/4aB
 cNqHPkJciygUYFyrLlgq7c7cOEFGKqffDa+Tw0SloNo+8nw5p1273s+1a4cSAKY+OqKl
 um4w/KIRglkdC1Oby7i4fLx9WK2d9sAmA9K7VSchWO+CQ+txyrCmXQp3rjKuKgR3R4Hn
 S5abWgARrixDfc97S8I09D6wsAQdCi+s60Mqrli6gY/+u/Mq+DJRt0bqTvJIjoEXwvKx HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eer3rrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 16:29:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082GPFAJ152380;
        Wed, 2 Sep 2020 16:29:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380kq92q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 16:29:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082GTk7M000784;
        Wed, 2 Sep 2020 16:29:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 09:29:45 -0700
Date:   Wed, 2 Sep 2020 09:29:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200902162944.GH6090@magnolia>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901214613.GH12096@dread.disaster.area>
 <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
 <20200901235830.GI12096@dread.disaster.area>
 <d2ba3cc5-5648-2e4b-6ae4-2515b1365ce2@toxicpanda.com>
 <SN4PR0401MB3598CDEB0ADC4E43179DE2E29B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <43272cc6-4d40-caf7-8777-4ef1e1725c97@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43272cc6-4d40-caf7-8777-4ef1e1725c97@toxicpanda.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 07:10:08AM -0400, Josef Bacik wrote:
> On 9/2/20 3:12 AM, Johannes Thumshirn wrote:
> > On 02/09/2020 02:22, Josef Bacik wrote:
> > > Instead now we have to rip
> > > it out until we figure out what to do about it.
> > 
> > I don't think we need to rip out the iomap conversion. We can
> > take my fix albeit not pretty, until we have reworked the locking
> > around ->fsync(). Probably with a big fat comment attached to it.
> > 
> 
> We do, because your fix breaks DSYNC for AIO.  You didn't hit this with
> direct io, you hit it with AIO, and the reason you hit it is because you are
> on zram, so your bio's completed before we exited iomap_dio_rw.  So that was
> the last put on the iomap_dio, and thus we ran
> iomap_dio_complete() and deadlocked.  We can't just drop the DSYNC thing for
> AIO because in the normal case where this doesn't happen we need to know
> when the last thing is finished in order to run ->fsync(), we can't just run
> it after submission.  Thanks,

Bleh, Oracle mail (or vger or something) is being slow again...

It occurred to me that we added iomap_dio_ops.submit_io for the benefit
of btrfs.  Could we solve all this for now by adding a ->write_sync
function pointer to iomap_dio_ops that could lead back into a btrfs
function that would flush the necessary bits without itself taking the
inode lock?  And if a ->write_sync is not supplied, then the caller gets
generic_write_sync?

It's kind of a bandaid, but maybe less bad of one than restructuring the
btrfs locking model under time pressure...

--D

> Josef
