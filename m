Return-Path: <linux-fsdevel+bounces-14162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F83287893D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 21:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C41F21DAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 20:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0956772;
	Mon, 11 Mar 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BbJRN59W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79AC55E75
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187527; cv=none; b=u3Qcv1NBvhvi+YtPM8HlXcVzVvs1S5lpClqK2sRKvXjueCl4BQUQN4fVlWUFWMPks9nt5G91b2sAgHHnk4WnhkD5TZs65uAUPR/n14A3unMCisMtdiNMMWpS1q0mR9jqH8SCEuKfxOx+k37SBDAmX032+7pST4D636mzAwJs76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187527; c=relaxed/simple;
	bh=mpT1sl1F0yF+bunGOpA/ynNHa11gaq+11+ZvHS6RJUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3UlC9CbQG51Daht2Lh+Qfv7ncY8fS4rD74IaWYPpVZTueTLC1u0r30D4jSLXclhTfRQDzSNqebZEp6bGay/QJxTAp46pQK9r90vMZSwlGmJz8ZVzddPHJUUfgOrxcl8HsUv21KNsRoiGYd88kmBM6MOxkQ5x6OJaTK2aaAJ9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BbJRN59W; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44f2d894b7so604272866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710187524; x=1710792324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4eiTO72xToSXf7fJMM1Ipdwyb9aIIUVWhtnvnxbKSBw=;
        b=BbJRN59Wdeohaf6YrpklY7rI16pbNIMrqmAzlNaiGP5XyGbINr5ZlTEUMEfw1qjx3t
         vVyMbGYYTpszeOEuLLJ0CvuTZCYGyge1Qe4Pv4ji66fFxaZujckKwbh7Gv9KB2u7x+vv
         indxh/6dMWsg3uFB5oe7oWaXE938H3H6kLWws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710187524; x=1710792324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eiTO72xToSXf7fJMM1Ipdwyb9aIIUVWhtnvnxbKSBw=;
        b=BWpVl8HzWimLulh78xWDqathyWARSdx7edgXppQa99xr/Edk2xcFmh4OaZUjTvHiq2
         35wpwCwLnYeLPQNYYD1oGLsCyMvN8RJv3/y9XuMagUSWwni9QY1+FDHzTA7N3nwGLlY0
         sP5e2zirXuxsOSZuLnCm8pWOWPVYNP5SLsKUS5qf1wCVeOSFYotJgv7eFzGFKqwb/3tT
         5usIIZiNpPXGAcY/S/Ah8rFRDlpCca9dNuojbUz/2OZRDSFFOo1AltHZ7LBPteq77mYV
         VwJHfviKYb7aA4dSAOO8Ig5PFOhcy3/oIghOCDWbGGAfTFCFFcsH4njR94TS4hekL8jI
         Fosw==
X-Gm-Message-State: AOJu0Yxb6h1erdZwEASNm6HdsrJtyrYxwv3o0vdIz/rfEhWyUpKLx5yQ
	eqdDildl+7kpC5vaGJ6fCGZ0EtuQWpmUf0o8FkiUzlFUfPMfvfGzSV5kduRU4TgC5v8HY7MW1qD
	j85I=
X-Google-Smtp-Source: AGHT+IGUHjfwCMprvvmoSOJm+xy9h0680rzP7UCGNGV2R8VeI090aM5GZJLi65ZjJGLtlWzks0V/JA==
X-Received: by 2002:a17:906:2bd5:b0:a44:8c1b:8877 with SMTP id n21-20020a1709062bd500b00a448c1b8877mr968200ejg.50.1710187523742;
        Mon, 11 Mar 2024 13:05:23 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090652c900b00a461543ab87sm2270672ejn.205.2024.03.11.13.05.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 13:05:23 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5685d46b199so1995011a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 13:05:23 -0700 (PDT)
X-Received: by 2002:a17:906:c34e:b0:a45:ab1a:4c31 with SMTP id
 ci14-20020a170906c34e00b00a45ab1a4c31mr991274ejb.56.1710187522843; Mon, 11
 Mar 2024 13:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-pidfd-b106369f5406@brauner>
In-Reply-To: <20240308-vfs-pidfd-b106369f5406@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 13:05:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
Message-ID: <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 02:14, Christian Brauner <brauner@kernel.org> wrote:
>
> * Move pidfds from the anonymous inode infrastructure to a tiny
>   pseudo filesystem. This will unblock further work that we weren't able
>   to do simply because of the very justified limitations of anonymous
>   inodes. Moving pidfds to a tiny pseudo filesystem allows for statx on
>   pidfds to become useful for the first time. They can now be compared
>   by inode number which are unique for the system lifetime.

So I obviously pulled this already, but I did have one question - we
don't make nsfs conditional, and I'm not convinced we should make
pidfs conditional either.

I think (and *hope*) all the semantic annoyances got sorted out, and I
don't think there are any realistic size advantages to not enabling
CONFIG_FS_PID.

Is there some fundamental reason for that config entry to exist?

            Linus

