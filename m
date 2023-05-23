Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41A770E1C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbjEWQWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEWQWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 12:22:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4112B;
        Tue, 23 May 2023 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d661uJD3QZyNSbDvh1yODoH87KCKXO6AdQINLMKGe10=; b=PJwJqOx+NIMo9E4oIdJHNzHO4x
        /I3Fbeijrw9ytebTXP/VjCInxuGEyLhyF7xK8tuhjlfrJL+4miepn6rGuZNMr5lVWDLMP5nLFDN5U
        VmyWpb0tB51Wm0DRUm1Lw8tWZB8qqHaYAUGYCtJnq2/TMNBM6iuUiGBwsjrKPSeuh/a2hcal0qJXW
        DnEIJi9jkoA0SIeByrBKFfHDsAiHJqK+NGjeIWf0DXni53eZdO6V8ifabwFhdnzm9a/6VWSPaoo3V
        QLtDo5B4zTthXQWU4qSrbH9mzvYLHucS9j+5ROtP1vDIK6MooC5a/p+4oDUqZF3eqJi6wnkrKyMeo
        JASpUFUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Ulo-00Amb7-2r;
        Tue, 23 May 2023 16:21:56 +0000
Date:   Tue, 23 May 2023 09:21:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZGzoJLCRLk+pCKAk@infradead.org>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523133431.wwrkjtptu6vqqh5e@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 03:34:31PM +0200, Jan Kara wrote:
> I've checked the code and AFAICT it is all indeed handled. BTW, I've now
> remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
> ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
> way (by prefaulting pages from the iter before grabbing the problematic
> lock and then disabling page faults for the iomap_dio_rw() call). I guess
> we should somehow unify these schemes so that we don't have two mechanisms
> for avoiding exactly the same deadlock. Adding GFS2 guys to CC.
> 
> Also good that you've written a fstest for this, that is definitely a useful
> addition, although I suspect GFS2 guys added a test for this not so long
> ago when testing their stuff. Maybe they have a pointer handy?

generic/708 is the btrfs version of this.

But I think all of the file systems that have this deadlock are actually
fundamentally broken because they have a mess up locking hierarchy
where page faults take the same lock that is held over the the direct I/
operation.  And the right thing is to fix this.  I have work in progress
for btrfs, and something similar should apply to gfs2, with the added
complication that it probably means a revision to their network
protocol.

I'm absolutely not in favour to add workarounds for thes kind of locking
problems to the core kernel.  I already feel bad for allowing the
small workaround in iomap for btrfs, as just fixing the locking back
then would have avoid massive ratholing.
