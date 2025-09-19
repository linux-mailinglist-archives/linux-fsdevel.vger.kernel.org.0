Return-Path: <linux-fsdevel+bounces-62235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D32B8A2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990E04E7890
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E943B314B9F;
	Fri, 19 Sep 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xE58bSsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1190313E30;
	Fri, 19 Sep 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294259; cv=none; b=HbJJN1e4FAWDVuPVGmtsjHeBKze2uc38mQEZjDdULlKvcg27QIWgSFyDmNLc9wE8xG+9B5vqIABHmApgpb0L79GPilybwax/I3pgiZMCV6uyyJrCAYiBTwfhgzzQ2nuUgS2QOfDdCZggbLFPQTW6AhUOmVYlw1HJughU9z18zCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294259; c=relaxed/simple;
	bh=42isF/WZsmBh5ZmpcnOp7XXD2OgHyQsMKCD1TyuRvOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN2/+oin6ofIldrpAiYtGYcPdcwVv17KAAB1x9vKXxfMye6NXwdieJg23jCYoGhvt0lD9Sirnj5DDZDw4gtU0llwVAizZwKIkPrYwKSTJj0XqcMMJ/ocvfcwSf0i920n+lLALAQP2hR/XEmWIQ8WiHxVkfiUOjWiEsA48U9z650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xE58bSsG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ci6GUzt/zBUPg8YgjcIKFzIGceTJiYQmoDw0F7XTobs=; b=xE58bSsGEbJk8MPAMD2lNBwyCj
	6iZDmXZHma806PABiz8+4MZk6xBVmBkKSUKOwwfbK0ZW9i6LG426urRxZlRNnhY10U3rOXkAcNtDi
	AnQslLXWyOblSLTibCbCBDIdT843nD8KmiyaqkmSbCSkHfIf+NtOCQcuLSf20gUL/5vCE1TNo8qqS
	Mj0jufB8Upbl+JOjMcvKD8I0RT+1Mve9xDgfwXEIhde+lBkSDWYFu676ISkAOFj0DAPZZJ1SMZHxh
	nZ4qTK4qwLekk3aqpg4TqBAkSM9X8M4W8dJhuIGyhg+dNTAstEzapteJc9jV5iGN2VjgpqYY51pwx
	O/l+KiBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzcel-00000003G5z-2STi;
	Fri, 19 Sep 2025 15:04:15 +0000
Date: Fri, 19 Sep 2025 08:04:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	miklos@szeredi.hu, djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 12/16] iomap: add bias for async read requests
Message-ID: <aM1w77aJZrQPq8Hw@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-13-joannelkoong@gmail.com>
 <aMKzG3NUGsQijvEg@infradead.org>
 <CAJnrk1Z2JwUKKoaqExh2gPDxtjRbzSPxzHi3YdBWXKvygGuGFA@mail.gmail.com>
 <CAJnrk1YmxMbT-z9SLxrnrEwagLeyT=bDMzaONYAO6VgQyFHJOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YmxMbT-z9SLxrnrEwagLeyT=bDMzaONYAO6VgQyFHJOQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 16, 2025 at 12:14:05PM -0700, Joanne Koong wrote:
> > I think you're right, this is probably clearer without trying to share
> > the function.
> >
> > I think maybe we can make this even simpler. Right now we mark the
> > bitmap uptodate every time a range is read in but I think instead we
> > can just do one bitmap uptodate operation for the entire folio when
> > the read has completely finished.  If we do this, then we can make
> > "ifs->read_bytes_pending" back to an atomic_t since we don't save one
> > atomic operation from doing it through a spinlock anymore (eg what
> > commit f45b494e2a "iomap: protect read_bytes_pending with the
> > state_lock" optimized). And then this bias thing can just become:
> >
> > if (ifs) {
> >     if (atomic_dec_and_test(&ifs->read_bytes_pending))
> >         folio_end_read(folio, !ret);
> >     *cur_folio_owned = true;
> > }
> >
> 
> This idea doesn't work unfortunately because reading in a range might fail.

As in the asynchronous read generats an error, but finishes faster
than the submitting context calling the atomic_dec_and_test here?

Yes, that is possible, although rare.  But having a way to pass
that information on somehow.  PG_uptodate/folio uptodate would make
sense for that, but right now we expect folio_end_read to set that.
And I fail to understand the logic folio_end_read - it should clear
the locked bit and add the updatodate one, but I have no idea how
it makes that happen.


