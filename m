Return-Path: <linux-fsdevel+bounces-15181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B47887E2E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 18:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5AB1F21218
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083C1AAAE;
	Sun, 24 Mar 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cuz/wuUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3A199BC
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Mar 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711302321; cv=none; b=Lbh4xsCf5UcniYnjwky4a8Xvl9iDqsdsPEglA7NYmTDzO7YBk3rmvEXEeCKtoRu0wtGd9w/LaUUnxCLhO5v/5FYIhOGb13Kh+e9D/0NLVFW4OqN+mGCzTsyV3eIssNre39GHdHGoU8szlgYcMkhLGcwCG/RY7DKKoS2FnahSgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711302321; c=relaxed/simple;
	bh=xdIW6mBPIRVyFNi0g6EGkmhDMUnRw/D1b7czg+0i/ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/AYlfRZ6xF7Ck1fY1KenXxew+So8PBVBpmtticYqreY3I9NjA2WQFpl6BQpsP4dOH4zizxPSbrpAYX0BDV71mm3ZSpdxqdZsKm8BoFFEU6OqKRJzwd1dF5Z9+OFLOwxtVkH+b2NiSNjyQkavw3seZAdMLoLaNDCF/EzG9TMB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cuz/wuUi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a465ddc2c09so202576266b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Mar 2024 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711302317; x=1711907117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oe6GIQzO/C567doEXwsmBSySXlt6oy2RX728KJkYzKg=;
        b=cuz/wuUik3HMnipgbKl49knUONIng5nCb6owYldFOa8oqyekrKdz8CXhHZDcF0c36r
         yJ+3e1lI1BSlsZoioQ1RfsMcVut2iEYDDUOmggpVxkKILQQMu3+DH/N635ZR5F/6ys+h
         spbWrOaD7TFDHtX9/U3C/jO8S2YN4bEP7C1is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711302317; x=1711907117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe6GIQzO/C567doEXwsmBSySXlt6oy2RX728KJkYzKg=;
        b=Fomx1F+EZMvXvuqhmiK0LVwkcuHlZ4zSzqa7oxz/eChkWjCTDutX7W6uscBtwmy42G
         A/OKvwZx4aFQolI0/lsQfyMl7rb9ttqkdMt6ioRQdpyn3S3EMdXr2u0coGGzPasjNA/b
         LFu+QkNArlya82iZbK87B/HCVn3p2mwbYXL4BtZM6ftU6pscV4p6BXhcOoKyU4zNebmN
         Q3Pd+2ROgwYt1PfYb11YcvnMnKRJmBV7HS/bPcTn+yyWXpv4UP5mRvzG7u5MneYe6Hps
         6Z7b/GubB1afSPRG6qr2xQWR03HxzvN6N0NA0F/0aG3SBwu2D3/aLXUpuTYkhsrmzJq+
         ba5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtALkEz6kx0BkyGisaUd7o8BSfl4NL62PV8Ec5Mtii9r2J9Rt7Y0KY4dcIvMzgkYLLwlFUCIINe1+vKHvz70Bfrbv5cZwGF5QeKlYSqg==
X-Gm-Message-State: AOJu0Yz1FgU3o1Bp+Cy7cuSjPHutxKitrt0GcTXpDWwOG841zm0htR0Q
	hQkFEtYY0Pth7KHNMjkWOQYwMKPaD/hbH9wJ3NvJjCQCGqV4611iv+G27Q8DcYJARcx11AITnih
	43PNDbA==
X-Google-Smtp-Source: AGHT+IFHS4Yl9fGwotLdzIO6eFVXIZSW0pJDddfyd4B0WDH9p5U8LnKksY+XMmPShM0NzYFIeILIRg==
X-Received: by 2002:a50:d699:0:b0:568:32f7:6c55 with SMTP id r25-20020a50d699000000b0056832f76c55mr4420389edi.9.1711302317301;
        Sun, 24 Mar 2024 10:45:17 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d9d1000000b00569aed32c32sm2109384eds.75.2024.03.24.10.45.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 10:45:16 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41482aa8237so8817715e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Mar 2024 10:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGLfJWuauAoimMsd03B0QW3yrpFPCdnpkC9o0xE6iY4m84/p9CC7g5hTqTX9YVNWiTh2zZ7DOirRCpjDauB0Mrc9SYQqxe8aWXHBKLww==
X-Received: by 2002:a19:ca19:0:b0:515:9ce3:daa3 with SMTP id
 a25-20020a19ca19000000b005159ce3daa3mr3631407lfg.37.1711302295763; Sun, 24
 Mar 2024 10:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-4-359328a46596@suse.cz> <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
 <20240324022731.GR538574@ZenIV>
In-Reply-To: <20240324022731.GR538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Mar 2024 10:44:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBQPxKh1cGhGoo=SmJq72H4VObrkVxQepooaq18H4=oA@mail.gmail.com>
Message-ID: <CAHk-=wgBQPxKh1cGhGoo=SmJq72H4VObrkVxQepooaq18H4=oA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in path_openat()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Al, I hope your email works now ]

On Sat, 23 Mar 2024 at 19:27, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We can have the same file occuring in many slots of many descriptor tables,
> obviously.  So it would have to be a flag (in ->f_mode?) set by it, for
> "someone's already charged for it", or you'll end up with really insane
> crap on each fork(), dup(), etc.

Nope.

That flag already exists in the slab code itself with this patch. The
kmem_cache_charge() thing itself just sets the "I'm charged" bit in
the slab header, and you're done. Any subsequent fd_install (with dup,
or fork or whatever) simply is irrelevant.

In fact, dup and fork and friends won't need to worry about this,
because they only work on files that have already been installed, so
they know the file is already accounted.

So it's only the initial open() case that needs to do the
kmem_cache_charge() as it does the fd_install.

> But there's also MAP_ANON with its setup_shmem_file(), with the resulting
> file not going into descriptor tables at all, and that's not a rare thing.

Just making alloc_file_pseudo() do a SLAB_ACOUNT should take care of
all the normal case.

For once, the core allocator is not exposed very much, so we can
literally just look at "who does alloc_file*()" and it turns out it's
all pretty well abstracted out.

So I think it's mainly the three cases of 'alloc_empty_file()' that
would be affected and need to check that they actually do the
fd_install() (or release it).

Everything else should either not account at all (if they know they
are doing temporary kernel things), or always account (eg
alloc_file_pseudo()).

               Linus

