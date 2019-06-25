Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A66352917
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfFYKKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:10:52 -0400
Received: from verein.lst.de ([213.95.11.211]:33426 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYKKw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:10:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D25E668B05; Tue, 25 Jun 2019 12:10:20 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:10:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190625101020.GI1462@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-12-hch@lst.de> <20190624234304.GD7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624234304.GD7777@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:43:04AM +1000, Dave Chinner wrote:
> I'm a little concerned this is going to limit what we can do
> with the XFS IO path because now we can't change this code without
> considering the direct impact on other filesystems. The QA burden of
> changing the XFS writeback code goes through the roof with this
> change (i.e. we can break multiple filesystems, not just XFS).

Going through the roof is a little exaggerated.  Yes, it will be more
testing overhead, but that is life in a world where we try to share
code rather than duplicating it, which is pretty much a general
kernel policy that has served us well.

> The writepage code is one of the areas that, historically speaking,
> has one of the highest rates of modification in XFS - we've
> substantially reworked this code from top to bottom 4 or 5 times in
> a bit over ten years, and each time it's been removing abstraction
> layers and getting the writeback code closer to the internal XFS
> extent mapping infrastructure.

I don't think we had all that much churn.  Yes, we've improved it a
lot, but much of that was in response to core changes, and pretty much
all of it benefits other users as well.  And the more users we have
for this infrastructure that more clout it has with core VM folks
when we have to push back odd design decisions.
