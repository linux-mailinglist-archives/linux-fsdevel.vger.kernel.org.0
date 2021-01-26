Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF4303B3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 12:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbhAZLMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 06:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405030AbhAZLKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:10:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993E0C061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 03:09:29 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l4LrF-00008s-P7; Tue, 26 Jan 2021 11:46:01 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l4LrB-00054N-OP; Tue, 26 Jan 2021 11:45:57 +0100
Date:   Tue, 26 Jan 2021 11:45:57 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210126104557.GB28722@pengutronix.de>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
 <20210125154507.GH1175@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125154507.GH1175@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:20:06 up 54 days, 22:47, 98 users,  load average: 0.16, 0.17,
 0.21
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:45:07PM +0100, Jan Kara wrote:
> On Mon 25-01-21 09:38:54, Sascha Hauer wrote:
> > On Fri, Jan 22, 2021 at 05:16:58PM +0000, Christoph Hellwig wrote:
> > > On Fri, Jan 22, 2021 at 04:15:29PM +0100, Sascha Hauer wrote:
> > > > This patch introduces the Q_PATH flag to the quotactl cmd argument.
> > > > When given, the path given in the special argument to quotactl will
> > > > be the mount path where the filesystem is mounted, instead of a path
> > > > to the block device.
> > > > This is necessary for filesystems which do not have a block device as
> > > > backing store. Particularly this is done for upcoming UBIFS support.
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > I hate overloading quotactl even more.  Why not add a new quotactl_path
> > > syscall instead?
> > 
> > We can probably do that. Honza, what do you think?
> 
> Hum, yes, probably it would be cleaner to add a new syscall for this so
> that we don't overload quotactl(2). I just didn't think of this.

How should the semantics of that new syscall look like?

The easiest and most obvious way would be to do it like the quotactl(2)
and just replace the special argument with a path:

int quotactl_path(int cmd, const char *path, int id, caddr_t addr);

If we try adding a new syscall then we could completely redefine the API
and avoid the shortcomings of the original quotactl(2) if there are any.
Can you foresee the discussions we end up in? I am afraid I am opening a
can of worms here.
OTOH there might be value in keeping the new syscall compatible to the
existing one, but I don't know how much this argument counts.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
