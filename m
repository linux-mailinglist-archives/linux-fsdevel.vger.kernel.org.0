Return-Path: <linux-fsdevel+bounces-9943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A58E846561
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A56B21D2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571F63CC;
	Fri,  2 Feb 2024 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OQS32+5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D1B5678;
	Fri,  2 Feb 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836987; cv=none; b=Au+g/P77U3sarP+GnE0l2FDuyJy7XxcyFVpyIkoaZ4EGeiqROjaWn+m/G3WhQRxSRBomHLkmdMBUnAklBhWTd6CNXYXwn1SzeF6nhuybZSuP/ZDs7zKla9T3yYQyM1Wth37HdNM4fT9NJ8ODYOUcH7xfQl+D6SF5qJb9IBVDcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836987; c=relaxed/simple;
	bh=O1HNcOSRVymO4MDjLMRr19qQpRWyxtwKCj+/n1K2RaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opOsHqvKRTqc6htou1PMLdHP0nq/3wU+hgN6B0JRUenAxNDT2QWV83WMWIzUrh5QfTOzlO9RnPLywzgC9YAlzv8VbjJA1YDu0hSnToxXfmgPbzOyjKSE0LEF078xEQ82xy4TwHcsmwSEQaHog2NpJToaFZLaKcLcU6kp4EpbaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OQS32+5B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1ZIT6+l1ZLIkY5DXwfFbHPuAQNZOi2QWA8dkeqdsXTE=; b=OQS32+5BonAVyWJcUHPZSA5zMj
	yAAE0gK6PYd+tHz2jwUuSHy92NNPK2K9DbV+9Sh6royxClCGX4mVVvXT5eLxdG0/7dlCp48LxhoCN
	Y6ndewMOQBTphwOv7nJkvq6T9AD0sjFS0OqKThpdB2IBUc8lCQ9g8aOIdEJMBoT65LBWV9PlcY8WN
	cmgit1qgAOiF2QFtF8qh4mRRt/ZP5oT24GvVTzNIpzLiQyo7OPSr5njQgBc5Hw6JLDU1bvMjZ9Inb
	rv6qFIXFx/8kC4FSSDV3NmuvW4HNdlnosd5BEUoXOHexAcpo7Y6+jr0Urv8YCJcwLf+76bMsXIyrx
	irhwq4jw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rViGX-003Z4R-1L;
	Fri, 02 Feb 2024 01:22:49 +0000
Date: Fri, 2 Feb 2024 01:22:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Douglas Anderson <dianders@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <20240202012249.GU2087318@ZenIV>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 01, 2024 at 05:12:03PM -0800, Douglas Anderson wrote:
> While browsing through ChromeOS crash reports, I found one with an
> allocation failure that looked like this:

> An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
> a surprise that this allocation failed on a system that's been running
> for a while.

>  	if (size > regset->n * regset->size)
>  		size = regset->n * regset->size;
>  	if (!p) {
> -		to_free = p = kzalloc(size, GFP_KERNEL);
> +		to_free = p = vmalloc(size);

	What the hell?  Which regset could have lead to that?
It would need to have the total size of register in excess of
256K.  Seriously, which regset is that about?  Note that we
have just made sure that size is not greater than that product.
size is unsigned int, so it's not as if a negative value passed
to function could get through that test only to be interpreted
as large positive later...

	Details, please.

