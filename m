Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9481B2D06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgDUQqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728165AbgDUQqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:46:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505D2C061A41;
        Tue, 21 Apr 2020 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6VSSPJCcevYsGUKgN4kM18lxCeXB2g2KawPNFpxhfTw=; b=SKTLs75QLUp1ncUNRj/fn4XbLB
        AYZZtGG0i8SAqhc8Lz5wcbe10h1cWVUvxxaAtCBMRWO+HhiVMYLsxXuT6oxbVtL2DlTJtvQ8NhiHp
        yBsXJ8tZcPuzsogjkFQripCy2rDJEXY3AuGv2T1Ir+EuHYS65ppKC8WmBShkCkzhElAUNf2DXKGJo
        +xp22i3wieCJvZl6bJNkfRHjQOYtXPHq9/6nIUwtJI/h4EeuOsIJpVXggI6qvQhQ0AeHnzt/n7Dhu
        RPIS9/C8fi8K0C+4cK5+q9JTXNw8q+MoKMexFuQrsAJLFspDHP0IG1VKiZAwSsDdmBZzwp3DUawN3
        Lpm5lS3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQw1y-0003am-Pt; Tue, 21 Apr 2020 16:45:54 +0000
Date:   Tue, 21 Apr 2020 09:45:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        bugzilla-daemon@bugzilla.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then
 16TB
Message-ID: <20200421164554.GA3271@infradead.org>
References: <bug-207367-13602@https.bugzilla.kernel.org/>
 <bug-207367-13602-zdl9QZH6DN@https.bugzilla.kernel.org/>
 <20200421042039.BF8074C046@d06av22.portsmouth.uk.ibm.com>
 <20200421050850.GB27860@dread.disaster.area>
 <20200421080405.GA4149@infradead.org>
 <20200421162910.GB5118@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421162910.GB5118@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 06:29:10PM +0200, Jan Kara wrote:
> Well, there are two problems with this - firstly, ocfs2 is also using jbd2
> and it knows nothing about iomap. So that would have to be implemented.
> Secondly, you have to somehow pass iomap ops to jbd2 so it all boils down
> to passing some callback to jbd2 during journal init to map blocks anyway
> as Dave said. And then it is upto filesystem to do the mapping - usually
> directly using its internal block mapping function - so no need for iomap
> AFAICT.

You'll need to describe the mapping some how.  So why not reuse an
existing mechanism instead of creating a new ad-hoc one?
