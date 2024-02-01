Return-Path: <linux-fsdevel+bounces-9822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314488453D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6469D1C26EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2815B11D;
	Thu,  1 Feb 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="o42QU8N/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B115B10A
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779401; cv=none; b=qQo65PXyOQGOh2uac8oLzXjm8p+QQ4j2eOzR8lQe0vm63CtFrYPPlCEtOyLg9PL+NwuFrfagxedT3BdSXEy6w/i/H4eNCgHmN0VYMT0O5u0P8LixkRtwXgvV409IPEV3ehhnCT8YBGhYf4F4T+9q4p26t1vd797L2pEjt2pAg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779401; c=relaxed/simple;
	bh=P/o0U0jRV5smDHEuQY610H2VGAl3tdPdE66Kv2+oDkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF+57arvHIZaR8HVtjzQtlQ76MBOEt5vT6ge5BP3c6SScv3idYxGqqhvDa0acUEMRugHXBllaPxTBdm5981PRYbOZXrBCTvChXrxh8u85lRwQ6xNklnTRvNUDyHUENrObm6uNoqlV1ZaNRlBCbQQRPYwtSKD2MEfCTj9ghnIldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=o42QU8N/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3122b70439so85851066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 01:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706779398; x=1707384198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxYYV7eFNynI72ZruKC6Q2ePZmpMY4c1EQ3Ni7rcsDY=;
        b=o42QU8N/ta/zwWF0OOl+Tj2tpHcsepmWrdlmTan9hqu5mK+3khuon7+a0w0kstN+xu
         YXvKBrfhdgimxMHizn51/vAzMev9R2JaWPHzNKi5kl1uKMhOqKWErzMa1+V04MHRGQfN
         uuAk2APAlJzt2+2xMmSMqM/yktasGrZhm3qIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779398; x=1707384198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxYYV7eFNynI72ZruKC6Q2ePZmpMY4c1EQ3Ni7rcsDY=;
        b=DF1tTv2EK895A6zWGnuMK/dLSMavHQTrde94ubrTEsDfHXdkjW92kZYCMpacmILTSc
         WRlbSq2wwxPTg75haARThQqve+EaNBqxxltB4uXSjR9j7If9ZUJdzEG031/zzJuRPUcp
         ITiVaLYUGmW2JuFypssE4Ih1yGnYWx6afR9bt5fthXDEyMmUwSRTShtCRMbbQt3xD3n2
         RSKGutUmuPj87yn3BMSThPuqPR3gQ3ElYi1OmwB00DSEP0/igiYk4qzwC1VshIthH1Mw
         KlPYqvXvhKS1LPtvKGyr2SFF7fyBu2V5LXZSkX0viCjy8LTHdHHHQv2f+GhIeHwTlj20
         J4zQ==
X-Gm-Message-State: AOJu0Yyx9jSKx6cMIMLGZZFyaBjW2A5InWUkIDGEV4H5a9kTRPS77gPL
	9F0OlmJvGLiKz9isr7z0Q00eYuU49+xsIrEUlcfBAQDA4FP09RzS9LmezB3p02fes+YKajwrjlE
	Lstkk0Z/KX48pHf/iznIEYZTP8k5E4T3dYCWtUw==
X-Google-Smtp-Source: AGHT+IH/FZuoIGaAqNiBs6pUa6EAx9oL2KNEz2zRUqywz9Fk6M66wvgzQ6gWZ+OyvyHJbtESFkv33EsAMU4qU/CbhGk=
X-Received: by 2002:a17:907:bb85:b0:a36:133c:ad2a with SMTP id
 xo5-20020a170907bb8500b00a36133cad2amr2843227ejc.21.1706779397209; Thu, 01
 Feb 2024 01:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
In-Reply-To: <20240131230827.207552-5-bschubert@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 10:23:05 +0100
Message-ID: <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> In preparation for inode io modes, a server open response could fail
> due to conflicting inode io modes.
>
> Allow returning an error from fuse_finish_open() and handle the error in
> the callers. fuse_dir_open() can now call fuse_sync_release(), so handle
> the isdir case correctly.

While that's true, it may be better to just decouple the dir/regular
paths completely, since there isn't much sharing anyway and becoming
even less.

> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index d19cbf34c634..d45d4a678351 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -692,13 +692,15 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         d_instantiate(entry, inode);
>         fuse_change_entry_timeout(entry, &outentry);
>         fuse_dir_changed(dir);
> -       err = finish_open(file, entry, generic_file_open);
> +       err = generic_file_open(inode, file);
> +       if (!err) {
> +               file->private_data = ff;
> +               err = finish_open(file, entry, fuse_finish_open);

Need to be careful with moving fuse_finish_open() call inside
finish_open() since various fields will be different.

In particular O_TRUNC in f_flags will not be cleared and in this case
it looks undesirable.

