Return-Path: <linux-fsdevel+bounces-45411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB3FA773A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 06:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC9E168D8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 04:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232261BFE00;
	Tue,  1 Apr 2025 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L79WPtzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144BEACE;
	Tue,  1 Apr 2025 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743483540; cv=none; b=INGPONApI4CrGjon4yLK82SFTNiq7It61q/tS6X6InsnsWT9bpNpPUenIh/o6tMnNSrM8/KpzngOxmKKw6jP0z6q22Sn3qGux/yKxM/eGUSr7/NBTovP++IjhU9bCTQTfVlFxnt7NMPIjj1ronsIiM1OllMX+VRerPrCwkwA/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743483540; c=relaxed/simple;
	bh=3z5XX5BtVoTMasfMWZlJkWa9WdOEmC51NhKM+qgU1+c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YxIYavJ7EKYG8S0A/EyTbAwOQLvCM6wA8CAudIsBwshAKiN7v1J0Hpe7XewWDavuJSTR3dqM5BkyGR9CF5QzlKZvD+ocpPzCpChCo4J4LxvzCcWshRuDZlE/4kAzBny2XKfOOWUTF3dQ3tCpAYJC7Hp7qMUWmOzL5z5l+Tn8NFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L79WPtzQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30db1bc464dso45786061fa.0;
        Mon, 31 Mar 2025 21:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743483536; x=1744088336; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VWTENQzr2hZDJmgqPOZQRNlVCbiEyzezvQvSZ+qcZVY=;
        b=L79WPtzQVMHmxt0S9rMHuOORQLP/kflg8S9LOt4yir57lXre/LSEWwAnLlYLZhsa7M
         xIZAXXB01YT6JJtS0jYS+JTSMmZ7pcfqH3fPmWv+LcGienGp3XJRim+9b5WSMClL8NIi
         8m47vyKIxGw5EdClPZcA2KQShcUP4plLjbBnNWA1x2lFf0DCxDvtxfGZxj8/g03K5Wcf
         rljvylFBfpeO0zw8vvnQPnoalkk+wTYU/fd1rTd39y1kvwAy8g0fVjMVBTviqGbB4eM2
         TM73eB8b5kQ/5gTIWxVGPztWCKwf00AR7X+MVmZmAswDnXe1I0TjetxvQOW+Y3QHuZuI
         jykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743483536; x=1744088336;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWTENQzr2hZDJmgqPOZQRNlVCbiEyzezvQvSZ+qcZVY=;
        b=HbHgROJv69G/T4gL8jTPSVeePiVNzwTlIM7EmNkKscV70NFAj7vK+gWQvab5r8Ojb0
         kEdeAs5HTv/9rEntTXV8PhAe/bDRnmvKovhgbG78c0qjyxlXhKvY0B2jUvk8zH7JsIkf
         Ra7ZdIkYRbwoIfwaaC9A1EbOgIzFoqTGs3M8xVaiZDxE6VThmVn0zN049Z+Oy6b/L6F+
         0W3xBPwvFJplcIsW1H+DXfHJZrOc4mrzNvzYg9tnAUjVO4NBcG2dci+GCDiiMusx/9Jl
         1K0AdZKg8DLoxwJnzyEoffqlxcuCAh9NpZdw999hQX2yaaTJu7FXDLC3n12ZoVmOonTB
         9ZUw==
X-Forwarded-Encrypted: i=1; AJvYcCVxnq48vF3D96vnapYDGr0EJAHuJ+aXIdit6+xAO+9yDSqo+VO8G/iDKtF2IqmigATNL7Ehh3gJ0uH4Rtvo@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxlR7IMy3LnF3uwXs5a0RbiRIwMhYjNZrBIfLhZtFa9u3OZeT
	8Wxy/WEUReW8woKt9WZa+QgmomGbiSv454FDjOmFZam3vbF2W2cBwsTR/JXweXJByH0J8AsLtcN
	hCYCIm2HMZrJMss2CNWJ2o23Pm0pYmSfl
X-Gm-Gg: ASbGnctzG4KSAASXqjr2/+T+qm/zxmM9BGQUDVHuwYbmgoEkFc1PNw1vOFHxtpMAalt
	a4oZ7zqyagt8mUfN+Kpy5daVTFHJ4XytGLh1Dd7tbNNwwt23flcF/VuPTxYwn41t9OPxUOWY9D0
	xdCpxaSUzqkz0xNpMYVu6e3hQclCVCe/Qyo2wBaM15UxNTmLTXc1WuOobfZxuA
X-Google-Smtp-Source: AGHT+IHMduVQM7Rv6Xiep2IbvUU3vM8bK7xyCH7L9lMJucSLkTrZLrMCHNVkofFdW6RqJ2xczm3thdlxaygGGHyICNA=
X-Received: by 2002:a2e:858d:0:b0:30b:b7c3:949a with SMTP id
 38308e7fff4ca-30de02655e6mr33587281fa.18.1743483535946; Mon, 31 Mar 2025
 21:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 31 Mar 2025 23:58:44 -0500
X-Gm-Features: AQ5f1JrcVoDAoAIjWjhq1iuk122oVsMRc5QCcasmRDfbRNCFpyRC_6rrHibhPkA
Message-ID: <CAH2r5mvre+ijjAQMbqezJ=PeNX-8-o228bh4SjyJjL8wGp70Yw@mail.gmail.com>
Subject: SCSI circular lock dependency with current mainline
To: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I saw the following circular lock dependency when running tests with
current mainline from today.  The tests were not related to local fs
(they were for smb3.1.1 mounts but the bug is not related to cifs.ko).
  Presumably bug is due to locking problems for local I/O.

[Mon Mar 31 23:12:21 2025] sd 0:0:0:0: [sda] Attached SCSI disk
[Mon Mar 31 23:12:21 2025]
======================================================
[Mon Mar 31 23:12:21 2025] WARNING: possible circular locking
dependency detected
[Mon Mar 31 23:12:21 2025] 6.14.0 #1 Not tainted
[Mon Mar 31 23:12:21 2025]
------------------------------------------------------
[Mon Mar 31 23:12:21 2025] (udev-worker)/423143 is trying to acquire lock:
[Mon Mar 31 23:12:21 2025] ff1100013840f118
(&q->elevator_lock){+.+.}-{4:4}, at: elv_iosched_store+0x13b/0x370
[Mon Mar 31 23:12:21 2025]
but task is already holding lock:
[Mon Mar 31 23:12:21 2025] ff1100013840ebe8
(&q->q_usage_counter(io)#13){++++}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0x12/0x20
[Mon Mar 31 23:12:21 2025]
which lock already depends on the new lock.
[Mon Mar 31 23:12:21 2025]
the existing dependency chain (in reverse order) is:
[Mon Mar 31 23:12:21 2025]
-> #2 (&q->q_usage_counter(io)#13){++++}-{0:0}:
[Mon Mar 31 23:12:21 2025] blk_alloc_queue+0x3f4/0x440
[Mon Mar 31 23:12:21 2025] blk_mq_alloc_queue+0xd6/0x160
[Mon Mar 31 23:12:21 2025] scsi_alloc_sdev+0x4c0/0x660
[Mon Mar 31 23:12:21 2025] scsi_probe_and_add_lun+0x2f4/0x690
...

More details on the log message:

http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/builds/438/steps/205/logs/stdio

-- 
Thanks,

Steve

