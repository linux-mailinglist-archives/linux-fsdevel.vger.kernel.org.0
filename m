Return-Path: <linux-fsdevel+bounces-73223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C652D12972
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48A5D301BB3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA6329C6B;
	Mon, 12 Jan 2026 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwYLIa/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76222258C;
	Mon, 12 Jan 2026 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222004; cv=none; b=aUMzBqZcJihFsxDvwHOXeu15B4iKnReHWH5gdB2+PF+VZVocLOy68MaATAxB2Msq1angI8dizASCAAHMwSt25zkX1MKsRp5fngYfamcAYzwVApLaDOsHfGMosBblqNEALd01GgVIPO0Ujf5NgNMGpt5XUQbtTSd1NbJf0PnM6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222004; c=relaxed/simple;
	bh=Yaur77UJWshlN4SFJ40DKZsCHZS5SiViKRjaHLlWch8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFh7bHa0M9deiFxxjNwvXvwbWUZ+se+6H35jzwWAaOE6MxU+gTQBf2Fwzvcr7ng5Ag014J15MQT3nQr82+BcHxOAiqSyCYqQWrKoVgM+nx1FUlLcXgSlZS03boqpIxpc0VSG4MaB8l+7F/7PKU8geRJjo7WggoCRQrExCxefdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwYLIa/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD7CC16AAE;
	Mon, 12 Jan 2026 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768222003;
	bh=Yaur77UJWshlN4SFJ40DKZsCHZS5SiViKRjaHLlWch8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwYLIa/ZAiJu9lNs1+HqdulvGkdyA6nlM8nRkou1F+JhDYbjt6GtPWDMgIfL8RuBy
	 0dqcTctcOyrYJ2rkNsNUcRdosKeE4QCakJ1WXj16jgosHzKzY7i8yhesdVt9jwBDwi
	 2M7tlSQt2ixlEbNC9fy1A8s4BNMLCW6HLleTybBYp/e5SeFNtYRHryBtRx+Wt/IIou
	 WSZHhvgctm19zAiahQRBiOVpcJ/24FrDoh19zLE+KPzzvqIZNtuDIvKLwbAvy7/PhL
	 hh1f1tLqZppS22hM3gLGqRTQSoqIRdZrFDXxFbBDw5eherr77h048cT2CPVwj6CRMk
	 OKdlW1G3R5gRA==
Date: Mon, 12 Jan 2026 13:46:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>, 
	=?utf-8?B?VGltb3Row6ll?= Ravier <tim@siosm.fr>, =?utf-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Sheng Yong <shengyong1@xiaomi.com>, 
	Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
Message-ID: <20260112-zuziehen-fallpauschalen-0ec870c7e5b5@brauner>
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>

On Thu, Jan 08, 2026 at 11:07:09AM +0800, Gao Xiang wrote:
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow when stacking an unlimited number of EROFS on top of
> each other.
> 
> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> (and such setups are already used in production for quite a long time).
> 
> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> from 2 to 3, but proving that this is safe in general is a high bar.
> 
> After a long discussion on GitHub issues [1] about possible solutions,
> one conclusion is that there is no need to support nesting file-backed
> EROFS mounts on stacked filesystems, because there is always the option
> to use loopback devices as a fallback.
> 
> As a quick fix for the composefs regression for this cycle, instead of
> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> nesting file-backed EROFS over EROFS and over filesystems with
> `s_stack_depth` > 0.
> 
> This works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
> 
> Essentially, we are allowing one extra unaccounted fs stacking level of
> EROFS below stacking filesystems, but EROFS can only be used in the read
> path (i.e. overlayfs lower layers), which typically has much lower stack
> usage than the write path.
> 
> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
> stack usage analysis or using alternative approaches, such as splitting
> the `s_stack_depth` limitation according to different combinations of
> stacking.
> 
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timothée Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

