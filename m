Return-Path: <linux-fsdevel+bounces-8343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EEA832FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 21:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4E91C2368B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC49756B9E;
	Fri, 19 Jan 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VhQWwBY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20015647F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696215; cv=none; b=GHUvDVrOkFPT+ZpfTtlJHtZ9A0x37VoXDVJ8t7Au4tdSogsu6PvHsIasnAC9zhuLf+JNIYGsesKxPv3ZAvvDu63suFoGOSeKvUEXKd9aPf2i/wgP48pk+LVv27x+ujuFeUDOs9rlg2mTWYfHh8Zs8ZUQ8YgQ5kTjx6qzra3vHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696215; c=relaxed/simple;
	bh=8OYZqPISIFN5KLjECVoHCt1uNlCy0BijTW360W4wa40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtTh1w6Rfo5MRLYo0NvkBnKcGG9C6IiK4dxforl/xnlcuO8pgEp7NEd8/49ZCkOuo/rigztejiw1gGrRr7K92C1hrxrtGFIgC8lxe48zJrStMxPnqFgI7OVo8G7mllR9MFYtHQKvsb1FwwTBKgzvrqB8/G3ve1QkcQ0M7at+Ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VhQWwBY+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so206446866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1705696211; x=1706301011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uDGXTncqm9MB3BL9Zt8G5ddcs+43LzaU9pS4N/bFZaw=;
        b=VhQWwBY+pdHZlWirKg0fqls4o1bwQvRHX+CK8OX7R8Kby4h2cFtIfTPohDR/ZO1+/J
         kv0bCHdgSLWHUMQdqG95IdOcCQJ7wx17N8vbvkIxVBgfKnzLEzelTWw1CPfskU9MiZ1C
         V0EPi9GmWu3vvnwxCO7QQ3yBe8qNGhR8IZWNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705696211; x=1706301011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDGXTncqm9MB3BL9Zt8G5ddcs+43LzaU9pS4N/bFZaw=;
        b=HAtXmfcfxot+Y1UGMqYPtsYhcDPJgUlaDp1OSf66Nu1GfqaiaveEql/thgSJCdpzHv
         Lzdo4osmG97Llm9Fp8bPnI9ikE3dZeWY2EYAF8uUua3WoFMohAE/Jw3ICL6b/6/I8kBV
         Cry2m0VmV+xuy4SN4xYGr2e+7m/WAozQK+GCPtzI9CJz0xKdMiuT1KDG4aqKx8Q1EvY7
         P/LxzI1mOfzxb3yomWP1cjYhi1jnfkJBwQ1nIexPOKNII5gNHSn6z1BGHdYBoB6TyMwp
         e5Z/4ijRw+1ugRYGofmS7y5hMoBERDkCh3QYviZdce9JRuZo30erDPSKXtclVR6shrdb
         TieA==
X-Gm-Message-State: AOJu0YyRWfII3gqK47tuCZ94+NxAkL+RphCubbQUvw3UhxdayXXDIXfY
	7bONjW7YmKsC7W9nxDtvDRlBzK764wzW64V4ajTBVEZBG/lYIyQVX0ISuVe0dvF6r8s6scFenCh
	o4qki3zf1qtn9VmGaSerC9jAJirGVemIYU6Pl7Q==
X-Google-Smtp-Source: AGHT+IEAii7Y/IUup/E21nLLKZG3h7YMWqAccABZoHNHDmiuXaqhXigJUCgpyKgYEXNLdxgQ8bTu70xR/vO2hJ2VpyM=
X-Received: by 2002:a17:906:714f:b0:a23:62fd:e2f6 with SMTP id
 z15-20020a170906714f00b00a2362fde2f6mr445811ejj.30.1705696210888; Fri, 19 Jan
 2024 12:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
 <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com> <CAOQ4uxiob0t4YDpEZ4urfro=NrXF+FH_Bvt9DbD1cHbJAWf88A@mail.gmail.com>
In-Reply-To: <CAOQ4uxiob0t4YDpEZ4urfro=NrXF+FH_Bvt9DbD1cHbJAWf88A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Jan 2024 21:29:59 +0100
Message-ID: <CAJfpeguFY8KX9kXPBgz5imVTV4A0R+aqS_SRiwdoPXPqR_B_xg@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Larsson <alexl@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 20:06, Amir Goldstein <amir73il@gmail.com> wrote:

> How about checking xwhiteouts xattrs along with impure and
> origin xattrs in ovl_get_inode()?
>
> Then there will be no overhead in readdir and no need for
> marking the layer root?
>
> Miklos, would that be acceptable?

It's certainly a good idea, but doesn't really address my worry.  The
minor performance impact is not what bothers me most.  It's the fact
that in the common case the result of these calls are discarded.
That's just plain ugly, IMO.

My preferred alternative would be a mount option.  Amir, Alex, would
you both be okay with that?

Thanks,
Miklos

