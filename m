Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8F163CB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 06:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgBSFfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 00:35:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgBSFfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 00:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i5jjRMxpChRQy+2J/xRxaZpOqmFrFWQR+xd6cg6u2PI=; b=DuVHuymBPWn5wDST1aeEelhfNM
        /bXL88FT9MFQnHGtbK4rSNZ+luoUIXATKSnNmq0w0g+oFVWjyKpy66W6FFgRGnswoBOWQpscJbJQP
        4VedcAPQbAlzmDR4kFU3J0Di3kgpR1We770va4VzU0v+3uU5Psu/vRRzwnfoiQqbwdrygPBoB0Acc
        Kj/viayLIFCgDZTYuGeW41k0nXnLmWVc48ZXm+FRjozkqV+sHubRee661ywX49PCOT/E1uqhfX2Ny
        D9csTE5YF0U7xa7/EP5Jtkli2RRKOHF+UMVo8N/d71C108g1DAP7O0iiHuaezDNJcoHL5lnGSyTJU
        QRfWManA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4I1Q-0004Jt-TF; Wed, 19 Feb 2020 05:35:44 +0000
Date:   Tue, 18 Feb 2020 21:35:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
Message-ID: <20200219053544.GN24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
 <d4803ef9-7a2f-965f-8f0f-c5e15396d892@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4803ef9-7a2f-965f-8f0f-c5e15396d892@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:17:18PM -0800, John Hubbard wrote:
> > -	for (done = 0; done < length; done += ret) {
> 
> nit: this "for" loop was perfect just the way it was. :) I'd vote here for reverting
> the change to a "while" loop. Because with this change, now the code has to 
> separately initialize "done", separately increment "done", and the beauty of a
> for loop is that the loop init and control is all clearly in one place. For things
> that follow that model (as in this case!), that's a Good Thing.
> 
> And I don't see any technical reason (even in the following patch) that requires 
> this change.

It's doing the increment in the wrong place.  We want the increment done in
the middle of the loop, before we check whether we've got to the end of
the page.  Not at the end of the loop.

> > +	BUG_ON(ctx.cur_page);
> 
> Is a full BUG_ON() definitely called for here? Seems like a WARN might suffice...

Dave made a similar comment; I'll pick this up there.
