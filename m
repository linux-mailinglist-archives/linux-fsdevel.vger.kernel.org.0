Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF33319C6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 11:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhBLKNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 05:13:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:46196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhBLKNC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:13:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0C55ADDB;
        Fri, 12 Feb 2021 10:12:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E949B1E62E4; Fri, 12 Feb 2021 11:05:05 +0100 (CET)
Date:   Fri, 12 Feb 2021 11:05:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210212100505.GT19070@quack2.suse.cz>
References: <20210211153024.32502-1-s.hauer@pengutronix.de>
 <20210211153024.32502-2-s.hauer@pengutronix.de>
 <20210211153813.GA2480649@infradead.org>
 <20210212083835.GF19583@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212083835.GF19583@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-02-21 09:38:35, Sascha Hauer wrote:
> On Thu, Feb 11, 2021 at 03:38:13PM +0000, Christoph Hellwig wrote:
> > > +	if (!mountpoint)
> > > +		return -ENODEV;
> > > +
> > > +	ret = user_path_at(AT_FDCWD, mountpoint,
> > > +			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
> > 
> > user_path_at handles an empty path, although you'll get EFAULT instead.
> > Do we care about the -ENODEV here?
> 
> The quotactl manpage documents EFAULT as error code for invalid addr or
> special argument, so we really should return -EFAULT here.
> 
> Existing quotactl gets this wrong as well:
> 
> 	if (!special) {
> 		if (cmds == Q_SYNC)
> 			return quota_sync_all(type);
> 		return -ENODEV;
> 	}
> 
> Should we fix this or is there userspace code that is confused by a changed
> return value?

I'd leave the original quotactl(2) as is. There's no strong reason to risk
breaking some userspace. For the new syscall, I agree we can just
standardize the return value, there ENODEV makes even less sense since
there's no device in that call.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
