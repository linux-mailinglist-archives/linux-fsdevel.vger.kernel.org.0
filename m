Return-Path: <linux-fsdevel+bounces-44317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F8BA67348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 12:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E0C7A92A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18F120B7EB;
	Tue, 18 Mar 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IvkjNfAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4311204080
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299117; cv=none; b=HTJC00YB0T6c5rCBnVTLmm+SURzknOP00MyJA88FyxWFPoF7/8KkEI0IWVn4mxwzDtQxouG9fbj4v5p/oBFqtlPI8P1rdST0XJ9Mihwt1lu+wqvkUNqvHfmHjs7QCaEscvo7BEDElb4sQ9u4Jdn/Sdi2CuNuyR1YRwXTy8Elebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299117; c=relaxed/simple;
	bh=1MGE3j/oMG9jTrRbeME6R9O2WWOVHmRuDbhmv342Ido=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9nrPv8oKIJeYBzZ4Kemciq/ZbUE4Wpl1GvCo5CXUXakFT+ZHlcaNr5nqNy1UKSXG8QlOSz8npFnZJdwdSiaIFVPCSuP8Ee/boYZTr24W1dwxbQv6CPo9OIP+iBMBfO2XQQju3cQSukDin9FigYafaEifDEleAlW35CtNOlTjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IvkjNfAY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47677b77725so53872471cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1742299109; x=1742903909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1MGE3j/oMG9jTrRbeME6R9O2WWOVHmRuDbhmv342Ido=;
        b=IvkjNfAYbgLvdYaK0K7BawJqO9m5hXeeMLEJ3CriImt8RP4nhl08hv7BWvBodVEECD
         qJ7bjKuuSpHZXpkNdC5inQL57NqdLvh7OObuThhdjXqzP3iG5LMEd9ZfpJl/LkSMgQp1
         W78C8y5JB60O7GlZKZr+YIqKsvVyXvEI7OeAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299109; x=1742903909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MGE3j/oMG9jTrRbeME6R9O2WWOVHmRuDbhmv342Ido=;
        b=M5YOTQ2TobRQVwiPdcTZ9f54hI0MrwbHw8KGzviIUswkMMvzrIdQhufgRS/GIO5T7y
         tnn918QO4NhJ+6SfAPCzYnF7x1ZAYkGAcndX/x+BImRyjRvaZf6fEHyM0AwhQDar5lZQ
         7HfCa96QwlCPaxTBLhfrb4NeTm9QpWbrt5ZWvOj1ln2DDJCFV5r0Nd0Y4wYmalP7Apcr
         6v/2P6lP5P76I/fFEgqwvBc2fOy/ILyrRXlLXvLxnYSnfZ6tEFY4ukM05+G1ady6yf6U
         3i6ynqzKoukWNuawrk2yzm/EQADvJxKR+dfnc2bMHI6suxp9rHP1GQecfcn3dGa0s99B
         Sfvw==
X-Gm-Message-State: AOJu0Yz78UyXdImTJH7fJEeMuyPjpZSpaMycvmiOCE+IY/1mihDZymH0
	UDd/MGPENuONPL0zMOO5aojbkzi3u8M35n2Ud08MJd/cc1B9wdDh/F/J/gRHX7U5PA8/FUg6TqX
	gIEGaBWi96ULyaAEk/KSIDTW2Q7cHQ43zfuJC3A==
X-Gm-Gg: ASbGncteVoRZ/Aq59nq0d/LpGuluc7VHQcrtV9QOaoqxBtICnAthCVx+o/Ej54ZkLeT
	JXTps44Kk+nhwsrlX0A6Ca2FH3WRXiCYjbnz5n1Mz2hnBBCLoyN3bBrsOi7VomysLtJ5tSOxgzz
	v1uckSAFk0EnMq/0/C3SCvX7jB
X-Google-Smtp-Source: AGHT+IFDrOnVColt2aANGvOPXEUbI5CiuK2d6NtU5+VASJaLol5OYoL0Kgq6obFtGAweIGST8pl8bwLZtNlGAu3Jh6k=
X-Received: by 2002:ac8:5708:0:b0:476:78a8:4356 with SMTP id
 d75a77b69052e-476c815c921mr229073051cf.26.1742299109451; Tue, 18 Mar 2025
 04:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318003028.3330599-1-joannelkoong@gmail.com>
In-Reply-To: <20250318003028.3330599-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Mar 2025 12:58:18 +0100
X-Gm-Features: AQ5f1JpwSHVP6mIZvTzmiAZY5ShTFeSULswhlcntJoMwwfacMvkuM-gl_n3HkGM
Message-ID: <CAJfpegvgaFAXZmOh6pNhbDMuT0XagEs61LMQL3pWNze8kqeGUQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: fix uring race condition for null dereference of fc
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com, Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 01:30, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> There is a race condition leading to a kernel crash from a null
> dereference when attemping to access fc->lock in
> fuse_uring_create_queue(). fc may be NULL in the case where another
> thread is creating the uring in fuse_uring_create() and has set
> fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> reads ring->fc. There is another race condition as well where in
> fuse_uring_register(), ring->nr_queues may still be 0 and not yet set
> to the new value when we compare qid against it.
>
> This fix sets fc->ring only after ring->fc and ring->nr_queues have been
> set, which guarantees now that ring->fc is a proper pointer when any
> queues are created and ring->nr_queues reflects the right number of
> queues if ring is not NULL. We must use smp_store_release() and
> smp_load_acquire() semantics to ensure the ordering will remain correct
> where fc->ring is assigned only after ring->fc and ring->nr_queues have
> been assigned.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please queue this fix up for 6.14-final?

Thanks,
Miklos

