Return-Path: <linux-fsdevel+bounces-74045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01CD2B6EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37B703008193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709B338593;
	Fri, 16 Jan 2026 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak9HsTWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BF42C21F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768538013; cv=none; b=aQy+N7vFVfBFRP8HOe8ikYa2/UwyGZn4pe9EGX/jXm05suTbCZKP/LxU8TH18NcLz+b1VrXMnbBeNGAbSEkzRPF9V8jPZ/8IIhJ2Xcl0Y2+eRaRAvcbBH5dI6pSODnyrtMWsMaNFfyfsbfHlWDr87SYYYdta3hT22FlbcAiRiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768538013; c=relaxed/simple;
	bh=8LRNBKrqbjTSHDGZsehazJKOM9y/E1l7Q8EziGaQHuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKNc2ZasdpgSqOqHm/SBf8qJPTTAdd5nCF4yPeZCv9HllBiytbnD5QnLoB6wI++DZqxF7DQe5AKRgov2zIjNwVgn9L2E+3IyM7bzFF/hJS3LUufJ81jf9ixWcm/NL8A2x3EXz9/1N1AyKwobDAmefWN6q3hP5p986wmLD0MKgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak9HsTWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3893DC16AAE;
	Fri, 16 Jan 2026 04:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768538013;
	bh=8LRNBKrqbjTSHDGZsehazJKOM9y/E1l7Q8EziGaQHuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ak9HsTWEUniypXNLg8ldodSz5anRVkUzf9ddXo2FrI9/WP9EHX/YO0NtFwe//tz6z
	 3S4wsRSpzOtYDjCm4QKXXUAKQUhq6m36wydkStflcYRLD83qtgTkiR6W7bMWTCqqN1
	 0FFLR9+guqe1ryBe90ML3dQoyLdi0SvSqmbpYEJYvfFtLlHIr6D29fu7TE5RDPsPkc
	 kPHGyu4GdjIkhFAAxqpj2MKcf9ZeZN7B7yJKaVOWVEIK3PfiZtdrSraMpIOASR36Mx
	 HuRcIaKrfoYsZZTe7WSd0O1ATk/6GzS8luWGiNJmAXpqiX+x6rJEDL+A84ACcHEb9y
	 Hys9tU5SL3i8w==
Date: Fri, 16 Jan 2026 04:33:31 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Nanzhe Zhao <nzzhao@126.com>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
Message-ID: <aWm_m0AsbUXcRB6l@google.com>
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
 <aWaPzQ8JXNBdzb4U@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWaPzQ8JXNBdzb4U@casper.infradead.org>

On 01/13, Matthew Wilcox wrote:
> On Sun, Jan 11, 2026 at 06:09:40PM +0800, Nanzhe Zhao wrote:
> > @@ -2545,6 +2548,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
> >  	}
> >  	trace_f2fs_read_folio(folio, DATA);
> >  	if (rac) {
> > +		if (!folio_in_bio) {
> > +			if (!ret)
> > +				folio_mark_uptodate(folio);
> > +			folio_unlock(folio);
> 
> 		folio_end_read(folio, ret == 0);

Thanks.

https://lore.kernel.org/linux-f2fs-devel/20260116043203.2313943-1-jaegeuk@kernel.org/T/#u

> 
> surely?

