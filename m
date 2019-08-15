Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2768E58D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 09:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfHOHb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 03:31:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfHOHb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:31:28 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hyAEI-0008A0-Km; Thu, 15 Aug 2019 09:31:26 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hyAEG-0000RX-5L; Thu, 15 Aug 2019 09:31:24 +0200
Date:   Thu, 15 Aug 2019 09:31:24 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     "Mainz, Roland" <R.Mainz@eckelmann.de>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 07/11] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
Message-ID: <20190815073124.p2wqwyggh2nwvxhp@pengutronix.de>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-8-s.hauer@pengutronix.de>
 <48831093afb8467b90ecf3c96601a2db@eckelmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48831093afb8467b90ecf3c96601a2db@eckelmann.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:29:56 up 38 days, 13:40, 48 users,  load average: 0.01, 0.16,
 0.22
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:11:08PM +0000, Mainz, Roland wrote:
> 
> 
> 
> > -----Original Message-----
> > From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of
> > Sascha Hauer
> > Sent: Wednesday, August 14, 2019 2:19 PM
> > To: linux-fsdevel@vger.kernel.org
> > Cc: Richard Weinberger <richard@nod.at>; Sascha Hauer
> > <s.hauer@pengutronix.de>; linux-mtd@lists.infradead.org;
> > kernel@pengutronix.de; Jan Kara <jack@suse.com>
> > Subject: [PATCH 07/11] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
> > 
> > The FS_IOC_FS[SG]ETXATTR ioctls are an alternative to FS_IOC_[GS]ETFLAGS
> > with additional features. This patch adds support for these ioctls.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  fs/ubifs/ioctl.c | 89
> > +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 84 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c index
> > b9c4a51bceea..121aa1003e24 100644
> > --- a/fs/ubifs/ioctl.c
> > +++ b/fs/ubifs/ioctl.c
> > @@ -95,9 +95,39 @@ static int ubifs2ioctl(int ubifs_flags)
> >  	return ioctl_flags;
> >  }
> > 
> > -static int setflags(struct file *file, int flags)
> > +/* Transfer xflags flags to internal */ static inline unsigned long
> > +ubifs_xflags_to_iflags(__u32 xflags)
> >  {
> > -	int oldflags, err, release;
> > +	unsigned long iflags = 0;
> > +
> > +	if (xflags & FS_XFLAG_SYNC)
> > +		iflags |= UBIFS_APPEND_FL;
> 
> Erm... what does |FS_XFLAG_SYNC| have to do with |*APPEND| ? Is this a typo ?

Hm, some copy-paste accident probably. That's rubbish of course.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
