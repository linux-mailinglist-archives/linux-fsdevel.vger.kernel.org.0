Return-Path: <linux-fsdevel+bounces-31362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FC99569A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 20:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A601F25B6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6B213EE7;
	Tue,  8 Oct 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cE2tBpM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58144213EC9
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412375; cv=none; b=QiSX5DZSj4PmkKY6WPXeC0M+J7jqV0GkLG6g0wosil5uGBC08EEh+vZ2IeQG0k2An+zA36b9rX1wQYE19qmWOUVR+dcAfzHUiWU/6s03NLxTyqI3pyC2/H+hGfBdY/ZnKr2us1l7GyCLTTlqldXhCHX4JacPQpxxhFwBFMTY/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412375; c=relaxed/simple;
	bh=NdQwiwQuLoS2/vzCdC3cG3nYhs+SrFNqy7Aeb1DsPg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o24cPcU45gUuF6aj5DUFRjHrMrAooR9hZSxxdH3mWyAtA+9RH8yRMVvWcX1O1i3Ikfdm3Ol1ZuCdlWM+1b1QxikTweFrnT/V2rdgOcKOp2QKxpS+2RQ7lPFwC1+6NyHozEppBYxsg8n9v25e0TRBi3DJ1IvcFuWWHxdGMM5zUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cE2tBpM8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so192851a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728412371; x=1729017171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJoPz0THRqBd4HlQLDGinYJ6nPjtsrSYsGPiskCD98Q=;
        b=cE2tBpM8ASxVWH2Kp4FF6viv5Hpl1v5ecwJOt35vclWpwAFp/j7AM5rgOvfNwQ7V1s
         dpiFc+KMDjF9gwTwD1Ybg5nCOufKqnuRksayxJr2bZhg0/8ZTTL3VvZkU1EzH+bc4bsm
         dlnR5l984wDrhlFhq3SlRLyX1N7wvS/0hWAk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412371; x=1729017171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJoPz0THRqBd4HlQLDGinYJ6nPjtsrSYsGPiskCD98Q=;
        b=hbHCcvO0J6aig6RNz28+UO/GQ6/1WCiEOab/zoVIaAuiecHoJQB22UGsGHlqMBAnh3
         d7MKevvpLjaAphcEpY5BdxdQBGyb+dAOZbhskyFLGAMvoPxkFMKM2vo2Eq/kdh7OP+g/
         F6kzj2j61IoUriF/lexvEscG4SjBrb+rVpbAgPVb7pf5/In0tZ+hMI928ID0op/miaJH
         /J6u4jsM8/8wnqZalvlg+RO+0taVsodP9ihtsyYUpeabF9DUxCkhITDcKbayiU4ZUDfb
         N99NnCBCtj4hlOydUtln5Q9yrfvrzuqe5k5V6clMWq0Bc4H0xwED+vm8EV74ZFpGbaSJ
         qZIw==
X-Forwarded-Encrypted: i=1; AJvYcCUJhOu4QjSPGrYIpURM5SkExmMb+XdJV4xL+0bcaUSj/3AraCXhH+XjHsirhk9b7E65b7xbswbPI1VgKpFa@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRXX9w+IsfvTSDExFXj1k5b1utJKpfUDZbyzZx7g0yFHAC25n
	nYRTOWJs8pbSYIZpIPFE8ROKqiOw8wZ70Yj9a/7qSQBKsG2qLYbsIqzvgo3y6LcQ34LLCBcHZ/f
	wpVv7QA==
X-Google-Smtp-Source: AGHT+IFfo4Qf1VYAK+UvGbrlA9X55KMzUNR5NkGPrueeYeJ2KrrtZ80Bizf62cQ/2tfnFByGVTWphg==
X-Received: by 2002:a17:907:7f12:b0:a99:5f65:fd9a with SMTP id a640c23a62f3a-a9967a7bd65mr504098966b.21.1728412371328;
        Tue, 08 Oct 2024 11:32:51 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e78498fsm537700466b.107.2024.10.08.11.32.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 11:32:50 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a995ec65c35so14817966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 11:32:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpJYLzuvCBSAvr0J/CXgoTE7QWDM4ow1elo6ZArDjMqQx0b/bg6gMMSLfh0w/xNBDVPGCDQlnPA1+5v9Vq@vger.kernel.org
X-Received: by 2002:a17:906:d551:b0:a99:5afa:cc62 with SMTP id
 a640c23a62f3a-a998b277a2amr1061966b.19.1728412369839; Tue, 08 Oct 2024
 11:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008150247.6972-1-almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20241008150247.6972-1-almaz.alexandrovich@paragon-software.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Oct 2024 11:32:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5a-4NGhU4J-PxOwVgNEqN+ZSQ3ZvUMfy5DhzGdZXLmQ@mail.gmail.com>
Message-ID: <CAHk-=wg5a-4NGhU4J-PxOwVgNEqN+ZSQ3ZvUMfy5DhzGdZXLmQ@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.12
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 08:04, Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
> Please pull this branch containing ntfs3 code for 6.12.

The bulk of this *really* should have come in during the merge window.

I've pulled it (.. because ntfs3), but still,

           Linus

