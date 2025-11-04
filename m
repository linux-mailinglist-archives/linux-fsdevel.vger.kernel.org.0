Return-Path: <linux-fsdevel+bounces-66930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3DEC30C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B1C18C2648
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC132EBDD9;
	Tue,  4 Nov 2025 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjxRGUvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786D2EAB70;
	Tue,  4 Nov 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256442; cv=none; b=fRl/o3heD+pp0smogX084MJmvAgIxYiMzApEVLz8d9zpa0loHukCPZlUWSksh8XX/pKRZAY6XvG16PLE1MgvsNahq/C7o0H7VHuzk40aYCkimtxCocCQAuQRhAh2arNkwzXB1b8mG4aHfs6yv5cmvvdCrfLmvHv+LYcLA6cK6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256442; c=relaxed/simple;
	bh=W07D7k8d9r42eIB9elVR5UyKqnAXxbxiWn376ofpzAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhNaOALMln6C4DVPsoNqEhl1J1C7OrpSWydmoYXAmvu/kRH0am3lCyIHyvA6b0i6/3uMWLLTNdlgynZ/dD20WFf9IgPN6MLHXTqrCjWdgBsCkbVQn4UZy/2CNFn1zsO420pa9gTIjJC/Uz2lwsFjSnvnc5mJd0jOoCwPveDz9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjxRGUvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578D9C116B1;
	Tue,  4 Nov 2025 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762256442;
	bh=W07D7k8d9r42eIB9elVR5UyKqnAXxbxiWn376ofpzAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjxRGUvsTz2TY9x558mHTIz1Ih91p9JqOFsGFSwluMb08sYCfC6Ta+zRipYa9vIQO
	 sibc5N5/8swj3yBcqMXzlZviupVerLGaz7oBWIfyw0edv8u8ZJoJ/Jad9Wfy3QYUTJ
	 WxUM9obfJfM21WpmvJzLl6YFVkGFkqwhWyuF/cDhSjTUDFTux0PggSbhNbsoGf3D7J
	 cXkQaq1eT0oOY29VqHb9Fwjpnefr6N/CoaJP2W9ISCdRcRvl8DTW4iG1YeYHw7WC6H
	 8U8SBPX4W5hp7daJ1pRBpbhJIzlkSSgVCiQid6fuR9ivcp6dJvC9HEt0z/VPCUfUVy
	 rTpA4nSfJZaqA==
Date: Tue, 4 Nov 2025 12:40:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
Message-ID: <20251104-hebamme-sinnieren-a30735196a26@brauner>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
 <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
 <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>

On Tue, Nov 04, 2025 at 08:04:28AM +0900, Linus Torvalds wrote:
> On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote:
> >
> >         /* Perform file operations on behalf of whoever enabled accounting */
> > -       cred = override_creds(file->f_cred);
> > -
> > +       with_creds(file->f_cred);
> 
> I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
> have this version at all.
> 
> Most of the cases want that anyway, and the couple of plain
> "with_creds()" cases look like they would only be cleaned up by making
> the cred scoping more explicit.
> 
> What do you think?

Yeah, good idea. I reworked it all so now we're only left with:

scoped_with_creds()
scoped_with_kernel_creds()

It increases the indentation for about 3 cases but otherwise is safer.
It's all in:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=kernel-6.19.cred

