Return-Path: <linux-fsdevel+bounces-41125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA01A2B400
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BE7188A818
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116F51DF26E;
	Thu,  6 Feb 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElYSLXtb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6151DEFF9;
	Thu,  6 Feb 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876619; cv=none; b=Zq9kagxuTPTMueN+HcGw29A7hk3v1++MJLB3xv0WPzRMt/S1pjGlHuSoN6JFOz5VzPNh3ivB1pdCAbxu8Blzwovv/iyABPhGZTFikpsTgICCPp3+MYd8srVXGCupulkSsjrJXqTiGu2/DenvjERwTG02xLVBIZCIPmEN2yWNbDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876619; c=relaxed/simple;
	bh=7RLOQgqxkeJV37SB65KL4xohj0BnZPDsnI9DHX295jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSOXk4PAuAIfSSQSaUM1rmpFwtNoMD3rcAMncZFpO5/1FQbGEZW2yMH4+zixrzHeVQqhCtAqPxYH8WsjpwYPhPJ6lc1TcReHpqp04DOv8uqGZlwC/uI+UZ7k+AFRMj9/DiebUm2obvXj61WTYRm366Uq2y28SiEM3os+iOUKawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElYSLXtb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f16af1f71so22060625ad.3;
        Thu, 06 Feb 2025 13:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738876617; x=1739481417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3ry0f1fvXAjZQbuhNpyazK/LrWcbCBiBdgamVGM/o8=;
        b=ElYSLXtbfx7JM78rMWgO79ikeT89eZN+jeP/1tipBqEM8LN6gAVwRHA1dZp8xuR3II
         xRmpUq2VTKhaa7U+rIhDUUsg1bAkHhSN34g/g5s7U9WAvqws347WnJIfVEYgH2h/mY6H
         0Bv0VtMHdmAwTH9poENTrzPrv9E7+p60rqtebq/7iCYqNvJqX+5eK9tjynEtt1sHd1wR
         0BYZqlfHLkivT5nXhy1NrbVdcX0Y0vPzGN/Vnj81pA40NN4Lrfxgk34RgkhbEUp7y0aF
         1KX153sGjOItSogFeypf4q223OcPBrvg3PxUeqbRuKeW3IQjAmPyHKaZLnnrwDsR5wvl
         JZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876617; x=1739481417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3ry0f1fvXAjZQbuhNpyazK/LrWcbCBiBdgamVGM/o8=;
        b=gv5aHqTBkSijneRnSSXnpqFm1NxXDGleIjDICbHDjuaqWAQhRtPOnMqC74ZQHN4v6u
         G4dgB8BRtwal3/mvpBFjgEk+DnveYa3jKxuNerD5MfvhqrNF4fRqSUzWSOp1OeTUBsgz
         KaiivxLvPzg70NkrZTtQLVKdZ57jBKXej0KqdAcGhEQiodIqGWzNuj4oE5wf9JuCIqMz
         i3SnZ4D5ccnK6q2Ihc9Te7Lyi1+3VLmmPGLRK2qgScF4Yk8kb38XW17BzcGKVz63yJ/6
         jO9r2KLLVpTdFHOute2hZQF/GTMvk2XqBKaqdbjkGHAOroJP28J3c4RkbaedGSXQEW2X
         jNYw==
X-Forwarded-Encrypted: i=1; AJvYcCVlwG7gvTS6roJAU/nbGJll9j36Q6Eh0IeMckd7M/OKYEm6QnjXFx0dmyWJ2T8OntpK3jGX3Z6elkcgNg+w@vger.kernel.org, AJvYcCVxLJ0NffrfNERuI/RH312K71r1GBZHdEMreJN+DmDFRoWugMksiWaEupXItuTHrvOEYQZIFw7z@vger.kernel.org
X-Gm-Message-State: AOJu0YxlirpBNoGt272cu10E3Enc9HrDLS+3zSYoAKr+VjIoM07dHWPa
	R9aP195m8hgG5awp08xrB7bC7tT1qZU93mXJUSQfRmFukzJKSbHjNo8h2Q==
