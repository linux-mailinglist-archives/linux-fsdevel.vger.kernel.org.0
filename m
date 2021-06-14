Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93563A6AB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhFNPpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhFNPpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:45:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E8C061574;
        Mon, 14 Jun 2021 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k+GlvjVi0BRrHEyiA/n5n3EFf4shy2W6VnVssDLXioA=; b=s6ODF9OtR3BlZ9XVnzGicasAeY
        jlfVoPRVG14lRRMJYIoCdqvGejj20VXBRmKTPwEPzxS4L4lLLzJJfPpHIS69xpFRtsXdnFZvcUmmf
        VIJHAi4f8Hj7w0SuXn1gGvkVRR6xhFjuvsDcWD9rCyGSjaK/KQg5HEAV6KlA+eAZQZQDeoA/7+fWC
        VB0I/BoJI1/kpsMFd25OBHVJ5DnorcIYTBZ9LfkHgPretBNDi1v4YLVLU2aFnn7BCyDM5iKNzP0P2
        kl4bcdjc/BG7rhdGOb33aNMn14/BFV0hwb+MjSEolasxnORciQAD8kzEE2tlW1Zd/z8bpaLY0/iqM
        57ayFTqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsoju-005Zja-3U; Mon, 14 Jun 2021 15:43:07 +0000
Date:   Mon, 14 Jun 2021 16:43:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
Message-ID: <YMd5BqIKucO6rW4R@casper.infradead.org>
References: <YMdpxbYafHnE0F8N@casper.infradead.org>
 <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
 <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
 <475131.1623685101@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475131.1623685101@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 04:38:21PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > -	ASSERT(PageUptodate(page));
> > > -
> > >  	if (PagePrivate(page)) {
> > >  		priv = page_private(page);
> > >  		f = afs_page_dirty_from(page, priv);
> > 
> > Why are you removing this assertion?  Does AFS now support dirty,
> > partially-uptodate pages?  If so, a subsequent read() to that
> > page is going to need to be careful to only read the parts of the page
> > from the server that haven't been written ...
> 
> Because the previous hunk in the patch:
> 
> 	+	if (!PageUptodate(page)) {
> 	+		if (copied < len) {
> 	+			copied = 0;
> 	+			goto out;
> 	+		}
> 	+
> 	+		SetPageUptodate(page);
> 	+	}
> 
> means you can't get there unless PageUptodate() is true by that point.

Isn't the point of an assertion to check that this is true?
