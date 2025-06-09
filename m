Return-Path: <linux-fsdevel+bounces-51020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB6AD1DF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801177A2C65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706F253956;
	Mon,  9 Jun 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWHP0QWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F77FD;
	Mon,  9 Jun 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472750; cv=none; b=B29yHXlZED+ZfLsGiNJgT1x/1wGNuY2BXDgbRl7B09WH72tc/KlwNfH7ZOWsw1gVgD04u6fN0jx91CSTSgUilVFyu5p6eCNNTQrvyhCS985kkSaDGJFx4DWAeyq1D498J7tflb/dQrxiNh/K9uy+ZBTgwVMaRmpje6ip34qBF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472750; c=relaxed/simple;
	bh=fqrOw0E/bCqrWaCiG1SA0VX//BhvXNIedkaN/GLwOWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwFTyvYviKHpL5MhYXARmvLheW+yb9upXYo6olO9PbYKQkhX6sxHftxJL3O1p3KotbX0mi7tx/zxHTwIF+yHaJDswABUor8iSnftHgTpwe7Ql+u+8Y0uoxBdVA3SHcUdwO4hYVh7B1ibcSgQKCCX3J+fgVmSnrYZxJGQDvCm82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWHP0QWy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad51ba0af48so994634866b.0;
        Mon, 09 Jun 2025 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749472747; x=1750077547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqrOw0E/bCqrWaCiG1SA0VX//BhvXNIedkaN/GLwOWA=;
        b=IWHP0QWyT1gwPmCksg2r5CZ9fcijsI4I6u+7mfyxYiIsXNSdUkHujwYKD5WphNrtWX
         IWAiZ0H0EZipsmgk3Q79zzPapAYueOh2y3IqW3Ud0N5pE+8r1wbwTg/adTGxI5YihEle
         FI4i1OEDvVyRBeq4ryz7GbHIgKGeLKDBzkhBelUjaA8i7Aw18oXtkRRmoTjtitkMFIFd
         pddDEy4P+k4PFwTYjwx40LodLgUAVtROW9gr8wuwzsxmRo6d+B8UlgNzVx7dLmX5U8n8
         7yiisLDK6CxDHjlqpIeRUXAG7jl7VA8YUaw6IeRiPUWHYNrKKpPesj1IzTRovatIPGki
         ijDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749472747; x=1750077547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqrOw0E/bCqrWaCiG1SA0VX//BhvXNIedkaN/GLwOWA=;
        b=CxkNjKE28hx3AGR6wFETfIyP8LPpFUGyEGNA8lUUiAJoAxz+N0KJl8GAQbTREeBpsj
         WiVoTpr4K0TkPA+cERQ0mRBdndK5MRJTqN/3M6bt5DQ6FVclKnz7arWwTL8X9t4penk6
         Jk/iMrPHKNOkhT/xfZriN9LLA379UbcclxyzioI5MhIpCqqi3A32Gx1C0/2+xO2Qh2v9
         O3SmUEzOgUdk+OPFWedoi4gvLgs0ZDkTyQpGOIdm8xGIoP6pdf12L62jU/xhI1e7Jk1s
         E55oYC0Jj7M2wS1P1ZJkCyZFAps54RfoFvMUgHizpnEWHlGCKMfkll+mckXKKUp/weR+
         IGCg==
X-Forwarded-Encrypted: i=1; AJvYcCUOGVf8XHHLj4VKOh58kBln5rqm4CvFIavnQkAfwEBLhXhV4HMympVUnkANXr5d1ENrzn0Wpfel5VC/rZlj@vger.kernel.org, AJvYcCV1tWcYlEZlHTFBYowa70BbUv3Z+1P7KYZWpKFg14vi0Hbh0wLLL4dcgnfnaEwtROLtpz6v7x5RmzCY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fs9/4hMXRjSg4Mgw43DfuYqEPLXTexQRxqavP9zYDw5XRTjh
	WB2jpeCKcRzmrNsx66uS6gEp/7M51Swscv+bab1/1q15o+oyrZLnzCNJuIzk8GJHV3ZxzkqTN4T
	wrCDtNTOiauMKb1sYbvY5r+u8KpeHqA==
X-Gm-Gg: ASbGnctuTjL3vsQKN6YyCHA9KTn6eO4Qr8WR38s96sV5gMp8rgi1WRHILek6ORcaumL
	RqI/el4CvFQOWpdGk/93B3BHxGGACdWA2znSPGFJyEDIPxAqbOn/OQv6pkAHiBLbsH1Eqos1eaL
	s4ZELdprHIU46Hax1FQ9ZwQRD/MMcC0WDnLxN4fbkziRnso2Zggob+b5IXORbxsh0kwv5iPKHXk
	g==
X-Google-Smtp-Source: AGHT+IEJYvarobZcAdaW5IT1NR/x/GLAH4MEaEffy7c3klgYm/UeXzQeiX2kIQHx/00F90lNkIKJr5m7q2tXUGjcy68=
X-Received: by 2002:a17:907:7eaa:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-ade1aaac5b0mr1043640166b.27.1749472747311; Mon, 09 Jun 2025
 05:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com> <aEZly7K9Uok5KBtq@infradead.org>
In-Reply-To: <aEZly7K9Uok5KBtq@infradead.org>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 9 Jun 2025 18:08:30 +0530
X-Gm-Features: AX0GCFsaD1avfJtWh4Yp8VkfRfuEKOzoktyawjS59zkwCY7IT6s7SVqtZsBThWY
Message-ID: <CACzX3AsfbJjNUaXEX6-497x+uzHptrxM=wTUnDwy_tH6jAEMTQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, djwong@kernel.org, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 10:10=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Can you also point to a branch or at least tell the baseline?
> The patches won't apply against Linus' 6.16-rc tree.
>
Yes I had a hard time too, figuring that out. FWIW, it applies fine on
top of this branch [1]. It would be a great, if base commit can shared
in the next iterations.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?=
h=3Dfor-next

