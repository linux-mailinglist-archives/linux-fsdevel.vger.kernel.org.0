Return-Path: <linux-fsdevel+bounces-51166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E082AD3966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBA01883EB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02D23ABA8;
	Tue, 10 Jun 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rerNKwhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4223AB98;
	Tue, 10 Jun 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562231; cv=none; b=Wq/81jPWN+XAfb7qDHXHzgx+65o3Noo8fgQKNF4xbjad0xER64sEoQZiOeJjZgaCKCg7mcmOm14u9kBVwzefQm8NrgQvV/w0RhoIoj1DlF1+PebJ1bBRSnHq2WeSqzfUVxyFsic6mGHgHdq7/VjJJue7+jF4CdA6ccIJRrUXRzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562231; c=relaxed/simple;
	bh=j72cNm8s8BmJR2yvP9N6+eHhMx4qyILJpk302T4ObgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeLxsvIV/Qjz71E9uSka6TcipQWrd0wLMf7TY6iUz3l4VdLk7StU1zHSoaUT8GiVwvnb+vdRikqLpTtPI4ZF8I1oT70sKKniUZNfR/h9uVxXAUfN2xutjGB0Fzz+qRsyZldNBzBbzOh97G4SPwPqLMBEWEdlXBcu1KO/l/nixVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rerNKwhY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GcbjZKDHfWzF4Hztsbds8tFXOAXOwUhPwJriLCPNAsA=; b=rerNKwhY6cYVBgVq/mcdEaviHF
	T9VsFX+uRspOI7OnRjqZgfBd7m4bKGvsbou3oaDt+D/0AaycXXsIkRa9KXeXjunGpQqyrMQtI5ZYS
	116OQpYPMbfiBB4CMqR9FWiP+pdMPQQi7VR8e7jb6VwYwV1TkSBXrCG0+1EHom6o0kw6zI9z8bPbW
	47vTBzs6vNbvM+Vju65uUPUMEEOK75kYSxXox+V8nXWy5bB7ki/GGUkIom76kW46SEUQFZ0RkhpbS
	gPiHlQGjnLygStCc1PKNEeiKQDjob7VrrAVOwuaO2OzfnStz3IEUqE2n+4gM1a0qpSPzWaGF2/xGC
	ZLFrdfOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOz3d-00000006ySA-1UMn;
	Tue, 10 Jun 2025 13:30:29 +0000
Date: Tue, 10 Jun 2025 06:30:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <aEgzdZKtL2Sp5RRa@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-8-bfoster@redhat.com>
 <aEe1oR3qRXz-QB67@infradead.org>
 <aEgkhYne8EenhJfI@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEgkhYne8EenhJfI@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 08:26:45AM -0400, Brian Foster wrote:
> Well that is kind of the question.. ;) My preference was to either add
> something to fstests to enable select errortags by default on every
> mount (or do the same in-kernel via XFS_DEBUG[_ERRTAGS] or some such)
> over just creating a one-off test that runs fsx or whatever with this
> error tag turned on. [1].
> 
> That said, I wouldn't be opposed to just doing both if folks prefer
> that. It just bugs me to add yet another test that only runs a specific
> fsx test when we get much more coverage by running the full suite of
> tests. IOW, whenever somebody is testing a kernel that would actually
> run a custom test (XFS_DEBUG plus specific errortag support), we could
> in theory be running the whole suite with the same errortag turned on
> (albeit perhaps at a lesser frequency than a custom test would use). So
> from that perspective I'm not sure it makes a whole lot of sense to do
> both.
> 
> So any thoughts from anyone on a custom test vs. enabling errortag
> defaults (via fstests or kernel) vs. some combination of both?

I definitively like a targeted test to exercise it.  If you want
additional knows to turn on error tags that's probably fine if it
works out.  I'm worried about adding more flags to xfstests because
it makes it really hard to figure out what runs are need for good
test coverage.


