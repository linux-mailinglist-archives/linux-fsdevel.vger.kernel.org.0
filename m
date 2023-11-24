Return-Path: <linux-fsdevel+bounces-3771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60DC7F7F73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 19:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135351C2144C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281AF33CCC;
	Fri, 24 Nov 2023 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P4WwO+D7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D492128
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:40:11 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so3019734e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700851209; x=1701456009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n6dMaBnN8wPxxEjM8N0CTPmBnvpOexlwMzfQXUjTE8U=;
        b=P4WwO+D7apZBePL1C5YgXrneQu5IVGUSqxZLcXpMu+huujzgzVvDCLmxVJHSPHamga
         G9zvX/p+6n4NB8ZtJwoesfdplhfIPT0roKRnDxxA1dahtXIoYtnq8qlEZ6yvvbam3dKg
         HsMchHogW7CobpjAI7pBLMxQjqjo3s618Nwo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851209; x=1701456009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6dMaBnN8wPxxEjM8N0CTPmBnvpOexlwMzfQXUjTE8U=;
        b=tUS6yZc1q3ehvRschmVlD3cy8IpshAM6xFwm/OAndVuKqeEDAYcz4BibtufJ+bhl3b
         LczEIdv/kvHxEK4xLMnu7YmDvzIaDxIrFc5RSVT1ZXHIUwx+wSrTZ5hPbdHbANdYCDjp
         rhNLZMl0AyX0+U1Adyz2l8+u+3ixq8SDVXPZcYkmvnmMqWeAx8Sjjnm4Q74Vgcv8uHMu
         ATMkiODTRKWNivFfawGlbKsnykHlt+R6Ikf1BQ2Ioh+E3bBRA+kSR6areqH85vnZKRVC
         vfxmKLO/daptpbL1agYdhvym8w3p2MzbyCy2lQeqZLcwUFxuABrevvkTcxeUswie5S7d
         5LHw==
X-Gm-Message-State: AOJu0YxehwJ2asa/KjrYQhlAti0+nlB8jxOZezjyCqE08qRMb9ow8ber
	XasTL+GzUs1UFIlvRLJPmgM+3ooReuz1fneA74I7og==
X-Google-Smtp-Source: AGHT+IEhnoN1YQK6aIjZ8+PTtOIBiL+yaiNG+vLOM/RTjsS0BeSNNHJQB3/lZfASLQrCCjO3fSMo3Q==
X-Received: by 2002:a05:6512:3f0a:b0:507:b1f8:7895 with SMTP id y10-20020a0565123f0a00b00507b1f87895mr3209781lfa.38.1700851209252;
        Fri, 24 Nov 2023 10:40:09 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j3-20020a19f503000000b0050aaaaf82f7sm569447lfb.260.2023.11.24.10.40.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:40:08 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50797cf5b69so3015689e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:40:08 -0800 (PST)
X-Received: by 2002:a05:651c:1208:b0:2bc:c771:5498 with SMTP id
 i8-20020a05651c120800b002bcc7715498mr3557404lja.18.1700851207707; Fri, 24 Nov
 2023 10:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1205248.1700841140@warthog.procyon.org.uk>
In-Reply-To: <1205248.1700841140@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Nov 2023 10:39:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz+y82U8ycSBfey_ov1GxdiUkkVpjJA1f0=JogWqUp2w@mail.gmail.com>
Message-ID: <CAHk-=wjz+y82U8ycSBfey_ov1GxdiUkkVpjJA1f0=JogWqUp2w@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 07:52, David Howells <dhowells@redhat.com> wrote:
> Btw, I did want to ask about (5): Does a superblock being marked SB_RDONLY
> imply immutability to the application?

Obviously not - any network filesystem can and will change from under
you, even if the local copy is read-only.

So SB_RDONLY can only mean that writes to that instance of the
filesystem will fail.

It's a bit stronger than MNT_READONLY, in that for a *local*
filesystem, SB_RDONLY tends to mean that it's truly immutable (while
MNT_READONLY is obviously per mount) but even then some sub-mount
thing (and I guess the AFS snapshot is a good example of that) might
expose the same filesystem through multiple superblocks.

Exactly like a network filesystem inevitably will.

In any case, any user space that thinks SB_RDONLY is some kind of
immutability signal is clearly buggy. At a minimum, such user space
would have to limit itself to particular filesystem types and say "I
know _this_ filesystem can have only one superblock"). And I'd argue
that while that might work in practice, it's insane.

                Linus

