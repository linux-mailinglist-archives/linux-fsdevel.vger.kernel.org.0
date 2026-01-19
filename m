Return-Path: <linux-fsdevel+bounces-74523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECED3B6BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C19C3023D38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FC23921D0;
	Mon, 19 Jan 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtfZTXUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C436B075;
	Mon, 19 Jan 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849566; cv=none; b=QJurA7WVFo6OFeajiexaQ9v8Wq+SvgFdHgwAbpHqYznAo+9oDvaNYOkN8z4yz7F3xOl+wuxd8e6AeqO9f2Csz8lrG0FxfQQW8agNrZ+4LqwnSNhAOIpdqq8KOPs6x86tvmRMZ+acy+0wIZIzvpFJO10pL6lRv4XaQ5AKT7Zs9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849566; c=relaxed/simple;
	bh=qwc08ec1OrctlmlBAKmKSTt74F2eGcEv59WaOb2w5eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAA2iqzU5KiOiyPVEanAVPJt+aueuDD9rIEU0i3X+l7d+wAvrklWx6Az6/Q+S3WtQTTTlFIt95xv6jIALgdec8gYK3+3M7OpAlPEqzupNOeMFSmxkWP50/LnrY9ag0eHgYLJhIBLuQMyl+11DY90MvidgTo7FS+z2N1FJBfGTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtfZTXUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B61C116C6;
	Mon, 19 Jan 2026 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768849566;
	bh=qwc08ec1OrctlmlBAKmKSTt74F2eGcEv59WaOb2w5eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtfZTXUqDM7feQgU5ZToqJgQZfAEbmvBY6pgybD43xWXMt5+0d1F/AgDFH0jYr3hN
	 Pv34MqMPrKVWxKgQxA0z0xO8T97+YdKXpxYk6pduxC2A9PoYfLeL6fDgupt3wQfjzS
	 r1XxlTijMiBjFLZMphMJtVvD+qfHuUItPnUWutZS57l6KjV+OeTtq3cuHYs3J+GH/h
	 PorU2xUi0AWmM8VF9IoYarXTtpg9RSEs166be/N2rOnQ4gsZCfXJIKV93gkLJV5LZW
	 2GcKQ1fLhawecTS6hTvIBY1iNsWS8OyaUpNnpTJsrGgkBruC/e4kIZLMpDLhm0gNgL
	 VDhQpjkvpFydw==
Date: Mon, 19 Jan 2026 11:05:36 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 4/6] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260119190536.GA13800@sol>
References: <20260119062250.3998674-1-hch@lst.de>
 <20260119062250.3998674-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119062250.3998674-5-hch@lst.de>

On Mon, Jan 19, 2026 at 07:22:45AM +0100, Christoph Hellwig wrote:
> Use the kernel's resizable hash table to find the fsverity_info.  This
> way file systems that want to support fsverity don't have to bloat
> every inode in the system with an extra pointer.  The tradeoff is that
> looking up the fsverity_info is a bit more expensive now, but the main
> operations are still dominated by I/O and hashing overhead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Has anything changed from my last feedback at
https://lore.kernel.org/linux-fsdevel/20250810170311.GA16624@sol/ ?

Any additional data on the cycles and icache footprint added to data
verification?  The preliminary results didn't look all that good to me.

It also seems odd to put this in an "fsverity optimzations and speedups"
patchset, given that it's the opposite.

- Eric

