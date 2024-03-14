Return-Path: <linux-fsdevel+bounces-14416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B106587C24A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A925EB22234
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FBD74BE4;
	Thu, 14 Mar 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SMvXi7h9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751374BE3
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438999; cv=none; b=OGwwfiQWjyljQSNY8OsbVJUtDZaoHRWaRqiH+Yvd0nieemvHylS1abmQmFgKCux7On4UaeoU+JUzA9ddEFOCLoPzO6J8G5OculCUxFxpVHb6dd1PQ9L52ad1j/C1prnp9/UJz/6aGhq71OZpx4JMvFliYDBK3wuBzinmQlhBCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438999; c=relaxed/simple;
	bh=q6LSgzuTsEdBF9ut1bKQ2CFEToCK1i1nZUywiwE9Vpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPfn0b0hE4qZwvWJKLHoOzTgh2Xhi680YpoNT+wl11sg7I4IuMYDxc79SaqHJB/h08HhiMStOdIrs/T6ATkY+ufoxYYf/BRD+I90DijG/QdbeZis06wio+p2GsXYn9Y2jBOp16XmTUqJcWToY4cpAaYqty6UsOqbnkGpa2XJJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SMvXi7h9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60cbcd04de9so13816127b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710438997; x=1711043797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb6X5KMHfFiYteE+h25PpagvlyZNfqx6cWfVGc1cZ88=;
        b=SMvXi7h9+WHXNA3c0I9UewVJcLqJL9luO3zH2w3n9nrRdJ3EyBgO6cAS9+ZHmLXpNW
         /2LOFAEaVihnpSr5FKUOe66qs/2Z4ZtciJbOszV4FIDhYvzkEGXYMu/blXFiMr5WIUB4
         VJ7Bj46+gLv8rnzEWR5DukAwRGFnQdUbqsv/S4ATIV5/nAqOOMT1FjhONXfAk4RG4Vfy
         3LzZGsOyavE/4LXjkCW+PnzlipZiOdn8+cprLPR6+BhWsWcegfT4HY75jXU8jjlfncod
         9yJ+Woge3Aa9EzfQ2u/lvwQIuWv1zTwAgqGnqD5fCFRUUDXKRWLjaYzDnSBbLAITDrmd
         J0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438997; x=1711043797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rb6X5KMHfFiYteE+h25PpagvlyZNfqx6cWfVGc1cZ88=;
        b=vqN89h6dOO8kH7jZugHBgWtwdEGL9ru2QsbeoVa41gRQzKt3ZpXw+8Ro8SFRjvddb8
         nQEt4RGSwunQyypuNsiHoZ/5dtmiQvyPUFjQdRmZcABDext2QCl97QPeQutI0BC2imBh
         xK4xq95qoKX6egv0z1KaYECKufzZyhcLt9b+z3Yi92vQL0iqCgVF89dW27cQkwjRxynK
         d5tcf5vN35Tr/F2jjCN26sdnAy4+8CzOr5Hs2DkY1woFDnUOf1jCuUCA8DHYjvt9kviD
         cd8P9NQmG8VE+gvnXpIuYfo7C4ah1k9FSq4ypPfy0Ex7fSkLlPbJDtxppfGxyWI4gNhK
         wGzg==
X-Forwarded-Encrypted: i=1; AJvYcCXsc699JpmeGxwBMB2kkKHGGyGnoNmJFCI7DEiH7mjvmqKHWq4flQI6Wd9J5icWPQVgZL3xt+MinOB/mM++rFsrT5bUAPyLfh/jxmWYWg==
X-Gm-Message-State: AOJu0YxKgsu31rPnr9FplqK5D4sk97eW9ZoCAlZKKzjfUJOeHr8Tos57
	g8GyIx7tThy3Bp/HpGuqjXSzLIX0zjN7koeqZazoxbj+8T/LwXm+MSlBY9m8SXiH/wfu5UxOQJT
	KPH0wNCsd2eCod56Hu09HkcE8CF3ugilzlJaF
X-Google-Smtp-Source: AGHT+IFSaY3KSxtTjzJoeT7Ux2PIH9a1le7b1LUgfoNjhfxRL1BHbUUMuJ4kF5c2cbU+yMftlKDHosl2AWYs6A7Rwlg=
X-Received: by 2002:a81:a00f:0:b0:60a:66ac:84db with SMTP id
 x15-20020a81a00f000000b0060a66ac84dbmr2560993ywg.11.1710438996730; Thu, 14
 Mar 2024 10:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com> <20240309075320.160128-2-gnoack@google.com>
In-Reply-To: <20240309075320.160128-2-gnoack@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Mar 2024 13:56:25 -0400
Message-ID: <CAHC9VhRojXNSU9zi2BrP8z6JmOmT3DAqGNtinvvz=tL1XhVdyg@mail.gmail.com>
Subject: Re: [PATCH v10 1/9] security: Create security_file_vfs_ioctl hook
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 2:53=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> This LSM hook gets called just before the fs/ioctl.c logic delegates
> the requested IOCTL command to the file-specific implementation as
> implemented by f_op->unlocked_ioctl (or f_op->ioctl_compat).
>
> It is impractical for LSMs to make security guarantees about these
> f_op operations without having intimate knowledge of how they are
> implemented.
>
> Therefore, depending on the enabled Landlock policy, Landlock aims to
> block the calls to filp->f_op->unlocked_ioctl(), but permit the calls
> to the IOCTL commands which are already implemented in fs/ioctl.c.
>
> The current call graph is:
>
>   * ioctl syscall
>     * security_file_ioctl() LSM hook
>     * do_vfs_ioctl() - standard operations
>       * file_ioctl() - standard file operations
>     * vfs_ioctl() - delegate to file (if do_vfs_ioctl() is a no-op)
>       * filp->f_op->unlocked_ioctl()
>
> Why not use the existing security_file_ioctl() hook?
>
> With the existing security_file_ioctl() hook, it is technically
> feasible to prevent the call to filp->f_op->unlocked_ioctl(), but it
> would be difficult to maintain: security_file_ioctl() gets called
> further up the call stack, so an implementation of it would need to
> predict whether the logic further below will decide to call
> f_op->unlocked_ioctl().  That can only be done by mirroring the logic
> in do_vfs_ioctl() to some extent, and keeping this in sync.

Once again, I don't see this as an impossible task, and I would think
that you would want to inspect each new ioctl command/op added in
do_vfs_ioctl() anyway to ensure it doesn't introduce an unwanted
behavior from a Landlock sandbox perspective.  Looking at the git
log/blame, it also doesn't appear that new do_vfs_ioctl() ioctls are
added very frequently, meaning that keeping Landlock sync'd with
fs/ioctl.c shouldn't be a terrible task.

I'm also not excited about the overlap between the existing
security_file_ioctl() hook and the proposed security_file_vfs_ioctl()
hook.  There are some cases where we have no choice and we have to
tolerate the overlap, but this doesn't look like one of those cases to
me.

I'm sorry, but I don't agree with this new hook.

--=20
paul-moore.com

