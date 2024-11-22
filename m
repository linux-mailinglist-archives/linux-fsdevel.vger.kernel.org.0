Return-Path: <linux-fsdevel+bounces-35566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291AB9D5E13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55710B248A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BE1DEFC6;
	Fri, 22 Nov 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptf2RCld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46A1DED4A;
	Fri, 22 Nov 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275084; cv=none; b=pFqjUhpdXWWInM3GptVXouIHz8DvacNuqyAEAWgh2P6qXuFf/NdM5GzT95l/MNhoYYVKxrN3hB5tCwQFAr4B642zosSl0MczX4yuScLQaFNO28sQnIHkZCwL5NUcjIquAisBjnhgDxdUZZ6Q67ZwiUI4YzJgb7QGelwKmKRKhdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275084; c=relaxed/simple;
	bh=nL1fwObmR5aWAcjXqUw4jdRTWKBmpbBvUkZCZW9IoZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7cJWg4oRrEy4LzIZywD20esizKyOYpUiJySxcvMT5XrvTk/HSjj/SCVzAdilhC432TMgWu2AjDR2OMkTxK20OwqYNdybegntrr/GqVzXGf6WfsWkPoDyOrobPX/KgxetUCvfKSwtHZUj8LWWVT+yR/EMhJcbzLGmGF3qr5qP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptf2RCld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E076C4CECE;
	Fri, 22 Nov 2024 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732275083;
	bh=nL1fwObmR5aWAcjXqUw4jdRTWKBmpbBvUkZCZW9IoZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ptf2RCldkdWSffHdTscx+6Cg2j3kABnA7+5t+O9TB+MCxNnXvWHCVwputj74S45M4
	 QdCeUjhUrGVKMFLkHf6CKfnwrbY/7d8CIrRInFzJSNxB1uS5G+31aT1Ylx1SJ5srC8
	 fI+BqVfpk37HlxNXmZ/Y5/s6wIUkTUz5x2xGDnfS2x/e6NBksC4iZiE5vkrI2/M73O
	 x/3PwqNlZhzZrLx+U2YKz0rD0jK75kQfUCnpPYavJavqu5lo9kvbBoSJWa8M/EVyOV
	 al4R/fJBeZtOd7DAqLOl2rk64FMC+MufP53udIhX2IbbgT2zNs6fohpVsSTJGyMxI0
	 tIwrtTOTuyeTw==
Date: Fri, 22 Nov 2024 12:31:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Yun Zhou <yun.zhou@windriver.com>, stgraber@stgraber.org, 
	cyphar@cyphar.com, Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	mcgrof@kernel.org, kees@kernel.org, joel.granados@kernel.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: add pid_max to pid_namespace
Message-ID: <20241122-hinten-sesshaft-5951878d9374@brauner>
References: <20241105031024.3866383-1-yun.zhou@windriver.com>
 <20241120-entgiften-geldhahn-a9d2922ec3e0@brauner>
 <Zz9E0pGTioTcH32m@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz9E0pGTioTcH32m@tycho.pizza>

On Thu, Nov 21, 2024 at 07:33:54AM -0700, Tycho Andersen wrote:
> On Wed, Nov 20, 2024 at 10:06:27AM +0100, Christian Brauner wrote:
> > On Tue, Nov 05, 2024 at 11:10:24AM +0800, Yun Zhou wrote:
> > > It is necessary to have a different pid_max in different containers.
> > > For example, multiple containers are running on a host, one of which
> > > is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
> > > it requires the global pid_max <= 65535. This will cause configuration
> > > conflicts with other containers and also limit the maximum number of
> > > tasks for the entire system.
> > > 
> > > Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> > > ---
> > 
> > Fwiw, I've done a patch like this years ago and then Alex revived it in
> > [1] including selftests! There's downsides to consider:
> > 
> > [1]: https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com
> 
> Thanks, looks like this patch has the same oddity.
> 
> For me it's enough to just walk up the tree when changing pid_max. It
> seems unlikely that applications will create a sub pidns and then lower
> the max in their own pid_max. Famous last words and all that.

I think we should revive Alex series. Not just because it has selftests
but afaict the implementation is a bit more robust.

