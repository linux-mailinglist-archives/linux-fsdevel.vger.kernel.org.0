Return-Path: <linux-fsdevel+bounces-38259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFDE9FE26C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 05:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DD11881B8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 04:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF715DBBA;
	Mon, 30 Dec 2024 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kMhBeKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A252AE8D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735533729; cv=none; b=Jljx2GFiGih3z0JNNg+clQ2RX6aZC73pKZS5Rco3GWYeQFA0vQtbV1HIaIeGT2rSgNe15VzMdVgy6FUnULRedzAu1wfrLIbMqjl8Jwk6NEu4MjBFfh/znV6IJgE8XvjyXnO+ILYlY2QK2WknDuCUPI69pA5MTU6ZJjK/JMX0cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735533729; c=relaxed/simple;
	bh=BHhECL8MYTJU+Aq8si59T6lLd2xOEidlCLTLxP28xjY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oyr+SScQaIUwthO9RqeOkzOqJBcF/0FFPRHBnPplxqHorOqvH/sVJB8xwo8scnzGJ1x3ZZ+XBh/p8fZszQw3KVHpIu2nw6l9C8H4ltHe3Xo7Iif8UGW+qyfHOcVQvTwkWj+nx6Mtcw8WcKpx7j+TEdXjDOaUdmoj0bU12PDeWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kMhBeKu; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85bc7d126b2so3550467241.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 20:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735533727; x=1736138527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BHhECL8MYTJU+Aq8si59T6lLd2xOEidlCLTLxP28xjY=;
        b=3kMhBeKu7HTtpHCZdGPsqRq6WEnpxmSaUGe1FNaQQ51ihD1wxIkC2lX0UTcqMNqO4b
         9iCc9H8MwzUdAyBCOAT6pGJvSVNdvReZN8Lz1WjZHMmFAfOy/YuZ4/r1YmN5Lul5nRQB
         fbD+1Flm+DaLiBlSlp370cyL2COfA21GDtY3LEn12nQXBPhEFlUPeGRY7ZefwJBQDMcm
         jJQ3/Qan6/acIrsAOZff3F4GaGFsUvCglTM5piY0McLjVN6q9HWgxbeQ4yXHYa8jVVbt
         d7fljy6woYO7lLAUoCVEUiZRClugPWDBWcAjD8xBnvPiiyYGxOTtZ13IcbWxM9GdsiIm
         OEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735533727; x=1736138527;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHhECL8MYTJU+Aq8si59T6lLd2xOEidlCLTLxP28xjY=;
        b=MQMK617rKIecWGZx9g3bbe6MUwUHWrV2g2ZpiR1o6tgKE0NLGmkgda2cYKMhAioUxU
         VOEp6nxxfqvH8ZfLVz/ydxrB3g3iYt0+JFQFUZcPGlT6/rLUZUKu8R31hgr0pZnp/Fk5
         39X5huONM2t+dfz7xJGiMJF14/L/y/6TT72iWvMNSYzhbjsFxnomfU3RiKidZTBJbGIF
         +tml+AAJbuVUoUb464EoIL6/2e3knmJZL5q3BsPDGTs0JYDw8VDNfnVsJ1OlumwsGsca
         8zlLrS5iiIXgMZYBAKoft180ssFjvvzjWJxWrAUtnPU0ZVTSHL5vFTx938OVbwUALZJq
         Nkbw==
X-Gm-Message-State: AOJu0YwiH0bGamPcWSeLbzx5KHipycIQVVqqXZZuttvLLwzpafBTutUs
	hOgwmVVTMVI8p+p2OTOfZjyM3YTtH5YE0SVLxBDLlor/y+U5hHujlGKohvm7nmIjjFjonr7WK6H
	sQ7TrXIhmjk/5D13/Uq/LioMfe10M5GG1kCbNKm1Fet8Y3rMciyoVfH26TQ==
X-Gm-Gg: ASbGncufVCc2cMPvJq4qHkuF9mZNqk7tXBH+YLNzLPWUEQ3dHAVhpfnM3b5BIkJfdEf
	KAO+SddNRtH0q8C6Xu2FJnb6EXUPjKGD1k8CHE8IdDT4Zb1nFJgbWV1V2T60qRkfZfc5qrA==
X-Google-Smtp-Source: AGHT+IGeW1mSE/TkeL77eO0fGCz2Azs9kUfrSXcxJsKtiExeIEaJZFRTewlO0dmQk4muDkGpQ3D4bpXqhFpyhwECd0s=
X-Received: by 2002:a05:6102:548f:b0:4b2:ae3e:3ff with SMTP id
 ada2fe7eead31-4b2cc48a5eemr25473220137.27.1735533726586; Sun, 29 Dec 2024
 20:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Prince Kumar <princer@google.com>
Date: Mon, 30 Dec 2024 10:11:55 +0530
X-Gm-Features: AbW1kvYt0AadQPOw68wz6g_x94QWIwzQWpE0ZnbD0VLgPWctKZEsV5aPPa5uK2o
Message-ID: <CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com>
Subject: Fuse: directory cache eviction stopped working in the linux 6.9.X and onwards
To: linux-fsdevel@vger.kernel.org
Cc: Charith Chowdary <charithc@google.com>, Mayuresh Pise <mpise@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello Team,

I see a regression in the fuse-filesystem for the linux version 6.9.X
and onwards, where the FOPEN_KEEP_CACHE flag is not working as
intended. Just for background, I referred to this linux commit
(https://github.com/torvalds/linux/commit/6433b8998a21dc597002731c4ceb4144e856edc4)
to implement directory listing cache in jacobsa/fuse
(https://github.com/jacobsa/fuse/pull/162).

Ideally, the kernel directory cache should be evicted if the
user-daemon doesn't set FOPEN_KEEP_CACHE bit as part of the OpenDir
response, but it's not getting evicted in the linux version 6.9.X and
onwards.

Could you please help me in resolving this?

Thanks and regards,
Prince Kumar.

