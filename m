Return-Path: <linux-fsdevel+bounces-7274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CBF82379B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55525284469
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405191DA52;
	Wed,  3 Jan 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CfoMUGTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EBD1DA3D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d88fff7faso27161655e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704320261; x=1704925061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ggectDD1sVFfFuxF/ttgx0s4Ggo2HATlFxfh+QjmL3o=;
        b=CfoMUGTw2GdwxyRQnnMtqmN+XUJ6zHHXhmB4U80Ncv+sTDlJQk+QKtDL1TRwjstHye
         yGKE+JpjSZ+cUFpg4kVzScq6H37aspIuLV6u5kly4X5M/ZjmKiqXaxf2tVt4V0pSoCaK
         X7CGIsEFxKs0MFeRF6j6rvB5kzRFuCPalIgTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320261; x=1704925061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggectDD1sVFfFuxF/ttgx0s4Ggo2HATlFxfh+QjmL3o=;
        b=B7byYi21g68v920/r4px1hRm95w6yUiuA+Edgd7X64Uu8Lgn4lTEop1AWVAxZ7IJH0
         UnmxweWuBr2x8lIQAPHYoB6yf6+2xNJqzJwcbrmDdN3jmPUGnavBcesyU4XXVGgu09xS
         vjeLOg65dSyLjpNjpvmd+KnUzHjO4RUPgjIxcFw9YAMteejdEL2Ii/GIfN867FsV4uLs
         60bYiOfNrGMh5wd65H3+DULE+gFH6E5ljYKhLu9/t0LsNxKMFPCYa5ryFXvFPl+FVS4X
         zWU1i8BIbcXc6ZyI5cR6TGmwSkvRq/TDn3rrSdII3Au4miTiTjhlJnuuIhLL8DzLeGFP
         ZNfA==
X-Gm-Message-State: AOJu0Yxu35BF3LaIqztj7cHgYOPdGamilY4zsrWwoiMXywWAuYTcbjOi
	R4Ze2yXFEF6370/hCd+lkyKU3xuDyNysldilpolxW75gL+dupsuJ
X-Google-Smtp-Source: AGHT+IEMupGy3J6GV/XEAlVipXP8hmZ0ck8x5NBPi+RZGLG5Mc8DHRNGiyMZYh7cIuwTkjSjYItx5w==
X-Received: by 2002:a05:600c:1910:b0:40c:24b1:8d07 with SMTP id j16-20020a05600c191000b0040c24b18d07mr5399348wmq.192.1704320261264;
        Wed, 03 Jan 2024 14:17:41 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id li4-20020a170906f98400b00a26f5eb0554sm8617143ejb.63.2024.01.03.14.17.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:17:40 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so1276169666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:17:40 -0800 (PST)
X-Received: by 2002:a17:906:73c9:b0:a27:db5c:8a4a with SMTP id
 n9-20020a17090673c900b00a27db5c8a4amr1618752ejl.213.1704320259797; Wed, 03
 Jan 2024 14:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com> <20240103221444.GM1674809@ZenIV>
In-Reply-To: <20240103221444.GM1674809@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:17:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHEyd2z-KvaV6ndKSqGjkisE0MBEXsFkkxeicHTUy-Xg@mail.gmail.com>
Message-ID: <CAHk-=wgHEyd2z-KvaV6ndKSqGjkisE0MBEXsFkkxeicHTUy-Xg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 03, 2024 at 01:54:36PM -0800, Linus Torvalds wrote:
>
> > Again: UNTESTED, and meant as a "this is another way to avoid messing
> > with the dentry tree manually, and just using the VFS interfaces we
> > already have"
>
> That would break chown(), though.

Right,. That's why I had that note about

   So take this as a "this might work", but it probably needs a bit more
   work - eventfs_set_attr() should set some bit in the inode to say
   "these have been set manually", and then revalidate would say "I'll
   not touch inodes that have that bit set".

and how my example patch overrides things a bit *too* aggressively.

That said, I think the patch that Steven just sent out is the right
direction to go regardless. The d_revalidate() thing was literally
just a "we can do this many different ways".

                     Linus

