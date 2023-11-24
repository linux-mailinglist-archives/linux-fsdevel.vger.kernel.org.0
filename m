Return-Path: <linux-fsdevel+bounces-3784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820417F8576
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 22:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA32282733
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 21:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556403BB4D;
	Fri, 24 Nov 2023 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gBho6sCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD419B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:28:43 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507f1c29f25so3212716e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700861321; x=1701466121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UE+udvWHynzozj92dDUIlgeAGu8LTQ+iWilnuivlMqc=;
        b=gBho6sCNs9cgETHAPp8Io4gkWNqWBYUNcmKlU6uO3eK/KmC973ImyHddQrTxdLpvfX
         smpGYEEFqX54bAv5Bny+KHjGqLJKlUnL24u0TlD4ck6AGVGT016FTzIzlEZAUmFmh7OT
         VOQwsYBrPcvkyACgG6YSzch0pXIjIFoNp7snI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861321; x=1701466121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UE+udvWHynzozj92dDUIlgeAGu8LTQ+iWilnuivlMqc=;
        b=Z7kHe7ALrkn+TVeQIKc3UPPD8RXzwYgu4LdnfQfYksSBzaaOCpINpbnSEtolg02YDc
         k8inmHU9HP82tAvwAiai2E6ZTQzwIr3sfc4T88a1Mf3A95WPRFIhG1AMJE4CTP/fn0u9
         e6Sgu+u3S0P6jk09XW8k1oHLnvXXvSay59vqFgW416p1Q3vvv4d8G5V2f0Ex/EArmGMw
         8Gymo6mZMMqCtRODDaVIfV78MpfnCb1RaKJG15p5BbJIJoZwpGs8XnO5bD5yVdmS8ViT
         KM3GFxNy6z8KyupjfQ2Jv4LelaAbmakTTHNKhMWCjhE25pb2GExukJEmfPXpU2hDN99o
         ummw==
X-Gm-Message-State: AOJu0Ywcb/XD+3xEbjrf1/JiJvKnbKvmcN1ANzn8YJtCxd2jp3ufGANt
	jdBfbFVZ1dTc1Tm5JW8H+OUgt4YP+uhLgidUUxSXW0B8
X-Google-Smtp-Source: AGHT+IHlN0w3cuSBHObWu8HKboT6jLsgdu9QO9y/mLh+dd5qJ1+R5MNLmKOjqTmW2MmDaRVbrQ+10A==
X-Received: by 2002:a05:6512:a92:b0:500:99a9:bc40 with SMTP id m18-20020a0565120a9200b0050099a9bc40mr3805267lfu.69.1700861321159;
        Fri, 24 Nov 2023 13:28:41 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id cf17-20020a056512281100b0050aa94e6d15sm611281lfb.9.2023.11.24.13.28.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 13:28:40 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50797cf5b69so3203203e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:28:40 -0800 (PST)
X-Received: by 2002:a05:6512:3b0a:b0:509:4b78:69b5 with SMTP id
 f10-20020a0565123b0a00b005094b7869b5mr3916662lfv.36.1700861320031; Fri, 24
 Nov 2023 13:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV>
In-Reply-To: <20231124060200.GR38156@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Nov 2023 13:28:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsmOgYVFEQqikxtpH6w6kJ3YePTHhGVDhZSMLYvXpP8A@mail.gmail.com>
Message-ID: <CAHk-=wjsmOgYVFEQqikxtpH6w6kJ3YePTHhGVDhZSMLYvXpP8A@mail.gmail.com>
Subject: Re: [RFC][PATCHSET v3] simplifying fast_dput(), dentry_kill() et.al.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 22:02, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         The series below is the fallout of trying to document the dentry
> refcounting and life cycle - basically, getting rid of the bits that
> had been too subtle and ugly to write them up.

Apart from my RCU note, this looks like "Al knows what he's doing" to me.

Although I'm inclined to agree with Amir on the "no need to call out
kabi" on patch#3. It's also not like we've ever cared: as long as you
convert all users, kabi is simply not relevant.

            Linus

