Return-Path: <linux-fsdevel+bounces-74600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA63D3C5A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1CE6A8FB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB17D3A9009;
	Tue, 20 Jan 2026 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeFXQe0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6634214F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903016; cv=pass; b=bhM3XsROoBSZhkWqp2U7BgqJIWTGM1nXaejuOoPvWYfCPcS5jscTmXT6y3D0gFkupsjjMM+MycWhVN3Yjjkjbb17/Zcyu65CeQP9Z8enNExK6BiaNSD8oOJTMYa9p4CcLAuspQIE1XXLGcdAT0rVwiv2HkLbroMnhzEQ4t1Mgiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903016; c=relaxed/simple;
	bh=9Dhv4VwbA4U0m2vH0vhDzEoBZ6ShPMRZyYVuMVnFWP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syORpUbVVoPl7FG7cYt0O+WF9iPnm8cnV5sKkJqJC90oouHY5k3bbPNr7OVS0MDmnRGOEisUQtbKgIwvz6O0anpGSU/UZ6AcpmFbfrPEhONVXm7oSNBEccaJ9cajx8ZI4ZyDKESsm8XdsDaQ5r9gLTplThs8DAaAv4Dj3Sf5toY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeFXQe0g; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b86f3e88d4dso928931266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 01:56:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768903013; cv=none;
        d=google.com; s=arc-20240605;
        b=e+en9glaopnlbF4YGte4YAo79uH7KpKfH3aReBuGV2DxoThJpNNlISMfjEL74LspLT
         geFfOnkStfQr60XEpF6IEWiXY9nG+pE6s+LgV//8fpnLyEgVpVkxCMJI++Z8sHPPPNv6
         97oA7cm0RXRk7wWUDjOmhxjIGqI9qK4IuM8lmGITaWHhBB/PoBMZugL7jYIQUxtlKL2P
         MlaRLqE1jfn+mlr/F9XK0NiBRQ7IvoVptbGDSVjL64NNRclVfyWoaVyMjZE7lHexb57f
         9cpClaTwCxe8qnnsL9k0bPyr5YxQEHbGNr2i2uVT1m0g16lYPOIc6odjrC5iNfY+jAWC
         0L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Dhv4VwbA4U0m2vH0vhDzEoBZ6ShPMRZyYVuMVnFWP0=;
        fh=AKvcTgS0++TAaYc07UNILnvTBxGSEdU5Ufhzp9LcFPc=;
        b=iJuOwBRV6/vqDU6jQginXR9Jzm+7akiLXTmziUTn+u9ONvNtXxYY/jRiNV6q5eS9pE
         H+Iw/w+6yU+CjZ/VPWtg5VO1IacLy+ct6nyrPNS1f2bHyc9PS9R9mewEh/rrGQgOg1uE
         RzRMF/L6v0SxyFI+5KJWo/2MWJ6R6f6hfQmVrlcQtDKx+5q8kd4Vux0m7nQwCdNmyP9d
         29JseUW7ms3VIViA2vW+dSBnw5SKNcDTom3CGzC3/vl2HKQhruTT2kD5wu1VP54OnX2Y
         MBwCmSujPhiK2u1guywddLBfl5hW3qjS1W9LjIbcWmpM05BO+US+gwbpDBvv4PvLxaX5
         KAWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903013; x=1769507813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Dhv4VwbA4U0m2vH0vhDzEoBZ6ShPMRZyYVuMVnFWP0=;
        b=SeFXQe0gRU8Gtasp0TCPuR9xIgo1l5LsrDdXobETsfPQWbd0I0fdTyoegOzEKrv40c
         Bad8iv/SeZFLuLP+HJPQDedpEjIlvamf5jN2MZUR+XChi4ISV7xovSMnvHGrXm3F1n1x
         pqCYwW5kb8D2Cc0BAsPfEat6bnyUqv2yFFUTZIm/YaJE3wJkw2/xgVSvNEFxab0ESjl6
         Foren6vWbcWfph7yaswAr2Jk1IGlus3OcKqJVudo01rzMnnts5VkMn5/sgS+fyl44RZy
         GP9/TKS0jwbqYCvdbPsOGKypnVaEeyNUgxriIY4Tn1Mnb8SrISPU4Jdtknsrs1LISCzk
         Valg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903013; x=1769507813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Dhv4VwbA4U0m2vH0vhDzEoBZ6ShPMRZyYVuMVnFWP0=;
        b=jBBcn+RIOmNjSovomUe0N1TW9KMBdy2VEksDNeRcSSj6BG4840cTRyPLeYMFu2aQaG
         gKEe9Nt36t370KrRox74mZLjd+0lJ+HRFch0SuL0bgG6U4PJNPvKWVwLvsgJpwlaTzxl
         6clq6BkAh5aWAif3lpiot97WUl1D2AlqFfrEK1caC4sTz69O9A0pveLM/0rXQujkiUSc
         p00JBkOkUFGkhnfHKRSkHS/Kn6qo6yl8RpyHDSVYoZq0YZf6Wgg8i/PsxlzxOEnihCRL
         aCGCeenLn6G6ZLKQqxkVOdhZtbkU9H3D2P/rrnXiRpMuri9KggWcLABcC5Sb0TKOwyCp
         TUEA==
