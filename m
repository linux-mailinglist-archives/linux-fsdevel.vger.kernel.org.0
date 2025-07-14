Return-Path: <linux-fsdevel+bounces-54822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF5B03983
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3023516B37A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C85F15B971;
	Mon, 14 Jul 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZW0vQZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897A23C4FF;
	Mon, 14 Jul 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481457; cv=none; b=CwPqOGI+4lmQSbajG+EOALD3TzGo/LiB/Vx0f+uVmMVKTMVNtFyglVigzzwj8ogA+veCfBLNyXThICrDM4UrH6rvpAyl9VWp2wptRD7dMXSq7kqpteDQocqi86N8nm/w/9uHQRoC39kLry4779cnheynXch1p1p0ozB9+I0NBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481457; c=relaxed/simple;
	bh=whi7/4A/B3A092M26uoKP7rULCtRrrMYkOBXaT0EZDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zkc38O8bX44zAi+dvM+k72Khfil2jEsvDmfKid9cdcRoOi2HcX/2ePuIf1TNMpCE4Bm/XffG0Xu9k1ViWGUY2P7/9Wf4VwAxWbCR941HbjbOLd1MtVdUygzkT5tG0lC9D6vGSc3gs83JhG5Dti7q8jF1Ov49tsfm+wugH5M4rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZW0vQZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058DDC4CEED;
	Mon, 14 Jul 2025 08:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752481455;
	bh=whi7/4A/B3A092M26uoKP7rULCtRrrMYkOBXaT0EZDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZW0vQZdDxjaZXC86oUvhuiVdH86fcJscbsasFp8SEgO6OtWm8tkRNhz3mKkKBC1C
	 xnq9qKQ9vLoHu0Uv/Jw8s6D66rBhz+vvolpRx6/eayawNKT0Gmye8J3A/AAPgFvfdO
	 c0hFgPL4gxSLPjc4i9m/U0aySzaXWb1thWD2ROR5ertsqWV69ioRIi5KdPjZlfyj3Z
	 iFUO/pIfO6BoXQI4YBXVVopjt5J6Cjs9/AGq4jRej6jtWu9jngGv1YaJRD1fiFbTlW
	 Pa+wfCnxBsyNMMQXlwbjz8654bAIWXW8h1ktYIGSge6LiWI7wMsUGcVfhs1ILe0wdd
	 k7tVlJE1VHbIg==
Date: Mon, 14 Jul 2025 10:24:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH][RFC] don't bother with path_get()/path_put() in
 unix_open_file()
Message-ID: <20250714-digital-tollwut-82312f134986@brauner>
References: <20250712054157.GZ1880847@ZenIV>
 <20250712063901.3761823-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250712063901.3761823-1-kuniyu@google.com>

On Sat, Jul 12, 2025 at 06:38:33AM +0000, Kuniyuki Iwashima wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Sat, 12 Jul 2025 06:41:57 +0100
> > Once unix_sock ->path is set, we are guaranteed that its ->path will remain
> > unchanged (and pinned) until the socket is closed.  OTOH, dentry_open()
> > does not modify the path passed to it.
> > 
> > IOW, there's no need to copy unix_sk(sk)->path in unix_open_file() - we
> > can just pass it to dentry_open() and be done with that.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Sounds good.  I confirmed vfs_open() copies the passed const path ptr.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

I can just throw that into the SCM_PIDFD branch?

