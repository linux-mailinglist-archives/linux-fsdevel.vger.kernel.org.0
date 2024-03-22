Return-Path: <linux-fsdevel+bounces-15082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E18886DE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA83FB2214C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC3846449;
	Fri, 22 Mar 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am38FD+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15245BFF;
	Fri, 22 Mar 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115810; cv=none; b=mkWXBGfzD8+Fn9DutK8axHyGHWZ0uNMw+sCjvg4t1Z6NmUoGaTRwuJsnGUCs+nsyLIEBWsnumsCFGu2OQY1Jrh/wu8Qoh1owF1Gxcb6oWqJ+8ayjwuyzxDJw9+fcyn7X5EIqIP5bWEqUrGAU+6iwQ1es7UISN4CVWf8x2IiX3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115810; c=relaxed/simple;
	bh=3GjkxtEAJUZaEY9C8yUt6EFSeE4ihCL5ryBVtmtcOqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeSuhZSUTUcdMo2Dwf1utO8aVvo6wISPN6ZGqy2LzxTS1WPeECMwwdynSme9KQjXU/yLF0OqOMppr5fD7/DWZAByowinhTEpcEcuOcYlf9MJckTw2+OTwmBdrX4/AFF/CkN34lnGguzpRv6RjPNiy/3aaI583NoPRCCQNByG4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am38FD+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4137C433F1;
	Fri, 22 Mar 2024 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711115810;
	bh=3GjkxtEAJUZaEY9C8yUt6EFSeE4ihCL5ryBVtmtcOqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=am38FD+of+uFGB2s1MpchvW3TIdwV791yB56kw7plMsHM0mQPLSY16LFQ4W/LIDHn
	 hoAZJYtSgnFaCipQ0n/hP0NPyElPJI7ov44mK6XA/bY0VlBPi2A+86YWbRXdtmpYeo
	 YnDB7M62pq5d9mTAnvSqddT3KNUxmcE7mFFF5xjLyz5d33YW2I3etFegKNDsiIxzee
	 uWeUMNsR9NyYoVTM7NUXhp9WwD/DB6xMEElmoaPT8VcvqTDDV4BRPk5lkICiuVqZC8
	 RTs7kgKIyykMQRC9jYWcbyMaxJKDSWn0U6NPdW48cl0TGMhOOSj20HK/+u9SkJsH9Z
	 LRUmcJKqihkOw==
Date: Fri, 22 Mar 2024 14:56:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240322-geteert-simulation-d5f56dac2289@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <ZfyyEwu9Uq5Pgb94@casper.infradead.org>
 <62e6oefgpa5gj4xipmu6jjohkyl3bqcufcvfa2vn3tnyfwpmi2@oh6c2svzixxl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62e6oefgpa5gj4xipmu6jjohkyl3bqcufcvfa2vn3tnyfwpmi2@oh6c2svzixxl>

> Christain, let's chat about testing at LSF - I was looking at this too
> because we thought it was a ktest update that broke at first, but if we
> can get you using the automated test infrastructure I built this could
> get caught before hitting -next

I already do automated testing. This specific error depends on a new
config option CONFIG_BLK_DEV_WRITE_MOUNTED which wasn't reflected in my
test matrix. I've fixed that now. But I'm always happy to have the tree
integrated with other automated testing as well!

