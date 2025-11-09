Return-Path: <linux-fsdevel+bounces-67572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8972C439C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 08:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4454E3AA8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 07:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96382690D1;
	Sun,  9 Nov 2025 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOX6qwnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F711F8723
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762672397; cv=none; b=W++Q/hn69Sr8rBFX/Cya1I4xUDXuaBWQIULmE/iHNV1NJl32XH7p4I5ELD520qE3AHZpGJK3UA6qWR8QyXC9BXQJlNnFcY1IghRbvMI6QkoulVMjOcMgDKAh3EFgA4NGjHSKwlipoZFyTEbGFTLNN/uOK/jPItaVFdm5ky9v8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762672397; c=relaxed/simple;
	bh=kCkl0IgEuB+qK0ucQM7ByvS2mgClHBC+newUobFrM2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/1NYLwqj9PEhRXVoi5qSZSB5lMCkU2MFEhIy2NJduUFFPstY2mPILxUxfkAmKX5CiDdpyJlt0BhmmhkC8S9fx5cHQjl8xL1vFhaEPuu3U0siEoTGd0c9M0sVPn8hu6oNlICR9Z/goD/Aic5I+MvKzzLOmc8nOkmAZbCWjD6wo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOX6qwnR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297ec8a6418so1344315ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 23:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762672395; x=1763277195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwusb2qyqwUfitZumVkZ/28VAioj7VL64C6xxAS8wL4=;
        b=mOX6qwnRHIZNmd/1YGRYE223nLT+gkppueRfKG8E6I2WZC9NbRzjRP5EwjynwSWwl9
         dxROBwOCw//AEkIDeqseh7l5QeOz584aOte/uMGb7IUkjZb+Cat1EZ3Lp0c9n2EKqmLD
         oYfLeHXbOcAGAPRjEZhjH2ZCv99HRVtRVRYunuFGR2ziTOUvhd8DZ6v5urXB1co42MSg
         JC2cBHwurNDpI5dOKzdoHEXGTDVP8Bf3eOELL1E0Q1/U7qUUTACTVDm8NzJajoRxBD1Z
         KnwG2Hay8cCY+eHe5AvxN1KsfThrjfYBqlEl1wHCNG/N2O1Zp//BD/OI7ptJfAxCCxla
         ++lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762672395; x=1763277195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwusb2qyqwUfitZumVkZ/28VAioj7VL64C6xxAS8wL4=;
        b=t6pGDTDKpAl/QCYFarJhS09Fr4zwRXmlouzFunOkJ72h6zNl4563tOTbd096EeVMw4
         sysoRqtu6O6omYZScFho7VkAasm2NBXswYksgs1OAaKIwKDwOPqKlP1M55OHkTON7TyP
         q+ZvYRoe6PmN50pBj29+GMm1w7hQfmcXn2FARYMFET3fpPS9JSWyqEaIpZgPswk+fljv
         JgJ6FWnlA/MWWQyTSnWejmv/cP+d82sYgsEZoj01lKkcle1i/QfcYGjdVAFU+GHa6yVP
         Ib+oxFpxrBqzosgy1+KfYIskbV/aXSQqDJ2ae9Lqxy8PiODNeqkWyfTkWDQ5yU2VhUvr
         CyUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/MBup64VsO7gQ/jo9+Qlt4zCiuub+7OkPkS3PsqilIabCXa/72uq73vH0TFcMgHLDRQpa52mO/f+HQ7md@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiCB8tulrqp+zPzpmqUqgOZ7+XRjCNY3Cjok1noAKb8++UtLm
	3gbCSjsF5FjIUepUiuKfU06RGbCbKKSRr5a8xHJ6ul+DCXFHKD9nOh9L
X-Gm-Gg: ASbGncvCp81RmyI5asDehMQJUZ4Hev/PmNVMx5WGOiK2tbUgmAp4ZlRnL2w7dUZmvZm
	TEqOYkooeeEGy3RhGhszJgQxPWvG0/MoW4wqdFhrgTVWghPYoIiuhiN6e5kmiRGYvCsrufYnsoS
	4a6B1Kdedik0qvdhH1N2B6UGQCw2omOBolZCNKgUEHxG0BLtOYD8bKC1JHJGUcUkRZZfAUzRxu2
	AH7JdhWwUqngK1+WdoRnIF5TMLSOgr9ne1Gj9GEVyIiph0mbOrajEXHL0q4IZnZsE75xN+yAFS/
	93A8ZOLhEmplkCcU3PBH2TtvtvXqYO+ak8e5eDS9GQQakFTyBzLzHDUnq1pWTr8ggS6zev1ck3d
	qOn3I8KZ0m8BrbwgVl2SNyG7Yx0PmiGWOB4ZX60x4QSL3i7GREjI6kzbosr98zBiJBu3PN55qzK
	LCm+k7bxsiWykWgco50A==
X-Google-Smtp-Source: AGHT+IEy6utceTlq2dzE6jroNbB4zuXSzLqvToAaWYV/ORbFpst6LvtRaKQzKsVJDmFFSf2dbDX5rA==
X-Received: by 2002:a17:902:e742:b0:297:f50a:d12a with SMTP id d9443c01a7336-297f50ad245mr18826875ad.8.1762672395171;
        Sat, 08 Nov 2025 23:13:15 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm57287495ad.88.2025.11.08.23.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 23:13:14 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: jesperjuhl76@gmail.com,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH 0/2] fix AT_RENAME_* redefinitions with glibc < 2.43
Date: Sun,  9 Nov 2025 16:13:02 +0900
Message-ID: <20251109071304.2415982-1-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LKML reports show that `allyesconfig` currently fails with glibc 2.42
because both `<stdio.h>` and `<linux/fcntl.h>` define the AT_RENAME_*
macros.  A follow-up pointed to glibc commit `1166170d9586 ("libio:
Define AT_RENAME_* with the same tokens as Linux")`, which will first
appear in glibc 2.43.  Until that release lands in common distributions,
upstream kernels still build against glibc versions that redeclare the
macros and fail under `-Werror`.

This series is a small, revertable workaround so developers on Fedora 43
(glibc 2.42) and other distributions with glibc < 2.43 can keep building
the samples.  The
first patch only emits the AT_RENAME_* aliases when libc does not do so
already, and the second patch undefines any libc-provided macros before
including `<linux/fcntl.h>` in the VFS sample.  Once glibc 2.43+ is
ubiquitous (or if we decide to remove the aliases entirely), these
changes can be dropped.

Link: https://lore.kernel.org/all/CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com/ # LKML report
Link: https://lore.kernel.org/all/20251013012423.GA331@ax162/ # follow-up
Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=1166170d95863e5a6f8121a5ca9d97713f524f49 # glibc fix

Masaharu Noguchi (2):
  uapi: fcntl: guard AT_RENAME_* aliases
  samples: vfs: avoid libc AT_RENAME_* redefinitions

 include/uapi/linux/fcntl.h | 6 ++++++
 samples/vfs/test-statx.c   | 9 +++++++++
 2 files changed, 15 insertions(+)

-- 
2.51.1

