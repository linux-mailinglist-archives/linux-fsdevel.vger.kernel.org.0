Return-Path: <linux-fsdevel+bounces-14822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C38801DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 17:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6237D1F23288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17C85659;
	Tue, 19 Mar 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="l+V0fC34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B485920
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864843; cv=none; b=KmANUR2f/ZYYrJOL7p9Z5PKMFjBTStqZ40FkvddIpwQmXnxiZyKEx47FIidyOttptxLG09OPOJ/wseUxclSgek2Ev7CZWstgueKURARNiF/Zt+kuKhpJeaQpWZfCLn0TZM1MtPrrNKVvzNHj2HOuatQQX7rc5DvZMyRgQ5OZxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864843; c=relaxed/simple;
	bh=xK6oFtMSPOO/+MFMrzgdRfpeW/yJYOp63dnRub6XKM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciQ7VJdgbwgRdQx+D6ysbPnNO/XJyczAfUMUNLhWOgE0+fsA0tMODuunLMjSl5aCUVqaEXmbDOl4Kqc/xaUuHqjKkeoFvqH3wn7um1V47Rv/Kid/t3SarwA9r03kkkLvzPVpahCQOGDU7KhKl8vba50dQJ/ZIqmRyg7YiWeicJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=l+V0fC34; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56b9e5ed074so993304a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710864839; x=1711469639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qssoFyi0EHVSMQZ8tvcNSLF8ll1cyBFfjAUL3WkFTKQ=;
        b=l+V0fC34qbWms3t2kAM2Tsaco+GNRpzk32yyo0NNeSGtZuo5iLyGwkDFxfHS7jyxuT
         EjYfJjUYY/jl10/fim6+6QLQfSlCeSzFvYZY0aAjsYBNlqdd16aIRTso+2GaFAMF86Wh
         g0+a6IL6vAXBN23hxZ4lFYPLWdEr8CCHoiv+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864839; x=1711469639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qssoFyi0EHVSMQZ8tvcNSLF8ll1cyBFfjAUL3WkFTKQ=;
        b=vIHNDd455Fui29AjkguW+W5JECJiXoysw4ekPkluCt2iYJsAKNrtWsXCuz7TDXUILN
         MBn4Cf6zfMBq/Bzi1ryMPMWzk+4Rt8/PQQgxiQ+4RGndOq2l2X7Z9FBy6AkiZZ62bUaX
         5dl/7KjNZFfBhFwSQv5xVwkgE+CrvZ5g4HsrYUDNEyK4o2YKTLBFwrJEiq0BlXudmn5P
         PNkpNvJAzBGp5Ufl1uMz6B9H7uvoSjjM7pDGdYJ/eEvnNqOfgyradqoz+xhjcT2Jydjk
         s9rV5bWQs9z4KkMFK1aF/oJmeFUKk7osUDLDVOdpuDIMqr3qKOba90HcJbzpfilLkIzR
         xM6A==
X-Forwarded-Encrypted: i=1; AJvYcCWu7bfB5hpBGhlU0r8fUJVpASoMNt9W4Im/9ocNj27a5FtapcGmbIM/kFKXx9FdExvev18Wah8a9+4+Iusi0GF2r+1MjKrmJrMu+l2IJg==
X-Gm-Message-State: AOJu0YybDz6JbMrkHFuNkSCXYMb9pR/DlmjnT0u9zWjgwUXPMeiq82P8
	VpBSVYv87ENswr63XZPzpbxjDi+J2S8RCk2a4wWzId+78EJobXZBP2G/Y3+ZrMNja1wUes90cCW
	ekjEGww7AyLz/MTLTrtDJvyKqENgunW8pGJqYZw==
X-Google-Smtp-Source: AGHT+IG80idJ/eoHfs/tS8xY4ItmYTZEjrCulMFp8PsOW5O33PBCGW/QH9XqH6EWMgC+d4lP/zrFK1SKGKNE4vf/7pM=
X-Received: by 2002:a17:906:af07:b0:a46:47bc:580b with SMTP id
 lx7-20020a170906af0700b00a4647bc580bmr2203920ejb.56.1710864838625; Tue, 19
 Mar 2024 09:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk> <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
 <651179.1710857687@warthog.procyon.org.uk>
In-Reply-To: <651179.1710857687@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Mar 2024 17:13:47 +0100
Message-ID: <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 15:15, David Howells <dhowells@redhat.com> wrote:

> What particular usage case of invalidate_inode_pages2() are you thinking of?

FUSE_NOTIFY_INVAL_INODE will trigger invalidate_inode_pages2_range()
to clean up the cache.

The server is free to discard writes resulting from this invalidation
and delay reads in the region until the invalidation finishes.  This
would no longer work with your change, since the mapping could
silently be reinstated between the writeback and the removal from the
cache due to the page being unlocked/relocked.

I'm not saying such a filesystem actually exists, but it's a
theoretical possibility.  And maybe there are cases which I haven't
thought of.

Thanks,
Miklos

