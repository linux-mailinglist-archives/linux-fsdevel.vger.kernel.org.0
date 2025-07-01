Return-Path: <linux-fsdevel+bounces-53560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001F4AF0216
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77593BD9FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD227E7FC;
	Tue,  1 Jul 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="k7+un4vW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AAF27E048
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391719; cv=none; b=rCZI/htqc+B9ncPiou+8dJHSA1hCWUYCWvsuX2RfiaVVsY7i04bOLLZwtBPGExo2Ki5lqw8AJIrZEv8FAVqVWR5QE9DFRSuiW5XzMjZ+ABOKZSYlUZ7LQ4+gaLiIkGOvIAeCEiNqGxvuAyhx1fexlZtwA3XdD0cQsyo+85J+fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391719; c=relaxed/simple;
	bh=vo+jsSLa7JU5IyWo2puh8gDfkbcKEmpzTYMYLg63hs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni3eSnYrFih1eDzQLkyo/figJKdx6uAg+jEd89JjJQkoYrI5yw6ZzkvvvRmHgL/bNMl+rIG4oHZdVa0lQtzJu/KvwTlgR+KbVwprTbNb4WTl/UViaxef2JyDcSqaCEAtr+ogrP2UQcjeOWcFfX3V/OIr0syDnz7+llM9VN1N6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=k7+un4vW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a442a3a2bfso61052361cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751391716; x=1751996516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz9gxtHvV0hde9hVIKSffqOhDz+stlEZIhL4Ftpkdm8=;
        b=k7+un4vWzopGCxZOXWfMTCpCmdQMKxWfjrvxHhklh2uUycV2Hb1a7s2Dq2q6ngysZU
         Eh9qGTP9j3lccDeFOOv21ZXrApgKJEI3osZaWhshMPqB8zNOJxV3qiUnQnJUf17mtuTA
         J5WDmStotfDHqrD3Oep9r2O3rPHpDt8v+6crA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751391716; x=1751996516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uz9gxtHvV0hde9hVIKSffqOhDz+stlEZIhL4Ftpkdm8=;
        b=drfLVdgI6e9KDcPwuUVhSoHyWhtU9BkXKWeSvpnQmjJqaKEad+VqnbcgrgySaHZWzw
         m7D/ZEBQwZ7TVNlBxlsTsp6R85t6atskGRy39A7YUoxt3FGvNCFQmOmSc20JKtSuaIb1
         KfwkMN6d0reNwLMCBmh7fcffUhVGpLIkLtns7eEnvm6piuOp3TcJqwkbjuzk7XGDTNWl
         MdkaiplWsFMDgT3tbnAWOJ+K+R7sM9Hb8HSUHlFUz96AH6S5C3sAArPHS9XP/yjh/la5
         uTf8oPGfpqGqXlvi8Ys476oKhgsqDf+kpT3E2R7NoQZ3laW/deoaylubgVJMJ6G0miuk
         m7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqYnanbB1XOZVAXnvIB7BUZQAoRqHP6uNLcN9oX4GLwqu9yGAbXQZWg+3ak62T9F3JKEBoKkkvb7jW3acc@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSNGnRyRNp+4Y4B6Z8FlbGpKJnQJCwlUMemMGSg1Nyx8vuflP
	kZ1EU61hJjoPTKlbWMtnCwyn9q6BR29+B1mhZrrG83t3A7KfXYZIBkeXYAPGXQrgUVLM4Jn9UP5
	AqgmIq0rzap7nHxsFFXBcLri5pIcYjXAB6X9ZWsi5vQ==
X-Gm-Gg: ASbGncvcfq1MA7j4lgnqzax2xb+OjHS7ndnNRo9LTFQb7FoGHnTB1hXgeYq2obfhhia
	Qquy+Z7F0M7wqGCl3MwZknQXMXlTicDze+498iLXhPhJn2PScvx5J3CnR5sc1R9SXLzsoBerSg8
	M9ivkuz9oPmWa0B8INLkKKnRCzMor/pazl/SOtUQidF2lx9an/qs5hUWyD20TTOdTxZs+288UaO
	pDw
X-Google-Smtp-Source: AGHT+IFAguzY7Hna22OMNWaSfgeB2t8ipomsLv1pH4YwBbEzWUlXYmbu+ldhrUxhzS4BdlUNdvBk2bxHYF3YnWukajU=
X-Received: by 2002:a05:622a:30d:b0:4a7:f9ab:7895 with SMTP id
 d75a77b69052e-4a7fc9ca69emr297652251cf.4.1751391715752; Tue, 01 Jul 2025
 10:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701142930.429547-1-amir73il@gmail.com>
In-Reply-To: <20250701142930.429547-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 1 Jul 2025 19:41:45 +0200
X-Gm-Features: Ac12FXyGnQWcOSjNvnf-sEx1GMXUZppeDO2dYzXnmlfXTWtjwRASiJG8thdk__0
Message-ID: <CAJfpegvjpcsbNq6dpu5pdpfMUqcaKoqY5gAy62jq2V_rU55J5w@mail.gmail.com>
Subject: Re: [PATCH] fuse: return -EOPNOTSUPP from ->fileattr_[gs]et() instead
 of -ENOTTY
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Jul 2025 at 16:29, Amir Goldstein <amir73il@gmail.com> wrote:

> index 6f0e15f86c21..92754749f316 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -722,7 +722,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
>
>         err = vfs_fileattr_get(realpath->dentry, fa);
>         if (err == -ENOIOCTLCMD)
> -               err = -ENOTTY;
> +               err = -EOPNOTSUPP;

This doesn't make sense, the Andrey's 4/6 patch made vfs_fileattr_get
return EOPNOTSUPP instead of ENOIOCTLCMD.  So why is it being checked
here?

Thanks,
Miklos

