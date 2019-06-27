Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D225756D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 02:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfF0AWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 20:22:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfF0AWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:22:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R095sZ153911;
        Thu, 27 Jun 2019 00:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OZ6e0FbvZ6ih1IklP3kOWEbcdJlaHfvXLF3leRVcWUY=;
 b=nB7qaexUVLsnWtZZL8ilmpxLc4CbV8CD4zkMKrWoh3xml3JhUaIp9+OiX8KWgEiq+QTV
 TmxH5cPDR/GN/Mim9pS0HSeUZriivu5IXjKymJeB4VlwuYqux8YFE96Q7ZuFaywS9GAs
 IfOynDYAH9wgXQWBBSy6D0VCSg6NmF9n/ECyAKjhrIbHx+AeA7tGFvV0wlMxz0hVhnnB
 xmxNQ5IUCjtH5vC5g7w5I84m4u6ESWlV3qRYMg8v1xYN3YBxl87OiOZnnvitl0kRmOQG
 ZRsajauz8/ilsNemW/ld4kcCe0+NXHIqitakDgA0iOejAf6kjQWlHHswxg9S0B9x2R/i YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brtd8qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 00:21:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R0I1KJ030470;
        Thu, 27 Jun 2019 00:19:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 2t99f4r2nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 00:19:34 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5R0JYLu032344;
        Thu, 27 Jun 2019 00:19:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f4r2n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 00:19:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R0JTqS006644;
        Thu, 27 Jun 2019 00:19:29 GMT
Received: from localhost (/10.145.178.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 17:19:28 -0700
Date:   Wed, 26 Jun 2019 17:19:26 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, matthew.garrett@nebula.com,
        yuchao0@huawei.com, tytso@mit.edu, shaggy@kernel.org,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, cluster-devel@redhat.com,
        jfs-discussion@lists.sourceforge.net, linux-efi@vger.kernel.org,
        Jan Kara <jack@suse.cz>, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] vfs: create a generic checking function for
 FS_IOC_FSSETXATTR
Message-ID: <20190627001926.GL5171@magnolia>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia>
 <156151633829.2283456.834142172527987802.stgit@magnolia>
 <20190626041133.GB32272@ZenIV.linux.org.uk>
 <20190626153542.GE5171@magnolia>
 <20190626154302.GA31445@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626154302.GA31445@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:43:02AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 26, 2019 at 08:35:42AM -0700, Darrick J. Wong wrote:
> > > static inline void simple_fill_fsxattr(struct fsxattr *fa, unsigned xflags)
> > > {
> > > 	memset(fa, 0, sizeof(*fa));
> > > 	fa->fsx_xflags = xflags;
> > > }
> > > 
> > > and let the compiler optimize the crap out?
> > 
> > The v2 series used to do that, but Christoph complained that having a
> > helper for a two-line memset and initialization was silly[1] so now we
> > have this version.
> > 
> > I don't mind reinstating it as a static inline helper, but I'd like some
> > input from any of the btrfs developers (or you, Al) about which form is
> > preferred.
> 
> I complained having that helper in btrfs.  I think Al wants a generic
> one, which at least makes a little more sense.

Ok.

> That being said I wonder if we should lift these attr ioctls to
> file op methods and deal with all that crap in VFS code instead of
> having all those duplicated ioctl parsers.

That sounds like an excellent next patchset. :)

--D
