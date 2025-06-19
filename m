Return-Path: <linux-fsdevel+bounces-52262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E02AE0ED6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 23:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFC216B97A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 21:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2F25F797;
	Thu, 19 Jun 2025 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cW6D1BRd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572230E84B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367061; cv=none; b=LdYGpX0GWMNGdNjvh3tdT6gQnaM1AMMbgJfRhlCP17GuZf77OCHlnyMoOGWVtnhBQEGPcbCUMzkOt3whZsXDFkQiHGkxfHbCMjOhrAxznOAuuv88DlYV47Nnu7Za4D6M72ZcgUxKLIUBdE5rkknZh9rqFMrKDkx/feepKdsxXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367061; c=relaxed/simple;
	bh=f38j4Iqo8acxnIhtuXkeD3cynLv4OcZQ7P8GpdgZm4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLUbdxGo2mQKNgOfSNWAu9rgIXm+JNBKXY2E7fhkl4UYLlbAbPLsYiK9Cgsmz3000Fc2Y2OTZt/J8pjvLwPyxnLFZfOJIVAHjTEHxWnBy2vkGePvJNnBhziRm1O7wk79E9VnzGct9d5ivfa3cAx//z4JUg/zSJyjZiqGsyzBnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cW6D1BRd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-712be7e034cso8277527b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750367057; x=1750971857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lumfk+fpW+/5RKyXlyleHS+MaP2GOeXbKZfOKNMMyIc=;
        b=cW6D1BRdeBH/yBYWcL/wW3xI9TIZwqjiAhDhf9YbmcTVJdcRUbCyG1arPgo+Yy6/aT
         Oaj4L9eF5s//T1+B/suXBN/LTab7Wt8VosVtYC6wWA4gLN0WbwvP46YDVaxLguhLFu1S
         S0WufY4MjC0O4LwZcgY2FgQ8PL4jmfMAJ8fvtoA30rBXnt8C+NtpkIOcLAmwFxoeWr8Y
         V14/jcyLgFMOTcpl3YCy6yyouurTHPnH+kId/uokOJ0Fr3WSjxbZzHpXDgLwuz3+/XbQ
         FURBQqIQpG5Uqg3omXXvKTbMUq2QmjOcLG75sn/DNq+9wrvGnaKN9dEl+ysaV2nHAr03
         yYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750367057; x=1750971857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lumfk+fpW+/5RKyXlyleHS+MaP2GOeXbKZfOKNMMyIc=;
        b=QRU97V2Cy4OiYZTpa9Sws5h5VoGZU1dOPjtUEh9bVh/nTBbA4WzJat3CHFNIZypHtp
         N4Hkg+V0oCyhbThAw/hUEt4pzbpcbkP+iYz2Q9jbrTA8MkuElISb2Jd1G6jxAtKaB8B7
         AsH2FXo326ulNqtocgmlZ/HFEnq7Nspq8/979+OQifthKjZjqLeWQ1dTPgtEmwGkS0/9
         C5xdl4noU4IS7A+WGzw4UKvGrapdNfryytNG2YqASd8Wqa0mKg1PpNRIRKZgjh2qCSYO
         aP+oiMXJFFggT4sfrTsmBvRpk9S+4n6hJEHRq/jpeEaJ3D0apv80tvxV/1g+ZyPSqD+q
         3YyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqZCFZrKHZR5PC0Xi7LZdDnpnz+T8zWMtAn0VNvn9B9NtizCx/ZgH+RUfQwPx9Y3LnB2Zvc9Sr+54Y/4G8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+epVakS+yUkGjbkpHt2xeNHN78+tR2L3+MnnwNyX87NKDWtfl
	HWtWTQL+CE0aFQwzaVdETOdBO9Wxc2ssPnPg0Qb969IFfL36paOeqgcuGToLepWjfPJjxYgZ4Rc
	rQHTgPLq6bzeK2aBKCllJjoGT8sBPnv8BqGQzn6Vx
X-Gm-Gg: ASbGncvkWub/u3leTHCHwmduzEJeW7NM+Zv1Td6T6JBJ+vUlefOK2OjCaeXIvEOgG9t
	o4xaXaYGnbMWYzuJu258RmydxEBvq/XBwAu22EX+AQbDOuQ3dwBudQEycVxfSwrAHgj5SDUTvt+
	6AxuvJzNm9Y/gmmIgm1mzALTnpi4WrXS1MyIEa9MgtsHgFARukhzxa3Q==
X-Google-Smtp-Source: AGHT+IHTFe77unrYK9C7+eJbf2IZV6JzFgf/SfY74D8DPdljUvrt1WKcgPBYC5tSk0+mGANvgDk4AqDQw6/LqYvuk2Y=
X-Received: by 2002:a05:690c:350f:b0:705:750e:37b7 with SMTP id
 00721157ae682-712c639d784mr9888287b3.5.1750367057365; Thu, 19 Jun 2025
 14:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <20250521003211.8847-1-kuniyu@amazon.com>
In-Reply-To: <20250521003211.8847-1-kuniyu@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Jun 2025 17:04:06 -0400
X-Gm-Features: AX0GCFuvQDcj0Q4-T6mYoDn82kX6DVurSN3n5y6exOy2D1H3OZ7Mt_ie8lnZOc8
Message-ID: <CAHC9VhT71e7r6eS-j3o+ruciG1jyrBJ8zvrvQgaf3r+6CkgSuw@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: stephen.smalley.work@gmail.com, anna@kernel.org, brauner@kernel.org, 
	casey@schaufler-ca.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jack@suse.cz, jmorris@namei.org, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, omosnace@redhat.com, pabeni@redhat.com, 
	selinux@vger.kernel.org, serge@hallyn.com, trondmy@kernel.org, 
	viro@zeniv.linux.org.uk, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 8:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
> Date: Mon, 28 Apr 2025 15:50:19 -0400
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> [...]
> > diff --git a/net/socket.c b/net/socket.c
> > index 9a0e720f0859..bbcaa3371fcd 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -560,17 +560,14 @@ static ssize_t sockfs_listxattr(struct dentry *de=
ntry, char *buffer,
> >                               size_t size)
> >  {
> >       ssize_t len;
> > -     ssize_t used =3D 0;
> > +     ssize_t used, remaining;
> > +     int err;
>
> Paul: Could you sort this in the reverse xmas tree order before merging ?
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ord=
ering-reverse-xmas-tree-rcs

Done, thanks for reviewing the patch.

> otherwise the socket part looks good to me:
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

--=20
paul-moore.com

