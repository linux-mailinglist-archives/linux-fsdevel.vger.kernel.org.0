Return-Path: <linux-fsdevel+bounces-44946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05992A6EE50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC221897F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBB25522A;
	Tue, 25 Mar 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cxUh7kCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396781EA7E7
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900273; cv=none; b=FUFtzlAY0DNmDT2zoOaexw26kji8K2Pa6JUlayaDLaRJtb9F7ifEsVdQTzOJnJn2m1DHxVmvYbdBx+wDSNkAOKvrQvP5nTDmWwS3vi5cfcyD/umdOJSTT4PWounNteP5LECx27h8DxINij+Fpgr9+waDwnyCxHTuDh6dkUMCgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900273; c=relaxed/simple;
	bh=XsEMWdvBi5iYepcfq5t8UKPpw3unNu+uylpT17aX/IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8rS2PytgbZxjn64rQe+jrDa18OwunNpYb7hgwFLPYQi0Uss9qqmIFM35VT3xGnGuh1xFlSrrtaMCIkjhjYc6XTcb9N3mleYrmUw5z4ZcNiXlC0mdUCqTKI2hIVHhbrA5LLQK8rPMIyZrbsdjLnExfdDNApPlXt5RwHiCTkSR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cxUh7kCl; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4769bbc21b0so57404651cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1742900269; x=1743505069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBkCikaTAoHizoDbryCJJ3jdoOZ97/scQy3/JjbbFL0=;
        b=cxUh7kCl8I6InZltCE3Mze3ggfthI/nHlpoNQlE9txD33CUJXnYWYtRnbLWsGSwUVc
         +kX0HNd/LTyrs4Hhd1CA+nVFi2OG1y2di3VsFMJyNCrm8fBISR0koylarjwR69Ddu2Zz
         zfrpdbwrD+zJ1e1UU1360K2VaaoabIKSzr4ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900269; x=1743505069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBkCikaTAoHizoDbryCJJ3jdoOZ97/scQy3/JjbbFL0=;
        b=cble4BqVFoD+z/LBwKnHoTqWK6X7fTXJiqn8taUlO024GEEE2ob8GWpXszpvcHoA2U
         5d3wscJ97jlAh39GDeErtuQF58xDOJtfyzHUcUP+GRX+Qg6R0o989bbu5VT4fPdXU07H
         D0tYjQsQitq30y/ocPuSsSguYInSdY3/wV+f7F7i829D8AR8P0o2doYVZOOh5rNA+BPV
         zCAxVw9n2diVUJIwKbuW5yUYJaHm2xhqsjXNq+qF7A9mudZkJFcZ6AP9Z+j/rLExmruM
         B4aUQGoEPbXf4+yndEAORvv3wHDpgwnSZ00sMagnjWWAnsS6KOcq1uwvLz9tDDWsUL4l
         vaAw==
X-Forwarded-Encrypted: i=1; AJvYcCVl3a2uIIz+mXQYsEZzQYYE7HsXIx/YkfdHeaLcH0h0+1OLNU/CeEZUuIoaa7QjcHGOl5Q0FuzNBZiPhhTb@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKC9IW/3XWPdi2OKxNlyyiFqENW2FSWYWE6e8Wtu945gGemjb
	lujwv4WVIi0ynVL64Rnxs48w7rBd9NLFeRib9+wFjXhdSMLb8yfT5cYqGSQ3rtWovajheh4uaIk
	y0LimDk31xFGuVgSPC/nMgjQC+uTGT+nRMRmryQ==
X-Gm-Gg: ASbGncumOGKtbJsSyFo8BvnmfYC+ZmGrUyYA8F5Db/e5FeTetc9o2ekQLXaYUuldUvj
	gmhhkJK+Dp4QFMB3O2yweRRB7mcctsb+K//hREvoVW0o0VR60EWQag1En5pf+7WQl8687u5GK/J
	Fg6ev3CFZITJT3dVc2ykdjYk6n
X-Google-Smtp-Source: AGHT+IG+KLvfcAl79m45TxzmZPY9Trdpca/2dQEEBE+Xb5C+dQlIvgNSU5J10Zl3B4H6RzI3Mc6ZMY0zQ5DIimVjAsE=
X-Received: by 2002:a05:622a:4c8c:b0:476:b783:c94d with SMTP id
 d75a77b69052e-4771de1585emr250434821cf.35.1742900269488; Tue, 25 Mar 2025
 03:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com> <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Mar 2025 11:57:38 +0100
X-Gm-Features: AQ5f1Jr4s098ta3jIrpq5kQdXM6kspgGjK8HSqHg4idBTvhTOKRucehRWdwRJr4
Message-ID: <CAJfpegs1hKDGne7c3q4zs+O5Z4p=X3PK8yFXhyCY2iAjs4orig@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Colin Walters <walters@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 13:01, Amir Goldstein <amir73il@gmail.com> wrote:
> Looking closer at ovl_maybe_validate_verity(), it's actually
> worse - if you create an upper without metacopy above
> a lower with metacopy, ovl_validate_verity() will only check
> the metacopy xattr on metapath, which is the uppermost
> and find no md5digest, so create an upper above a metacopy
> lower is a way to avert verity check.
>
> So I think lookup code needs to disallow finding metacopy
> in middle layer and need to enforce that also when upper is found
> via index.

So I think the next patch does this: only allow following a metacopy
redirect from lower to data.

It's confusing to call this metacopy, as no copy is performed.  We
could call it data-redirect.  Mixing data-redirect with real meta-copy
is of dubious value, and we might be better to disable it even in the
privileged scenario.

Giuseppe, Alexander, AFAICS the composefs use case employs
data-redirect only and not metacopy, right?

Thanks,
Miklos

