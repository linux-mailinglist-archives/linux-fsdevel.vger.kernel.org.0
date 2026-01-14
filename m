Return-Path: <linux-fsdevel+bounces-73659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55634D1E36D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3836E3109ADD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D8395248;
	Wed, 14 Jan 2026 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/qJeu6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05F38F230
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387321; cv=none; b=NWsiCXpQzOam7vvpWfZm4POa2B69c0EUadMakuJOP4+izhWPPhX08olQjO6zyClifD155Tbi89k6Vkcznloq+6NJTj0ZZDp1UNM4wPg2ITUnOqMioF9YmhHfWMCgh7qRG4LgUnrc8hmDe+OiSPblGKuXr5Tz8ffSka4IiYr1DFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387321; c=relaxed/simple;
	bh=i4yytTNmVkmFiF7VhC12SD5qcVKeMJU0ABCzZO/63xY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzcwS7+rch6teid+MW1RKH6n5CxqqD5YtRnFkCse2a00UKBs27+pY+2wSjHKn770etvJz83Rat8fonVylsZiFPkpCl3LF1WzNJhDpGT4e9O6knHYYKM6KBht98Q1bRRV8ZagZ8DWeACYMWW0CxQHfkx0106vId0JemrfslTD0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/qJeu6H; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso4542255e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 02:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768387318; x=1768992118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Lk7QsQj8+PnAUAXKejIhRlWfGoAntY1XiyL3gVs6yI=;
        b=R/qJeu6HoJthZFgQ5jwvjuATd3NFsmZb0XPMd/3F+SxJRrh2rPEO9ILbrihFG86CxY
         kxJlueg7RZwNhdTfsnCtnEE9JqKk2U6nbDWV9wqX3DJZHmEq2eISv4piq6rXKkCduOW7
         nNCFB7Zn5HO9slncITH8kfyBBWlbvmhBLSxTLSE6JduzvNTqSkagb7PIC+hzNJdLHLai
         XU0zf5tjMPqOHLUjVsf8EWQThT4XU/eKfioSn8paOW38Ux+tHVkKPBUvUXHkuiC0nHDD
         /YBEI954s7ocE6RUUoOxS3s7Uh8aL4DKkSytJJ79+gA2uPCWRiFQFe45iXBeTeK5W4qE
         E04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768387318; x=1768992118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Lk7QsQj8+PnAUAXKejIhRlWfGoAntY1XiyL3gVs6yI=;
        b=sUgL5CtQIdRelNIwZobFwUGXgNQFC/ihU9eySyLZDV9trbJAp30Uwtghn2YtLvwRvD
         vsyvaz+Hk57fPV4oW/4EUOz1J+wpGup03hF7siujDwGFjXVB4ER10GexGBthLU6uasTq
         2A+wk2iSN1PRZiRZV0vwKlfLNiSLHyws6sa48QEurmsfyvLg7MgSNhICHKcEpgmS/xxY
         VN9yFgAUTP17/EqI+uHOteD/0O9nyJvL7ujTbbkyy1fenaITSlB9bOAu5gKd8Ti+diLX
         kV0AOjAYuO1pDHnkGEEQ/K9weQf3GOPk6qSzbfVENGo1Zl5SXbMW8aCW8ywIiUYSsC/A
         HIFg==
X-Gm-Message-State: AOJu0Yx8REi3N5R1x3TqPAQk6M7EUJd8+D6fuOAZtOiAVvn8hS2yBfvK
	fdNeMHPN8XghJ06HA2KnXboso4M5aWUxGjj98BJ3ww3sYG8pqlNjQb4g
X-Gm-Gg: AY/fxX7YH/4x1+WaMeU9v6tlMLx5BwV58dY1Pksoe1RH3A99IxwrtcuECeDAf4NGZOl
	UlVGie/RCVZYgszQCuBqridXTbhXbPEspIztfx/NqhlpkHI+7yXwAoFzWnOynF/BnFdZvTV3vDW
	d8FCLVyHsIvXxaItzhDRcdBPKcJdYYl77yzaXI5S8DzxNKqXRHzhzpACsVyGZOXbvpDr01g8x5f
	L2DEQODYbz1l0V0tZHB+uv3PReEX9f9dJ20G4gmUVnJu400v/cRvxoykZLSWb5chA7I/7tD7CO7
	/WaJ3Mgtl+gIITaiF1ue3A7/p++qKhFjV9wxR84+3ioNab2Nb0+gJmUMpQJyNRsf4qUZYtxKbG0
	qH7RcrxKklbsD771elaW7WsqbO3E9UzGLHecBIDtGFyVdL5LZeZWKEiu11FM7d8MU80iSBfuxQK
	MC5W4AidKH7q6L6RimHiwELZlenVGU7TV7i0mgYDu6ytkUuOcXwcoD
X-Received: by 2002:a05:600c:1c02:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47ee37a440bmr25926025e9.10.1768387317582;
        Wed, 14 Jan 2026 02:41:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee5910fc2sm20776235e9.13.2026.01.14.02.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:41:57 -0800 (PST)
Date: Wed, 14 Jan 2026 10:41:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, Paul Moore
 <paul@paul-moore.com>, Jens Axboe <axboe@kernel.dk>, audit@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 68/68] sysfs(2): fs_index() argument is _not_ a
 pathname
Message-ID: <20260114104155.708180fc@pumpkin>
In-Reply-To: <20260114043310.3885463-69-viro@zeniv.linux.org.uk>
References: <20260114043310.3885463-1-viro@zeniv.linux.org.uk>
	<20260114043310.3885463-69-viro@zeniv.linux.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 04:33:10 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> ... it's a filesystem type name.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/filesystems.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 95e5256821a5..0c7d2b7ac26c 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -132,24 +132,21 @@ EXPORT_SYMBOL(unregister_filesystem);
>  static int fs_index(const char __user * __name)
>  {
>  	struct file_system_type * tmp;
> -	struct filename *name;
> +	char *name __free(kfree) = strndup_user(__name, PATH_MAX);
>  	int err, index;
>  
> -	name = getname(__name);
> -	err = PTR_ERR(name);
>  	if (IS_ERR(name))
> -		return err;
> +		return PTR_ERR(name);

Doesn't that end up calling kfree(name) and the check in kfree() doesn't
seem to exclude error values.

Changing:
#define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
				(unsigned long)ZERO_SIZE_PTR)
to:
#define ZERO_OR_NULL_PTR(x) (4096 + (unsigned long)(x) <= \
				4096 + (unsigned long)ZERO_SIZE_PTR)
would fix it at minimal cost.

	David


>  
>  	err = -EINVAL;
>  	read_lock(&file_systems_lock);
>  	for (tmp=file_systems, index=0 ; tmp ; tmp=tmp->next, index++) {
> -		if (strcmp(tmp->name, name->name) == 0) {
> +		if (strcmp(tmp->name, name) == 0) {
>  			err = index;
>  			break;
>  		}
>  	}
>  	read_unlock(&file_systems_lock);
> -	putname(name);
>  	return err;
>  }
>  


