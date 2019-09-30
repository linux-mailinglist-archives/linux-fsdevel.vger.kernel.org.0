Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D4FC273C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfI3Utx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 16:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbfI3Utx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:49:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 979BF3084244;
        Mon, 30 Sep 2019 20:49:52 +0000 (UTC)
Received: from max.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACAF45C224;
        Mon, 30 Sep 2019 20:49:48 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH 15/15] gfs2: use iomap for buffered I/O in ordered and writeback mode
Date:   Mon, 30 Sep 2019 22:49:45 +0200
Message-Id: <20190930204945.30780-1-agruenba@redhat.com>
In-Reply-To: <20190806053031.GD13409@lst.de>
References: <20190701215439.19162-1-hch@lst.de> <20190701215439.19162-16-hch@lst.de> <CAHc6FU4wtDwLv_TU6xydtO2h8P8jE1ddPjVqs8=NDFFDNEpiLA@mail.gmail.com> <20190806053031.GD13409@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 30 Sep 2019 20:49:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Tue, Aug 6, 2019 at 7:30 AM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Aug 05, 2019 at 02:27:21PM +0200, Andreas Gruenbacher wrote:
> > Christoph,
> >
> > thanks again for this patch and the rest of the patch queue. There's
> > one minor bug here (see below). With that and the gfs2_walk_metadata
> > fix I've just posted to cluster-devel, this is now all working nicely.
>
> Skipping through the full quote this was a missing set_page_dirty,
> right?  Looks fine to me and sorry for messing this up.

here are the changes we currently need on top of what you've posted on
July 1.  On top of the page dirtying which you patch accidentally
dropped in gfs2_unstuffer_page, there are two places in which we also
need to call iomap_page_create to attach an iomap_page structure to the
pages.

The first place is in gfs2_unstuffer_page, which converts an inline
(stuffed) file into a regular file.  This is implemented in a filesystem
specific way, and I don't think there is any point in trying to make
this more generic.

The second place is in gfs2_page_mkwrite.  This function should
eventually be changed to call iomap_page_mkwrite instead, but we can
just fix it as below just to get this working.

Currently, iomap_page_create is a static function in
fs/iomap/buffered-io.c, so we need to export it before these changes
will work.

I'm still trying to track down consistency problems with a 1k blocksize
in xfstests generic/263 and generic/300, and that is with the mmap
locking issue fixed that Dave Chinner has pointed out [*].  This problem
existed even before your changes, so your changes seem to be working
correctly.

Thanks again,
Andreas

[*] https://lore.kernel.org/linux-fsdevel/20190906205241.2292-1-agruenba@redhat.com/

---
 fs/gfs2/bmap.c | 2 ++
 fs/gfs2/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index bf5c494d25ef..48b458c49fa1 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -93,6 +93,8 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
 		set_buffer_uptodate(bh);
 		gfs2_trans_add_data(ip->i_gl, bh);
 	} else {
+		iomap_page_create(inode, page);
+		set_page_dirty(page);
 		gfs2_ordered_add_inode(ip);
 	}
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 997b326247e2..30fd180e199d 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -516,6 +516,8 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	if (ret == 0) {
+		if (!gfs2_is_jdata(ip))
+			iomap_page_create(inode, page);
 		set_page_dirty(page);
 		wait_for_stable_page(page);
 	}
-- 
2.20.1

