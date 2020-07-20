Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DCC226F85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 22:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgGTUOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 16:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgGTUOG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:14:06 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680AD2080D;
        Mon, 20 Jul 2020 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595276045;
        bh=wDxijBprww99JyKZ7zq1b0Bm+gBJfpxa+gZiTN2MMac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPMtmi5EfngGRLVXC4qUYRQ1gdrrDIyuG8biGtRFAryZ0R9CC8s/0ZXIdD+Ovfbla
         JnQVA+559vhRMT7XehRKOYcnDREV63fo/E7ZW17Y80AOMn3OmELWauhiaC/+dIA1E8
         5l8h0NDI2Cq1StzoLJGfBfBTNTRRaqlHa6Pc2oyE=
Date:   Mon, 20 Jul 2020 13:14:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 1/7] fscrypt: Add functions for direct I/O support
Message-ID: <20200720201404.GJ1292162@gmail.com>
References: <20200717014540.71515-1-satyat@google.com>
 <20200717014540.71515-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717014540.71515-2-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:45:34AM +0000, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Introduce fscrypt_dio_supported() to check whether a direct I/O request
> is unsupported due to encryption constraints, and
> fscrypt_limit_io_pages() to check how many pages may be added to a bio
> being prepared for direct I/O.
> 
> The IV_INO_LBLK_32 fscrypt policy introduced the possibility that DUNs
> in logically continuous file blocks might wrap from 0xffffffff to 0.
> Since this was particularly difficult to handle when block_size !=
> PAGE_SIZE, fscrypt only supports blk-crypto en/decryption with
> the IV_INO_LBLK_32 policy when block_size == PAGE_SIZE, and ensures that
> the DUN never wraps around within any submitted bio.
> fscrypt_limit_io_pages() can be used to determine the number of logically
> contiguous blocks/pages that may be added to the bio without causing the
> DUN to wrap around within the bio. This is an alternative to calling
> fscrypt_mergeable_bio() on each page in a range of logically contiguous
> pages.

This is a bit hard to read, especially the second paragraph.  How about:


"Introduce fscrypt_dio_supported() to check whether a direct I/O request
is unsupported due to encryption constraints.

Also introduce fscrypt_limit_io_pages() to limit how many pages can be
added to a bio being prepared for direct I/O.  This is needed for the
iomap direct I/O implementation to avoid DUN wraparound in the middle of
a bio (which is possible with the IV_INO_LBLK_32 IV generation method).
Elsewhere fscrypt_mergeable_bio() is used for this, but iomap operates
on logical ranges directly and thus needs doesn't have a chance to call
fscrypt_mergeable_bio() on every block or page.  So we need a function
which limits a logical range in one go."


In particular, the detail about PAGE_SIZE better belongs in the code, I think.

> +/**
> + * fscrypt_limit_io_pages() - limit I/O pages to avoid discontiguous DUNs
> + * @inode: the file on which I/O is being done
> + * @pos: the file position (in bytes) at which the I/O is being done
> + * @nr_pages: the number of pages we want to submit starting at @pos
> + *
> + * Determine the limit to the number of pages that can be submitted in the bio
> + * targeting @pos without causing a data unit number (DUN) discontinuity.
> + *
> + * For IV generation methods that can't cause DUN wraparounds
> + * within logically continuous data blocks, the maximum number of pages is
> + * simply @nr_pages. For those IV generation methods that *might* cause DUN
> + * wraparounds, the returned number of pages is the largest possible number of
> + * pages (less than @nr_pages) that can be added to the bio without causing a
> + * DUN wraparound within the bio.

How about replacing the second paragraph here with:
 
 * This is normally just @nr_pages, as normally the DUNs just increment along
 * with the logical blocks.  (Or the file is not encrypted.)
 *
 * In rare cases, fscrypt can be using an IV generation method that allows the
 * DUN to wrap around within logically continuous blocks, and that wraparound
 * will occur.  If this happens, a value less than @nr_pages will be returned so
 * that the wraparound doesn't occur in the middle of the bio.  Note that we
 * only support block_size == PAGE_SIZE (and page-aligned DIO) in such cases.
