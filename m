Return-Path: <linux-fsdevel+bounces-24622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503DC941917
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4B51F22664
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA0018455B;
	Tue, 30 Jul 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HT0hz34A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F7D1A6195
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356931; cv=none; b=gbTozEQ8zmorfoEM0PqE3Q6n/LWiCpnxeSQd3kar9m3jhy9Hn31Lu15TlDqdBCkQfZqtKBe6KYQ5XJRvQifhMWNkjqTGwIRt8IDwmWQMJCt6Ho/hYj0HuTQmZT4A+jIxBXS0jo9Nwtm174zE2RQz5SD6RlF1LtBcWZ9CVKgEhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356931; c=relaxed/simple;
	bh=/WrqX39V/EGZlU7gkM+jA9j7Jyn0OjEJ1Mehdy12oxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUw9lEXt3DjadspNYD9GtdHaBaQlasr+FpTjyZk/zvwBPirsExteCaaNclGyptIbrr0Juw8DQZOH0sww/K1HnoLioj6bKhGB3ATSG1sKMtXRYyeeJs0Fzu29UQ34nA3TUg+SH7F+cVA+ammA44pkxZeDMERStEuwKo/W+artd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HT0hz34A; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso447945666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722356928; x=1722961728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfuNs9RJBxSHtgXaAG8xtdh6dR8/ZJRWqaxb2ZGOGQw=;
        b=HT0hz34AV6AQOhCDOqRoWZOg8kSqMBzmx3P6JlVSEUBoBqcFqHofONDiRu4Te+WWVq
         p6Y9EKYcyc457hg/5hRi9b9iZ6xBfdo5bQRyEEIpwQ4XnSNZAaCzf7TltKeESxQMHeLe
         mtVXoJQ+ti3kIitz3bRxYaMul+afdcJDVDujtjjkvBj08on3jxBFcipcMnjJ7H14hGg8
         Y8le95YOsIFhqGJ4oaFJPfQpa8G+12t+p1KcxSwncNJeNzUv0YowLBg+rbE/srCOuhup
         3wRKfhcWAskV8UVaHV+vaminX6hgYEY2F08gIfQIvJs4F2V8k/q6TGL7qR66XHH0RAQv
         wwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356928; x=1722961728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfuNs9RJBxSHtgXaAG8xtdh6dR8/ZJRWqaxb2ZGOGQw=;
        b=HiS2hLmL+BxGCdvBLjMc3uNOlpifOPVqt7XImcyAk0sbyFVx7y20VjtG1utCPVLoI6
         Y5UKC9vShBGiKuZBO9MPyK8yschWjNmWvSf1STAX7exijXHc7qW4kUsoQCysUUGovDXR
         VCS4dbr6d6N8GGJkDsWZoMMRzCnhe82rGYifqOVwPpo+UPNlCBmEeasX2htGS+ZJnUam
         hTCOdu7uxSvXaUwZrOivXzPZqVUuWBCNGhOL/Tt6sQSOlz8331VayvAnxw8RxLtEMZJM
         XwbRmZdKt7UijbtKVz44ibwYt/6iL+iSZk9efCmVIyRllcQ/Yl/2NlPiYE/wOnwtmULV
         EaKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHLzS1YhcZ0VGslA06p5J9ASIcT/Kr39E6uQdYa4xgt7AZsbgGPnL2grITXaRpRwe5vFfGy5tR/1fLc5zZt5pUHon/My77KKwEE4az5A==
X-Gm-Message-State: AOJu0YwYj0uKICHekP1DaSVeetApXCR4/lx1BrWm5qL4tn6/YYePsN2e
	Mso0MJhN2S4tShDvUaxf0ugxT6/BLRpJPzZ8GFGaLZrr6QZYIjyH3nCJXnVd2IwxiFtqanIoE77
	EdYbzfcYG52/SNIlEO/oql0zBNv4MAxPp7zZuaA==
X-Google-Smtp-Source: AGHT+IG1VcMHenRJE4OMv8Wdwm4JETBLEpAvJgISa1/m5vlwH5K/nlA4PdfCRxYRpOU0UfdTVOnSQCZN39wxbmaGSUY=
X-Received: by 2002:a17:907:96a0:b0:a72:7da4:267c with SMTP id
 a640c23a62f3a-a7d3ffa612bmr940477966b.12.1722356927933; Tue, 30 Jul 2024
 09:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <3575457.1722355300@warthog.procyon.org.uk>
In-Reply-To: <3575457.1722355300@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 30 Jul 2024 18:28:36 +0200
Message-ID: <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of
 PG_private_2 as a second writeback flag"
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, willy@infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:01=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Can you try this patch instead of either of yours?

I booted it on one of the servers, and no problem so far. All tests
complete successfully, even the one with copy_file_range that crashed
with my patch. I'll let you know when problems occur later, but until
then, I agree with merging your revert instead of my patches.

If I understand this correctly, my other problem (the
folio_attach_private conflict between netfs and ceph) I posted in
https://lore.kernel.org/ceph-devel/CAKPOu+8q_1rCnQndOj3KAitNY2scPQFuSS-AxeG=
ru02nP9ZO0w@mail.gmail.com/
was caused by my (bad) patch after all, wasn't it?

> For the moment, ceph has to continue using PG_private_2.  It doesn't use
> netfs_writepages().  I have mostly complete patches to fix that, but they=
 got
> popped onto the back burner for a bit.

When you're done with those patches, Cc me on those if you want me to
help test them.

Max

