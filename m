Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83F8203EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgFVSN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbgFVSNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:13:55 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDCBC061573;
        Mon, 22 Jun 2020 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fI19LO2+kVeZbFNCAbzHEO3fT5rq3PpBrNGKrOZ0eJU=; b=PvTVCLag7uWuChnh7GXE/F0LfY
        Z/qG7GMHeiyvLMalJYaNPM5H2wV64nnXWJljQVKbr9MJd1/CfpoXXs1pzSqcd2koLO0AAu4lc38jV
        2vb4u2ltkwZCnZV0mo/zpJIXHkOiH9lv8VJqmLUYXzmc9mqqnFBsMl3hKjlbMoBu05CgjLICfXV+n
        XtKHRShvzjEvXDeII2yVQZFu7b+bME8CV22ThUZ41gnaU8SS0V021NrtK06IvWm0A3I8y5tDHJecr
        36TCrnJk4k1fhtbYGWX3HZ74cAgYu5cfIYBrmXJzKH9V+ciyL6+kO1mXQ5AFT0VJggUlyg6z4SaGs
        QNmQdp6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnQws-0005kx-1f; Mon, 22 Jun 2020 18:13:38 +0000
Date:   Mon, 22 Jun 2020 19:13:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200622181338.GA21350@casper.infradead.org>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <20200622003215.GC2040@dread.disaster.area>
 <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:35:05PM +0200, Andreas Gruenbacher wrote:
> I'm fine with not moving that functionality into the VFS. The problem
> I have in gfs2 is that taking glocks is really expensive. Part of that
> overhead is accidental, but we definitely won't be able to fix it in
> the short term. So something like the IOCB_CACHED flag that prevents
> generic_file_read_iter from issuing readahead I/O would save the day
> for us. Does that idea stand a chance?

For the short-term fix, is switching to a trylock in gfs2_readahead()
acceptable?

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 72c9560f4467..6ccd478c81ff 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -600,7 +600,7 @@ static void gfs2_readahead(struct readahead_control *rac)
        struct gfs2_inode *ip = GFS2_I(inode);
        struct gfs2_holder gh;
 
-       gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+       gfs2_holder_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_TRY, &gh);
        if (gfs2_glock_nq(&gh))
                goto out_uninit;
        if (!gfs2_is_stuffed(ip))

