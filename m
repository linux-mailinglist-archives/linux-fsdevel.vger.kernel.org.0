Return-Path: <linux-fsdevel+bounces-10302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFBA849A20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638BB1C22D53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D849A1BC3B;
	Mon,  5 Feb 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYYKABlK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DE1BC2A;
	Mon,  5 Feb 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136080; cv=none; b=iXb13FHY7GEdnmRzqPxmQZ0yyuehyopK+myGkCbyWRR9VMj0DO5SPeZcUuzFV1Qa3ZSh1t8dRFflMQSo8v7DZYQGqly1H+/Ha53aHeOrrvlmB/q/J17ITTWu34ysrfsBhfwBmWLkFHRT7hnaAjU1aeILU7aHZxcCi43zDqKZ7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136080; c=relaxed/simple;
	bh=RKPf8kkr32aRIXh/yMQJha3cALSjOW0Xvoobpu3PQ9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8XJjmNv+VtJu5V2xGtzQvSwOjwTbM/RJ+9eY2QdzVADzGRxZg/LAXarhL/ijwicy+5xF9ZhBgNfJoiH3v+3LRyH390oYLoydVxmDpwSJwoWrhSJ9xF5mNbR5oL6e98t9/Yn3TJYhmHPgB3KF1P1F8waoOoenwiJKaaESvPl4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYYKABlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EC0C433F1;
	Mon,  5 Feb 2024 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136079;
	bh=RKPf8kkr32aRIXh/yMQJha3cALSjOW0Xvoobpu3PQ9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYYKABlKNaNTUjNG6Vg+3WijT2Hgs5IX68pFABMhEeMl+SMqVKbTr638rRxoUwv06
	 HH+nsujlcftjw2R9Y31kcQyEGk/xbAxO0vcbS07iBdiFOnqE93VrfFLYTKIVGFxRLA
	 6xZbQnXQJKMFcp2B7dCQhiRmEKaAFumRRti4Rv3lflTsswQXj1CXcrAOJZGxZNKDr0
	 6DOWsfcCqYwvTancUhrafd1j0LX4yhaFIekc3MY1ZCD2pOKcSLpSb6p+ToPOsVP6Pl
	 QWay5MNEz/WEOrAxBW3BwP4juxVgj3UWE7YMupfcihuRlxaSGIqAHqXvQxlwURqsTg
	 U9gwnKPueaHfA==
Date: Mon, 5 Feb 2024 13:27:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 05/13] hfsplus: switch to rcu-delayed unloading of nls
 and freeing ->s_fs_info
Message-ID: <20240205-endung-verjagen-d9db2027384a@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-5-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:31AM +0000, Al Viro wrote:
> ->d_hash() and ->d_compare() use those, so we need to delay freeing
> them.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

