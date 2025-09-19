Return-Path: <linux-fsdevel+bounces-62247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09BBB8A8B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B76E5A7847
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A8320CC1;
	Fri, 19 Sep 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsnhY0ap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D013261B95
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298870; cv=none; b=gYat/fx0QPXnZ/1P65YQWMdDPkPFLzv7rXPppBgWwAtxyJfnwQuqwdIFiWUVfBpZiOw6snQHEG8bwo0ZLyIZNvvNxmoSHl6l5lX+2Kb/zdSkNJWsR85wepZaUsLUApSF0is2n4RIzKCgGbJbJvyYeFB0Mkzs5j7DxnzOaVb0yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298870; c=relaxed/simple;
	bh=QBR3q128bUgK+aJr1qrFuwmKOnFUzte7eOzYpkVH+Uo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pQ0lGaAnwVFPz5l6Lmi4wiRext8bkExZAO9bGJ5ZIjSZVkvPyMrpv616sbncmxO9oeQdKJmbEReGkGcRycoBYXK8SNAnAMFUsUPp+wEJ7kZyf+6YCyH2PXctKkwl/JqTTQmd2VA2RLn+p9SU46rigOh7/dLrWcTEydOZA0lCHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsnhY0ap; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-323266d6f57so2390353a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758298868; x=1758903668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWYzmm7VP3Jm6Odg4nV5pKuMy0k2YkDmS/dJtDxHQuI=;
        b=LsnhY0apbVAOzXHvhIqNmR3DQXmkta1sUxHPheLZMPzDRHma9GZr/J0UCmATfdWioh
         oxHvmvbVdNqvep5JD1QE5xPcE0Alk5BIu9Yd/FxSYgmcsFKbZXygKafaahE1AuH8XJZq
         avAy+DVjkBNE71B7IZPY+8xtWJZgHktk/NoYl4WIgBtErN2t9sMrmhq/EhYtB9RwyaGV
         dTQuBNspNAhlHawUQgtP1PpAkiyWq3mmRMDDVTsVpfaZXa9AkD8llvV8fbop2FPMPnhZ
         H2EuEFJwksOdTvQmraa9WtGGgmyIE4H0YGRewdkRtsuI/QOHxKzICJJQRg2SukTmX7F2
         30Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758298868; x=1758903668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWYzmm7VP3Jm6Odg4nV5pKuMy0k2YkDmS/dJtDxHQuI=;
        b=dhF+TCaOu9LTP3kVEGCekesp/svSC/j1/UuNuCoI70JuGMNZva3iYVcs4Ob7jJU+SQ
         hgThtwmgAcvZDAsj35Iz80cGs/jP/9ot7bCHEz+5erHIOh4MT+w8AI/pBs0LbfvAE0TX
         r24pizSrpqFG5RM5m51Pa6Lsosa2FQ9h5YUofGly91Lo3kyQCQKZJjBwHo4YoAx01CVA
         HEKPFIQv2Vy0j8mk++QNW7VoF2weR4JwuoihwYvfCL/VqPraozILCPM2pa/2q2NnwkXN
         WzVYsEIqOm/B3NRmE+AXLPlIK28BTV0PUNSBEO+6mUiN4RV+10KJxi96A4C15soXLSHj
         crRQ==
X-Gm-Message-State: AOJu0YxquaFEOpY/t4e8GAULh1axLTYuS3KcF69wKdYQoJRq/az+2sfS
	PDvo1/Bo7xMHuyTjB2zRI0lZJjlPw57vTzMR1XfaDqvzlmYMTxUqGLJOOW6jQg==
X-Gm-Gg: ASbGncvYMHbJU+9Xmmh0C2sLKNXITwjNx5v2hrHXMIyfqhDsvY74CYfNyyVKnpHlNdq
	q7GgUcK6i5h8Kkxvemi4wDIxiE4RGBTAqyNlUgIhQdf6yiurnt0DffgVcIIo/zQx3Kpcxojh5q1
	kb18XKc/DZ2gYkVv/U6eSVPjju20uiq1Kt5nSMaTb3KKy2SHIskhZb82QZMkJIirdNZlj6uxaYT
	h3rG5PVUw/lD3+W47ETlBEJO6beXs6gphUUiuEUkhkl3prPXAbjDkLc2fDBvdAuwIVgNLTdO7US
	XOcawyxsUeOOiXtCus1NDtkRah/9ZwqReznchHkkJ9DvRU3FQD/Fc4PbZR1hXHobIKUFQSe8E6e
	8rX5zKjY8ozuC6GH48V6tpdLboICVCdweWGPACR8lSBO3x5yD
X-Google-Smtp-Source: AGHT+IHjxACvl1yLV4P8mxv2sLixkOf/7iJWwOXaLEDvxyIrPBDvXpv72zWEuAoL91+sk3WreigFAA==
X-Received: by 2002:a17:90b:3ec1:b0:32d:e07a:3d4e with SMTP id 98e67ed59e1d1-33098387bafmr4673814a91.33.1758298867960;
        Fri, 19 Sep 2025 09:21:07 -0700 (PDT)
Received: from tx3000mach.io (static.220.227.itcsa.net. [190.15.220.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff3750e7sm5219934a12.17.2025.09.19.09.21.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:21:07 -0700 (PDT)
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To: Linux filesystem development <linux-fsdevel@vger.kernel.org>
Subject: [QnA] procfs: How to read the unresolved location of an executable?
Date: Fri, 19 Sep 2025 13:21:00 -0300
Message-ID: <3300604.5fSG56mABF@tx3000mach.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I have an MWE with a combined multi utils executable like BusyBox. I know I 
can use the arguments passed to deduct which name the executable was invoked 
with.

$ ln -s multi example

$ ./example # example should show in argv

I want to do the same with procfs but if I use `/proc/self/exe` it points out 
to the full path of multi instead of example's. Is there a way to know the 
location of example with procfs? My intention is to use this location with 
frameworks like Electron to find resource paths relative to the one of the 
invoking executable.

Your answers are thanked in advance.



