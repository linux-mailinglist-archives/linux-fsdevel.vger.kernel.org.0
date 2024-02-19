Return-Path: <linux-fsdevel+bounces-12040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07E85AA8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1542830DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467347F7F;
	Mon, 19 Feb 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTtQeVug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530944C89
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365953; cv=none; b=OhIsPrirAZdUiptZI3dPsYQ6ocogbUWNDOtmH0wrpM90I6B4Nw6CFE57bwwttaPThLXg8cKTxCEYYRFBmbciUG/3dQjF5gZIA+LqnsBkLU/Ya7UIZHZkRvKmUdhKnuw/pOalRChCHmrkA00Nkv1z4V7fA/YN3L5N1Q6mw3J6Gv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365953; c=relaxed/simple;
	bh=OfLIj5TjlBX8MqzaK4BSqXD+nVAtPaxxaAbH9mSACZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMSY2lXxR3cAKExFlyABVpFZK9KG+ksORPtruJjgiDFckR6bogpyiL8o7SXjwM8B2yaU77bFdAGI/3msBBvCJkn4/vC+zBFRD3dbHsCoEkGuCQ4eSgPSxJtxo/NrkGd8Wy+9I+25aEONJbEPCrx4nddxCHU+61JcADAySiUc604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTtQeVug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50827C433C7;
	Mon, 19 Feb 2024 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708365952;
	bh=OfLIj5TjlBX8MqzaK4BSqXD+nVAtPaxxaAbH9mSACZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTtQeVugd1TEsUGr/qi+yU2hSZgqXnRBVBP+WWOBWRQQr1A4IrDgLHXNhQaEzMvRT
	 wwzFYg7/EtdjDJfkzu40zAICvfxJ5mjDbDmZh4QSueJ5Km3yIKzu1lNNbsLNCCRTdF
	 HBAPlAPbrPEMJuyhnr3o2T/WkPmwfcf2K37h04SMYNNaSPKk5UiJDX9v/UoF9uK4ZA
	 ca+hXv0CjYp4rIxTGFlIZbuVLV0PZmTAKnJPbcRh9DwzCLkk8pFwA0gFoacXexlZJJ
	 IEwjhDSV2x0DXEBwHPmsnbxqzr+JuJJZ/302PJIFyhO2BjML0PBXPXwGnT3aKpOlT8
	 zzlYulZVP7CSg==
Date: Mon, 19 Feb 2024 19:05:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240219-parolen-windrad-6208ffc1b40b@brauner>
References: <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
 <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com>
 <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner>
 <20240218-anomalie-hissen-295c5228d16b@brauner>
 <20240218-neufahrzeuge-brauhaus-fb0eb6459771@brauner>
 <CAHk-=wgSjKuYHXd56nJNmcW3ECQR4=a5_14jQiUswuZje+XF_Q@mail.gmail.com>
 <CAHk-=wgtLF5Z5=15-LKAczWm=-tUjHO+Bpf7WjBG+UU3s=fEQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtLF5Z5=15-LKAczWm=-tUjHO+Bpf7WjBG+UU3s=fEQw@mail.gmail.com>

> Fairly straightforward, no?

So, I've finished the series today. It took a while because I wanted to
hammer on it with stress-ng --{procfs,pidfd}, run LTP, and then do some
other tests. It survives everything now for over 24h. There were a few
bugs as expected in the first draft.

@Linus, if you're up for it, please take a look at:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.pidfd

The topmost 6 commits contain everything we've had on here. I renamed
pidfdfs to pidfs and all helpers completely mechanically. The rest is
unchanged. At the end we have the conversion fo path_from_stashed(). And
the topmost commit implements your suggestion. Let me know if your ACK
still stands.

