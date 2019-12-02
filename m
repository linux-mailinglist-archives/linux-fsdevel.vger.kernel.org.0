Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5F10EDDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 18:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfLBRJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 12:09:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58776 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBRJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:09:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2GsS8d005525;
        Mon, 2 Dec 2019 17:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Bbe3gDdEP0eJTwUIZaW8+QYkjdYfh8aDqS2vODKLAQs=;
 b=WumvQAi7iRLd7p4QVlUUnPMBV25wpwF74Ofd4kECizaZcawWz9UijTOhyKAtOEAtCgwF
 5YobxEedKwO24Wti5sZ60jITN46XydqBk+nMN3J7AYiIC1MnNVON30Rl/7Bb+TxbN907
 vRiWs+dyf48i8BjFBkGt6RH00oMtLMZDwia9M3PYplEoXupOGuLbt2PbpOh7MG+bBSP4
 p5oKXUjNKYI9k53FznkBHbIw4Pjp/B+7g+p0PkExlfghOE1NS2bWa520IUfgY3C2AZhq
 5Aqi2TJdvVBBvhPRx16Qnp9vOjW/I7Tpu0KIZHev2SblrNWp6kcjUt7VaLdxDXTjY6i6 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wkgcq1eyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 17:09:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2GsbXc156460;
        Mon, 2 Dec 2019 17:09:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wm1w2xhj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 17:09:32 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB2H9Sq7024423;
        Mon, 2 Dec 2019 17:09:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 09:09:27 -0800
Date:   Mon, 2 Dec 2019 09:09:26 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about clone_range() metadata stability
Message-ID: <20191202170926.GA7323@magnolia>
References: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
 <20191127202136.GV6211@magnolia>
 <20191201210519.GB2418@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201210519.GB2418@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020145
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 08:05:19AM +1100, Dave Chinner wrote:
> On Wed, Nov 27, 2019 at 12:21:36PM -0800, Darrick J. Wong wrote:
> > On Wed, Nov 27, 2019 at 06:38:46PM +0000, Trond Myklebust wrote:
> > > Hi all
> > > 
> > > A quick question about clone_range() and guarantees around metadata
> > > stability.
> > > 
> > > Are users required to call fsync/fsync_range() after calling
> > > clone_range() in order to guarantee that the cloned range metadata is
> > > persisted?
> > 
> > Yes.
> > 
> > > I'm assuming that it is required in order to guarantee that
> > > data is persisted.
> > 
> > Data and metadata.  XFS and ocfs2's reflink implementations will flush
> > the page cache before starting the remap, but they both require fsync to
> > force the log/journal to disk.
> 
> So we need to call xfs_fs_nfs_commit_metadata() to get that done
> post vfs_clone_file_range() completion on the server side, yes?

That sounds like a much better/less hastily researched answer! :)

> 
> > 
> > (AFAICT the same reasoning applies to btrfs, but don't trust my word for
> > it.)
> > 
> > > I'm asking because knfsd currently just does a call to
> > > vfs_clone_file_range() when parsing a NFSv4.2 CLONE operation. It does
> > > not call fsync()/fsync_range() on the destination file, and since the
> > > NFSv4.2 protocol does not require you to perform any other operation in
> > > order to persist data/metadata, I'm worried that we may be corrupting
> > > the cloned file if the NFS server crashes at the wrong moment after the
> > > client has been told the clone completed.
> 
> Yup, that's exactly what server side calls to commit_metadata() are
> supposed to address.
> 
> I suspect to be correct, this might require commit_metadata() to be
> called on both the source and destination inodes, as both of them
> may have modified metadata as a result of the clone operation. For
> XFS one of them will be a no-op,

Hmm.  If xfs had to set its reflink flag on the source inode then we
want to ->commit_metadata the source inode to push the log forward far
enough to record the metadata change.  That said, we set the reflink
flag on both inodes before we remap anything, so chances are that
->commit_metadata on the dest inode will be enough to push the log
forward.

I suspect that from NFS' point of view it probably ought to
->commit_metadata both inodes to insulate itself from fs-specific
behaviors and avoid weird crash dataloss bugs.  Someday, someone will
design a filesystem with per-inode logs /and/ hook it up to NFS.

> but for other filesystems that
> don't implement ->commit_metadata, we'll need to call
> sync_inode_metadata() on both inodes...

<nod>

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
