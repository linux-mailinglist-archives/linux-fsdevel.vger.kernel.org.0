Return-Path: <linux-fsdevel+bounces-18076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E223F8B534D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CE128189E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A817BC9;
	Mon, 29 Apr 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqor1v/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F66171B6;
	Mon, 29 Apr 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379986; cv=none; b=OGF9YZ+ysS40vP8ef0BqnuqnaGvyywGrtu1DKsI9NgOBBpOUHFd8Agewtv+x5uELuHZTkJA16zEiIp3ZkCrgzjd8a92en7cYa6tqY7Serk6PJ6E6ptNxJ2btYW2EjS75KFHS3nFuXbtl3EZDKuc7nzX9affpq9XmnT8MRDGsg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379986; c=relaxed/simple;
	bh=bWX+7oaCxU8yNEuPuZA6tPBcQDP22tUGNF7qaMQi1XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqcVdV1bpLyOUAvoDORLzo8mgGfTEZsR4JKWqQ7Dke0CEpS+q/xmeYLE+x9eF/wMN8EyCjDTZ7yNT1ghFQATI7pYYNZYyIOrMCmyfZKP9bhiwbtE5yApfxnFUITsu5NJKWINuCufoENRcs5H6HBWW26JSvGMp31Qsce7ZRAwkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqor1v/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B91C113CD;
	Mon, 29 Apr 2024 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714379985;
	bh=bWX+7oaCxU8yNEuPuZA6tPBcQDP22tUGNF7qaMQi1XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kqor1v/HS/EOTXGWLSYhx+yfbg5mAgRBm010u8s5PZWEmcTKT1MupPxA6qMt/MaOT
	 cdlozODjHSWbzrngtuLA1TMbUX4lZZ/PORHPqOfX2N2hCPgjoOr4JYWrBoPUgGJXOw
	 SL6djGgd7WK8N9++vPA9KBHJVzGH42jqbll8szuMzHI57HLcMquORKxRjCSBK++LTT
	 5dHyhC49EJxldhPbuEbrQgYKGrkaZZHmU68jV5YFhk20Aa8pXe88LTuNkvmyvy+Q4q
	 7iGiN/ZLuO/KNmWm0w/7ZTFVYJGXvgxCOxCLNAbNq8q2bB2eHIfLjLNA0kKqj2qRy7
	 I/S44+qsuk9Rg==
Date: Mon, 29 Apr 2024 10:39:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
Message-ID: <20240429-raser-gasexplosion-2359e9bf0ab3@brauner>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211128.GD1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427211128.GD1495312@ZenIV>

On Sat, Apr 27, 2024 at 10:11:28PM +0100, Al Viro wrote:
> ... eliminating the need to reopen block devices so they could be
> exclusively held.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

