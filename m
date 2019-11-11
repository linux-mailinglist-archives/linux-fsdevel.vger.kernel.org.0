Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A77F715D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKKKIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 05:08:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57763 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKKIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:08:09 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iU6cC-0006uV-5z; Mon, 11 Nov 2019 11:08:08 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iU6cB-0000CY-8J; Mon, 11 Nov 2019 11:08:07 +0100
Date:   Mon, 11 Nov 2019 11:08:07 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 04/10] quota: Allow to pass mount path to quotactl
Message-ID: <20191111100807.dzomp2o7n3mch6xx@pengutronix.de>
References: <20191030152702.14269-1-s.hauer@pengutronix.de>
 <20191030152702.14269-5-s.hauer@pengutronix.de>
 <20191101160706.GA23441@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101160706.GA23441@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:03:12 up 126 days, 16:13, 138 users,  load average: 0.25, 0.27,
 0.19
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 05:07:06PM +0100, Jan Kara wrote:
> On Wed 30-10-19 16:26:56, Sascha Hauer wrote:
> > This patch introduces the Q_PATH flag to the quotactl cmd argument.
> > When given, the path given in the special argument to quotactl will
> > be the mount path where the filesystem is mounted, instead of a path
> > to the block device.
> > This is necessary for filesystems which do not have a block device as
> > backing store. Particularly this is done for upcoming UBIFS support.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Thanks for the patch! Some smaller comments below...
> 
> > ---
> >  fs/quota/quota.c           | 37 ++++++++++++++++++++++++++++---------
> >  include/uapi/linux/quota.h |  1 +
> >  2 files changed, 29 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> > index cb13fb76dbee..035cdd1b022b 100644
> > --- a/fs/quota/quota.c
> > +++ b/fs/quota/quota.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/types.h>
> >  #include <linux/writeback.h>
> >  #include <linux/nospec.h>
> > +#include <linux/mount.h>
> >  
> >  static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
> >  				     qid_t id)
> > @@ -825,12 +826,16 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
> >  {
> >  	uint cmds, type;
> >  	struct super_block *sb = NULL;
> > -	struct path path, *pathp = NULL;
> > +	struct path path, *pathp = NULL, qpath;
> 
> Maybe call these two 'file_path', 'file_pathp', and 'sb_path' to make it
> clearer which path is which?
> 
> >  	int ret;
> > +	bool q_path;
> >  
> >  	cmds = cmd >> SUBCMDSHIFT;
> >  	type = cmd & SUBCMDMASK;
> >  
> > +	q_path = cmds & Q_PATH;
> > +	cmds &= ~Q_PATH;
> > +
> >  	/*
> >  	 * As a special case Q_SYNC can be called without a specific device.
> >  	 * It will iterate all superblocks that have quota enabled and call
> > @@ -855,19 +860,33 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
> >  			pathp = &path;
> >  	}
> >  
> > -	sb = quotactl_block(special, cmds);
> > -	if (IS_ERR(sb)) {
> > -		ret = PTR_ERR(sb);
> > -		goto out;
> > +	if (q_path) {
> > +		ret = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT,
> > +				   &qpath);
> > +		if (ret)
> > +			goto out1;
> > +
> > +		sb = qpath.mnt->mnt_sb;
> > +	} else {
> > +		sb = quotactl_block(special, cmds);
> > +		if (IS_ERR(sb)) {
> > +			ret = PTR_ERR(sb);
> > +			goto out;
> > +		}
> >  	}
> >  
> >  	ret = do_quotactl(sb, type, cmds, id, addr, pathp);
> >  
> > -	if (!quotactl_cmd_onoff(cmds))
> > -		drop_super(sb);
> > -	else
> > -		drop_super_exclusive(sb);
> > +	if (!q_path) {
> > +		if (!quotactl_cmd_onoff(cmds))
> > +			drop_super(sb);
> > +		else
> > +			drop_super_exclusive(sb);
> > +	}
> >  out:
> > +	if (q_path)
> > +		path_put(&qpath);
> > +out1:
> 
> Why do you need out1? If you leave 'out' as is, things should just work.
> And you can also combine the above if like:

See above where out1 is used. In this case qpath is not valid and I
cannot call path_put() on it.

I see that having q_path and qpath as different variables is confusing,
but as you say I will rename qpath to sb_path, so hopefully this
already makes it clearer.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
