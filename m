Return-Path: <linux-fsdevel+bounces-7763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E182A5A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 02:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE724282FCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 01:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AECA4D;
	Thu, 11 Jan 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RcbXVhLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FED7EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so5942797a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 17:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704937658; x=1705542458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6u030KI6il12QBShR1lcsXxHEUIec68JdndFK14yRTA=;
        b=RcbXVhLxuTvndQgNP5zPdxsAgMaDGuIrCcY58ETZj24DXrGUjns5tAOIE10JNSbOtE
         tj0bK4y5NJLbW2AChovtzJRx7Wnxraziq1NhoxLSwX74PD910tmOpGvd6yeYhFaWTCTp
         +OQjUvQbkqV0fQNUcaAHRS1vEIStocxrTtvbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704937658; x=1705542458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u030KI6il12QBShR1lcsXxHEUIec68JdndFK14yRTA=;
        b=fbsgHOzRMghgdRNaJt8OqM7Gwj2mNWBuDdmjZa4MuQB/9k0xTNR0KAv9zIoibx9MzN
         AKaZUuw/KLVlRrUyr1srgJ/QOXLVE+GEnEX8onV9KUH0b7I4rLHSMZkLuMS0Lq4lKKjP
         bCkVlmw5R5SkhHcNc2PwZLHYuRPFIpaxsEO37zZXoUrHwqcfAkUPbBSNP6IeT5w9yObS
         FYI6ppIRSC0eK9t7weBP0h6iohlwfUTWKRt2Lk8BOdmQQCukg84eKeUwAuqpcKJeOD1L
         OPI7SyiQ8Vw9sqcbeg13umHwoWG0nFCZ8CANg6RTfqQ7wZbqfiVtrnLYWaGnWd6/fvNQ
         vAxQ==
X-Gm-Message-State: AOJu0Yyne/hJzX/S7OzlSkPxVXq+nbYnfzW/PmADBR76SUoRj9CDO14t
	vmVEOJB4XPgSE9l6z4ywaNXmLT5zqHoE/m96R5VTxSGvgHris/k8
X-Google-Smtp-Source: AGHT+IHsH+b5UJpzptsJoeci6kQEWyTxop4dT13EHMQp45Y0Stjp3F+kvtQBSG15Flz+WuMD1X38nA==
X-Received: by 2002:a17:906:2351:b0:a28:b71d:6801 with SMTP id m17-20020a170906235100b00a28b71d6801mr169324eja.149.1704937658346;
        Wed, 10 Jan 2024 17:47:38 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id n26-20020a1709061d1a00b00a293280c16csm9052ejh.223.2024.01.10.17.47.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 17:47:37 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55753dc5cf0so5689128a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 17:47:37 -0800 (PST)
X-Received: by 2002:a17:906:abc3:b0:a26:8ee9:9b31 with SMTP id
 kq3-20020a170906abc300b00a268ee99b31mr175059ejb.4.1704937657031; Wed, 10 Jan
 2024 17:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook> <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook> <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
In-Reply-To: <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 17:47:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
Message-ID: <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 16:58, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> ...And how does that make any sense? "The warnings weren't getting
> cleaned up, so get rid of them - except not really, just move them off
> to the side so they'll be more annoying when they do come up"...

Honestly,the checkpatch warnings are often garbage too.

The whole deprecation warnings never worked. They don't work in
checkpatch either.

> Perhaps we could've just switched to deprecation warnings being on in a
> W=1 build?

No, because the whole idea of "let me mark something deprecated and
then not just remove it" is GARBAGE.

If somebody wants to deprecate something, it is up to *them* to finish
the job. Not annoy thousands of other developers with idiotic
warnings.

            Linus

