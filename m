Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1C37C359
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhELPS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 11:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhELPOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 11:14:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB8C06138F
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 08:03:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lgqOp-0002k4-OL; Wed, 12 May 2021 17:03:47 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lgqOo-0007BI-N4; Wed, 12 May 2021 17:03:46 +0200
Date:   Wed, 12 May 2021 17:03:46 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210512150346.GQ19819@pengutronix.de>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
 <20210512110149.GA31495@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512110149.GA31495@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:00:10 up 83 days, 18:24, 103 users,  load average: 0.20, 0.14,
 0.11
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
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

This sounds like a much cleaner interface to me. If we agree on this I
wouldn't mind spinning this patch for another few rounds.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
