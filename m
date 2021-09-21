Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0509741302F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 10:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhIUId4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 04:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhIUIdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:33:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE34C061574;
        Tue, 21 Sep 2021 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HdSp8YiX/oNpqESucnzRDG5Qf8BF22BX7HXermzl3P8=; b=QZOXY6Wn82vcs9UEnwFoQlK6hO
        fpQH0Jlym7rhsl5uX+aUHJTnNYfS+JIyZm9xlH1RYW046mLR37imI/sHo9vP/BSf48bOdwDX8zUA0
        leoIIFxmm0bIy5qOpsuwiZYdYvSNkv4KdCBz6OgtRIFBX+bLsy42OvADy8AzcSVtSlz5F6bB7Xhqt
        vVJUBXLQrUGn3LDt9J6AYE0DGqCr7y1Fe/sQOME9sOpgzRoWBJlquZQZ2i1H0ZUFyMQeeaX3tZQqG
        HbxcoMPuexjxyVLMyp6GFgtA+2C+BDpA9KPmvQqItmetWf5xeD0sZc0BmJ7E41U7L7NTJXo8mluZh
        /l9gShFQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSbBn-003dcA-Oi; Tue, 21 Sep 2021 08:31:51 +0000
Date:   Tue, 21 Sep 2021 09:31:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, jane.chu@oracle.com,
        linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <YUmYbxW70Ub2ytOc@infradead.org>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
 <20210921004431.GO1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921004431.GO1756565@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:44:31AM +1000, Dave Chinner wrote:
> I think this wants to be a behavioural modifier for existing
> operations rather than an operation unto itself. i.e. similar to how
> KEEP_SIZE modifies ALLOC behaviour but doesn't fundamentally alter
> the guarantees ALLOC provides userspace.
> 
> In this case, the change of behaviour over ZERO_RANGE is that we
> want physical zeros to be written instead of the filesystem
> optimising away the physical zeros by manipulating the layout
> of the file.

Yes.

> Then we have and API that looks like:
> 
> 	ALLOC		- allocate space efficiently
> 	ALLOC | INIT	- allocate space by writing zeros to it
> 	ZERO		- zero data and preallocate space efficiently
> 	ZERO | INIT	- zero range by writing zeros to it
> 
> Which seems to cater for all the cases I know of where physically
> writing zeros instead of allocating unwritten extents is the
> preferred behaviour of fallocate()....

Agreed.  I'm not sure INIT is really the right name, but I can't come
up with a better idea offhand.
