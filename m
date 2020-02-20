Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92907166154
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgBTPrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:47:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgBTPrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=asXjJUPyTxLf/fjaD73hG4T2BQQMjNwUve1mlt++5Bg=; b=I/Ab8+bwJavMuSdF6A7yoLoxpl
        I80eOjHHrc7YW4s1mRM3GXAWV63YYUGG6kYuZAbhKMD7o7inowQ7wkdtEhk0CShSQle+pUHSJSQ3R
        X5Ie4ceE4nw5O60QIoKVy+Nx7nLUPwXo7HXGU5sNQ/MNv7k7CTW5cYA2mGffcLjnMuopklxIrnEb5
        zXaF3Q4w6YT3XY3kUH+syaFGM+K+jajsEL8N7w0LjXwXSkPM4zCg+dqrmYKzt+1rJwJrKO5ulxHRb
        Yx2SJUtD5uEs/JDzQY6ckw9PLSkFVwKmtv7afz08IkWKilgFHxNduTmfFUEZJ2ZFaKnIsglqiJ94N
        iYbQPz8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4o3B-0005FU-UO; Thu, 20 Feb 2020 15:47:41 +0000
Date:   Thu, 20 Feb 2020 07:47:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200220154741.GB19577@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-22-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By putting the 'have we reached the end of the page' condition at the end
> of the loop instead of the beginning, we can remove the 'submit the last
> page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> didn't return 0, which would lead to an endless loop.

I'm obviously biassed a I wrote the original code, but I find the new
very much harder to understand (not that the previous one was easy, this
is tricky code..).