X-Forwarded-Encrypted: i=1; AJvYcCVIzsI1CNBUnSFzewwNKZHRKhO6Vfcs6nlb98RoiEOVLlmhQv8K2lxb6R3jljgJfCapLxWo6kHQ2LlxEbOw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xNYTGoVVzSO0AwHaEW9hf/jcndHUq9TtnBmwaqUgr+iJUYSI
	ltVHClmiigfvK3SGEqJt335Fa5YkzqIr6orOs7JqQCsEUYq8rKL4pwmYlizEpa+MuJ8GYKvj72z
	EIu5Cx40xDmTQfHpIq6siemZucw9n984=
X-Gm-Gg: AZuq6aIEmPJx2wNtaM4Sg/E5UY5sbYc1QWiVIwWL6mvXVDjvlFgaaTU/Ot3wIElsKA+
	n4j9b1VY9ZWyb5Ea6pTlPTosPKlp3UVJtKo3sDzClTT9XUy2VbAnSxcYjjf9BNoer15GzdGxixb
	SRZlWjnvIb66wZSVY7dA7zMv3OUIwT2O7BXiyg5970zFW5gnUVwa1vHXlyfs4rOr//gDfTcwGux
	D1B3ibh8JGdfuD/MltNfrjVCZ29dP7P8l910k7n4evN5KQWnyQDQopZ77N4Y6tRtnOhS1KARGvD
	IFlx74h66gDJ3R7HOTIb6omst58=
X-Received: by 2002:a17:906:ef03:b0:b87:15a7:8603 with SMTP id
 a640c23a62f3a-b8792fc3465mr1346199666b.43.1768903012644; Tue, 20 Jan 2026
 01:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
 <CAGudoHEej7_Q-nkJqBU8Md15ESVtyxZ9Wbq9zwyUEcfT034=xg@mail.gmail.com> <20260120-teilhaben-kruste-b947256ed6ab@brauner>
In-Reply-To: <20260120-teilhaben-kruste-b947256ed6ab@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 20 Jan 2026 10:56:40 +0100
X-Gm-Features: AZwV_QhMJEGz6W61TaUT3j4m4-Y6UUiONKsMizzVEczQInwuUMFzp9dOZckL78o
Message-ID: <CAGudoHEGUDaToxwhsFHT1vB7Q66-H2UMNpX8KTj-dcEZy4Hz3g@mail.gmail.com>
Subject: Re: [PATCH RFC] pidfs: convert rb-tree to rhashtable
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 9:17=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Jan 19, 2026 at 09:51:30PM +0100, Mateusz Guzik wrote:
> > Longer term someone(tm) will need to implement lockless alloc_pid (in
> > the fast path anyway).
> >
> > In order to facilitate that the pidfs thing needs to get its own
> > synchronisation. To my understanding rhashtable covers its own locking
> > just fine, so the thing left to handle is ino allocation.
>
> I'm very confused why inode allocation would matter. Inode allocation
> for pidfs is literally just a plain increment. IOW, it's not using any
> atomic at all. So that can happen under pidmap_lock without any issue
> and I don't see the need to change to any complex per-cpu allocation
> mechanism for this.

I am not saying this bit poses a problem as is. I am saying down the
road pid allocation will need to be reworked to operate locklessly (or
worst case with fine-grained locking) in which case the the pid ino
thing wont be able to rely on the pidmap lock.

It is easy to sort out as is, so I think it should be sorted out while
pidfs support is being patched.

The nice practical thing about unique 64 bit ids is that you can
afford to not free them when no longer used as it is considered
unrealistic for the counter to overflow in the lifetime of the box.

Making it scalable is a well known problem with simple approaches and
the kernel is already doing something of the sort for 32-bit inos in
get_next_ino(). If anything I'm surprised the kernel does not provide
a generic mechanism for 64 bits (at least I failed to find out and
when I asked around people could not point me at one either). Getting
this done for 64 bit is a matter of implementing a nearly identical
routine, except with 64-bit types and with overflow check removed.

However, the real compliant about this patch is the re-introduced
double acquire of pidmap_lock.

