Return-Path: <linux-fsdevel+bounces-9369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5225B8404C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEAD6B22D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F02604AD;
	Mon, 29 Jan 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GTeYry8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0D5F879
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530548; cv=none; b=brnnFhHeHGtwr5X/32FAtXBI9SMiilSYqBeHjAgd27sndMbqJUEM/4lMoVOU1/eVTW74fKN9YvGmtx5LTmhPu2r5Qo1/EBqfrfwer550/0I3xa0OLG0Q9WeOvIgnrFth9DtRxsgb5SiOJar7n7kIzT7dz0aRoU0qACYjNsMF18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530548; c=relaxed/simple;
	bh=beSEpMwWPhoXPG21YOXXQgt1VNjIWZ1tYR3wUsAzp44=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c9LKko2YzzhPClNGkMME1Ec1jzY+ABNhMnj4FxkO3QY+8/TQF15lAEaftwUwB5iEAstVmpF9xt8LdNtUre6xjpSxMhq78TUDXW+m5pRfOVbWpSPeuYTASHsdk41hwzsbt85rnuzFOlpb80PPn3uzwRDQ9zLNkILE6w2iGi0oZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GTeYry8Y; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D08D3F336
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706530544;
	bh=SaRR+cA5aioFaC6rHkjuNEVQCXHh/LCdTL3vZh7l9Dc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=GTeYry8YqQlHKI4iKxjTdl8FwxBMsU6vMVsEsYWSz3z50fT4dLLafn/KwSTeulB8d
	 V3xVQHZcwitL/YD2T8JObu4JUAfdnUGV8AGbtHDBUZDyU0EYA7mhjLB0mI17LLFQ+J
	 xRmZ8V8eA+C4nlQcXXEWGSFDa/1aabn1VWpPouxT7l0q6kgNPvYGFbucKdNwC2Az5Y
	 P+WnYqKt7EM1I/J8tNl7b2kTHhN+Yen2RSSD5zGCwfx1lXtwEo6l8LvmoTnDyXH3Ov
	 abp1xD7vZ+9TapN2gJ3JjdPD+nph6uL0cucv1Ucz8VSomJlj5mSq9VtPGzdrD9hT0C
	 yU5uHlOmC7gZA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-558fe4c0c46so1663735a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 04:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706530543; x=1707135343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaRR+cA5aioFaC6rHkjuNEVQCXHh/LCdTL3vZh7l9Dc=;
        b=Lw5gakzRkT1uiRMiK7ZEZGI0wRnAngUjCOXEHvYtj3O2kRkcO5GJnhqWufm4Fqf3X9
         ezneM0WfMEaZwcKQLcRHd6XTE1UaUSU7cMIyMki+0LuUwk0RYXgofg/5dzZvuKCEBOHF
         gOzpStsrF3ya1lS3VXrHbhfFlHWXJF9/NaOczoNvHQQaE4z2Vfn9F6I+88j18TasF1DG
         LiFFNJvKVau31NHnBp8Cfnt2i/XhCfcHMw8k7tW35rzgR6O7W+1AqJaaiKOtZZJzpt4N
         oOxAykrv0ynSZclncP/F+rWftawB85grAneuFwdOnfhon6GklABVd5kKq+YPxDiYnQkI
         vZXQ==
X-Gm-Message-State: AOJu0Ywkg092akHHs1n5PZqCMUhgPPCW3pWxIL5r66x6sO+hdt7KdRnV
	7vcNkpvPyJZoWcLJm718jaAPyNkZouuQLzP7Yt8kHFvTbYlnSLra4a04rc3ryZKUL8t0SR3eqoD
	w/62cRKukMjkiUvWOX/g2E7OC0aGVZar74QgwjDJW/n193QzvIPsd7W4VfJpPvarmkuvNuraxLK
	DpB8qRuzGF4r8=
X-Received: by 2002:aa7:dc0f:0:b0:55c:d474:56dc with SMTP id b15-20020aa7dc0f000000b0055cd47456dcmr3504328edu.39.1706530543437;
        Mon, 29 Jan 2024 04:15:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE1UPnji4HFFHIfmLwUcudfhejZixFf7AfaUc8q8iJEaCdy+QPERSuFFEev3B3r0IdQz2X+g==
X-Received: by 2002:aa7:dc0f:0:b0:55c:d474:56dc with SMTP id b15-20020aa7dc0f000000b0055cd47456dcmr3504315edu.39.1706530543167;
        Mon, 29 Jan 2024 04:15:43 -0800 (PST)
Received: from amikhalitsyn ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id cs10-20020a0564020c4a00b0055d37af4d20sm3576492edb.74.2024.01.29.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:15:42 -0800 (PST)
Date: Mon, 29 Jan 2024 13:15:41 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] fuse: __kuid_val/__kgid_val helpers in
 fuse_fill_attr_from_inode()
Message-Id: <20240129131541.a5005f1ec36b0424dfdb69af@canonical.com>
In-Reply-To: <20240108-ramponiert-lernziel-86f5e0926c3c@brauner>
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
	<20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
	<20240108-ramponiert-lernziel-86f5e0926c3c@brauner>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 12:37:07 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Fri, Jan 05, 2024 at 04:21:29PM +0100, Alexander Mikhalitsyn wrote:
> > For the sake of consistency, let's use these helpers to extract
> > {u,g}id_t values from k{u,g}id_t ones.
> > 
> > There are no functional changes, just to make code cleaner.
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> 
> Looks good to me,
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks!

Kind regards,
Alex

