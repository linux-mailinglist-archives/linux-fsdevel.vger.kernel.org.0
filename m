Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9C8303E6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 14:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbhAZNSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 08:18:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:52216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404145AbhAZNSe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:18:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD38CAD19;
        Tue, 26 Jan 2021 13:17:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 880E81E151D; Tue, 26 Jan 2021 14:17:52 +0100 (CET)
Date:   Tue, 26 Jan 2021 14:17:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210126131752.GB10966@quack2.suse.cz>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
 <20210125154507.GH1175@quack2.suse.cz>
 <20210125204249.GA1103662@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125204249.GA1103662@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-01-21 20:42:49, Christoph Hellwig wrote:
> On Mon, Jan 25, 2021 at 04:45:07PM +0100, Jan Kara wrote:
> > > What do you mean by "take"? Take the superblock as an argument to
> > > quotactl_sb() or take a reference to the superblock?
> > > Sorry, I don't really get where you aiming at.
> > 
> > I think Christoph was pointing at the fact it is suboptimal to search for
> > superblock by device number when you already have a pointer to it.  And I
> > guess he was suggesting we could pass 'sb' pointer to quotactl_sb() when we
> > already have it. Although to be honest, I'm not sure how Christoph imagines
> > the refactoring of user_get_super() he mentions - when we have a path
> > looked up through user_path(), that pins the superblock the path is on so
> > it cannot be unmounted. So perhaps quotactl_sb() can done like:
> 
> I don't think we need a quotactl_sb at all, do_quotactl is in fact a
> pretty good abstraction as-is.
> 
> For the path based one we just need to factor out a little helper
> to set excl and thaw and then call it like:
> 
> 	sb = path.dentry->d_inode->i_sb;
> 
> 	if (excl)
> 		down_write(&sb->s_umount);
> 	else
> 		down_read(&sb->s_umount);
> 	if (thawed && sb->s_writers.frozen != SB_UNFROZEN)
> 		ret = -EBUSY;
> 	else
> 		ret = do_quotactl(sb, type, cmds, id, addr, &path);
> 	if (excl)
> 		up_write(&sb->s_umount);
> 	else
> 		up_read(&sb->s_umount);
> 
> as there is no good reason to bring over the somewhat strange wait until
> unfrozen semantics to a new syscall.

Well, I don't think that "wait until unfrozen" is that strange e.g. for
Q_SETQUOTA - it behaves like setxattr() or any other filesystem
modification operation. And IMO it is desirable that filesystem freezing is
transparent for operations like these. For stuff like Q_QUOTAON, I agree
that returning EBUSY makes sense but then I'm not convinced it's really
simpler or more useful behavior...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
