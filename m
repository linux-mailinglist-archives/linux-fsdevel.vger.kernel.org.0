Return-Path: <linux-fsdevel+bounces-7414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC398248ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82821F254F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0122C690;
	Thu,  4 Jan 2024 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EdnZzLUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC82C686
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a1915034144so101792566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704396098; x=1705000898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4MuqzTE/G+T5VrqGABwUELReNnh9TwctX30WQtzQOw=;
        b=EdnZzLUClgs4ur/8y5FP6tRq02qyWaY5N72vXNV5I9U8bZ/7bKHZvSDwGX01jA1NAz
         Z/8Dmh9QysgWpFAHjEiv5MnGR2GQbMzilbKtSJTGsR7mqwKBGTHr7a88sJ40n+4iPQSr
         xtIwlHn98rsYx9laJRh++951DYO2BbepN1hGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396098; x=1705000898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4MuqzTE/G+T5VrqGABwUELReNnh9TwctX30WQtzQOw=;
        b=EAwi8EL5pwMOSI8HvrzdhBR1Kk5cq1L/Dhgxe7DrgNH1WUEuKGf9CNnYdTbJu9RBVI
         WT9s8wR3WtQyUKDEy3EaLcaKoS85OE58CXpbZTGAgOdlONDtovx7kfNynrWeyreejD57
         bT0gvSjeBojlnIp7izHHsKU2rJFi/6ByNdQJbFHTWe+NeEAlBB1lgQVI69dzoL2I/5EK
         3x5ryIrdYrPo0knWF4XeG+juYr1hzfkK5mYl9WtEx81qN3kaiq1XbXk+ScsIR+zJPnIQ
         VIp5u7qcaQ7Ebu4gmWj9VMN0PWGyMm4UY6gu9J7mNk0PCIFlTf6+IJDrv+GTjXARn3SB
         /LPA==
X-Gm-Message-State: AOJu0YwZSsCM0fFWhsBwktuTMAcL9NXb9RhEi5Y/JnVTuBPAuSZpodDu
	6IrO4lBDdf/5Rq3oCx/DD/zm+ZmW9IUn7la6lOxggehfSyKgAbk+
X-Google-Smtp-Source: AGHT+IHBSeRumM0Oxgvr7+xG45/hgX+LHcC766+vKBVaXcHDfF7Fi012L19N/kN+e0kZJE9lyGGJVQ==
X-Received: by 2002:a17:906:4e89:b0:a28:aa8f:38d9 with SMTP id v9-20020a1709064e8900b00a28aa8f38d9mr461022eju.29.1704396098607;
        Thu, 04 Jan 2024 11:21:38 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id wl1-20020a170907310100b00a2697984204sm13986169ejb.72.2024.01.04.11.21.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:21:37 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a1915034144so101782866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 11:21:37 -0800 (PST)
X-Received: by 2002:a17:906:ee86:b0:a28:fb5:4389 with SMTP id
 wt6-20020a170906ee8600b00a280fb54389mr705009ejb.0.1704396097273; Thu, 04 Jan
 2024 11:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103203246.115732ec@gandalf.local.home> <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home> <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home> <20240104182502.GR1674809@ZenIV> <20240104141017.4cd8451f@gandalf.local.home>
In-Reply-To: <20240104141017.4cd8451f@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 11:21:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLTq-aj2bN_B7-0h2NYdkVxkbkmiOKKer=n0x6pPO77A@mail.gmail.com>
Message-ID: <CAHk-=wiLTq-aj2bN_B7-0h2NYdkVxkbkmiOKKer=n0x6pPO77A@mail.gmail.com>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default ownership
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 11:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> My mistake was thinking that the dentry was attached more to the path than
> the inode. But that doesn't seem to be the case. I wasn't sure if there was
> a way to get to a dentry from the inode.

Yeah, so dentry->inode and path->dentry are one-way translations,
because the other way can have multiple different cases.

IOW, a path will specify *one* dentry, and a dentry will specily *one*
inode, but one inode can be associated with multiple dentries, and
there may be other undiscovered dentries that *would* point to it but
aren't even cached right now.

And a single dentry can be part of multiple paths, thanks to bind mounts.

The "inode->i_dentry" list is *not* a way to look up all dentries,
because - as mentioned - there may be potential other paths (and thus
other dentries) that lead to the same inode that just haven't been
looked up yet (or that have already been aged out of the cache).

Of course any *particular* filesystem may not have hard links (so one
inode has only one possible dentry), and you may not have bind mounts,
and it might be one of the virtual filesystems where everything is
always in memory, so none of the above problems are guaranteed to be
the case in any *particular* situation.

But it's all part of why the dcache is actually really subtle. It's
not just the RCU lookup rules and the specialized locking (both
reflock and the rather complicated rules about d_lock ordering), it's
also that whole "yeah, the filesystem only sees a 'dentry', but
because of bind mounts the vfs layer actually does things internally
in terms of 'struct path' in order to be able to then show that single
fiolesystem in multiple places".

Etc etc.

There's a reason Al Viro ends up owning the dcache. Nobody else can
wrap their tiny little minds around it all.

               Linus

