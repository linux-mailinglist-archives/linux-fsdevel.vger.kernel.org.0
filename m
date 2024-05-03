Return-Path: <linux-fsdevel+bounces-18688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5C8BB66C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E83828103D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71CC5821A;
	Fri,  3 May 2024 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AapHLxT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64D1EB21
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773180; cv=none; b=SCrIyurApTuzcwnNvk0HqBcW6YQA7w+mHrbS9I0fY8DK8ovd99ttXWcznxYcgA7izVdoB+dbDQlTZYSSdI9rMJGErkXls1sAVcNFYfZMXFWiRlawz/JwAFUme+7eD9110oQogJeJoWcuL96m5836NWq9/XIz8LRSjEy7zh4Pfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773180; c=relaxed/simple;
	bh=d5soG/vdOcHc+T4G2kOCRoZhsfh2zUDag1A1J17X/z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXuOvRknK92CITANTpzOrnVv8G3bExsfTuetZa1pqJ1dDPdzpamAbls737UX5OCHYX0DJGrxj+x8hFjkc7ini4PGu2i8n+UpcDnxhK29bkmbHks3LW+AqC4aLgDBZi4SPnKu80JktjkednDIxSEWvjBl+q0wQ1FknixiRTU/oLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AapHLxT3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a599af16934so17667066b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714773177; x=1715377977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7KwjGqB6cN3Dl955k2+YGPiXLoEdjHxOLmUV0m+ZBo=;
        b=AapHLxT3lnwb1tMaqco4jv36km1X5yWmWSbmyyTrvrT4S7kHW4LeCW/defI5AANPim
         T5q84VjL0rM3may+SChxZAhpiaBOJzc20UpIKNdJa7cePCJsLwr2ARuTGkWWEUZv80en
         IukOFOILN/4oE+W8/JwfsIl5RmSDqFd0teRjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714773177; x=1715377977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7KwjGqB6cN3Dl955k2+YGPiXLoEdjHxOLmUV0m+ZBo=;
        b=et/zqdUkxWuWUZtxOb2piPjSg0hAqNh6DYGCwaOW/VS7a8zcwC1FADVu/9Bi+wcJcO
         9h5eqc+9+mCvLIOw+EsfGz7JmKoKoYwdM1ASN6N9FFuTJtsIQPv5o/yhe4LheeHgTleh
         9GjqadFrTKIND1Rnx19NP5Ho2f3OdWSLjFxJquOaQ7HJxaFF40ZGPjrW0gkHcjzCAwB2
         VjYWsMnyNWVya3A8y+YxG0HfwAQC8R6ygHHQaJVof9rK72T9/wV+yhuIpCZJjIosf6+i
         2+8Cxy2yxksU398S14MyXeceaC1PwF6SW4iH8JpDQh+vvbTcAzCcTzUsoiPGMPSS7BDO
         /4lg==
X-Forwarded-Encrypted: i=1; AJvYcCWvxCgZA7bgQq4KmobT4G/SCGXTQG61+P2S++8gZu8LqqEnUSgDse9qiQGsbAkUMsvKaeerQL63guVL76SqO/FGY/2AEDOqWv76PSYxrA==
X-Gm-Message-State: AOJu0YyG+3rDEOYSCXD2ipImCh9Da9WWrubrafM8QMB99seeulWaTCAv
	1IzmmF42nsU+QT1ZETCNte+R054QN7HRz4IvrkZRGTXf/dsXy8/jEMvCVgxIVg8gdANYlEoETmd
	NeundFQ==
X-Google-Smtp-Source: AGHT+IFXZpm1rWTvEQHDphWOJgNxhnLSWLi5vKMtK96HLMMriEaWDIX9TSgFccCTmYpn7C2cO+l79g==
X-Received: by 2002:a50:a452:0:b0:56b:cfef:b2de with SMTP id v18-20020a50a452000000b0056bcfefb2demr2284296edb.26.1714773176804;
        Fri, 03 May 2024 14:52:56 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7da5a000000b005722cb1dd6fsm2121701eds.27.2024.05.03.14.52.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:52:55 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a5f81af4so18524066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:52:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaYH3mBqHU5fdGDF6oBpqAYE8r8PSZNsEey0BAEcEmgh0vusvzGP5pGQDulCgoAE9d6WonO0xfdSKtOtMHRiR2IOVLZiM11Z3fewIaCw==
X-Received: by 2002:a17:906:eca8:b0:a58:c639:9518 with SMTP id
 qh8-20020a170906eca800b00a58c6399518mr2622517ejb.76.1714773175036; Fri, 03
 May 2024 14:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240503214531.GB2118490@ZenIV>
In-Reply-To: <20240503214531.GB2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 14:52:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
Message-ID: <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: keescook@chromium.org, axboe@kernel.dk, brauner@kernel.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 14:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> How do you get through eventpoll_release_file() while someone
> has entered ep_item_poll()?

Doesn't matter.

Look, it's enough that the file count has gone down to zero. You may
not even have gotten to eventpoll_release_file() yet - the important
part is that you're on your *way* to it.

That means that the file will be released - and it means that you have
violated all the refcounting rules for poll().

So I think you're barking up the wrong tree.

                  Linus

