Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DBB8E152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 01:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfHNXjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 19:39:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50356 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHNXjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:39:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hy2rq-0001jN-5Z; Wed, 14 Aug 2019 23:39:46 +0000
Date:   Thu, 15 Aug 2019 00:39:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 05/11] quota: Allow to pass quotactl a mountpoint
Message-ID: <20190814233946.GX1131@ZenIV.linux.org.uk>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-6-s.hauer@pengutronix.de>
 <20190814233632.GW1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814233632.GW1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:36:32AM +0100, Al Viro wrote:
> On Wed, Aug 14, 2019 at 02:18:28PM +0200, Sascha Hauer wrote:
> > +/**
> > + * reference_super - get a reference to a given superblock
> > + * @sb: superblock to get the reference from
> > + *
> > + * Takes a reference to a superblock. Can be used as when the superblock
> > + * is known and leaves it in a state as if get_super had been called.
> > + */
> > +void reference_super(struct super_block *sb)
> > +{
> > +	spin_lock(&sb_lock);
> > +	sb->s_count++;
> > +	spin_unlock(&sb_lock);
> > +
> > +	down_read(&sb->s_umount);
> > +}
> > +EXPORT_SYMBOL_GPL(reference_super);
> 
> NAK, for a plenty of reasons
> 
> 1) introduction of EXPORT_SYMBOL_GPL garbage
> 2) aforementioned garbage on something that doesn't need to be exported
> 3) *way* too easily abused - get_super() is, at least, not tempting to
> play with in random code.  This one is, and it's too low-level to
> allow.

... and this is a crap userland API.

*IF* you want mountpoint-based variants of quotactl() commands, by all means,
add those.  Do not overload the old ones.  And for path-based you don't
need to mess with superblock references - just keep the struct path until
the end.  That will keep the superblock alive and active just fine.
