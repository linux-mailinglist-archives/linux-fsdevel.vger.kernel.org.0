Return-Path: <linux-fsdevel+bounces-10301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EEF849A1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D23E1F24E5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE591BC2F;
	Mon,  5 Feb 2024 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUEG5oas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A01BC2C;
	Mon,  5 Feb 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136056; cv=none; b=bF0Ds2jzLNzh1C4j1eXb9YtDWHr0R/tQA+Z4ugvA0nEFrnHhNSEj4UIekW6cpXyDybqZzBJ+I+IHtrwWQyU+eR/i2BjRbl8WzvA6dOo/xeP7puBOLWKqhFXxa6S20BlcEODJuZdGbC5LoQ9ySVpUFLIWB5WpXbjNNzyGb7g39IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136056; c=relaxed/simple;
	bh=nJ/nnlSkragXyTOmo6McsmZA0UzJBKHw10J1qbwURTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inzOlNKX2wQGg+tdD4vm3/BJPugmbK20g3bTvBUvC90HaXo7MJVzS0GkoAmub71mOaVbzijSHl7XLa0arlhbiWZD3hrraLhr4etkuvq1Oc6nAxXKYKhcKE1A1KSqoda8M7XHit/nUjumpJw/uYv79xSZTcD9xK9lqLxAQCeMVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUEG5oas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DFBC433F1;
	Mon,  5 Feb 2024 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136056;
	bh=nJ/nnlSkragXyTOmo6McsmZA0UzJBKHw10J1qbwURTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUEG5oasPhkwQER7wdC7h5vu8Z11xpTgVtgTuo0LQuV3rxlcz1x80nybh03Akeenc
	 UCKt6n9XpoogKF8etuEMHpVVS2Sc8yjI9UbB3Of2SSzQOU5yZl8bYVSlo4HBjsp4Rg
	 C/QPzV1jAeOe/dnuJeazG5aoTYXFfT4Ft+ysk8yJIJL0axlPZlInloAkHjQG6fBkvt
	 yD+wlG/Q6KHFo9/za4VOgFwTaEhjJJNCgzM9pzE6W+n5RpoXY+aoUpz2eKLQ2/RheE
	 qU580Yn/BIe4RBYOxfElXvz8c+OyqLxrVC/yLkFyqxwRXvJEZBwkIoeBoJqOMhm9+w
	 YqQV7WgMvSiOA==
Date: Mon, 5 Feb 2024 13:27:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 04/13] exfat: move freeing sbi, upcase table and dropping
 nls into rcu-delayed helper
Message-ID: <20240205-plant-seufzen-3c25de168ea8@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-4-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:30AM +0000, Al Viro wrote:
> That stuff can be accessed by ->d_hash()/->d_compare(); as it is, we have
> a hard-to-hit UAF if rcu pathwalk manages to get into ->d_hash() on a filesystem
> that is in process of getting shut down.
> 
> Besides, having nls and upcase table cleanup moved from ->put_super() towards
> the place where sbi is freed makes for simpler failure exits.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

