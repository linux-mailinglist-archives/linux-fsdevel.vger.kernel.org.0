Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77E5305E95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 15:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhA0Ori (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 09:47:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:38204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234335AbhA0Ora (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:47:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AABA8ABDA;
        Wed, 27 Jan 2021 14:46:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6151B1E14D0; Wed, 27 Jan 2021 15:46:46 +0100 (CET)
Date:   Wed, 27 Jan 2021 15:46:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210127144646.GB13717@quack2.suse.cz>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
 <20210125154507.GH1175@quack2.suse.cz>
 <20210126104557.GB28722@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126104557.GB28722@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-01-21 11:45:57, Sascha Hauer wrote:
> On Mon, Jan 25, 2021 at 04:45:07PM +0100, Jan Kara wrote:
> > On Mon 25-01-21 09:38:54, Sascha Hauer wrote:
> > > On Fri, Jan 22, 2021 at 05:16:58PM +0000, Christoph Hellwig wrote:
> > > > On Fri, Jan 22, 2021 at 04:15:29PM +0100, Sascha Hauer wrote:
> > > > > This patch introduces the Q_PATH flag to the quotactl cmd argument.
> > > > > When given, the path given in the special argument to quotactl will
> > > > > be the mount path where the filesystem is mounted, instead of a path
> > > > > to the block device.
> > > > > This is necessary for filesystems which do not have a block device as
> > > > > backing store. Particularly this is done for upcoming UBIFS support.
> > > > > 
> > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > 
> > > > I hate overloading quotactl even more.  Why not add a new quotactl_path
> > > > syscall instead?
> > > 
> > > We can probably do that. Honza, what do you think?
> > 
> > Hum, yes, probably it would be cleaner to add a new syscall for this so
> > that we don't overload quotactl(2). I just didn't think of this.
> 
> How should the semantics of that new syscall look like?
> 
> The easiest and most obvious way would be to do it like the quotactl(2)
> and just replace the special argument with a path:
> 
> int quotactl_path(int cmd, const char *path, int id, caddr_t addr);

Yes, that's what I meant.

> If we try adding a new syscall then we could completely redefine the API
> and avoid the shortcomings of the original quotactl(2) if there are any.
> Can you foresee the discussions we end up in? I am afraid I am opening a
> can of worms here.
> OTOH there might be value in keeping the new syscall compatible to the
> existing one, but I don't know how much this argument counts.

That's a good question but also a can of worms as you write :). One obvious
problem with quotactl() is that's it's ioctl-like interface. So we have
several different operations mixed into a single syscall. Currently there
are these operations:

#define Q_SYNC     0x800001     /* sync disk copy of a filesystems quotas */
#define Q_QUOTAON  0x800002     /* turn quotas on */
#define Q_QUOTAOFF 0x800003     /* turn quotas off */
#define Q_GETFMT   0x800004     /* get quota format used on given filesystem */
#define Q_GETINFO  0x800005     /* get information about quota files */
#define Q_SETINFO  0x800006     /* set information about quota files */
#define Q_GETQUOTA 0x800007     /* get user quota structure */
#define Q_SETQUOTA 0x800008     /* set user quota structure */
#define Q_GETNEXTQUOTA 0x800009 /* get disk limits and usage >= ID */
<plus their XFS variants>

In a puristic world they'd be 9 different syscalls ... or somewhat less
because Q_GETNEXTQUOTA is a superset of Q_GETQUOTA, we could drop Q_SYNC
and Q_GETFMT because they have dubious value these days so we'd be left
with 6. I don't have a strong opinion whether 6 syscalls are worth the
cleanliness or whether we should go with just one new quotactl_path()
syscall. I've CCed linux-api in case other people have opinion.

Anyway, even if we go with single quotactl_path() syscall we should remove
the duplication between VFS and XFS quotactls when we are creating a new
syscall. Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
