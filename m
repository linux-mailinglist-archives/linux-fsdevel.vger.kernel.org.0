Return-Path: <linux-fsdevel+bounces-47595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107DAA0B93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A91E1B66C27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22E2C377A;
	Tue, 29 Apr 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTYjVyqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895672C2AB0;
	Tue, 29 Apr 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929532; cv=none; b=fenJG+n+GKQYbSuQeoo0KepAIO1EwQ3ASqhw5rv6OWZSfUvMmWl6K69RbputPRmq2jVjBhp2khjMHaWu/BaozGA96AdCYnDfFUIX9Dz6Lr4/gQlDVq3Rovl6OD4tbNlAaFp0ka811BOrfZ1xZRsi2Qr1Yt7DzLnBQcd4qMgKOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929532; c=relaxed/simple;
	bh=zsm6ivjV8BsTo8xfQiOd3qcE4lNpKXfeCj2tYJTKcbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itB3lQKdxz0hbs6xpIO5ymrKsC0mSCVIVXTQI0nAwV7ajAMusoE1s75uH7HwRLGRU+9XdyKbJL7RlMAA4TKx0w8fZ1gnNhGTzg5orG7gPAsZcopDvefszC93OwocZ8tiRDKgy2c6tyw4NX5nR27nKdkeaIgBtaWR3wZGpl1TA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTYjVyqC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22401f4d35aso71429465ad.2;
        Tue, 29 Apr 2025 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745929530; x=1746534330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJVdhlVALx0VKxqj/M4ZChdpnSmyjEQNQbIaG3nTBss=;
        b=fTYjVyqCot/yJGpx/Gt8/o5ID5x6VzfJLwzbfyUimRVN7IA9cdkqLvsVb7qGbxD9OK
         BAVSe6TJGQ0/maMhrPBp9wqbTM7jdVHGPgFuK5ss83VvpcjHY0IXxNDVHJ/Scaybp/bp
         bTVEqdyjv379B8InCSxfTPMd3RnI1BqxynrR09CNnPn10NxEo/Di3f5aF46F6TGyQ7mC
         0ixJ3AAdfKkiQIuB8X3x4fI8hW9hfNuQuOwyH9WrbjYKMI/FqjoZsTAW/j5nGC0H3h5B
         BsccZbxzZQ/SqqcmRd/0GlhaxhYn4sGL7d+42pmqQ3SRkyk7Uwje6BI43Kt4oCjJBic7
         I75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745929530; x=1746534330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJVdhlVALx0VKxqj/M4ZChdpnSmyjEQNQbIaG3nTBss=;
        b=iKHysVX7basfUKuiGSDTUIcx9NASp9mBwfGsSBOvltuYN7VlfO94QUjMal31VpFo/O
         8oCJcmyIH8ICfeJ/vCfkYVI/u59z7krM8EiAitRiMdBkDWblly+mxKZ/PfAXH5LXDg0x
         V6/TbWFCdY/8SMTSPdE6qH9C974y+cKXI01i1b8HPhxq/nPdn21MOnfsB0QNRsVoEfxi
         ZXLj7rCoI8ZSh8CgeJGoxl9aVlUeMpHwIYDYlYOlG5OCC7uEVFDFhNx7Cm5G7O320T8C
         3e1qYOdzYK90t1DZ2aKzLR2T4BNLzeB07qWt0CcVj8frjdqACjGzyQY1vymMehjvKoQW
         m4rA==
