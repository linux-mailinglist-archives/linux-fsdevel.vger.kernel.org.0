Return-Path: <linux-fsdevel+bounces-73051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B31D0A042
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 13:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9ABD309321B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1C35BDD9;
	Fri,  9 Jan 2026 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mBuea27j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA235B133
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962325; cv=none; b=B/dYBPQA6A0mWGPsLabYErZ8niZW0UQ0vZ84O339rvmUi9BI3wp+6DWOZyKwkHbNtF/ceKEQJ+PdvrxFmVbZQ2idM521OTwp6fgxHRY1zGkfNLCs/e8gVfW0QGzY/1rpiQHq7Rz++NIOxlIQeEurd1KhplQKqRiHcGFK1Momrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962325; c=relaxed/simple;
	bh=w0/bscQ7J6JUtueF0P2lJB2+eSYbcnb+3dMr7mj3YZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1KDdY7tu3+jus5T/BMG+gKsLjPDBo9R5Qny4O4vQwp1Iw8llnFzZEj+J52B42RtzA4R5GLhc/6W6HblY7C44N9+6yJceQDo90ZglOv32p6xAjoArOMFIsJABTnrAbdN3K3t4k40U9bCOGei0pimKWVGNWMJems4EhzPZPurVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mBuea27j; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b04a410f42so3444046eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767962322; x=1768567122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQJsv4Dj4MBtqV/JXrC0+1HqqDkJYiYEpDs3inEn0Zk=;
        b=mBuea27j6hUMOtBAWmX1mxXAM00Lk++Coa+vM3ghFU+frWaDFB5IE3vq9hp2/JwWVQ
         QQHUKepGQZQvCJJQu0yxrXErteNZGPWw6CBZArYHZsPepSk7moWMFd1JkiERmmfXB4Kz
         7RydAp4nntMTDYDooQqtdhhCBubvfAYj3DJdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767962322; x=1768567122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQJsv4Dj4MBtqV/JXrC0+1HqqDkJYiYEpDs3inEn0Zk=;
        b=OKGHZYkakXAPcpnm4p0wd1nJ1tFVLpT2UX/Y/lHEc24lbVY/m7hYXtyTnMG3FvrrgO
         hBzAyOOr1UdhizzvbxMu4nzin00XaHIi9jrlLI1ZGS5cAB0wEJ9vHpoK8CcQmDgh5OA7
         cxqBB95/p+XHH5Z3lYmyI92VcOEflDdmuuS2f3b5BUPzR/MZYqn9xenN6+KN97nc6/Wk
         R6Zp7aBAUojV/780QeTBEl9Oa7TyUKF+5CIn7d2nqkKThrfTb/jHZii7VQ3I7WsUaSGM
         +1/38c0x7MpzYIfbPimzV0NAucQhwI/p4VkCiw2T70nHk+Cc7+ZSNJYk1PYzxRcxYl/X
         PzIg==
X-Forwarded-Encrypted: i=1; AJvYcCU9yriyFovc2q72xJMil6mkeQZ7qu3l2G2LAb39Foyl/UH7KfaybAzDcPFQHjVVzQofAO7goWu1h77zBBN6@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVMPgkNCGQkAvGW/UmXG3RpUxmoZsUUBzTqMfikRv6OL8l8k2
	I7e2xghusU9tIaB0Sqk5xVVD2BDVXDZN3W4HAhPXtBKs6kGD6m4Q6aivhBPpeGtb9rD5iJhZKjg
	AR4C//ubJH3LoCjj/1XNP9tyfAxeNYF4BGDReuU+mUw==
X-Gm-Gg: AY/fxX5K/RMOhYsbuD+Kdy/ljtIsSpRzpEUNizzcD6rAjqPnGrVyjn/uKselrQuleMG
	3E9dCykBgF9s7FkfUD+SXlw8ADJiL2GfWKBnAqApUoLfiZ4vrBDL/5As6JZKy14JAyysdDi09jO
	RFNVR4g8iZBjo9fwSu/Sy9HjXwTlJvgapXeZGUaLw5k/fRNco5a2MdYllttB8ecZ+F+CUjf2+ZR
	JDB6OvcAc1bfXw/r640ZxPUFVz7tGS5RO795M/oLo2z6HgXp8B9CysZL/W/d84YipTa
X-Google-Smtp-Source: AGHT+IE6RGTYNFGWr1bDZOwdfO45KsQF9cYcg9cUD8BreIfg65Hx4serUDRPPWTMuGgqfCqlww8Wrkbo+61sFryEDhY=
X-Received: by 2002:a05:7301:7108:b0:2b0:5609:a593 with SMTP id
 5a478bee46e88-2b17d26717fmr5507307eec.16.1767962322041; Fri, 09 Jan 2026
 04:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com> <87zf6nov6c.fsf@wotan.olymp>
In-Reply-To: <87zf6nov6c.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Jan 2026 13:38:29 +0100
X-Gm-Features: AZwV_QhSIUxuWrzQVKaJgGZ_yHF7U9q04yphYG9kmea3ARSZEpjIOCP6bIrU9Uo
Message-ID: <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 12:57, Luis Henriques <luis@igalia.com> wrote:

> I've been trying to wrap my head around all the suggested changes, and
> experimenting with a few options.  Since there are some major things that
> need to be modified, I'd like to confirm that I got them right:
>
> 1. In the old FUSE_LOOKUP, the args->in_args[0] will continue to use the
>    struct fuse_entry_out, which won't be changed and will continue to have
>    a static size.

Yes.

> 2. FUSE_LOOKUP_HANDLE will add a new out_arg, which will be dynamically
>    allocated (using your suggestion: 'args->out_var_alloc').  This will be
>    a new struct fuse_entry_handle_out, similar to fuse_entry_out, but
>    replacing the struct fuse_attr by a struct fuse_statx, and adding the
>    file handle struct.

Another idea: let's simplify the interface by removing the attributes
from the lookup reply entirely.  To get back the previous
functionality, compound requests can be used: LOOKUP_HANDLE + STATX.

> 3. FUSE_LOOKUP_HANDLE will use the args->in_args[0] as an extension header

No, extensions go after the regular request data: headers, payload,
extension(s).

We could think about changing that for uring, where it would make
sense to put the extensions after the regular headers, but currently
it doesn't work that way and goes into the payload section.

In any case LOOKUP_HANDLE should follow the existing practice.

>    (FUSE_EXT_HANDLE).  Note that other operations (e.g. those in function
>    create_new_entry()) will actually need to *add* an extra extension
>    header, as extension headers are already being used there.

Right.

>    This extension header will use the new struct fuse_entry_handle_out.

Why _out?

It should just be a struct fuse_ext_header followed by a struct
fuse_file_handle.

Thanks,
Miklos

