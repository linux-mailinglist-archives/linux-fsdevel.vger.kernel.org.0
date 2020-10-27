Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF729C6EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 19:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827629AbgJ0SZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 14:25:58 -0400
Received: from verein.lst.de ([213.95.11.211]:42109 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1827646AbgJ0SZw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:25:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A284C68D03; Tue, 27 Oct 2020 19:25:47 +0100 (CET)
Date:   Tue, 27 Oct 2020 19:25:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Removing b_end_io
Message-ID: <20201027182546.GA3269@lst.de>
References: <20201025044438.GI20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025044438.GI20115@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 25, 2020 at 04:44:38AM +0000, Matthew Wilcox wrote:
> 
> On my laptop, I have about 31MB allocated to buffer_heads.
> 
> buffer_head       182728 299910    104   39    1 : tunables    0    0    0 : slabdata   7690   7690      0
> 
> Reducing the size of the buffer_head by 8 bytes gets us to 96 bytes,
> which means we get 42 per page instead of 39 and saves me 2MB of memory.
> 
> I think b_end_io() is ripe for removal.  It's only used while the I/O
> is in progress, and it's always set to end_bio_bh_io_sync() which
> may set the quiet bit, calls ->b_end_io and calls bio_put().
> 
> So how about this as an approach?  Only another 40 or so call-sites
> to take care of to eliminate b_end_io from the buffer_head.  Yes, this
> particular example should be entirely rewritten to do away with buffer
> heads, but that's been true since 2006.  I'm looking for an approach
> which can be implemented quickly since the buffer_head does not appear
> to be going away any time soon.

I think this looks pretty reasonable.
