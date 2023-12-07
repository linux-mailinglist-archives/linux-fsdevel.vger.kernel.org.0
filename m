Return-Path: <linux-fsdevel+bounces-5195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D980927A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 21:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5511F2117A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4355024A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UYhboT7r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B197A10FC;
	Thu,  7 Dec 2023 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5iL0o/3jhpJnv1J7ULbie8/wniDsJsdIZdalhFUlmno=; b=UYhboT7r8ye6uKJG1CW7ysxSlP
	45nlPEZkBInWQMowfFaFxCYxvox1HAcm5h/85N0hBx94VN0nL5km4nv+QRcGENGvjiLKKhTaadcvV
	gXnCpOd2jCTVQApKiZhYcNp/nHZKQmWcUrOnqisNoPhvB+zD6hFA7supZ/dgPfR/CJHpoPlrcPavs
	sA8bpRDrJfUoj1eeCRqhSEuTsUou6kXw17UGiXh+b5vJ3g8tQN6qBr6k77QHBQkoTHrKC8EiG1wGK
	HtsDdAjCNAbBV70FIPnNbrzdA0wKNN5MSfdYXc6SoQnAiuLU+o3tqRKX7Phy5A+DAwSNwMKCMnhM0
	uZ1WXsgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBJds-004DYu-Sy; Thu, 07 Dec 2023 19:02:36 +0000
Date: Thu, 7 Dec 2023 19:02:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: Rework bio_for_each_folio_all(), add
 bio_for_each_folio()
Message-ID: <ZXIWzLUUqZ7ld7bb@casper.infradead.org>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231122232818.178256-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122232818.178256-2-kent.overstreet@linux.dev>

On Wed, Nov 22, 2023 at 06:28:14PM -0500, Kent Overstreet wrote:
>  /**
>   * bio_for_each_folio_all - Iterate over each folio in a bio.
> - * @fi: struct folio_iter which is updated for each folio.
> + * @fi: struct bio_folio_iter_all which is updated for each folio.
>   * @bio: struct bio to iterate over.
>   */
> -#define bio_for_each_folio_all(fi, bio)				\
> -	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
> +#define bio_for_each_folio_all(fv, bio, iter)				\

That @fi should be an @fv, no?  Does kernel-doc not warn about this
mismatch?


