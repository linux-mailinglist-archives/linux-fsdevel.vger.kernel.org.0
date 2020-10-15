Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7670A28F6F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbgJOQju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 12:39:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40432 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgJOQju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:39:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FGXrvW099454;
        Thu, 15 Oct 2020 16:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ph+iaR4DoXiJ762IqZBmT0p/300c/ncdF4YPRCB2RDo=;
 b=LFQX2FsvnJVHRXdj4BWP5V+zjU9oHL/Pu6+0LDNdeE+tYOCbkd5qJ/ITOnPFiE0DYLPK
 rLJyfi58KD/ycdu7+KwJprcsPVvKcGPUw2D75tv8FFc7FkVRozrXCIlaFNHM9nKOTyJ3
 UXe+1U9COt+tD76V4HRM2Hgi9nDe7JjZPanFP+4+RchqNIoauaSl8lwOW5a9ACkvbPQP
 BtPftbeC007B5wtlwVpNh2tP5je9UoBATj389J9+gM5DrapnKU93X34rlLw/R6F+ppqM
 jocE3wxjWtGf2CigkisthQ8X2KptMYFX9BusIVVwBorWvhJL8++62gO+6eFeIpE2qwRU Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 343vaem28m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 16:39:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FGZLER165208;
        Thu, 15 Oct 2020 16:39:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 343pv22thj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 16:39:38 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FGdaoG014943;
        Thu, 15 Oct 2020 16:39:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 09:39:36 -0700
Date:   Thu, 15 Oct 2020 09:39:34 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] vfs: move generic_remap_checks out of mm
Message-ID: <20201015163934.GA9825@magnolia>
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
 <160272188127.913987.8729718777463390497.stgit@magnolia>
 <20201015113826.GX20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015113826.GX20115@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=1 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 12:38:26PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 14, 2020 at 05:31:21PM -0700, Darrick J. Wong wrote:
> > I would like to move all the generic helpers for the vfs remap range
> > functionality (aka clonerange and dedupe) into a separate file so that
> > they won't be scattered across the vfs and the mm subsystems.  The
> > eventual goal is to be able to deselect remap_range.c if none of the
> > filesystems need that code, but the tricky part here is picking a
> > stable(ish) part of the merge window to rearrange code.
> 
> This makes sense to me.  There's nothing page-cache about this function.
> 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 99c49eeae71b..cf20e5aeb11b 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3098,8 +3098,7 @@ EXPORT_SYMBOL(read_cache_page_gfp);
> >   * LFS limits.  If pos is under the limit it becomes a short access.  If it
> >   * exceeds the limit we return -EFBIG.
> >   */
> > -static int generic_write_check_limits(struct file *file, loff_t pos,
> > -				      loff_t *count)
> > +int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
> >  {
> >  	struct inode *inode = file->f_mapping->host;
> >  	loff_t max_size = inode->i_sb->s_maxbytes;
> 
> I wonder if generic_write_check_limits should be in fs/read_write.c --
> it has nothing to do with the pagecache either.

Yeah, probably.

--D
