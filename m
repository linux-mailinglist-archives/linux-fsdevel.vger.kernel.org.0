Return-Path: <linux-fsdevel+bounces-5202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C5780959B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE2E282104
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078405786A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X99USWiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254763309C;
	Thu,  7 Dec 2023 20:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C09C433C8;
	Thu,  7 Dec 2023 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701981947;
	bh=sYQGssTPlpa20lbjLRapkdCgDOIj7sRJzFW5CjUHMbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X99USWiJWBAwJ+VC4spP2yULMtaNtSkqbt1K+gmlozAjNkUj10SDqOuy/hezUjcZv
	 rqymWPito8296Ff41S+g+f9OY0XJkNNSRxj8v/ujY8qlmViZroXundj5ZgPLKMgi1o
	 jMGwEGBe38sUY3ThKl/guF72+tE9NzkOoPGl1gHjTSl1Vfp82Ofx0ieCYyEJIhhJcy
	 vISs1DK/3+FnyymvYyy87x44BF0CsavXDI02bUHpQubCN1JcmIHY/z9jUfGWGyqg78
	 3MjBEzFGlztw6BNeL/vrDUNj/KbdSWPD7LrjQFNjltfcsXNlFzeHZRoPxpnRSORprc
	 EHhsCCOFYIeJg==
Date: Thu, 7 Dec 2023 13:45:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/3] block: Rework bio_for_each_folio_all(), add
 bio_for_each_folio()
Message-ID: <ZXIu-Yj2tBd2895_@kbusch-mbp>
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
> +#define __bio_for_each_folio(bvl, bio, iter, start)			\
> +	for (iter = (start);						\
> +	     (iter).bi_size &&						\
> +		((bvl = bio_iter_iovec_folio((bio), (iter))), 1);	\
> +	     bio_advance_iter_single((bio), &(iter), (bvl).fv_len))

I know your just moving this macro, but perhaps now would be a good
opportunity to rename 'bvl' to 'fv' to match the callers and have a
different naming convention from the bio_vec macros.

