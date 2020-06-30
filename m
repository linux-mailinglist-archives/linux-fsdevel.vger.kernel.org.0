Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0196520EDD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 07:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgF3Fqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 01:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgF3Fqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:46:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1864AC061755;
        Mon, 29 Jun 2020 22:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F3FLndStJwjI+FmliDbcJxHMui6PgirEhNORg6B2/VE=; b=FqbRI9ssjR0VFI/R+7XX/nDnVc
        ZnkkzCjF0oAs+vM/vTjpKkTtULJ/R4EmHKS/3Q76sx6l6NaA08FYyQqydirMEzKfHXBsQcSW2xTla
        /FZoVIqfAGnQ4sAfmmAS1QFaPMNFTyYopjaxtEl7Sc10TEHvzSxBP4pAwQNepA0bIOZOrl87THSg9
        kJ9lE01ZMcPrjCL3s9v8EV0vsFelvzOLgqgq4fKAlhSvbxnRVv4jd7l+dGx/GWfCp/X7u0FFoJI4I
        9lyMl/QOTw9y/TwJPdnfdXdMEjWHQ8Vbqb1xU7m75/CDRzRHkhyIHj4zsgUlzIsjLQMk3Y7KWHdB9
        LCJrOHUg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq96I-0007aR-Jj; Tue, 30 Jun 2020 05:46:34 +0000
Date:   Tue, 30 Jun 2020 06:46:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200630054634.GA29011@infradead.org>
References: <20200629095118.1366261-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629095118.1366261-1-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:51:18AM +0200, Andreas Gruenbacher wrote:
> Make sure iomap_end is always called when iomap_begin succeeds.
> 
> Without this fix, iomap_end won't be called when a filesystem's
> iomap_begin operation returns an invalid mapping, bypassing any
> unlocking done in iomap_end.  With this fix, the unlocking will still
> happen.
> 
> This bug was found by Bob Peterson during code review.  It's unlikely
> that such iomap_begin bugs will survive to affect users, so backporting
> this fix seems unnecessary.
> 
> Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

