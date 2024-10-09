Return-Path: <linux-fsdevel+bounces-31422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7F99622A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 10:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C111C23151
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2524187FEB;
	Wed,  9 Oct 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="djXWzcVQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556916EB4C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461694; cv=none; b=ee0rW5yC/BQGQNnvGhzJ7rnAC6kXqWQxPjt5EdOrVT4+19PhjNkcv7s+RScZ8kU6OJAS2bdyToXqDKyqKQqXqSeg33wPY6E9t7OgjKerlUXZHysBF3dfH8i5hMYC0GkMiLlU9kvYxeqyyL8s7w5R1h8vEzlHKXU/kzTM94fBfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461694; c=relaxed/simple;
	bh=cD3TTKd9WaaR1Ey0TyzkV24tD6ccCmjwO0FhANozRH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2m1Tc5Lp1hzRUWklo4ywoT0TDrPMcR6E0b2JcTI3R1JYHbJspzRJGOAVLYB4nlKRPcZiu4e0bbRElTVqtQeFZO1XTb0ZsiWxq1S7uR13K2EhkOIA2BtAuFiuxuTFFAel3kJ0r/jc67pqWIa4DkWzz+KPnL8sFAF9qVfJq3tknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=djXWzcVQ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso91346551fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728461689; x=1729066489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o96PaZ9jvLu3NHIwWcMi+936OIYdv+d8h/RY5oInW8w=;
        b=djXWzcVQVFhq4eIPSExN5/WWIElhxH3bMSYy+HCyFYkUpi7PRq5jXzD8ms7DQYtVLG
         GQpeaw0U4SDk1FSiwD8ozWK8JIUQlx1VKYQ447RbHuQSKltXm3MlNLQ1SSe7rgCnLbrl
         UmMsv62bEXw1MAD759akVCUfuvC9GBbrRN+us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728461689; x=1729066489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o96PaZ9jvLu3NHIwWcMi+936OIYdv+d8h/RY5oInW8w=;
        b=MbszIJ7ztqx0Uv29IYF3gc7p0a7KCy4hc/zrqrvRSJUQ2DKaIsl6TkXSJeBB8iefPD
         k9qrZV2ry9RVTgBU6HeyudrnFKtNDZp6pJrkPTcYGDEQvIY0OqrWNKBwcU//c5363sIF
         X5NheOd2WWk3PhC1f4ui8DkAksPgIP42xWUvXgJg1osxQgHYS7475NECjlj35uk1BRkS
         thbIeWDKNl6EB4Y54e/KBWr8oapEslvkKsXaWD3Zlb82w7zrOJ70Xz4JMlIrJBhrsHls
         VGpU/HmvlyoLx6qxxnPJog1Wf7+ANRybbTZzGlApUllsPiv/rMwQbwkHO7uabB16aKWS
         4o6w==
X-Gm-Message-State: AOJu0YwbSFfhM1wKDn5kMx3PYvA56sNtCB1QaooLZNdRzUwx50JP4E3y
	gyZQVHGsffP6AY7sg5jLRPgsKRdchm3wmiGtGF50blA7MLJo6Y+wgJqs2rGKeLeWsBI/IdEwYDn
	KZIghYH9PvAiM2HxcFq1YroTbeyR9XpnxdrJPhWQaU5AIaX0g
X-Google-Smtp-Source: AGHT+IGd12h8wb9N5oVrpjuC1qbMb0VK++d/Y7jW+6NZyrvofZuYTBSI83qnhFDF7IuTj7/gqyWZIUa+04HeOBvJvV8=
X-Received: by 2002:a2e:80a:0:b0:2fa:d604:e519 with SMTP id
 38308e7fff4ca-2fb1872ef48mr11161251fa.11.1728461689281; Wed, 09 Oct 2024
 01:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007184258.2837492-1-joannelkoong@gmail.com> <20241007184258.2837492-3-joannelkoong@gmail.com>
In-Reply-To: <20241007184258.2837492-3-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 9 Oct 2024 10:14:37 +0200
Message-ID: <CAJfpegs9A7iBbZpPMF-WuR48Ho_=z_ZWfjrLQG2ob0k6NbcaUg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] fuse: add optional kernel-enforced timeout for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 20:43, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.
>
> This commit adds an option for enforcing a timeout (in minutes) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.
>
> Please note that these timeouts are not 100% precise. The request may
> take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max timeout
> due to how it's internally implemented.

One thing I worry about is adding more roadblocks on the way to making
request queuing more scalable.

Currently there's fc->num_waiting that's touched on all requests and
bg_queue/bg_lock that are touched on background requests.  We should
be trying to fix these bottlenecks instead of adding more.

Can't we use the existing lists to scan requests?

It's more complex, obviously, but at least it doesn't introduce yet
another per-fc list to worry about.

Thanks,
Miklos

