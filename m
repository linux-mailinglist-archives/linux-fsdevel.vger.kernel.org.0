Return-Path: <linux-fsdevel+bounces-6113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCD8138D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56BB1F216AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7EC675BE;
	Thu, 14 Dec 2023 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN906fd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9765EBC;
	Thu, 14 Dec 2023 17:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB98BC433C7;
	Thu, 14 Dec 2023 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702575541;
	bh=V/fbxsK7q1OnjNdRchrl8etLwYN7DQR4SahFULXkoe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PN906fd563Q8HLlx91Hl7Dq4NFroiwUoyofjLvvPbk2wF8OvvtszM8A/AK2ycUTu9
	 BCGTLKaNEXbHvuKgeDjkYKLjeKmpeUiBOWK96sZbof20gqWp6ViVkE34qDhIr57LYd
	 PfDssee2KM5WkvGXQ4xbH5nLcyFE66ZPnBYXx9JW+LPGbdE3WoUAqQNRPKfOXQiWZG
	 obXvXu919sT/jBR2ZQdEqZJDo5bK8UTvY1E6dG/ur1BvAt9Tg2/tm1oMTfGfZAAg8I
	 WzpZqyvZrb+/Vn+1TFd3opBt6eFsiLJW6N7lQLYtAnKJEVIFjn0gui03KHzZNyWM0b
	 aBgPhDFE2qA5g==
Date: Thu, 14 Dec 2023 09:38:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Tony Lu <tonylu@linux.alibaba.com>, Karsten Graul <kgraul@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D.
 Wythe" <alibuda@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <20231214093859.01f6e2cd@kernel.org>
In-Reply-To: <3d025aeb-7766-4148-b2fd-01ec3653b4a7@kernel.dk>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
	<145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
	<ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
	<20231213162854.4acfbd9f@kernel.org>
	<20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
	<3d025aeb-7766-4148-b2fd-01ec3653b4a7@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 09:57:32 -0700 Jens Axboe wrote:
> On 12/14/23 3:50 AM, Christian Brauner wrote:
> >> Let's figure that out before we get another repost.  
> > 
> > I'm just waiting for Jens to review it as he had comments on this
> > before.  
> 
> Well, I do wish the CC list had been setup a bit more deliberately.
> Especially as this is a resend, and I didn't even know about any of this
> before Christian pointed me this way the other day.
> 
> Checking lore, I can't even see all the patches. So while it may be
> annoying, I do think it may be a good idea to resend the series so I can
> take a closer look as well.

So to summarize - for the repost please make sure to CC Jens,
Christian, Al, linux-fsdevel@vger.kernel.org on *all* patches.

No need to add "net" to subject prefix, or CC net on all.

> I do think it's interesting and I'd love to
> have it work in a non-blocking fashion, both solving the issue of splice
> holding the pipe lock while doing IO, and also then being able to
> eliminate the pipe_clear_nowait() hack hopefully.

