Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E9A5B9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 19:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfIBRB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 13:01:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfIBRB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:01:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x82GxJeO069743;
        Mon, 2 Sep 2019 17:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=SFDxJjAViLlQmwB4JcX+fQxI4Y3TvOk4g/U34IKF6kA=;
 b=lMpG+CXZBDZLNfvs+NLV40xbtKu2055QexHQVRUpiH3GhUxWtvgzEOKzhfVk9JkNBFMy
 nxtXbyY2yc02saIccVFBoNB9kJb4urakjmGrJFyijzCRKW0IhaSqgMmRL38NSwuWgqNj
 XDbVTMJKAEd+/AgBmBhPhszRYSk97AR3jWD3y+xtiLw68rcug8gzktHOMrTx3x7Bahk0
 PWi5ZJeEgZqypPi+kBG8gLxD6HuqOXt1x5A7M4zmtio0Hb2RF4HZz1Z58153V2nAyfOV
 5B2ZPHKKEgS8JuDMpS1eoh2qaC5556FRzuCDJbm3Heg26kLo+lAv7khyDr2lH/OK120A HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2us70ar0wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 17:01:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x82Gw8eZ195303;
        Mon, 2 Sep 2019 17:01:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2urww6nnqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 17:01:16 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x82H19WB008126;
        Mon, 2 Sep 2019 17:01:09 GMT
Received: from localhost (/10.159.145.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 10:01:09 -0700
Date:   Mon, 2 Sep 2019 10:01:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/15] iomap: Read page from srcmap for IOMAP_COW
Message-ID: <20190902170109.GD568270@magnolia>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190901200836.14959-4-rgoldwyn@suse.de>
 <20190902163124.GC6263@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902163124.GC6263@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=873
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909020191
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=932 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909020191
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 06:31:24PM +0200, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 03:08:24PM -0500, Goldwyn Rodrigues wrote:
> 
> > +		iomap_assert(!(iomap->flags & IOMAP_F_BUFFER_HEAD));
> > +		iomap_assert(srcmap->type == IOMAP_HOLE || srcmap->addr > 0);
> 
> 0 can be a valid address in various file systems, so I don't think we
> can just exclude it.  Then again COWing from a hole seems pointless,
> doesn't it?

XFS does that if you set a cowextsize hint and a speculative cow
preallocation ends up covering a hole.  Granted I don't think there's
much point in reading from a COW fork extent to fill in an unaligned
buffered write since it /should/ just end up zero-filling the pagecache
regardless of fork... but I don't see much harm in doing that.

--D

> So just check for addr != IOMAP_NULL_ADDR here?
> 
> >  
> > @@ -961,7 +966,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> >  		if (IS_DAX(inode))
> >  			status = iomap_dax_zero(pos, offset, bytes, iomap);
> >  		else
> > -			status = iomap_zero(inode, pos, offset, bytes, iomap);
> > +			status = iomap_zero(inode, pos, offset, bytes, iomap, srcmap);
> 
> This introduces an > 80 character line.
