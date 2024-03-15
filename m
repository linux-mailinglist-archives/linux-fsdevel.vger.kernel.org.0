Return-Path: <linux-fsdevel+bounces-14450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54BF87CDCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D20A1F2134E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEDF2575D;
	Fri, 15 Mar 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U2712HQN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5725543
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508206; cv=none; b=qNCUuqIB+JMCZOKwdyO2E5MWp06kVLobehUqUgwAUYcQAKf1ATOVAGJr9f8P7KllQxAUDiC87H9adzAf1BVtsTh9iabAfbTYYlj47zvh2J9mfY+ZeBNk5e+uSbd2PruwP0VoCLg7lauKwHjN9ch4qctti9Lmi1jVdzP/Co+jEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508206; c=relaxed/simple;
	bh=Oa3Umy36YobvTEyJhUdMvkH9ELj1sL6BHsH5KZ4jzW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAAjHNaANxOpLWPLZkK2mb2uPQbHpS1BysDs2VzKCnUivt7wVtQccFXTwxTgdf8iEnEqyz/UfUL9I/pUR+obZqkZKPhoBipcEG4AazpQr2OugtkG72v9eduHdNB9NGm2Clc+NaXq6Y5ch5ptjrmdvPwkluCtiJlApH6GEyRVZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U2712HQN; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1816016276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710508204; x=1711113004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMezNXkB9TO/Do+10PK7yOkqjtztuGFODtVVCBpPxvk=;
        b=U2712HQNOvzirtw8F1U3e3Uf1roP/CNc7arEsbbGZyMUsfV3sY1vaUEnmc5KBthOzF
         0IrCdMc+XOwpau4lyBcCgct7sHgvhLADqeQ2C72GXMUZfn/vw/kq99+3Z6+wU4NXoqMv
         Y5AD/WgXWHti0SNysYkOh8BzEyR5IM0XVHMv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508204; x=1711113004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMezNXkB9TO/Do+10PK7yOkqjtztuGFODtVVCBpPxvk=;
        b=Vy+oHUuvhdBvioDq9wqt6nIyjELp/MP3iGY4wWfT2+bv2/Rphq4KRQLWb8vaR33vk3
         GWTNxZo5KFojrc7V21Vn9uM+MZwBS92KnzT3MGSsoENPXPPquHHMPmlqTKwqemfQacV9
         omuFHnPeRk1FxhXtPV1wkXaoHjj92n84lwIPoHtyDtSsUkCLJPcqZE3e615kwF/I92qZ
         AMX8Swpj3NlNhVN6l/xwmbIT+dCaOdW/sY1ZtCazCd5sagL7Diz2+2Im6dzmjioVW61r
         HgO94VGbIc4I/+E15z9qwHsWFhT0m1komzVaHSlcuWkFUVATHMXcjxK61VV3iKZCTdo/
         OzKw==
X-Forwarded-Encrypted: i=1; AJvYcCWkwNx05zvBiN8qEdZwPIjUJI4hX9uVTJFccU/HjKxpuGdGpKgBEW4u6FBP3vvzeg3ku/Oc6U+Fkx8ZazuU29eyNk2pm1K+LLPHNBE8ag==
X-Gm-Message-State: AOJu0Yzz+tTXi8kHLxQrjgYw56hEROrJG4YClzAQD14fCF6hTF9KhG2I
	rXT19mwPcRreR+lpkNN+PEDstjJCoH5d7k3JKfknsgXvqC+rAODvpbyE9v05wapZ7plSZWZgSra
	EN0Xb8ylooYOEwIzllacUN285nETDgAWYUsMh
X-Google-Smtp-Source: AGHT+IHA0EnM2M9nAzsP1HCtdKzQPO3GMdhS/V1u7qfs5dzMzC1XW1DoI2/JVWjz8Fkwzo2hLLJ5zH3eiul9g8sOb2M=
X-Received: by 2002:a5b:bce:0:b0:dcc:52dc:deb5 with SMTP id
 c14-20020a5b0bce000000b00dcc52dcdeb5mr4880388ybr.20.1710508204031; Fri, 15
 Mar 2024 06:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023183035.11035-3-bschubert@ddn.com> <20240314103404.2457718-1-keiichiw@chromium.org>
In-Reply-To: <20240314103404.2457718-1-keiichiw@chromium.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Fri, 15 Mar 2024 22:09:52 +0900
Message-ID: <CAD90VcZndHS5f=ZKEkpDMtxQ80J-bAER8FEVHjV+qfUjrLUPbg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Do NULL check instead of IS_ERR in atomic_open
To: bschubert@ddn.com, linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com, 
	hbirthelmer@ddn.com, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	yuanyaogoog@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I realized this patch was wrong, as I misunderstood the spec of d_splice_al=
ias.
d_splice_alias can return NULL in a success case, so the original code
was totally correct.
Please ignore this patch. Sorry for the noise!

Keiichi


On Thu, Mar 14, 2024 at 7:34=E2=80=AFPM Keiichi Watanabe <keiichiw@chromium=
.org> wrote:
>
> Since d_splice_alias returns NULL on error, we need to do NUL check
> instead of IS_ERR.
>
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> ---
>  fs/fuse/dir.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4ae89f428243..4843a749dd91 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -914,7 +914,7 @@ static int _fuse_atomic_open(struct inode *dir, struc=
t dentry *entry,
>                 alias =3D d_exact_alias(entry, inode);
>                 if (!alias) {
>                         alias =3D d_splice_alias(inode, entry);
> -                       if (IS_ERR(alias)) {
> +                       if (!alias) {
>                                 /*
>                                  * Close the file in user space, but do n=
ot unlink it,
>                                  * if it was created - with network file =
systems other
> @@ -928,8 +928,7 @@ static int _fuse_atomic_open(struct inode *dir, struc=
t dentry *entry,
>                         }
>                 }
>
> -               if (alias)
> -                       entry =3D alias;
> +               entry =3D alias; // alias must not be NULL here.
>         }
>
>         fuse_change_entry_timeout(entry, &outentry);
> --
> 2.44.0.291.gc1ea87d7ee-goog
>

