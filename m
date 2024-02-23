Return-Path: <linux-fsdevel+bounces-12587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2ED8615FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC071C2197C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE081759;
	Fri, 23 Feb 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZcRlwVq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88D6E618;
	Fri, 23 Feb 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702597; cv=none; b=O1Z6j6iWPi0z7pPJBTB9hC+QY6QGfdw8IzAqQUnwSFukHU22p9ucoN/Kdj26tY8HwL7ZKunWuxFg2qftcMfFLG1bO5kPBASuh9DmzOylBwj8enNM0DFGZjtSwaYjKld9GPM2idJQtrMYIEaKA5yZpgwW+V0zVg6WODaqpIYcdGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702597; c=relaxed/simple;
	bh=alVWIUk3BEu3xPVTyvD6WzPjZSlnEFhpX1T223Yfp7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoIuqvm+j87Oocv4uAByyAHbR3kklJu1oW7x6/irU7WRkHxy4ZCX3HBkA9C7FKrMo9ckwEdo41wjqqLUaKNCp8Nhz7YcYNLl65w4FCFAY8b3eLvckms2OWf5B9xtdoXHBTdsi/Ys0gTmcJxqjpMEpbNEYYDoxkUOPt7aV+Ditvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZcRlwVq8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3GdX6imMvbRIm6fINSz0BafY57HFCVJylihVpHjCpIk=; b=ZcRlwVq8wpjvVDN9MmRm9NWh1Q
	/ZPcygYeTsH+OlQwivGsM3rT0tFj1C8ZSZOhn+6SzlZnd/Lnug/5+CkW4p548drHl2AfQFRi2mjjy
	t9DelpK5oNDQHD865DXFn8bCeCaduWmSHeVy/FcF64QDuXrAkg3OsQv6nv50lePYzUJ3LrDgyQwjv
	EW+2pjjS1HFzfcrDd4AQ8Atz1XsJ0BuzcIm1rmAk8dLlpuLHBBAbvFwH5ozfd8xt9qZWTMuqs0EbM
	mGQe5nrzFoSJ+l7OmJ/NraO++3s2H/KvefGpMjG/f1ahOiVAqGFOz1aeioVkC4XZnxjF5PjBN1VFK
	fZkj0X4g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdXbE-00000007VwD-3yPS;
	Fri, 23 Feb 2024 15:36:33 +0000
Date: Fri, 23 Feb 2024 15:36:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	torvalds@linux-foundation.org, npiggin@gmail.com
Subject: Re: [PATCH v2 03/17] mm: Add folio_end_read()
Message-ID: <Zdi7gCrsbSNhQTC8@casper.infradead.org>
References: <20231004165317.1061855-1-willy@infradead.org>
 <20231004165317.1061855-4-willy@infradead.org>
 <564df866-e874-400e-aff3-54d75295187b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564df866-e874-400e-aff3-54d75295187b@I-love.SAKURA.ne.jp>

On Sat, Feb 24, 2024 at 12:26:41AM +0900, Tetsuo Handa wrote:
> During a bisection of a different problem, I noticed that
> commit 0b237047d5a7 ("mm: add folio_end_read()") added folio_end_read() as
> 
> ----------------------------------------
> +void folio_end_read(struct folio *folio, bool success)
> +{
> +       if (likely(success))
> +               folio_mark_uptodate(folio);
> +       folio_unlock(folio);
> +}
> ----------------------------------------
> 
> but commit f8174a118122 ("ext4: use folio_end_read()") for unknown reason
> removed folio_clear_uptodate() call when bio->bi_status != 0.
> 
> ----------------------------------------
> -       bio_for_each_folio_all(fi, bio) {
> -               struct folio *folio = fi.folio;
> -
> -               if (bio->bi_status)
> -                       folio_clear_uptodate(folio);
> -               else
> -                       folio_mark_uptodate(folio);
> -               folio_unlock(folio);
> -       }
> +       bio_for_each_folio_all(fi, bio)
> +               folio_end_read(fi.folio, bio->bi_status == 0);
> ----------------------------------------
> 
> Why
> 
> 	else
> 		folio_clear_uptodate(folio);
> 
> part is missing in folio_end_read() ?

Because the folio already has its uptodate flag clear.  We don't re-read
folios which have the uptodate flag set.  This was always dead code.
Now we assert it's true in folio_end_read():

        VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);


