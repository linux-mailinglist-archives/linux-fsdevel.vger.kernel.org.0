Return-Path: <linux-fsdevel+bounces-40131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E7A1CD84
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 19:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAB41883EAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DD1632DD;
	Sun, 26 Jan 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R1mOlzy7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211F78F39
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917349; cv=none; b=AMlIeTvmiEDlLs5Rx/eqkvpSUG/e0efvz1IJZ3o3DAbiKVoBcQCcRUxJdoBhCxCk3H1/W7uD6WR28yBDYUqFTCI+FOSvo6zW7Zu4oV+JwsgZbvp3w37iLjbaoC9pNOOY5qmi1k6hoII1S3vZusryZm+gOaGwplv9xRj5FLJ230Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917349; c=relaxed/simple;
	bh=9+4bl650qRTAagQCd8/i53cIPSqoTxWQoFGUbxeEMWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy6H3mNXeHt9cCiTjvWWBA+IsVn9XDiqmGlR1dLN+ZUo2QYEPo9+6eP9c10uLJUYmgdphnaBkFWDvWI385/0Cew6Lfdoi7acK9eUyOAvXdpDJLlKp2CS4Gjm0/T52vrrg+Mynu8bIus1RsgWM8pSQIfWRHsJCbRsq8wP4XmcptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R1mOlzy7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso6780247a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 10:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737917346; x=1738522146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FrZ0sALiETvcJmlfvZPLZePY0CmkWSknJ94I5nMkpj4=;
        b=R1mOlzy7YuB8ail+n4YU1uno7p/JP1FrPGsP+GEql7HPJU3MGHMof+UKtW7W+JG/Fg
         DluSPY4QKlucMfEaOT4imZtdtJToKTMIGgkwqrBANgu/zqZddr0yF6drJJwEzPAYhg3U
         n12Zh26Ni1G6p1qqYkPh62b3T7tSwLm4SkKms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917346; x=1738522146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrZ0sALiETvcJmlfvZPLZePY0CmkWSknJ94I5nMkpj4=;
        b=cQUMNtweqABWf3pZqH6QCnAZgjjkyp2h7TzE2EUcCXt1MtfYxTtlv843AIRsffipqr
         9vFdMigZey0y0xhqltJMyLcNgMy5zv1X3AgWBXn7Oodm6PCKdZTOXM2mn6CRaFy79F9J
         amV5hC5dIM6ZyAQG/EAfqLGol8MqMyZjdMhl2gORur5slf4RHv+wSVENzyylN87uoZvY
         jAQStHw6vqFcQaoRObdBRY/yuKFBVKBOMdbnIF7VKwERmDIeCPegUInTbsiC3rM6menH
         7B60Y+mXaebKusRpYIGaUqbN3vaQHdT7aUhYhYFR8BErvNi5b7CYdoKu9ghLtEUZSpO9
         P6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBdoG/TJSLHxnjVvL1gUz16jjJkxx25W7M5HD8NfhuXKAtJJ/HSUVnEcQRZatykGM4s38vDW2hKQDkF1dc@vger.kernel.org
X-Gm-Message-State: AOJu0YxZrFvxEAwmYSkmsZx4NkgD3GgZ+/oejzr1AhAqZmOkzpq+bI43
	6N2v+KfB4eb2pJtYm5IB8RkGPqdKtuPE/dET1ajdnhaW0t8JFOqIhgT72si4PI7Zd9o2X335txd
	S0n8=
X-Gm-Gg: ASbGncsDg+Ir3qiiKv8UgX2MF0v7d4qokqljjSvLkV95L6pVlJxwLq/hWGI6Cz9RmuC
	hhchIgLTlYe60+Lv+h8nxzjT0L6zbZx9T12KWn9kZzn6NotS1813ZSeaNs+DC/VrW4IQgy7XYdm
	WCHvmRs8YAwMwV65VHHvGBg+Ew67kisglsQPD53KHKcjgApvorgXbAeLsyoYxhRe8svRAwPE8kU
	9NWPLKzzfXxVipNwmyL90pLmCxrnX2E8WXev6zQnFbEolAqm0XGOPLIk/P8pe3wf02nHnbOENEV
	Y8jLBNRabqkxMj/EwGv1qNSUtsZJO+f0EFfLkBsmF0YUbs4alZF5PccueqM5B9bfhw==
X-Google-Smtp-Source: AGHT+IEJZWvf/SXaRSAVe/jlJGcJmTZqLnLPAamU1Fl9d+dG7Ruzu5/Uj3C+E19x5LENen4g+06NGg==
X-Received: by 2002:a05:6402:520e:b0:5cf:420a:9 with SMTP id 4fb4d7f45d1cf-5db7d2e8ff7mr35472046a12.5.1737917345674;
        Sun, 26 Jan 2025 10:49:05 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186b37f3sm4167291a12.64.2025.01.26.10.49.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 10:49:04 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so7129218a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 10:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUk5QRKeqGTLETWacahI1pGEoKqk9WrYSidr0ljVObUxokJIv+Um33uBBYk9u12KZN9c8BgWSwbnaZ/DRXF@vger.kernel.org
X-Received: by 2002:a05:6402:1e96:b0:5dc:1239:1e40 with SMTP id
 4fb4d7f45d1cf-5dc12391edamr10964500a12.31.1737917343237; Sun, 26 Jan 2025
 10:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20151007154303.GC24678@thunk.org> <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
In-Reply-To: <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Jan 2025 10:48:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
X-Gm-Features: AWEUYZkmZjjZx_3oHvn1XNkCUxAkyGOnB497YCfolsRGd70E-DAjp1uUQmxmOwE
Message-ID: <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>, dave.hansen@intel.com, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jan 2025 at 09:02, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Hello there, a blast from the past.
>
> I see this has landed in b90197b655185a11640cce3a0a0bc5d8291b8ad2

Whee. What archeology are you doing to notice this decade-old issue?

> I came here from looking at a pwrite vs will-it-scale and noticing that
> pre-faulting eats CPU (over 5% on my Sapphire Rapids) due to SMAP trips.

Ugh. Yeah, turning SMAP on/off is expensive on most cores (apparently
fixed in AMD Zen 5).

> It used to be that pre-faulting was avoided specifically for that
> reason, but it got temporarily reverted due to bugs in ext4, to quote
> Linus (see 00a3d660cbac05af34cca149cb80fb611e916935):

Yeah, I think we should revert the revert (except we've done other
changes in the last decade - surprise surprise - so it would be a
completely manual revert).

If you send me a tested revert of the revert (aka re-do) of the "don't
pre-fault" patch, I'll apply it.

Note that the ext4 problem could exist in other filesystems, so we
might have to revert (again).  It's not necessarily that ext4 was
_particularly_ buggy, it's quite possible that the problem was
originally found on ext4 just because it was more widely used than
others.

               Linus

