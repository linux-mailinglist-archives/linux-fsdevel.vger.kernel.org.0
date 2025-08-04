Return-Path: <linux-fsdevel+bounces-56647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E4B1A454
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40C2174CD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E52727E7;
	Mon,  4 Aug 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygvauovz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09F1DED4A;
	Mon,  4 Aug 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317004; cv=none; b=Vqdtw3DAt9zYNaCS7mrm1UbpNLr0+mvpbHlh6KqV3DfI4fY/5YSjmRsH9m26NrPAayHapnNVCL20GFku+H7M869YZ6/Ly+21vMDXe/1Z6KEnSqDYjOKtBxe49yDTgv1qZIiN2KSVLLkhFqa8ILmi8buUm1mTfSsdkAndv3WAZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317004; c=relaxed/simple;
	bh=xZ4/OtTou0bjCOMvQJOdhc2IhhVGQdK8WBFg49SVbYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ/L4sweUVDVgkMXTxOZsCm64ZgKjkQGcKVgAD6kaZ/DJMYJgTJvnE8EeDH1kh8Mnyz9KMbLzFigl/cQvLCnA8LMrlUTjKUP4ZCjWr2+p8JeeX1PD2rulQON1iyN6oDKUShwtZ2COG0YcSan6Rq2D4IV6BgmNs8XoqXvMHavwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygvauovz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EE0C4CEF6;
	Mon,  4 Aug 2025 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754317002;
	bh=xZ4/OtTou0bjCOMvQJOdhc2IhhVGQdK8WBFg49SVbYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgvauovzR3vOKKvaFyT3pCHc7GSPQP3+yYpYdpyLxL9xvghi9ot/OQ+21Xi+LAWh0
	 D44/J9HtNTqzyYUX1ys3dez6fpZSTU+M+1ErNU8GiyrJR/QyrQAIjpyd3eJjWV3TIg
	 udaADm/VfRwUUZCqN1cCDX0TkQvR6Bv9t1h/gpyzxCxnf9LVOQVwwIkJwJk7lQkzPn
	 JptGtZFQC/5+MmjAZopvHN7UmN0VUUulSYKXW7E/EWZJruEZ3QiY38MOAWXW5oin//
	 XSiG4zNCghlX1ydzSHy5Bbtq/Dr53L6JS+TuesL0wBPIGiqQrE2a0AkS/hNEdoP0FA
	 5Fh5vDjafLsKg==
Date: Mon, 4 Aug 2025 08:16:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 7/7] iov_iter: remove iov_iter_is_aligned
Message-ID: <aJDAx1Ns9Fg7F6iK@kbusch-mbp>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-8-kbusch@meta.com>
 <aI1xySNUdQ2B0dbJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aI1xySNUdQ2B0dbJ@kernel.org>

On Fri, Aug 01, 2025 at 10:02:49PM -0400, Mike Snitzer wrote:
> On Fri, Aug 01, 2025 at 04:47:36PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > No more callers.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> You had me up until this last patch.
> 
> I'm actually making use of iov_iter_is_aligned() in a series of
> changes for both NFS and NFSD.  Chuck has included some of the
> NFSD changes in his nfsd-testing branch, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=5d78ac1e674b45f9c9e3769b48efb27c44f4e4d3
> 
> And the balance of my work that is pending review/inclusion is:
> https://lore.kernel.org/linux-nfs/20250731230633.89983-1-snitzer@kernel.org/
> https://lore.kernel.org/linux-nfs/20250801171049.94235-1-snitzer@kernel.org/
> 
> I only need iov_iter_aligned_bvec, but recall I want to relax its
> checking with this patch:
> https://lore.kernel.org/linux-nfs/20250708160619.64800-5-snitzer@kernel.org/
> 
> Should I just add iov_iter_aligned_bvec() to fs/nfs_common/ so that
> both NFS and NFSD can use it?

If at all possible, I recommend finding a place that already walks the
vectors and do an opprotunistic check for the alignments there. This
will save CPU cycles. For example, nfsd_iter_read already iterates the
bvec while setting each page. Could you check the alignment while doing
that instead of iterating a second time immediately after?

