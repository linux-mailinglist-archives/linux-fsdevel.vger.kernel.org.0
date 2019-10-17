Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E013DAFA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440051AbfJQORK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 10:17:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfJQORJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y+XGLl0Vap7SE0bMWtkcbzX0kf7bJtdYAujS7bFw7W0=; b=JFlEbV1bUAvp7psuG+ZDP7kjC
        T66v2pFcrUCPhNl4AXtu/IdIHPyP7R7SUkMJ1KFnmpSbCKEYyg/nSQN+ZWP4Vnm7PLAE6T25jzPk0
        V7T/U7pqBntq5FGRFGVF0C5+9PozuonaecxHr8/Q8xDTC6AogRpLDL7qWxoJKCOVqFq3ZEGB536m8
        uQORBqk/yjWh7clsA+7eQGAsqeEF7Js+Y/7TTrzET3Ersxu8O5zM531+rcV5bf26TMXDyOXlgugwi
        /U6+5NUJsxCAHzToc3eJF/Iv8KCvyc+X6XtFc7MI/xAz2Z5S7DrcBpQTpsrn/39mow6FG5lMUbRuQ
        rd3/AAngQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL6aP-0000Hx-GD; Thu, 17 Oct 2019 14:17:05 +0000
Date:   Thu, 17 Oct 2019 07:17:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH v2] iomap: iomap that extends beyond EOF should be marked
 dirty
Message-ID: <20191017141705.GA31558@infradead.org>
References: <20191016051101.12620-1-david@fromorbit.com>
 <20191016060604.GH16973@dread.disaster.area>
 <20191017122911.GC25548@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017122911.GC25548@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 08:29:11AM -0400, Theodore Y. Ts'o wrote:
> > +	/*
> > +	 * Writes that span EOF might trigger an IO size update on completion,
> > +	 * so consider them to be dirty for the purposes of O_DSYNC even if
> > +	 * there is no other metadata changes being made or are pending here.
> > +	 */
> >  	iomap->flags = 0;
> > -	if (ext4_inode_datasync_dirty(inode))
> > +	if (ext4_inode_datasync_dirty(inode) ||
> > +	    offset + length > i_size_read(inode))
> >  		iomap->flags |= IOMAP_F_DIRTY;
> > +
> >  	iomap->bdev = inode->i_sb->s_bdev;
> >  	iomap->dax_dev = sbi->s_daxdev;
> >  	iomap->offset = (u64)first_block << blkbits;
> 
> Ext4 is not currently using iomap for any kind of writing right now,
> so perhaps this should land via Matthew's patchset?

It does for DAX, which is one of the consumers of IOMAP_F_DIRTY.
