Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A5F72DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 12:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKKLPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 06:15:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44479 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKLPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:15:04 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iU7er-0005tS-BT; Mon, 11 Nov 2019 12:14:57 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iU7eo-0003JR-C1; Mon, 11 Nov 2019 12:14:54 +0100
Date:   Mon, 11 Nov 2019 12:14:54 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/10] quota: Allow to pass mount path to quotactl
Message-ID: <20191111111454.7ebq4hhdcnakpnls@pengutronix.de>
References: <20191030152702.14269-1-s.hauer@pengutronix.de>
 <20191030152702.14269-5-s.hauer@pengutronix.de>
 <20191101160706.GA23441@quack2.suse.cz>
 <20191111100807.dzomp2o7n3mch6xx@pengutronix.de>
 <20191111110559.GB13307@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111110559.GB13307@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:14:02 up 126 days, 17:24, 139 users,  load average: 0.07, 0.14,
 0.14
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 12:05:59PM +0100, Jan Kara wrote:
> On Mon 11-11-19 11:08:07, Sascha Hauer wrote:
> > On Fri, Nov 01, 2019 at 05:07:06PM +0100, Jan Kara wrote:
> > > On Wed 30-10-19 16:26:56, Sascha Hauer wrote:
> > > > This patch introduces the Q_PATH flag to the quotactl cmd argument.
> > > > When given, the path given in the special argument to quotactl will
> > > > be the mount path where the filesystem is mounted, instead of a path
> > > > to the block device.
> > > > This is necessary for filesystems which do not have a block device as
> > > > backing store. Particularly this is done for upcoming UBIFS support.
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > Thanks for the patch! Some smaller comments below...
> > > 
> > > > ---
> > > >  fs/quota/quota.c           | 37 ++++++++++++++++++++++++++++---------
> > > >  include/uapi/linux/quota.h |  1 +
> > > >  2 files changed, 29 insertions(+), 9 deletions(-)
> > > > 
> > > > -	if (!quotactl_cmd_onoff(cmds))
> > > > -		drop_super(sb);
> > > > -	else
> > > > -		drop_super_exclusive(sb);
> > > > +	if (!q_path) {
> > > > +		if (!quotactl_cmd_onoff(cmds))
> > > > +			drop_super(sb);
> > > > +		else
> > > > +			drop_super_exclusive(sb);
> > > > +	}
> > > >  out:
> > > > +	if (q_path)
> > > > +		path_put(&qpath);
> > > > +out1:
> > > 
> > > Why do you need out1? If you leave 'out' as is, things should just work.
> > > And you can also combine the above if like:
> > 
> > See above where out1 is used. In this case qpath is not valid and I
> > cannot call path_put() on it.
> 
> Right. But you also don't need to do path_put(&qpath) in case
> quotactl_block() failed. So you can just jump to out1 there as well and
> then 'out' is unused...

Ah, I see. Ok, will do this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
