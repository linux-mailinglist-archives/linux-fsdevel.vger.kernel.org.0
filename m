Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F171518EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 11:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBDKf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 05:35:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41971 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgBDKf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:35:28 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iyvYC-0004wP-NX; Tue, 04 Feb 2020 11:35:24 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iyvYB-0004Gi-3r; Tue, 04 Feb 2020 11:35:23 +0100
Date:   Tue, 4 Feb 2020 11:35:23 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20200204103523.tbxzptf4lkr474yi@pengutronix.de>
References: <20200124131323.23885-1-s.hauer@pengutronix.de>
 <20200124131323.23885-2-s.hauer@pengutronix.de>
 <20200127104518.GC19414@quack2.suse.cz>
 <20200128100631.zv7cn726twylcmb7@pengutronix.de>
 <20200129012929.GV23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129012929.GV23230@ZenIV.linux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:21:53 up 211 days, 14:32, 79 users,  load average: 0.16, 0.19,
 0.23
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 01:29:29AM +0000, Al Viro wrote:
> On Tue, Jan 28, 2020 at 11:06:31AM +0100, Sascha Hauer wrote:
> > Hi Jan,
> 
> > @@ -810,6 +811,36 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
> >  #endif
> >  }
> >  
> > +static struct super_block *quotactl_path(const char __user *special, int cmd,
> > +					 struct path *path)
> > +{
> > +	struct super_block *sb;
> > +	int ret;
> > +
> > +	ret = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
> > +			   path);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	sb = path->mnt->mnt_sb;
> > +restart:
> > +	if (quotactl_cmd_onoff(cmd))
> > +		down_write(&sb->s_umount);
> > +	else
> > +		down_read(&sb->s_umount);
> > +
> > +	if (quotactl_cmd_write(cmd) && sb->s_writers.frozen != SB_UNFROZEN) {
> > +		if (quotactl_cmd_onoff(cmd))
> > +			up_write(&sb->s_umount);
> > +		else
> > +			up_read(&sb->s_umount);
> > +		wait_event(sb->s_writers.wait_unfrozen,
> > +			   sb->s_writers.frozen == SB_UNFROZEN);
> > +		goto restart;
> > +	}
> > +
> > +	return sb;
> > +}
> 
> This partial duplicate of __get_super_thawed() guts does *not* belong here,
> especially not interleaved with quota-specific checks.
> 
> > +	if (q_path) {
> > +		if (quotactl_cmd_onoff(cmd))
> > +			up_write(&sb->s_umount);
> > +		else
> > +			up_read(&sb->s_umount);
> > +
> > +		path_put(&sb_path);
> > +	} else {
> > +		if (!quotactl_cmd_onoff(cmds))
> > +			drop_super(sb);
> > +		else
> > +			drop_super_exclusive(sb);
> > +	}
> 
> Er...  Why not have the same code that you've used to lock the damn thing
> (needs to be moved to fs/super.c) simply get a passive ref to it?  Then
> you could do the same thing, q_path or no q_path...

I am getting confused here. To an earlier version of this series you
responded:

> And for path-based you don't need to mess with superblock
> references - just keep the struct path until the end.  That
> will keep the superblock alive and active just fine.

I did that and got the objection from Jan:

> So I've realized that just looking up superblock with user_path_at() is not
> enough. Quota code also expects that the superblock will be locked
> (sb->s_umount) and filesystem will not be frozen (in case the quota
> operation is going to modify the filesystem). This is needed to serialize
> e.g. remount and quota operations or quota operations among themselves.

So after drawing circles we now seem to be back at passive references.
What I have now in my tree is this in fs/super.c, untested currently:

static bool __grab_super_thawed(struct super_block *sb, bool excl)
{
	while (1) {
		bool again = false;

		spin_lock(&sb_lock);

		if (hlist_unhashed(&sb->s_instances)) {
			spin_unlock(&sb_lock);
			return false;
		}

		sb->s_count++;
		spin_unlock(&sb_lock);

		if (excl)
			down_write(&sb->s_umount);
		else
			down_read(&sb->s_umount);

		if (sb->s_root && (sb->s_flags & SB_BORN)) {
			if (sb->s_writers.frozen == SB_UNFROZEN)
				return true;
			else
				again = true;
		}

		if (excl)
			up_write(&sb->s_umount);
		else
			up_read(&sb->s_umount);

		if (again)
			wait_event(sb->s_writers.wait_unfrozen,
				   sb->s_writers.frozen == SB_UNFROZEN);

		put_super(sb);

		if (!again)
			return false;
	}

	return ret;
}

int grab_super_thawed(struct super_block *sb)
{
	return __grab_super_thawed(sb, false);
}

int grab_super_exclusive_thawed(struct super_block *sb)
{
	return __grab_super_thawed(sb, true);
}

Does this look ok now?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
