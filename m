Return-Path: <linux-fsdevel+bounces-67748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F41C494FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 21:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DDAE34B425
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 20:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6B2F5328;
	Mon, 10 Nov 2025 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TPMyloj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26042F290B
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807998; cv=none; b=UKBRrZ6Hmkor4qE5KxeZRX96uSSHQYYsoKxri2uU1K2yIwZUKh1vkChxmB+0eVMsc2fpt0YVt8HzpH/0ebb0iyCj9ECR5WBSNxdO5geBRzFVie/M3ClVbCsd48RXwbm/alEXHmhl2CePRkPs9lSGV0YWVOwHUIoKbvowI2jCDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807998; c=relaxed/simple;
	bh=JX9r00UWOioSGgY9OIngH/ryyDZlP1m8Vn4QG2kc5H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+m6GQeGn1WVBHdDaeZ0FG5bSEg6oRx07Dqr/c7J+xEyRSD6Wz8ZYLEudTiMcsA8dzOqgDgY9LiaU2JNBvFopqV9nDajHePNugGL+/MzmAIzvMHigV4hm4x0DCz7Nwstp1roU4wKXdH7A6BhVFtrwIMJJkV/lY2s8reodntB7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TPMyloj3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7277324054so516530066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762807995; x=1763412795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf8vYmew6sPCWLS1uooTayzzz1zVmg4FNt5aKYULseU=;
        b=TPMyloj3GXVYYAuGb03fJ32y8sUZNdIYiagEoS6IIUSWB9e4WCLlVQxzV72fQXecO5
         1Xv2viMoeJBn7N0us+sYnT1suZN3JDE1r+qLmoNvCWwZ+ao06CNn1qFGbtPC2jxOAIfY
         MCtwxEmlx+eutS1Exbir4o4oQzgpbA8/E3Rdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807995; x=1763412795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf8vYmew6sPCWLS1uooTayzzz1zVmg4FNt5aKYULseU=;
        b=fK3RQDe3clI004fEFsex6jkcEYMZQ8BEoo1F/ppNeoMt1ahJjwoBRErakqFVD/g4tM
         9ji89SUM7mcUzDE/DbxRVgVlcHeTYtEDjajCGegXL6BGhHpqjz5wiHhY0PFJWqHlmz7d
         2W76DAdDsJa5bbPZl+/ps6Cobhgc6eKr305jYiu7lDRHP16xMJws9jmRp12ZT2BWdfNa
         2gjJhibtQ6B3ZXt9zXaQmjpIzcdcXysuVjm5K1iKAJAoMb8IUPilICKNOh9m/Mv0ernY
         EEfMe8PRevTjha9CREwLcRWY0p+DwxZbP5an4xFKIeLnMvVYJAFkBpuwZFHodVSoVBVQ
         NTrA==
X-Gm-Message-State: AOJu0YwykpVC0hQX1Hr52cRw/MiTpwVnuqzXScUK+xpRKavQQvMsstVw
	Jx/Cj6C5/vt2H07B1cz/65unSc+V6vDSfZdt2asLfgjqEXy751SkHgvJd/DcJ+JymUEY4HFCPZ7
	fVbvuQ6A=
X-Gm-Gg: ASbGncvhhjEBzY0KSYb9QU67xQEMju/NAmMBp9m0W46pB+fKiVebAZiAgbUuMNDKoRJ
	uZ5Nd31vtn7vwOgSNwTRf2MOx+X1M2ymXZZ6NlZkBqZpW2z3xqce3OSYMq0aD+Xmk2TBBKRCtg5
	6ikmg+fi/PYXzCLBESg85L2lfEZuVCivEk1Lt1QwWNcANv6MpWIf3Jt27ez5nGsxxN5cl/wuyLB
	rjYUsZzyB7mkX4ikor9ZF0NExTsTLGKxSdbO8/PL2KSwB5uXVSf+Y89SKWEoabMSqF83Zdqv1q6
	1W6n+dxVJFFcwVOYER7Uu21mcS3nFZhVFoUn/os4hnHtDhzMuQwYcqsjP54uLLv6mVj+W/epzWk
	KketMdbvBwQP8D3FKol5Zf+oO1JBMb/Tl3dgiiVSMAFzyRTG+SAOUFVaMayBzfsWlfwczx5o1yp
	sB37q6sQ3s6lHtUS2/AV0X/TG9MKZ6Nf0+zr1VpQ0b4X8trBToLg==
X-Google-Smtp-Source: AGHT+IEpYs8oeCWjRWEinRr5t+J7ceKE9xLCb9FdLvaizFxj+oZ8pqe/rgIAVegeKkAdt2ZCASz2oQ==
X-Received: by 2002:a17:907:1c9f:b0:b5c:753a:a4d8 with SMTP id a640c23a62f3a-b72e05bce7emr923461366b.62.1762807994834;
        Mon, 10 Nov 2025 12:53:14 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf40768fsm1176439166b.23.2025.11.10.12.53.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 12:53:13 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so2039137a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 12:53:13 -0800 (PST)
X-Received: by 2002:a17:907:7b96:b0:b40:fba8:4491 with SMTP id
 a640c23a62f3a-b72e0310d6fmr1100087666b.17.1762807993264; Mon, 10 Nov 2025
 12:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAHk-=wjA=iXRyu1-ABST43vdT60Md9zpQDJ4Kg14V3f_2Bf+BA@mail.gmail.com>
 <20251110051748.GJ2441659@ZenIV> <CAHk-=wgBewVovNTK4=O=HNbCZSQZgQMsFjBTq6bNFW2FZJcxnQ@mail.gmail.com>
 <20251110195833.GN2441659@ZenIV>
In-Reply-To: <20251110195833.GN2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 12:52:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3vpw5W6rV6VKxa9PYF3Xwn5_6AT=OwqBWO79g6N1B_A@mail.gmail.com>
X-Gm-Features: AWmQ_blj7UCkHVNWD8MxILQgPkvzV6LzxIw6bD27yUdHSxmjHA7zzLofljDreO4
Message-ID: <CAHk-=wi3vpw5W6rV6VKxa9PYF3Xwn5_6AT=OwqBWO79g6N1B_A@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 11:58, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> If we go that way, do you see any problems with treating
> osf_{ufs,cdfs}_mount() in the same manner?  Yes, these are pathnames,

Hmm. In those cases, the ENAMETOOLONG thing actually does make sense -
exactly because they are pathnames.

So I think that in those two places using getname() is fairly natural
and gets us the natural error handling too. No?

              Linus

