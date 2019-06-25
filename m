Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08C5533F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfFYPVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 11:21:53 -0400
Received: from verein.lst.de ([213.95.11.211]:35780 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfFYPVx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:21:53 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BABDB68B05; Tue, 25 Jun 2019 17:21:20 +0200 (CEST)
Date:   Tue, 25 Jun 2019 17:21:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] xfs: initialize ioma->flags in xfs_bmbt_to_iomap
Message-ID: <20190625152120.GA8153@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-5-hch@lst.de> <20190624145707.GH5387@magnolia> <20190625100701.GG1462@lst.de> <20190625151357.GA2230847@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625151357.GA2230847@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 08:13:57AM -0700, Darrick J. Wong wrote:
> > This doesn't affect any existing user as they all get a zeroed iomap
> > passed from the caller in iomap.c.  It affects the writeback code
> > once it uses struct iomap as it overwrites a previously used iomap.
> 
> Then shouldn't this new writeback code zero the iomap before calling
> back into the filesystem, just to maintain consistent behavior?

The core code doesn't decide when to overwrite it, that ->map_blocks
method does that based on a few factors (including the data_seq/cow_seq
counters that are entirely inside xfs).
