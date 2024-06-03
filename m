Return-Path: <linux-fsdevel+bounces-20848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC18D85EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA6C1F22E18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA91311A1;
	Mon,  3 Jun 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DBT54nDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68312C530
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427999; cv=none; b=EgP2dFXJUw/0hwukacx4rzNu4TeVNX/PHQObe4brM17OLh6oualOmpP1kw3+vt84POUGQLLgQGQ/QrZw5+svojkgL+BDToIPUsrVsPY/lznB+I04S3KOrzTOgtY3bQgzzWcZWjMbNKGzltrZC3TF5kZkSZ/QP5uzKKt615hgD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427999; c=relaxed/simple;
	bh=NQ95lMcPWzwTE2o3kU0Ae+ZOlNKig0yne1jUrW5+ZI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzM72IqhwQEjJowZ3EapnTmm35GOk429kO2HZ+8CBKgXIdICzwI3DQpzO03UbjoTO7jtsO8ByLH03x+WVNJT/EoEO8ZhhsHoEVrDGMcz6rFOGUb1uYcuPPZULqsra81OWciI//CNgHh/yeVZPZtfTMsvrwQZYKHcAyxsXIaV1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DBT54nDA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a68f10171bdso179921766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717427996; x=1718032796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=woBS2IATcUYSmA3gxVexLIm6p+YGbILHlSrgGqEEWEE=;
        b=DBT54nDA29gh01S8f/V+korNEGWGoUWm3EX6/3uDb3Eyn2E1oNHS4AB+ElO65QPSf8
         9Xjev6wNxGhmsg7bc0fXYPq9WX6Z+fKtsh0rRbeHu0+CGWzMw5fJQ1kVAmVgQyXFMdiG
         V1guAukKADv9pOMx9uNM26XYKxlxsyf/XBvVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717427996; x=1718032796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=woBS2IATcUYSmA3gxVexLIm6p+YGbILHlSrgGqEEWEE=;
        b=DfwGGqYJVoyTUPUCeIh52obivXVw/tblmib6Q+YVIooz0McLsc61f5OMO9QoKFt3sI
         9LGZK01BRr8mMJI+q0h3Jd+pxtp2/AuFzUtbyrvk9o9b3pE72THzOrLRWrNtOBvUzmEI
         KE3c3JCCcDGYPwn0bPncVqlQJzeCmYCDnnq/cEk9gchO968muQUjtkZDgO0F4A+jCPaT
         23oQIeXT8iSxMvYeui7jx5MctAyEsXHwKZ2du5UbbDMlnWEHXIReKhiADtFw6PPLCK0D
         vTzva7HhcdtGk7YZv8JX3bcucWfKGxzx4Op8bs8wtTp67G/FxssbaoAmwTfKDdYa5xme
         12Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWTDsQpT6SKdJ91+825rbc8lkNU2HkXFslRQXKxELpdZeYeJHhU+BxrCfsQ7ClOgaW9MqvXZj62aihrwNj1XtSyrmfNCtqnSnUN1hA/WA==
X-Gm-Message-State: AOJu0YzULIEWdzc66VJtGD8w7QK38KX3hS2uIf5nqLueiGVx29wjvrIQ
	JQcExrr1aiKjJxZFVaV+GJohBbzN8JnOcpj+i6BG4uzUSa5kukqcXraDQzv8vu7+0wfl/AjSvca
	IHJAIXWEPAFX+CcHiN4Kj3b6rvh0HyxGDVnL4ng==
X-Google-Smtp-Source: AGHT+IFiK+1AY6mYKiuFSwJ+GpwFCotbgojMdxXzefTcjLEOieydftGm63EUOLwyGjuudIvwhegCcs7IhunFek4wyNw=
X-Received: by 2002:a17:906:130e:b0:a67:7649:3c3c with SMTP id
 a640c23a62f3a-a6821d62f61mr773336166b.56.1717427995768; Mon, 03 Jun 2024
 08:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com> <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
In-Reply-To: <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Jun 2024 17:19:44 +0200
Message-ID: <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lege.wang@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 16:43, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 6/3/24 08:17, Jingbo Xu wrote:
> > Hi, Miklos,
> >
> > We spotted a performance bottleneck for FUSE writeback in which the
> > writeback kworker has consumed nearly 100% CPU, among which 40% CPU is
> > used for copy_page().
> >
> > fuse_writepages_fill
> >   alloc tmp_page
> >   copy_highpage
> >
> > This is because of FUSE writeback design (see commit 3be5a52b30aa
> > ("fuse: support writable mmap")), which newly allocates a temp page for
> > each dirty page to be written back, copy content of dirty page to temp
> > page, and then write back the temp page instead.  This special design is
> > intentional to avoid potential deadlocked due to buggy or even malicious
> > fuse user daemon.
>
> I also noticed that and I admin that I don't understand it yet. The commit says
>
> <quote>
>     The basic problem is that there can be no guarantee about the time in which
>     the userspace filesystem will complete a write.  It may be buggy or even
>     malicious, and fail to complete WRITE requests.  We don't want unrelated parts
>     of the system to grind to a halt in such cases.
> </quote>
>
>
> Timing - NFS/cifs/etc have the same issue? Even a local file system has no guarantees
> how fast storage is?

I don't have the details but it boils down to the fact that the
allocation context provided by GFP_NOFS (PF_MEMALLOC_NOFS) cannot be
used by the unprivileged userspace server (and even if it could,
there's no guarantee, that it would).

When this mechanism was introduced, the deadlock was a real
possibility.  I'm not sure that it can still happen, but proving that
it cannot might be difficult.

Thanks,
Miklos

