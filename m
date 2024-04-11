Return-Path: <linux-fsdevel+bounces-16739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892608A1F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 21:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC9F1F2A2FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED98D534;
	Thu, 11 Apr 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGnUDIW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E62F9DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862981; cv=none; b=gg0vW7F59HX9EXQpljtTN1ACxcXpvNBBWL+Qn2H62+TIou6tgt3v3PWeWVMgwgtcnTD49TkF6oLms+6925PTLCqFSWB+uzppIerQ+mAmO+KvZZqh1eDI7U2YEpnCcYKO0NjQPohb7tShQubXqBDPQLLgU4U8e9Nx6i4z42kELZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862981; c=relaxed/simple;
	bh=pNGS7PL3Q3YJB0ZVZIZ0iegtesPYiF+tOfUb+pWU9rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdJew2Z44165Y5APXQHJzz4dhi/scHQSYpYPWeInBrV3viSeWQYBB1z71/BdFQHQO2m+lIxQIgSb1nW+sOHOubf0W65wDz5wmEnwPlQInxeyf+gMkI+kL+qdWWF1/ZLKIYZbizk4RpFFOWUN32H4qHFF5nWvqNau/6bdAnRTSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGnUDIW8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b10c9cdf4so1217036d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712862979; x=1713467779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhpgH9Z9qXqFvfvUioYha8hRr6JLQXv1CXZE9+U2upw=;
        b=PGnUDIW8Das7KyDsdeah1UrsMzDg7M6t9E8y3zqVV1yF+X2YQrTqF/ChCufIzBbAXF
         wU3hs3w8OHsFWDQjjV8iWVkuc7q3Nu/3jWW8lfBk3Qow1S7d7LznKVglpcjpZALK+RSq
         8QAv5yK0u28aall5zqfoZcmvQrfQ6sJutJtZdwImxKKsLGFyc21dvlFHhFh84I+nsu5y
         mFCPrVblvekNGQ2RAFku3iEUF1Q5GjQ3n//378qhIXc6IHANjiwEQXpK4nCm2PQc8hPg
         XNcCTu+wn2ualSreP4FkiBvTx/o3ZpGX9wrPKm6pYElO6NF3gYafIaQ1FsnfzWyqBLuK
         NVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862979; x=1713467779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhpgH9Z9qXqFvfvUioYha8hRr6JLQXv1CXZE9+U2upw=;
        b=EjAWYPBrf5+Gi50t7xnJD1eUcJnc5X4wqXtpEgZusUtH1oV1eT0+p6PHG2IuKFk4pw
         e/rVEHgcRAcyinZzECz2sYAzPQlcWETX7tlylmYGIFVkRulcUMscbaGrH4ELLDZDLzUt
         zZ2GpX25UjeONsDvh+rvqAxwxj7jU8mchRRhYPc86jXTzH7Ns+if+RQbZQCCCmotyn7I
         HnGA5UHb2y5xkUyRFYvRKH8JO9KoWVVZIHV0evx5DJ+VxmiRl6HwhfNcROYS6S6Hs+Nz
         E/Q5shZnuLF4ZzbfrstGlNF84sgbp5/zcgVQkKxfgljZXFHxazqRdNpGiJZ28/JDQpa7
         vq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeUD5FnQM1YX+xXTMQtRAwh9Tn9nbbuP/u9j3unmnNPGEfgkubheMHJ1iOJAzu9X3y+9Co/gqU+lIddmf56xxldqsF08G6UDSbBwULQQ==
X-Gm-Message-State: AOJu0Yx1+R2w/eKmnr7RjonoHbkhnPv75v/6YhpuklbabNTQntXKjK73
	ilzAG4DN1ghYjfTLoTp7ojWJLzGxLKcKxqH3vJqqobT4LYZlG0KHnqginpV7ApRVyvIxhRqZGXs
	5msErWGqgCzkb23uIp4OZ2erTi6serwx661z4
X-Google-Smtp-Source: AGHT+IGfw7Fj9rJcZz0lVyRkaC000N/pbyxjhWMp0wgV0f00xMv3P+3YAc16D0UgDFqzJhTfRJb/CdCWFldQ6h4t5bU=
X-Received: by 2002:a05:6214:5610:b0:69b:7c6:72be with SMTP id
 mg16-20020a056214561000b0069b07c672bemr730423qvb.43.1712862978616; Thu, 11
 Apr 2024 12:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com>
 <20240328205822.1007338-2-richardfung@google.com> <CAJfpegvtUywhs8vse1rZ6E=hnxUS6uo_eii-oHDmWd0hb35jjA@mail.gmail.com>
 <20240409235018.GC1609@quark.localdomain> <CAJfpegt9hBADfGEAdsBjNShYHB68o7c=gHN29SZHqekdnYzkNA@mail.gmail.com>
In-Reply-To: <CAJfpegt9hBADfGEAdsBjNShYHB68o7c=gHN29SZHqekdnYzkNA@mail.gmail.com>
From: Richard Fung <richardfung@google.com>
Date: Thu, 11 Apr 2024 12:15:39 -0700
Message-ID: <CAGndiTMNuzKot7fKSE5Hrcm=9XQ-0=KsQCnt4wXVtkq0bmVvXg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: Add initial support for fs-verity
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:06=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> Ideally I'd imagine something something similar to how we handle
> FS_IOC_GETFLAGS/SETFLAGS.
>
> Exceptions for those were also added in commit 31070f6ccec0 ("fuse:
> Fix parameter for FS_IOC_{GET,SET}FLAGS").  But then infrastructure
> was added to the vfs (commit 4c5b47997521 ("vfs: add fileattr ops"))
> so that filesystems can handle these as normal callbacks instead of
> dealing with ioctls directly.
>
> In the fsverity case this is not such a clear cut case, since only
> fuse (and possible network fs?) would actually implement the vfs
> callback, others would just set the default handler from fsverity.  So
> I don't insist on doing this, just saying that it would be the
> cleanest outcome.
>
> If we do add exceptions, the requirement from me is that it's split
> out into a separate function from fuse_do_ioctl().
>
> Thanks,
> Miklos

Thank you all for the feedback and suggestions!

Would allowing FUSE_IOCTL_RETRY for these specific ioctls be
possible/preferable? From my limited understanding retrying is
designed to handle dynamically sized data. However it seems like
that's currently only allowed for CUSE.

If that's not a good idea then I'll try to split it into a separate
function if you don't feel strongly about the other approach.

