Return-Path: <linux-fsdevel+bounces-10456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E484B596
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775F11C24548
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8212F39F;
	Tue,  6 Feb 2024 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CWOVkARt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261E43AB8
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224011; cv=none; b=O6WcbVXbFJGnXOEJ90dFq4PySfTdYFfQUR/KFXrBVDAexUd5922snlY3SwB+rfc5cvhIcZqKM4BwcnI44k1noH91aCo90S7niAF75uPowBZvfoVsrcI/z1Eu3+ozb7V8lUIJzptPrJKfkRvsms2ndazxGS1haf9VbiZbe5JsQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224011; c=relaxed/simple;
	bh=xSe5C5JbdmU8o0Dfnn7j6Jfa2oIGtsSyeHqQw1oFkZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbXli0gqf5uPul8wzPvUYZB7IpAPhc1J6KvwXwIMOCy1hFqgp7pleyL3PlIJBQ5NJz26IQly2U54SlZvrEem5h0DYpW+pVm5P/denrfiEzHnqSZm7/Osur6SHvxeTa/P025go38JJDZB+6KZdrXdClsCv9adDLL5lXX2zQvs5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CWOVkARt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51160efad36so313720e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707224005; x=1707828805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xSe5C5JbdmU8o0Dfnn7j6Jfa2oIGtsSyeHqQw1oFkZo=;
        b=CWOVkARt01fWLoFBovBEB9BP5YzfTHco+HzoZ25/TTcytMDqNR7ONFojf6r8TG0Azy
         RkhSHLhKT9EjGKmPYWAH+IgVSyeAjT5q6Q5gLOtACFXvHsDBhoPkKE9ue282xqGn4GbG
         p+8LyoGAFiQAG7VmJFq/kFuxlE/I+qA1KECHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224005; x=1707828805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSe5C5JbdmU8o0Dfnn7j6Jfa2oIGtsSyeHqQw1oFkZo=;
        b=NHAWAGlfuxJGy07NWpeRwzkQGh3xewauYh+/yfoOYvObUQmnJwquWU0qDQ3GqyDkFx
         w3l/Ifi9blNYt3A5oFVfA0sCiY/KmixA0+8NdGOcqzK6cQIpuR0fP5s/SkBZkSX8izA7
         EJUZ8LGBvoUyv4BtXuWqZWZKF/JaQGGQO7PyPloPoit8ATBpB4Nzi8u+UtGAfMlvZigI
         WT5Sd0v2iuo7ZwKHjMtRYkkqyNdyimDVu9mj72AVSqvNde/ahfqQLo1QBk5/RYez2sHD
         YGXeDJPxMULJ/Lj11DLMI4nan8v8KBHENgGSB0jqGbM86eObue9UnLi58bFE3nIW+Qo2
         8HBg==
X-Gm-Message-State: AOJu0YwfBp4b4YHFa100DE064np2peZb/w6SMYjQTZAqOsZ7TfiIld0P
	JYYU0vTYDBUETxlqqgdm8xqUrS3pM0sGJNOxoGrhKijHbUdMuEa5u1r9U9dRuRpCW67BOmkli4+
	YNOV1rLcbmHmlNkbp2LkSw19Sph2ZOUUj9+WfAA==
X-Google-Smtp-Source: AGHT+IHs6wXFtQJ8DCnqBjUzjRyim+CnLZh9zDBCP7L64xUITwRiMOSEuAeBqFEFhLpaSCufRTl4ESwDpJRvNWLXaeI=
X-Received: by 2002:a05:6512:3d9f:b0:511:4fec:c374 with SMTP id
 k31-20020a0565123d9f00b005114fecc374mr1903944lfv.66.1707224005513; Tue, 06
 Feb 2024 04:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-6-bschubert@ddn.com>
 <CAJfpegvUfQw4TF7Vz_=GMO9Ta=6Yb8zUfRaGMm4AzCXOTdYEAA@mail.gmail.com>
 <CAOQ4uxjVqCAYhn07Bnk6HsXB21t4FFQk91ywS3S8A8u=+B9A=w@mail.gmail.com> <CAOQ4uxjnrZngNcthc9M5U_SBM+267LMEkYxtoR6uZ8J8YNRvng@mail.gmail.com>
In-Reply-To: <CAOQ4uxjnrZngNcthc9M5U_SBM+267LMEkYxtoR6uZ8J8YNRvng@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 Feb 2024 13:53:14 +0100
Message-ID: <CAJfpegvPCkj-r1m1ndSzNzT2i_oZQUM2PARDTov0vwhqC5JrvA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fuse: introduce inode io modes
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 13:39, Amir Goldstein <amir73il@gmail.com> wrote:

> I have played with this rebranding of
> FOPEN_CACHE_IO => FOPEN_NO_PARALLEL_DIO_WRITES
>
> The meaning of the rebranded flag is:
> Prevent parallel dio on inode for as long as this file is kept open.
>
> The io modes code sets this flag implicitly on the first shared mmap.
>
> Let me know if this makes the external flag easier to swallow.
> Of course I can make this flag internal and not and FOPEN_ flag
> at all, but IMO, the code is easier to understand when the type of
> iocachectl refcount held by any file is specified by its FOPEN_ flags.

If there's no clear use case that would benefit from having this flag
on the userspace interface, then I'd recommend not to export it for
now.

I understand the need for clarifying the various states that the
kernel can be, but I think that's a bigger project involving e.g. data
and metadata cache validity, where the current rules are pretty
convoluted.

So for now I'd just stick with the implicit state change by mmap.

BTW, I started looking at the fuse-backing-fd branch and really hope
we can get this into shape for the next merge window.

Thanks,
Miklos

