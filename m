Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758EE59393
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 07:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfF1Fmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 01:42:55 -0400
Received: from verein.lst.de ([213.95.11.210]:45086 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfF1Fmy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:42:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0A0EF68CEC; Fri, 28 Jun 2019 07:42:52 +0200 (CEST)
Date:   Fri, 28 Jun 2019 07:42:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: lift the xfs writepage code into iomap v2
Message-ID: <20190628054251.GC26902@lst.de>
References: <20190627104836.25446-1-hch@lst.de> <20190628013256.GE5179@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628013256.GE5179@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 06:32:56PM -0700, Darrick J. Wong wrote:
> I think Dave has voiced some valid concerns about our ability to support
> this code over the long term once we start sharing it with other fses.
> XFS has a longish history of sailing away from generic code so that we
> can remove awkward abstractions which aren't working well for us.  If
> we're going to continue to go our own way with things like file locking
> and mapping I wonder how long we'd keep using the iomap ioends before
> moving away again.  How well will that iomap code avoid bitrot once XFS
> does that?

As outlied in my mail to Dave I agree with the high level issue.
But I very much thing that the writeback code is and should be generic.
For one it is much more tightly integrated with other iomap code
than with XFS.  And second the kernel doesn't have a sane generic
writeback implementation.  We have like three different crappy buffer
head ones, and anyone wanting to sanely implement writeback currently
has to write their own, which is a major PITA.

> How does that sound?  Who are the other potential users?

The immediate current user is Damiens zonefs, which is just a thin
abstraction on top of zones in zoned block devices.  Then my plan has
always been to convert gfs2 over to it, away from buffer heads.  With
btrfs now joining iomap land I'd be really excited to move it over,
but we'll see how feasily that is.  But with gfs2 done I think we
also are ready to convert anything currently using plain old buffer
heads over, so things like sysvfs, minix, jfs, etc.  While that isn't
a priority and will take a while it will help with my grand overall
scheme of killing buffer_heads, at least for the data path.
