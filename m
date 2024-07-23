Return-Path: <linux-fsdevel+bounces-24155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D0093A7F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 22:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0530DB22F07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 20:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB6142900;
	Tue, 23 Jul 2024 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VnRyOq+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357C13E04C
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721765025; cv=none; b=bHR3/kj13EPsI7k85axe1uKW57Lo/fJsAdFs+P1IOo9uhH/dWSZ6qelrO5B9Z2TrJ9uHMcUEgWzPj3kOQa892Oo9HJInziefig7AHBF8QJDE4nB1UQVE6qo9+D9XOLI7HqW377V7F6QUPf1Rvc/002pLjKXMiUSl6bgA5M821Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721765025; c=relaxed/simple;
	bh=EW7tXQ/dDezLqgDLVIR2g+sGxfuFTpd8ZsbHt0DMCP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUouu+7/muOi5Kmb+Rx3b8IWJWT3gzgwu0Y21xF0eMPEWWGz2zli7Hqm1BVFznskxfhbEG22rqfRcJBpX+6EtOdeZSyIAMc9XCGmaRBNqSvtykNafuY2y9dCHZ4By49SxH0ufaZn9WPB8oEGArd1RJ9csg+DL3cCQVk/NvmdPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VnRyOq+8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66ca5e8cc51so31018867b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721765023; x=1722369823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zkmFWPNDP18w4tTLctdaq0+UuELeqaf2zWP++6uC88=;
        b=VnRyOq+87uoCg13ULFkE99JxVtKvBD/BncEbz1LjMBEtbdDyY+qKzOIWs1kbyU0mvb
         OKmrerDlVGVtO9c5BK7NJLS0Gjs0/0fkBFbv3txbQb7ddTKuTzl1m5uGR0gmDS894v0k
         IDnWg6IvHS6MTnX95lRsqwHzoZWSo/dRKyJx+tjG5y2gqHNUJVSTqyuMJr7AdjyJvzir
         zMt2PCJLpQq83SutKRVEj7MhfR4m1dPGyx+zH6nvVoPN1FATNtBNTORG7VhkkcpWMHoo
         WbXTAeV2gK2nmmlUI5ZMGYgff0lesy4i88oyseGqUARcSp1osxSBxAaHOlXh1QRqW8sC
         kKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721765023; x=1722369823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zkmFWPNDP18w4tTLctdaq0+UuELeqaf2zWP++6uC88=;
        b=CrTo1ccH0kkxy7R3TuM0NGRIkOlCeKXNb+MDm7pJOpwp83GqLhlBGjs3xwQ2b60N5y
         qd2Ru471wUA3AXWbeIOvtW1NMgrVbgm5ECZQgEu3FlPIr3rlBWks+auxDQnIiDoU5WIr
         5xy2acLhiggsb4a5REQpKIx1NG8ABT2l5Od9YpKUMBlbxVjXcX1hTVcnkE9eLeeHKMWZ
         mgx+pMxh49BhHSvh7NbIZfwNx6c1ZYJZmMX8Owq1vE7PEohD+8Df4FoNwIhZ3vJESt8K
         G8UUqIV26hK4gTvb3yt5l64R6GG1PcXN7tRWbfP9apjjPEPVdQeQkRiHbgPA2WxzvG8N
         0FBA==
X-Forwarded-Encrypted: i=1; AJvYcCXyVf53yCERAkIJi4Nvad5UwtdwaWkvPgu8vaGGFndc47ofhJX6yGzwU67McabLfjoj7kC+4V4JyOCMP32A6fISrhQet8hoN2dVHucDhQ==
X-Gm-Message-State: AOJu0YyetyIpupu3g6uCjDtI6VtKoep5PdIUz6JRtLw/xLIR5xzunuIH
	gTsytNE6Qe4s+FEqfx18JjxZstWp724qphJiumHTlYD2jtv9gyCDheiQH//4fjFymXWpSjv3yJ7
	SA6DgzAlCEjrRznLh7j4qwO++sjl1xunfcZJg
X-Google-Smtp-Source: AGHT+IEfazfbOemV8hCZhxxwW/FjHC35kfoH0DBZR1Q+/miCrhP3eAS+2l6Jm94N51uXa/nZLYgDH9KjDYVHSUG09i4=
X-Received: by 2002:a05:690c:2e87:b0:627:de70:f2f8 with SMTP id
 00721157ae682-66a63a73e77mr128588017b3.14.1721765022700; Tue, 23 Jul 2024
 13:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk> <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
 <Zp8k1H/qeaVZOXF5@dread.disaster.area> <20240723-winkelmesser-wegschauen-4a8b00031504@brauner>
In-Reply-To: <20240723-winkelmesser-wegschauen-4a8b00031504@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 23 Jul 2024 16:03:31 -0400
Message-ID: <CAHC9VhTRf=9oq1dyhEtmgX-dZQJcs7qFBLHKdaHOF1eX6jnPCg@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Matus Jokay <matus.jokay@stuba.sk>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 11:19=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> The same logic extends to security modules. Both selinux and smack
> handle MAY_NOT_BLOCK calls from security_inode_permission() with e.g.,
> selinux returning -ECHILD in case the inode security context isn't
> properly initialized causing the VFS to drop into ref walking mode and
> allowing selinux to redo the initialization.

Since we are talking mostly about the destruction of an inode, it is
worth mentioning that the SELinux -ECHILD case that Christian is
referring to isn't a common occurrence as SELinux only invalidates
inode labels on network filesystems under certain circumstances (chase
the security_inode_invalidate_secctx() hook).  On most normal SELinux
systems inodes are labeled as part of the creation process so long as
a SELinux policy is loaded into the kernel; this does mean that there
is a window during early boot where the inodes are in an invalid
state, but they are properly initialized later (there are different
ways this could happen).

For local filesystems with inodes created after the SELinux policy is
loaded, inodes have a valid SELinux label from their very creation up
until their memory is released.

--=20
paul-moore.com

