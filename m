Return-Path: <linux-fsdevel+bounces-19357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67D8C385C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C33B20EF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 20:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E98537E7;
	Sun, 12 May 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X7LZthBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92B42077
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715545768; cv=none; b=UgRF5Gi/TSn/WIDfJB5yODG6TfH1+6xa+/1HThQcvymGunPigXSCkF4vnbt8EEVMoR/ATaiM0Ak2dMSad+fHHGS1Pv7DitwW0c2GaQI6KmHwpGgAS+mEOSLSg5YyQ5DeYKlsn4GO6qv3P6t1IjG6MUs8hgBxE3Ldmb2dxinqAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715545768; c=relaxed/simple;
	bh=8R1vcBjGnRHm643zQlPYmibpa42JeprtbLL1O9Df0Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sq9WLKrzNVWNURoLbguH2GfmiFtXzPAXfDwaZIEMeQ4GQSKlwPuZMyqXNlTeFozydOYqEdu+2dupKyjIplK/mqEZzXg5Ng+XZMbnoGf3jyvOmpWG7ZT9T+uvtzdlq1Iv2KJm4wO9THW0Uya53cNZjRIdXNMncD3rLqw4nf+1t3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X7LZthBQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so774461366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715545764; x=1716150564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLhAAMtTilh+acvxS1lvVpwxtWLHhHyqaWXuOXpO4TI=;
        b=X7LZthBQUso1TxmC0x6mtDNdMvvdICeNAmtAKuUpfkKkqpobMVBNrRx0jEnH0xPmcg
         7/MT1+X8kzdI3lumqloyvnufp4W/Hs9Gi2RR47zrzV9lAv1sLoSIwlyg7eFS4JbpvlO9
         ShkCIAfezRu38nwJyoy841P2g5UdnxLwkuS6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715545764; x=1716150564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLhAAMtTilh+acvxS1lvVpwxtWLHhHyqaWXuOXpO4TI=;
        b=DRAJ27CLd7LRF2ARgccWm3or4BUxI/hm5YsxKRNpnCvXbENEFDDmdHBR2QZ8o1F78O
         3uB/KH5yjRYdpdwhHiRqCvRvM0gwMBvXzbfJQLOYWgSgb/t6pCBdERMR++kUTQ8oUaCN
         QZGHutBb8IuCJCqsTCZ0pJjmUHTX5TAERUaICvmPoRdXHzeF+5Gpa1xwI9gQImsmJQYA
         ITU4247v/V/6c+aULolgN4AZhFeZybQTob7UyMdOhl+dMOLhTPeDhJcnb/zWHzVy6dks
         mH2OCtZC2etHMVqfurJzy/RUnCJ029IQdPyHSzeXuuHYLpgrETJq6VaOqlKxuVe75OAf
         +djQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz6SEEm0xTOKuyvMiEZ792DDD0sOAIZUThqspWvB3/yNpPv0+jKidm7R7Oa7i562F+/d1Rg/yuhkpb7dr/OiY2FuJan55agEcPOdUNdg==
X-Gm-Message-State: AOJu0Yy5EcFey7YzauWe44CiWiG2m1R8aVRHTQU35mFjTCFvYlZSkNKB
	zcQKHy4vaOGp4g9Ua1TjNaW975qh8VXNKo7734inOhZGAhyyDSAWA6UjHsXnY2nijJyRRWwrtSN
	tSJ0=
X-Google-Smtp-Source: AGHT+IEeD+aVWpuMmSvN6eka6acHoW8WmPmwsDgFIpbgiB2dUDMsIOroOrx1d5yXmZp1NKJm6a06EQ==
X-Received: by 2002:a17:907:3601:b0:a52:6159:5064 with SMTP id a640c23a62f3a-a5a2d65ecffmr928904766b.52.1715545764171;
        Sun, 12 May 2024 13:29:24 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cf91sm493170166b.1.2024.05.12.13.29.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 13:29:23 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59b81d087aso919337066b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 13:29:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUURtGodWePzvBQhQnU304Ncd3dHVhD0qoNs5DTY77dV6iUDdGP4RHZYRDRThPZ4FnVroj7BcH/OL6ct4aUoOJtuj2cy7jTrNazTnfAQg==
X-Received: by 2002:a17:906:eb07:b0:a59:bfab:b24c with SMTP id
 a640c23a62f3a-a5a2d676025mr834868666b.63.1715545763013; Sun, 12 May 2024
 13:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org> <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV> <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
 <20240512161640.GI2118490@ZenIV> <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 May 2024 13:29:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ-Rd0_Phh63VTrLXQw0_8m-d93gD5Mg4f18C1=-a8jA@mail.gmail.com>
Message-ID: <CAHk-=wiJ-Rd0_Phh63VTrLXQw0_8m-d93gD5Mg4f18C1=-a8jA@mail.gmail.com>
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, brauner@kernel.org, jack@suse.cz, 
	laoar.shao@gmail.com, linux-fsdevel@vger.kernel.org, longman@redhat.com, 
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 May 2024 at 12:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the children are already unreachable through that name, and can
> only be reached through somebody who still has the directory open. And
> I do not see how "rmdir()" can *possibly* have any valid semantic
> effect on any user that has that directory as its PWD, so I claim that
> the dentries that exist at this point must already not be relevant
> from a semantic standpoint.

Side note: our IS_DEADDIR() checks seem a bit inconsistent.

That's actually what should catch some of the "I'm an a directory that
has been removed", but we have that check in lookup_open(), in
lookup_one_qstr_excl(), and in __lookup_slow().

I wonder if we should check it in lookup_dcache() too?

Because yes, that's a difference that rmdir makes, in how it sets
S_DEAD, and this seems to be an area where existing cached dentries
are handled differently.

                Linus

