Return-Path: <linux-fsdevel+bounces-51578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5C7AD87AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 11:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79F13B6E94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F94291C05;
	Fri, 13 Jun 2025 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKIhIjYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DC19049B;
	Fri, 13 Jun 2025 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806630; cv=none; b=XojemXJxTAdNhesUKu0uRsIsBhpNAvJhKzkSLMuzOjg/RpqDqCzzukyj3XtiRbtFW9iWgblLXwKssIqCA4h+4mWltT3xOLlxiKmSRxHt2EnP5m5RGM2xrp6fN2221mLQKH1DcpCLgv0WQzwRcKfzhRXIkjSX9jkdTxKE1o38/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806630; c=relaxed/simple;
	bh=4IM3ljHai7hhYuxZjlxbC1b3dgfoRlGohNkgBHQPTJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAZ88+o7fQOg5QzfkEhYa+nJJxrOR/s1hS6Irfge2U8P/L5aqNf0tBiCsuBLq01JVlrrYq2DnvG+1avg5Vsw5bJpj0KehHBBKXzsfO2F0KGHH6Ue8tscqkhjVBNVaD0NbuqbNfDxyUxGfXrQoeZaAN6ED+N5v7IbT4bC2Y0pReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKIhIjYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785FDC4CEE3;
	Fri, 13 Jun 2025 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749806629;
	bh=4IM3ljHai7hhYuxZjlxbC1b3dgfoRlGohNkgBHQPTJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKIhIjYsG6tslEAhzjn+gh02xfPhV8Zwt6HLme2cE5exQJLo3AgVlx6mJqNO2fp9/
	 z3pwGrg2wkuIpaCxr9iOeujM+XeqO2AK0at5VdGgHzv1VIpHikz6BOMIpvRk0KNsuM
	 eeOKcP7t9YgRl0/iJlG56MNRg/boGldhY9CsuaYo6aj9r6dxRFJWTyEWjL+l8ub6fO
	 HFJwkVCevU1bU7benFDmVvf1G0NgcFf96mtVjqWa6/f4gOcPz/O6VpRZYHcX4JPcur
	 CAe7W6OdHJBHX3nMT8+005SLu5nLexzn0djUosZfghj9XuGKokz0m/JWZZR7g/th/+
	 Qd7ICSXEHJlzg==
Date: Fri, 13 Jun 2025 05:23:48 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, david.flynn@hammerspace.com
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aEvuJP7_xhVk5R4S@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
 <aEu7GSa7HRNNVJVA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEu7GSa7HRNNVJVA@infradead.org>

On Thu, Jun 12, 2025 at 10:46:01PM -0700, Christoph Hellwig wrote:
> On Thu, Jun 12, 2025 at 12:22:42PM -0400, Jeff Layton wrote:
> > If you're against the idea, I won't waste my time.
> > 
> > It would require some fairly hefty rejiggering of the receive code. The
> > v4 part would be pretty nightmarish to work out too since you'd have to
> > decode the compound as you receive to tell where the next op starts.
> > 
> > The potential for corruption with unaligned writes is also pretty
> > nasty.
> 
> Maybe I'm missing an improvement to the receive buffer handling in modern
> network hardware, but AFAIK this still would only help you to align the
> sunrpc data buffer to page boundaries, but avoid the data copy from the
> hardware receive buffer to the sunrpc data buffer as you still don't have
> hardware header splitting.

Correct, everything that Jeff detailed is about ensuring the WRITE
payload is received into page aligned boundary.

Which in practice has proven a hard requirement for O_DIRECT in my
testing -- but I could be hitting some bizarre driver bug in my TCP
testbed (which sadly sits ontop of older VMware guests/drivers).

But if you looking at patch 5 in this series:
https://lore.kernel.org/linux-nfs/20250610205737.63343-6-snitzer@kernel.org/

I added fs/nfsd/vfs.c:is_dio_aligned(), which is basically a tweaked
ditto of fs/btrfs/direct-io.c:check_direct_IO():

static bool is_dio_aligned(const struct iov_iter *iter, loff_t offset,
                           const u32 blocksize)
{
        u32 blocksize_mask;

        if (!blocksize)
                return false;

        blocksize_mask = blocksize - 1;
        if ((offset & blocksize_mask) ||
            (iov_iter_alignment(iter) & blocksize_mask))
                return false;

        return true;
}

And fs/nfsd/vfs.c:nfsd_vfs_write() has (after my patch 5):

        nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
        iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);

        if (nfsd_enable_dontcache) {
                if (is_dio_aligned(&iter, offset, nf->nf_dio_offset_align))
                        flags |= RWF_DIRECT;

What I found is that unless SUNRPC TPC stored the WRITE payload in a
page-aligned boundary then iov_iter_alignment() would fail.

The @payload arg above, with my SUNRPC TCP testing, was always offset
148 bytes into the first page of the pages allocated for xdr_buf's
use, which is rqstp->rq_pages, which is allocated by
net/sunrpc/svc_xprt.c:svc_alloc_arg().

> And I don't even know what this is supposed to buy the nfs server.
> Direct I/O writes need to have the proper file offset alignment, but as
> far as Linux is concerned we don't require any memory alignment.  Most
> storage hardware has requirements for the memory alignment that we pass
> on, but typically that's just a dword (4-byte) alignment, which matches
> the alignment sunrpc wants for most XDR data structures anyway.  So what
> additional alignment is actually needed for support direct I/O writes
> assuming that is the goal?  (I might also simply misunderstand the
> problem).

THIS... this is the very precise question/detail I discussed with
Hammerspace's CEO David Flynn when discussing Linux's O_DIRECT
support.  David shares your understanding and confusion.  And all I
could tell him is that in practice I always page-aligned my data
buffers used to issue O_DIRECT.  And that in this instance if I don't
then O_DIRECT doesn't work (if I commented out the iov_iter_alignment
check in is_dio_aligned above).

But is that simply due to xdr_buf_to_bvec()'s use of bvec_set_virt()
for xdr_buf "head" page (first page of rqstp->rg_pages)?  Whereas you
can see xdr_buf_to_bvec() uses bvec_set_page() to add each of the
other pages that immediately follow the first "head" page.

All said, if Linux can/should happily allow non-page-aligned DIO (and
we only need to worry about the on-disk DIO alignment requirements)
that'd be wonderful.

Then its just a matter of finding where that is broken...

Happy to dig into this further if you might nudge me in the right
direction.

Thanks,
Mike

