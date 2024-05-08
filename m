Return-Path: <linux-fsdevel+bounces-19025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EF28BF717
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95171F22558
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2932BCFD;
	Wed,  8 May 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDpTbF2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769515E86;
	Wed,  8 May 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153537; cv=none; b=cdRp3raxAcKdr6zZq+4VuHnZRxdDGZXLrX14Fn4U2p5IzOUmN1KrcFja/p0mqHHbmAnlsRpGAnoYEPzf5FDtu5hDBCs2Mb2Xt1Ue1a+7Q0yWPy+/Ggect5n8bd+HwWn6iptGmoCdHhGLZwuQdrTSUcUfLCnEcCgPzagrLf2z4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153537; c=relaxed/simple;
	bh=5xjdvgZ0qfVphG4RYVX/Wl6O8KYdPOuRI8itJoQ9NB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX8tZVPUoaQfsnP4qUhYUslyYhdjovf9oS02RLyjmAgotv5sALitDZ0ClH9Wpdi1nVkkXja0zKFzw6roWp2iBRBN/d9EMCMaY9EEmQHcLq2Z4aeIFjGoekpbgg9R4ow+GjweJ7uJsUef78xNGi+vN/BazcKj8ojuIv+ddSMPgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDpTbF2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF425C113CC;
	Wed,  8 May 2024 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715153537;
	bh=5xjdvgZ0qfVphG4RYVX/Wl6O8KYdPOuRI8itJoQ9NB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDpTbF2R7n6xJrz6oUW8BeA7alylXQTyeEEhkebELa2sOQHOd4ajm+bMy5OIOCvNz
	 1hStICxUX6R5/aVAYbO4dMLZ4tnd4CdymL8ucPoAS2UslNeA2iQu+xZtLdoJ/VAT5K
	 sSWbYcb1TRZUELjMSfilF32Pu8z4xDqD+wnWzSU8zj5Muw7JplHkZqZB+GqAa2Wk45
	 4w0UKLZLdSF18ontN/S0AU86gATAAxL0iAHeHr/noM59Lb1coc9bgEjFaX5FT/8JiE
	 u7Rg25nbooDQhX49NECdavcvcxIsJliuuK9iOfr7hNdI2/5oWrftsRtowQPOAgWMZQ
	 rsjQj+csP3lxw==
Date: Wed, 8 May 2024 09:32:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Stas Sergeev <stsp2@yandex.ru>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Message-ID: <20240508-flugverbindung-sonnig-dcfa4971152e@brauner>
References: <20240426133310.1159976-1-stsp2@yandex.ru>
 <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
 <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
 <20240507-verpennen-defekt-b6f2c9a46916@brauner>
 <CALCETrWuVQ-ggnak40AX16PUnM43zhogceFN-3c_YAKZGvs5Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWuVQ-ggnak40AX16PUnM43zhogceFN-3c_YAKZGvs5Og@mail.gmail.com>

On Tue, May 07, 2024 at 01:38:42PM -0700, Andy Lutomirski wrote:
> On Tue, May 7, 2024 at 12:42 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > With my kernel hat on, maybe I agree.  But with my *user* hat on, I
> > > think I pretty strongly disagree.  Look, idmapis lousy for
> > > unprivileged use:
> > >
> > > $ install -m 0700 -d test_directory
> > > $ echo 'hi there' >test_directory/file
> > > $ podman run -it --rm
> > > --mount=type=bind,src=test_directory,dst=/tmp,idmap [debian-slim]
> >
> > $ podman run -it --rm --mount=type=bind,src=test_directory,dst=/tmp,idmap [debian-slim]
> >
> > as an unprivileged user doesn't use idmapped mounts at all. So I'm not
> > sure what this is showing. I suppose you're talking about idmaps in
> > general.
> 
> Meh, fair enough.  But I don't think this would have worked any better
> with privilege.
> 
> Can idmaps be programmed by an otherwise unprivileged owner of a
> userns and a mountns inside?

Yes, but only for userns mountable filesystems that support idmapped
mounts. IOW, you need privilege over the superblock and the idmapping
you're trying to use.

> 
> > Many idmappings to one is in principle possible and I've noted that idea
> > down as a possible extension at
> > https://github.com/uapi-group/kernel-features quite a while (2 years?) ago.
> >
> > > I haven't looked at the idmap implementation nearly enough to have any
> > > opinion as to whether squashing UID is practical or whether there's
> >
> > It's doable. The interesting bit to me was that if we want to allow
> > writes we'd need a way to determine what the uid/gid would be to write
> > down. Imho, that's not super difficult to solve though. The most obvious
> > one is that userspace can just determine it when creating the idmapped
> > mount.
> 
> Seems reasonable to me.  If this is set up by someone unprivileged, it
> would need to be that uid/gid.

