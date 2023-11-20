Return-Path: <linux-fsdevel+bounces-3214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E67F1752
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9613E1C21044
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC31D6AB;
	Mon, 20 Nov 2023 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNGwgPd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AB1D537;
	Mon, 20 Nov 2023 15:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E8BC433C7;
	Mon, 20 Nov 2023 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700494240;
	bh=UVmN0hmXR6hm5zs5mIu0Z+2I8RDP0YAu3/dYG11DvY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNGwgPd8T++zK/cxNPLbGd6DKXiNNH1F+ooM0LWcI37tgqouwioi3ZLtUbj1Ek+v5
	 +ORGNdjE0fFfYNkwUx/9jRBpr+Pe46KPy9kdfdYMs/XQQv5PWuW2etkHEW0TJUahuq
	 fWxQ30/2e7wsGUSxWefSfH6aAGH2btBNLkyzHf9H4jYOjbzXNydPobNDaz2EFmPxd0
	 ZwNYHgTETVNJ+DZzFsxuB/zSsfbUaFGtKhZsZLlqyq73GhY3wUNTybYVpnbdSEvge/
	 qREC7k5BGz9o3c6JcZdJTJn7agN+bd1UU7aMl/2oYwsLZtVmWqbHSWazHbTzXxsxuh
	 YDyIQQohlqILg==
Date: Mon, 20 Nov 2023 16:30:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
	linux-man <linux-man@vger.kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
Message-ID: <20231120-erklimmen-endrunde-fb17c5f6f3b3@brauner>
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
 <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
 <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>

On Fri, Nov 17, 2023 at 04:13:45PM +0100, Miklos Szeredi wrote:
> On Fri, 17 Nov 2023 at 15:47, Florian Weimer <fweimer@redhat.com> wrote:
> 
> > The strings could get fairly large if they ever contain key material,
> > especially for post-quantum cryptography.
> 
> A bit far fetched, but okay.
> 
> > We have plenty of experience with these double-buffer-and-retry
> > interfaces and glibc, and the failure mode once there is much more data
> > than initially expected can be quite bad.  For new interfaces, I want a
> > way to avoid that.  At least as long applications use statmount_allloc,
> > we have a way to switch to a different interface if that becomes
> > necessary just with a glibc-internal change.
> 
> Fair enough.
> 
> And that brings us to listmount(2) where I'm less sure that the
> alloc+retry strategy is the right one.  I still think that a namespace
> with millions of mounts is unlikely, but it's not completely out of

The limit for the number of mounts per mount namespace is set in
/proc/sys/fs/mount-max. It defaults to 100000. This value is globally
configured and thus can't be changed from e.g., unprivileged containers
but it applies to each mount namespace.

What glibc could do is read that value and cache the result and use that
as a hint or upper limit. That'll waste 800kb potentially but that could
be solved with a cache.

Alternatively you could add a basic listmount() glibc function and
another one that's explicitly there for handling large mount tables.

