Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59122840B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgGUPmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:42:44 -0400
Received: from verein.lst.de ([213.95.11.211]:52767 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUPmn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:42:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D724F68AFE; Tue, 21 Jul 2020 17:42:40 +0200 (CEST)
Date:   Tue, 21 Jul 2020 17:42:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721154240.GB11652@lst.de>
References: <20200713074633.875946-1-hch@lst.de> <20200720215125.bfz7geaftocy4r5l@fiona> <20200721145313.GA9217@lst.de> <20200721150432.GH15516@casper.infradead.org> <20200721150615.GA10330@lst.de> <20200721151437.GI15516@casper.infradead.org> <20200721151616.GA11074@lst.de> <20200721153136.GJ15516@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721153136.GJ15516@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 04:31:36PM +0100, Matthew Wilcox wrote:
> > Umm, no.  -ENOTBLK is internal - the file systems will retry using
> > buffered I/O and the error shall never escape to userspace (or even the
> > VFS for that matter).
> 
> Ah, I made the mistake of believing the comments that I could see in
> your patch instead of reading the code.
> 
> Can I suggest deleting this comment:
> 
>         /*
>          * No fallback to buffered IO on errors for XFS, direct IO will either
>          * complete fully or fail.
>          */
> 
> and rewording this one:
> 
>                 /*
>                  * Allow a directio write to fall back to a buffered
>                  * write *only* in the case that we're doing a reflink
>                  * CoW.  In all other directio scenarios we do not
>                  * allow an operation to fall back to buffered mode.
>                  */
> 
> as part of your revised patchset?

That isn't actually true.  In current mainline we only fallback on
reflink RMW cases, but with this series we also fall back for
invalidation failures.
