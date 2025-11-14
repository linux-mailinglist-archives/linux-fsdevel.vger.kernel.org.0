Return-Path: <linux-fsdevel+bounces-68440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF49C5C2A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2E0A355C71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E50303C86;
	Fri, 14 Nov 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWj/V3ye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59B2727E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111109; cv=none; b=Bo2oEcs0rjGtmUteEgLulUym82E9lslKMuBH2NQfqYimje5Iw7Imbd4/cvViumJF41Kg4DQfjW3j/v8VOe5ec6RFykeNywfXRomelo3roWgbRNV2RChzkHghtdsdWYtv+71xB4pIE0qwXPiOPr4GunpRCWsp7H4QiRUPG7z7Awk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111109; c=relaxed/simple;
	bh=O+Dnn8DMSzYrt6UMUEKlwnSeLcmgzuVwwGhUjPYAj8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8BJTifoYSkoAspGsDjG0ir/e6voq8EqQS3OsmJ+dMdkAT2F59eODIFjkVL9rftUgvjF+fAGXGm6wFf5nL2TNzUZr2pKLTkSCPeC7Bi/JqD/JcOKWKWkEQHBIJP86WDuCLkXRHL48UJUn7LNWPNPzKO5kMMrqsT08lxjWV5Vb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWj/V3ye; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso3015018a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 01:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111103; x=1763715903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=590P1F+Abi0Ye9e5UOfcZnWB/iYAfiVbOd0H5hq8/hk=;
        b=dWj/V3yeW8M1X6v+QYUndZ8HbwQAfvyQb1dPqc/IAvoHI+Jo/sngV5gHs6klyOKDbh
         WgMlUNQdwbFYb8nNWqqqcPFQvLfbrmFZgbGfZDR2pexvZYrsXwmWJuEy/4E2dR8iKjsP
         KyHz3NY1hBlwEQX1mdoxgKeuUmhjPvP8VSKY1mqM/ZElQZMhZaBO9rvSmswaReIhei3X
         lEo+E/ZU4rKSjfy9suin9W0OZWfP0zO/yqxn3GFD/rdVPApqoBrgu4LJxxNRr+/Rn7EF
         BVBgj/CTw9SoPu1OVQ/YYKrA7cFDk939V9GGqj+cwb7cFtEtKgjIt17dRVr814+n3hOw
         Nhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111103; x=1763715903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=590P1F+Abi0Ye9e5UOfcZnWB/iYAfiVbOd0H5hq8/hk=;
        b=aPa06odnZp6pY/2gBbLL0rk8RzIAFH7os821lHCqvn7X+GUof9GvRgy0PoWkZdJVbr
         L2YByo5BjNPGduhF5caaCSuXmQlDqCTQe+6o+nEfgEWsIPTNyKMbMYIxBVC92u6DVsJg
         Ypj0uzCjo4XdO5vkeFmnTVfspp6gSJHaPHh6WkGpofQjSLy5sQsow43+LXiqtwvXkeMd
         mrVSGHSTK+gXAA/HJ5u6Jc24vRReRKKpBVO0JvMWqZLYo9iYdE1UuxJkDCL2lRXWJ1Ir
         HA+XanhScZyAq+MmzXzLcYk6EzldSjOw0BYSAC4kGCSFXtqQ+Xi229UofmSPVKUqfIhr
         Inhg==
X-Forwarded-Encrypted: i=1; AJvYcCXEpF3OCXx8WIuNOyT3O20eXYvqATaH9TvkueIIyjWPSwsWbFy7MowNTnEo5ML6D8CODmkXSfgXnZdt39M0@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUhPfTWtTqsKPZ+K7wJT413I2b7mfYvo5lcKoKCivCuv6sa6p
	MmWNYX7aGDeFM78wHLxqgQVJxqgOROsuGkMkyGbESreh5UhWnhBLRPVaVtkKNdyAIyVJrnO2PMf
	vVML+zuYZPVgLQ8G93BBKvbOAZU2b++o=
X-Gm-Gg: ASbGnctcR3ZXiyMowghkbOGtGVjims5VCGMmK59ddaOWEpkC8JSGDkOsYLbvBe6Wlfm
	Dz6cjYgRxqSKOESAIleMYnJ/VByuKg9unguveoE2u3kTR/HNXPGjPqCVC4vJr50LBSaVtlEBFD7
	6aBatGSQeq5X0gJvSHADY3dECdaP5W5aRcYM3yEsqFnEAV5g5JOaaOx1XzynJqV6CczzWqFhl6h
	dl/HsV/wrNe5N/HSkdNFSBJG5hKo0L5FDKYN0VYaKPAnT6uvXG+5xx+09NilJ0s9+Rr6wQknLtF
	uw38yHWm+yVNR69PwIM=
X-Google-Smtp-Source: AGHT+IGJ6tti4Eyass81p7nkkUH/cydyjrRGJiP54q6aqUvgHP/ozurh6DWM/0M/PH1dD6Maf+Q+g5hXlU1S0OIuQZw=
X-Received: by 2002:a05:6402:278f:b0:640:96fe:c7b8 with SMTP id
 4fb4d7f45d1cf-64350e04747mr2080919a12.2.1763111102773; Fri, 14 Nov 2025
 01:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org> <20251113-work-ovl-cred-guard-v3-33-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-33-b35ec983efc1@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 10:04:51 +0100
X-Gm-Features: AWmQ_bmvSOUE8XS8-dGx_2PJjILVwNiUjTy11YSzEFCQvJn9yJuc8ogg6iVVInQ
Message-ID: <CAOQ4uxjeZC0V_jWA=8u+vTw0FDWehdu8Owz8qzO8bTqYVb6A_w@mail.gmail.com>
Subject: Re: [PATCH v3 33/42] ovl: introduce struct ovl_renamedata
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:33=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Add a struct ovl_renamedata to group rename-related state that was
> previously stored in local variables. Embedd struct renamedata directly
> aligning with the vfs.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/dir.c | 123 +++++++++++++++++++++++++++++------------------=
------
>  1 file changed, 68 insertions(+), 55 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 86b72bf87833..052929b9b99d 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1090,6 +1090,15 @@ static int ovl_set_redirect(struct dentry *dentry,=
 bool samedir)
>         return err;
>  }
>
> +struct ovl_renamedata {
> +       struct renamedata;
> +       struct dentry *opaquedir;
> +       struct dentry *olddentry;
> +       struct dentry *newdentry;
> +       bool cleanup_whiteout;
> +       bool overwrite;
> +};
> +

It's very clever to use fms extensions here
However, considering the fact that Neil's patch
https://lore.kernel.org/linux-fsdevel/20251113002050.676694-11-neilb@ownmai=
l.net/
creates and uses ovl_do_rename_rd(), it might be better to use separate
struct renamedata *rd, ovl_rename_ctx *ctx
unless fms extensions have a way to refer to the embedded struct?

Speaking of Neil's patch set, I did a test merge and ovl_rename() was the
only visible conflict.

Most of the conflict is about the conflicting different refactoring prior t=
o
the actual start/end_renaming() change.

I think if you guys can agree on a common prereq refactoring patch
that would make life easier for both patch sets.

I can give it a shot at providing the common patch.

Thanks,
Amir.

