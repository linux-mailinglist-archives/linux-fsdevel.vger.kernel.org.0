Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9535C21DFCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGMSgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 14:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgGMSgV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:36:21 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30864206F0;
        Mon, 13 Jul 2020 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594665381;
        bh=BLeUpT0iFaXku/efoG1DhWrwtysiF8mjsyAhDbJwYvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KM7PMsU9e+2DXZLJqUFe2XogR1FnNqbehLX3k0+pOhOi5vpA45U7N7wQoDAv2d3fd
         c3qXgNVc47g0YliQJzKPx38hA8WIeHdc4f4jYHsyQnBOYMVLu/KOwJbE/pqKejSJYH
         8azn8SCxy5mt3B+hvpZpiei6Tl7lLZ+R9SfKbQpA=
Date:   Mon, 13 Jul 2020 11:36:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/5] direct-io: add support for fscrypt using blk-crypto
Message-ID: <20200713183619.GC722906@gmail.com>
References: <20200709194751.2579207-1-satyat@google.com>
 <20200709194751.2579207-3-satyat@google.com>
 <20200710053406.GA25530@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710053406.GA25530@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:34:06AM +0100, Christoph Hellwig wrote:
> On Thu, Jul 09, 2020 at 07:47:48PM +0000, Satya Tangirala wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Set bio crypt contexts on bios by calling into fscrypt when required,
> > and explicitly check for DUN continuity when adding pages to the bio.
> > (While DUN continuity is usually implied by logical block contiguity,
> > this is not the case when using certain fscrypt IV generation methods
> > like IV_INO_LBLK_32).
> 
> I know it is asking you for more work, but instead of adding more
> features to the legacy direct I/O code, could you just switch the user
> of it (I guess this is for f2f2?) to the iomap one?

Eventually we should do that, as well as convert f2fs's fiemap, bmap, and llseek
to use iomap.  However there's a nontrivial barrier to entry, at least for
someone who isn't an expert in iomap, especially since f2fs currently doesn't
use iomap at all and thus doesn't have an iomap_ops implementation.  And using
ext4 as an example, there will be some subtle cases that need to be handled.

Satya says he's looking into it; we'll see what he can come up with and what the
f2fs developers say.

If it turns out to be difficult and people think this patchset is otherwise
ready, we probably shouldn't hold it up on that.  This is a very small patch,
and Satya and I have to maintain it for years in downstream kernels anyway, so
it will be used and tested regardless.  It would also be nice to allow userspace
(e.g. xfstests) to assume that if the inlinecrypt mount option is supported,
then direct I/O is supported too, without having to handle intermediate kernel
releases where inlinecrypt was supported but not direct I/O.

- Eric
