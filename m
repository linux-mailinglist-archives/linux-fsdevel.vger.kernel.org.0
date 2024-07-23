Return-Path: <linux-fsdevel+bounces-24152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFD93A64E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEC2B232AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB79B158A37;
	Tue, 23 Jul 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BWoVOlkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C889158858
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759635; cv=none; b=tHE3UmxKS40fmFVCPtn0wvjhpQ3A6U5/+q1SDYyRODYccQVGIFjw56xabbYN0RFA6hdVs7vl550nNMxY/jhM7CmGflNq2Hy3cRJYXsPjhwUIMdKrd1Cid2243MyaQ5S5CdhpETuJlxqTMC5Uq3FbrKeZP7bT/w+7HTgYo9Jrlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759635; c=relaxed/simple;
	bh=NFq/ekDOEm1BCUiEQxAbPVsS7vv5PxDQqveu1WlBUdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc/kUYyguLALdUn21xR+kYVEkOzhq5xG0It0ljQUIxHM9O3BiM/WZwt0mw4mvy8qW2TqUBS3X5RLCwlHJ66aEpC/hgVk9+bkC8267tfI2CPQQD3YYVI+F0ALuLfwHFafFauFzWVnchMnYmmrv4E2quyDCWCyG9niC3LgFXT9ElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BWoVOlkh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so4768758a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721759632; x=1722364432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVlnyN0btPbYCcHbH0TkKobCqtHm6zMls3/CNbNfk/I=;
        b=BWoVOlkhhWtTHUF4nKcFnVEDmWEvMIIXT6uWr6WvJC2qcVhoYqcbkuTxV17PNZMuss
         EeBEyGYv+kp7YDQB9vqG2Zsi/lOz3tbPFvhTt5cC9ZkMiuljwqHJ+T8HncDwcgNkMV9o
         0GzdAoD1N2Z69DtYI0erbcGA1WelF6MmHcrUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759632; x=1722364432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVlnyN0btPbYCcHbH0TkKobCqtHm6zMls3/CNbNfk/I=;
        b=OBYZLgWtJ4ZZHweAFuzhGl5RQdGx9K8/aaFB3vR50nm7u/Y4uKDcdrl5tof3ekR2vb
         j+lcdYbvMfAVSjrtRANuFLD1EeK/Wa4luie0UR6TzqZIa4i04dxMDAZGGABQYq9B66Vf
         8PO46lZxn1yJFTYoKRyU5jk8xmY4qffFCGVpcudJyIOzZA4awy40w69GU5U1RO8QGkO9
         yuyc9VDyqUmSNRbxRAvaa1POvszRD4MR+i+pdI5/OxY1FRp58pbrePfksId1tYHaE131
         Z0hDSkkhnHI6iw065YiieJPx0SllIYCp33HOE3IwCIE94A3VaBu3AhxRygfKqs+jPQRG
         HLNw==
X-Gm-Message-State: AOJu0YxLM9BGJPY7jvHoPJgI/gpsc2M1C7EIFlad/5Y9vx1cQtjNL8Sk
	ncK+yeQymC91bXzADaUsSUuYZbyIzHSN8j8Ums7HLqfcKGtfEKeksoGeH6cfNkcjGVp3hpayHrj
	/+LzjMA==
X-Google-Smtp-Source: AGHT+IGxJO3ScnABrtjChZXFuZtEsDHSg+sAuj/bn2StWBtIxzffiwNImgVFx8UoaRV8NPyquxmTeg==
X-Received: by 2002:a50:9fa8:0:b0:5a2:6e1c:91ed with SMTP id 4fb4d7f45d1cf-5a47a61f401mr7094416a12.27.1721759631869;
        Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30af8384fsm7941288a12.44.2024.07.23.11.33.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso5172941a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
X-Received: by 2002:a05:6402:26c2:b0:5a3:f5c6:7cd9 with SMTP id
 4fb4d7f45d1cf-5a47a61f330mr9178333a12.26.1721759630852; Tue, 23 Jul 2024
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723171753.739971-1-adrian.ratiu@collabora.com> <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
In-Reply-To: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:33:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU8igSGkycZ1e8+6-NF9obbbt1aZXYwd0ONzXnHsBgHA@mail.gmail.com>
Message-ID: <CAHk-=wiU8igSGkycZ1e8+6-NF9obbbt1aZXYwd0ONzXnHsBgHA@mail.gmail.com>
Subject: Re: [PATCH] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 11:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but while that looks a bit prettier, the whole "fs_parser.h" thing is
> admittedly odd.

.. don't get me wrong - /proc obviously *is* a filesystem, but in this
context it's a boot command line parameter, not a mount option.

The "constant_table" thing obviously does work outside of mount
options too, it's just that it's documented and used in the context of
the mount API.

                  Linus

