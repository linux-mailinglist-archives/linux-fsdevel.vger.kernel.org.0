Return-Path: <linux-fsdevel+bounces-74301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06904D392D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 06:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03784300C17A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B129286D53;
	Sun, 18 Jan 2026 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDl4YANf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459E1A3179
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712452; cv=none; b=WRTFyR3P/I/WzV0Db8PQi4JJvv4gxXE1txyH/kGb4Lcxx4zO3bDHwuYLFpn0BVjUV6rZ5ZfJO25W70iDhVC+9A2TPMLHZzio0aF8xJCCH5SpnbFkXR1eMdVDo7HadwO3ZeOP7dGhvgG1njSP1WWu8Mo3QGcj7LEryoB0YUu51b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712452; c=relaxed/simple;
	bh=Jxz0U2iInqPaGuQypiXJ692Xhx4yWPEcUw6KprqSRms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYWVWT9IqrugKe88qjzdFZL/T94I4Wd2q1iHMAp6WypQu8lC2FYyRYmyAYk2UpRrAxM8PSs2MvjwA5pEAVYKkdcD7B32/cUZhnXnUNov1FmOa7z3esbF0kcRbtRSAYCfBpzBr7W5ey23VjnEZRcmr2dSYQykzmnABhp9WMcicuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDl4YANf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1A7C4AF0B
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768712451;
	bh=Jxz0U2iInqPaGuQypiXJ692Xhx4yWPEcUw6KprqSRms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YDl4YANfwv9Gw6Zg0ZgMUSI6gJLj+yGINm3BDsKQBhPr6j/jjGiSj/2XKOu+QPoS/
	 Pq6ooY6sEvAWVD4fZmRcTgG9vse9mlt0xV7keTi/wng8s4smQorBST6kENVqBVZPzd
	 SB28xXPU3ufxzWxSmAxvJGW+IJP7kGaL9irUaicUhUKxXbVhG3DU1MXuUmgIG8/7dS
	 r6bWwsBw4ceyY9N7qaBauRF6m115+9+ZdxpnX1uiyx/a3fqGYoxk1IkZeA5DVo9oZH
	 TB62unR7mBsoEbqh/3cUmEfjRJCSgEIh294F1e/93MUEUq7eCVelBy36i2lE0fxJqI
	 qSFDiP9ZpPsEw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b876798b97eso529515966b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 21:00:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4QsUqijdRkSv1OP9wnFfyjxra8ICTPqvrXhtdpCxwpRgcML34blLlhirRPTA34tAXl/pVi2o5MPK1m0Rr@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnyh4l1ZunoZHLI4ZlsFbzXpfJd1icTOcDPLiIr5VfNLdKEiv
	62VRyCtt/fKOoLHHE6LXDRDkWKX5G48GCBEG39CbniepqKRXRaKtg+z6bmh2UNks92mQ583YjqL
	SzoNjOYQ0d/aW4Wy5VNaHC673xb1w2b8=
X-Received: by 2002:a17:907:268d:b0:b86:fd46:72f with SMTP id
 a640c23a62f3a-b8792d489f3mr607472666b.10.1768712450081; Sat, 17 Jan 2026
 21:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-10-linkinjeon@kernel.org>
 <20260116092138.GA21396@lst.de>
In-Reply-To: <20260116092138.GA21396@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 14:00:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9JqbBiZK077KwzjWXYM0Gk-qKEPv_1mre9Wqv7kUBuew@mail.gmail.com>
X-Gm-Features: AZwV_QhwGV6N6o2-7FvFrOkveju13gDOgvB4ewMdwCLGZ_zeN13mqpqAfVf-qMs
Message-ID: <CAKYAXd9JqbBiZK077KwzjWXYM0Gk-qKEPv_1mre9Wqv7kUBuew@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] ntfs: update runlist handling and cluster allocator
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:21=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > +     for (index =3D start_index; index < end_index; index++) {
> > +             folio =3D filemap_lock_folio(vol->lcnbmp_ino->i_mapping, =
index);
> > +             if (IS_ERR(folio)) {
> > +                     page_cache_sync_readahead(vol->lcnbmp_ino->i_mapp=
ing, ra, NULL,
>
> You probably only want to kick off a read for -ENOENT here, and not
> any error?
Right, I will fix it.
>
> > +                                     index, end_index - index);
> > +                     folio =3D read_mapping_folio(vol->lcnbmp_ino->i_m=
apping, index, NULL);
> > +                     if (!IS_ERR(folio))
> > +                             folio_lock(folio);
> > +             }
>
> either way, this seems like a nice primitive for doing reasonably
> efficient reads from the page cache, and I could think of a few
> other places to it.  Maybe factor it into helper, even if you keep
> it in the ntfs code for now?
Okay, I will update it.
Thanks!
>

