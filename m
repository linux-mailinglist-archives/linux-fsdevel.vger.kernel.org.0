Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF815AFF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBLShh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 13:37:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49370 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLShh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:37:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CIWYxS114874;
        Wed, 12 Feb 2020 18:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=NnLYrbFPwtYHXlc4aNe/I8TmPOo3elqAIhGbBoTXajA=;
 b=HcXmZGymymikiScRbvBhLU6/dlAoefgps1xN/3PTjCqBDdIqA76g3JLZazzia5mxsci+
 5OpCO0wiLHLdpX5Cc0PE/PXJDfH6ZyG9xnWEG7VhVTo12kxMb+MKO+Tbxm2kC2bX04ej
 UgECm9uU4TfYzBv73fencCQdR7+B4ZQ86Vb8o1E2PelL4oOGzXLpow0XJ03m/cULjAHG
 yD9XsmErPPWC0zSEau+3KDP6uuF5jZcgom588O8yjJvZik3jEVHdQxoUOX2qj1GsWvKn
 h8isycn5jwcpIaVEPLoqRRP1I9q8oR2EJcU0ZsFtfXFjjMEYNo6aKlucGkuIU1OiRzh2 vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k88cwk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 18:37:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CIb2w7005778;
        Wed, 12 Feb 2020 18:37:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y4kagpenx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 18:37:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CIbJHi024070;
        Wed, 12 Feb 2020 18:37:19 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 10:37:19 -0800
Date:   Wed, 12 Feb 2020 10:37:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Florian Weimer <fw@deneb.enyo.de>, linux-xfs@vger.kernel.org,
        libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200212183718.GQ6870@magnolia>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
 <20200212181128.GA31394@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212181128.GA31394@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=988
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:11:28AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 12, 2020 at 08:16:04AM -0800, Darrick J. Wong wrote:
> > xfs_setattr_nonsize calls posix_acl_chmod which returns EOPNOTSUPP
> > because the xfs symlink inode_operations do not include a ->set_acl
> > pointer.
> > 
> > I /think/ that posix_acl_chmod code exists to enforce that the file mode
> > reflects any acl that might be set on the inode, but in this case the
> > inode is a symbolic link.
> > 
> > I don't remember off the top of my head if ACLs are supposed to apply to
> > symlinks, but what do you think about adding get_acl/set_acl pointers to
> > xfs_symlink_inode_operations and xfs_inline_symlink_inode_operations ?
> 
> Symlinks don't have permissions or ACLs, so adding them makes no
> sense.

Ahh, I thought so!

> xfs doesn't seem all that different from the other file systems,
> so I suspect you'll also see it with other on-disk file systems.

Yeah, I noticed that btrfs seems to exhibit the same behavior.

I also noticed that ext4 actually /does/ implement [gs]et_acl for
symlinks.

> We probably need a check high up in the chmod and co code to reject
> the operation early for O_PATH file descriptors pointing to symlinks.

<nod>

--D
