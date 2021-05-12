Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D741D37BD77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhELM4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 08:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233514AbhELMyZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 08:54:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD1AC61177;
        Wed, 12 May 2021 12:53:13 +0000 (UTC)
Date:   Wed, 12 May 2021 14:53:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210512125310.m3b4ralhwsdocpyb@wittgenstein>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
 <20210512110149.GA31495@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210512110149.GA31495@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 01:01:49PM +0200, Jan Kara wrote:
> Added a few more CCs.
> 
> On Tue 16-03-21 12:29:16, Jan Kara wrote:
> > On Thu 04-03-21 13:35:38, Sascha Hauer wrote:
> > > Current quotactl syscall uses a path to a block device to specify the
> > > filesystem to work on which makes it unsuitable for filesystems that
> > > do not have a block device. This series adds a new syscall quotactl_path()
> > > which replaces the path to the block device with a mountpath, but otherwise
> > > behaves like original quotactl.
> > > 
> > > This is done to add quota support to UBIFS. UBIFS quota support has been
> > > posted several times with different approaches to put the mountpath into
> > > the existing quotactl() syscall until it has been suggested to make it a
> > > new syscall instead, so here it is.
> > > 
> > > I'm not posting the full UBIFS quota series here as it remains unchanged
> > > and I'd like to get feedback to the new syscall first. For those interested
> > > the most recent series can be found here: https://lwn.net/Articles/810463/
> > 
> > Thanks. I've merged the two patches into my tree and will push them to
> > Linus for the next merge window.
> 
> So there are some people at LWN whining that quotactl_path() has no dirfd
> and flags arguments for specifying the target. Somewhat late in the game
> but since there's no major release with the syscall and no userspace using
> it, I think we could still change that. What do you think? What they
> suggest does make some sense. But then, rather then supporting API for
> million-and-one ways in which I may wish to lookup a fs object, won't it be
> better to just pass 'fd' in the new syscall (it may well be just O_PATH fd
> AFAICT) and be done with that?

I think adding a dirfd argument makes a lot of sense (Unless there are
some restrictions around quotas I'm misunderstanding.).

If I may: in general, I think we should aim to not add additional system
calls that operate on paths only. Purely path-based apis tend to be the
source of security issues especially when scoped lookups are really
important which given the ubiquity of sandboxing solutions nowadays is
quite often actually.
For example, when openat2() landed it gave such a boost in lookup
capabilities that I switched some libraries over to only ever do scoped
lookups, i.e. I decide on a starting point that gets opened path-based
and then explicitly express how I want that lookup to proceed ultimately
opening the final path component on which I want to perform operations.
Combined with the mount API almost everything can be done purely fd
based.

In addition to that dirfd-scopable system calls allow for a much nicer
api experience when programming in userspace.

Christian
