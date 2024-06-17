Return-Path: <linux-fsdevel+bounces-21838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E9B90B783
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E802844AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2416A943;
	Mon, 17 Jun 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrHrcJs4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74116849F;
	Mon, 17 Jun 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644226; cv=none; b=Rok5FPrsCUp6Ymg4rorfsA343TvWWEMdWE3quazZQtOAPc2MNetWGUvubhrnR1kTZED4GNWEp+5xIkmEPHwRfBxzG68yAiIikn5AC0HT5pKJbA9xJDcc2O+Rb3n3eigGX/QkUI7mVNgxfWQiFTyICz6b8jL7vuz+8/jXJlobLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644226; c=relaxed/simple;
	bh=f7lK7VGmYzBBx6VWAje1NRnDphBiTs3HuNXvgL0+QKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDraNwawjU/UIx5MHqdQIM1DvSt4np1HQZ/NtPonMOlzH3hmYnzqXMbz/LOIPoyBeak+s/ldu1cOCHgB/BTarLB5MT7OfX+MAGLL89KoGmiGWEXSJvIhW2dPleqe1Q4GOnXm0/Hh08QweG/NMPOYY7x9yui7bM9YYAS3nAQQDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrHrcJs4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7955ddc6516so328462685a.1;
        Mon, 17 Jun 2024 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718644224; x=1719249024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ez6wONf2/2cmZH1p6FhYRBtC2vHp1WfaArV/rCGFFw=;
        b=PrHrcJs4mBXi+T5uuh+YgcSWSgyBapk/EIPHjy/UX7t4HX52tbhISzr2VQksrYmaCi
         UDULXOmArr8kRjmfxVcGsHm4WKjSAX2vWT9wkjwmz6dJUkWUGPHg7SSH0iuSGfcZJiR0
         J3Le62CkEpB0IWIRmtd2XgmNuIx8KB0rkIgm6kNAXT7Qo9sBpCtKhYwI0Tb8YU4gTgU3
         /DjR+gugho2ddln64oCpF7scaiZ1rT6XGDKL0Fdobc1KVPy3W+HQ3TeJGdbd8jRR79V2
         Q90/nYxxg/PKSyYxFBvQmzZPj8tHSgNFHVPFHLXMdTu8WTkQvERxp3/OAhtor+FfuDt9
         SclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718644224; x=1719249024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ez6wONf2/2cmZH1p6FhYRBtC2vHp1WfaArV/rCGFFw=;
        b=ggJ7CQXAJ5SLvop3gwxnY1NFjckOrjWOYy1G2nX6YBPApVgV7qtJJoL5BRFO3gwTd1
         3zxlRVpmx943TpjbJPLxX5poYtRbohU+tRVrvtqxDiDIhKopC5MVy7xW6VGBb7Kbxknr
         8XcLkLG5Bx7OxSIOaBw8T5jaAqzVhqZLgJBPfy4sX8aQa4zO1eSRFUESGOOCyr2dgyCy
         vn8V6WySoMzSrO9Mcof2vgdDPKZv61Ptr/Zqg05AwDVdAX0tPkLktkwfDLRzLXht22IK
         M8fAhI5Ji9S5BRtHU7x4Eu/KNPeUGXvSegrhabSmKoxO5X87kmR+v1HeYJMxcTcrtIR+
         RWbA==
X-Forwarded-Encrypted: i=1; AJvYcCWX1SzTnLF7YjDF0lT5zSzLn/RPyhb2x3iSMZpISZLyHkq5U0PfudSPXjM3DG3STRorz7a+RjSPJ5kGy2hoj6RjxJKz9GfPvAx3eIYas+jGwVUtBhdSj4J9J5xfgl2/vEG+P3WbwdGaTA==
X-Gm-Message-State: AOJu0YweWlCCtBrvF8lLjtjfLGLCnN/hchuAOptRXpm0RgU7hGw6GWxK
	VAxm53dfE9FtXpw3uZ7QqxbDGbDLtCtMUCrQneYefbNxrdQXBGHOFbaypEHhkWsSGwgw1F9P+Pl
	f20zj/TBUKCYrN+MDPyNWD/LSGbU5Rpda
X-Google-Smtp-Source: AGHT+IE9bI2jvgejW/jzxrWszTj6tPjedhG1vNzpswD5en5Ch8uMMStXbN2LpP+ohG6igpZ+tMRJAOhxZlXkWeXTLZs=
X-Received: by 2002:a05:620a:4687:b0:795:4a03:8032 with SMTP id
 af79cd13be357-798d258afc8mr1338207985a.52.1718644223569; Mon, 17 Jun 2024
 10:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617161828.6718-1-jack@suse.cz> <20240617162303.1596-1-jack@suse.cz>
In-Reply-To: <20240617162303.1596-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Jun 2024 20:10:11 +0300
Message-ID: <CAOQ4uxhYuvs5_q+jqL-OAXzfPJv_NJTQpkGPzysGhq4i+WSjPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsnotify: Do not generate events for O_PATH file descriptors
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	James Clark <james.clark@arm.com>, linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>, 
	Al Viro <viro@zeniv.linux.org.uk>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:23=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Currently we will not generate FS_OPEN events for O_PATH file
> descriptors but we will generate FS_CLOSE events for them. This is
> asymmetry is confusing. Arguably no fsnotify events should be generated
> for O_PATH file descriptors as they cannot be used to access or modify
> file content, they are just convenient handles to file objects like
> paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
> file descriptors.
>
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  include/linux/fsnotify.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 4da80e92f804..278620e063ab 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -112,7 +112,13 @@ static inline int fsnotify_file(struct file *file, _=
_u32 mask)
>  {
>         const struct path *path;
>
> -       if (file->f_mode & FMODE_NONOTIFY)
> +       /*
> +        * FMODE_NONOTIFY are fds generated by fanotify itself which shou=
ld not
> +        * generate new events. We also don't want to generate events for
> +        * FMODE_PATH fds (involves open & close events) as they are just
> +        * handle creation / destruction events and not "real" file event=
s.
> +        */
> +       if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
>                 return 0;
>
>         path =3D &file->f_path;
> --
> 2.35.3
>

