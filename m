Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDE72F36B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 18:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406058AbhALRLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 12:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406000AbhALRLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:11:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD3C061786;
        Tue, 12 Jan 2021 09:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z5sovJ1D8yiiPMIt5GhFymgVyYeX6GsIc/qWYNKOx2s=; b=XL6FVDzLgqfICkrWI7V4LpWIkO
        ShzAIqAqaHhTo/ifER5Mxh/BaXXGs092mEgJccHGi64qWZPBr2a31koUYxiO79Et0sjfSCCJWIZdy
        jNoJaT/+Gd45/TNtU8oOJQMWdcT9vk0HKEr2qk33777E28b5Llp30McOUMDT1DBMygzzX9CA8GZ3o
        kDGBFavGSS4hsVvwh8eQ+9oYOhgLkqRQlN3qNBPAAECJz7u2DVz8dxF5f7OKL9nDy9CkEi/rmq6sv
        xRdgd3Tc8DeGQBIzOgLRnz4wJmniBpvTCDjCcXAhjTmU6r0M9DZfiyOOBhHFtNAI+VLPuwfi/v+Wq
        IdXkf+eQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzNBQ-0055E8-Dh; Tue, 12 Jan 2021 17:10:20 +0000
Date:   Tue, 12 Jan 2021 17:10:16 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: Re: [PATCH 6/6] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210112171016.GA1210850@infradead.org>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <20210112010746.1154363-7-david@fromorbit.com>
 <X/19MZHQtcnj9NDc@infradead.org>
 <20210112170133.GD1137163@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112170133.GD1137163@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:01:33PM -0500, Brian Foster wrote:
> > I think this is in many ways wrong.  As far as I can tell you want this
> > so that we get the imap_spans_range in xfs_direct_write_iomap_begin. But
> > we should not trigger any of the other checks, so we'd really need
> > another flag instead of reusing this one.
> > 
> 
> It's really the br_state != XFS_EXT_NORM check that we want for the
> unaligned case, isn't it?

Inherently, yes.  But if we want to avoid the extra irec lookup outside
->iomap_begin we have to limit us to a single I/O, as we'll do a partial
write otherwise if only the extent that the end of write falls into is
unwritten and not block aligned.
