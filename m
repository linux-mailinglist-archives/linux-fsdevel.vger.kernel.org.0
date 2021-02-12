Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2126319B5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBLIj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 03:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhBLIjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:39:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FEBC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 00:38:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lATyG-00080K-Ru; Fri, 12 Feb 2021 09:38:36 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lATyF-0003tO-NC; Fri, 12 Feb 2021 09:38:35 +0100
Date:   Fri, 12 Feb 2021 09:38:35 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210212083835.GF19583@pengutronix.de>
References: <20210211153024.32502-1-s.hauer@pengutronix.de>
 <20210211153024.32502-2-s.hauer@pengutronix.de>
 <20210211153813.GA2480649@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211153813.GA2480649@infradead.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:30:38 up 71 days, 20:57, 106 users,  load average: 0.33, 0.12,
 0.12
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:38:13PM +0000, Christoph Hellwig wrote:
> > +	if (!mountpoint)
> > +		return -ENODEV;
> > +
> > +	ret = user_path_at(AT_FDCWD, mountpoint,
> > +			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
> 
> user_path_at handles an empty path, although you'll get EFAULT instead.
> Do we care about the -ENODEV here?

The quotactl manpage documents EFAULT as error code for invalid addr or
special argument, so we really should return -EFAULT here.

Existing quotactl gets this wrong as well:

	if (!special) {
		if (cmds == Q_SYNC)
			return quota_sync_all(type);
		return -ENODEV;
	}

Should we fix this or is there userspace code that is confused by a changed
return value?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
