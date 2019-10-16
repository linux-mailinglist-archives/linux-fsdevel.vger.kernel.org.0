Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB90DD8A13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbfJPHng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:43:36 -0400
Received: from verein.lst.de ([213.95.11.211]:59476 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387890AbfJPHng (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:43:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D8C8E68B20; Wed, 16 Oct 2019 09:43:31 +0200 (CEST)
Date:   Wed, 16 Oct 2019 09:43:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] iomap: lift the xfs writeback code to iomap
Message-ID: <20191016074331.GA23696@lst.de>
References: <20191015154345.13052-1-hch@lst.de> <20191015154345.13052-10-hch@lst.de> <20191015184040.GU13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015184040.GU13108@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:40:40AM -0700, Darrick J. Wong wrote:
> > +	if (unlikely(error && !quiet)) {
> > +		printk_ratelimited(KERN_ERR
> > +			"%s: writeback error on sector %llu",
> > +			inode->i_sb->s_id, start);
> 
> Ugh, /this/ message.  It's pretty annoying how it doesn't tell you which
> file or where in that file the write was lost.

Sure, feel free to improve it in a follow on patch.

> 
> I want to send in a patch atop your series to fix this, though I'm a
> also little inclined to want to keep the message inside XFS.
> 
> Thoughts?

I don't see a sensible way to keep it in the file system, and I also
don't really see what that would buy us.  I'd rather use the same
message for all iomap using file systems rather than having slightly
different error reporting for each of them.
inside the iomap callstack.
