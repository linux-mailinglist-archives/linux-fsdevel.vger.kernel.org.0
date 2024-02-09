Return-Path: <linux-fsdevel+bounces-10954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB2084F5DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA491C22A87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75853F9F4;
	Fri,  9 Feb 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Jei6QD35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90973F9CF
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485236; cv=none; b=Dh392vaYF+WALEH3oERCRHj3TilbOlSQCXl5jBVvyyoFldr/ir6xGEplrpzo4+jZiMHojV9ag2AEGIuTsajQ/V+Ilr+OgqTfl9hJFl0WHE1aJP+Nbj8lsklcto61+vmPDajkbZpxDBR3aS7ck+8GEA2wXSHlGP9RBRoCSMrthPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485236; c=relaxed/simple;
	bh=eT/Jc7OiOyp6dIAUfJMyXt5WHFxuMnxspcqZBhUQefQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZS8q/qlr6/E2iQliqL3MhbJgQ5DFmn8Bp6ddbow3TvQgjUKEm+DDiAehqeX5JWHccFstFbXVjDH7Srk8Ts7YjbsPKxh3hfTCOR2YAFwhTEU7a8tOvoypyJxdDXVMEHfRkts40stqdcve7ZDdCnZtSSXjc79xX3ezLECqMh/DLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Jei6QD35; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3850ce741bso94763466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707485231; x=1708090031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/coNF+Lf8pCX8TmGm8edvPiVdHcmXYMoyUEQ6cgX/4=;
        b=Jei6QD35fOqqIkMTry+DG8zFtoerDjGS5Alkg2KbiKFfKvUBVysot99GXS9gkg97Qr
         eOoW69Qik3PW7bf3e6kSOdYs/0pxXsmVhBNZIyxLzLmL9JP4CaVXR51Jw+SFW91ffxBm
         wY5OuWVpq/92RbjlSwsgisV9pU7rMoj2nHX/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485231; x=1708090031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/coNF+Lf8pCX8TmGm8edvPiVdHcmXYMoyUEQ6cgX/4=;
        b=u4rriznAK5URJ6qHRWORgnsIQNNzhas9QXO4tq5Lp9rq7ynVAkXPQKE9sCQxZ+ty9J
         G2GSJeF68Y5ToZTJ5VjY0kve100NZdHanFekBJymbwHuYTyjwKg/iXTd0343oIvK7KhE
         dzow0AKXj0SIYC3lsCIrKy/R4nnFl1fh25wzRZdWT6X7LbyhbLa0WsyRV7aRrBbBl+Mi
         /QmTLBW+YIrI5WpU6PaeCZ9pe8oe5Vh9lpiDRrVq1xVvd/XAzfboCvxbxxDongJt9Ysi
         uj1EyjhN0MfP6W3ckRuKgDDbKbESECEmWZmw8GDlRuw+rEmqWAJYiIKjKAJ9alpHoN4o
         19Cg==
X-Gm-Message-State: AOJu0YxjCGuvj1zVL+NI96HzARRuBRaPHL2nBUVp5bvoaSBiv6OitjQf
	kjAZYdd+/q7PksMFDFGJcw/Z3a2lKmoHOlbXnNDJfdw8ebR0JhvRXDnulmluXzM08zuH+4sB8v0
	tOE8HOve7SCDxDtcvwg4Td8LhlL3i6QLweQk3AA==
X-Google-Smtp-Source: AGHT+IEa/EJLJSPKj9ReQAcsryaqf811ty6GPohdF7ph0g20WN9kFrcvlUVHk9ho+csKAzyJj68jbClI+5+YTWLwxbo=
X-Received: by 2002:a17:906:af8d:b0:a38:3a78:1d0c with SMTP id
 mj13-20020a170906af8d00b00a383a781d0cmr1017322ejb.55.1707485231163; Fri, 09
 Feb 2024 05:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm> <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
 <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
In-Reply-To: <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Feb 2024 14:26:59 +0100
Message-ID: <CAJfpeguKM5MHEyukHv2OE=6hce5Go2ydPMqzTiJ-MjxS0YH=DQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 13:12, Amir Goldstein <amir73il@gmail.com> wrote:

> I think this race can happen even if we remove killable_

Without _killable, the loop will exit with iocachectr >= 0, hence the
FUSE_I_CACHE_IO_MODE will not be cleared.

> not sure - anyway, with fuse passthrough there is another error
> condition:
>
>         /*
>          * Check if inode entered passthrough io mode while waiting for parallel
>          * dio write completion.
>          */
>         if (fuse_inode_backing(fi))
>                 err = -ETXTBSY;
>
> But in this condition, all waiting tasks should abort the wait,
> so it does not seem a problem to clean the flag.

Ah, this complicates things.  But I think it's safe to clear
FUSE_I_CACHE_IO_MODE in this case, since other
fuse_inode_get_io_cache() calls will also fail.

> Anyway, IMO it is better to set the flag before every wait and on
> success. Like below.

This would still have  the race, since there will be a window during
which the FUSE_I_CACHE_IO_MODE flag has been cleared and new parallel
writes can start, even though there are one or more waiters for cached
open.

Not that this would be a problem in practice, but I also don't see
removing the _killable being a big issue.

Thanks,
Miklos

