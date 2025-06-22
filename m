Return-Path: <linux-fsdevel+bounces-52397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED40AE30CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CB37A75EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8CD1EE014;
	Sun, 22 Jun 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvCdFS2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A458DDD3;
	Sun, 22 Jun 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750610160; cv=none; b=U1QgBU0VDwvHvAxPRJ3S6f7DdNKbAe0VA6MfGUDTPxQ6hC5LhXLqLl7iFGZ70IiltWMRqW2HvBYt+A3P2evB758dk3o/+5x7oZ/cQxVA1GBLS6b/dyPapPE0we+LGh0+ReJvLcd4vMxpEDAlZc2ayqwfMNwKw98Percjk5xX7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750610160; c=relaxed/simple;
	bh=0MNHobrzR1isQrVx2j3psQxijYtWVnqO9jfxuSncCj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBPfdDwLtd1LKJ2TZu1gUxWyQIoFRAD8M8nRaucKNpz+L2/pcP0CxGtNTQkCArJ1ZsjzT4HXA9PdgVwKMgcr0auRs1TUVvIHIebqGdd0EiHv6vM06zGb0/TndKsCKjSe6G4qkKGIw3jDn8UdVaVj9fqFUm01pZifZoSjM4ylyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvCdFS2c; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so39219935e9.1;
        Sun, 22 Jun 2025 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750610156; x=1751214956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1oa4nNQ6OD1xXNiA0TVTj0NDdNUr9/eQINchl8HXO8=;
        b=AvCdFS2cg1eaVkJUKo+s6tq3Dt7jY6LtnbsXkWiux/mBrPZZWmm44Fo7TlKhQore3b
         p+kLkLQgwcWebeJVTT21WR+/LKG8PCDftxHVAr9a8fiSgqZXKZGL/id9kL68hn1vAQKm
         nO8yHLXEawhi62MZRZDlKLsS1fxCeElHvjHIvpK8dZOCJXz6G1RSty+BphpLFHCoT8Uo
         HqtT4BLQF33bOIyLeN/aemfMd3omblXlUCpUKixKLAZaEbjHw3vGkhimQCA0r3VIigal
         p470YxnwWE4k+lQy6UnKezbamUdFECs4Vd7l0rSoiryylT4fRSHJqHXk+nagFDANx55Y
         /Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750610156; x=1751214956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1oa4nNQ6OD1xXNiA0TVTj0NDdNUr9/eQINchl8HXO8=;
        b=rULqjZrbEIocf5j/xBhEHtrdZUAC/09syvpXEJCYZTodaWjTFpbRY5TC2naYm9IjAP
         xGUMKrD1ovu9/v27CoROc0lbaG6gHtU/4DzkwcMTv9C6a6km7472uLOKPX83WAyPj4kl
         HivsouqtxSPkVyFAOINjl8+AqVx9EVduJ9ZotoFuOUVRjPKf9C96CnHy6BshyfBCXgoo
         7x93oU7txzQYhRGhsZt0vpWUw+Qmj9xsixQ9w+apDoEGRTG4qzt3lYxjjaZww3wagZ9L
         6kMW5izInXyR1rLZepwO+NUIqH2q/O2rF4GO0gHFVh5g0i/0p/J7kDV98628OcU/R8fH
         X26w==
X-Forwarded-Encrypted: i=1; AJvYcCVZwp/CqCf3qiQnGiy2MI5hi4euLjAzsQFLLRWQl6oUR2qLPdtkkCvY71Mctk1H+LX807QAjquQFnkxMfFi@vger.kernel.org, AJvYcCWbd/QgL7zN4mGK5QOhMMSwINokm6kN5yu4ULZTzHB5I648uVXeaw5RXzxoekCcRDcAY/Q9aXk9vBkLecP4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mS9hHnqsgq+gsrOTYrE/++YfGBhR6t2+juBv0yNhEzWmrq+W
	jWGK2zj0uugWZCX1TySY9TUXGyjIpciZaMVrOf1XhrWI6G2AD0N3hQWX
