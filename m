Return-Path: <linux-fsdevel+bounces-13126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C486B81B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 20:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C831F2465D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFC15E5D7;
	Wed, 28 Feb 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ikh1klkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012074435
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148260; cv=none; b=BNw6SxX/3N2Oa3R2Q7V/ff1yDdY5hxLjf6zIP3XPpSeOqFEXV+k8GoCi+ldjgeOYAAUJYv27cMaLdMFMxCiMwyw8Ideonzt3jKUbWPRbB/H/zREk0yHQ/T4Mm1i7tNsOaPNhuR5daFBkQrzFwW9wYm/bK7c5Hra49RVyQr02aDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148260; c=relaxed/simple;
	bh=16yvQGF4TqEul7uf//Z255JvkU2yThlRubF/gIw3PP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nweSDAUc4VkONv4HwrrGA5OR8LTLPkIRWNdw8JWTkL9LjAyTb3vcTo2weVLT2at8fEmF8fIV0rdESz/FABMOAzBl3bON/lsCOaAC7Wr6deKPYPLvndV53O4OtTXgSfHNNOvWmavtEZQwKurTHoUlXRIufPLY9waqSoMZdNzf6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ikh1klkC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso22044566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709148255; x=1709753055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LUlsH9mwlheftjt1VnERMRGr0XlA6bQ63sK+GJc4YIY=;
        b=Ikh1klkCY1zX01MpbathS0jr5xmUPfXw+nhtIAqA0gp14WP6M2Y8qOcOzL3KUz2YTl
         U1oWaps0IAUQ86QGkQ/D3/01wgVNchPlvidnNcCb7n0vcrT2X7z3/wYmU+EgaTJuEZIr
         /mJ/sgUv2/R4aDEuEMRK9Kyf0ZzmTLDyaipBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148255; x=1709753055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUlsH9mwlheftjt1VnERMRGr0XlA6bQ63sK+GJc4YIY=;
        b=ES7qCrdcKNENUC0JncV92wUWxyrQtBOr0wvuB/DfgCW+makMqJITHNpeoVzxUby+7w
         XIm5hyEXkW0hrtVrBq9vNIUy5QtzUnDxBmj1gJO8UwT2xQulbLmk1XCMyznS6jYz9LCr
         PGhR2Z+/15hIACVRq9mKPDTXfUh/pg8vEYLw6i8DNfBQvDuJm7BJxDMBgyFX+OJvQm7o
         ONmu1upH2oaFMV0xSqUCBBkPS2y2HXF0p6pWcZj9QQ48pm7qj14K8p5HXajbrvpl4E/b
         flo3yQjCpGV2eM9hyoO7nuooqxrgmOXDFqZLg5SY7nk29oT+JxQ4lIIyq69NQQJn81SY
         tMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWSQNTq4m8gs6v6E9CelTzJL+JSpuqfVrBAUathleUVnox4d/brs4+0/j5N7xlUqCuLZ3qhF/Ud1XuEKqe16l1ks9PLQEQVxH23m5Rrg==
X-Gm-Message-State: AOJu0YwSrw4Hx1+4QJbQWa5W+RY9HlOL04yEjt7LWWHL7dQaDqYjrula
	DZE0MydPjKPv+g73F8U33ynCz6vn2E+PbPth1BgOPq4bbT+obh6FRvf/3GWPSA6ZSefmWNOHjuN
	dN+oDo3+daflddapu4WMn27DqOY2qU1DSdEcCWQ==
X-Google-Smtp-Source: AGHT+IE6IVFHssB3O0XoXNS1Yv6t0hxMflNes0j90lzSJqxQAEvvhPaRuCXLQGSbgCL9X4N+SNOny3EQNZ61LoixIq8=
X-Received: by 2002:a17:906:27d7:b0:a3c:5e17:1635 with SMTP id
 k23-20020a17090627d700b00a3c5e171635mr287940ejc.30.1709148255326; Wed, 28 Feb
 2024 11:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228160213.1988854-1-mszeredi@redhat.com> <20240228160213.1988854-3-mszeredi@redhat.com>
 <fa6cd2cc-252c-492f-adb5-7a0d09c20799@fastmail.fm>
In-Reply-To: <fa6cd2cc-252c-492f-adb5-7a0d09c20799@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 20:24:03 +0100
Message-ID: <CAJfpegsDo-P+tb8BQdhdLeNAKwJnxUnnQoJ=eT3Yd260AxUuJw@mail.gmail.com>
Subject: Re: [PATCH 3/4] fuse: don't unhash root
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 17:34, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/28/24 17:02, Miklos Szeredi wrote:
> > The root inode is assumed to be always hashed.  Do not unhash the root
> > inode even if it is marked BAD.
> >
> > Fixes: 5d069dbe8aaf ("fuse: fix bad inode")
> > Cc: <stable@vger.kernel.org> # v5.11
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/fuse_i.h | 1 -
> >  fs/fuse/inode.c  | 7 +++++--
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7bd3552b1e80..4ef6087f0e5c 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -994,7 +994,6 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
> >
> >  static inline void fuse_make_bad(struct inode *inode)
> >  {
> > -     remove_inode_hash(inode);
> >       set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
> >  }
>
> Hmm, what about callers like fuse_direntplus_link? It now never removes
> the inode hash for these? Depend on lookup/revalidate?

Good questions.

In that case the dentry will be unhashed, and after retrying it will
go through fuse_iget(), which will unhash the inode.

So AFAICS the only place the inode needs to be unhashed is in
fuse_iget(), which is the real fix in 775c5033a0d1 ("fuse: fix live
lock in fuse_iget()").

Thanks,
Miklos

