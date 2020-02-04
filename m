Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB08D151F12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 18:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBDRQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 12:16:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBDRQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3NMwJ5AxeA2DxLtwDwGHd3oNGbv+NT9nGn8qTgTw24Y=; b=KvUEDJeoNCmLGpgVORZ1wzUvhJ
        wIAGhqJxfoOzPQ81fRuNGE10yA3XKfb/XFoGImLuak/cMOfZTUmObg0Isl2d2H0xUOSKupB0K5WcM
        sKxT2uMCKsc4W81B/oIY7Nq/C5eF5mKX/mpXbcr6o6ZfTyX9aekNmNh3gtOEhVHyRyRFOjLmBOoAV
        w/5nCLaExb6rBxUuDMer/dCqVGMYPxFJFfEgIYZLwmM129d6OhQkvQzzrkTlvB2JCwmIwlAncUOBt
        f+hfqZM2PPSztiwr4r/vdc/oOP6H8o9d+EufWbh/gPVAF/VnEbBn1Z6Mr84omAyvjNDVJTZNQSeyL
        y2yx+ifA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iz1oN-0000iE-LX; Tue, 04 Feb 2020 17:16:31 +0000
Date:   Tue, 4 Feb 2020 09:16:31 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v4 00/12] Change readahead API
Message-ID: <20200204171631.GM8731@bombadil.infradead.org>
References: <20200201151240.24082-1-willy@infradead.org>
 <20200204153227.GF2654@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204153227.GF2654@twin.jikos.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 04:32:27PM +0100, David Sterba wrote:
> On Sat, Feb 01, 2020 at 07:12:28AM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > I would particularly value feedback on this from the gfs2 and ocfs2
> > maintainers.  They have non-trivial changes, and a review on patch 5
> > would be greatly appreciated.
> > 
> > This series adds a readahead address_space operation to eventually
> > replace the readpages operation.  The key difference is that
> > pages are added to the page cache as they are allocated (and
> > then looked up by the filesystem) instead of passing them on a
> > list to the readpages operation and having the filesystem add
> > them to the page cache.  It's a net reduction in code for each
> > implementation, more efficient than walking a list, and solves
> > the direct-write vs buffered-read problem reported by yu kuai at
> > https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/
> > 
> > v4:
> >  - Rebase on current Linus (a62aa6f7f50a ("Merge tag 'gfs2-for-5.6'"))
> 
> I've tried to test the patchset but haven't got very far, it crashes at boot
> ritht after VFS mounts the root. The patches are from mailinglist, applied on
> current master, bug I saw the same crash with the git branch in your
> repo (probably v1).

Yeah, I wasn't able to test at the time due to what turned out to be
the hpet bug in Linus' tree.  Now that's fixed, I've found & fixed a
couple more bugs.  There'll be a v5 once I fix the remaining problem
(looks like a missing page unlock somewhere).

