Return-Path: <linux-fsdevel+bounces-62213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C511FB8887B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 11:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D44F1C85F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634632F291B;
	Fri, 19 Sep 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jIkfBxWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B32459FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273396; cv=none; b=KMJpET64gKlf9ZR7NwQyDKYlsWzDcGqH+3BaTRR8h3umG68+G+3q8CvecTxELMFD7yGGAZo5/QH4mJ1mZaZ0brZyeEiJHNQeezLCtgvY/xgnqd0qaJQUmNGDEWWhxL9oVI8S5lQmqDcrN/dYEvpzrWW7ORIs9yWFR5a002YjgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273396; c=relaxed/simple;
	bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIITJt9/zXUm21NUwtUmOki3gQMSYAXQ744blzd4EPFcB5sf5lXDsJOETocRTpH0TP0bwSGKgmTWpb1qgoxjYDa1rPOXI37YNqC6F47+lXVBA8YOCbbdJvAuMC/pIiD6k8PSARecSeSG/+Xa9F7BOfsvskg1boJFrY7yoU53Go0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jIkfBxWS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b61161c35cso30452021cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758273393; x=1758878193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
        b=jIkfBxWSlkjW5STzq37DPgVopUzsqLgx+5lZ5mRKt851bD5CPQ0b1Ki7IlmlwQiMYE
         H0xpl3LtCSTR/KGE26rJ4q7NsTw9tNEXpOp8fC4wELhU7PtsLQc8OnrHXMG5PofxzC+m
         GybeLzX+nLQQYDz1fGSuf4OPCRHsRuuf5BOEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273393; x=1758878193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
        b=t9HbYbHiSd/4kRnW8X4gDD8giXsdYd8OgsfKumC8vQZIl2KQ4uLpTCgokw4A1SXEzw
         xveobjIWvxUunURTyDwMcGs407QOJwGw/m+ixDkEYW6N0wx4ZZpYyOBSoRVZtH1eFD6Y
         NCJ+pgE/gpm7kI84XDhWrgiW40tBlpEm1o85BQUt0omR01cPF8z63EOr9gCc8UdRH8fO
         BdETF1Cz/BSre05lf8r6/h/xuNfWW09OGSu9atsUlu+7w+5tMhqEsvObCEcbF/2eOmpK
         XvxvbyXC1XN7VDUfS8jh0+1/0q0vTh1xiRKcNVYl4nR5cW0IgZ15TGp9epVvoxgVT5kc
         fHdA==
X-Gm-Message-State: AOJu0Ywwm5bRl+Wzz4/pI1M88HluSa1jF6tKcGmKQHpvdRrbgVCIMFWl
	cTlwg3gIjVfAp3pj2jQAbeJCmTLlyIv9tIF2VH7cftagu1aEPxNqBi9ACRnv4E+KbjOdhobJqXF
	xDHzxzhQBVLjYNfu03jbKA40zKZU7RSy6HwSPmhN7Uw==
X-Gm-Gg: ASbGncub8OgWmV61Z6/D0O8ZsDFS4k+4uaMeavVxug4WiRdyDwKuuvWhzgxrCT5nt9r
	1G/whfg/PwPUldD2XKZGE9LUBvmfNQKUGXSs48TG1MRG+OfRpZGkeq7WVbiIqdTcFjx9VLLA/Lv
	8vlvfESAOibVrjpBwCzFNRpOw0X766uV+XGD3/nQG0SRVzDx8vonzdmyn4K18p1WBVi+vAk62m8
	xAGSlPc8Ncy5xR4ZJG6jL11lAp6d6NOl1o/cSI=
X-Google-Smtp-Source: AGHT+IEC7DaOiqsDhZ6el+nJAXMCR2LZLpubNGOPgEov0Yiqge6V0MP8FIeK9NIu4a3q26iz/ROtYZA/OmdKQK0CbyY=
X-Received: by 2002:a05:622a:1189:b0:4b5:ee26:5371 with SMTP id
 d75a77b69052e-4c06e7cec5emr25872751cf.26.1758273392530; Fri, 19 Sep 2025
 02:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917232416.GG39973@ZenIV> <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
 <20250917232736.2556586-7-viro@zeniv.linux.org.uk>
In-Reply-To: <20250917232736.2556586-7-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 11:16:21 +0200
X-Gm-Features: AS18NWBdR2wSIkWeUQEoOiuG4V2oEtZ00-2g_l56ym-IbHqMpDho5hZu73hYZtE
Message-ID: <CAJfpegsxUQzZaXKFAOBmThP6e5F=XT=oDn1BDBUO0R35D39P=Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] simplify fuse_atomic_open()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, agruenba@redhat.com, 
	linux-nfs@vger.kernel.org, hansg@kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 01:27, Al Viro <viro@zeniv.linux.org.uk> wrote:

Some explanation about the dput() removal would be useful, e.g.:

Non-null res implies either an error or a positive dentry, hence the
dput(res) cleanup is unnecessary, since at that point res will always
be NULL.

> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

