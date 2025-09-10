Return-Path: <linux-fsdevel+bounces-60747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8FB511FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 11:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F217F1C811EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF8312834;
	Wed, 10 Sep 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7iHPOHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD6302CB4;
	Wed, 10 Sep 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494847; cv=none; b=IMTj1ZyxUjeCGzvLJVE6PCd6mJ+AhCvhtGcLIiPlgZlJ1imBWpo1UHkMm7hGmr5WQPV9kTDHhUuJwxLbZXKRzrONRdmevZSHI3ASE/Om1MLDcR9rOt5JcnIJD/vdnN8qoWlepeixAN+BAMg4Lmv14h7r3fcRwua5jr1NnsswNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494847; c=relaxed/simple;
	bh=4Xd4T9plZGNuzmetOyet7pXzc6rXYThTyeIFjtxyluw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIx1a/VrUeY9N8y1NbXT1GXPI4OcS1wPq7LbLUwTOT2pdDHPlSdbw3Shy0p7eAArQY/zmt/3lssryoMN2le1FGBfNk6QauWXSsmr3wi/Xwrb0nCTfvYsyujbAaZN7sKWKst+7Tu0b41/e/gKfy/fEMUh09EmvVMCQBof0IW96Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7iHPOHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC3BC4AF0C;
	Wed, 10 Sep 2025 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757494846;
	bh=4Xd4T9plZGNuzmetOyet7pXzc6rXYThTyeIFjtxyluw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7iHPOHbiKvNeVcrHURbrVeEG4lKrvJQ0BSkPjR/thoFGaMIknDuO4RlX5uIhaSQr
	 y7ZS9lbQ1+O68pa0QTIY5uY2H2XszCwjmKErRWUgiQta5JRWDNSFCTsWOdlIWZm+/h
	 fbQPu114XW8oqZ/bJKZE2WTGVpIJMADsyBRi3DWQ=
Date: Wed, 10 Sep 2025 11:00:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com, dakr@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] USB: core: remove the move buf action
Message-ID: <2025091007-stricken-relock-ef72@gregkh>
References: <68c118e8.a70a0220.3543fc.000e.GAE@google.com>
 <tencent_B32D6D8C9450EBFEEE5ACC2C7B0E6C402D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B32D6D8C9450EBFEEE5ACC2C7B0E6C402D0A@qq.com>

On Wed, Sep 10, 2025 at 03:58:47PM +0800, Edward Adam Davis wrote:
> The buffer size of sysfs is fixed at PAGE_SIZE, and the page offset
> of the buf parameter of sysfs_emit_at() must be 0, there is no need
> to manually manage the buf pointer offset.
> 
> Fixes: 711d41ab4a0e ("usb: core: Use sysfs_emit_at() when showing dynamic IDs")
> Reported-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b6445765657b5855e869
> Tested-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/usb/core/driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

While this fix looks correct, your cc: list is very odd as this is a
linux-usb bug, not a driver core issue, right?

At the least, cc: the person who wrote the offending change?

thanks,

greg k-h

