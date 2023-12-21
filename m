Return-Path: <linux-fsdevel+bounces-6633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C362C81B00B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6411EB241D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39815AFC;
	Thu, 21 Dec 2023 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7tjHuEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3515AD5;
	Thu, 21 Dec 2023 08:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA891C433C7;
	Thu, 21 Dec 2023 08:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703146251;
	bh=kokoN1WRX868iErZ3/hkDdFRzJiN84Zn+iSka3sWB6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y7tjHuEhGKqU4rAQgQp6+2vVsBmivXMAr3Ek45Yoi2cxsZPRaWZeDEMkDS9adusUy
	 JayEIySqLquF0XUl65GsUA2LCZgpNDTSGCiTdv2O+LZhwrqZlaGF0KTFJYNnVBVkzH
	 veQESjjIfRtzcXNna3DbVlJUqPqQjrQkihNa1oYE=
Date: Thu, 21 Dec 2023 09:10:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 08/11] tty: splice_read: disable
Message-ID: <2023122141-footboard-yam-433c@gregkh>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>

On Thu, Dec 21, 2023 at 04:09:10AM +0100, Ahelenia Ziemiańska wrote:
> We request non-blocking I/O in the generic copy_splice_read, but
> "the tty layer doesn't actually honor the IOCB_NOWAIT flag for
> various historical reasons.". This means that a tty->pipe splice
> will happily sleep with the pipe locked forever, and any process
> trying to take it (due to an open/read/write/&c.) will enter
> uninterruptible sleep.
> 
> This also masks inconsistent wake-ups (usually every second line)
> when splicing from ttys in icanon mode.
> 
> Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wimmqG_wvSRtMiKPeGGDL816n65u=Mq2+H3-=uM2U6FmA@mail.gmail.com/
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

