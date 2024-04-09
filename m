Return-Path: <linux-fsdevel+bounces-16425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B389D571
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C81C21A69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485F8173B;
	Tue,  9 Apr 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbv06Xq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233C7F7EE
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654595; cv=none; b=ke2l8rbDLfzV1MdKi5LQgZArBWSpYOmg3tIYR6uJsAGUhyjzWyxcyw0DZDzLUoAK5T+fxaN8WqncO7FGb8bmvT9/v8OHAPICTflxAiIAW9ace4txHqjcWyJjVLVjK9FT2k5sNFHuY+4JzAuc43xnDeN25PVXlKBeWAZ9AbVXnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654595; c=relaxed/simple;
	bh=gq6fRfbMwvIXpNSzZQRgcJgPBB2+AbfERCKttsRKIcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upP4aVW5sKgpSrhxL6hbtTmrgKjUkDtVlbIgwY7/LaxcBgkDrPdndXN0i9kt0DVzVx2qObWpikRiDt+9AL4UaREn5bljxnkPzgo2B4Ym8z7LoehOgAn3QCRoBi/4pRlTYzuj6wsGlcZCbYJt2M38xeq+UPUKZbvm8Od8CGA1+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbv06Xq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAEDC433C7;
	Tue,  9 Apr 2024 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654594;
	bh=gq6fRfbMwvIXpNSzZQRgcJgPBB2+AbfERCKttsRKIcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbv06Xq0V4tqRDWMeTgz58QaE1SYgdQDmDhByZFIlVTxK/fUFzWiXtSwGLcteAeS8
	 Bkc9MsRnu++T4klfW2NMMNSgIwjZ88BFAQoZaea/2hk//yiOzTxK5UZTkHeG7ZzxSB
	 QHRZUCQAynd5a4DzN+vmVV1uabExB5y/efH7bCj/n8TxRF9F04H2SLj0w9teLUyS25
	 cStqkgZLW92EfYESuxaCKnxz5X4p1XxCAdLJ7RgAOZdK92LdeyhlzdwEr0DjfoxQaI
	 qcOpaqaGu0gDhezq5TdNbrip3bXs02Y0vsIFdJj3DSqINgqqQByYe1mG/2Lx4YCZM/
	 HIphwe/58YKqA==
Date: Tue, 9 Apr 2024 11:23:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 3/6] get_file_rcu(): no need to check for NULL separately
Message-ID: <20240409-umbenannt-mittag-ed0610f466fe@brauner>
References: <20240406045622.GY538574@ZenIV>
 <20240406050033.GC1632446@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406050033.GC1632446@ZenIV>

On Sat, Apr 06, 2024 at 06:00:33AM +0100, Al Viro wrote:
> IS_ERR(NULL) is false and IS_ERR() already comes with unlikely()...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

