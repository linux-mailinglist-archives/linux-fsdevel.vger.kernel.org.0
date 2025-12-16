Return-Path: <linux-fsdevel+bounces-71465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0FCC212F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91BD03015940
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEEE342504;
	Tue, 16 Dec 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F3QNoPSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AB342173
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883264; cv=none; b=qGAlYdTN0zx5ScDUeLKUfjO0X62dhOErh73+P/MWto0ce/5xc3oOWIIHFyhfZzl1GhgLKLWWAFm0ij2uHZcPRtelN0zp84JU2aK3eteHVBlZkEGwCt3uP7jCuLyNWsOU3uxHbnJ0/C4px06BT4KSEiQaueAHH4IFWlzm8eXZa7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883264; c=relaxed/simple;
	bh=lMTuLIsxhCVcnKQD731XO5NCZxpeVjppKafwI5jqz5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrERUtD1paxB16SAGGx1SsUuNyZO+5h9httCBfmKzmY3gdAzmmkVJhxXJLaCp6iwV3C8yJDESOCC1rykcAPCbQ7lAR2v7daur5Ub68E20c/rNgP6PeNMoBIiYej3tfqh7xOCiTBEmYjfAmFKDv2OwIaObpeh9waOwtgqxsrYRk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F3QNoPSO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4eda77e2358so39338741cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1765883260; x=1766488060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlzdekFkPm3sA+OW/VE7mJ2R9Cdqzm7oPJWDRazhBmk=;
        b=F3QNoPSOLHtXZpTA1mocyDQo6ZwChh0UI70YZblJ2LSwZC1CXpyQrkMXxdktfF9i3H
         F26Z7odimtVelPLL1lqeSKuzkZqD/uueCvLiP/XnoIup5LPVUt25kt1Glc/QcdcYWgBu
         SfJ2GscG/XoGAKaSCEbMkBj3Sm4GkEHUVNdUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765883260; x=1766488060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlzdekFkPm3sA+OW/VE7mJ2R9Cdqzm7oPJWDRazhBmk=;
        b=nKeFO3vcxO1gptoMSniho2fVmj5YY7Cdija24KBSOTgCtH+6EvRC6B2NVkU//XHr5s
         V+y1mGtnEA6wI054ydBQlGJWAqToHBQ7PSOrkaqseTG02P6U/UiI/ci6LOMFLjJffJoh
         heZ8rg01H0D5jRZwc6rtYvTqNy/fYzCfjKNGrh2AZY3lTm84elnZlaygG2XH7yWNbcun
         E9JlL6TL3qbHPfLoSC0DOqfZ/n5kV9o/3r2ybLiaMCCYRryw5juf2dpToRYM4A4hJj7T
         XDvlmqyExTSslR9GQE3TTfKOxXlTOyc2ED/RXwk/mO2eFzZZhB3Sg6PPWJmZ51dOUjG/
         34Pw==
X-Forwarded-Encrypted: i=1; AJvYcCW6kAEgGZ9pM2+lNgpqNr0dN0neGYPt03+b429i9cFxtZaTj4ZT2JgS4lGF/FpvVrrScOdiIrJQDkaTIov9@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJGsAAffqq0RVgJvQU+HhWWK0SFiebURFglog7vcI1Rp+eX2p
	rBdFjiKpivDFzgxA5KqZtUxeVo/inDQhIM1ir3FyODs18f0Ei9hMyas8yDmtxENPWft1AyHhhSz
	1jpxc/NFwrTPc4xkZYVzEu3kNO1SuICygNBncEvPwSQ==
X-Gm-Gg: AY/fxX5Idt/849sVqb5BDqUgpVIEN6Iea2scqE1DppXr4V8ihVwsphf/+hW2lmLsme2
	uS0gJrbpa5lqvNQT29RtM3fWs2S8i+JeCYJ9ZwTrt6gw4ciAkv61aGuTvj7GHK5pR35niXF5Y3+
	E/VbC9+ABOI65Z08vpYb+fGW8NZ/Zumr79L4gZBbNe8K/mZbDywL5JQiwQGgtPpVOJwFVln6NLd
	2/LelkWrVBRFZ1JZdIJy5/fcxSFSeG7NO5VYcVOXskRlD5hIf2pbFjA0fcpIs32Ku2WIco=
X-Google-Smtp-Source: AGHT+IHRZhDQXlj83EvfZqPralOneuTPYHNmYBl1MCKvewvqN5v5F5ckiqPKoDO2q8R3kgqLBjc3HYhf3J9Rm/jMMPg=
X-Received: by 2002:a05:622a:2609:b0:4f1:c76b:d003 with SMTP id
 d75a77b69052e-4f1d064f3b7mr195647731cf.78.1765883259712; Tue, 16 Dec 2025
 03:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com> <CAOQ4uxgY=gYYyc62k-Xo7vgrSHgQczC_2d4d-s445GK=eWpKAQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgY=gYYyc62k-Xo7vgrSHgQczC_2d4d-s445GK=eWpKAQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Dec 2025 12:07:28 +0100
X-Gm-Features: AQt7F2rmplW9HvQv8QSWxtHcWv1558gyJc4pE9IF47--Tzp2n2meFK7r2OBZrhk
Message-ID: <CAJfpegvM7UwdkTG-aaqTxAAqTgfxGO7uAd5cL3dcQUjM90tFuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Dec 2025 at 11:52, Amir Goldstein <amir73il@gmail.com> wrote:

> Keep in mind that we will need to store the file handle in the fuse_inode.
> Don't you think that it is better to negotiate the max_handle_size even
> if only as an upper limit?

I don't see the point.  The handle will be allocated after the lookup
has completed, and by that time will will know the exact size, so the
maximum is irrelevant.  What am I missing?

> Note that MAX_HANDLE_SZ is not even UAPI.
> It is the upper limit of the moment for the open_by_handle_at() syscall.
> FUSE protocol is by no means obligated to it, but sure we can use that
> as the default upper limit.

Yeah, but even that is excessive, since this will be a non-connectable
one, and need to fit two of them plus a header into a connectable fuse
file handle.

Thanks,
Miklos

