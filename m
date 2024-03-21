Return-Path: <linux-fsdevel+bounces-14962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46E88576C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 11:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE26B21234
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4565676E;
	Thu, 21 Mar 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXhjj5eh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455AC42A90;
	Thu, 21 Mar 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016836; cv=none; b=f6GwAeKETop5adZ6EqlwSEKwJHhJzt/4W9BXKT2tXYYBfhLN6lR/xkAhaKhiK0OGCx7ivPd+/7wdTgL8JnyrQ7s0holoN8Q4xa6PQEYIDm+WgR6Z6QiE6KZCmFKArPEEuJ/JXb5BdhF2sQiygHlxwJ9LOzu5697ZkMZ1P2N9aOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016836; c=relaxed/simple;
	bh=1zhtiodWEJoBSN8q4xfdcx9nEtiNLQzorvlVQQqLSsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqY5o7hiOhECyadn+tH/kqJo4plfggLEZSqhvTkH4l3ZcQmchIDCd8cKO+BnAQz+JKk1mGByc3QyRvl3d0Emq/gNfyIHbTUGun0kb3L5hwLdT5y+lXM9pwGZcI4yDtTP9MzuFu+i5T+QfGgh6+i1axPRA0rhKVwhzsZOEWeEYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXhjj5eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A50C433C7;
	Thu, 21 Mar 2024 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711016835;
	bh=1zhtiodWEJoBSN8q4xfdcx9nEtiNLQzorvlVQQqLSsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXhjj5eh/mThB4cbVBJAsIN0z7iK+TVDnlyTfiUy5nm95SoQkSoFDMnnMckphcXMl
	 HrwfMRQo8BTULlSYVHjYVgdcBtcgtBIwBKd/IcBMPVYfpf7ZEnGoG0g4qXssNQZh2q
	 tHn1RoXMXLbcQtR8mTcvDe4IAaitHsF/C4q+6sxiQk1XS4SzhC50rxDwJ6J4yK5cLT
	 ixiuvirVtP4Bmrfk+K6gPvfR0i+OQCFu5MhpGyOxxAj6gBrX7znm7jNNuV+D3erJvS
	 4uxGfQ6JLF/Dzr8chvL6JtSmBaMKHU8WJDddEP+jxAYyRk15wLAp+2frLtAk4zHtYb
	 ha9Mr+w07uMhw==
Date: Thu, 21 Mar 2024 11:27:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, it+linux@molgen.mpg.de
Subject: Re: possible 6.6 regression: Deadlock involving super_lock()
Message-ID: <20240321-ruinen-exhumieren-32b9e3fba6fb@brauner>
References: <6e010dbb-f125-4f44-9b1a-9e6ac9bb66ff@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e010dbb-f125-4f44-9b1a-9e6ac9bb66ff@molgen.mpg.de>

On Thu, Mar 21, 2024 at 10:15:04AM +0100, Donald Buczek wrote:
> Hi,
> 
> we have a set of 6 systems with similar usage patterns which ran on
> 5.15 kernels for over a year.  Only two weeks after we've switched one
> of the systems from a 5.15 kernel to a 6.6 kernel, it went into a
> deadlock. I'm aware that I don't have enough information that this
> could be analyzed, but I though I drop it here anyway, because the
> deadlock seems to involve the locking of a superblock and I've seen
> that some changes in that area went into 6.6. Maybe someone has an
> idea or suggestions for further inspection if this happens the next
> time.

Ok, I'll take a look. It might take a little.

