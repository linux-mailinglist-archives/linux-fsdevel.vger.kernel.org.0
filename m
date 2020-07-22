Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2022A2DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 01:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbgGVXNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 19:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVXNB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:13:01 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEF92071A;
        Wed, 22 Jul 2020 23:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595459580;
        bh=HEvt8lyCEN3ZmLCF1F3YI7aqWFAeXTGaHSadk319KrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOcLVkNzY1Ih1PYGRteI/48NgDjzPpJqhAiy3Bm1rKFbQ0/Ap0D+Keuc67pI0xPfH
         WtJquG4oOQM+/LW67fiuUTw1FSgP5jMtxtE4E30+47Xas9p2xkDjq/33ONaWvi6f+a
         qjZUV7jHG81quN/uhS1slSRH/l6c+hJF2U2ijJTg=
Date:   Wed, 22 Jul 2020 16:12:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Satya Tangirala <satyat@google.com>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200722231258.GA83434@sol.localdomain>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
 <20200722224407.GR15516@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722224407.GR15516@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:44:07PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 22, 2020 at 03:34:04PM -0700, Eric Biggers wrote:
> > > Which means you are now placing a new constraint on this code in
> > > that we cannot ever, in future, zero entire blocks here.
> > > 
> > > This code can issue arbitrary sized zeroing bios - multiple entire fs blocks
> > > blocks if necessary - so I think constraining it to only support
> > > partial block zeroing by adding a warning like this is no correct.
> > 
> > In v3 and earlier this instead had the code to set an encryption context:
> > 
> > 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> > 				  GFP_KERNEL);
> > 
> > Would you prefer that, even though the call to fscrypt_set_bio_crypt_ctx() would
> > always be a no-op currently (since for now, iomap_dio_zero() will never be
> > called with an encrypted file) and thus wouldn't be properly tested?
> > 
> > BTW, iomap_dio_zero() is actually limited to one page, so it's not quite
> > "arbitrary sizes".
> 
> I have a patch for that
> 
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/1a4d72a890ca9c2ea3d244a6153511ae674ce1d8

No you don't :-)  Your patch is for iomap_zero_range() in
fs/iomap/buffered-io.c.  It doesn't touch fs/iomap/direct-io.c which is what
we're talking about here.

> It's not going to cause a problem for crossing a 2^32 boundary because
> pages are naturally aligned and don't get that big.

Well, the boundary can actually occur at any block.  But it's not relevant here
because (a) fs/iomap/buffered-io.c doesn't yet support encryption anyway, since
neither ext4 nor f2fs use it; and (b) iomap_zero_range() just writes to the
pagecache, and the bios aren't actually issued until ->writepages().

- Eric
