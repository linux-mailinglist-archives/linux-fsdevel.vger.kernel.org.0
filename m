Return-Path: <linux-fsdevel+bounces-36529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0DA9E54B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 12:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962231882C93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503D214A6F;
	Thu,  5 Dec 2024 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSCGyNrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6D212B19;
	Thu,  5 Dec 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399863; cv=none; b=B70DfhGh863IqhJ4kkKJm9ntOKCju+X/d3GibcJO7QwMoiSKDl52qPPuRk506ZTfGXtTa+CWKqvlIppNsqyNUAnh8XQjKmcoTY27qUe0FxaFJ9T4tJS9jAQQeXgoRL179sVK4U7J1CqhLsIHKmxkxn0NVLrybfMf5zT/dryO0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399863; c=relaxed/simple;
	bh=XFUbX/YZsggW3Lj2pO1KVc1XwRkwRE4Aixa8DIpVws8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGOywji4T0YP0sYaqDRM5ZM8jqH1zU7Bt4bzmbUqKzJ2wuVIWHgWB2AQeJQDKMB50j5tkVZ/L7TZh74QA9vZRz6e1QsqYRcZuw4q+F8a35wE3/29CZOg/+ZVQtaiGJpR8zkbfRCVtV35Dt8U2NWeL4Eq65puoCgg2sHm+FdP+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSCGyNrj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so130073466b.1;
        Thu, 05 Dec 2024 03:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733399859; x=1734004659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHqFbmX+c3US0UItNKn2A73h3t1bWaRXaMWTZM0i8F8=;
        b=NSCGyNrjUts5rNAcFKR9aYuHdj+Fs4shdJNS3EbQ0QMEeKvn5GHhuo9cLis7qqBhJ6
         lyBXe1w1duZyWsNsr2QlEUcPnZu/AclqhFbtDDJcXy09sbQr+4X7Iw07jfIANrKUsatx
         TTked6sYdI9rhH/HJIpSqkxzg7qDjkuWzIOsczCKYFlJeTGIb5IP3NxIs4eiIv5Nvuiv
         1khgUBI9UoUcWP9hawVwnMWnmweF2NW/bazxd+jTPfHekp4eL6g0LaMNlBZmtWEoqDu7
         zFy+ZYDm2SA287SCQIj7fAFEChW2jC1wNOtTO25zT0vJY/x67K0ad+yLKegdeQ7ZKToL
         DNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399859; x=1734004659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHqFbmX+c3US0UItNKn2A73h3t1bWaRXaMWTZM0i8F8=;
        b=iZF/TMMKGdVMe6oQFOeHuAQpTYfhIhR+C73gjJELNhFdtyN0Z7paSJsoi/7ng7rAFm
         VKwsTkFq9kYG/LGHRmcIxMNE0FTC1/CIeGTqxIDj90P6LC5W0k3atzGf8pS2YxgER2+8
         HYHLKrKUV9VLBakLoHHYMcDt3rvYP38GB1ap7jKSNJR7uhHF9JHmhN+7KdU8DNPJUvRn
         hqinb9cKPEv8oN0vAJYKb7YJNJ39UUHDiHfTCfHehJ7pAvz/gxdua62bbImZ1VbxGGUV
         jo0tHxtKZWq0nrl0HSEhN9hwqFpVq/7WDbKCpdLW5YlMi1rJ/XRrF4m6OBkZcorJeJOo
         jvdg==
X-Forwarded-Encrypted: i=1; AJvYcCUhncMAEzzvspz/K5GvzzksmTvVYXaXPijLxfE8D2PyCANOuizko7UCU6u01hFPksjVpi2TaNe5fqtnfiBW@vger.kernel.org, AJvYcCV2S59lSMxVGKtfOqIcN42fY87w2XFF7MAQvmLa/fYx2Jdx/5Btl4ibrw95VetDAn4mQUANoAsyPFu1feAD@vger.kernel.org, AJvYcCXD7YMr8bGFbkHNfzfl74Jua9JATnznNg5bhy/LUZFPWfMk7ojxWXGAz6KMqatp5iq1g1DaypW2W8fK@vger.kernel.org
X-Gm-Message-State: AOJu0YwYk4Jge3adv5fPW/VWqVzoS6S5m+bxIs/YMzitgSFeLNcvqbw9
	6RSaMus/EkhDfgfziLbsDMi1B4Iit/pDmGzf2zYbYkAOdqMiTgeyWieTL2iXL8JYIXi1qmuS6bC
	IRkLWIgzWuDzKuHcSdSda7WhYuuw=
X-Gm-Gg: ASbGncvkKKhxaYUcApe/CS/7o9KDgTalh6Dtisc3GVdvyxLaOSvDKqMOhfEl0yBAEnm
	i5QHfIgV2Ru2VYTaQl+MxkExOPtBrMAU=
X-Google-Smtp-Source: AGHT+IFtSaplePUPTfu2b1qsmyJ35bqUssMpJaodaFJv+wLRQVvbm9L+aDyCbbZud1nyfYd6OmNtABo73+XJa8y0VQc=
X-Received: by 2002:a05:6402:3511:b0:5d0:ccce:34b2 with SMTP id
 4fb4d7f45d1cf-5d10cb99fcfmr14494613a12.29.1733399859160; Thu, 05 Dec 2024
 03:57:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org> <Z1D2BE2S6FLJ0tTk@infradead.org>
In-Reply-To: <Z1D2BE2S6FLJ0tTk@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Dec 2024 12:57:28 +0100
Message-ID: <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Erin Shepherd <erin.shepherd@e43.eu>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:38=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Sun, Dec 01, 2024 at 02:12:24PM +0100, Christian Brauner wrote:
> > Hey,
> >
> > Some filesystems like kernfs and pidfs support file handles as a
> > convenience to enable the use of name_to_handle_at(2) and
> > open_by_handle_at(2) but don't want to and cannot be reliably exported.
> > Add a flag that allows them to mark their export operations accordingly
> > and make NFS check for its presence.
> >
> > @Amir, I'll reorder the patches such that this series comes prior to th=
e
> > pidfs file handle series. Doing it that way will mean that there's neve=
r
> > a state where pidfs supports file handles while also being exportable.
> > It's probably not a big deal but it's definitely cleaner. It also means
> > the last patch in this series to mark pidfs as non-exportable can be
> > dropped. Instead pidfs export operations will be marked as
> > non-exportable in the patch that they are added in.
>
> Can you please invert the polarity?  Marking something as not supporting
> is always awkward.  Clearly marking it as supporting something (and
> writing down in detail what is required for that) is much better, even
> it might cause a little more churn initially.
>

Churn would be a bit annoying, but I guess it makes sense.
I agree with Christian that it should be done as cleanup to allow for
easier backport.

Please suggest a name for this opt-in flag.
EXPORT_OP_NFS_EXPORT???

Thanks,
Amir.

