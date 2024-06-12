Return-Path: <linux-fsdevel+bounces-21526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7040D905198
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2EDB243F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4E16F0FE;
	Wed, 12 Jun 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePp/Cy0m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277E16D4D3;
	Wed, 12 Jun 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192891; cv=none; b=us0zQcoqmwF6zjp4zOvfWRJy5w+f7+xADQ0wZn0/zPBfK7tnMlyetLKDxTyo0XGnfRpRkZPOMyz9ZmA++PAlYym4Wg5+6yBJUr8tW463bSjeZMu9XoTcmP+MjETJuGpsAld50MI/WiG0LVEU2TVmUbwzV3mJVXthJHrvj1UKy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192891; c=relaxed/simple;
	bh=+5fRX/VuHHGoAI9oN7+6SerJZMyY5a5f+pHiSoygEuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEqT/a2fWgHJHosvmkD+o5MRcHi2IewWxWW6gS42dBl6A/3fGmELHG8kZ653LtnUOcVtpYoMxVZc85c0n4htiZY8c4H14epsUzUJlqk8kzFSH8mCdSQ8iU+QFV+59TEf0e/nL+2jBeVPG6K6Tq5I6wv7naH4i15HYkjU572PaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePp/Cy0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69710C3277B;
	Wed, 12 Jun 2024 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718192891;
	bh=+5fRX/VuHHGoAI9oN7+6SerJZMyY5a5f+pHiSoygEuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePp/Cy0ma1tw9W7mjqM1+MkKOU5Cq/8eNmXEJHlNp+ceBJeAwC+FX8ZzHuOKGV0P8
	 dyeDSLOc9mZq5SGPc3FJWcsgZ8CLVZs4TWU96Uqj8bQl+czgxrT57SZEzYpff7N5Oa
	 TM4uTrVPiEjDSkzP518roRrn+ukIfofzNUxXMY5yAC5i518Gj9pchsFtwrxG6l+h3i
	 2fmHTWiyNL8BRZgDdXMVJGLkwVvpw20g28yQeHijzSC3M/yKaNBDqk5Bn/s3dSJGpx
	 md30mJuHA5Wi20bTaRJnLunHmarBviaO7Ab7Vp92jFBZ+h8ozAcf0sDbM1k+Kg7HED
	 +y4lK4JQulXIw==
Date: Wed, 12 Jun 2024 13:48:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Subject: Re: possible deadlock in freeze_super
Message-ID: <20240612-hofiert-hymne-11f5a03b7e73@brauner>
References: <CAJg=8jz4OwA9LdXtWJuPup+wGVJ8kKFXSboT3G8kjPXBSa-qHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJg=8jz4OwA9LdXtWJuPup+wGVJ8kKFXSboT3G8kjPXBSa-qHA@mail.gmail.com>

On Mon, Jun 10, 2024 at 02:52:36PM -0700, Marius Fleischer wrote:
> Hi,
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
> 
> ======================================================
> description: possible deadlock in freeze_super
> affected file: fs/super.c
> kernel version: 5.15.159
> kernel commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6

I'm sorry but this is really inconsistent information.
The kernel version points to 5.15.159. The commit referenced right after
is for v6.9 though and it goes on...

>        freeze_go_sync+0x1d6/0x320 fs/gfs2/glops.c:584

That function doesn't exist on v6.9 and has been removed in
commit b77b4a4815a9 ("gfs2: Rework freeze / thaw logic") which fixes the
deadlock you supposedly detected. So, this must be from a kernel prior
to v6.5.

In general we will ignore bug reports from automated tools that are not
the official syzkaller instance because stuff like this is stealing time
spent actually writing code or fixing bugs.

