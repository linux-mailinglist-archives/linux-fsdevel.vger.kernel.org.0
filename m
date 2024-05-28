Return-Path: <linux-fsdevel+bounces-20313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D218D1574
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EBF1C21BD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1F73501;
	Tue, 28 May 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="koTBL2vk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84D11713
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882315; cv=none; b=n2I9Enjfq4e6rZgqkKlyzb+FPDQ5nGqz3BYLuvr3CyJrrQV1gm97dQzqH/vmLNIkBNnoo5feEG1YJqu15Tljb7dUMhMAEeLJDEBdo3MBiQb6ul6ptXFOsrIOeQa8fuUs/+cUnwYu2KMLZ6bwi9eobFY8HrcwG+4NXbdsClkfHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882315; c=relaxed/simple;
	bh=s4AFXr6m9coBBvMRw4NwmMAzWfc+AaAO9stgcQr/ywo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF9B7W5ahSzyB0OCdVSQY33R04MbaB62k+ocebGHfwxU/8TACDhA9J/XivjUuRTx98V1i35j7AniSdZXWJxuvC7KB5y48LJRX/QSdo8fc6iJFEs83ejgd1/up7SLnrI4UXVLZNIJVXpJXGWnTEO7z5Vsvd+Z9s88nLkQg8nSwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=koTBL2vk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6265d48ec3so51303666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716882312; x=1717487112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJZQOx7zTUcF2zXADbetDAFVrZmcB1mlQ8M5pp4q2Fc=;
        b=koTBL2vkQ3nFS8BCdXkF5HDv+sL/PeuMbRafLXnSvVbw2bju3x/T5rBCzU4LVXqjRg
         qIcn4dpbGQrRVkuOVUKPXEQYPiFeXHI7e3KYKuSwJBp0RKmXDadpzjxMnDgXIFE1BzmK
         BBbxe+H/p4BU1o4wjh/BoPUiH4oV745Z2gk9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716882312; x=1717487112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJZQOx7zTUcF2zXADbetDAFVrZmcB1mlQ8M5pp4q2Fc=;
        b=CbAxXZKaXZoU9KYy+o740s+Oe0nQwYxFrNqUtT0TgmHwY9rlvnF8fwAawK70AkyQix
         BR0wySlnOLW6FTs5iufb5g+W5917/Z+KGOAX5W2lQyqp0NJSmeXYa0n1zPxn+RT2UaqA
         JmKp3KRlsyFrTP8iDEf8x+slx2zVzr2tIpRKGQHTtGS/Zym/Y67i5S8oqaC8cvm3TzKm
         t9SWhS/jsgo0LcZt2IrrP0YGQW7m/bfhMOMYIUT49y3+usUMYJXAkHvmk7LSCoO5RlsK
         mA6HifwfqvCuAiMo66rfa9nmobo1J/rlaX2EFfnsq7J9cnGVhjE3Sw3KWpUaOedSAJnp
         3bmQ==
X-Gm-Message-State: AOJu0Yw6DZzJmNLK7gg2lruBf5qvsSsA+/r85PPfNXqxMXuyikSAMA9q
	JWCDVKyGHRrfjsyzY8JH4GAn6Xo4qUqbTCWdeyqFkak9n7CwKlO48XbVKBQmYGj3DmLVCM3075L
	lDrRbBqHhSIwEia6K20dgk05WvhroZKjjl0og/w==
X-Google-Smtp-Source: AGHT+IFJPIYHUs6LwME8kXfa3gU6qPJ1bQAgQIPu17zC9f1lE6na7kF+nMquELBaMF+aMeltHP3/Ih+Q4eQl77eoKmU=
X-Received: by 2002:a17:906:d8da:b0:a59:d133:87db with SMTP id
 a640c23a62f3a-a62642e0799mr786093666b.42.1716882311557; Tue, 28 May 2024
 00:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com> <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
In-Reply-To: <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 09:45:00 +0200
Message-ID: <CAJfpegsyyFPUDmoi3T8vkS7+jpgfOqeUZBdKW8=Y7R8-b7ch2w@mail.gmail.com>
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	winters.zc@antgroup.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 04:45, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Yeah I indeed had considered this, but I'm afraid VFS guys would be
> concerned about why we do this on kernel side rather than in user space.
>
> I'm not sure what the VFS guys think about this and if the kernel side
> shall care about this.

Yes, that is indeed something that needs to be discussed.

I often find, that when discussing something like this a lot of good
ideas can come from different directions, so it can help move things
forward.

Try something really simple first, and post a patch.  Don't overthink
the first version.

Thanks,
Miklos