X-Forwarded-Encrypted: i=1; AJvYcCUIuriosk62nts4x5NZ50EdT9L5ZthK15h3b3duIlM5ZZv9TlI7Bod3tZnSDGhjBX1GL2ZdTB5R@vger.kernel.org, AJvYcCUjxBI84AjTkGQ3f/c0PC/K7WstY1VqKpCNjDH02rFiUmYMO9z/MdRJviEWUChDQxDemy6QKFfSu5pMLJCd@vger.kernel.org, AJvYcCVgozgmUDz/63VzhxmupQGp2nGa8cTwI5SxD2VPjHj9CQdckcNlvPY0hkNYrPH0GoKfzeoM5eQMJg==@vger.kernel.org, AJvYcCVoaEnc9jHGqLKjZlzmuzWeBXMgm4CKrn1YmiF6TUxCrUNjA2xJk7CnPaNES8xAkthix/vhmzFHcAYE@vger.kernel.org, AJvYcCWUAiyYx4oMGrnJ7qQi1rKLOtw2G1Y164p8PG1stxe2QxhylRBm8C89BkKr8cDAN0cxJA7dEnj4ZkcqdWKQ@vger.kernel.org, AJvYcCXw4z0MVOINQDjjyEajSIl0sqlOWMAw80lVJwjWE0xJZJ7yGdwG3MxD0di5cLIu3E4XXXXMuuc2HcMuAhLrg5fRRlgMxN0J@vger.kernel.org
X-Gm-Message-State: AOJu0YyFwn7+hpxL6COLFXIZsU0BvJOvptKqdmiND+MIJUpYH4t2rYOU
	MnLxsQVAe0YUblq9loSrtcc7k3eFL8h/hhGXPWJ91MVXwge8XswxXK1vATp5b7UK9V9acdDhyRs
	aRztLa/DzKU9++keAgYcccP8WB64=
X-Gm-Gg: ASbGncvKh2BmMritV9h/1ncQ/cs2Dhqzj4FNb0egbccLLg2vCGafAaD5akqJ29IUOSd
	VAqBht1ZfBV5lww1Ug/qPCxFhlW8UvSgBkC3ApBSY7VCuROQfLx87xY18RhXrxbWLzCjGXEb0ct
	/YDIhqDK/FgzczDrQ6BtRm+mH9DEY1UeOP
X-Google-Smtp-Source: AGHT+IFw5PGCtB/r465vG1XkbAkMe3WiEheNR1OB4z/vokWf2TKrcDs8DMVIqvqL7tkeIcwKphxbmdwf1K6pcvV6RbI=
X-Received: by 2002:a17:903:28d:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-22de70276d4mr44592265ad.21.1745929529695; Tue, 29 Apr 2025
 05:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <20250429-lenkrad-wandschmuck-c0dad83f9d1c@brauner>
In-Reply-To: <20250429-lenkrad-wandschmuck-c0dad83f9d1c@brauner>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Apr 2025 08:25:17 -0400
X-Gm-Features: ATxdqUFo3aBkmJM0ErLbRpF5E-qqX4L_b-5dm4NMPsfSqwdJkopEgKEUFmnh4NU
Message-ID: <CAEjxPJ5S1qkpsFYhDZdymzMhubK76UGLki5sj2XVdifodO5AOw@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Christian Brauner <brauner@kernel.org>
Cc: paul@paul-moore.com, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 3:46=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Apr 28, 2025 at 03:50:19PM -0400, Stephen Smalley wrote:
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > This patch is relative to the one linked above, which in theory is on
> > vfs.fixes but doesn't appear to have been pushed when I looked.
>
> It should be now.
> Thanks for doing this.

Maybe I am looking in the wrong place?
$ git remote -v | grep vfs
vfs https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git (fetch)
vfs https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git (push)
$ git fetch vfs
$ git log vfs/vfs.fixes fs/xattr.c
commit f520bed25d17bb31c2d2d72b0a785b593a4e3179 (tag:
vfs-6.15-rc4.fixes, vfs/vfs.fixes, vfs.fixes)
Author: Jan Kara <jack@suse.cz>
Date:   Thu Apr 24 15:22:47 2025 +0200

    fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2)

    Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
    calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) and
    fail with -EBADF error instead of operating on CWD. Fix it.

    Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
    Signed-off-by: Jan Kara <jack@suse.cz>
    Link: https://lore.kernel.org/20250424132246.16822-2-jack@suse.cz
    Signed-off-by: Christian Brauner <brauner@kernel.org>

commit 46a7fcec097da5b3188dce608362fe6bf4ea26ee (tag: pull-xattr,
viro/work.xattr2)
Author: Colin Ian King <colin.i.king@gmail.com>
Date:   Wed Oct 30 18:25:47 2024 +0000

    xattr: remove redundant check on variable err

    Curretly in function generic_listxattr the for_each_xattr_handler loop
    checks err and will return out of the function if err is non-zero.
    It's impossible for err to be non-zero at the end of the function where
    err is checked again for a non-zero value. The final non-zero check is
    therefore redundant and can be removed. Also move the declaration of
    err into the loop.

    Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

