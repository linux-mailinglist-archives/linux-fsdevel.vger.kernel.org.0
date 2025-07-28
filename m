Return-Path: <linux-fsdevel+bounces-56192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210CDB14459
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 00:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585065406B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9B223DC6;
	Mon, 28 Jul 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ABFxcP4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524BC2E3708
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741304; cv=none; b=GuVYpc7cjv0VrxS81H8eOCW/tm/2tzafCswHs6bgOCMT9uyopaD59SKNnjFN6xfLXFn2+giNM2WksiIIV5u73K80AuaD++NxmIIWDySfPCQQFx0CNX7wa7jciftUCzgSo2icC+ddGoTxdfmG3nKLfhsd0Z0bDT2/z86HxrmA+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741304; c=relaxed/simple;
	bh=xOpI2jYETyxLIMK6Q9ED9DU01xuFZr4mDYMkTCbHb6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1EiBz2vxEPk4LNOhvnVB52qOjGALXIexbyFfS0ZQhOfxZOJClYYoQ8vsx9rcja6vj8RO+ZVUI5IRrX+Z5+ljx6NgOCv2U/oSZ0DL94VS7pmR665fBYuirLA8CccQ/44CmdpK0ZsHjoE8oNn3drgOmVC4lRduFSbFrYMgfxB/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ABFxcP4U; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so7880936a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753741300; x=1754346100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JqExg814NmJsAheHoSQFN76PuNVP4UFH80zpicXvJrc=;
        b=ABFxcP4UTdFAfbqBRu+Dy9jGZAzAjDFgKSwz+/e1+DTi1Eq2UtrNtWQ+ZnYCm85iE+
         Vlmv4041IhsK8tctjl422r8SC+egpRpjrBgiZFQ6yP0u+0Nq4O/Ru0MKbFHlmYiwTvjm
         YCWXkm9+ZNRG9kEViaO0l85KnY8uWDuTpq1xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753741300; x=1754346100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqExg814NmJsAheHoSQFN76PuNVP4UFH80zpicXvJrc=;
        b=duhMbb8ugdjcSkwCkw2IEmi0lS3NpZp2TxbDHqf94LustCgm2P59kNYKNeCfPGajMu
         ihHIy5cv+x0CiPQ7lRg+q+RfanBmfzWeT2LteXnBXqjhuXFSZ8PXWT+z3cOG/EuDYqQU
         LnDidzrsBSsO+vySNeM8s5cWFaSLD6C/qZ7j39C2qHvqRiTChhJUhPlMjKXay0jp9MoK
         TtHoSVqleRa08olFYwf/XiEjy1ten0rmvnzL7DKtGq7YGcab1mnuDlgpyjbNvQtrGKEQ
         E2H2oUQrmLOeNfjH4hEG6tV6bsFah06G0ymtMjeZXPBpaS3MjdrS/s5JoKDmqKcJ+C2z
         PEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8vR9T0MYM1HhivwA+co7nTCck8bevPzDJe+xhNDe5IDNLFy14608DgwKZWwQ6VxYeva9yZq4Utd98MEUc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4L/vReNbprc4hVHbRMRZhls3tsNy1CQWL8TpYDQgVId/10L9
	HF7PLGFfIJW44ICOGlQfflcqKQhjNYQGkhiFOw3Yxp35lML5FQz71OtoN44h4PpHTKFNV5wjDAf
	eyNVDf+I=
X-Gm-Gg: ASbGnct59nV5fTVCh+9QdiGtjDdbVP6E6Jc2aDQz7jd3VafrgOmRvovBEKtSeupGdZ3
	d9P1FFAOQe5mLoGOEOfoXUfqQcnuHJpIth7rNnfqW+GXwUaQjPjdb9cFhMRaQg6drfy+/3FgodW
	3VsmmrD4LeSdcyhcLiLqWC4+8JjVm+WsFgq8DQ3pJ2f9iNZfF6nabgW1NDMm0XTlVUal/So7EqZ
	RShn2AMqJopnjTpKzjnrFccK2ChLsNFUTzrmNclu7mcWjV9VgW8JfIQM+zRIoDOf7bQNBOiOcCz
	zzfn0P+RpAw6vAqk/GV2SS2lVG25E0JyYDBy+Y/kcx7A1PNjWQud1eKEU+WFih5NEoVdz5WEnx8
	K4FLOiPkCw8qz3e9ofYB7PSMJugSjCr/E+3hV37rkLzpaAGv1vptPoxG7v+KjEyBNoX47WyYA
X-Google-Smtp-Source: AGHT+IFq7fsnb4qRSq7PyofRbLiIVRsjSoATAKBFeF97DCTMEVzdmlMQZA5COM5WORfjLpod6w4v5Q==
X-Received: by 2002:a05:6402:848:b0:612:b67d:c2ae with SMTP id 4fb4d7f45d1cf-614f1d5ec0amr13037287a12.16.1753741300288;
        Mon, 28 Jul 2025 15:21:40 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6153055f5a8sm2337331a12.48.2025.07.28.15.21.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 15:21:39 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so8468498a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 15:21:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrQAGRge3PPROX9ntLYLevY4XeIkFLZUfxq5zQa4TEEY7QU1f9pZhCegDJb+ZeaYCnZSJWeVKht1hMCcMb@vger.kernel.org
X-Received: by 2002:a05:6402:35d2:b0:615:5aec:561b with SMTP id
 4fb4d7f45d1cf-6155aec595fmr2603824a12.17.1753741298741; Mon, 28 Jul 2025
 15:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-integrity-d16cb92bb424@brauner>
 <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com>
In-Reply-To: <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 15:21:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
X-Gm-Features: Ac12FXwBHyV1oTWHkUDzkz967sD6oQ6xpn7rxtt-GEiesYTsoGqtNNJfDxE5ks8
Message-ID: <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
Subject: Re: [GIT PULL 11/14 for v6.17] vfs integrity
To: Hugh Dickins <hughd@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Klara Modin <klarasmodin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anuj Gupta <anuj20.g@samsung.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Jul 2025 at 18:29, Hugh Dickins <hughd@google.com> wrote:
>
> It would be great if Klara's patch at
> https://lore.kernel.org/lkml/20250725164334.9606-1-klarasmodin@gmail.com/
> could follow just after this pull: I had been bisecting -next to find out
> why "losetup /dev/loop0 tmpfsfile" was failing, and that patch fixes it -
> and presumably other odd failures for anyone without BLK_DEV_INTEGRITY=y.

Bah. I *hate* this "call blk_get_meta_cap() first" approach. There is
absolutely *NO* way it is valid for that strange specialized ioctl to
override any proper traditional ioctl numbers, so calling that code
first and relying on magic error numbers is simply not acceptable.

I'm going to fix this in my merge by just putting the call to
blk_get_meta_cap() inside the "default:" case for *after* the other
ioctl numbers have been checked.

Please don't introduce new "magic error number" logic in the ioctl
path. The fact that the traditional case of "I don't support this" is
ENOTTY should damn well tell everybody that we have about SIX DECADES
of problems in this area. Don't repeat that mistake.

And don't let new random unimportant ioctls *EVER* override the normal
default ones.

               Linus

