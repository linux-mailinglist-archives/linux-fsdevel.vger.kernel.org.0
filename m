Return-Path: <linux-fsdevel+bounces-38887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5503A0979F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D581671AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC3212FA1;
	Fri, 10 Jan 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af7xTWQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8520DD76;
	Fri, 10 Jan 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527051; cv=none; b=br/3HxWO61xfeiR4EpZC9m3yn9A+SlaUw9WaAYYF5yQOK/v1Co7NkbWCnsBjQ0og0Sbb8VjkEkrkMlsGE7n/bWCgF7gT3YoPXOeYStYiQxE9sjfCB6hIGG6H0nqREj8qke8K75uh/I6TiDCJHCx80/jT+zyxS+IWdOFR46X5GCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527051; c=relaxed/simple;
	bh=pINS1bNJiBtH60ptoxpaosWaiqli5xOI3SxrjlI3kVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLTJjoM3xK/aqSO6BjIjfVveZhn6A5x63uA5g7D+SeJ6E4h/GBXEitk05X+2AgtKTtXgwwJ+YqDa6C/evUBzPPjw4DuvSXzOd3J3eASV3mSHYjcQjQtPmtJ+1j8balxXaY4cTDZZMIacyRWm5SQuK/vdjSPwqF1LAEAKocRT5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af7xTWQo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so1301337f8f.1;
        Fri, 10 Jan 2025 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736527048; x=1737131848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77Io2UBsaWIErtJlWUYZdovk8i/T/bN1F7t/oGMTyQU=;
        b=af7xTWQo38EyK5UKV6p3HHN/yLGPaKZbxO95KQbms0BO1G1HSof4BDskMcT3pWFXZZ
         5fSvQIfF+kcV+Bj5DLnSQNKEv65BNsW34hoZ5H6y30QdY4yDPwyWqfS42eo7yk4r1iPe
         tBbPYY8iux/ZhImy0VcPztwdrImuNm2PrjfrJxUAwEjvo3aFgG2n0OvKUB/WuxfqhFys
         CtSmJaXF5WuOhGz9Qz0M2Qfo+KvMrW4Fj+3ATe9+vioKqHIHlY96k9c+aVAGYUeFmlHN
         QV9ZSmzj5rLIdXgCqz/69dZ9ZLyZgg3p74bMeZamLJxFq1day8XWM4tt57W/eooJcnM4
         kI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736527048; x=1737131848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77Io2UBsaWIErtJlWUYZdovk8i/T/bN1F7t/oGMTyQU=;
        b=pl64ovKv78rk8LFJayMIEmOC/fCMkhzDQpbMn12wG5C3NtCSBE+Ter9FZrx6nktGbh
         M0jK1e+ZeYtfeBTsH3Mod2WvcXAeC3wBez6pBFDrPpw9c4JwQoR2rtZTidlycL7Ii+9R
         pX/3xLn9ANeAgGPyYsZQELqm4jHh9YAMV9gU/WWL+Nk48klATac1v6ZnuvkEjdAVnZlK
         /bL0rZRKvRRKp/BrAv7eZeFLo3Q71dKM+CNQiKH5MmOs+RquhYFk4lwytc+vFJ2Qfgay
         8e+pSp2PEdEYx2ZJhW2h/iSgRYmioqIA3TjAk2/RX33vyjiofmcSWIHs/Iq6Aokl5Y4L
         nWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbw2xxJYmuQVF5wu7TGXXPkFGRBPqJqpafZWFMmsBKXgRTfkv34rjaATEKXb0yAzvl6k06YqROag99vXR3@vger.kernel.org, AJvYcCW4d6J29GAwTeQi8iYECPdNKzIaVZWI+M270SZQkKc8qDgsJg9lildHNE6qa220gUMBHyxnVRaUFqdsNne3@vger.kernel.org, AJvYcCXyZP7E3PH5H3HLJVt4NzC4e0uRDkdZogcsdQcV9IsH/hRmH4PKoJMlh91Ayxcc0x48r8x7SEDMJp5Esg4CwnUl69Lsmp32@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+Vo3qvecJC4iMcHXEw09OMXu7kLc13LUnN0h5XhSt8d743N4
	02wXt/4aw7pYbTkdLV3bafYwooxrCgTQPCQeh3CUkCmM/w0w/EKo
