Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D7E319CA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhBLK3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 05:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhBLK3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:29:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD04DC061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 02:29:05 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lAVh6-0003Yv-PA; Fri, 12 Feb 2021 11:29:00 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lAVh6-0002Un-4a; Fri, 12 Feb 2021 11:29:00 +0100
Date:   Fri, 12 Feb 2021 11:29:00 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210212102900.GN19583@pengutronix.de>
References: <20210211153024.32502-1-s.hauer@pengutronix.de>
 <20210211153024.32502-2-s.hauer@pengutronix.de>
 <20210211153813.GA2480649@infradead.org>
 <20210212083835.GF19583@pengutronix.de>
 <20210212100505.GT19070@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212100505.GT19070@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:28:11 up 71 days, 22:55, 105 users,  load average: 0.07, 0.09,
 0.14
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 11:05:05AM +0100, Jan Kara wrote:
> On Fri 12-02-21 09:38:35, Sascha Hauer wrote:
> > On Thu, Feb 11, 2021 at 03:38:13PM +0000, Christoph Hellwig wrote:
> > > > +	if (!mountpoint)
> > > > +		return -ENODEV;
> > > > +
> > > > +	ret = user_path_at(AT_FDCWD, mountpoint,
> > > > +			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
> > > 
> > > user_path_at handles an empty path, although you'll get EFAULT instead.
> > > Do we care about the -ENODEV here?
> > 
> > The quotactl manpage documents EFAULT as error code for invalid addr or
> > special argument, so we really should return -EFAULT here.
> > 
> > Existing quotactl gets this wrong as well:
> > 
> > 	if (!special) {
> > 		if (cmds == Q_SYNC)
> > 			return quota_sync_all(type);
> > 		return -ENODEV;
> > 	}
> > 
> > Should we fix this or is there userspace code that is confused by a changed
> > return value?
> 
> I'd leave the original quotactl(2) as is. There's no strong reason to risk
> breaking some userspace. For the new syscall, I agree we can just
> standardize the return value, there ENODEV makes even less sense since
> there's no device in that call.

Ok, will do. Who can pick this series up? Anyone else I need to Cc next
round?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
