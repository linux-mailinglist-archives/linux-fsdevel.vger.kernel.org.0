Return-Path: <linux-fsdevel+bounces-21256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E072B90089C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A69BB27386
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C026194A5F;
	Fri,  7 Jun 2024 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JODtRKuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669615B133
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773678; cv=none; b=eJlQecwgRFGiPLU6AY7qhgBO7VLkd6YnlpdQ7W7Q0gsaHzpCrfDcn08CjGkAamuDk2DbPNfVgNNxfgJif2sm0pdrZvehO0YYTo05cAsH2nxwNhJ7FABNlkcUSBlSvQJJTPqBhkMpa3UhHoOAyk3quZArpfcTcSLriWaBPFlW24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773678; c=relaxed/simple;
	bh=jwBNhKE6vD+qwW1ngN7H467ReTUWxy+D+I2d3KwNIIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZeFo7q5yPLdAFxlAl83cj3eHE1fzt/St/BV7Xh2VYUb3R84CwDvcQIt19lVn4cCuv60nivHhHmthbwTNvN8KxI+khofyX4DOIreEUeDXMCpLeI9NVKoIFIGguxUHMWNiPHOgexV7xo2mo2ptOt42MVeYEDDE/AkVhc9n6ImtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JODtRKuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED1DC2BBFC;
	Fri,  7 Jun 2024 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717773677;
	bh=jwBNhKE6vD+qwW1ngN7H467ReTUWxy+D+I2d3KwNIIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JODtRKuzQX8i0vX0A560z/1pKTcb8zDcbFJGTKjiJ/V01/Dec26eDnUIL/bXr9vwA
	 7TGQPywVHr1ZGSVAZhdQC1EGxG6pFTRowPSH0mAnUUgAVQd++Vcwgfp1WAjyUFz0OJ
	 A8LRvO3PTHDUjEBPnl+DDlZEbGDfcWywfyIPZzxVNbQVHfoO6uFaru3BGBlMg7BL0O
	 XohO0hkShd3CpBqcZj8FfTxmjnEQBWaYRoMKDTzHZT+RQ0jmacRdjvvPtEsjTbg/1p
	 D37vd58h6yne/DyZKZ8UfjyN8zHsKdAlG9wOFWEwyCWSNT2Hb1bZSwL2TI3pNkaJaF
	 lVtrZVtjqhMZw==
Date: Fri, 7 Jun 2024 17:21:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 09/19] css_set_fork(): switch to CLASS(fd_raw, ...)
Message-ID: <20240607-bildverarbeitung-unbeobachtet-bbb7866b6140@brauner>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607015957.2372428-9-viro@zeniv.linux.org.uk>

On Fri, Jun 07, 2024 at 02:59:47AM +0100, Al Viro wrote:
> reference acquired there by fget_raw() is not stashed anywhere -
> we could as well borrow instead.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

