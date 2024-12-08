Return-Path: <linux-fsdevel+bounces-36705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6339E84A3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 12:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7208C2817D3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 11:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB621448E0;
	Sun,  8 Dec 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBGx2a+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226EEEB2;
	Sun,  8 Dec 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733657231; cv=none; b=iFk3ICcL1Wa9C+bQC84xevALf1mWSvsXapPEzdliBqseR9DtramrxUHXuPRVu6+KKvu70evdD+7s++bo5OYiVk49g0OrSw066ILblSy0HCjSsGgRngS91biectCkaHYEnaFHBCKaGvOEoP++xpdZwdSYhRXMJXcIyvC2aFlrVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733657231; c=relaxed/simple;
	bh=lbMgVCEochd8cBdIcmYjZ4Tv+9aAwL7sabZWZz0vNBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTuJ82JaigCXy7BO0ZCd7tk9+Z2nRJ+3FG/KwFYj/5DI9XD2WkgGkyYpF1W+uAjA6j8KM8G63mkLgp2jsMsNHviYL0Cb/aUN0Zl0TN7zrnIJHggC/MTqT+qgT2g8m3rCG1LLZoQ9WwNFfu399280sTToDnaM8vLz44QjMwXrD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBGx2a+P; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so465673266b.1;
        Sun, 08 Dec 2024 03:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733657228; x=1734262028; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUW+2iId8Zd5sw8XkFZ1jsrcHJHTv4++FpqEFyDMn8Q=;
        b=kBGx2a+PjhMEjiuJ1V0/E21m2S+wnPA0+d1rda9Wwor0UBTT6itgtp5QaZMLYdiUR9
         tVy8GDLKyc5Bp8y6WEX2wFuL6yTIL1Km2Z6VhfAVhBDAndwOCl/Rw4DrMpRlcvt5/1aU
         q1UjsJfcsqKTMszA0/l4HSjJkKpZ9gxN//m+fA/hD35CoXhCump+J+thVNdZFJ03GFGf
         3LaajREQkZ0ZquLiNz/qXVfX72Vrg0Trqsv28UOLf3eT1pxRMTgrsEJqFDnb4HReviZz
         HJZ3pbI0+mCNEc3ZLdPSX0wKG1dcvl1tBLqaJP42X4q7IIfbgmpMeoHZbX55J55nGwNT
         pXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733657228; x=1734262028;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUW+2iId8Zd5sw8XkFZ1jsrcHJHTv4++FpqEFyDMn8Q=;
        b=eLCZOelWVRQTzoK87vLQQXbd2MD/E2b274LmISf+Bslr86PdoXQKFIW6hXB0Z9DGFB
         z7wlDKTQlheh/pGOFNkBIoOnS5drG0Il6AuZmxhbjovH59w+bOXB0wbE9jWZ2rxXCi2p
         XC1YTnYgdKP7l3P3Uq6MEJEGFl6uFTH5+CMAIgkc0hbanG+aISvvcHb5Hd3b+ZBkAavH
         rz7w3CvUkgHatdKxuWG/X4wFvJ75DX2genwJ/khyb8NWaOEk1/ckyxYzQw3h/bGMV2lm
         /P8gHDxu2FvuAd5l4DbG2+jIctUhQu46HhlN7V/Cf7jUrnuaiRe075T+1Qwfm1MX35xk
         A9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/hcBhY+Qwa3clSfVfzdLV5+j0Kyb44EndzSiw7wGELqdyNFwMi839fhJnV+QjnNe0A15uYk6tnf/DpWDc@vger.kernel.org, AJvYcCWOxNIlsaXmLlxqFmQDI30pEKcgv+rhLR0QR3H6gwgAfYrp7Cyf5C8MFGWubnhG9aEs7dCdXIlakpiWDLD8@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEkWqYYHDrRd9W+fRdxEhBgf/cBMY6jVXxqqtyu4Ea/ptro+t
	nGywtU50jJl25tvp7/c34zEkZvWf9Ez0uvkqG8CV4N6kTFRD851l
X-Gm-Gg: ASbGncuHRjAlrNcEVMPEyPxtXwQ2aMRfnNEYbpH0Ut+/FXELJpMcKaYv++PaFLXehwE
	w201S7v6WhGJ/91IAMqzfqAElHbL6uR8r1Uyaep6nIfx7HD3aFdtbtoWwmXpwQoU9mIQ6FPGObs
	mZE2dauBn9qidayFBzt9OmkzvJvO/0DZnnH9trkrRYBOb5bJ/Ke8HJvqXSviIn4GBiIoNcags5s
	s3sx+dlR17ty5IHc9yC2rKFXdKKXDKrEpV6grrpqgRTvK6ZNg==
X-Google-Smtp-Source: AGHT+IHS+B0iRGQt5BsO9uK/gwQVsu2n4QHvr0IM+ThzUnPuEmYlYuveqnSOHlPIygXmvjWWlZdwtA==
X-Received: by 2002:a17:906:9d2:b0:aa6:841a:dff0 with SMTP id a640c23a62f3a-aa6841b1083mr46573466b.32.1733657227714;
        Sun, 08 Dec 2024 03:27:07 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260ae4e8sm520122566b.163.2024.12.08.03.27.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Dec 2024 03:27:06 -0800 (PST)
Date: Sun, 8 Dec 2024 11:27:06 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: abstract get_arg_page() stack expansion and mmap
 read lock
Message-ID: <20241208112706.cmzyrotgnjflv47h@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
 <20241205001819.derfguaft7oummr6@master>
 <e300dfde-b6a5-4934-abc9-186f7fef6956@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e300dfde-b6a5-4934-abc9-186f7fef6956@lucifer.local>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Dec 05, 2024 at 07:01:14AM +0000, Lorenzo Stoakes wrote:
[...]
>>
>> Maybe we just leave this done in one place is enough?
>
>Wei, I feel like I have repeated myself about 'mathematically smallest
>code' rather too many times at this stage. Doing an unsolicited drive-by
>review applying this concept, which I have roundly and clearly rejected, is
>not appreciated.
>

Hi, Lorenzo

I would apologize for introducing this un-pleasant mail. Would be more
thoughtful next time.

>At any rate, we are checking this _before the mmap lock is acquired_. It is
>also self-documenting.
>
>Please try to take on board the point that there are many factors when it
>comes to writing kernel code, aversion to possibly generated branches being
>only one of them.
>

Thanks for this suggestion.

I am trying to be as professional as you are. In case you have other
suggestions, they are welcome.


-- 
Wei Yang
Help you, Help me

