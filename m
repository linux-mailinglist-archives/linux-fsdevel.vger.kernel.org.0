Return-Path: <linux-fsdevel+bounces-66614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1F1C26779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 18:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C2794F7996
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A592BEC26;
	Fri, 31 Oct 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO6XF6au"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412D2AF1D
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932554; cv=none; b=P3PbQzHJRTSISVv5VIbBY7AZZpfqnts1yKacDOjddAqSzTswj3LB68/s2tviktfI3gBkVRZJyB5sGOiZmK4yY/Scj6WIFJPQNhj+ZaZ9LS5sbyQJp3ciLvQED7+t78WnSNugK6jPchzbkJaZ2Ki0mVDbKdxHG35+nTQ/kYOY4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932554; c=relaxed/simple;
	bh=DYEF8MbETkWa1W+FmO2hraZ9Nh0ThE32WSIYF5X0sVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/vRqRsCnqNYMPnUhpeg6XIhRoSsrlZjLBlp/pT1Gzo3s5bgnm6gA/V3gZtSUCh1Kj8dXx+2hR0X3EjbEvI5cQ5ykgtu+8UlwcYK5crLsQg6eHk0EnpoY5tVp5LocwmIaixzb7w/7jZrsgsbmfBeh+RNWyxakaBujTjuCdSiBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO6XF6au; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so24443575e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932551; x=1762537351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdJDBEnJpKm6jWCOTYuhfQ0SBELeMNdpfOIkxeoe/+Y=;
        b=QO6XF6auYASGT3E0wDe/HhKPVe5KKKIUJE4K+ZF9V55X9Qd2DU/bLidv+XyfHZIOPU
         RQ+W7PQGYQOUyYll6P/8idNGT8YWXbxt/cedkkqwOKU9hGUVv7evpquTG8FKq3zL+Soi
         DJplxRYULqtzgrNHcKlbPZOgmEL2J6gZ+y7ezxb9q6n7iheSyt2g5RKu5EhfeR8sD8dN
         JWOVAhKMMaytQiXI67JhF6dtjBfAuv+IYEia0YkhYF6XBpuDVXhbhxPEJB4gwq4y8lFx
         5x6bRnM1ZK1XvJkHnsp5SEnbDQ5qhm0rZFC1sm6vhHrliAeeJlvmfUYQMWVbvlYI6TWw
         tigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932551; x=1762537351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdJDBEnJpKm6jWCOTYuhfQ0SBELeMNdpfOIkxeoe/+Y=;
        b=RUHRldRzXpa2IXU3eBFSiki17Y/kIyNHcGXo8UtxuSaDblwDxDKMzzyngYEVkK4YSJ
         JNl11R7ddOcPB9cpiI9PYTjEBGvdEwq38+F1twlDLP8HoJgeBdVNysTWzZCCCxU7Hb00
         hg+1FOmgN9yhGBKpd72y7/sYHly5Pw0/bhxmwRUkXuX3PoMVPa9Tkbuyabp3sa0gkp21
         xZVaRmL4rT04VLBj1sQi52wV19I2zup5xuwG+aBNqMb4E4n5LfKPGushOD33wztkVstE
         AcUto2S4fptye9yXCEQT52yhU+MjyT7PYN3vukA0hxy1TysPMzH2Pzm8jRh7BxSbo+mh
         tJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOGDWXTB4QZ8QzhuF4vqACwXbvw5nijhCqwqfbGhJPuZHydDMs8zahsWtOvC5xPFJy3mfF+gFKJYM+CTnt@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiL6BmZWo3ybICUp5nrKF3qSgbKMI66cCYBhN+CxNdDahkh8w
	BsbCbf1mgqfqB2yf0kGAhhhrRkDWyR2yYt23QOXjDCRO+2enzfoxYTzO
X-Gm-Gg: ASbGncsWHrg5jkvO2rwX/p5HHu6ycV4hCaX4VjsUUdf5uPYNj8Pf49OXlk/gVDjJ8WT
	m/1G+sDWs0oYaxfwRt4FLiPjrSPd6mI6hxrIzfleSlJCY+i4pX9llBpwckksZ3wtS0UENlREL6l
	O7uDNtuZQepQDNavwzYK9IqiQAtcnWs2ma4EMXuZYROF+1KSQQlrgDBxp8vcD+3lie9Dc5va/3T
	UOzl1I4nWwMSmfmcIacgxPc2NIVbv4+AxA5IOBfIe3608OOz/sS1Jw233hoWKwi6BvdhErONbAE
	ywThzJj7mJZWKjrDY2bXR3f8gBZUSVfZAfEMMVOJLoYGZkOcd0pG1o2pdlmE1WvzKJFWKpzq74R
	NaLhaulMAq48Sm8nYrBS/BPd1z4p8qNOM9N3awn78f5bSkKCqKhBGadz/9KHHl7pQyE272OVOxK
	wDTFb04qrD6qLi9l3+byQsDycnxLKLR+HabUc/H2E2JgrN02eCWnhHh1aNs6o=
X-Google-Smtp-Source: AGHT+IGAkZg8kAklapkT4C/4gT42mCirvSfZPUgZIn6r0X6eqd/Q4MaOuVsA9Z1qVisGwmh3i9a7ZQ==
X-Received: by 2002:a05:600c:5292:b0:475:dc85:4667 with SMTP id 5b1f17b1804b1-477307c2af0mr46578475e9.15.1761932550959;
        Fri, 31 Oct 2025 10:42:30 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53eafbsm6728865e9.12.2025.10.31.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:42:30 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [WIP RFC PATCH 0/3] runtime-const header split and whatnot
Date: Fri, 31 Oct 2025 18:42:17 +0100
Message-ID: <20251031174220.43458-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So I slapped together what I described into a WIP patchset.

The runtime header treatment so far only done for x86 and riscv.

I verified things still compile with this in fs.h:
#ifndef MODULE
#include <asm/runtime-const-accessors.h>
#endif

The -accessors suffix is not my favourite, but I don't have a better
name.

If this looks like I'm going to do the needful(tm).

Mateusz Guzik (3):
  x86: fix access_ok() and valid_user_address() using wrong USER_PTR_MAX
    in modules
  runtime-const: split headers between accessors and fixup; disable for
    modules
  fs: hide names_cachep behind runtime access machinery

 .../include/asm/runtime-const-accessors.h     | 151 ++++++++++++++++++
 arch/riscv/include/asm/runtime-const.h        | 142 +---------------
 .../x86/include/asm/runtime-const-accessors.h |  45 ++++++
 arch/x86/include/asm/runtime-const.h          |  38 +----
 arch/x86/include/asm/uaccess_64.h             |  17 +-
 arch/x86/kernel/cpu/common.c                  |   8 +-
 fs/dcache.c                                   |   1 +
 include/asm-generic/vmlinux.lds.h             |   3 +-
 include/linux/fs.h                            |  17 +-
 9 files changed, 232 insertions(+), 190 deletions(-)
 create mode 100644 arch/riscv/include/asm/runtime-const-accessors.h
 create mode 100644 arch/x86/include/asm/runtime-const-accessors.h

-- 
2.34.1


