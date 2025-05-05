Return-Path: <linux-fsdevel+bounces-48088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D3AA950C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832FD189A31F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B28325B1E0;
	Mon,  5 May 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWnYWv38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4725A2BF;
	Mon,  5 May 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454006; cv=none; b=tws6/sSCOjItHw2i8yLoryM4Tqx+jNKLYiGdir+H+NO6hGLZ5BqiFE9sel+6ZWOqKajmHZ+7FgjzWEPuv6ehsbrgXDp51r1XzoFx4w97X7inToM94qdH76WGYV/rh+dnBk1eSM5+5DdqwBVIe8sf+plkV5kr4Gv6DnmEcQQWvBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454006; c=relaxed/simple;
	bh=tiOVGzbXZsmK/lbrWFEkbAM9Lo9QAadJp9dBa3dETKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCfOlHMddvFE9gyMoRmzVQ7DBoX5y3km9aG+UgLYNbldy36SRCUlvMvIAaP6NC9dbl90Nl1+zPDn1gxPvXKgnajl7Cb3NQW+m5zAsdR3odjDTy7sTF8jG0FZzGH1qpqro9pUpzetb51U17V8pSAmmL0pXL0sx5sVO3aB5q5/NGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWnYWv38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3B8C4CEE4;
	Mon,  5 May 2025 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746454006;
	bh=tiOVGzbXZsmK/lbrWFEkbAM9Lo9QAadJp9dBa3dETKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWnYWv38lkOrJokGeMoYnsTL8ILDfoKqnE9TLcp4XdUwplg/qizt1VScxaAKeSCqr
	 VAVfT5WnxG39LbUQI29MF6uFk+U3mUc9wERqZexoh3VTAFN2HsW3JOFpQjzLBHb4av
	 RbVasBgMiDWTA4eK9sKpf0tZ8cmHAFbWiRKTuSIwQYX1YQR4d6kvYU7t7YdrC581up
	 NnvI7nKwpk6o4ZnDwqWLtGhHXjOPoffHdM9PpepUBHpL1Klk4esPdr5j+FyfI7CAFH
	 0hpVAtHLOwC8pVHZo7UFkoHtykTX3zsECXiuFxPVyGl2S30G8HGMBEVY0aE58/4sLY
	 ribpa11beZedA==
Date: Mon, 5 May 2025 16:06:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow
 coredumping tasks to connect to coredump socket
Message-ID: <20250505-dompteur-hinhalten-204b1e16bd02@brauner>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
 <20250505-work-coredump-socket-v3-8-e1832f0e1eae@kernel.org>
 <CAG48ez3UKBf0bGJY_xh1MHwHgDh1bwhbzMdxS64=gHNZDnNuMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3UKBf0bGJY_xh1MHwHgDh1bwhbzMdxS64=gHNZDnNuMQ@mail.gmail.com>

On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> On Mon, May 5, 2025 at 1:14 PM Christian Brauner <brauner@kernel.org> wrote:
> > Make sure that only tasks that actually coredumped may connect to the
> > coredump socket. This restriction may be loosened later in case
> > userspace processes would like to use it to generate their own
> > coredumps. Though it'd be wiser if userspace just exposed a separate
> > socket for that.
> 
> This implementation kinda feels a bit fragile to me... I wonder if we
> could instead have a flag inside the af_unix client socket that says
> "this is a special client socket for coredumping".

Should be easily doable with a sock_flag().

