Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6E37BB68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 13:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhELLDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 07:03:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:44188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhELLC7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 07:02:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B359B15B;
        Wed, 12 May 2021 11:01:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E3C4E1E0A4C; Wed, 12 May 2021 13:01:49 +0200 (CEST)
Date:   Wed, 12 May 2021 13:01:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210512110149.GA31495@quack2.suse.cz>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316112916.GA23532@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added a few more CCs.

On Tue 16-03-21 12:29:16, Jan Kara wrote:
> On Thu 04-03-21 13:35:38, Sascha Hauer wrote:
> > Current quotactl syscall uses a path to a block device to specify the
> > filesystem to work on which makes it unsuitable for filesystems that
> > do not have a block device. This series adds a new syscall quotactl_path()
> > which replaces the path to the block device with a mountpath, but otherwise
> > behaves like original quotactl.
> > 
> > This is done to add quota support to UBIFS. UBIFS quota support has been
> > posted several times with different approaches to put the mountpath into
> > the existing quotactl() syscall until it has been suggested to make it a
> > new syscall instead, so here it is.
> > 
> > I'm not posting the full UBIFS quota series here as it remains unchanged
> > and I'd like to get feedback to the new syscall first. For those interested
> > the most recent series can be found here: https://lwn.net/Articles/810463/
> 
> Thanks. I've merged the two patches into my tree and will push them to
> Linus for the next merge window.

So there are some people at LWN whining that quotactl_path() has no dirfd
and flags arguments for specifying the target. Somewhat late in the game
but since there's no major release with the syscall and no userspace using
it, I think we could still change that. What do you think? What they
suggest does make some sense. But then, rather then supporting API for
million-and-one ways in which I may wish to lookup a fs object, won't it be
better to just pass 'fd' in the new syscall (it may well be just O_PATH fd
AFAICT) and be done with that?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
