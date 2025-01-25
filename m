Return-Path: <linux-fsdevel+bounces-40105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCDA1C284
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 10:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304F87A334B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16B1DBB0C;
	Sat, 25 Jan 2025 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGRnD05v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432A1C5F0E;
	Sat, 25 Jan 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737796950; cv=none; b=VdAGv6WgpRIz0BYLL0W0jitrMuEPECZiLbPXF6emG0oc0BZGcNM8i42aTF+11lz6K1FHnhD6EIvtmo+pTXdYE4L3gg+YJRajI7FmsM4ctjS5xMtkQvp098i00SAsOo0pUoFea9hhrf2Lq6MNOb11bvU+4niUZoGjMv3dY7JQaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737796950; c=relaxed/simple;
	bh=cqUlUk2k5pKbHBcnRD85SRBc5qNEMVL84HeU65uNupg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymmmsml7csN3U8paROmzcR5DrwJV8imZGUzMYqTXc7Hn0/8a2e/nUAqZBsrTZVDVvZMgKpFdzzK4zpqo4oKDWWVkJzgnh6OGPqbZe90odb3t9BqBUfsEtreQ8Oy1ulKaYkiNUeB+BbhihTkrFafLADqOjBpNCCtHDYUgIVlF1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGRnD05v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7622FC4CED6;
	Sat, 25 Jan 2025 09:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737796950;
	bh=cqUlUk2k5pKbHBcnRD85SRBc5qNEMVL84HeU65uNupg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGRnD05vmKrclL+x7ivQhXL3r/RRgSwiinN0LaeCaVh8PmEL/ZHYjcaEO1E1j6uiS
	 Z4nGsHnt4FnkbamCXo3UfCe1lkQdxwSzG88l9UJXadXovBcwIGkUiD91enJy706BWv
	 6Ir/L1KEwPutdMf2Zslv2dC7MfHd98neMa6gMXpTBdDmL/jl/lpceXcaK7C767pMUB
	 lC+UxQlLoNn/G60ZYu7SBTSD9W64A1hOow3jUpz8g/v2wweJRtlXJMDnpsF/5TVBdF
	 hQ8KT5RRr6oTS3gNvkIevCrcCYnweO40H8kZJ0XQkqa1nFUoEYMGnh9f52sX/ybxa8
	 Mwef9jl0Obivw==
Date: Sat, 25 Jan 2025 10:22:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v4 4/4] vfs: add notifications for mount attribute change
Message-ID: <20250125-gesessen-gerutscht-0a0468193303@brauner>
References: <20250123194108.1025273-1-mszeredi@redhat.com>
 <20250123194108.1025273-5-mszeredi@redhat.com>
 <20250124-abklopfen-orbit-287ed6b59c61@brauner>
 <CAJfpegvK9Q_uE-O8HkzzjeNh7nZ_sO89=OCyw_SZCudfXbB2JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvK9Q_uE-O8HkzzjeNh7nZ_sO89=OCyw_SZCudfXbB2JQ@mail.gmail.com>

On Fri, Jan 24, 2025 at 04:49:28PM +0100, Miklos Szeredi wrote:
> On Fri, 24 Jan 2025 at 16:38, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Jan 23, 2025 at 08:41:07PM +0100, Miklos Szeredi wrote:
> > > Notify when mount flags, propagation or idmap changes.
> > >
> > > Just like attach and detach, no details are given in the notification, only
> > > the mount ID.
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> >
> > I think this is a good next step but I would first go with the minimal
> > functionality of notifying about mount topology changes for v6.15.
> 
> I can totally relate to that.   I added the fourth patch more as a
> "let's see if this can also fit into the current framework".
> 
> > Btw, if we notify in do_remount() on the mount that triggered
> > superblock reconfiguration then we also need to trigger in
> > vfs_cmd_reconfigure() aka fsconfig(FSCONFIG_CMD_RECONFIGURE) but the
> > mount that was used to change superblock options is only available in
> > fspick() currently. That would need to be handled.
> 
> No, if we'd want to watch changes on super blocks, then we'd need to
> iterate all the mounts of the superblock and notify each.

Ah, I remember that old remount had unclear semantics where mount
specific and superblock specific options are interleaved. So we would
need to notify from do_remount() on mount specific changes. Right, then
this change is correct and I agree about the superblock part.

