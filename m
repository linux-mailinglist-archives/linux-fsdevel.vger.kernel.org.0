Return-Path: <linux-fsdevel+bounces-14724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AB987E5D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C1E1F2125E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52F2C1AD;
	Mon, 18 Mar 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8txPrXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785842C1A2;
	Mon, 18 Mar 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754297; cv=none; b=i5vwTdHAi+5AcuMDY2/hzgXNwkEp24AMaIXGSzFBOMeOpFrTiD5hKOgdulcmeEuCzJulu8ZDnMwFlqQamzFMzN3b35zOKX8ifi/GNkxb3LplQ1iWN65GO7wBPLuzMwVUraqnms35M4NgWULwOQbw3Xk4SedNILfF+us1sQ598YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754297; c=relaxed/simple;
	bh=Wv5XgnQMknYBIHZPwVPnV1WLFXNTUqJQsLd0N+JSBBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTWj66ETu+llOnZVQ4BUlMSly+bK6VtBMesrOnyHA9jyAz9maF0vCTkCEiQWwXSgLHyz0ms946ZUukrZSzxf/h/Bmn69qCf3IBZD8NV27LXd3n0FfKk5Z7ZmOy6fo3VZ59Ba0TFz5HzqaNfbYNhvJbNNsGeBmsXcraae+IaW/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8txPrXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39273C433C7;
	Mon, 18 Mar 2024 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710754297;
	bh=Wv5XgnQMknYBIHZPwVPnV1WLFXNTUqJQsLd0N+JSBBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8txPrXphMTQHclKlbYFFv8yFf5EB9y35fHu3d5Sn2WvglPXY1l+6oqg/KkRNRU1X
	 y04QxW8rmLClmevLpyQqDbYqmPetZAYskEhOpbNSbuVSKQqjaLLIkVEULULzYTuxl9
	 KWhIs9xVgbCdby3hyPtjlEJDcMd6cvvuP18QSu1Ms1TlCzXydmRp25alwHPLg+13YJ
	 xuwqbb1UJrtmVGkDb2GV1NMnymWcptgc8b/i1L7SEyckJoId+z+jHaW/9btMEC0yYi
	 Th4hf0Xz2oEXaWZA8xqAvgN3OH5b/WR3YE8kVkHbX/KH6ztUBlu395A4wh3phyn5q5
	 +UVNw3qAJFUxA==
Date: Mon, 18 Mar 2024 10:31:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: VFS: Close: file count is zero (use-after-free)
Message-ID: <20240318-verjagen-klemmen-b8430586340d@brauner>
References: <CAKHoSAsAt3hsZeqDBA6T_HkqgPWwrgmeBrZ+g7R5Wtw6auChKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKHoSAsAt3hsZeqDBA6T_HkqgPWwrgmeBrZ+g7R5Wtw6auChKA@mail.gmail.com>

On Sun, Mar 17, 2024 at 07:57:28PM +0800, cheung wall wrote:
> Hello,
> 
> when using Healer to fuzz the latest Linux Kernel, the following crash
> 
> was triggered on:
> 
> 
> HEAD commit: e8f897f4afef0031fe618a8e94127a0934896aba  (tag: v6.8)
> 
> git tree: upstream
> 
> console output: https://pastebin.com/raw/nWDbVZij

Generally it's not great to have ever more fuzzer generated reports
outside of the official syzbot reports.

And fwiw, your link isn't even accessible.

> 
> kernel config: https://pastebin.com/raw/4m4ax5gq
> 
> C reproducer: https://pastebin.com/raw/0ZSaae7K

That program seemingly to the mounted block device and your config has
CONFIG_BLK_DEV_WRITE_MOUNTED=y causing corruption. So that bug is likely
caused by that. Set CONFIG_BLK_DEV_WRITE_MOUNTED=n for your testbot.

