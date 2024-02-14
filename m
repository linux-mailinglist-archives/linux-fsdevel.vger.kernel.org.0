Return-Path: <linux-fsdevel+bounces-11595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9A85523F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 19:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291101C22468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13291339B0;
	Wed, 14 Feb 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dZu54AA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE661272C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935875; cv=none; b=H0fmxzpV5yENhn3arxASwwI0C4UPAU7kCoTkrrR2StmH8yutO4bekwI6j+RsCkxEYAFFUEE9Z7Fwn4IZByWWwO/yaDzOVnqoGyeIB2tVMhlEUafFnZMzO6/Vp9U+Ns8SOrU8KxNYkET7IVtPjLR3Ds0Ovpk6Fn/1LwcVLrzPEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935875; c=relaxed/simple;
	bh=zcLN3YvzG1bQFvq5MsikD12Qv1JrjQff1e/3KiPYX8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAp2dwgDJXsaaAu4yFQoWPlzudbTqJRDOGDvAf8oYG9Dd4YGNuRQa6XtZdB+vJ3pWSychMRYve2HZcJbb4QrEtqVQnoi7T09B2ydJPla6gCvE/L77Bg0+u65c60rMHrCGjdIaQJ/lB2AyNFu8BwDfYZY7SW1QK3y7swa6kO4ALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dZu54AA8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5639c8cc449so78352a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 10:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707935871; x=1708540671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KP/YqcMN3RDe9bQpy6O9hueIrBnuUxTgb2RIJ7Emwpg=;
        b=dZu54AA8LjIE59/sny9QYUKTYc4Yk+uOWZGXNkXWkGBxbE+wJHOXAw0x1fWSaPMsxk
         mxQbgb9fz++GAKXm1WSK9y7PSQX2kOLXgFREY6ehn3tDm+KHjNZlVuSahfUWqTlInY49
         aQa2i9xKpJpvWEAL41uWqSY71Gggevpa0Pc5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707935871; x=1708540671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP/YqcMN3RDe9bQpy6O9hueIrBnuUxTgb2RIJ7Emwpg=;
        b=idlA6yKZ3v7tWV2Q05bpi7xw9oNro0cVkiuORgbqKxgZ64uT1hsMMKuPuvxTG7IlFv
         HTD1+enH8bc35x40SyLPYMmk2R3O5r2O3dDD9RgkNZ/MVa70xasZgzkGvhcX29T/IjDT
         ylxy5ZGgoJ861WErb+tyI3UfwzAueE4ViktiqQJgH5bCwt0HnaUrMyL3NB0jC+OG95Ub
         zoytkvyuAxhJv2hhSCI3Dz7eF3GtJg5RFZNUcJkBzXeQCxYcscwOe9WgMdfMSYltpYQm
         Al5bBqQLLt3lfAynUyiKE6yvZRHM4LECEGgHOfqESem5Dq9yy7LoOapTsZidCmBhcFFm
         4WdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3zyvxxhA6YfYiEg3SRqoqt7ibjgibFAYFJ1QFZKrE7ZmwbYsJAwL4sa2rB8zYuExzrxqk5atJ663uWqWo8HNWNMYQgLZCc4qqh/X18g==
X-Gm-Message-State: AOJu0YwXGoMe7I2saB4jjHG56mS49t++0z6/mwtJqQ7Wi9YZzOTuZixZ
	/FJpWqER4CETDVqYFL+dJ/fMsIBHKhny6QG/q+UVX5I2J1I8szybrr6jXCdLo8eEUViZi2+Ctx7
	M5Tw=
X-Google-Smtp-Source: AGHT+IGrI/I4WsiZ5x6THzefi7ndLnvDGfM0bZ5R3oMr+q83Gsly77/tsQ+N7hCDfYZObkHvR7CA7g==
X-Received: by 2002:a17:906:3c53:b0:a3d:1f59:7410 with SMTP id i19-20020a1709063c5300b00a3d1f597410mr2165278ejg.22.1707935871247;
        Wed, 14 Feb 2024 10:37:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhhN6ee8IUvTwuFIBc83Ea/gbVGLINzPobaQcjt46T7ZHnFqeFsmE5qdq4clxS5rOf48foptHOgrcFY1HAhGaTK2SyKY19Ozcpnu3ecw==
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id gs34-20020a1709072d2200b00a3d69a5626esm359036ejc.198.2024.02.14.10.37.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 10:37:50 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563a1278f9dso50556a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 10:37:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhJA3fwv41IlzF4+QBZI735g9jW8APj45oVTWOp6uSkWq4Pg5py+zCzKGeWVHT+jMIqbzSTTsUz7pBgZLiT1xH2jgzAeU49PyIqKpFmA==
X-Received: by 2002:aa7:c49a:0:b0:560:463:8cd7 with SMTP id
 m26-20020aa7c49a000000b0056004638cd7mr2777716edq.34.1707935870376; Wed, 14
 Feb 2024 10:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner> <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
In-Reply-To: <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2024 10:37:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
Message-ID: <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 10:27, Christian Brauner <brauner@kernel.org> wrote:
>
> Ok, that turned out to be simpler than I had evisioned - unless I made
> horrible mistakes:

Hmm. Could we do the same for nsfs?

Also, quick question:

> +void pid_init_pidfdfs(struct pid *pid)
> +{
> +       pid->ino = ++pidfdfs_ino;
> +}

As far as I can tell, the above is only safe because it is serialized by

        spin_lock_irq(&pidmap_lock);

in the only caller.

Can we please just not have a function at all, and just move it there,
so that it's a whole lot more obvious that that inode generation
really gets us a unique number?

Am I missing something?

                 Linus

