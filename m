Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFB43C426
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 09:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbhJ0Hog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 03:44:36 -0400
Received: from verein.lst.de ([213.95.11.211]:36667 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240563AbhJ0Hof (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:44:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 093C068AFE; Wed, 27 Oct 2021 09:42:08 +0200 (CEST)
Date:   Wed, 27 Oct 2021 09:42:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm: simplify bdi refcounting
Message-ID: <20211027074207.GA12793@lst.de>
References: <20211021124441.668816-1-hch@lst.de> <20211021124441.668816-6-hch@lst.de> <20211022090203.GF1026@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022090203.GF1026@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:02:03AM +0200, Jan Kara wrote:
> On Thu 21-10-21 14:44:41, Christoph Hellwig wrote:
> > Move grabbing and releasing the bdi refcount out of the common
> > wb_init/wb_exit helpers into code that is only used for the non-default
> > memcg driven bdi_writeback structures.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Can we perhaps add a comment to struct bdi_writeback definition (or maybe
> wb_init()?) mentioning that it holds a reference to 'bdi' if it is
> bdi_writeback struct for a cgroup? I don't see it mentioned anywhere and
> now that you've changed the code, it isn't that obvious from the code
> either... Otherwise the patch looks good so feel free to add:

Like this?

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 33207004cfded..a3d7dd1cc30a1 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -103,6 +103,9 @@ struct wb_completion {
  * change as blkcg is disabled and enabled higher up in the hierarchy, a wb
  * is tested for blkcg after lookup and removed from index on mismatch so
  * that a new wb for the combination can be created.
+ *
+ * Each bdi_writeback that is no embedded into the backing_dev_info must hold
+ * a reference to the parent backing_dev_info.  See cgwb_create() for details.
  */
 struct bdi_writeback {
 	struct backing_dev_info *bdi;	/* our parent bdi */
