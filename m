Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8DC3049C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbhAZFXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAYJkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:40:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD844C061352
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 00:38:57 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l3xOi-0007V3-1o; Mon, 25 Jan 2021 09:38:56 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l3xOg-0008Hs-Lq; Mon, 25 Jan 2021 09:38:54 +0100
Date:   Mon, 25 Jan 2021 09:38:54 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210125083854.GB31738@pengutronix.de>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122171658.GA237653@infradead.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:17:40 up 53 days, 18:44, 60 users,  load average: 0.12, 0.09,
 0.09
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:16:58PM +0000, Christoph Hellwig wrote:
> On Fri, Jan 22, 2021 at 04:15:29PM +0100, Sascha Hauer wrote:
> > This patch introduces the Q_PATH flag to the quotactl cmd argument.
> > When given, the path given in the special argument to quotactl will
> > be the mount path where the filesystem is mounted, instead of a path
> > to the block device.
> > This is necessary for filesystems which do not have a block device as
> > backing store. Particularly this is done for upcoming UBIFS support.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> I hate overloading quotactl even more.  Why not add a new quotactl_path
> syscall instead?

We can probably do that. Honza, what do you think?

> 
> > +static struct super_block *quotactl_sb(dev_t dev, int cmd)
> >  {
> >  	struct super_block *sb;
> >  	bool excl = false, thawed = false;
> >  
> >  	if (quotactl_cmd_onoff(cmd)) {
> >  		excl = true;
> > @@ -901,12 +887,50 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
> >  		goto retry;
> >  	}
> >  	return sb;
> > +}
> > +
> > +/*
> > + * look up a superblock on which quota ops will be performed
> > + * - use the name of a block device to find the superblock thereon
> > + */
> > +static struct super_block *quotactl_block(const char __user *special, int cmd)
> > +{
> > +#ifdef CONFIG_BLOCK
> > +	struct filename *tmp = getname(special);
> > +	int error;
> > +	dev_t dev;
> >  
> > +	if (IS_ERR(tmp))
> > +		return ERR_CAST(tmp);
> > +	error = lookup_bdev(tmp->name, &dev);
> > +	putname(tmp);
> > +	if (error)
> > +		return ERR_PTR(error);
> > +
> > +	return quotactl_sb(dev, cmd);
> >  #else
> >  	return ERR_PTR(-ENODEV);
> >  #endif
> 
> Normal kernel style would be to keep the ifdef entirely outside the
> function.

It has been like this before, so changing this should be done in an
extra patch. Not sure if it's worth it though.

> 
> > +static struct super_block *quotactl_path(const char __user *special, int cmd)
> > +{
> > +	struct super_block *sb;
> > +	struct path path;
> > +	int error;
> > +
> > +	error = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
> > +			   &path);
> 
> This adds an overly long line.

ok, will change.

> 
> > +	if (error)
> > +		return ERR_PTR(error);
> > +
> > +	sb = quotactl_sb(path.mnt->mnt_sb->s_dev, cmd);
> 
> I think quotactl_sb should take the superblock directly.  This will
> need a little refactoring of user_get_super, but will lead to much
> better logic.

What do you mean by "take"? Take the superblock as an argument to
quotactl_sb() or take a reference to the superblock?
Sorry, I don't really get where you aiming at.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
