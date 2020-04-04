Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60719E6CF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgDDRnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 13:43:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgDDRnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AP40KpIqZCsdomgwe4trkVU5kvHN6xKBJSNZQoGj8AE=; b=TmGjz+7r6n1CR1VZNtjadT4GDT
        OHmH1fq6kpLID1Oga1dcep3mKYELxYgNd+jhZlo5aH2nB25prlXuDcxCRA/5Cau2ukG9zbx8kh98b
        BM811VI7n7/zQS7ACNPwow4ZBr0/qHVCVunR8V9f9U+erwyJZdQuzLhFevFowDyi/x8uwV9cGa6tv
        9l8tp0q2ArYCjoSWvWYuC6NcshuDHeE6RPdtxtLRxB92cSVLDK0W7dM5+QZ+n1DZf2YOcZhuQrCNT
        Xc6lLr8Xm8ETuvtZoOiTsxuhs1OpPxcxCZyIJKLwGkNE2SsQADy6KeotMTu4biuBDnaKwu2dM6h+N
        oafzssDg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKmpe-0003ZR-HB; Sat, 04 Apr 2020 17:43:46 +0000
Date:   Sat, 4 Apr 2020 10:43:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     hubcap@kernel.org
Cc:     hch@lst.de, Mike Marshall <hubcap@omnibond.com>,
        devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] orangefs: complete Christoph's "remember count"
 reversion.
Message-ID: <20200404174346.GU21484@bombadil.infradead.org>
References: <20200326170705.1552562-2-hch@lst.de>
 <20200404162826.181808-1-hubcap@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404162826.181808-1-hubcap@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 04, 2020 at 12:28:26PM -0400, hubcap@kernel.org wrote:
> As an aside, the page cache has been a blessing and a curse
> for us. Since we started using it, small IO has improved
> incredibly, but our max speed hits a plateau before it otherwise
> would have. I think because of all the page size copies we have
> to do to fill our 4 meg native buffers. I try to read about all
> the new work going into the page cache in lwn, and make some
> sense of the new code :-). One thing I remember is when
> Christoph Lameter said "the page cache does not scale", but
> I know the new work is focused on that. If anyone has any
> thoughts about how we could make improvments on filling our
> native buffers from the page cache (larger page sizes?),
> feel free to offer any help...

Umm, 4MB native buffers are ... really big ;-)  I wasn't planning on
going past PMD_SIZE (ie 2MB on x86) for the readahead large pages,
but if a filesystem wants that, then I should change that plan.

What I was planning for, but don't quite have an implementation nailed
down for yet, is allowing filesystems to grow the readahead beyond that
wanted by the generic code.  Filesystems which implement compression
frequently want blocks in the 256kB size range.  It seems like OrangeFS
would fit with that scheme, as long as I don't put a limit on what the
filesystem asks for.

So yes, I think within the next year, you should be able to tell the
page cache to allocate 4MB pages.  You will still need a fallback path
for when memory is too fragmented to allocate new pages, but if you're
using 4MB pages, then hopefully we'll be able to reclaim a clean 4MB
pages from elsewhere in the page cache and supply you with a new one.
