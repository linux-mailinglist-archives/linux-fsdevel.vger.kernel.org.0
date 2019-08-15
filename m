Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531AC8E5BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfHOHqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 03:46:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36803 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbfHOHqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:46:55 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hyATF-00014R-Ns; Thu, 15 Aug 2019 09:46:53 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hyATD-0000yH-QY; Thu, 15 Aug 2019 09:46:51 +0200
Date:   Thu, 15 Aug 2019 09:46:51 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 05/11] quota: Allow to pass quotactl a mountpoint
Message-ID: <20190815074651.4wnzc2beh7tpcori@pengutronix.de>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-6-s.hauer@pengutronix.de>
 <20190814233632.GW1131@ZenIV.linux.org.uk>
 <20190814233946.GX1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814233946.GX1131@ZenIV.linux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:34:43 up 38 days, 13:44, 50 users,  load average: 0.14, 0.13,
 0.19
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:39:46AM +0100, Al Viro wrote:
> On Thu, Aug 15, 2019 at 12:36:32AM +0100, Al Viro wrote:
> > On Wed, Aug 14, 2019 at 02:18:28PM +0200, Sascha Hauer wrote:
> > > +/**
> > > + * reference_super - get a reference to a given superblock
> > > + * @sb: superblock to get the reference from
> > > + *
> > > + * Takes a reference to a superblock. Can be used as when the superblock
> > > + * is known and leaves it in a state as if get_super had been called.
> > > + */
> > > +void reference_super(struct super_block *sb)
> > > +{
> > > +	spin_lock(&sb_lock);
> > > +	sb->s_count++;
> > > +	spin_unlock(&sb_lock);
> > > +
> > > +	down_read(&sb->s_umount);
> > > +}
> > > +EXPORT_SYMBOL_GPL(reference_super);
> > 
> > NAK, for a plenty of reasons
> > 
> > 1) introduction of EXPORT_SYMBOL_GPL garbage
> > 2) aforementioned garbage on something that doesn't need to be exported
> > 3) *way* too easily abused - get_super() is, at least, not tempting to
> > play with in random code.  This one is, and it's too low-level to
> > allow.
> 
> ... and this is a crap userland API.
> 
> *IF* you want mountpoint-based variants of quotactl() commands, by all means,
> add those.  Do not overload the old ones.  And for path-based you don't
> need to mess with superblock references - just keep the struct path until
> the end.  That will keep the superblock alive and active just fine.

I'll happily drop these changes. To clarify, quota currently does:

	if (quotactl_cmd_onoff(cmd))
		sb = get_super_exclusive_thawed(bdev);
	else if (quotactl_cmd_write(cmd))
		sb = get_super_thawed(bdev);
	else
		sb = get_super(bdev);

You are saying that the struct super_block I get from a struct path pointer is
in a suitable state for all the cases above, right?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
