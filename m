Return-Path: <linux-fsdevel+bounces-8344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E1832FC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 21:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D611C242E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 20:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A75730C;
	Fri, 19 Jan 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGJKHlfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3B1D683;
	Fri, 19 Jan 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696303; cv=none; b=iFv+Jy0ATfCtMpTPmHRT1z3fvyn33tE6WINOQWxX7SpT+xz+tZe0oimfb/pUNQlqCJj+mdIH5E0hJ+ZS+za21NnRQOO89HfZsmyLDgmdrfy9v4VvF9CytHlQfIFHkzg6gHcjzPOiVjWsKeAGElAJ7i91omJFIXXpR80OgwEmc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696303; c=relaxed/simple;
	bh=T+iusoCf36oS0nV4RUdsIgsydjZH09SrGeZ9RB2ukiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJmqvaYWhkBonivH7nupgKF5NGJsipj7Q88661orZ+1OLEWkn3VcI2SwKZ/LoBNk3CW2UYbO6JCkDrqEzmOnM8vg0ik7TMcIs6HTygz90GDX5GNtpGLo6wBYbt1hx8zqeSFG6ukP5kK/yJ4ZGBpSd4FLb5Z9J1vHzKfsU6PiY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGJKHlfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AF5C433F1;
	Fri, 19 Jan 2024 20:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705696302;
	bh=T+iusoCf36oS0nV4RUdsIgsydjZH09SrGeZ9RB2ukiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGJKHlfAlypNehD5+0vNY/Sy6bqJ/A4R4u/+M1jv22XzcXOIr67js8ZQqTu8W6/7U
	 XY3yg+3uUMMFD7oxLxcKWnD+o/BESFcP0NAzzTquoCY26ufXKkZIjhYUdr2ktL3Fiy
	 t/FmWQNL09iNjl31KmuXAflH4Mz1PhH95YJqL87hDLAEPM+J2Dtu5jrfnoBUp6K66d
	 lGbIHKsotWOUCnIuBHCPNYiDqELzFcxAARxRncatMU8AMt5jprrMS9GVT3AXfKQ6TE
	 HDNgZB/xnxsJl597kfhdxcX3NXkG0P8oCMQpVayUUSV5HjVEhPjF2VvNKf86dMvP2W
	 XHrSUIEsXYMsA==
Date: Fri, 19 Jan 2024 13:31:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZarcKxcaG87VE5XR@kbusch-mbp.dhcp.thefacebook.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>

On Fri, Jan 19, 2024 at 04:24:29PM +0000, Matthew Wilcox wrote:
> It's probably worth doing another roundup of where we are on our journey
> to separating folios, slabs, pages, etc.  Something suitable for people
> who aren't MM experts, and don't care about the details of how page
> allocation works.  I can talk for hours about whatever people want to
> hear about but some ideas from me:
> 
>  - Overview of how the conversion is going
>  - Convenience functions for filesystem writers
>  - What's next?
>  - What's the difference between &folio->page and page_folio(folio, 0)?
>  - What are we going to do about bio_vecs?
>  - How does all of this work with kmap()?
> 
> I'm sure people would like to suggest other questions they have that
> aren't adequately answered already and might be of interest to a wider
> audience.

Thanks for suggesting this, I would like to attend your discussion. If
you have more recent phyr thoughts (possibly related to your bio_vecs
point?), or other tie-ins to large block size support, that would also
be great.

