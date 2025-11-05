Return-Path: <linux-fsdevel+bounces-67060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB4FC33B56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21785464E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650EE21CC68;
	Wed,  5 Nov 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="An3z4PlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA719F43A
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307443; cv=none; b=gOIiEp29fanpDn9j50xv8eLxVu/wyjre0Ky1Ls9SecK3dTwcaaM528EF2AV30L3pXneUqge83aS4KBFa//goF+R2LYSHJqzRxd7Fh2TIpFnzf3mFduhYENWjy90acV8kKTX0Ry1av0uacgin9BcWvusbC1kYZJpTLKUEBT5C4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307443; c=relaxed/simple;
	bh=Xoo1eWw+oKxOthozh6rdMIwwomqTZAcI7+etlq4bToM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBqRvXRq9ZhWje24+cP0pcNGeGwjHf5XY7zedPw95P1YZFe1uP4kn66rqueOrvwLlpTMZ0th/KSiKLyiY5AY19VR4FrJ4FnqR24oin1gBvDaWikQDuminXIr7Ds5+Drp9EpN76h4guCaC1Phrh6e6GgzygPQGQv0x/7Uhn39QKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=An3z4PlS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3b27b50090so955960966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 17:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762307439; x=1762912239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v9O1EJ71YCT0OI8Q+97FbtiUgmbiyimj36/6bjgq688=;
        b=An3z4PlSXNnEPeiKHzsu04rGrzKB6w+WF/aUuW0GdVvoofBLuJvsyH19Z9/MLg9P+3
         gtJ6uYYVjeonxoO27NvVdNxx3uyGA6bgFguVHI15bga+LCWCcx5QQutppMTIFk6wfpJh
         wSw2MMtHKh9mZxZxoBWObFHdynOlBkizmaT0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307439; x=1762912239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9O1EJ71YCT0OI8Q+97FbtiUgmbiyimj36/6bjgq688=;
        b=aA5PZ3kwPT0TkvglQu5DbX4SoqDgg62VX2IBbBOWq1QzywBOEoi6HiQBDrbKytDCZi
         pV/vcCHkJWIndwQDhL4ulgsc2ajiRyDfK9QGLBXtxUSUDD1P8E6HDo4SWPasKjnV/b6X
         f2RmwP4BGjOKLwkZX6KatiOAvyGCp80+SKvsje3c5elfjsk3OIF7OuUdOfcA1V3KK37/
         G6gsppadfGky8ZhkgIc+tHrC8iU1OGPUfaFhXWYJlKboyNGMp0CTZ/+KxivHih7uf5Fo
         NnHTX4/uSEjRJcT0ttYsKqcsv6486vc+VyrjRTbneDauGmQbDASz9pYPlkj0MZMGqqZ7
         iF+w==
X-Forwarded-Encrypted: i=1; AJvYcCXxz9haLbQB/qB9kSKUWB9ItxsrljPPPZYdBLIGWhFLBZKdesA+5LGvHEFNcSyEgcicnvTCzADV5b2GAa99@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMgQh3wm1HLajxyVjT9BOIBjjQiLjVlOepEIm9skOKEr4w32j
	OssHqrbH0Ck6RJVTSSf9lbkkgGlotCixCHO0RdpywOjWcnT3lpU42rahl7sqCOa8CXJClIufEvV
	Ue5mZ6XO/5w==
X-Gm-Gg: ASbGncsoF8v3SP9KiGYGy4Odotk42smblyiDyK8JaoWAeRf4EEZ3aSDZgTkIR6ayyST
	v6haxZk7ksUdsNbMUu2WybPuCk9NuvFzvCWzTEQvah8eB5xQPkoKY4uMu+Low5vt+b1RsO3ma/s
	5IZBf07qt7emZtSdCMLFZeWgz/QE5APKJAZCBftOWB5Nhe5BnhmAw89d2G5GTQJ02cVpl/bPU8X
	hC/Wu9ez9mVoqNZZ/o6v+9qpQRTsIbC9LZVao1NDYmo5GkbLQiXzKzIraRcZGm6Itf8wQVqCbF/
	PhW+/UJHAnfdA/iKxVZ/UtIMdEOxhM1cQdcP8WI5X8UQFf/AkXP2syYLfwWVlbS0tT+yn2L7OXp
	nEp0etn/udhw5Vg3s/MI3aQlHXhbefqZBpyhtub76d6lwSZnQCVn2IpOBrM2nwDo1dHbexVXzEO
	xVXEZb2DtOWtWQPv0qj4Lienxnnbd9dVJySYpevCnUrk7Ek37Kkw==
X-Google-Smtp-Source: AGHT+IF86Fve8pOtGyAkYYVjaYK1lZJlw4L8H1k9qs3vWFGTd8JCiaC+88PcRHfHUbYxVO/gT7lsNg==
X-Received: by 2002:a17:906:7312:b0:b70:b3e8:a363 with SMTP id a640c23a62f3a-b7265568c41mr120729966b.48.1762307439494;
        Tue, 04 Nov 2025 17:50:39 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f9b7csm366559566b.21.2025.11.04.17.50.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 17:50:38 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so5581903a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 17:50:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOwxjT0QUKUPDriGIgcbY2QJYQjAvFOjfY4bboIuYh9aqYHyp8QbN50y2IifVaOQqS/UcxMLclO6O37tcW@vger.kernel.org
X-Received: by 2002:a17:907:868f:b0:b70:f2c4:bdf2 with SMTP id
 a640c23a62f3a-b72652ad183mr116255766b.23.1762307438033; Tue, 04 Nov 2025
 17:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
In-Reply-To: <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Nov 2025 10:50:21 +0900
X-Gmail-Original-Message-ID: <CAHk-=whu7aVmk8zwwhh9+2Okx6aGKFUrY7CKEWK_RLieGizuKA@mail.gmail.com>
X-Gm-Features: AWmQ_bmNvTH03i95LkvpehEJva-w_271URCZDbGW1hGWGw5T4Ng3DD_mmRBfixI
Message-ID: <CAHk-=whu7aVmk8zwwhh9+2Okx6aGKFUrY7CKEWK_RLieGizuKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 01:14, Borislav Petkov <bp@alien8.de> wrote:
>
> Did a deeper look, did randbuilds, boots fine on a couple of machines, so all
> good AFAIIC.
>
> I sincerely hope that helps.

I pushed it out with a proper commit message etc. It might not be an
acute bug right now, but I do want it fixed in 6.18, so that when
Thomas' new scoped accessors get merged - and maybe cause the whole
inlining pattern to be much more commonly used - this is all behind
us.

And the patch certainly _looks_ ObviouslyCorrect(tm). Famous last words.

                Linus

