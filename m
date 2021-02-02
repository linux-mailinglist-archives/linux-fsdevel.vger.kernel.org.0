Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4681B30C8F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 19:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhBBSFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 13:05:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:46048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238188AbhBBSDZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:03:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15EB3AD3E;
        Tue,  2 Feb 2021 18:02:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8A71C1E14C3; Tue,  2 Feb 2021 19:02:41 +0100 (CET)
Date:   Tue, 2 Feb 2021 19:02:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210202180241.GE17147@quack2.suse.cz>
References: <20210128141713.25223-1-s.hauer@pengutronix.de>
 <20210128141713.25223-2-s.hauer@pengutronix.de>
 <20210128143552.GA2042235@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128143552.GA2042235@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 28-01-21 14:35:52, Christoph Hellwig wrote:
> > +	struct path path, *pathp = NULL;
> > +	struct path mountpath;
> > +	bool excl = false, thawed = false;
> > +	int ret;
> > +
> > +	cmds = cmd >> SUBCMDSHIFT;
> > +	type = cmd & SUBCMDMASK;
> 
> Personal pet peeve: it would be nice to just initialize cmds and
> type on their declaration line, or while we're at it declutter
> this a bit and remove the separate cmds variable:
> 
> 	unsigned int type = cmd & SUBCMDMASK;
> 
> 	cmd >>= SUBCMDSHIFT;

Yeah, whatever :)

> > +	/*
> > +	 * Path for quotaon has to be resolved before grabbing superblock
> > +	 * because that gets s_umount sem which is also possibly needed by path
> > +	 * resolution (think about autofs) and thus deadlocks could arise.
> > +	 */
> > +	if (cmds == Q_QUOTAON) {
> > +		ret = user_path_at(AT_FDCWD, addr,
> > +				   LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &path);
> > +		if (ret)
> > +			pathp = ERR_PTR(ret);
> > +		else
> > +			pathp = &path;
> > +	}
> > +
> > +	ret = user_path_at(AT_FDCWD, mountpoint,
> > +			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
> > +	if (ret)
> > +		goto out;
> 
> I don't think we need two path lookups here, we can path the same path
> to the command for quotaon.

Hum, let me think out loud. The path we pass to Q_QUOTAON is a path to
quota file - unless the filesystem stores quota in hidden files in which
case this argument is just ignored. You're right we could require that
specifically for Q_QUOTAON, the mountpoint path would actually need to
point to the quota file if it is relevant, otherwise anywhere in the
appropriate filesystem. We don't allow quota file to reside on a different
filesystem (for a past decade or so) so it should work fine.

So the only problem I have is whether requiring the mountpoint argument to
point quota file for Q_QUOTAON isn't going to be somewhat confusing to
users. At the very least it would require some careful explanation in the
manpage to explain the difference between quotactl_path() and quotactl()
in this regard. But is saving the second path for Q_QUOTAON really worth the
bother?

> > +	if (quotactl_cmd_onoff(cmds)) {
> > +		excl = true;
> > +		thawed = true;
> > +	} else if (quotactl_cmd_write(cmds)) {
> > +		thawed = true;
> > +	}
> > +
> > +	if (thawed) {
> > +		ret = mnt_want_write(mountpath.mnt);
> > +		if (ret)
> > +			goto out1;
> > +	}
> > +
> > +	sb = mountpath.dentry->d_inode->i_sb;
> > +
> > +	if (excl)
> > +		down_write(&sb->s_umount);
> > +	else
> > +		down_read(&sb->s_umount);
> 
> Given how cheap quotactl_cmd_onoff and quotactl_cmd_write are we
> could probably simplify this down do:
> 
> 	if (quotactl_cmd_write(cmd)) {

This needs to be (quotactl_cmd_write(cmd) || quotactl_cmd_onoff(cmd)).
Otherwise I agree what you suggest is somewhat more readable given how
small the function is.

> 		ret = mnt_want_write(path.mnt);
> 		if (ret)
> 			goto out1;
> 	}
> 	if (quotactl_cmd_onoff(cmd))
> 		down_write(&sb->s_umount);
> 	else
> 		down_read(&sb->s_umount);
> 
> and duplicate the checks after the do_quotactl call.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
