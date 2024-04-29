Return-Path: <linux-fsdevel+bounces-18057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE18B5089
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80081F2286F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2FD53C;
	Mon, 29 Apr 2024 05:10:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47232C8E2;
	Mon, 29 Apr 2024 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367433; cv=none; b=PEMV5NYx4k5drn6Ry/VtrNguXtJcNnNQWTsnIue8rgs0SK5t7cZmssF2pKl0Yvmk0/UjWg9qFNLS8/VOjsXG41pZXcQKMtmKenawr8AvUuWtcPKeXFD1IVAEcsblZ4Ui40Ncb7eeQ7aNcqGr2dUM+tn4KRD5Z7R+zdAAQi+3agQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367433; c=relaxed/simple;
	bh=ht14nJOOZwy6sCJls5A9p2dT3u8OmOQO7Wg6Gz5Rzmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3+oSgbLLa+RP5Nc49fluBfX3QtXGjXW+0/98tM4LGC7Zvz+pMfEN319gtGr1NVrmOtfv1Fh2w8rsGxVlh20qSpeY50D9sFzytz44HdiEEcfdH4HkDaTWII3OM+JvszorwJAcU53rmUP8fx+UW0XFl+FmVAKQ5wEt1AccQcuVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2BFD7227A87; Mon, 29 Apr 2024 07:10:29 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:10:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
Message-ID: <20240429051028.GE32416@lst.de>
References: <20240427210920.GR2118490@ZenIV> <20240427211128.GD1495312@ZenIV> <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com> <20240427234623.GS2118490@ZenIV> <20240428181934.GV2118490@ZenIV> <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com> <20240428190709.GX2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428190709.GX2118490@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Apr 28, 2024 at 08:07:09PM +0100, Al Viro wrote:
> Christoph, do you have any plans along those lines for swap devices?
> If they are not going to grow holder_ops, I'd say we should switch
> to O_EXCL open and be done with that; zram is in the same situation,
> AFAICS.

holder_ops right now are used for fs freezing, fs syncing and dead
device notification.  None of this is useful for swap, as is the
resize notification I plan to add eventually.


