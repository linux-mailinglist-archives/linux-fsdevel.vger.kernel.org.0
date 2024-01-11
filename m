Return-Path: <linux-fsdevel+bounces-7773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCA882A78D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 07:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9381C23432
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 06:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6F256D;
	Thu, 11 Jan 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJvJDbCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64E23C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6810751e1fdso20977126d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 22:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704954442; x=1705559242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Skn44stswSpDCERqRkFjOJUD11F4M+FeCgrNkoMdAJE=;
        b=ZJvJDbCNIRlbo8o6FuHLfsb/U8eNnrXSfH9L/ffsvZ3e74Wxvb74/DRPhJHjYrbCRK
         9cUAmNGHjxFGMnxZAa1TVQFF4lyXLWX2WWoQIEjiA+Q+bJOHLCbCmywEOktAMS7jFUzJ
         1zIM677dW2xXZY6aAsxfVKZYrRVPMpY0khXCnwc3OH/XFivT3XK2fAiA+SSbJbgGKPcZ
         5EcYGABLKCGwm9EQFBsMTl3+Fu0E6dMdBxsFYiYSeL7X3wywJDR4ayOc9BgEhVWL7Kdc
         JPSHYcbRtZ08oUW0bodkf0lJz6qnQkNRBTBeJBium8T6tHs1SB6jKz830UYKppBxOf5/
         cNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704954442; x=1705559242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Skn44stswSpDCERqRkFjOJUD11F4M+FeCgrNkoMdAJE=;
        b=PHrj0tCHQcO8dmeDS1mL1/KZEC1fgTPqC5YcPIbLXOAYtdAE+GRFA0xQGCoiq/mlak
         shKzOp9F218nwt9Y/jVVntJEDO151knyjtEuTQMCRjdGHBcpKSuJixdTBafLVlpS+QiX
         WXDMyen7CaDZ5eGQARAd50pZ7/tG51ovLfl9JW2kQpKHaSeNJLh5R0FfAeovI6CNXFNq
         2XphU1pr59sD17SBAPAwUlDOwBI7JmmnRErLl9QrDFv+FTg0mf52pWN4KK06sTdNHo9x
         UKlz+fn+7GJt2kOLOOr3tLbo1mDV/Wp86hvMP44VML4A7SufZAp+LQdklcg3Pxa2IvyY
         1cVg==
X-Gm-Message-State: AOJu0YzTSiBIaVw9ZhzcYSCXAY7RTrhYl0VAERPxsKyQxiELZoedKA/V
	D6NJxTbI3bKc6mOz4fxGgDiiqod1nwXUF5fzPME=
X-Google-Smtp-Source: AGHT+IFZ8mmnVVnaaKbbJ/W6Z17JjsAsUIQHLzH6odF8GPVSzyu0dYAT8AKQVh9k//lE0cyZokUEQ/6YRZQ2vXDfBqI=
X-Received: by 2002:a05:6214:1256:b0:680:f980:9ada with SMTP id
 r22-20020a056214125600b00680f9809adamr733281qvv.42.1704954441618; Wed, 10 Jan
 2024 22:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109194818.91465-1-amir73il@gmail.com> <20240110135624.kcimvdq6hrteyfb4@quack3>
 <CAOQ4uxhNp57J8_W_x0siaZRCqTueY033iQGsXB2JA9o9jAJCVA@mail.gmail.com> <20240110165845.b7tgghzugm73pwog@quack3>
In-Reply-To: <20240110165845.b7tgghzugm73pwog@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Jan 2024 08:27:08 +0200
Message-ID: <CAOQ4uxiu5pdP7ZAoiz7pd1mMgFaFc2D1-OXF5uaF9WFXVwteRA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event watchers
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"

> > I am not saying no ;)
> > but it sound a bit complicated so if the goal is to reduce the overhead
> > of fsnotify_access() and fsnotify_perm(), which I don't think any application
> > cares about, then I'd rather go with a much simpler solution even if it
> > does not cover all the corner cases.
>
> OK, let's figure out what exactly causes slowdown in Jens' case first. I
> agree your solution helps mitigate the cost of fsnotify_access() for reads
> but I forsee people complaining about fsnotify_modify() cost for writes in
> short order :) and there it is not so simple to solve as there's likely
> some watch for FS_MODIFY event somewhere.
>

Actually, I think we may be able to eat the cake and leave it whole.
As I've written to you once in a different context, I think fsnotify
has two mostly non-overlapping use cases:
1. Watch FS_ACCESS/FS_MODIFY on selective inodes (a.k.a tail)
2. Watch sb/mount/recursive subtree

Anyone that will try watching FS_ACCESS/FS_MODIFY on a large
data set, would find that to be way too noisy to be useful.

For example, we have a filesystem monitor application which needs to
know about changes to any file in the filesystem, but we cannot use
FS_MODIFY for that monitor because it is too noisy, so we use
FS_CLOSE_WRITE as second best.

I guess we cannot rule out that the use case of watching direct
children for FS_ACCESS/FS_MODIFY may exist in the wild.

IOW, I think we should be able to optimize most of the access/modify
hooks by checking those events specifically in the inline helpers for:
1. inode mask
2. parent watching children mask
3. sb->s_iflags & SB_I_FSNOTIFY_ACCESS_MONITOR

The use of such an access monitor is currently unlikely, so
I think tainting the sb is good enough for now.

Note that the upcoming pre-content events (a.k.a HSM) are
certainly going to fall under this "unlikely" category -
If you'd want to use HSM (on-demand file content filling) on
a filesystem, you will pay the performance penalty for some intensive
io workloads unless you'd use an fd with FMODE_NONOTIFY.
I think that is to be expected.

HSM is anyway expected to incur extra performance penalty for
sb_write_barrier() (for the pre-modify events) and in my wip
sb_write_barrier branch [1], there is a similar optimization that does
activate_sb_write_barrier() on the first pre-modify event watch
and then leaves it activated on that sb forever.

I will try to write this patch.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/sb_write_barrier

