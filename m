Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0DD13CA86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgAORMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 12:12:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49220 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAORMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:12:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FH9YWk059762;
        Wed, 15 Jan 2020 17:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=yodk3FXBxJ+C4bpH8jgyDdNJeLK8BCw4+p/mjjrGu6I=;
 b=jGRi57OMh1x0TFj3rivWK8oMNmRGnEM26tBEOTsVXZ0KoEYnD+vD+kUfJC7N9Q9hKrY9
 FyQSIcaoLmNanRUrwVSx2oCpicHju3dtqFcYg3frf2nv4KVRTXvQ/FD1BMqP4X+kOAk9
 73YoDwwSBCteTcyAYNDjU9jCtrJcmTyz2ycimS7vyFrFZ0ZgPzL03cuxP7VTI/bVwJEy
 FU7LlGBPdez1oPasB/r2kFvgADnC1bUJzk8eMXP/Mx7PPLFr/w7+naEL+Q0YlIbPgGYl
 7dJyRU6jwabybhhkxT+Dl5umB4dU2h3iI3tAm15nW9CAU1KXQJdf2jVWJk8Dy8rjqGxq iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xf74sdfnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:11:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FH9Xdk073935;
        Wed, 15 Jan 2020 17:11:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xj1apxkdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:11:00 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00FHAopO016173;
        Wed, 15 Jan 2020 17:10:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 09:10:50 -0800
Date:   Wed, 15 Jan 2020 09:10:47 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>, YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] fs: Fix page_mkwrite off-by-one errors
Message-ID: <20200115171047.GA8247@magnolia>
References: <20200108131528.4279-1-agruenba@redhat.com>
 <20200108165710.GA18523@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108165710.GA18523@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150130
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 08, 2020 at 08:57:10AM -0800, Christoph Hellwig wrote:
> I don't want to be the party pooper, but shouldn't this be a series
> with one patch to add the helper, and then once for each fs / piece
> of common code switched over?

The current patch in the iomap branch contains the chunks that add the
helper function, fix iomap, and whatever chunks for other filesystems
that don't cause /any/ merge complaints in for-next.  That means btrfs,
ceph, ext4, and ubifs will get fixed this time around.

Seeing as it's been floating around in for-next for a week now I'd
rather not rebase the branch just to rip out the four parts that haven't
given me any headaches so that they can be applied separately. :)

The acks from the other fs maintainers were very helpful, but at the
same time, I don't want to become a shadow vfs maintainer.

Therefore, whatever's in this v4 patch that isn't in [1] will have to be
sent separately.

[1] https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=iomap-5.6-merge&id=62e298db3fc3ebf41d996f3c86b44cbbdd3286bc

> On Wed, Jan 08, 2020 at 02:15:28PM +0100, Andreas Gruenbacher wrote:
> > Hi Darrick,
> > 
> > here's an updated version with the latest feedback incorporated.  Hope
> > you find that useful.
> > 
> > As far as the f2fs merge conflict goes, I've been told by Linus not to
> > resolve those kinds of conflicts but to point them out when sending the
> > merge request.  So this shouldn't be a big deal.
> 
> Also this isn't really the proper way to write a commit message.  This
> text would go into the cover letter if it was a series..

<urk> Yeah.

--D