X-Gm-Gg: ASbGncu0c7GtOwGbEH3aNJK1G9qK2xtY3FugYLmx44JaLr/RQMcPbdAt2pszTKHXrYm
	PTnO8TMl+QVeoosEIyVreaOSl6TN5nECrJuka9+FDpFieb2JbSonfjRR4ORyLcS6MRiWM3OSRrL
	J/XTS8YyahPk2GI+FrlFZr55C0aPQ9X+/ru2qitOKkJ3PXc4fGVPHfU6mh41bMdCHffkbbTyqnJ
	m5gjqMZrK4IY7dzkipzCU/Rhk5vAZuD4JVGQ12eQ+tnVfrA87Y5qBXQbA==
X-Google-Smtp-Source: AGHT+IFgtk6jOdWEsSdncfPCjwcB9wQhaA/5CrzSDwYRsmOEiX/mnVJ0eCaQ4xy9JZMlynTTDd29Lg==
X-Received: by 2002:a05:6000:178d:b0:38a:2b34:e13e with SMTP id ffacd0b85a97d-38a87303df8mr9425565f8f.18.1736527047444;
        Fri, 10 Jan 2025 08:37:27 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a9407fd62sm3153027f8f.92.2025.01.10.08.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 08:37:27 -0800 (PST)
Date: Fri, 10 Jan 2025 17:37:26 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	syzbot+34b68f850391452207df@syzkaller.appspotmail.com,
	syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com,
	Ubisectech Sirius <bugreport@ubisectech.com>
Subject: Re: [PATCH v1 1/2] landlock: Handle weird files
Message-ID: <20250110.3421eeaaf069@gnoack.org>
References: <20250110153918.241810-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110153918.241810-1-mic@digikod.net>

On Fri, Jan 10, 2025 at 04:39:13PM +0100, Mickaël Salaün wrote:
> A corrupted filesystem (e.g. bcachefs) might return weird files.
> Instead of throwing a warning and allowing access to such file, treat
> them as regular files.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Paul Moore <paul@paul-moore.com>
> Reported-by: syzbot+34b68f850391452207df@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/000000000000a65b35061cffca61@google.com
> Reported-by: syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/67379b3f.050a0220.85a0.0001.GAE@google.com
> Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
> Closes: https://lore.kernel.org/r/c426821d-8380-46c4-a494-7008bbd7dd13.bugreport@ubisectech.com
> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/fs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index e31b97a9f175..7adb25150488 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -937,10 +937,6 @@ static access_mask_t get_mode_access(const umode_t mode)
>  	switch (mode & S_IFMT) {
>  	case S_IFLNK:
>  		return LANDLOCK_ACCESS_FS_MAKE_SYM;
> -	case 0:
> -		/* A zero mode translates to S_IFREG. */
> -	case S_IFREG:
> -		return LANDLOCK_ACCESS_FS_MAKE_REG;
>  	case S_IFDIR:
>  		return LANDLOCK_ACCESS_FS_MAKE_DIR;
>  	case S_IFCHR:
> @@ -951,9 +947,12 @@ static access_mask_t get_mode_access(const umode_t mode)
>  		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
>  	case S_IFSOCK:
>  		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
> +	case S_IFREG:
> +	case 0:
> +		/* A zero mode translates to S_IFREG. */
>  	default:
> -		WARN_ON_ONCE(1);
> -		return 0;
> +		/* Treats weird files as regular files. */
> +		return LANDLOCK_ACCESS_FS_MAKE_REG;
>  	}
>  }
>  
> -- 
> 2.47.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Makes sense to me, since this is enforcing a stronger check than before
and can only happen in the case of corruption.

I do not have a good intuition about what happens afterwards when the
file system is in such a state.  I imagine that this will usually give
an error shortly afterwards, as the opening of the file continues?  Is
that right?

–Günther

