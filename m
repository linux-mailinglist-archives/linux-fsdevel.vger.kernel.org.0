Return-Path: <linux-fsdevel+bounces-34025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE959C228E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28995B224B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6F51993B7;
	Fri,  8 Nov 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaNNy4q9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7A126BF7;
	Fri,  8 Nov 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085082; cv=none; b=MTIfI17duY+KncYZHp/csSBHgoKkGmt3OuOaqyqaWvDObHT7tpblus9ivjo0WQT6wbYi7JphjizxNKtQIZqqJf503ui85gwB9/qSQZC9nv5sinKKR8Pe2q+cQQJVx/jE7CvZPbQPkpx8oHZonP2FI882jUQlHqyQ0ysVVMLhbLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085082; c=relaxed/simple;
	bh=ygmj23GCBXdYHkWBW3AaE7mzinOINwmTjlC6ckKvSfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mix+2edh+eCqSe2DT+gquMkb23kpVTSH1StUyWI+oZMbEm92FgsOPUoCyVLwF6M+5QQkFiCXulHX2dgfAijNpJ/xNuhNCf8fJDUVvVQcUkBL3T2C32TWbSwitsndY5DNDvwFQZgZR5MtsR0MqoMG+DiTkXnndvY+Jb/wqpXYSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaNNy4q9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d18dff41cdso13871036d6.0;
        Fri, 08 Nov 2024 08:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731085079; x=1731689879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSXumXo58aMmPhg7fc9DXBq2pMwdxwBKEoTKpbMpHMc=;
        b=IaNNy4q9M24kEh7evtPDE2EnCm76hTkz7LU9R8hMsoKGs1p2gxVRyxwMOVg6U2Z9VX
         JQKCdAWYCEGmxuOio++L8D1zLlnJ10P4oQ6hnWLBubX5XXtSuvprA54qsP1wRnY3Xd3f
         LJEacR1C9YY96I16IPt3FMNfYTvNRew0WLxLbpew0lFGH8W3JjJKzabCzJ/e3VoYqbiH
         A8sO9Eai29QSKZnshiE5CNrUSt0nB5zAWPrBdCB5mpok7VCfhkZPgHgw1olylAfkc00k
         IW6Dxzj8uiy7vJW10lv45eNZYfrE2evLBz88CWoHT7cMXSWfrLdeXnhXczSRFV93ttvs
         sqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085079; x=1731689879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSXumXo58aMmPhg7fc9DXBq2pMwdxwBKEoTKpbMpHMc=;
        b=Q7rH6EzUBZcKzNf+HJY53mtOUBDuM8VVaw6+2gzVaHfCCsBjWTTNOjQo69bYdu6FJ8
         Z4CGKSK+ACvL7k8C2l66S2cCbwdbIqknlkalT+O2bduVti62v3+L13kfDguq61665aAI
         dxRVekt/OuBRrGZ7UQA9i1wTNrVssb3sCYJ3HlojTN5iuwQt8rmySlwGN4yD21PWhbJP
         yv1PgzR7lNZP3QDzqfJx5DEqHNM/+yDF+GhMnYSCP2EdfUQLEFm8MDDoapcTnBnBk1Dr
         MYRcGWpixod1exusKU6c9nFMFf+dLJ+uDFcQ3nRJz4DTiz3r5JsQjnPKUwtpBhMEIrWZ
         sqtA==
