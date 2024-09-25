Return-Path: <linux-fsdevel+bounces-30024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F99850B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 03:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1971C22BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 01:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24214831D;
	Wed, 25 Sep 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DVfxL+tO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9F3EA71
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228779; cv=none; b=tzpNZvGq7nyhu5FUZKv7SG6oQkKUg7K2yd8zpkQKocGgA1Yuc2MXFJxtlBvCehAjzkrD6R7hJbIGz0Rcs/PZdisHeUI4H/1yygAir0EK/P2cotoJvgFg5A7Zgp97eGKlt0oJyNzBFAShN4m4c1f7WmYdYmEDd8dqqe/FYIxn+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228779; c=relaxed/simple;
	bh=xUF69c+JXEl4NVUwF1HduHLgeTxgdRww8qHXpky5/BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRxtTfw3/IztHh42HxH2xFNWy7d+FEgEhi83VJzEBWlACMy2Xt182GJXrEXnox1MKoyVQ+hudsR4fEhDrf2pxlSlDeSbQ6KbYCaNwci/16HSGpv/OPMkE8tmFQKUWuzbecGOqTW+a1F8zoSI/LjBXwCy8WUno2nXDoZdhQyvGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DVfxL+tO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d64b27c45so1110006666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 18:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727228775; x=1727833575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPyihdkphzHjYHkiFltgJ2kdLQLirrIMMdhZ8LE0uX0=;
        b=DVfxL+tOdPFWW4PVOXFe6V3R1x20HQrmE6C7eUXEpqjVGKcrWOAI9XeHVSagCbGb55
         vwF/kuYhw1WdHJZM4ov9ZLQ/RZiCnR+Oxlun3dQmXCdKkYomTB3upwLZx+iQ5UZcMp/W
         krXsje5rUn9v7tuvVYP8tPuyzfJ+ce6mlehAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727228775; x=1727833575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPyihdkphzHjYHkiFltgJ2kdLQLirrIMMdhZ8LE0uX0=;
        b=v+9sFOdw0Q+yhBjXHbUViurzSx29d+M4Waa4800YIxFAL9oSTsakoUGu6D95t++IqP
         0n8ZAgYGXLHAHTmVHShM1OVDIOQDXX2cby1NKc+HFSlZYhSSKZ5aNlVU/zneQMEa3rQ1
         ik8MQuVHw8zsSix4qrbb9SXapmSh/OJvLnXH0vSNP2QjLngv8PE0eotkkDNQZXtgJrol
         SkbRXfiZrsNmu5UNeEhZNzXPkjp20tCLipgq1rtzK5bxxMqw79I5aafGvOQDh6HvdLYK
         PaI3P3Fay/O+oVFKUAgycBW4+v1FzhFvKIwrIarDgm1BVUuQBhs2D3O7t1h9/+W+FYoI
         9ivA==
X-Forwarded-Encrypted: i=1; AJvYcCWzYMAE0cr9uwnz+M7Ost/DlRXnznqbBlazlDZpzrCL92DdI3e7latB59y6r/+rGSqoV4KwlvWl0GTdpBh2@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEYHh49rKdPQZc3NSP/WmYGQ1Xa8xxQUS9/TCYOl/SYx1MJuM
	f6XiJQMmBWg7EPJamQ5qZmQ9X/MZZ1HfSNA291q3eWR+kT8jxLqkcz8Pk8o6oyNyMUiD6uHUvBI
	4yreUiQ==
X-Google-Smtp-Source: AGHT+IFflD7Xs6vkp/iPvFndt0iFgmTgbAfVtZm+i4al/bMY/+Pk382VT5ssGkr5zFfVHzST95naxw==
X-Received: by 2002:a17:906:d25e:b0:a90:df6f:f086 with SMTP id a640c23a62f3a-a93a032011bmr97687366b.11.1727228775266;
        Tue, 24 Sep 2024 18:46:15 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f84f4sm153094566b.164.2024.09.24.18.46.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 18:46:13 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a843bef98so831523166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 18:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUPGv4fT0e2c5dLikuNkFvkZVD8ZrVjqFgA9rttB5WUX/ZmTVmjvPX2N8d5X02ymiieHXz9uF+OAffj5Xr@vger.kernel.org
X-Received: by 2002:a17:907:e6ca:b0:a8a:8915:6bf7 with SMTP id
 a640c23a62f3a-a93a05de3a2mr90554066b.51.1727228771898; Tue, 24 Sep 2024
 18:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area> <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area> <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
 <ZvNWqhnUgqk5BlS4@dread.disaster.area>
In-Reply-To: <ZvNWqhnUgqk5BlS4@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 18:45:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+zqs3CYOiua3qLeGkqfDXQ0kPiNUWTmXLr_4dWjLSDw@mail.gmail.com>
Message-ID: <CAHk-=wh+zqs3CYOiua3qLeGkqfDXQ0kPiNUWTmXLr_4dWjLSDw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 17:17, Dave Chinner <david@fromorbit.com> wrote:
>
> FWIW, I think all this "how do we cache inodes better" discussion is
> somehwat glossing over a more important question we need to think
> about first: do we even need a fully fledged inode cache anymore?

I'd be more than happy to try. I have to admit that it's largely my
mental picture (ie "inode caches don't really matter"), and why I was
surprised that the inode locks even show up on benchmarks.

If we just always drop inodes when the refcount goes to zero and never
have any cached inodes outside of other references, I think most of
the reasons for the superblock inode list just disappear. Most of the
heavy lifting has long since been moved to the dentry shrinking.

I'd worry that we have a lot of tuning that depends on the whole inode
LRU thing (that iirc takes the mapping size etc into account).

But maybe it would be worth trying to make I_DONTCACHE the default,
with the aim of removing the independent inode lifetimes entirely...

                Linus

