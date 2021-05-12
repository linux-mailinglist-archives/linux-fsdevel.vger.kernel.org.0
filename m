Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906537BDCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhELNPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:15:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232056AbhELNPj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:15:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0F86ADA2;
        Wed, 12 May 2021 13:14:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 815211E0A4C; Wed, 12 May 2021 15:14:29 +0200 (CEST)
Date:   Wed, 12 May 2021 15:14:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210512131429.GA2734@quack2.suse.cz>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
 <20210512110149.GA31495@quack2.suse.cz>
 <20210512125310.m3b4ralhwsdocpyb@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512125310.m3b4ralhwsdocpyb@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-05-21 14:53:10, Christian Brauner wrote:
> On Wed, May 12, 2021 at 01:01:49PM +0200, Jan Kara wrote:
> > Added a few more CCs.
> > 
> > On Tue 16-03-21 12:29:16, Jan Kara wrote:
> > > On Thu 04-03-21 13:35:38, Sascha Hauer wrote:
> > > > Current quotactl syscall uses a path to a block device to specify the
> > > > filesystem to work on which makes it unsuitable for filesystems that
> > > > do not have a block device. This series adds a new syscall quotactl_path()
> > > > which replaces the path to the block device with a mountpath, but otherwise
> > > > behaves like original quotactl.
> > > > 
> > > > This is done to add quota support to UBIFS. UBIFS quota support has been
> > > > posted several times with different approaches to put the mountpath into
> > > > the existing quotactl() syscall until it has been suggested to make it a
> > > > new syscall instead, so here it is.
> > > > 
> > > > I'm not posting the full UBIFS quota series here as it remains unchanged
> > > > and I'd like to get feedback to the new syscall first. For those interested
> > > > the most recent series can be found here: https://lwn.net/Articles/810463/
> > > 
> > > Thanks. I've merged the two patches into my tree and will push them to
> > > Linus for the next merge window.
> > 
> > So there are some people at LWN whining that quotactl_path() has no dirfd
> > and flags arguments for specifying the target. Somewhat late in the game
> > but since there's no major release with the syscall and no userspace using
> > it, I think we could still change that. What do you think? What they
> > suggest does make some sense. But then, rather then supporting API for
> > million-and-one ways in which I may wish to lookup a fs object, won't it be
> > better to just pass 'fd' in the new syscall (it may well be just O_PATH fd
> > AFAICT) and be done with that?
> 
> I think adding a dirfd argument makes a lot of sense (Unless there are
> some restrictions around quotas I'm misunderstanding.).
> 
> If I may: in general, I think we should aim to not add additional system
> calls that operate on paths only. Purely path-based apis tend to be the
> source of security issues especially when scoped lookups are really
> important which given the ubiquity of sandboxing solutions nowadays is
> quite often actually.
> For example, when openat2() landed it gave such a boost in lookup
> capabilities that I switched some libraries over to only ever do scoped
> lookups, i.e. I decide on a starting point that gets opened path-based
> and then explicitly express how I want that lookup to proceed ultimately
> opening the final path component on which I want to perform operations.
> Combined with the mount API almost everything can be done purely fd
> based.
> 
> In addition to that dirfd-scopable system calls allow for a much nicer
> api experience when programming in userspace.

OK, thanks for your insights. But when we add 'dirfd' I wonder whether we
still need the 'path' component then. I mean you can always do fd =
openat2(), quotactl_fd(fd, ...). After all ioctl() works exactly that way
since the beginning. The only advantage of quotactl_xxx() taking path would
be saving the open(2) call. That is somewhat convenient for simple cases
(but also error prone in complex setups as you point out) and can be also
sligthly faster (but quotactl is hardly a performance sensitive thing)...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
