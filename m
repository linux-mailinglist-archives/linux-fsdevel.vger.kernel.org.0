Return-Path: <linux-fsdevel+bounces-27787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC1796405F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25D61F228FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470B18E34D;
	Thu, 29 Aug 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pmHloTNA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5318E04E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924326; cv=none; b=gmZVDbHbBsha4CMM2bvlTy7bNDZz1d/n2xuTljI4HxqGYZQPL3170UbeUQmFfX+Uv+WIBwgtJdx/7dmok2pDE7V07KGyEnONH5HXYfjtm/xqpZlE4pqnvHrbHu28S46BYzPxW4srlQdtugiGG6xwAqy2zK0CGxwNkCG/tQLprfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924326; c=relaxed/simple;
	bh=qLAKXH0be/Y9ZXuwwK8d4cy3M8dryqS76vMl11rfg3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3fasPUd7Cu+eUJxG6k9aNsERHDMIuw8oqgmXfcVzFW8lS4FasuydpWlExxwCPrw/Vvy5bRy0G3lFECCMSPIN7rBcPg28rSpJc2dNDXDIujJtTRDlK8Cp0ch9d6386IlZSer8XUtyW71hLF/hY0nytQnU5iz/bTeIJcWK+S873k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pmHloTNA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a868b739cd9so43694666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724924322; x=1725529122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qLAKXH0be/Y9ZXuwwK8d4cy3M8dryqS76vMl11rfg3s=;
        b=pmHloTNACfenOwQn3yuzHUsq7SlnaAfXlh922xBQ95aAaaOpuQYcRtQqvAxuEWHy5J
         VkmM1egODqPGq/2xZaOcxsDAs0gzogW8YPrQB68XS+/LMaM/7y+X9g8IqWrXjSgO1QYr
         d0LpfdulUa3sqRmpIj3QnMampSxByO+vPHNfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924322; x=1725529122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLAKXH0be/Y9ZXuwwK8d4cy3M8dryqS76vMl11rfg3s=;
        b=gpeRytgiYxUdnvMlAiIQCcJo8pYmQLMxOXuZQua5ZUpyo9a3E4qCEsWqwztJ0+cfLP
         j3ylWCJuLxq1mFw/WlqjiUwRQDwyh487yI/QRJqZq/LJY0Ke5hKAuW24Pq2Pbot0KEo1
         qR/mgsNwUIKNZW/4hZE6t6sVMvqUUT5oZ3HjLI3hXVVdUrY9Fbu0btEdd9vn3CBOc+9F
         yS0cu1IBTaUqLlUIR+bbVplbKI2+lqzVzp3gGyoU35+8P0Pfhp6czmgny05VdTNcJKlf
         3H6XirAFG22ah1P0ktK+6Q+c619G4XB9uX14lgctqZZ75DZ+fg5BuQinI8Ku+AM/BkDs
         0HPA==
X-Gm-Message-State: AOJu0YxvIsieyGo4zPg4MWQRiEATRCaSgHQNMx0f/7jBI7H4Utx4ibXz
	4LhKxWta2zSDOvFSleYU4DM3sGtbZRUkZJr/O+iagaaJSZ/caS0DV+/sBjGhWGBPK43wXZwG1G9
	mjljk1V4Z5KRYmXIdyY2TMDHaliEZFdbz7RHRpQ==
X-Google-Smtp-Source: AGHT+IEr1JaH7YSc4mlCnJjI1fudB4hsjo4BP9ZM6wvHEil1DeMhIXW1Yb0nuiAJCyZvpdxhQAPWJ/vGYERxTfHtH00=
X-Received: by 2002:a17:907:7e8c:b0:a7a:ab1a:2d71 with SMTP id
 a640c23a62f3a-a897fad365amr162492166b.59.1724924322357; Thu, 29 Aug 2024
 02:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9fb28d29-d566-4d96-a491-8f0fbe2e853b@yandex.ru>
In-Reply-To: <9fb28d29-d566-4d96-a491-8f0fbe2e853b@yandex.ru>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 11:38:31 +0200
Message-ID: <CAJfpegsbZScBZbN+iaydOD2SKPgfnfj4t=EJz8KyMBX5X3yJWQ@mail.gmail.com>
Subject: Re: permission problems with fuse
To: stsp <stsp2@yandex.ru>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 21:55, stsp <stsp2@yandex.ru> wrote:
>
> Hi guys!
>
> I started to try my app with fuse, and
> faced 2 problems that are not present
> with other FSes.
>
> 1. fuse insists on saved-UID to match owner UID.
> In fact, fuse_permissible_uidgid() in fs/fuse/dir.c
> checks everything but fsuid, whereas other
> FSes seem to check fsuid.
> Can fuse change that and allow saved-UID
> to mismatch? Perhaps by just checking fsuid
> instead?

Use the "allow_other" mount option.

> 2. My app uses the "file server" which passes
> the opened fds to the less-privileged process.
> This doesn't work with fuse: the passed fd
> gives EACCES on eg fstat() (and likely also on
> all other syscalls, haven't checked further),
> while with other FSes, most operations succeed.
> Some are failing on other FSes as well, like
> eg fsetxattr(). I moved them to the FS server
> by the trial-and-error rounds, but they are very few.
> Would it be possible for fuse to allow as much
> operations on an open fd, as the other FSes do?
> Otherwise the priv separation seems impossible.

See above.

Thanks,
Miklos

