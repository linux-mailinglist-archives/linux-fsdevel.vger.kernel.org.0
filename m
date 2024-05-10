Return-Path: <linux-fsdevel+bounces-19248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798B8C1DFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 08:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60871F216DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A321527B2;
	Fri, 10 May 2024 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AIlrARjZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077461494DE;
	Fri, 10 May 2024 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322023; cv=none; b=p/lpnU/AF1Z5/HrmcNvtye04YC+wu3t6+L7po5XJO3OHM5fG/+jWq6fOiMoxuDm9XzYezM2q9uKEHwlo6rmhM3RHv1gfXoOS36A4VL/JCcHoMZxtmnncfDc42NfGpU6mIR1MBRXR5cQxC09BOdmswlCMLWqm+7h04cKSZYp1fKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322023; c=relaxed/simple;
	bh=MXB8yULq8IhEcfPSgfRUb3LoqfN1ihZb5DfjgDQ83ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdhOOMNBNpTlpIQHdGqU2PzxR6aYlnwZoflTJwLiBonhFyd0LI4srHuFJTpng7yxtZdfZmfFa5CLeqdypByt93uPZnANyHq74O57sQ0NC+w+ChswsX9WVSpsgcZm1swPWf9GyCrmPoXvVuEsbsyWQDIFFoyKPFTj/Z8O+D/jq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AIlrARjZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tWbLPpe1dxAUAnS/VIXTnCfeoHbQYCROBhp9omQeVas=; b=AIlrARjZRQ5GemdOQ+DXBoAZFM
	U/d8TrSy87aVZ1nDBjzhYvOZ1KAq/gf/7MfzhCIUFgY3mymY1lQRroEqJ0h35wxP9acMycZ+8kpE8
	nnBeMpdTPe2sPxxqLkyi0aFDIBcbh20oYX0igwNKPZo8p/Nvi7pZ3vYuC8pTBtLiEvWBYZB8AjoLZ
	2y5T9ILibr8jTdt0coPaKcZ21oYr6KckIkVYP9ebyZFT/Ns+ErDBpH0Q+ASsp2VSnwQdf8bj92b8Q
	EeIte/xkPzqr5K8fTTfS+o+axvalsfpNESyVEj/rD3hcLQ+4DywsEIHgN6l+nmzZiyuQIOBu0rFOH
	NifxF0rQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Jc9-00000004Bts-2VHG;
	Fri, 10 May 2024 06:20:17 +0000
Date: Thu, 9 May 2024 23:20:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <Zj28oXB6leJGem-9@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <ZjxY_LbTOhv1i24m@infradead.org>
 <20240509200250.GQ360919@frogsfrogsfrogs>
 <Zj2r0Ewrn-MqNKwc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj2r0Ewrn-MqNKwc@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

FYI, I spent some time looking over the core verity and ext4 code,
and I can't find anything enforcing any kind of size limit.  Of course
testing that is kinda hard without taking sparseness into account.

Eric, should fsverity or the fs backend check for a max size instead
od trying to build the merkle tree and evnetually failing to write it
out?

An interesting note I found in the ext4 code is:

  Note that the verity metadata *must* be encrypted when the file is,
  since it contains hashes of the plaintext data.

While xfs doesn't currently support fscrypyt it would actually be very
useful feature, so we're locking us into encrypting attrs or at least
magic attr fork data if we do our own non-standard fsverity storage.
I'm getting less and less happy with not just doing the normal post
i_size storage.  Yes, it's not pretty (so isn't the whole fsverity idea
of shoehorning the hashes into file systems not built for it), but it
avoid adding tons of code and beeing very different.

