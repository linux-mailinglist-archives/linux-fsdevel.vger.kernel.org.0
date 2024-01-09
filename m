Return-Path: <linux-fsdevel+bounces-7634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA1B828B45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5931C20F50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65583B2BB;
	Tue,  9 Jan 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK2QhtKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9853B2A4
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 17:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84292C433F1;
	Tue,  9 Jan 2024 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704821411;
	bh=kJfb2pnNEuzIunWzicZ8GI6lWJLNDmACdR0f958F6uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nK2QhtKkffcmzMjTygB5uKnQA7gGBsbuqauKQ8KhzeaMfMYIJPR0tIr+zKC9Vl0vm
	 E+PDjQTU/eN2X49g56sG+2pJvgvmXISXfx7IFm3416M9LcHEH6RCpE0A/rmp5F9xsU
	 wLTIt/76JMYWUOZm68M3AIIY24r2W48dxmJhjAJlNHPM02DKFs0x6yWKBonsomUm1V
	 vO+SFnY5M6dUaVy6U4cD/0t4zWufFHCbPopeVxMLOmXCcgxrFuLFJBGAhi0IHE938F
	 Ih44DN7vgIWkGfnbqr9/qLiDVAKyxOxO8ty154sTWFtBtp+fouSzOGZ+Nqm4B2Jev9
	 J50p/2+fUvPzw==
Date: Tue, 9 Jan 2024 18:30:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Revert "fsnotify: optionally pass access range in file
 permission hooks"
Message-ID: <20240109-gitarre-zettel-5c9b772561cf@brauner>
References: <53682ece-f0e7-48de-9a1c-879ee34b0449@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53682ece-f0e7-48de-9a1c-879ee34b0449@kernel.dk>

On Tue, Jan 09, 2024 at 09:08:40AM -0700, Jens Axboe wrote:
> This reverts commit d9e5d31084b024734e64307521414ef0ae1d5333.
> 
> This commit added an extra fsnotify call from rw_verify_area(), which
> can be a very hot path. In my testing, this adds roughly 5-6% extra
> overhead per IO, which is quite a lot. As a result, throughput of
> said test also drops by 5-6%, as it is CPU bound. Looking at perf,
> it's apparent why:
> 
>      3.36%             [kernel.vmlinux]  [k] fsnotify
>      2.32%             [kernel.vmlinux]  [k] __fsnotify_paren
> 
> which directly correlates with performance lost.
> 
> As the rationale for this patch isn't very strong, revert this commit
> for now and reclaim the performance.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---

Thanks for tracking this down! I think Amir, you, and I came to the
conclusion that we can fix this in without having to revert. Amir is
sending out a new patch later tonight. I'll get that fixed by the end of
the week.

Christian

