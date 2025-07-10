Return-Path: <linux-fsdevel+bounces-54547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09791B00C66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 21:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF8A1CA70ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B42FD87A;
	Thu, 10 Jul 2025 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwD2iFsa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE8156C6A;
	Thu, 10 Jul 2025 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752177428; cv=none; b=XZlbjaFRfKf3TyGREVv7Y1dQ0ZoSGN3rYG5TPWbiMSOAPEGktgksUHOG90VVx9ViAZH4Mu1Z2h7cf47vw5SeNSzQchxSnwwGbIeUyKD1+bioLdiYAgaVb6OVgtysuYKogruOOhKweE6Xj5ZCwhVCPwRNq75orziYzalc38QyqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752177428; c=relaxed/simple;
	bh=laq88QMPXADMspyDTjRQjifQmCe9VhuNZqwCpLqzVJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp+vAchO4X19O/oZl9e+fh24Ufod559i4vedP5D+DhMQ5g4rwseqK2Ac6T6SbHMkoc7esHnIQSwc6JDxwq1pn5PbnUfGSIDulk5sSDBLbcjhYSpTM0wQzoLgpNqUnCeC6lY83BPHNGsEyxli+wwsxJsydDdfCiMHp8uPE68MjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwD2iFsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A155AC4CEE3;
	Thu, 10 Jul 2025 19:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752177427;
	bh=laq88QMPXADMspyDTjRQjifQmCe9VhuNZqwCpLqzVJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwD2iFsaw4fxL1BjVNjmfm3WRvqCmFgJKLfACA44hTVucIl8M2h0ZNONEkTGm6w4m
	 dkPcGtuXMdtm0buwX847l1KErF/FPUPm5vSxtBgka5liQ9UJ8/kfamjX0KB2rRY6Xj
	 OyugyOfNkATYnXnwG3zwjqdK0tgg03RuNBnUoDYBLe0vrQ1IB0MtgcDOBKjazFPseL
	 Wg7xrMDvUn0gApDbKkXxq4QjWlAH1IJJlefhV4SgBrBGe+XhdMcp9BPIZBiTkaO8wY
	 cjVOp7O/JzJ6B7L4QScc8DVLp39lTC3fPIoxUxkLTtx8HwbFovYkd/tsRGHtAHmvyk
	 cXQQqDK2Q0T5Q==
Date: Thu, 10 Jul 2025 13:57:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aHAbEKwM2JHX_dsM@kbusch-mbp>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
 <5819d6c5bb194613a14d2dcf05605e701683ba49.camel@kernel.org>
 <aG_SpLuUv4EH7fAb@kbusch-mbp>
 <aG_mbURjwxk3vZlX@kernel.org>
 <aG_qYnxiK1Rq5nZR@kbusch-mbp>
 <aG_28zNe3T-wt7L8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG_28zNe3T-wt7L8@kernel.org>

On Thu, Jul 10, 2025 at 01:22:59PM -0400, Mike Snitzer wrote:
> I'll revisit this code, but if you see a way forward to fix
> __bio_iov_iter_get_pages to cope with my desired iov_iter_aligned_bvec
> change please don't be shy with a patch ;)

For the record, I do like the cause you're going for. I wanted to make
that work when I initially introduced dma_alignment to direct-io, but
the spliting, merging, and respecting all the queue contraints for
things like virt boundaries and segment limits was a bit more than I
expected.