X-Forwarded-Encrypted: i=1; AJvYcCUqMj/cjQ1QqFbB3UBtn4nkyOS1smH44F6MkjAu8CKfkyc7R/BaPnBbR+oB+93IBr5OTPOmPUCkHrbM5KLf@vger.kernel.org, AJvYcCWw62DIFEgtTwHnwqq/PBeBbwDldWPmpfl1Pw5wKa6WH79i+cJ6YYH9cHHuFPUGMFcs4RrbCmlhGGxITxGP2w==@vger.kernel.org, AJvYcCXXGpKMdIW/jdBJugEM58ZmOsl9noUQcqCjmRKLxYqN9+K7NODSCHHr0FYCbNHC+fRM3/E96KRim7EyHKmz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/m/cRJVG13DzjEkNL4wbOMLvLMyDQvmtRjx9ufcI968d5rg+5
	NY3wgTpubmkMzxYbte4y46TOvjqON6lMuDKWUro+iBdBe7ZzQRX4MPVYEiroiWGnWren5A+D0uW
	Ma0+QN4MlWTkb1vtDINo8iw9VkSI=
X-Google-Smtp-Source: AGHT+IFh4W/d0ZTbRCV60n2UAgnrQl4BvBr7YvZYfkesKNQqfhEwdsAl9apEmYp7FDspj2zD4V3W4viysAUwLXACfBs=
X-Received: by 2002:a0c:f410:0:b0:6cd:feec:32eb with SMTP id
 6a1803df08f44-6d39e197c53mr43083046d6.22.1731085079472; Fri, 08 Nov 2024
 08:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005720.901335-1-vinicius.gomes@intel.com> <CAOQ4uxiRgXy-0WkTBbt6qNJ0+wbE=xBQLyOYnD7nPwQP1weV9g@mail.gmail.com>
In-Reply-To: <CAOQ4uxiRgXy-0WkTBbt6qNJ0+wbE=xBQLyOYnD7nPwQP1weV9g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Nov 2024 17:57:48 +0100
Message-ID: <CAOQ4uxiBmOHH5-7ief-bDX5cxkCAyETjL7Z7hEdyoenJ5AG8sw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] overlayfs: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, brauner@kernel.org
Cc: hu1.chen@intel.com, miklos@szeredi.hu, malini.bhandaru@intel.com, 
	tim.c.chen@intel.com, mikko.ylinen@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:19=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
> >
> > Hi,
> >
> > Changes from v3:
> >  - Another reorganization of the series: separate the pure mechanical
> >    changes into their own (Amir Goldstein)
> >
> > The series now reads:
> >
> > Patch 1: Introduce the _light() version of the override/revert cred ope=
rations;
> > Patch 2: Convert backing-file.c to use those;
> > Patch 3: Mechanical change to introduce the ovl_revert_creds() helper;
> > Patch 4: Make the ovl_{override,convert}_creds() use the _light()
> >   creds helpers, and fix the reference counting issue that would happen=
;
> >
>
> For the record, this series depends on backing_file API cleanup patch by =
Miklos:
> https://lore.kernel.org/linux-fsdevel/20241021103340.260731-1-mszeredi@re=
dhat.com/
>
> > Changes from v2:
> >  - Removed the "convert to guard()/scoped_guard()" patches (Miklos Szer=
edi);
> >  - In the overlayfs code, convert all users of override_creds()/revert_=
creds() to the _light() versions by:
> >       1. making ovl_override_creds() use override_creds_light();
> >       2. introduce ovl_revert_creds() which calls revert_creds_light();
> >       3. convert revert_creds() to ovl_revert_creds()
> >    (Amir Goldstein);
> >  - Fix an potential reference counting issue, as the lifetime
> >    expectations of the mounter credentials are different (Christian
> >    Brauner);
> >
>
> I pushed these patches to:
> https://github.com/amir73il/linux/commits/ovl_creds
>
> rebased overlayfs-next on top of them and tested.
>
> Christian,
>
> Since this work is mostly based on your suggestions,
> I thought that you might want to author and handle this PR?
>
> Would you like to take the patches from ovl_creds (including the backing_=
file
> API cleanup) to a stable branch in your tree for me to base overlayfs-nex=
t on?
> Or would you rather I include them in the overlayfs PR for v6.13 myself?
>

For now, there patches are queued in overlayfs-next.

Thanks Vinicius,
for being patient and working through all the different revisions!

Amir.

