Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4EC8E89D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 11:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfHOJxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 05:53:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:35444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfHOJxJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:53:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54B36B63F;
        Thu, 15 Aug 2019 09:53:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CBDEF1E4200; Thu, 15 Aug 2019 11:53:06 +0200 (CEST)
Date:   Thu, 15 Aug 2019 11:53:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/11] quota: Allow to pass quotactl a mountpoint
Message-ID: <20190815095306.GB14313@quack2.suse.cz>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-6-s.hauer@pengutronix.de>
 <20190814233632.GW1131@ZenIV.linux.org.uk>
 <20190814233946.GX1131@ZenIV.linux.org.uk>
 <20190814235124.GY1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814235124.GY1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-08-19 00:51:24, Al Viro wrote:
> On Thu, Aug 15, 2019 at 12:39:46AM +0100, Al Viro wrote:
> > > 1) introduction of EXPORT_SYMBOL_GPL garbage
> > > 2) aforementioned garbage on something that doesn't need to be exported
> > > 3) *way* too easily abused - get_super() is, at least, not tempting to
> > > play with in random code.  This one is, and it's too low-level to
> > > allow.
> > 
> > ... and this is a crap userland API.
> > 
> > *IF* you want mountpoint-based variants of quotactl() commands, by all means,
> > add those.  Do not overload the old ones.  And for path-based you don't
> > need to mess with superblock references - just keep the struct path until
> > the end.  That will keep the superblock alive and active just fine.
> 
> 	To clarify: I suggest something like #define Q_PATH     0x400000
> with users passing something like QCMD(Q_QUOTAON | Q_PATH, ...) instead
> of QCMD(Q_QUOTAON, ...) to get a path-based behaviour.

Yeah, this sounds like a good plan to me. If Sasha plans on using userspace
quota-tools for handling ubifs, some work will be needed there as well but
it's doable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
