Return-Path: <linux-fsdevel+bounces-28229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205F9684EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E061C22C72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E7184556;
	Mon,  2 Sep 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F6x3k4p1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2818452E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273486; cv=none; b=EfSRhuKer1UEMEMwfZW6NlluERo8GcSChZp3cknNK7qFDaR+Pgdn4Ai9kUZ3xGYwjNkqzLteojGJurqhoFSulAYC1P+VsnZ9a64yMqWoH959z/GUp7B/9JX5MqYw91uezoYyBLR/NAjeckKE7Ug8zY22P0inEyGgIokQUB7FQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273486; c=relaxed/simple;
	bh=nTg6Yk8Aso23PWEE0lJbIFpXJ/ymTU9reUYS8XbxRpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUxAKfyzGNe6zwRk6u2C9SSQVYfKrfqruJtxuYfRkiMw0SuuV3ujycfpILG9KFdj6XkH1YSleHDvc3ByOyho+qciywDyT5KX31+F0T+6vY/Nm0S74mxMFbUvoM6k91fWGb2TycgpI3Pc10HySKXJ99ppCAS25LHaHp+C7PQ+2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F6x3k4p1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a868b739cd9so482294966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2024 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725273481; x=1725878281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mRqj5E97LVLk6bKGRMGIUJzGP6e26pZm4U9abWJFs4=;
        b=F6x3k4p1VMc0hkORHQuNgXw7+CesamsxJV1Ydapn1h6S7C1IJ/AhHzJLMzOirR0Ayd
         nOuGk7to5xayoL13NqoMSkIyjfeC0saG0Vr6FBRvc2lPii+oV3Ufj1DI8wGy0aMXiqGj
         0FYoVh/cl5ZjU5rkrOcHZldzTMk4qt86aY3cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273481; x=1725878281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mRqj5E97LVLk6bKGRMGIUJzGP6e26pZm4U9abWJFs4=;
        b=j967a36JH2+8YZ6ZU7vbHyaVbmX7S0Poogru7XlT1ejj82tyqL8a7OkF8EbCuGp1z8
         KfmJ/4lciwjE0IIDMuIab7eAnsI+bzVvUQlN3oWCBwm7mgUkCTn80J4ZIyst7vPu4UXd
         0p1DZwfva7Bq61+RhyBabVVcDtAauV1ZJxWuAwYUnXBhV0yQS9IJK9ZOZaOPKcDif+R1
         pr0cvhD4zD2bBhmeKKMYUZ6D0TpP7WTESM9q40hNOYyWfT/5Q6Q40egjNH8JPUXbmJfV
         3PJSpWFC+FUKGllDnUwb3G03aLh1ze+MwYEZvwjreL0ok3VfZM6s4AhsxRvmcpXiBb6g
         dv4A==
X-Gm-Message-State: AOJu0YzUKDMOfLm4LSnyBkrpP2H1mb826iWFeobElicKe+6M4Nw2dUmz
	laLlAJZRc44wtktBaX2ecMKU0u+MRn+vhPbJ23APJ4LUYKcMi5b/NnyjsOqPpuTs160ZyqN6Tyj
	B6drKK5sxmJa8ia9AgPCLApygemIRo4EwFbMljDsWmsQjIxJLS9M=
X-Google-Smtp-Source: AGHT+IHn4AOvu0nqUJLjxj5oaqASti/RRT0RNuWr4hQw+CNJFnnmqSizKmVleIi9hCZOcTfvWI8Wag1N1JixIZCYzgA=
X-Received: by 2002:a17:907:7203:b0:a86:96f5:fa81 with SMTP id
 a640c23a62f3a-a897f920068mr1066918366b.32.1725273480978; Mon, 02 Sep 2024
 03:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com> <20240830162649.3849586-2-joannelkoong@gmail.com>
In-Reply-To: <20240830162649.3849586-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Sep 2024 12:37:49 +0200
Message-ID: <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is in a deadlock. Currently, there's
> no good way to detect if a server is stuck and needs to be killed
> manually.
>
> This commit adds an option for enforcing a timeout (in seconds) on
> requests where if the timeout elapses without a reply from the server,
> the connection will be automatically aborted.

Okay.

I'm not sure what the overhead (scheduling and memory) of timers, but
starting one for each request seems excessive.

Can we make the timeout per-connection instead of per request?

I.e. When the first request is sent, the timer is started. When a
reply is received but there are still outstanding requests, the timer
is reset.  When the last reply is received, the timer is stopped.

This should handle the frozen server case just as well.  It may not
perfectly handle the case when the server is still alive but for some
reason one or more requests get stuck, while others are still being
processed.   The latter case is unlikely to be an issue in practice,
IMO.

Thanks,
Miklos

