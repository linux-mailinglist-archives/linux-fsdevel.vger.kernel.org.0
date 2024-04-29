Return-Path: <linux-fsdevel+bounces-18073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490A38B5341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD131C2139B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531D17C61;
	Mon, 29 Apr 2024 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGIrzxdk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB517557;
	Mon, 29 Apr 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379838; cv=none; b=kIRXpwytpDsdq1gnGeOcZa9Kk2TQlbxP+rCN0GVuvPGh7K23zpAa5MvN7dsPsSsBMLoHNry2W/1VKPUh78kfcgMPD4/PGEdz94N2gvtNIW6WJC0bq5XbLnd88oiC4+S4ugDw3K3r1z0i0wuon/jWnDQxYu/LTs/svrzxUhQ5Voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379838; c=relaxed/simple;
	bh=wvIMnndAQ3VWmI1jPWw87xltZ8AbQuL9XuVFQeg1mPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbGPFUjKGYZIJkKy/zC/Ckp4ED6hEsP6B/kNmfNybx2817anQYx9SvnytRJK2SSRZiiYNCb1nJ29SuWANEbAmNnd/dzi+L7OTiKYkewSPrrmlq5ErKo0arG1m6XvwO2I2S0EwJSXkMnlhnuy7AlCpKxDmooPw3QPeH5b0yGrEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGIrzxdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4638C113CD;
	Mon, 29 Apr 2024 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714379838;
	bh=wvIMnndAQ3VWmI1jPWw87xltZ8AbQuL9XuVFQeg1mPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGIrzxdkuk9JaZVZO15FaSpqdBS7p/5KsEdQWg5fi58DRDSekQ+ZlEAmr9DIqxU1I
	 672S5rbsFmyx5SjHuSHiJSxzVU3voluSfY3NLVmQIrSRFkZS0HJJShY6vWr5V5Y8ib
	 jyxkE7IAP45CSll26mobfAsvZ35E9CjTfHJJFpYrxTqtno0MOCwBSA3GQXpTYoAW0S
	 m7I8tdrb6PKjyKkJJ52fHhLa6TT2Hh47bgEH5LY8P/kiTbF6FLxmfHxf6Gb4xTCx2S
	 4ftlS6/yfamnbzfhjPXAWT1gYstKsG5dSjD5txGIm8Iy/EU5yEcnPB++0Sx02KJsSH
	 JxuJ0616F1Vpg==
Date: Mon, 29 Apr 2024 10:37:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] bcache_register(): don't bother with set_blocksize()
Message-ID: <20240429-turnus-posaunen-795cc93151a6@brauner>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211007.GA1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427211007.GA1495312@ZenIV>

On Sat, Apr 27, 2024 at 10:10:07PM +0100, Al Viro wrote:
> We are not using __bread() anymore and read_cache_page_gfp() doesn't
> care about block size.  Moreover, we should *not* change block
> size on a device that is currently held exclusive - filesystems
> that use buffer cache expect the block numbers to be interpreted
> in units set by filesystem.
> 
> ACKed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

