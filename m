Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E644310B75B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 21:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK0UVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 15:21:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfK0UVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:21:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARKJvRU126170;
        Wed, 27 Nov 2019 20:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=95mfLhm4vghNr8cf39wWPNrlxfRQ9+/3VOjVBZT7JzY=;
 b=NCD166AcV9/rhzIIX/QgAs4CIE3Fs1OMwo7tJh/SjzDS1WAtlhtJE9m65MDMb34cKlhT
 RVkU4uMN/eNSbFiPZo/4uZnkX9W+h7ncRgcCmK8CkzMhHY9KSAAzPZgaHnyrV5mn7Eiy
 Lo0EPDpooUidRqfZbnTRQBaSIiONTJtLJmcHdS7aIp5DsXjDJRqekgnbghQLnxyUX25V
 7qty/MGC3b2TV5bRte5bXZP/rWs25C7EyNz20gUl5Ly1Jh2kv8SpgeyNzrWEP1MnzQ+x
 elDpRrnXQ2RBBavtDpU6Z/6D0BCDRgqHHUwBxZWAj8ul99HVXN3hBv+RSzKgj8RjVe9V nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wev6uftg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 20:21:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARKJ4Fa092823;
        Wed, 27 Nov 2019 20:21:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2whx5r556n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 20:21:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xARKLcMZ028437;
        Wed, 27 Nov 2019 20:21:40 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Nov 2019 12:21:38 -0800
Date:   Wed, 27 Nov 2019 12:21:36 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about clone_range() metadata stability
Message-ID: <20191127202136.GV6211@magnolia>
References: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911270163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911270163
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 06:38:46PM +0000, Trond Myklebust wrote:
> Hi all
> 
> A quick question about clone_range() and guarantees around metadata
> stability.
> 
> Are users required to call fsync/fsync_range() after calling
> clone_range() in order to guarantee that the cloned range metadata is
> persisted?

Yes.

> I'm assuming that it is required in order to guarantee that
> data is persisted.

Data and metadata.  XFS and ocfs2's reflink implementations will flush
the page cache before starting the remap, but they both require fsync to
force the log/journal to disk.

(AFAICT the same reasoning applies to btrfs, but don't trust my word for
it.)

> I'm asking because knfsd currently just does a call to
> vfs_clone_file_range() when parsing a NFSv4.2 CLONE operation. It does
> not call fsync()/fsync_range() on the destination file, and since the
> NFSv4.2 protocol does not require you to perform any other operation in
> order to persist data/metadata, I'm worried that we may be corrupting
> the cloned file if the NFS server crashes at the wrong moment after the
> client has been told the clone completed.

That analysis seems correct.

--D

> Cheers
>   Trond
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
