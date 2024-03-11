Return-Path: <linux-fsdevel+bounces-14120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A0877E67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3210C281EE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5D383B5;
	Mon, 11 Mar 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nb3iegMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC92207A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154398; cv=none; b=GmcGSgypjm3n5+SLhhOuaWMjCDxYSzSOg1L+neziTnL0ES+VAyuiUteVf70TZTf5Xv1ukCpkJhAiML3028GzKZHZDSzUjWOMMB0N5hnnygrhJbuqoBX8KJcJBVtr6S6jTKX84OdK+tYgy182Zgb2ZUCuAj2hobaxFVcf675SXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154398; c=relaxed/simple;
	bh=eipSaXQDNaHiMVilLLD9++N49oSdVIn+KRPI2kRYNhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTTiTup53i3xlFKkpTMi4oGXpQtCC+iEgk2hvt2sznxRb7+ayi527xvXGz+jM00xxgXmjAzPnemqCkFHGkA5sTZyqREAFdaSUcvpzZifXw3dyEWyAGJElPrOTFSi7P4O/Eq/rUqCSdrrcIhfc/BiSgy36wMa3VkOOAsOi/5YlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nb3iegMu; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56861dcbe79so783447a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710154395; x=1710759195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i2dfslh5QDNZ/Ge1JZNCE0iFX9bHyhSCqEH3cMk4dhA=;
        b=nb3iegMuKAyOwVme6oxxWajgKvOOX7Dy4rdx8xeqY9DWXjDr1J+h6b2Qnb2mqyvCOo
         NuiEOjPF7+BvpihJYalva3/mW8NLyYoKSRjIukhz9KUVjU6r6aBGTJVZT9T31LVEw+Np
         AjuSdRl6kdsDdOIWG3RtL0lMMUbi597WFtYnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154395; x=1710759195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2dfslh5QDNZ/Ge1JZNCE0iFX9bHyhSCqEH3cMk4dhA=;
        b=UGo/+5Jk/R1jjsMqJalgzmRgiTVKnD79rCHRmlbbVPvI2ovz2B4E6ex53JHdJ6keQi
         E9bSU7iWUlSzMnoFcH1qYeVadqQjUKHl9eCL7s2+UUnjuOk/xkZkzI+bOA836IHQn6NM
         Adac0tReLdxyp88zjRyzj+1YGkCGJYJ9l31DTZk8lPSUDMGeLJGQvYYONQCIgIjOL3Sx
         LcbkGrQOQL8wtXjI/LoYmAB2/ttdE2fiJdppjkoLfYLIM5aZHpAvZ0UL1K1QDR1fGuzy
         or7z6gcEKCwtIk5k24imTJ0j8d3ri/y1CEkYJmsrqhRuu3gTauAsJ0dmL8YTuLkxdQ13
         d9+A==
X-Forwarded-Encrypted: i=1; AJvYcCVHC+ytx0Jwr89Yh7RCjqcAu8Ij5GmgsDmFtTPnNpKhZiJx3cMn1RSLOSlcutZw5E2Lv7SWl8CburXVtq2dJtKP0EgLEDthe0ua+SLHKQ==
X-Gm-Message-State: AOJu0YzQBnP0KDN14VaTaePD9m778scYODgWmdux0lkKB0Ejk+0SAKlc
	SPSqQbL41gf7UZZLXsNNEkHoVzKIz49XRIGlrbHQGdN1TL4O2EPWppng4ViId52DDM6XPqx/TQO
	4tiHSbGO74TDJji1bdELElbfWM/FhFPqGdnwI2g==
X-Google-Smtp-Source: AGHT+IGrhueAiqHAAsjZ28RgNBvcuE2K3dRDxlPYHttuy9/oDJvWikA5V55Q0CYuFb4STx3zWkEYO199sE/YQ7Tm9lA=
X-Received: by 2002:a17:906:f209:b0:a42:615:1395 with SMTP id
 gt9-20020a170906f20900b00a4206151395mr3478723ejb.11.1710154394689; Mon, 11
 Mar 2024 03:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307160225.23841-1-lhenriques@suse.de> <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com> <87le6p6oqe.fsf@suse.de>
In-Reply-To: <87le6p6oqe.fsf@suse.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Mar 2024 11:53:03 +0100
Message-ID: <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount parameters
To: Luis Henriques <lhenriques@suse.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 11:34, Luis Henriques <lhenriques@suse.de> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Thu, 7 Mar 2024 at 19:17, Luis Henriques <lhenriques@suse.de> wrote:
> >>
> >> This patch fixes the usage of mount parameters that are defined as strings
> >> but which can be empty.  Currently, only 'lowerdir' parameter is in this
> >> situation for overlayfs.  But since userspace can pass it in as 'flag'
> >> type (when it doesn't have a value), the parsing will fail because a
> >> 'string' type is assumed.
> >
> > I don't really get why allowing a flag value instead of an empty
> > string value is fixing anything.
> >
> > It just makes the API more liberal, but for what gain?
>
> The point is that userspace may be passing this parameter as a flag and
> not as a string.  I came across this issue with ext4, by doing something
> as simple as:
>
>     mount -t ext4 -o usrjquota= /dev/sda1 /mnt/
>
> (actually, the trigger was fstest ext4/053)
>
> The above mount should succeed.  But it fails because 'usrjquota' is set
> to a 'flag' type, not 'string'.

The above looks like a misparsing, since the equals sign clearly
indicates that this is not a flag.

> Note that I couldn't find a way to reproduce the same issue in overlayfs
> with this 'lowerdir' parameter.  But looking at the code the issue is
> similar.

In overlayfs the empty lowerdir parameter has a special meaning when
lowerdirs are appended instead of parsed in one go.   As such it won't
be used from /etc/fstab for example, as that would just result in a
failed mount.

I don't see a reason to allow it as a flag for overlayfs, since that
just add ambiguity to the API.

Thanks,
Miklos

