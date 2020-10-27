Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EBC29C550
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 19:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825001AbgJ0SHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 14:07:34 -0400
Received: from casper.infradead.org ([90.155.50.34]:51754 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1824994AbgJ0SHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=88Dr87KsDhPlnO+OAXcMZDiYkKLK/3YwzmT8BRmkZKw=; b=bPhHbruaPk7FCwXSekew99Cv4z
        B6G26yRjpRI23lcrhMVGnsP9ko17+wtF1vSIJo0Tm4l992heyJ8SB/BamKjY3aXHZmvqaC2grpVYi
        qkCWoFcgWO6Y6OG9JfaCn9h/xENyRt5WObLPK1Y2DmbfPxzgmldhhGLOYGJoiXwJ6IW4sVCvX+JE8
        Fo3h5tnsXAaSORpyqXqcgWGdoogT1A2lwIl6MkGEG3J/YQJQkm5imgK1VQeKOKPbpT9l2UW0oL/9X
        419d6oQ9o5QzellWZkBYqo//KBKmfMjMxssG6ISWZHYmRFEanTv2QIOxKG+ek9vYG4DozafGFnR+J
        BZ6xGk5Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXTNb-0000Cq-Ie; Tue, 27 Oct 2020 18:07:31 +0000
Date:   Tue, 27 Oct 2020 18:07:31 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: use page dirty state to seek data over
 unwritten extents
Message-ID: <20201027180731.GA32577@infradead.org>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-2-bfoster@redhat.com>
 <20201015094700.GB21420@infradead.org>
 <20201019165501.GA1232435@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019165501.GA1232435@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:55:01PM -0400, Brian Foster wrote:
> On Thu, Oct 15, 2020 at 10:47:00AM +0100, Christoph Hellwig wrote:
> > I don't think we can solve this properly.  Due to the racyness we can
> > always err one side.  The beauty of treating all the uptodate pages
> > as present data is that we err on the safe side, as applications
> > expect holes to never have data, while "data" could always be zeroed.
> > 
> 
> I don't think that's quite accurate. Nothing prevents a dirty page from
> being written back and reclaimed between acquiring the (unwritten)
> mapping and doing the pagecache scan, so it's possible to present valid
> data (written to the kernel prior to a seek) as a hole with the current
> code.

True.  I guess we need to go back and do another lookup to fully
solve this problem.  That doesn't change my opinion that this patch
makes the problem worse.
