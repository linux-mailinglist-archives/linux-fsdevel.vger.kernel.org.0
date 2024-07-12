Return-Path: <linux-fsdevel+bounces-23599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA492F2EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 02:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE191C21E48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 00:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E3624;
	Fri, 12 Jul 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D101jmtd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16E376
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2024 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742970; cv=none; b=RlPSLhBOkEuHiH3qN0ZcstgffPBBqJWZ1w0sTbND9/dEN43yy3JJz20CVUJ0/0IA4xBXGVZD0Yx0Wt1owV2JW+gLu2NRMV2dxL1ESGoX3s1uUPPsIjQOmadiVrqHdp8zbc9M7JuocHDSbmp0kjVB3dRzcsK0wB4itkLQFW6Ge3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742970; c=relaxed/simple;
	bh=qa7OFawpDFI4fCaKSTOlkExBTRUj1Uv8uyAvZzeEb3I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FLuR7PxS47+3iY4EXydlwoiS4Anl11bEpzFnhMN0KN+xFYByyR/7M19moqyR6dGfnV0IxOi/WimlkQg46gHs5IXEyRVpteYW5GEe0xkP5v3hSgefIvRsH3Je5wnKkOs29GWDbtvRlZMaoLbUSl1dGE23REINx4OvrQDSYg7Umww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D101jmtd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso392460666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720742967; x=1721347767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xvNOwgjuFJaM0z79d4SbxcP/hPPR1Kz055xddSbnN0I=;
        b=D101jmtdLOun9PaJrpvlt0s76X+B3//cdIytR3sukEnuKZZ6pE+LspzocxGs1U5xeO
         3il8SeTx0goKSp3GXLf2HERI+O5ZzdlXD+n9A+6fVuDSyRBCICNW4xn5KcUQ832uH1Wf
         ns1loe+mrsZwOsuDNK5FpKox994q8fx729duyInTt9AziaT9DOangC5osehIA7CTOUAr
         sDUUY+b2Fd7fVNABZg6dmjCAYkUnpGqf5WFpx9F6+2I76eIVZimQ++ROMNL5SqhwNqir
         J7tHPrLqssHVXiWAVX05d+Dra18uddgcSbotsXbTI29z3IifhDpe3U8dSs+0yhhQczx7
         hhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720742967; x=1721347767;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvNOwgjuFJaM0z79d4SbxcP/hPPR1Kz055xddSbnN0I=;
        b=h4EkMPyr9EKbUaVeMfhZqIMoqvnzhBiDTsyeAeckX+2nzqmapvc9fvinqYNEFYVfq3
         +3hve+h1/b4+0pZmls86c/OuA4cNGc4Qyt4uMPqQshQf6qDDVLKvQzv8xqzDofE2AEDC
         cGij9Df9UTej0ukaF2WSpOfmpRD+/FZd5U7QhY5gpzd6ynlKR5m9PhfH7i2JULHbYIH7
         wPPBZsYlbRNyuSUQ3fFu5lHR2cyk1VVuKpPLC8n61N8qn/0Z49qyOW++1O+2rt9gqF6n
         dPSlmu0r8OOHeV4Y8I2RruYnHci7MiVfLVrIwcJQW8aLSejhbUeAmvCD/PhMMlPf7w7e
         YyIA==
X-Gm-Message-State: AOJu0YwOHeavxRT4O2t7C4jSja+U9VcxzvuOsDkNX9fqiRRU465qWkrs
	y3cz11ZJa+4cUESMB9Vrpr5OfX1ncTQIZzoLWIATUvRnZy613BaOhNVesJwBG55CHfHJBuqrqpV
	l4LpY1fXs2m5pBvzCa2U0TNJdltLIWj3O
X-Google-Smtp-Source: AGHT+IGljU00B/RF8kTJj6MKKnb81d+J+rlOutBe6WMWU5qG8tirojMDfyDWi3j48D1kyoUj94PQCP6BMbBUkQeoeKs=
X-Received: by 2002:a17:907:6d03:b0:a72:7ede:4d12 with SMTP id
 a640c23a62f3a-a799d3019bcmr91130466b.5.1720742966617; Thu, 11 Jul 2024
 17:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ilker Yaz <ilkeryaz@gmail.com>
Date: Thu, 11 Jul 2024 17:09:15 -0700
Message-ID: <CAMBmcmkbuB6UGxSMqLiaO_Xk5YwJmmhcZHJEggktjf9RGejTag@mail.gmail.com>
Subject: A few million negative dentries causes CPU regression for open() sys calls
To: viro@zeniv.linux.org.uk, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,
I've been investigating why system (kernel-mode) CPU usage of our
hosts keeps climbing up over time (over several weeks).
I realized it can be remedied by dropping cache w:
  $ echo 2 > /proc/sys/vm/drop_caches
which significantly reduces the system CPU usage like below w/o any
other change:
https://photos.app.goo.gl/aYQmi5v6qnThbt8S7

I was able to repro the same by running:
  $ stress-ng -o 10
to generate open() sys calls, and later by opening non-existent files
to increase negative dentry count to ~8.6 million:
  $ cat /proc/sys/fs/dentry-state
  11039972    10987061    45    0    8615033    0

Before stress-ng was consuming 20% system CPU (negative dentry count
was around 2 million) and after it started to consume +40% (w/ 8.6
million).
https://photos.app.goo.gl/xc3m5fwZdbqgbdaM7


I tried the same on another host by increasing regular dentry count to
~80 million by iterating over existing files. There was no regression.
Why would negative dentries have such a profound impact on open() sys
call performance?

Linux version:
  $ uname -r
  5.14.0-284.11.1.el9_2.x86_64

Thanks!

P.S. I've perf top / perf record / flamegraphs if needed.

