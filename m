Return-Path: <linux-fsdevel+bounces-9260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C283FA37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27108282D65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9F3C08A;
	Sun, 28 Jan 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g/2ywbQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC301DFCE
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706478953; cv=none; b=uFTlV4ODyW7Det0yM2LMbXSwfXaBjQi1RUpuC5VbMhkViYB9IyeJoPQ6TgevCCJ/C7+JROKK4yKR3clC/51nL/HTvlgKeyNOBULjuesCjvEujAgtpTlTdwaEeNXtZqv3m4f3Qijb3C+XQsA+79M4iEutt9y7U3JXGifxymcQE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706478953; c=relaxed/simple;
	bh=9jSkYnuonGJybCKZEIMVw8ZfaI1LKdY3jyIXSfaWi08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aS/vR4RgBJot2ERjkVXUQdHEm4V9z/PIzWjeKInpMkg66UD4fuVxLo9yUq2VFeuKowR+B005YQmZPvqHCdvWncdvHyey5lfzX0sR3VyJYbKFOuvHRaLy1VwxzETh+NP5QfOgI5xsDcCI4cpfTtydt069l0fextAfkYwAM6hrIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g/2ywbQb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso3267034e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 13:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706478949; x=1707083749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLt6r4XtTa4SPYOVEEGfDF0wKF4MI0mrfWV0xt83Pcc=;
        b=g/2ywbQbnlSiURgGGwuXY3fy7gdPUFu9cqJOVgDig7iCw57igZ2JfQTxLnwbPQTQy8
         Mx2wUH3rHXohrokHbWGMKnMN81IWyjiT+FRtBOyBldF47XQ4ORNIfH0okA5TFgkG/W3G
         HunuvknwpCW7U1RzBhk6IkWJ0U28j1fAbr3UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706478949; x=1707083749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLt6r4XtTa4SPYOVEEGfDF0wKF4MI0mrfWV0xt83Pcc=;
        b=NVhga0ZKDIP9OtqHAKxtPCq5CZuytPJeW57JhP+k1erMv4KzryKT3Ig/WoobYQxzgX
         qO5wgtW3PkWs+AD76F76lVJ7JDRG5zOg6FjWm+3W6oKenZNQCgVLKiHePyySQpO4Rn5T
         P9cfUmIduwpjmLSfOGdFTsau5NyKMfrENDn7HPcYNCOWv465Z3VajspRXM7hQCZSCNV/
         dmfq16ASzyRu8MSKJM5s+76QijToxW/IL5L9gtntFwfO6rCTQnlhVnX9avIs9zoJ5ljP
         tiLq0WWpLsYNv32aH2UoDZHQRpHmYXoYvpL+lHEF4VXU7KTA6J24LhUJv2OHahB8CDI7
         emRQ==
X-Gm-Message-State: AOJu0Yx0jQcSfOFtAiSCAVxMd9FDgUjQILAOuKIt9rj6bD46jbh1N0w0
	/iSJkLkEAOYqYE85gnkcALG4+aGoqVXogFhRXhZ45rmG+Kxj0S6KRNVrtxAAij5Wevlk1ZICvcg
	cLCA=
X-Google-Smtp-Source: AGHT+IHL7GW+JW+6K+Cr6RnqoiyWkdsw9RGw+mvrCGP82zHAh+/bX1mpYsdMOCXVSHSAdSljY8e5Fw==
X-Received: by 2002:a05:6512:39ca:b0:510:e815:7e27 with SMTP id k10-20020a05651239ca00b00510e8157e27mr1960515lfu.58.1706478949238;
        Sun, 28 Jan 2024 13:55:49 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g36-20020a0565123ba400b00510189e1581sm906210lfv.249.2024.01.28.13.55.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 13:55:48 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-510f37d6714so1135934e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 13:55:48 -0800 (PST)
X-Received: by 2002:ac2:4570:0:b0:510:c2e:e0e with SMTP id k16-20020ac24570000000b005100c2e0e0emr2432391lfm.13.1706478948313;
 Sun, 28 Jan 2024 13:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401280650.Us2Lrkgl-lkp@intel.com> <20240128211544.GD2087318@ZenIV>
In-Reply-To: <20240128211544.GD2087318@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 13:55:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8LUAX_rwM4=N9kNGeg=E+KoxY6uQfyqf=k7MOrb4+aA@mail.gmail.com>
Message-ID: <CAHk-=wj8LUAX_rwM4=N9kNGeg=E+KoxY6uQfyqf=k7MOrb4+aA@mail.gmail.com>
Subject: Re: [viro-vfs:work.alpha 5/8] arch/alpha/kernel/io.c:655:1: error:
 redefinition of 'scr_memcpyw'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 13:15, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The thing is, VT_BUF_HAVE_... are defined in asm/vga.h, so if you don't
> have VGA_CONSOLE or MDA_CONSOLE you are going to get the default ones.
> In case of scr_memcpyw() it's going to end up with memcpy(); on alpha
> that does *not* match the native scr_memcpyw() instance.
>
> Since we have vga.h in mandatory-y, with asm-generic fallback being
> reasonable enough...  Should that include of asm/vga.h be conditional
> in the first place?

It should be conditional, because that's the only case you want to
actually have that special scr_memsetw() etc.

I think the problem is that you added the vtbuf include to <asm/io.h>,
which gets included from VGA_H early, before vga.h has even had time
to tell people that it overrides those helper functions.

I assume that moving the

    #define VT_BUF_HAVE_RW
    #define VT_BUF_HAVE_MEMSETW
    #define VT_BUF_HAVE_MEMCPYW

to above the

    #include <asm/io.h>

fixes the build?

That said, a good alternative might be to just stop using 'inline' for
the default scr_memsetw() and scr_memcpyw() functions, make them real
functions, and mark them __weak.

Then architectures can override them much more easily, and inlining
them seems a bit pointless.

But I doubt it's even worth cleaning things up in this area.

             Linus

