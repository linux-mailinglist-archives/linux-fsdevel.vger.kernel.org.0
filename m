Return-Path: <linux-fsdevel+bounces-24705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6E9435B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 20:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B8C2853D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 18:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE614779F;
	Wed, 31 Jul 2024 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0D1x7vG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474F22F19
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451084; cv=none; b=FWlp56/qMBRzhoQsDff3tgyxzh8g+uP8vBy652j/KfzMuxJOfXout7E3YbrNESxUwVslPQVwQ+vJoqOKD4Lvq8iPag0kFjWxAq7F2a+e51tctXKqtZVNPqGqdKuuI1S9/w5kePkAUZqzGK7EX92TPAd6eSrJCej9GtSQcAhE7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451084; c=relaxed/simple;
	bh=TtPsYONdEUqRQE2crXvr+wPuv9Ohzr8NHz8RwrTGlC4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BLxgKR6MyTTKispUKSPKVAazaTRsxQ+YbFsA8M+BxTulrwx6RC2kZfZMWsMYKS/micJbPmmNSbEkGSaxe1w3eWu4mPaD5mBDYVCRdKEtq6WliVs61ncYleLCcsZnVD0iTczeAraAqOaykTcP+L6z5PppNqVbSiYd5ja5sMedEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0D1x7vG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so8433985a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722451080; x=1723055880; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TtPsYONdEUqRQE2crXvr+wPuv9Ohzr8NHz8RwrTGlC4=;
        b=O0D1x7vGWxmwysiqVq1upf+rJtAu7jHgl62vvsRQ67G6wAyOEwlpHZZGKlgfFxP3Lx
         wyKqTMmqfs547vs+9BrkHaIiD0mH9hR3vYDby7siAIorIO+D97DHP4x99k9LWGstI9Oy
         5HFem6RDXUa0+NAd1wRcIhcVNVIot/U3cH6EjTVVRMoeA8x85uN62OCHZhnvuCSY9C1f
         p4WVC0efP+2YSmMquuaDRUQ7R5cPOSh5syz/fBL/2DtRm4bqZ5FW4q8qPWQRtj9/EycF
         QyK2Gn4djxSKXwWA353Tt/3dgQUI9louBF5e/dbIwoxA6T9pw71YrcDoH26Jcl+J+OBt
         COWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722451080; x=1723055880;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtPsYONdEUqRQE2crXvr+wPuv9Ohzr8NHz8RwrTGlC4=;
        b=I7OGuugJBJhg02LDj4Pger/H5OeWWJ/YgUH/xAK3LaVag3GFrNhFTuD8/l4cnYBkw+
         c6EmsAVj63s4PlNZFBG1wnUSBx5ZF+7aUULkdV3ZzQmV46Jsu5xJIuhIud5On1TXhove
         l0JYnlEWAxw3dcJO+2ZG6/BwAJnPBPr5R20aZUz71QaFLH6fprE8ucwnYc05nYRZ5SLp
         V8Hmt55GecM0yi8uGlLfhi2lSvSicFOOX+2sKueH5ZESaPoqPuULaOwRqF+9D8aGcUJT
         NZqUbLEplyN4Vp7pm1aqYlx9yclGmkYTQhMqhJygfZt/Elfb+2gh4J1KbBW9PEBuA7e+
         ShZA==
X-Gm-Message-State: AOJu0Yxx0UOvbCHiH0oBQ2e1GK3rVEoa7MgoUSADfqJZgJcJ7NBVtVJw
	JigmNXQ854exymU4tYjA3hVfBJqsxWyYJksUyHBLERLCW4Uf6PUYLY3tZNca3lo88YGNkcstEuA
	Y/MVDkPsotPopSdYEmfQ7KjvCKmGq4QWXQCk6Fn0BtRB9pD6XXUZR
X-Google-Smtp-Source: AGHT+IGPjl0OQFLHiotngzZY/n4bR8VIl1TUPc5DWavPrwuM09HLmJTJyQnWNZWUVvkYWp11FPCnLgQsm9vhLTOgMeA=
X-Received: by 2002:a17:907:d18:b0:a77:e2e3:354d with SMTP id
 a640c23a62f3a-a7d3ffa3102mr910458066b.23.1722451079740; Wed, 31 Jul 2024
 11:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Frank Dinoff <fdinoff@google.com>
Date: Wed, 31 Jul 2024 14:37:41 -0400
Message-ID: <CAAmZXru_m0B4EEbjNec8s6hNufdAA_+Vpm8DFvC_=EUS270pLw@mail.gmail.com>
Subject: fuse: slow cp performance with writeback cache enabled
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a fuse filesystem with writeback cache enabled. We noticed a slow down
when copying files to the fuse filesystem using cp. The slowdown seems to
consistently trigger for the first copy but not later ones.

Using passthrough_ll from https://github.com/libfuse/libfuse I was able to
reproduce the issue.

# start the fuse filesystem
$ git clone https://github.com/libfuse/libfuse
$ git checkout fuse-3.16.2
$ meson build && cd build && ninja
$ mkdir /tmp/passthrough
$ ./example/passthrough_ll -o writeback -o debug -f /tmp/passthrough

In another terminal
$ dd if=/dev/urandom of=/tmp/foo bs=1M count=4
# run this multiple times
$ time cp /tmp/foo /tmp/passthrough/tmp/foo2

On my machine the first cp call takes between 0.4s and 1s. Repeated cp calls
take 0.05s. If you wait long enough between attempts cp becomes slow again

The debug logs for the slow runs say that the write size is 32k (or smaller).
The fast runs have write sizes of 1M. strace says cp is doing writes in 128k
blocks.

I think I'm running a kernel based on 6.6.15.

Is this a known issue? Is there any fix for this?

