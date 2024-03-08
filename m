Return-Path: <linux-fsdevel+bounces-13981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8590875ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 08:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F212846A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A01CD09;
	Fri,  8 Mar 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rOFY+bfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF64F605
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884380; cv=none; b=KO67AdmHi84GwDI9ZtSk8SLMmhc4x7zGAf7ht+IoN+IdSq+S0U9/ORWsF8HT3f9acKTsNyEjVaQEsiyGqlGtUr/3N6Km+35u486Srrfy1/Xr/SG3R7LEgHWDFqwFR/Ybb7jVF7SYuWm3JQetPfF8Pjk8DsRpueCW1iQNZo9k7bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884380; c=relaxed/simple;
	bh=sH4bAKDnIswJKnbTcqpk0Pb3FW7/UPFUpIR+aBApz4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4eNpgo59n+D3Z3cOvUFXsD0gzLn8SnYhp3z4TxsJMtXnL8h75dEQHgIUcuqZayrw1ctYLHuF+sxd8iTIO2XhOtcM0e2E4LTp/9GRWZj+YaUnYtRvnXcCAwsHbUxpX1NFntKf6Jt8STkNi9XyHZW8CivxViZ37S9tPZeVknYMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rOFY+bfK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a452877ddcaso235528566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709884376; x=1710489176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hrvCXGaVO3HhvR4A5xt8TDit+qLJ9i7NLCGUzaXWqIQ=;
        b=rOFY+bfK+k8+GVG7m5U9B3i2k0CHJlG1bQPzVjFG6hEfEKbfsJ8ty0BXbr/l8SOZ36
         b1Libwo+P0O519HMzwnrc3bSvuLYAc66Jox3XPUV0AROzk+X5APywrZbmKaVqdPlGnQq
         7kG4z9LIM0C0AGbXlcZ2+ka7IFIvl7RVsyKAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884376; x=1710489176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrvCXGaVO3HhvR4A5xt8TDit+qLJ9i7NLCGUzaXWqIQ=;
        b=vz+/Vq7HTYWn1M3Qvy94YupgOJOHCRpyht3VrlqhGkM9FtxNVBkvuCWYbgFfuqCpTj
         8RNnAJC4WUrjnRB3+o0vieuyuRWqaWXFsKoCv01N6JLVRxaYOkIglZg7VB5u2N8tTudr
         Kxho9ebX/DJ5Kl7s7RP+E5cn/gEdtfVKP5PL7/KjLIuyM6ynBKl4uAhu5rgx5AlWDeb+
         9H3IDzoj1AV6TOoczsD+HFruLVxKQOBzDDPqRt8KSDv/les8SvjpCqhqj0IxgrCOhSy2
         /uYpZpAIc+bLng6fyfZ3KkYebq9EbDlZYRaVo4QW2bFx2EN2ERs2uMEZFqOdnrSz2mfc
         EePw==
X-Forwarded-Encrypted: i=1; AJvYcCVknN4uWHvKPPWvXiVaxMloEUDIo4MYUjZabFI658Td4iddJpPyVffBQ8RE0+W5SAdNDCK886n9F9X0/ZXEra8hi1cJ8fVw02z1YPlYZQ==
X-Gm-Message-State: AOJu0YzGZKFWc2wxHbCf9LURCi8Jn7iAm4/HjH/16qVbs069MewFDS+P
	8s27hguQIJ+mjmpzUJPEfeMKm36yJZ/aNuf1BzSZ6LGRw3+goHjATNkltX4/zZxfH77Mzues2Zz
	AlKg0h0RdjwT+c3X4izx5EEKoOVHegAn51FtnQw==
X-Google-Smtp-Source: AGHT+IGfxe+G6Hzhhm3qO2+tkAluEdwQIf++vT61Cv18s0V9jevPsUAy++K+ZRtxdczK/SgeeJRbLSjfJGJhUS+augI=
X-Received: by 2002:a17:906:a2cf:b0:a44:488d:8e42 with SMTP id
 by15-20020a170906a2cf00b00a44488d8e42mr13783793ejb.66.1709884376420; Thu, 07
 Mar 2024 23:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk>
In-Reply-To: <1831809.1709807788@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 8 Mar 2024 08:52:44 +0100
Message-ID: <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
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

On Thu, 7 Mar 2024 at 11:36, David Howells <dhowells@redhat.com> wrote:

>  (2) invalidate_inode_pages2() is used in some places to effect invalidation
>      of the pagecache in the case where the server tells us that a third party
>      modified the server copy of a file.  What the right behaviour should be
>      here, I'm not sure, but at the moment, any dirty data will get laundered
>      back to the server.  Possibly it should be simply invalidated locally or
>      the user asked how they want to handle the divergence.

Skipping ->launder_page will mean there's a window where the data
*will* be lost, AFAICS.

Of course concurrent cached writes on different hosts against the same
region (the size of which depends on how the caching is done) will
conflict.

But if concurrent writes are to different regions, then they shouldn't
be lost, no?  Without the current ->launder_page thing I don't see how
that could be guaranteed.

Thanks,
Miklos

