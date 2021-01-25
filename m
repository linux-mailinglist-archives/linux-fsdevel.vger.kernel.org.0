Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF18302772
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 17:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbhAYQFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 11:05:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:46130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729886AbhAYQEU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:04:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FEA9AD6A;
        Mon, 25 Jan 2021 15:45:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 44CD21E14B3; Mon, 25 Jan 2021 16:45:07 +0100 (CET)
Date:   Mon, 25 Jan 2021 16:45:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210125154507.GH1175@quack2.suse.cz>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125083854.GB31738@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-01-21 09:38:54, Sascha Hauer wrote:
> On Fri, Jan 22, 2021 at 05:16:58PM +0000, Christoph Hellwig wrote:
> > On Fri, Jan 22, 2021 at 04:15:29PM +0100, Sascha Hauer wrote:
> > > This patch introduces the Q_PATH flag to the quotactl cmd argument.
> > > When given, the path given in the special argument to quotactl will
> > > be the mount path where the filesystem is mounted, instead of a path
> > > to the block device.
> > > This is necessary for filesystems which do not have a block device as
> > > backing store. Particularly this is done for upcoming UBIFS support.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > I hate overloading quotactl even more.  Why not add a new quotactl_path
> > syscall instead?
> 
> We can probably do that. Honza, what do you think?

Hum, yes, probably it would be cleaner to add a new syscall for this so
that we don't overload quotactl(2). I just didn't think of this.

> > > +static struct super_block *quotactl_path(const char __user *special, int cmd)
> > > +{
> > > +	struct super_block *sb;
> > > +	struct path path;
> > > +	int error;
> > > +
> > > +	error = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
> > > +			   &path);
> > 
> > This adds an overly long line.
> 
> ok, will change.
> 
> > 
> > > +	if (error)
> > > +		return ERR_PTR(error);
> > > +
> > > +	sb = quotactl_sb(path.mnt->mnt_sb->s_dev, cmd);
> > 
> > I think quotactl_sb should take the superblock directly.  This will
> > need a little refactoring of user_get_super, but will lead to much
> > better logic.
> 
> What do you mean by "take"? Take the superblock as an argument to
> quotactl_sb() or take a reference to the superblock?
> Sorry, I don't really get where you aiming at.

I think Christoph was pointing at the fact it is suboptimal to search for
superblock by device number when you already have a pointer to it.  And I
guess he was suggesting we could pass 'sb' pointer to quotactl_sb() when we
already have it. Although to be honest, I'm not sure how Christoph imagines
the refactoring of user_get_super() he mentions - when we have a path
looked up through user_path(), that pins the superblock the path is on so
it cannot be unmounted. So perhaps quotactl_sb() can done like:

	...
retry:
	if (passed_sb) {
		sb = passed_sb;
		sb->s_count++;
		if (excl)
			down_write(&sb->s_umount);
		else
			down_read(&sb->s_umount);
	} else {
		sb = user_get_super(dev, excl);
		if (!sb)
			return ERR_PTR(-ENODEV);
	}
	...


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
