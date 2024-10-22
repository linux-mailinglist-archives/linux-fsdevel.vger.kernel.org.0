Return-Path: <linux-fsdevel+bounces-32591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734F9AB358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2671E28592F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DE1A3BC3;
	Tue, 22 Oct 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LY/3+PXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1413BAD5
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613070; cv=none; b=SFTWL1nEXpOZq2zRMh7nUzU3ss+UxK5CbR1OCo6q7OVgRvWDHI9cvbTfdur+NTBwppgo//+gv8H6j8WRlro+slgavn+B/tokFxfFBkZgZSZLvxMjOhr5QWgZgSCyGwMWRvc1StpH9NXjlRhZ3f+w+aVI9td0iG8+rl0y4Uh44y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613070; c=relaxed/simple;
	bh=rmzUYtQyJIjh7ToRh48kfdgdfypbRGk/KTLvhH5S/Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOXyxL64+MbtsC/f6hCdR56m89Dbq9GH1JRV0nDi1XlV2wcc75YI1A5ghNQlJjOSfb1dnWKMqtCAxqn7IyLhbgZNUPqRMBx/WiVrihDYc9qeTmgPWwP+7CZEsJmvb4vJxjPwQdisJKQ/rJhtD6GMqYCZiEv2t9r3H+BGzOuHKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LY/3+PXS; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4609b968452so42102221cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729613066; x=1730217866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GrdJiXt2xow918evWgAPP4qJ3FQUAUku+VXEuKSc6fE=;
        b=LY/3+PXSK2EQFfXo3GIagQkg7cAuRFv/yljlHP0YtCyZK3UOgp+LPOB6Ta7gDmOia8
         Q9qIFkIzvWEfa6wmbnRvJfQ2aaQ/imO9830TjKDzRCfRAReA51ef36sY9pOa/16zz5U/
         8EfaiEDSd0gIxqzZ8XAjBDndxSvUQjTXGIdS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613066; x=1730217866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrdJiXt2xow918evWgAPP4qJ3FQUAUku+VXEuKSc6fE=;
        b=Qdq1w1N+uZPCY+g/tl+BY0zqarU/mPu/FcSfqWnh/uwNbwC4BkqgCR/RZ0aey1SWHp
         DNKIZmkEtJeGq05laU6o0Gc8HXMm1/DhMy5pG+NNeSFC8fHI1rx1hsOPS9qAEebpAoA7
         5Sdu2FzmVI8nOruF3c2R171hdEYCDosMFnj+UVdUKdWZ8tfNRWDzNjYJSR7V/3wj1KLD
         zV48CqUjEUNDIT0bZDGPxgHUssg8J1siD3ir9wO/fJN4zjlZsvTKIkqAUKwzTZCXS0FR
         2h0bsDapRZRSWQO0pl1wbwRHxvXEz07e5Y8t/V+qAnETkCn5EHAi6LDJ/oRnvLK34b6b
         Gv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4RKxxBTenzZpCeztUr8Q4j9WjsiPTxQ5Xj+0hKXUoqi+K5UUApa9jsVY+fQv2BpAYupC4sx2798Y0k4FR@vger.kernel.org
X-Gm-Message-State: AOJu0YyfptD0tWWi3cxzKJyEu8dJMyvYZHPdtQiUrCSZ12pRV6jlAwrH
	fxRvy57ZzQ4HidjklAdB73KBEXVAICO34yCtaTnEarXu1oD6mUyqHur1Vw9tdsVMDdSuDuh8DwJ
	vP5TZVL1yVo4mCF42vGnNc6PznvJQmaSV4jz32Q==
X-Google-Smtp-Source: AGHT+IE8o0AaShZ4oFoQ9Omnd2rJCHGgEkx5CNMuZdw4gGydsOrMdaBbjYadWLe6ztwfU2GakrrKPxoyKmoysPerZHU=
X-Received: by 2002:a05:622a:285:b0:460:e593:41fc with SMTP id
 d75a77b69052e-460fe77eda9mr56053661cf.37.1729613066335; Tue, 22 Oct 2024
 09:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022155513.303860-1-mszeredi@redhat.com>
In-Reply-To: <20241022155513.303860-1-mszeredi@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 22 Oct 2024 18:04:15 +0200
Message-ID: <CAJfpegtfa5LbGPH9CLatQAKud2tU8-uSDu4qRPiFwpLzE1Ggpw@mail.gmail.com>
Subject: Re: [PATCH] ovl: clarify dget/dput in ovl_cleanup()
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 17:56, Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Add a comment explaining the reason for the seemingly pointless extra
> reference.
>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/dir.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ab65e98a1def..9e97f7dffd90 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -28,6 +28,10 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
>  {
>         int err;
>
> +       /*
> +        * Cached negative upper dentries are generally not useful, so grab a
> +        * ref to the victim to keep it from turning negative.
> +        */

In fact an explicit d_drop() after the fact would have exactly the
same effect, so maybe that would be cleaner...

Thanks,
Miklos