X-Gm-Gg: ASbGncvkjVpCaHZyawKyrMMGoSqhNlLbnoLn+UR+iUqPHGJLSDtls03dLt8tvUrmGPK
	cxRwXpok2v1NeQroV2dn4cmzpQUhGKJ7gvI1R6vOh1aowQ0JrRl00aI2VeyvlRhhxc8VyjBfAUZ
	5SAndkdu1DwLnvd1jaIxDaJ0W/apvZBj2qRluftpb7j4IU4SApB2+aZ4wwmcD6UkTQ8V5FOBUow
	BQL1kf4OQ3aCOM2+ZengSlo5TJ5/Z4gkGl63jRY1Hv9ROiBst/LICqoDMV1NVshCloPD7Lyn1i+
	03yHFqw1KY63KGQRDz/nL+FmMX9oroTMPB72UArD4Cd0SAdRBdefat7EFr3wrzW8ziE8XraVvlW
	BbhUHxCcpHg0HVIyyojHOtdTQ
X-Google-Smtp-Source: AGHT+IGIT3mcJ0gknkqPxwnQDk3KNRNpW3ykVb1rF9fBn2/P8z4fr9bdSWKQ+VnywD6VovL+QSHlYw==
X-Received: by 2002:a05:600c:b86:b0:441:b076:fce8 with SMTP id 5b1f17b1804b1-453659c0bb9mr104566595e9.14.1750610156286;
        Sun, 22 Jun 2025 09:35:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f186dbsm7175528f8f.26.2025.06.22.09.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:35:56 -0700 (PDT)
Date: Sun, 22 Jun 2025 17:35:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, "Andre Almeida" <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/5] uaccess: Add masked_user_{read/write}_access_begin
Message-ID: <20250622173554.7f016f96@pumpkin>
In-Reply-To: <6fddae0cf0da15a6521bb847b63324b7a2a067b1.1750585239.git.christophe.leroy@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<6fddae0cf0da15a6521bb847b63324b7a2a067b1.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 11:52:39 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Allthough masked_user_access_begin() seems to only be used when reading
> data from user at the moment, introduce masked_user_read_access_begin()
> and masked_user_write_access_begin() in order to match
> user_read_access_begin() and user_write_access_begin().
> 
> Have them default to masked_user_access_begin() when they are
> not defined.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  fs/select.c             | 2 +-
>  include/linux/uaccess.h | 8 ++++++++
>  kernel/futex/futex.h    | 4 ++--
>  lib/strncpy_from_user.c | 2 +-
>  lib/strnlen_user.c      | 2 +-
>  5 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 9fb650d03d52..d8547bedf5eb 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -777,7 +777,7 @@ static inline int get_sigset_argpack(struct sigset_argpack *to,
>  	// the path is hot enough for overhead of copy_from_user() to matter
>  	if (from) {
>  		if (can_do_masked_user_access())
> -			from = masked_user_access_begin(from);
> +			from = masked_user_read_access_begin(from);
>  		else if (!user_read_access_begin(from, sizeof(*from)))
>  			return -EFAULT;
>  		unsafe_get_user(to->p, &from->p, Efault);
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 7c06f4795670..682a0cd2fe51 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -41,6 +41,14 @@

>  #ifdef masked_user_access_begin
>   #define can_do_masked_user_access() 1
>  #else
>   #define can_do_masked_user_access() 0
>   #define masked_user_access_begin(src) NULL
>   #define mask_user_address(src) (src)
>  #endif
>  
> +#ifndef masked_user_write_access_begin
> +#define masked_user_write_access_begin masked_user_access_begin
> +#endif
> +#ifndef masked_user_read_access_begin
> +#define masked_user_read_access_begin masked_user_access_begin
> +#endif

I think that needs merging with the bit above.
Perhaps generating something like:

#ifdef masked_user_access_begin
#define masked_user_read_access_begin masked_user_access_begin
#define masked_user_write_access_begin masked_user_access_begin
#endif

#ifdef masked_user_read_access_begin
  #define can_do_masked_user_access() 1
#else
  #define can_do_masked_user_access() 0
  #define masked_user_read_access_begin(src) NULL
  #define masked_user_write_access_begin(src) NULL
  #define mask_user_address(src) (src)
#endif

Otherwise you'll have to #define masked_user_access_begin even though
it is never used.

Two more patches could change x86-64 to define both and then remove
the 'then unused' first check - but that has to be for later.

	David



