Return-Path: <linux-fsdevel+bounces-32465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFEC9A648A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7361F216DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FA81E47AC;
	Mon, 21 Oct 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AM0IwWyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA61F1304
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507342; cv=none; b=fKv7BzCefOUf3YRrKGV0MWf6Z+khWqIPI+z7EzhosK7BgWR2O3Whbr+GtiIsIk4j8r6AggIHybOQUv7yHddwONDTdsnAB52qMXVha989bZ1QCm6HqRBjSLzZ+yu1DoaOcm65YnnRpCwGYo0GFgGnq7GQ3ag8hOnJuEgJXYqG0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507342; c=relaxed/simple;
	bh=lGlERMYtz5SnLQLwOGVAIXCz87xRgIubq9/dH5MFKxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFO3eulItkFg/HmEX53nT32gMW1cPiyJOll6h8b3+QMjHNwsENKsOw44EKsGftIQKBFaLzH8E3ujcg6WkHG2TdYlG4xn5FSRs8T62uI6OtD8FnFKHVUzdWaG0iRQwuFkcL63StwIdfc+AvE42xFxBFD9t1OBoa80TAcABdpj3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AM0IwWyk; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a47d1a62bdso1009447137.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729507338; x=1730112138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CROML7dAJaONpnsbzUaZW2t8Il+NSf2ScEsMHxaPnXE=;
        b=AM0IwWyk5Bi7vP/FjK+dBxt8SOPiE89M5zrMMuwzTnxgjNLiW3qfx20BvKPOGIFJM4
         fmcxeB7W2xkyXLyHUyrPmxdf/6RBQTly2vyYuBuh2M290XkxlDG5/bbtjbeeI+pgRBPr
         /i2/qXDeDq7+2FKZlnyLB8lraasiOwXoxsoy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507338; x=1730112138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CROML7dAJaONpnsbzUaZW2t8Il+NSf2ScEsMHxaPnXE=;
        b=vSYn6tQvzCCHusHCU5LO44ITK6c80kM7/I06LQGBAngnpU/8DWaETdvBV6+0NT/Pg9
         Q8LXR0Jd9OCguvpp7HsQbPjSVbfZYd5UmaA5jQHIQQIx14VsO2hDEQQswLzLTlbsFXmY
         lFnWkFEsAlevO6Wvp/FMhjG0p1ZxnqG6EAIXuE6i2Ru/BPfxybIWLG8IWgqumuYER6PV
         GMTv89H9+POGogtq/dDjy4x+Yh6MiZWb1++31GqrpF7jIHXx8tGScECKIg3rLQh3qzzV
         lCWJXQTX6gPYAI4itK/knurhEw7dI/E2fzdnHPv4Js89+KnqA7Nka4BRnw5Q/9UZFyTe
         2LMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfcs3RXzODPQKjyjKSn+sIi0ro5ehXc6uXudJ/6+AM7hefHog4VzWeFYpeF/cqLEJzr/4A+ds0cOmrwDU3@vger.kernel.org
X-Gm-Message-State: AOJu0YzNC0OyAoqWFplSzwrFqkJ+R9l+vxZh1sPQ3cKFXxwIBeDDyJdu
	sL5jyC4hUuF3VT36CNR6pDG/Qen6M2tthMdEGBHQQartPMUN6VxbUyZ7UiYy952KgX5i5BquZR1
	icmfrXvjXyCb0ZG37MlcHnXIm3qxdulsFcMjyDg==
X-Google-Smtp-Source: AGHT+IF1Ku/Or8mDvMjmkzrfK8UuA03VpibHFZYdfjhYwkRLLhL+F0cs6ozQJUKX5mt29gqDjdXeNaCFn3JIdUBJ4NM=
X-Received: by 2002:a05:6102:3a0d:b0:4a4:950a:cb1f with SMTP id
 ada2fe7eead31-4a5d6bb2175mr8957269137.22.1729507338663; Mon, 21 Oct 2024
 03:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com> <CAJnrk1ZrPcDsD_mmNjTHj51NkuVR83g5cgZOJTHez6CB6T31Ww@mail.gmail.com>
 <CAJnrk1ZSZVrMY=EeuLQ0EGonL-9n72aOCEvvbs4=dhQ=xWqZYw@mail.gmail.com>
 <CAJfpegu=U7sdWvw63ULkr=5T05cqVd3H9ytPOPrkLtwUwsy5Kw@mail.gmail.com> <CAJnrk1aQwfvb51wQ5rUSf9N8j1hArTFeSkHqC_3T-mU6_BCD=A@mail.gmail.com>
In-Reply-To: <CAJnrk1aQwfvb51wQ5rUSf9N8j1hArTFeSkHqC_3T-mU6_BCD=A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 21 Oct 2024 12:42:07 +0200
Message-ID: <CAJfpegsKbt=r+aY57cuSwyBe090aJQ6gh2eZ=o_Bo1PxrHyXwQ@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_writepages
To: Joanne Koong <joannelkoong@gmail.com>
Cc: syzbot <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 20:13, Joanne Koong <joannelkoong@gmail.com> wrote:

> I guess we don't run into this warning in the original code because if
> there are no dirty pages, write_cache_pages() calls into
> folio_prepare_writeback() which skips the folio if it's not dirty.

Added the revert to fuse.git#for-next.  Hopefully the syzbot reports
will go away.

Thanks,
Miklos

