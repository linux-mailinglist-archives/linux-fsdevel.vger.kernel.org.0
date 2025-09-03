Return-Path: <linux-fsdevel+bounces-60183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663EB42855
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CE01882C4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA626340D81;
	Wed,  3 Sep 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHsSKIzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E93376AE
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921762; cv=none; b=ifyFpxWOxJg/DKGyuH4Lu3i9kXdgT8PszbEa8Eh+xxg2M4dNmF1JbuSuTJaGeyUlHHApNOBO0OiiWYHg/zt397h/RjmIVVeicTTODmzXGDnepDdwbHZtZ7ZlZLaa65qqKerZNPgeKHKEfotHqzwVc4cLn2MdBon1gojzaq7hla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921762; c=relaxed/simple;
	bh=Lp9PPmakAELVcoUcA1IfpUotCWc2ASEQyFo7D3jyXvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+BLHYL2p6Vl5jiV9VVrYy3X5AACZLB5dH9YWDxGkqyir+x+B9/VW6T8kQOFcTpQPqYBJbkgJzzvIqiY0TfkM6xsxJCeKDRoB7dnTgYi2ebDFrCpGnR4HHDSQrLCe00466XSZGLNuuwpYyhUDV3yGF365zKtVgpx1VgeRlPppgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHsSKIzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F47C4CEE7;
	Wed,  3 Sep 2025 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756921761;
	bh=Lp9PPmakAELVcoUcA1IfpUotCWc2ASEQyFo7D3jyXvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHsSKIzQVgKqwLfIoF4Oy17nWVnJkcrPod+wErcCXDQP2zQR4u50q7VHsXywhbvhK
	 XO5DLrD7raf0m6UdMa8u/XjHXtdDAFp6BzDsbiYvn/tmI0llXld/MC3T4jEYpMpDA7
	 xJtPhBMIWdM4dm15rUH5y8jIiBtz8dIkVkkyrk9VMDeSxLtr+tGcZPGx/Mq4hZ9owa
	 NzKeNnhF8wAysnn5q+lSVqjWPZyj+vV4URX68dfS9qNf9aUvwSjP2yPjCr8xT46hlv
	 1/srdt2QykE5T52iJhhDPYSj+zTfgE0dxjN6GPb768nkFgZTnTW0vJGnuA1ZMAc4hF
	 f254XMehx5n2Q==
Date: Wed, 3 Sep 2025 10:49:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250903174921.GF1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708588.15537.652020578795040843.stgit@frogsfrogsfrogs>
 <CAJfpegu3YUCfC=PBgiapcRnzjBXo8A_ky6YiGTYaUuxJ=e1jmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu3YUCfC=PBgiapcRnzjBXo8A_ky6YiGTYaUuxJ=e1jmg@mail.gmail.com>

mn Wed, Sep 03, 2025 at 05:45:27PM +0200, Miklos Szeredi wrote:
> On Thu, 21 Aug 2025 at 02:51, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Create a function to push all the background requests to the queue and
> > then wait for the number of pending events to hit zero, and call this
> > before fuse_abort_conn.  That way, all the pending events are processed
> > by the fuse server and we don't end up with a corrupt filesystem.
> 
> The flushing should be dependent on fc->destroy. Without that we
> really don't want server to block umount, not even for 30s.

<nod> I once thought it was crucial to flush all the FUSE_RELEASE
requests to the fuse server prior to the server's ->destroy method being
called, but it turns out that's not true -- all the open unlinked files
created by generic/488 actually do get cleaned up even in the !fuseblk
case.

It's just libext2fs that's somewhat stupid and leaves dead dirents all
over the root directory, which (mis)lead me into thinking that the
unlinked files weren't being cleaned up correctly.

> I hate timeout based solutions, so my preference would be to remove
> the timeout completely.  It wouldn't really make a difference anyway,
> since FUSE_DESTROY is sent synchronously without a timeout.

Hrmm, the timeouts waiting for FUSE_RELEASE might not be so useful
anyway.  If someone configured a request_timeout then the requests will
automatically cancel if the fuse server wedges itself.

OTOH I don't set any request_timeout in fuse[24]fs because they use
FUSE_RELEASE to free an open-but-unlinked file, and that can take 45min
if (say) you have a file with ten million extents to free as part of
freeing the file.

I think the problem here is that there's no way for a fuse server to
report back to the kernel that it's making progress on a very long
running request; and that the kernel probably shouldn't trust that.
In the default case there's no request timeout so the kernel will wait
forever.

In any case, I think I agree that the time_after check isn't necessary.
Either we trust the server to be making progress (and do not have a
request timeout) or we notice the connection died and move on to
aborting all the requests.

> Thinking about blocking umount: if we did this in a private user/mount
> ns, then it wouldn't be a problem.  But how can we be sure?   Is
> checking sb->s_user_ns != &init_user_ns sufficient?

I'm not sure we can -- what if you mount a filesystem in a private mount
ns, but then some supervisor process adds another mount to the same sb
in the init_user_ns?

--D

> Thanks,
> Miklos
> 