X-Gm-Gg: ASbGncv1BP1imCdK54MhCSHSxsFuuxivVlWXsydk39HAxjPyKV2xqxjGlPHJMHnb01z
	yo7tc62VH7N4GtswqYrqtTqls3S9y+NQcMHM711BdbKtXM2i2MMILVJJ7SV+EdnwcnbMuBaM374
	9cVQvyHqOq6aEHoXtpHH/RUnNi1vHeah0aUw9XFrWqjyxSCJEcot1zRecZ/1Ml1qaL7zrgK6AJ3
	N5RfzbwFlxediDwnbKQV/p4qNg4JANJsAXTgGE5GV9q+Jtv4F+XWu0R+epYV5A6SRPz8atkyfY2
	m226wqBqzTonXq2fVnEwB0qsyR1R
X-Google-Smtp-Source: AGHT+IGG0ZsiVIWgAcAcsLxCwil0EnOraMxTLD03yHgQeVzBHEnch1aPkEja/wtga9He/ntNpiDS7Q==
X-Received: by 2002:a05:6a20:ce4c:b0:1e1:aa10:5491 with SMTP id adf61e73a8af0-1ee03a8f4b6mr1504083637.24.1738876617181;
        Thu, 06 Feb 2025 13:16:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d4d7sm1806241b3a.16.2025.02.06.13.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:16:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Feb 2025 13:16:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pidfs: improve ioctl handling
Message-ID: <988727a0-fe48-4cc0-ab4c-20de01dbcddf@roeck-us.net>
References: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>

On Tue, Feb 04, 2025 at 02:51:20PM +0100, Christian Brauner wrote:
> Pidfs supports extensible and non-extensible ioctls. The extensible
> ioctls need to check for the ioctl number itself not just the ioctl
> command otherwise both backward- and forward compatibility are broken.
> 
> The pidfs ioctl handler also needs to look at the type of the ioctl
> command to guard against cases where "[...] a daemon receives some
> random file descriptor from a (potentially less privileged) client and
> expects the FD to be of some specific type, it might call ioctl() on
> this FD with some type-specific command and expect the call to fail if
> the FD is of the wrong type; but due to the missing type check, the
> kernel instead performs some action that userspace didn't expect."
> (cf. [1]]
> 
> Reported-by: Jann Horn <jannh@google.com>
> Cc: stable@vger.kernel.org # v6.13
> Fixes: https://lore.kernel.org/r/CAG48ez2K9A5GwtgqO31u9ZL292we8ZwAA=TJwwEv7wRuJ3j4Lw@mail.gmail.com [1]

This is not a proper Fixes: tag.

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Hey,
> 
> Jann reported that the pidfs extensible ioctl checking has two issues:
> 
> (1) We check for the ioctl command, not the number breaking forward and
>     backward compatibility.
> 
> (2) We don't verify the type encoded in the ioctl to guard against
>     ioctl number collisions.
> 
> This adresses both.
> 
> Greg, when this patch (or a version thereof) lands upstream then it
> needs to please be backported to v6.13 together with the already
> upstream commit 8ce352818820 ("pidfs: check for valid ioctl commands").
> 
> Christian
> ---
>  fs/pidfs.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 049352f973de..63f9699ebac3 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -287,7 +287,6 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
>  	switch (cmd) {
>  	case FS_IOC_GETVERSION:
>  	case PIDFD_GET_CGROUP_NAMESPACE:
> -	case PIDFD_GET_INFO:
>  	case PIDFD_GET_IPC_NAMESPACE:
>  	case PIDFD_GET_MNT_NAMESPACE:
>  	case PIDFD_GET_NET_NAMESPACE:
> @@ -300,6 +299,17 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
>  		return true;
>  	}
>  
> +	/* Extensible ioctls require some more careful checks. */
> +	switch (_IOC_NR(cmd)) {
> +	case _IOC_NR(PIDFD_GET_INFO):
> +		/*
> +		 * Try to prevent performing a pidfd ioctl when someone
> +		 * erronously mistook the file descriptor for a pidfd.
> +		 * This is not perfect but will catch most cases.
> +		 */
> +		return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> +	}
> +

This double-checks _IOC_TYPE(cmd) against _IOC_TYPE(PIDFD_GET_INFO))
due to the switch() and case statements. A simple

	return _IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO);

for the entire block would have had the same result. Or at least
you might have used a simple
		return true;
in the case statement if more are expected in the future.

[ reported by coverity ]

Guenter

