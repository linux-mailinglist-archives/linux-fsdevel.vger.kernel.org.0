Return-Path: <linux-fsdevel+bounces-51226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E465AD49EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1686116A4E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 04:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB71FDA8B;
	Wed, 11 Jun 2025 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TXxL88Bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2C35962;
	Wed, 11 Jun 2025 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614662; cv=none; b=SZktWpmb6bBZfIErQkarPugr+bEIhv/rY73hikbsgV6uP26iApiEXBXN+fzaQGh1A3T/ufguOyJtq/VFdzp8Cifbf1hLqhomBx8eS0mbivdwXfH+fK4PiMdUMui3hnWwN7vRZ0farERd71jIN3dhqBSb7YL513GqqPbqJGumJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614662; c=relaxed/simple;
	bh=I5y7SpDYHhNs7xR1AW0mD/bdMwW+gnyliriQ1BwhFrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIKK0z8vEelygWhXxL+TZ035KB2XWqA/TBgzNbGcVFdup+FHAf1ReB7Ix2RZxM0na+pE5tKbcGFSnBCoyF7ecbibF38qpkzF0+GJ0DklIyX+kO7llGCieC3KXneP7m2WjLNu6JNIcmDcolhRdFGPik56UjrI/GHn5KRAZGwuqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TXxL88Bw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=21XRgd1yPOmwtbXLkWGSXe/1zc/7gcY3wvoXSU21LTM=; b=TXxL88BwT0q8YzFMNxHwyfHnCa
	A9kNMJrms+PpUd9c4oh3zUStSdPchmVYu6qX8X8RdIqx9la4jeZOffhnJsL/Ieewer6i8oWhtW7c+
	fH3Fn7SfeK6wBj3wfvZMt7W/Itgjpquc3pd0mmUAFZQ5DqmyQ7DxWYWx6aR9K8jKAP3JGJv03khXX
	Nm8kY9dVnPD1TJsOR+PXkcipGq9oj3BwRR+CSboWbzxi0VUAk3D6s5sMRE6QvmtXYmJqrJXVqpp3u
	8fEh90lLYk8PDNI+2EPL+9fNwV280VDzaf8jzrJud0CKcNxA2WKLzg5usASsNn+DfxP5Zgbk3vMoC
	wPQ16UJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPChI-00000008o5h-27l2;
	Wed, 11 Jun 2025 04:04:20 +0000
Date: Tue, 10 Jun 2025 21:04:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Message-ID: <aEkARG3yyWSYcOu6@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com>
 <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org>
 <aEgyu86jWSz0Gpia@infradead.org>
 <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 01:13:09PM -0700, Joanne Koong wrote:
> > synchronous ones.  And if the file system fragmented the folio so badly
> > that we'll now need to do more than two reads we're still at least
> > pipelining it, although that should basically never happen with modern
> > file systems.
> 
> If the filesystem wants granular folio reads, it can also just do that
> itself by calling an iomap helper (eg what iomap_adjust_read_range()
> is doing right now) in its ->read_folio() implementation, correct?

Well, nothing tells ->read_folio how much to read.  But having a new
variant of read_folio that allows partial reads might still be nicer
than a iomap_folio_op.  Let me draft that and see if willy or other mm
folks choke on it :)

> For fuse at least, we definitely want granular reads, since reads may
> be extremely expensive (eg it may be a network fetch) and there's
> non-trivial mempcy overhead incurred with fuse needing to memcpy read
> buffer data from userspace back to the kernel.

Ok, with that the plain ->read_folio variant is not going to fly.

> > +               folio_lock(folio);
> > +               if (unlikely(folio->mapping != inode->i_mapping))
> > +                       return 1;
> > +               if (unlikely(!iomap_validate(iter)))
> > +                       return 1;
> 
> Does this now basically mean that every caller that uses iomap for
> writes will have to implement ->iomap_valid and up the sequence
> counter anytime there's a write or truncate, in case the folio changes
> during the lock drop? Or were we already supposed to be doing this?

Not any more than before.  It's is still option, but you still
very much want it to protect against races updating the mapping.


