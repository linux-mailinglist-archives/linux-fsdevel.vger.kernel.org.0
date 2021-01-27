Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA2305DDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhA0OHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 09:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhA0OGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:06:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F14C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 06:05:26 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l4lRj-0008SV-2i; Wed, 27 Jan 2021 15:05:23 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l4lRW-00024o-JR; Wed, 27 Jan 2021 15:05:10 +0100
Date:   Wed, 27 Jan 2021 15:05:10 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210127140510.GI28722@pengutronix.de>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
 <20210125154507.GH1175@quack2.suse.cz>
 <20210125204249.GA1103662@infradead.org>
 <20210126131752.GB10966@quack2.suse.cz>
 <20210126133406.GA1346375@infradead.org>
 <20210126161829.GG10966@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126161829.GG10966@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:59:08 up 56 days,  2:26, 96 users,  load average: 0.05, 0.07,
 0.08
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 05:18:29PM +0100, Jan Kara wrote:
> On Tue 26-01-21 13:34:06, Christoph Hellwig wrote:
> > On Tue, Jan 26, 2021 at 02:17:52PM +0100, Jan Kara wrote:
> > > Well, I don't think that "wait until unfrozen" is that strange e.g. for
> > > Q_SETQUOTA - it behaves like setxattr() or any other filesystem
> > > modification operation. And IMO it is desirable that filesystem freezing is
> > > transparent for operations like these. For stuff like Q_QUOTAON, I agree
> > > that returning EBUSY makes sense but then I'm not convinced it's really
> > > simpler or more useful behavior...
> > 
> > If we want it to behave like other syscalls we'll just need to throw in
> > a mnt_want_write/mnt_drop_write pair.  Than it behaves exactly like other
> > syscalls.
> 
> Right, we could do that. I'd just note that the "wait until unfrozen" and
> holding of sb->s_umount semaphore is equivalent to
> mnt_want_write/mnt_drop_write pair. But I agree
> mnt_want_write/mnt_drop_write is easier to understand and there's no reason
> not to use it. So I'm for that simplification in the new syscall.

Due to the user_path_at() to the mountpoint the fs won't go away, so I
guess for non-exclusive, non-write quota command I don't need any
additional locking. For non-exclusive, write commands I'll need a
mnt_want_write/mnt_drop_write pair. What about the exclusive, write
commands (Q_QUOTAON/Q_QUOTAOFF)?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
