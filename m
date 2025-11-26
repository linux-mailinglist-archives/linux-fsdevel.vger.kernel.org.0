Return-Path: <linux-fsdevel+bounces-69901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2100EC8A874
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 16:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68CE034BDFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC83074AF;
	Wed, 26 Nov 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ruR0f9ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1459304BBF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169672; cv=none; b=qdo57dhBzQzmg7s02DUUOqEefPvAZEfZ0lAZr/f9dlkn+v0i8bsQokxge6C0ja1ah8dId3emIcKhjtnywuYuC7YNJYOxg0nOGh9j/OLOGO7GgkvHKcVNNgJ/WoIZK3lA6N4wGRu9WctsTDUF/VV8lXfVQ0i7c+wuzwnQSFCsJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169672; c=relaxed/simple;
	bh=OWnEu8c39sa1qXhoge2+MDzNJQLe4H9OEsol/tO7kE4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k9yWyauOEqCU7gYHba6oDpnucGo2uh6aw4b4sAcuQ3SW7QvvdDptaAklWXCN92wqxiAPMWewH6/gtg3WZIQuZp5HRXhaDaIT82pZPm33QxJnYyjqh8w4uk6lJz5xTx8C3ECtlvz8yeFl/+f7cdO18acou5tQz+4y4g8mQSx+y5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ruR0f9ob; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edb8d6e98aso406401cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764169669; x=1764774469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OWnEu8c39sa1qXhoge2+MDzNJQLe4H9OEsol/tO7kE4=;
        b=ruR0f9obUVbcu29y+RrWvdjq9lxA7Q1NXV8iYffu1TP27wSmDXYLuyuLl+BArNSuXx
         gR5qfcx/BvGBE7le4hKqstk/UtCg15dgN8MFTaaR+NKUpRZ6kChLDP4wm61TkxWlMzwW
         pnG04L240yCjQQ1SwP+GxAHmBDLQS3zuIrim8e8gNOC4Ul1rPtjvU0rfsL0Dvomoi6FC
         eC4nZSWxhNPlchrbzkDKJ3gR+RHMLorDIZ2qkIDRYmUZnlvs2pyUWPmd/VP1e/4vRE1J
         UJsUVSo3hGRhu0F8nGCqlB19hOOoiF66eU2U7R7nAcyVc7QYM+18KoTQTYcQnXX4RZVa
         4gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764169669; x=1764774469;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWnEu8c39sa1qXhoge2+MDzNJQLe4H9OEsol/tO7kE4=;
        b=JxuEJy34UhZroVTlndXWTEAlRd3BH14k/Olc03hed1WKSmdEBXl2t5AOZAKxuQS0QT
         egflO1gsxifrm1tYRv0pTG8KHbHuSppdrSOW4lLASyo/1KAus4rEmxcuxSHhePTbbnRA
         ps7MIMq1PcvTNysR+I3E8FMRBAcTq+ItmBuHAnsXOpOCbu6L0ayvdwlWJsqoIorBbNmv
         pWDvQiSCVUMbg9VDnZQ/JAPL1Sq0U8ZaehpyYNETMWgpF2JbqYtOtfqsrohuzUlY2tYN
         exDXZI+dIpIcvgj6DqVOthWlvJOkfi7jQesQRJ1HnRZPBoXM+mwK9BG7g0/A5XP760RS
         tyVQ==
X-Gm-Message-State: AOJu0Yx0ua/7xTo3VZkaoVE+z6Uih/RMCkvM8zkToGTORZn5BLjpzIJr
	7fIN/XezfHkz3tjJxNsdQpBzr5heoTJXAwVNNnwnXvaNxEtULaITL5Ezpf72Gs30N4wjA75G1Ga
	b7Jz0S/xtidMoQXmeiNUhUfURBssAKGTIkAH54CWflWXn+OnaXBaWcLgStOEYVg==
X-Gm-Gg: ASbGnctI8NRAMofzZ4z8wvYDvF653GhtlY0xJbwD8Pz/yBisNCWtQDvSImbNhCXrhgD
	cs8KcaTkVf7Id6aMxrfP845FZpHQQvtV1DDng1L5be431/Sufz/LtnFaUeGR97nqgBVbfnafj+0
	qaRV1UYgbwssYF0AIZ0hWWCQsINA6BWysoVBpTA3GyElsmL5Vro6uP+aQAhfcSb4x5u9D0MH1SI
	AKUYrPdRju6/tFPxIYiLdPalCbrmvZMKiAmiBYJ1WWc32eYXnEpwblzG6OhV4Ey9dUnwineBXIl
	bVfaC5gTaGc1vs2ui3GDTLNKrUEZZXJIuR8wOgk=
X-Google-Smtp-Source: AGHT+IFCmUilnZEivhyYkVat6kYn4XuNUWdnJnU9sPwWGQpvfaTJAfvkSNoDhk+yB8a5catSE1/OJZ000zuWem4EUEw=
X-Received: by 2002:a05:622a:290:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4efc8388d07mr3845621cf.11.1764169669146; Wed, 26 Nov 2025
 07:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abhishek Gupta <abhishekmgupta@google.com>
Date: Wed, 26 Nov 2025 20:37:37 +0530
X-Gm-Features: AWmQ_bnJ-4-eyB5DjyMDFd4SnT5kRf10MfPJMxZUVCuwDxTq-tPESQHZqz5tjmY
Message-ID: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
Subject: FUSE: [Regression] Fuse legacy path performance scaling lost in v6.14
 vs v6.8/6.11 (iodepth scaling with io_uring)
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu, bschubert@ddn.com, 
	Swetha Vadlakonda <swethv@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello Team,

I am observing a performance regression in the FUSE subsystem on
Kernel 6.14 compared to 6.8/6.11 when using the legacy/standard FUSE
interface (userspace daemon using standard read on /dev/fuse).

Summary of Issue: On Kernel 6.8 & 6.11, increasing iodepth in fio
(using ioengine=io_uring) results in near-linear performance scaling.
On Kernel 6.14, using the exact same userspace binary, increasing
iodepth yields no performance improvement (behavior resembles
iodepth=1).

Environment:
- Workload: GCSFuse (userspace daemon) + Fio
- Fio Config: Random Read, ioengine=io_uring, direct=1, iodepth=4.
- CPU: Intel.
- Daemon: Go-based. It uses a serialized reader loop on /dev/fuse that
immediately spawns a Go routine per request. So, it can serve requests
in parallel.
- Kernel Config: CONFIG_FUSE_IO_URING=y is enabled, but the daemon is
not registering for the ring (legacy mode).

Benchmark Observations:
- Kernel 6.8/6.11: With iodepth=4, we observe ~3.5-4x throughput
compared to iodepth=1.
- Kernel 6.14: With iodepth=4, throughput is identical to iodepth=1.
Parallelism is effectively lost.

Is this a known issue? I would appreciate any insights or pointers on
this issue.

Thanks & Regards,
Abhishek

