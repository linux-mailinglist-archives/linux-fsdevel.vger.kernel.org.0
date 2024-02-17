Return-Path: <linux-fsdevel+bounces-11915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C40859153
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 18:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D77D1F22665
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877E7D413;
	Sat, 17 Feb 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AlKF4ke9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AE1D681
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708191532; cv=none; b=RuFVXKU1LfTbVWvwuA7ga7qca+cgwiuPtPOEkc+8Uvn/IOfK9LiPdAiHMNjZbRR/snXxcEn/QTN+rp2SwBzIQI7VSHhVNXQlvYkiK2yYZ5rbq8JxD3C/0F22bY5KsgsysOxE7TBh3ZVWIa8eredaqC83lbdhIB6CdNoLxNR39m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708191532; c=relaxed/simple;
	bh=i+ObIVVycgUAeNkQC/SibpEvibJ2oy2gm9tDEV9651E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnJ5lgUnDgyHKnfK2G1GlrA18eRmK8PgEr4uR5Y0c+yyZxSg80aEMCAqX75R/BIzvyTQ4bDxChMQFHheiZ+TgCONZ07LJ9UXMVk3BtC1gqOfPNrX0ZjB4cCp7dVbvXsz+qTNF0gqVAWFu3jAR18TQDFRMUpdGBZTUfVWX5HV0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AlKF4ke9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d094bc2244so42253281fa.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 09:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708191528; x=1708796328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i/RT0wnncjlrMgsAi3qkZJUSgiidU29Cil2lNRbx08M=;
        b=AlKF4ke96M2XA9Gk7ydmc2adtB6pzD5UxMcJ9fgkNH0cPZBBNWGS6T0Dhle87Wzu54
         8QgoaqeEADHYgvk+du2RN3xMCxAsPpwr5E4/QL+a97Gd6jZe3myALsf1UAry9Uf27Yad
         4IvdF9Ll9QoiKEnGuHhY6RG3Cj37f/mBAHXGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708191528; x=1708796328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/RT0wnncjlrMgsAi3qkZJUSgiidU29Cil2lNRbx08M=;
        b=WwMgg8hidePoZFZ8IubW2ACny5YM9tbek0d1Alho61gbKAViRhY+ajeHtyHIIIjoGF
         u9cCkgkGfY00lOpl659huoVbh/xHV4GY9zjdhXTAkhuUJAXabHBi+t597FbQaS5ltT4F
         09GKM9oqsc1pR5fV9F4dTBV76je4Bm9mqp5sYzv/kSrI160bI7VI57KpD1JNP2lc4o3f
         WUcRt88UsXd2UMv7SJlZDjVyjD6QpZgUa2p32fCMZrVqxLoY2+bL0XrQfWnBVfDs+/j9
         yIxOjT7nnp+qLbFtqzMNPuQ3D1mwO2utHsjbBFcx9jr4qyh4F//EKAQrtIuWSOAuXg1l
         TN/A==
X-Forwarded-Encrypted: i=1; AJvYcCX7zfHx80l2FmUKFG+jTpP8JuTVze0fHcqUaW/9COVF5fRPsOSzcrGlf151oWrZ6Y/vmveLuQEGNBcoD1zvI6TAvqSIunch+QmT2b4xug==
X-Gm-Message-State: AOJu0YxSXbrdzpVn2qXGJ2aasuL/P7OmyF8YJyvQkvzbtoKMH2PYayPg
	R2jRzSpufbvTv19YZEsLEOYhmC8/BVxNtt+p6unDDfWXqFFPeMF7nS1dt//O205iahPB6ZdSc2E
	PVcs=
X-Google-Smtp-Source: AGHT+IFdtfzVYA+k2yaHbws6+xWmf22yjMm97ZhC7Kt59bxhaZObc1hdOpdE+V8gwOmiXViodNaetQ==
X-Received: by 2002:a05:651c:1033:b0:2d0:ff21:2a13 with SMTP id w19-20020a05651c103300b002d0ff212a13mr5268072ljm.32.1708191528401;
        Sat, 17 Feb 2024 09:38:48 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id p22-20020a2e9a96000000b002d0a5d4752bsm383234lji.84.2024.02.17.09.38.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 09:38:47 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d094bc2244so42253131fa.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 09:38:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsFtar47bOBSFxjgHqHBAYoagSPUcNBW+RKmi95yc40jIkjRjduyCRGFj09HHkgeA8F34Jb04bgrLVkJxu5Eim7aAM+8V/VQ1WOhCvAw==
X-Received: by 2002:ac2:551c:0:b0:512:a785:53b with SMTP id
 j28-20020ac2551c000000b00512a785053bmr822378lfk.46.1708191527469; Sat, 17 Feb
 2024 09:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner> <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner> <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com> <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
In-Reply-To: <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Feb 2024 09:38:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whY0Vm+Hnh1Kn2WSx2DZg5-_PMOtrqrjQV9batXSL5Cbw@mail.gmail.com>
Message-ID: <CAHk-=whY0Vm+Hnh1Kn2WSx2DZg5-_PMOtrqrjQV9batXSL5Cbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 09:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yes, using "atomic_long_t" for stashed is a crime against
> humanity. It's also entirely pointless. There are no actual atomic
> operations that the code wants [..]

Just to clarify: the reason to use 'atomic_long_t' is for the
_arithmetic_ atomic ops. So the "inc/dec/inc_and_test" etc.

The code wants none of that, and can make do with the regular smp-safe
cmpxchg operation that works on any word-sized type.

              Linus

