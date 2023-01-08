Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFEE66177A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjAHRco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 12:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjAHRcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:32:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AADD2DC;
        Sun,  8 Jan 2023 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R1tQhMLwN4df2mTt6NSEvjv94KFR0xXR92Y8zCvhpFM=; b=FssYgoKFZHidY6HJOtw1t5D7qT
        SSnDu0S20XK2dNzQNI8l0X5KMIHIcnVb6jVkqjkGYnzT0cIyCmrK3luFDFLF996tLChKZyvWZzVyT
        7EWr3fK5//ghnW+GmM535i3S/Sk42dJbL9ZV5e3Gh2SERN0Js3TZoMHdhX08INzVa+7zC85fBegvL
        FhuxML8FV3b7Fmk2yiXf3+DD92bNzk6atxHviRWCcPOmVOXP7lQgD1ylf4Ak+fpVXpsQ6dUHynlWr
        0btDgzUlioKghS95IKzKMLHe2XZt4tFc46mvD2oRehwuYwFMFeDxeemxNcTNYzz7wgz7Vc8Ywir8I
        3+ubsOfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEZXC-00EdRV-2f; Sun, 08 Jan 2023 17:32:38 +0000
Date:   Sun, 8 Jan 2023 09:32:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 7/9] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <Y7r+NkbfDqat9uHA@infradead.org>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-8-agruenba@redhat.com>
 <Y7W9Dfub1WeTvG8G@magnolia>
 <Y7XOoZNxZCpjCJLH@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7XOoZNxZCpjCJLH@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:08:17PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 04, 2023 at 09:53:17AM -0800, Darrick J. Wong wrote:
> > I wonder if this should be reworked a bit to reduce indenting:
> > 
> > 	if (PTR_ERR(folio) == -ESTALE) {
> 
> FYI this is a bad habit to be in.  The compiler can optimise
> 
> 	if (folio == ERR_PTR(-ESTALE))
> 
> better than it can optimise the other way around.

Yes.  I think doing the recording that Darrick suggested combined
with this style would be best:

	if (folio == ERR_PTR(-ESTALE)) {
		iter->iomap.flags |= IOMAP_F_STALE;
		return 0;
	}
	if (IS_ERR(folio))
		return PTR_ERR(folio);
