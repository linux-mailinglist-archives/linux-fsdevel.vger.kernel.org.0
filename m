Return-Path: <linux-fsdevel+bounces-41338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81BA2E04C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 20:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CB21649CA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F94243374;
	Sun,  9 Feb 2025 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK0To3fJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648913B7B3;
	Sun,  9 Feb 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739130481; cv=none; b=PZw7FFnuRSUokoS7B9OGAVSjk+FWUxhfsyaWR3L2kruQz3woecSlSG4u+wVeI87nGmCNxNelrUMVoaQuyCqLxOFzoFEwfhrlbxQGayypUgpDf6WCIf+v4gwBj7Lf4p+PhmL0qqV4KcxKCUOf0igVMOwN/l8mCdvYQR3vyevxDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739130481; c=relaxed/simple;
	bh=2iddprleDhyX55yjl7LmHuRBGW+otxD+SE9E258OGjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfvFmOqkkZKYIKr2sAYT1UsQP+ua7l7co7y1hl4Saqtf+GExgqHfr+pI2p8mvu+MHxdrLoORqkZNnkE0sO6UUPbMcNEsw07wD1822N1cIa2WQGwFgp59K+Zj9zNeADs6Kg9diktmBlipGDK56vrXhLbleLF22TmxUIxpKiAvF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK0To3fJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436a03197b2so24134875e9.2;
        Sun, 09 Feb 2025 11:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739130478; x=1739735278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05e2nuLFvgd3qQpz1nNUA8vFtVPDYxhm+b4OpyX6msA=;
        b=eK0To3fJJsJ/nJFeGGCcgFOzJoj+EZVX1nNKy+3zkHBmcf/IBxKJk26yvLFnsx5+vA
         KcgVR/AliQyHwpRl2YxO1gQYIZX7plPOqHzZsOh7bU0f/KESKyUwamPo9DZ4YNakI5le
         C0QaudM8P51L5QCPHDs6NqwUXGUutxaWkysa0wnXnmLLJSccSdldOwzQQ3yCNdJwBqF+
         xTcZSfy6sQPvYL5IR+S9Q6Irr+lJdBM4s2Ke3AAl9k9HUCAgbELHBwslFfxf28t/PDXZ
         4msOwVm+9dfgb2nibj9fEg7EkGVyKsmayAycQeCX5X/Ygk3NzQydwXwLhTtT6k6xtvak
         6O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739130478; x=1739735278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05e2nuLFvgd3qQpz1nNUA8vFtVPDYxhm+b4OpyX6msA=;
        b=v459M9Cl2rNdIhriBnFcfjrj5iA4X+nGwu2/MmcEFGY2xS+4KQcHp/JdFndHAGdPOE
         zPBXGVRUBURPu6szMpbslOstRGH2r4FnEr15s/9eekk/ttJrUsI+JJ9aaHIBb9TAwoN3
         IhCljcqQB7q4IqXGK6NcMFyp27V2qy2vRzb/2Kx5ue1fICleLlvc82VNR/a4HCu7tuM+
         X90OoAAibtFkNcxtTbWjiBgIeVS3BWzZADi2v77Q1YOvKlj+gyIYIc/o0Cvc3FRAXN6C
         8x6/x504lUi/dSB616URx1OZCWwMwgwIel0JLyTnCO3unNcIVYMVcfwiaoclam23S1io
         d5uw==
X-Forwarded-Encrypted: i=1; AJvYcCX+bp5OAOjJdfah1eVbd9mME0z9/J3Pq4cDN3jPrgJ7U3mDwCeH+fTfmG0dutUFRPNQjjIPPfNG2fZgCuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqlBpJzyKcYekx1vVvXGZBrt1VFCSib5FzDBhE4fB1HUcsaS3
	H7dXw5z/MMGt4/zjGavhLSrtjw2X5RxHbaZlXIZhTbSFtM9tz8FE
X-Gm-Gg: ASbGncvo6GHKb6seDyaT9We/TKgcOMk9qbYFpVbWVRfIRQRwF2jh93FMuxFHDrspuFq
	qrog9yoeXRyiJ/GyXokJtK1pLLsEhVquaiPbS5ax5W7CbydYpbM+B1Lb7xOypIpQ8FoHsBpPsWw
	KnWYwkG8SD2PeorQFzgg9t68kYsJUH5w59osFuKZV9hsKM2gDppxMiQZbpfCEgtU1NMgrg34fjc
	RcNWYIV/IJnrErTLWeSXUshXJGBeEx0U8XmjGTYf8Kj+u52cgHtvW9fe7tFWgmtChZkMVftGkL/
	Iz7ukX2fn70t9K5/9G/+TkGbnFMBwMFtmlaI7y9jerhJJjZ6H4eCrQ==
X-Google-Smtp-Source: AGHT+IEfWfkksjUPYmoMtkrUoJiZl6DZoNzSiFzFgsKp+IrxIUAEEH4Q41Xjdc1txiF9YXtlpZbNfA==
X-Received: by 2002:a05:600c:138f:b0:436:488f:50a with SMTP id 5b1f17b1804b1-43924991f95mr82303615e9.17.1739130477669;
        Sun, 09 Feb 2025 11:47:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db10b2fsm156656485e9.33.2025.02.09.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 11:47:57 -0800 (PST)
Date: Sun, 9 Feb 2025 19:47:56 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user
 copies
Message-ID: <20250209194756.4cd45e12@pumpkin>
In-Reply-To: <CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
	<20250209105600.3388-2-david.laight.linux@gmail.com>
	<CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 09:40:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 9 Feb 2025 at 02:56, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Code can then be changed:
> > -               if (!user_read_access_begin(from, sizeof(*from)))
> > +               if (!masked_user_read_access_begin(&from, sizeof(*from)))
> >                         return -EFAULT;  
> 
> I really dislike the use of "pass pointer to simple variable you are
> going to change" interfaces which is why I didn't do it this way.

I'm not sure the 'goto' model works here.
The issue is that the calling code mustn't use the unmasked address.
You really want to make that as hard as possible.
So the 'function' really does need to do an in-situ update.

I did do a test compile without the &, it exploded but I didn't
check whether it always would.
IIRC there is a sparse check for 'user' pointers that would help.

Even with the current functions, someone is bound to write:
	if (!masked_user_access_begin(uaddr))
		return -EFAULT;
	unsafe_get_user(kaddr, uaddr, label);
and it will all appear to be fine...
(objtool might detect something because of the NULL pointer path.)

You almost need it to be 'void masked_user_access_begin(&uaddr)'.

	David

