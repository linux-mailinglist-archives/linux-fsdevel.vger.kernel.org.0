Return-Path: <linux-fsdevel+bounces-50305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFA7ACAB6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3883B5E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4E1E1C3F;
	Mon,  2 Jun 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/bQqgF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64A2C3249;
	Mon,  2 Jun 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856758; cv=none; b=MVmiRnoiK7VNw7tW8XDZNVC2awvJF6x7oVf7wbX3v1Ej8BYv2Dfl0wxl1+IpqtdLjzeN/7Go8J/3xCBPcJk83s5RsT3cBJV3rtaGyvZaK0JR2D3iftM56YqC5Ned01KgiR1l+Dcvr6//J89k+4WYJB6IpoMQ1qwp++ydshKms50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856758; c=relaxed/simple;
	bh=nr4WqDvry9Cej4Mt316h/Dzw69D+4TInCxHLquLuXZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za9N0C7xWG0iESfskk+vr255t3GUWFJlU+CGLHBcqsHv9okAwNS+89ARHM1bAqd33VawLSxE2kD6pxewQNq6RyTCiuzKP7kxhaLGruSOZREIk0nnbMbqdUxrRMqaKvWKi1niB21wbixkDEjZGOoEpTU+z9dZEopRok0m3EppFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/bQqgF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7010C4CEEB;
	Mon,  2 Jun 2025 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748856758;
	bh=nr4WqDvry9Cej4Mt316h/Dzw69D+4TInCxHLquLuXZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/bQqgF/D2RMhGm2dsGYeYPHlX/2BpeQ+jCGtifH5sJXlzICBeiNAFBIKRuF2HRvL
	 BmYTwVWy08M+Dg8ye38PD44v7aAfkEg7ctXRbjzRXEF/qdnObtlDr3ImqQfI87qaJ3
	 cNqaIZ6zgs1NPnmPgdnqiVZfmwDKwA9ct77XcGzruvspCMdpbXUWF7D8ePweEiiYNx
	 5pKzOUsbXd0LyRc5L9jkbtZX1gyQ7XzLbyQYpZS2E7RmvkDA24gHX2OcFqXbxEiK1p
	 DknJP2rB9A1lm9w69qeB3cOaphrvnH7T1L3cYQFtfC9SHn5MdA7I3CO68KtVAB9zJ0
	 ERHbtYy+4ubtw==
Date: Mon, 2 Jun 2025 11:32:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Song Liu <song@kernel.org>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, gnoack@google.com, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250602-hagel-poliklinisch-922154e2202d@brauner>
References: <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
 <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
 <20250530.euz5beesaSha@digikod.net>
 <20250530184348.GQ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530184348.GQ2023217@ZenIV>

On Fri, May 30, 2025 at 07:43:48PM +0100, Al Viro wrote:
> On Fri, May 30, 2025 at 02:20:39PM +0200, Mickaël Salaün wrote:
> 
> > Without access to mount_lock, what would be the best way to fix this
> > Landlock issue while making it backportable?
> > 
> > > 
> > > If we update path_parent in this patchset with choose_mountpoint(),
> > > and use it in Landlock, we will close this race condition, right?
> > 
> > choose_mountpoint() is currently private, but if we add a new filesystem
> > helper, I think the right approach would be to expose follow_dotdot(),
> > updating its arguments with public types.  This way the intermediates
> > mount points will not be exposed, RCU optimization will be leveraged,
> > and usage of this new helper will be simplified.
> 
> IMO anything that involves struct nameidata should remain inside
> fs/namei.c - something public might share helpers with it, but that's

Strongly agree.

