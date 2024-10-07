Return-Path: <linux-fsdevel+bounces-31220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ABC993434
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1B51F23766
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433B11DD867;
	Mon,  7 Oct 2024 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky9T4tC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1511DC1AE;
	Mon,  7 Oct 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320222; cv=none; b=F5hCWgxsfAL4ZycH1kD7XwNvEnSQvkK2dIYI8t5J/kdTM3IJ6sKUeYD9fFtQQ+RfTr4WVWNiWeJvybWpKG6bpN8SWIsqelNmK3uoa6OL8hbGeCyJsZ7F3QF9x+K0BWpTz3c+mbixVJCcNxSqEtviQW+69QEuzfFNEfddkiyrj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320222; c=relaxed/simple;
	bh=xcXKw2m89hBWIM4ZfeefRHBeTdHv9hQNK29Cj4F0q50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVGRsHx9E+mj48/vepfEnMc2rO9pWMvR+vWsNZGLDn/S6pg0GaKBhG2Q3e2knHJZjtP/PbUqziYUOa/AlRXTk0VR+u4ab4mYdAdylign/svznf6Tq1GRpYPytPfY+UfTrID1UQOgZTkSJcchX5NFPfxrBpoCLGmbwTbWN7Rdf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky9T4tC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550ACC4CEC6;
	Mon,  7 Oct 2024 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320222;
	bh=xcXKw2m89hBWIM4ZfeefRHBeTdHv9hQNK29Cj4F0q50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ky9T4tC9+D9Fzx5HOrNmvh72thajEfb5RaYm+lj3pSvO277kRmjdCitvRHq+cCT/u
	 kEBG7Dksq8JQDbDeTmEaLpJjfC3ThrQR0sNwDMWE+ilswO8bWkOUyTKY75LOcDOJta
	 8MSCUGYOKHvIjKkDXyyjv2Sm+uKLm+NH1HQ3B62h/iZCsISwUlngVmdh4LPBq6FWt5
	 WL1pqqMyitjdqpvMiSMtd9euG/DJQzfoFwIlAyDW/9QTbjgxAPvciJoVu9DMaaE11Q
	 ifjejDzki1ynkr4sThMqojZr7jYII6LATViBk5o4SOi7z/yHkRRp4UtMtB2IETvx+r
	 RZKL4udMpy6bQ==
Date: Mon, 7 Oct 2024 09:57:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/12] iomap: check if folio size is equal to FS block
 size
Message-ID: <20241007165701.GB21836@frogsfrogsfrogs>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <b25b678264d02e411cb2c956207e2acd95188e4c.1728071257.git.rgoldwyn@suse.com>
 <ZwChy4jNCP6gJNJ0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwChy4jNCP6gJNJ0@casper.infradead.org>

On Sat, Oct 05, 2024 at 03:17:47AM +0100, Matthew Wilcox wrote:
> On Fri, Oct 04, 2024 at 04:04:28PM -0400, Goldwyn Rodrigues wrote:
> > Filesystems such as BTRFS use folio->private so that they receive a
> > callback while releasing folios. Add check if folio size is same as
> > filesystem block size while evaluating iomap_folio_state from
> > folio->private.
> > 
> > I am hoping this will be removed when all of btrfs code has moved to
> > iomap and BTRFS uses iomap's subpage.
> 
> This seems like a terrible explanation for why you need this patch.
> 
> As I understand it, what you're really doing is saying that iomap only
> uses folio->private for block size < folio size.  So if you add this
> hack, iomap won't look at folio->private for block size == folio size
> and that means that btrfs can continue to use it.
> 
> I don't think this is a good way to start the conversion.  I appreciate
> that it's a long, complex procedure, and you can't do the whole
> conversion in a single patchset.
> 
> Also, please stop calling this "subpage".  That's btrfs terminology,
> it's confusing as hell, and it should be deleted from your brain.

I've long wondered if 'subpage' is shorthand for 'subpage blocksize'?
If so then the term makes sense to me as a fs developer, but I can also
see how it might not make sense to anyone from the mm side of things.

Wait, is a btrfs sector the same as what ext4/xfs call a fs block?

> But I don't understand why you need it at all.  btrfs doesn't attach
> private data to folios unless block size < page size.  Which is precisely
> the case that you're not using.  So it seems like you could just drop
> this patch and everything would still work.

I was also wondering this.  Given that the end of struct btrfs_subpage
is an uptodate/dirty/ordered bitmap, maybe iomap_folio_ops should grow a
method to allocate a struct iomap_folio_state object, and then you could
embed one in the btrfs subpage object and provide that custom allocation
function?

(and yes that makes for an ugly mess of pointer math crud to have two
VLAs inside struct btrfs_subpage, so this might be too ugly to live in
practice)

--D

