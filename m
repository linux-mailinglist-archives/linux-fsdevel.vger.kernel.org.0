Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A384B1AABB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414667AbgDOPSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:18:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414655AbgDOPSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:18:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFIJcS106389;
        Wed, 15 Apr 2020 15:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qS/LkJjaAYTu2JH9+UNdmlJWo6ur3h3lKhehibB0yNo=;
 b=v9dKG7owZ4RXlV8c2Nyq1hlWdpfkmg45nTYtsBXix+l8EaetAcnemybNgy3/7rI5W9jV
 GmNDVDJ98Fv5tMC+t3nEzmSJkgx273lWmlv+yMABCz7OoXgSH0S1MyQ3IS5mSETQEcmS
 gEqgkUyfQBOOH6Uiw3Spq8VOr71g4I28OZ5yLmEeR2n+x3NVPYiNb57tOY5rtdFZQNSn
 Otjj10YQ8cZeDhNPmwLt16+5ZfwR3JPMIf8j6k51vmUkfIhVSJrbQfFvB1w02PIoP3mB
 i602f4q0tVCCxKLCMKm2Zed9MIxZagKLcxIGnpoNZcujHTALECKt3bKdkRCueinCznRr Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30dn95m1jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:18:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFD4g3163258;
        Wed, 15 Apr 2020 15:18:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30dyvf0578-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:18:35 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03FFIYr6030940;
        Wed, 15 Apr 2020 15:18:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 08:18:34 -0700
Date:   Wed, 15 Apr 2020 08:18:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 08/11] fs: Define I_DONTCACNE in VFS layer
Message-ID: <20200415151832.GQ6742@magnolia>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-9-ira.weiny@intel.com>
 <20200415085216.GE501@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415085216.GE501@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004150113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=2
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:52:16AM +0200, Jan Kara wrote:
> There's a typo in the subject - I_DONTCACNE.
> 
> On Tue 14-04-20 23:45:20, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DAX effective mode changes (setting of S_DAX) require inode eviction.
> > 
> > Define a flag which can be set to inform the VFS layer that inodes
> > should not be cached.  This will expedite the eviction of those nodes
> > requiring reload.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  include/linux/fs.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index a818ced22961..e2db71d150c3 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2151,6 +2151,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> >   *
> >   * I_CREATING		New object's inode in the middle of setting up.
> >   *
> > + * I_DONTCACHE		Do not cache the inode
> > + *
> 
> Maybe, I'd be more specific here and write: "Evict inode as soon as it is
> not used anymore"?

I had the same two comments about the V7 version of this patch...

--D

> Otherwise the patch looks good to me so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Also it would be good to CC Al Viro on this one (and the dentry flag) I
> guess.
> 
> 								Honza
> 
> >   * Q: What is the difference between I_WILL_FREE and I_FREEING?
> >   */
> >  #define I_DIRTY_SYNC		(1 << 0)
> > @@ -2173,6 +2175,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> >  #define I_WB_SWITCH		(1 << 13)
> >  #define I_OVL_INUSE		(1 << 14)
> >  #define I_CREATING		(1 << 15)
> > +#define I_DONTCACHE		(1 << 16)
> >  
> >  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> >  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> > @@ -3042,7 +3045,8 @@ extern int inode_needs_sync(struct inode *inode);
> >  extern int generic_delete_inode(struct inode *inode);
> >  static inline int generic_drop_inode(struct inode *inode)
> >  {
> > -	return !inode->i_nlink || inode_unhashed(inode);
> > +	return !inode->i_nlink || inode_unhashed(inode) ||
> > +		(inode->i_state & I_DONTCACHE);
> >  }
> >  
> >  extern struct inode *ilookup5_nowait(struct super_block *sb,
> > -- 
> > 2.25.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
