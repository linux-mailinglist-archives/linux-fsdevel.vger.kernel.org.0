Return-Path: <linux-fsdevel+bounces-1239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A47D8217
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 13:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465FDB213DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7B2D7A3;
	Thu, 26 Oct 2023 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk2h5Uz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A927156CE
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 11:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59818C433C7;
	Thu, 26 Oct 2023 11:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698321325;
	bh=D9/erz5wIDl8ZD7B+g6bjxN0QtGzc/vjTrcDjTWJqPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dk2h5Uz+A6LPJnd6Rls5lyXluKElnQwzweXn3SB6FAF60nhhNdWluRz4s9KumY6hL
	 BmTxrdU6ZSY+RxHmGVCmsL7ds12TLrGAnphkR+1R5SVQp82+PEKYdhJpPAQo/PolRE
	 0BXugSv8Ku/9VYG1YeSSzQBKFIyi38HcMf1Rtw7MXRkozBHLNlq+QGlbFBquBJxMqk
	 9HjnnjBsdRaL6WYYvDeVgGrkUmCLpA94ekdDrMV90hk9SfwT0FTFCoR0uTubq6uyDR
	 lgBaBEXJLaDnaGQJYfjafCt9CbfWwWBa9ydiWE739cKCbP4peWeZh2Q9sbgymllxMj
	 KEKqc4AizLOWg==
Date: Thu, 26 Oct 2023 13:55:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] io_uring: kiocb_done() should *not* trust ->ki_pos if
 ->{read,write}_iter() failed
Message-ID: <20231026-sympathie-lecken-1ebc61f94b6e@brauner>
References: <20231026021840.GJ800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231026021840.GJ800259@ZenIV>

On Thu, Oct 26, 2023 at 03:18:40AM +0100, Al Viro wrote:
> [in viro/vfs.git#fixes at the moment]
> ->ki_pos value is unreliable in such cases.  For an obvious example,
> consider O_DSYNC write - we feed the data to page cache and start IO,
> then we make sure it's completed.  Update of ->ki_pos is dealt with
> by the first part; failure in the second ends up with negative value
> returned _and_ ->ki_pos left advanced as if sync had been successful.
> In the same situation write(2) does not advance the file position
> at all.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

