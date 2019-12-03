Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C323A11026B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLCQfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 11:35:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLCQfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:35:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3GJEYj001601;
        Tue, 3 Dec 2019 16:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=CG2m3f4Oi7sNZTSZk9mkAnAp3Upf/MKRwb2/e/7lIqg=;
 b=sgIhIr6XDq/lbHIMRf9YGKWvZO7v7P6D+/FDaUKWVPQepE6fxrKyS7yNwt6QWx2S3qr0
 v1K9yCrjkOb9plETSzM/qLOvc8iZbUZWz1IhHLaA555OjMHwQSG8Xmb7t5nbjJDSgKhs
 C/egZozHpI14q8ZOZPnaNP8RvqTjFIXhlq+uFfD5aUjTQMpm6x7fUrJaDe1dXg/c07HR
 GT75U0xSRoQ4zp6ZzWsMty5BIbJs/bjxexIIbrbY/dKRy7oC1aDuQqtFjLZKS5Xsn7iC
 +wygu52xavP2nGu5ipoep+P0bJCFRIznyo7CRyqkIRplkGGRPs/+1SJ77vKfB0oyn8yM Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wkfuu91yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 16:35:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3GJ9YK082241;
        Tue, 3 Dec 2019 16:35:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wn8k2v9rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 16:35:31 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB3GZSBZ029804;
        Tue, 3 Dec 2019 16:35:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 16:35:28 +0000
Date:   Tue, 3 Dec 2019 08:35:26 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Question about clone_range() metadata stability
Message-ID: <20191203163526.GD7323@magnolia>
References: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
 <20191127202136.GV6211@magnolia>
 <20191201210519.GB2418@dread.disaster.area>
 <52f1afb6e0a2026840da6f4b98a5e01a247447e5.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f1afb6e0a2026840da6f4b98a5e01a247447e5.camel@hammerspace.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 07:36:29AM +0000, Trond Myklebust wrote:
> On Mon, 2019-12-02 at 08:05 +1100, Dave Chinner wrote:
> > On Wed, Nov 27, 2019 at 12:21:36PM -0800, Darrick J. Wong wrote:
> > > On Wed, Nov 27, 2019 at 06:38:46PM +0000, Trond Myklebust wrote:
> > > > Hi all
> > > > 
> > > > A quick question about clone_range() and guarantees around
> > > > metadata
> > > > stability.
> > > > 
> > > > Are users required to call fsync/fsync_range() after calling
> > > > clone_range() in order to guarantee that the cloned range
> > > > metadata is
> > > > persisted?
> > > 
> > > Yes.
> > > 
> > > > I'm assuming that it is required in order to guarantee that
> > > > data is persisted.
> > > 
> > > Data and metadata.  XFS and ocfs2's reflink implementations will
> > > flush
> > > the page cache before starting the remap, but they both require
> > > fsync to
> > > force the log/journal to disk.
> > 
> > So we need to call xfs_fs_nfs_commit_metadata() to get that done
> > post vfs_clone_file_range() completion on the server side, yes?
> > 
> 
> I chose to implement this using a full call to vfs_fsync_range(), since
> we really do want to ensure data stability as well. Consider, for
> instance, the case where client A is running an application, and client
> B runs vfs_clone_file_range() in order to create a point in time
> snapshot of the file for disaster recovery purposes...

Seems reasonable, since (alas) we didn't define the ->remap_range api to
guarantee that for you.

> > > (AFAICT the same reasoning applies to btrfs, but don't trust my
> > > word for
> > > it.)
> > > 
> > > > I'm asking because knfsd currently just does a call to
> > > > vfs_clone_file_range() when parsing a NFSv4.2 CLONE operation. It
> > > > does
> > > > not call fsync()/fsync_range() on the destination file, and since
> > > > the
> > > > NFSv4.2 protocol does not require you to perform any other
> > > > operation in
> > > > order to persist data/metadata, I'm worried that we may be
> > > > corrupting
> > > > the cloned file if the NFS server crashes at the wrong moment
> > > > after the
> > > > client has been told the clone completed.
> > 
> > Yup, that's exactly what server side calls to commit_metadata() are
> > supposed to address.
> > 
> > I suspect to be correct, this might require commit_metadata() to be
> > called on both the source and destination inodes, as both of them
> > may have modified metadata as a result of the clone operation. For
> > XFS one of them will be a no-op, but for other filesystems that
> > don't implement ->commit_metadata, we'll need to call
> > sync_inode_metadata() on both inodes...
> > 
> 
> That's interesting. I hadn't considered that a clone might cause the
> source metadata to change as well. What kind of change specifically are
> we talking about? Is it just delayed block allocation, or is there
> more?

In XFS' case, we added a per-inode flag to help us bypass the reference
count lookup during a write if the file has never shared any blocks, so
if you never share anything, you'll never pay any of the runtime costs
of the COW mechanism.

ocfs2's design has a reference count tree that is shared between groups
of files that have been reflinked from each other.  So if you start with
unshared files A and B and clone A to A1 and A2; and B to B1 and B2,
then A* will have their own refcount tree and B* will also have their
own refcount tree.

Either way, nfs has to assume that changes could have been made to the
source file.

--D

> Thanks
>   Trond
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
