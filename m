Return-Path: <linux-fsdevel+bounces-78335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QECcLrdinmkKVAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 03:47:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3368A191030
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 03:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E73623064D95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A127280F;
	Wed, 25 Feb 2026 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXJNB5hN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC123EA93
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987629; cv=none; b=iul8rJMRALx4+wvu2WYMxe8bX2tpsgzrlSk96Fsz3ExNyaZ8uM/ZOKlA+iPbSKPePyvm4GnxcP9Zaz+jDJV7eM6LdsZeqeufUSfBDqtKT5/yxFuXU/3FisnJQ7Nkew+iIoH9RbJc+YkzfOqCrZn29hWjd+TcDDr6WmgE7AKTIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987629; c=relaxed/simple;
	bh=E1lwa7ZJ/WAy2alEVM4F0dirmYmtZhj7j38hNnf0+OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXG62b/RNPtaE57H6iracBW6gqJb0FOi3yhx8O0YQSCNS50HeyBjUL9IIIEcG9yCVZUdMySuQw68UygUR0i2K2v0GY9pALGi2cBh7WQ3SDvKj/iSirGj9Ay1psObqcN6xUfu875Nt8NTc7peoS+LVZ3JzKAWyCggAcunmjCOhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXJNB5hN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48370174e18so33546895e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 18:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771987627; x=1772592427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiFhgebVBAWbhz5+ERVNeVjInFoee99RjUIbud6OLg0=;
        b=jXJNB5hN0WxN7ClkUbDOSAsSq68K9mhXc1XEdZjG4EWmuuH/lFHggEuZpkoGqGcrOv
         jCZkyWgEBrhzjCU1GsrE0iIYJOCrU4vI8VyG5fuYKRGd5I6T/8g+DifXdLklJLDOtv5I
         zRuv0rC9QqWFN1t+2jhC6MZIOUOJx5wUsx3pUO3lUgLBIQS9NBTSXeMR7eYhzvhdUrPt
         KY5O5UGg02zdqcOfEzoZbPxx1S7OBsosEozzjqGtCUXUlqM1x1h+UR0UghAWFd0szN4w
         RNS+tWe70Wn/VXDl7nqvuIQ/9fsW9Bh9XXpMo8Te77mkwndrpOgaM0zekbPWevyKRjtd
         LE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771987627; x=1772592427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yiFhgebVBAWbhz5+ERVNeVjInFoee99RjUIbud6OLg0=;
        b=i1Iilt8FwRXIvfkEZwwoRuXkpQrIWc5iiS3YZXrnCMzLjxEfEa0bDSnF/UWQQucjZb
         XS2Mkuulgas7cuI4hnCi8aH+Y0f7uuqTfJ84wHmmzkwYGa980glnn1p1x0fgQyOxdGZX
         UwqcqmRHepXyJa6fIC+WlTWvDjrObl2s0dt/ERsl1U5FvI78VUMA83Jib7xahNQ3BgB9
         TPvX3SaZZv2siEAJHqs7zMl+XtX7g5bDvW03rMtUbu41HbIh91Zc2Dg07w73cTRNN8kJ
         LuW835sC49R/l80E3eJ9PIeJtgZ2mVrLsyEUtfoUe7YEL6M1d4d1d4AVE3lRT1e7wX49
         Rh1w==
X-Forwarded-Encrypted: i=1; AJvYcCU/RV+c2+4fS65X9N08VuDRhQtqlpMH2As2sSXit8waNqklc3XxjmwppnCvsa1UkP8xofrlGvXJtOxmgx8E@vger.kernel.org
X-Gm-Message-State: AOJu0YyPv8zhgq62stDowRZ5BB5xtR0Fos6MVW7U2zg8arwo4gcDHtq8
	/YPYkx4U98zTXz2H9ajAKPST8O9juoBvPsoqUAZLS9WFKy52u9xEcPQL
X-Gm-Gg: ATEYQzxeBItT9TVu/AnUGaodEE4PNg1efouucZtjIJIf5fWsDgPBISsfRZwXPOaGSzD
	KUM+ilDag7YRwxAL9a6Ajflz78WNz6e5Dc5manQABqXBH0THYCbxNeG6up0VulRa5/LO13KWIg5
	6FUc5lIn6Rpv0ebGn5rSwc0I1GCnkSvS5mRSNXl2xTqIRAsTlCDnFrHrTbC5zg58rdWDi+qiSR2
	OQHLm5ENhNwVPjM60xgg6rDjAuSHD8F/nqGDPZyEuhMLZ4tdWHsM3/MsNYrvW5i/+ZJ56pdF3fS
	NVLnSAAmH3gED0gyHr6dW5+pK2zqWGT1L/+rCx5dMz0Csp1fxMHRA6lB8CDsBI4PU5rfnND3TTC
	yiU2fV1etl7Y3J1hOrrpjtwIYPZ6/tjEzQUmWSYztntFHmzICRTl622LVREmIS3MGrFBdqd0zs8
	9N4gbgbSWF/Ua7kCNnFJc=
X-Received: by 2002:a05:600c:a06:b0:483:badb:618b with SMTP id 5b1f17b1804b1-483bef5a23fmr13743535e9.24.1771987626617;
        Tue, 24 Feb 2026 18:47:06 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483bd7272bdsm32789845e9.10.2026.02.24.18.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 18:47:05 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: ignat@cloudflare.com
Cc: kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
Date: Wed, 25 Feb 2026 05:47:01 +0300
Message-ID: <20260225024701.3098089-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20200305193511.28621-1-ignat@cloudflare.com>
References: <20200305193511.28621-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78335-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email]
X-Rspamd-Queue-Id: 3368A191030
X-Rspamd-Action: no action

Ignat Korchagin <ignat@cloudflare.com>:
> With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> before the initramfs handling code, so initramfs gets unpacked directly into
> the "leaf" tmpfs with rootfs being empty and no need to clean up anything.

This problem is solved by nullfs patches:

https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/

They are already in mainline.

-- 
Askar Safin

