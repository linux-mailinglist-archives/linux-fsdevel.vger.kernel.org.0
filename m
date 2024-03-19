Return-Path: <linux-fsdevel+bounces-14826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A947D880291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 17:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFBA1C22242
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE3134CB;
	Tue, 19 Mar 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Bjc+xpQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE90FBED
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866473; cv=none; b=KFM4PSNKuOSw/w1qKKTqiJmwS69wlHxANQ8AB0CzLnbHyAVHzhRZ3fihcNcpr90lTEzbAGM/6fTRuO+susx4Xe4c0PepzjL8hWRxSImSa9jHFxNLS757v/JrPTw7ifNmw0ipxQUZ+I0Lqm53xjebH+tJmUn4QAaXSuajeVxI55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866473; c=relaxed/simple;
	bh=nRp7+YyTBHw31NX7xj7EtsXhg3dkAR+p6w1ZMt+sOEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThEpqmgwh85lGDivYXOnw1GbijIkET8zgTgFNC7ANOMoAyn1Dcr6FhulTKQMdkgphbhmzfnXCc6/sY0QBYN5xhOcsZ4LmkFG7TnWAS/l7XadJNGxcqoT+JOmuFUtAL8Ph4fYHdTYepw0yhKUv7jyRjoKOLWCqh7KHbyTrsCesKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Bjc+xpQA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56ba72fffd6so328590a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710866470; x=1711471270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=Bjc+xpQAwY3z3fbUSs5mWFZqOgAsXiWOfTt2fETf32xVt5LGMFFT8BlXOVa1nShF4e
         u3hKGCc3sXooS8tjsd1KJrhLeAY0AsQHmlDDydrwglGH1JSvNWnPALsWFn98NxkI4Uc4
         VoScTVzsNWKZM++T29YZIQ9ySLCKZz1WGzusQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866470; x=1711471270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=L421e0hG6NND2mVWmj0ynle/jR/HWJyJyi8dGgw2ZeiwVI3X6U6CsRECcUBARrcTwd
         gEibTTgDnR0zVQCx3Uat2+K6vnITPq6CGLx2YcoOipWkhDpkWt1mMbw5DipaWUBZlyT4
         1bxffGh+eK6cLJyl9bfUTlJpBHGqOGyfORWJyhNzUsx1A4S24+Yhx3Kntjp/WcvFUmRv
         ZI3ouriG9MKDITaM42l7SjJ1FnT+Tw4ig/taLD5MugDxQw/RrIn0pb7gCWXBvZiw54hz
         MHUuHstMeuXlsplER6/5GOrMZMnHWgsBHl6TkRX7BU4/ik5r8IIjiPaI30akmXhHT3PK
         dP1g==
X-Forwarded-Encrypted: i=1; AJvYcCWf6sxmaDyAPRvD3VMw4NIiEgT2D1M3FZU8wKAm9SJ7Aj6SU1ufElgr6jA9o7+Q4zC/eH+t8eTwWd+fcPcrMmvb7VbwKHJAdFDg6sd9QA==
X-Gm-Message-State: AOJu0YxiTuxBVfR0sc+yFMFqQNK4xIH2C2wWLPchy1KZlbtdnfy9TXM5
	TNWQR6nBPGiZamd5cckZqToxmwepTWweJhBI1kSMCNIlPeJP3Pceg0nKlm8bfrIQbar2jXiGpps
	jHGTtapm/KwO0BX4TSBgmdlwiuHsLrKpi/agrdQ==
X-Google-Smtp-Source: AGHT+IFDeEEaIOtSBG5DGppYGHWRw4rXZqpgILKwzYCMW4SSXhcYWj+KFRDuw5xeuXxFLrQ0w0/J7Jaydr+ESekL/l8=
X-Received: by 2002:a17:906:70c9:b0:a46:6bb8:1ec4 with SMTP id
 g9-20020a17090670c900b00a466bb81ec4mr8429584ejk.76.1710866470240; Tue, 19 Mar
 2024 09:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk> <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
 <651179.1710857687@warthog.procyon.org.uk> <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
In-Reply-To: <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Mar 2024 17:40:58 +0100
Message-ID: <CAJfpegsCBEm11OHS8bfQdgossOgofPcYhLTFtw7_+T66iBvznw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:13, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 19 Mar 2024 at 15:15, David Howells <dhowells@redhat.com> wrote:
>
> > What particular usage case of invalidate_inode_pages2() are you thinking of?
>
> FUSE_NOTIFY_INVAL_INODE will trigger invalidate_inode_pages2_range()
> to clean up the cache.
>
> The server is free to discard writes resulting from this invalidation
> and delay reads in the region until the invalidation finishes.  This
> would no longer work with your change, since the mapping could
> silently be reinstated between the writeback and the removal from the
> cache due to the page being unlocked/relocked.

This would also matter if a distributed filesystem wanted to implement
coherence even if there are mmaps.   I.e. a client could get exclusive
access to a region by issuing FUSE_NOTIFY_INVAL_INODE on all other
clients and blocking reads.  With your change this would fail.

Again, this is purely theoretical, and without a way to differentiate
between the read-only and write cases it has limited usefulness.
Adding leases to fuse (which I plan to do) would make this much more
useful.

Thanks,
Miklos

