Return-Path: <linux-fsdevel+bounces-18074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772298B5344
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F35281E98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E517BB4;
	Mon, 29 Apr 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUi5zPKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A713AEE;
	Mon, 29 Apr 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379892; cv=none; b=ixYDNKtNyzhEUzeyzxfNUNC15GRYdufiHzpLjXwVz+zExc7+XQQ0pYq6Te7xFYvc3JbOzt7VULW9pxAsfmlWis6j3hzfPiMyboWYY1FDpeogO4ylUqFo8r5sZhyfVfz6jQsI36s62OaWGBsJdePJObQYq5kV7FHWtyNca6fHqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379892; c=relaxed/simple;
	bh=YWkodHggdiUj44Q+NL61mF6luWX5u4sM1EYhn71vXeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csuQe0GHIESAqFXCkZE6kZki29gq2YQYTkfo9RLezeeUJQRUXYNSQIwVVp79MRhH5SR2EOnmRyRqbF1rhVwb6SoJXzfledgDRVFDBQ6Oh1WOgtFdvEKejC2Tn9Z88Iepv830cK1+NL5hdKc4UAf9PQKDtIGtNXURetdzGvBi5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUi5zPKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BFCC113CD;
	Mon, 29 Apr 2024 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714379892;
	bh=YWkodHggdiUj44Q+NL61mF6luWX5u4sM1EYhn71vXeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUi5zPKBPFintRlECloGiSogHC976uLGG1dUdbI95wFygW2TA9aURqYH5vGWwzL2J
	 eLcWKT8XT9nxgwR54ikTW4otgyRikLDYVUmfVoq1aZUsbGLc2NFxIGIvavd/y6q/bq
	 qzDLYape1zuunil+ua2PcGOD/tqkaOfRKUr6FWEkDQVp/u5Rjdg5UenxG3dkatxiPc
	 aqSEwHv5iB0gO1T/l07rlMQeQ8xolLIGu+yaTjqHxAmJypwiwgojoRQiOynoRVhuCX
	 YoTZdGhLvcsdlXnUgtMO+HCodsbu/kqqbNDKrPKk5QvP5O5BwkbpkwuKY0v2T4aC1m
	 +N1Hf19dw4vjQ==
Date: Mon, 29 Apr 2024 10:38:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] pktcdvd: sort set_blocksize() calls out
Message-ID: <20240429-synonym-weisung-b77f8350d35b@brauner>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211032.GB1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427211032.GB1495312@ZenIV>

On Sat, Apr 27, 2024 at 10:10:32PM +0100, Al Viro wrote:
> 1) it doesn't make any sense to have ->open() call set_blocksize() on the
> device being opened - the caller will override that anyway.
> 
> 2) setting block size on underlying device, OTOH, ought to be done when
> we are opening it exclusive - i.e. as part of pkt_open_dev().  Having
> it done at setup time doesn't guarantee us anything about the state
> at the time we start talking to it.  Worse, if you happen to have
> the underlying device containing e.g. ext2 with 4Kb blocks that
> is currently mounted r/o, that set_blocksize() will confuse the hell
> out of filesystem.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

