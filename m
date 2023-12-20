Return-Path: <linux-fsdevel+bounces-6591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4F81A13E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 15:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535E1B2173B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24903DBA8;
	Wed, 20 Dec 2023 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZntQW+0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806D3D985
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33664b6d6abso3453866f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703083148; x=1703687948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2oUpPP2PLyXV8nPq8H1pk05VlePtZv14Y6rjtd2zCg=;
        b=ZntQW+0SNqTLPlSvwnMh7ExUUc/znMh3zcBeTpkqLsRpKKnpZKtknEspxMxT35+T/l
         b5+OX97x1/j1CABxYDPqpKJd793y43Tn9FkhPxe5JW4ZUiltRGggAkpgPdfiS9L0b57t
         l26SQx2uJbveqBnuqnfv4E15LO8j0K8dT/K2vZZxMLbIt6qAvyQWbDnBg7f1LEUikDYH
         /HTyIZpN2D4qXeHq56J1zc76ymM1L6tM2Bei3Kz3fVwbgLwQxrg0PwPbjJcxMVmooi0/
         tKvq6pdJlUQiiw4/XubmRRFer2afeVaCivlOwpRP2Y6wV8I/iKHNO8gwit9YwQoOCFqE
         qEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083148; x=1703687948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2oUpPP2PLyXV8nPq8H1pk05VlePtZv14Y6rjtd2zCg=;
        b=ubaweeS42jPYxIx//q6undX1dqVBsBRnHQT8lHBzz/tVi3GM21+Fiwu3ZLkRWKZ4A+
         I989UmkXNImOGaYF9LMl4GBwgUUJspMJwH2+QffCn6d0ZHQbTBZiYSwdwB9Gwlidr4ZO
         2CX5EyeBuzhjO19UJ4Q+4d0bHHpdvRBkaiFp9Y5XQPIa5twPNAi98z6t5PoXUIPOog7j
         7/svWn76Kfr7zKGxaickAqGJYEAHXKFM58deInnxJl9BA/3ip4MWETvobehzxUAsJr4V
         bRisXaCIkrPxBnV9G66QU50qTeX5Od5mNwdc3CmmGsTpRdBnFTjnutXESZqTWNn9+/lA
         4nEA==
X-Gm-Message-State: AOJu0YwKqej6/WhAprugIX7T7ln7NuZ0w6Ar8qGJpihP1qGIh74Wf9fc
	mGftVnQzJ+prvVPO/LmRLNjYRmEZSKmatPCGhS/tpw==
X-Google-Smtp-Source: AGHT+IF8K6EUmmfn1dSorG+bifQbkbItpBNPjm2gICGt2CYz8CKW5ogpaRIJFGwGAo1cEwXzCcejyo4bDjcnYdjSwOs=
X-Received: by 2002:a5d:47c5:0:b0:336:5b5d:245f with SMTP id
 o5-20020a5d47c5000000b003365b5d245fmr5663984wrc.140.1703083147437; Wed, 20
 Dec 2023 06:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
In-Reply-To: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
From: Alfred Piccioni <alpic@google.com>
Date: Wed, 20 Dec 2023 15:38:31 +0100
Message-ID: <CALcwBGD1hW4RJEpm6ABgEA--0RKkn1U9O5mBPL1g3B4Hw+0gWA@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> By the way, for extra credit, you could augment the ioctl tests in the
>> selinux-testsuite to also exercise this new hook and confirm that it
>> works correctly. See
>> https://github.com/SELinuxProject/selinux-testsuite particularly
>> tests/ioctl and policy/test_ioctl.te. Feel free to ask for help on
>> that.

> I do like extra credit. I'll take a look and see if it's something I
> can tackle. I'm primarily doing ad hoc checks on Android devices, so
> I'm unsure how easy it will be for me to run the suite. I'll get back
> to you shortly on that.

In response to myself, I unfortunately won't have time to do the
testing updates this year. If someone else wants to help, that'd be
great! Otherwise, I'll take a look next year after vacation and see if
I can take a crack at it. Thanks!

