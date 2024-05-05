Return-Path: <linux-fsdevel+bounces-18777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E58BC39A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 22:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DAE1C2143A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94907581F;
	Sun,  5 May 2024 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TIE6fivG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EDF74C0D
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714940232; cv=none; b=Q984jpnpUlZ+hyWHQG002H2Y8bbXgkMAzzhTKC3yy4qeCSCwHSKFHHavKsZUFKsT6yviWo/oAbZRBA44t1AiWW2Qo7hc8HNr+W6xd7xFc9tSthq1lAbVpTl/t+9q7yFK0PdBH6rjHV0g/RMblPKffM+C99W2TPIM6nbw5PfH5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714940232; c=relaxed/simple;
	bh=YVUUiZWgMhQe0Pv8Ng+UCkY3LYOanihQ0/5fJzF5CqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuWzXQKdp6N6nii/4sSNIOJuL2iljwIa8Rl+9kYoo/+YaTIa2tuMDvI/VPcDV+G7dcjbjRHG2Rhhy4HC34zU8I7pFfXL17X4WNRWvVmpQIC+IWexU4UG+WyeAm5fk/kLxhuAC9xYeXfOyk2prdLsi4D00l8finB6wNH7zShiQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TIE6fivG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52006fbae67so1629622e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 13:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714940228; x=1715545028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=89jyKA3wApx9BQCfs5IiJWmwTiyjcjG5A1RQj5E06Fo=;
        b=TIE6fivGd9wAkCMMfINu1pQ+4riIGri8T5WnOfDZGn9xEiupO2A8RaHTFbY2spBmny
         q8wF8IBSPGRHAi+so5pE+cx43/flXlDxkYxmd9JXsZx7eqZon9e2va3iU2jK5feXSiD1
         frFMhT3UB31tXaVFW97l7KTrazCbKnOT6jTGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714940228; x=1715545028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89jyKA3wApx9BQCfs5IiJWmwTiyjcjG5A1RQj5E06Fo=;
        b=rpGGm7I3dn03Okgh79ARpamjYfA1M5HfrxdiT7BwCZNofi8nWd+K2LUDqPiin3cmXE
         do/UjuU6FuQXX9Fek70ZXPHvnxwTvtGmAPWWgrokSVOsmLAT9Mt5kRopMtcSI4yWyuqM
         beX/slhD7aWxl3ThtW0iuLcLqyks101GAyJjnx8cJyVArS0iW8IIuX4X9YaLJdnipj7v
         7UTRdmMcbSl7g2a9jAvPYDawEU7Qb7ATGm41KMzxIeYI5KNOcQ6TfE/39gWtpwY/yVMC
         vJgweaGjX5h2jzGuJFQKXAtDbh+XxdFtnIylecqFYHJTq9j1q0Mw4nZlQLT2rtvkXHWF
         IK8A==
X-Forwarded-Encrypted: i=1; AJvYcCXOm9wsIZw+uDFPGpf34ol0cTWZZYKgVanj4J3PHYtIEKhpJb10mArV1+UhINZ+rUqEAgvBKnUPam0pJthly5hgncUFpYubNOfnuPjoHw==
X-Gm-Message-State: AOJu0Yw0GPAHTN1vN/lndBbfG+0Q4UzD/pFreVOQTMHcZEjv2YBC1pPX
	ex/U19G7ZYs6gKkfii2RvDPnYXI0UGcd1c3VZvRE6fFcT0z9xlwlh6M5haHkfpH+cngrkCigq7S
	ZPvl9uw==
X-Google-Smtp-Source: AGHT+IEPA2YsV5bSPW/3QuCr0N6WPa+1hcBK4IAGvyfAh09iIXJEwWZU2kO9LazeQht/cBf77vcDIQ==
X-Received: by 2002:a05:6512:3108:b0:51d:4260:4bf8 with SMTP id n8-20020a056512310800b0051d42604bf8mr5556959lfb.35.1714940228608;
        Sun, 05 May 2024 13:17:08 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ov10-20020a170906fc0a00b00a599ec95792sm2724150ejb.162.2024.05.05.13.17.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 13:17:08 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a387fbc9so274224866b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 13:17:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsHKxNPMadSKO2k/vY8FDfZ8UPT3tB/BVF4LeVa21Wbu/2+l+eKyYbzuEHkOtqDJyOEFZfoaGrLd9Qe1jLIGoZHy4mcw4/D7Qmq+l2PQ==
X-Received: by 2002:a17:906:7188:b0:a59:cd18:92f5 with SMTP id
 h8-20020a170906718800b00a59cd1892f5mr599989ejk.11.1714940227970; Sun, 05 May
 2024 13:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgMzzfPwKc=8yBdXwSkxoZMZroTCiLZTYESYD3BC_7rhQ@mail.gmail.com>
 <20240505175556.1213266-2-torvalds@linux-foundation.org> <12120faf79614fc1b9df272394a71550@AcuMS.aculab.com>
In-Reply-To: <12120faf79614fc1b9df272394a71550@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 13:16:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxLdB_P=nW1bmVKn1m2jdcZRgkMksfvA722toFpT554w@mail.gmail.com>
Message-ID: <CAHk-=whxLdB_P=nW1bmVKn1m2jdcZRgkMksfvA722toFpT554w@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: be better about file lifetimes
To: David Laight <David.Laight@aculab.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
	"keescook@chromium.org" <keescook@chromium.org>, "laura@labbott.name" <laura@labbott.name>, 
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"minhquangbui99@gmail.com" <minhquangbui99@gmail.com>, 
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, 
	"syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com" <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>, 
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 May 2024 at 13:02, David Laight <David.Laight@aculab.com> wrote:
>
> How much is the extra pair of atomics going to hurt performance?
> IIRC a lot of work was done to (try to) make epoll lockless.

If this makes people walk away from epoll, that would be absolutely
*lovely*. Maybe they'd start using io_uring instead, which has had its
problems, but is a lot more capable in the end.

Yes, doing things right is likely more expensive than doing things
wrong. Bugs are cheap. That doesn't make buggy code better.

Epoll really isn't important enough to screw over the VFS subsystem over.

I did point out elsewhere how this could be fixed by epoll() removing
the ep items at a different point:

  https://lore.kernel.org/all/CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com/

so if somebody actually wants to fix up epoll properly, that would
probably be great.

In fact, that model would allow epoll() to just keep a proper refcount
as an fd is added to the poll events, and would probably fix a lot of
nastiness. Right now those ep items stay around for basically random
amounts of time.

But maybe there are other ways to fix it. I don't think we have an
actual eventpoll maintainer any more, but what I'm *not* willing to
happen is eventpoll messing up other parts of the kernel. It was
always a ugly performance hack, and was only acceptable as such. "ugly
hack" is ok. "buggy ugly hack" is not.

              Linus

