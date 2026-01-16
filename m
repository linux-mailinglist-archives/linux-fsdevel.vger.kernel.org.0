Return-Path: <linux-fsdevel+bounces-74275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5768D38A6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A789304909F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8180F3016F5;
	Fri, 16 Jan 2026 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlICbK1+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552613D891
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768607789; cv=none; b=N04M/11Xfno5aILcIXPh++L9JjwA72368Pa3seHJHE6jk2qBvgKupBFT98t08hIvf33nRvvkDgZjsGTVQkQb6nxu2vAjW3dBlhSY3B2avbNFttwhuH2ro7DJw2uEPt3tFCWei3EmY72yByHV5jQzZy+Gl7hkIuXXPECP3ZUJ+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768607789; c=relaxed/simple;
	bh=sjrOeUdnyKb4J1uRO7uuu4Rt02X1VYzL9mQHvH+URd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1QDMaJw17PBm7+Br4EJGqTSQUFxKncHheSsjI71Ojtts8N741F1gbIz1ufLbjdZlXrZhPZBUNigq4kwf6LihSxq4P3reGSueUfr645QdT8TYO8pl10B0ubflaFuPcLSNrdM12lS4h3abgLFTEnXCa2+u7bOGmoA/6hIGtJllT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlICbK1+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81ef4b87291so1355290b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768607787; x=1769212587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rq68E7M9xCYQNGUy1XmtIJIBaK0TRaEBAlddirVb7VU=;
        b=RlICbK1+AVxVI69UblJOMxi8J7zgBVxh5C2/K4wM/gppHJZZ+rDvGcT4C2lHJp4Lr+
         kAlV/pnMYOA2RtmD2h03o5sWkURFdd/piaiTo0FBWWvdZZGScX1AHDjSxDDAQJKUK3kA
         bsZH0iGxkVOWt6277MJvdrnTb4WAK0k5KG27xuhcwDDBUYdpHpL4sd7p8Eqq8BM3piNw
         JssU9hKhHqkyLA/xyXy7psJiKtUStFAHP64aKyIGMFWTD6GiZb8vck+L442lui1SEP70
         jbI/r2IEs/kmwFG6ImlNELUA236tfWcphCpw7oPE2qNwT0/d2kKteDIgO+kYReEZHA79
         H13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768607787; x=1769212587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rq68E7M9xCYQNGUy1XmtIJIBaK0TRaEBAlddirVb7VU=;
        b=DG+SWHcCFu2yNuLWcEcvSg8G9vIf/5I8Pj+22e6zysrY6oFXNq2X+su0Ql533j5xpW
         9NCOjjliXmM67UhrpsKraVQixmLj7rh81eiw+RY8CFDQSWEaqhFb1fL8c56L4+cedIrd
         vF376bSfwAZxQn1eoEx7q77Zoa+sjvCBpXTnssBXNF77Ltf7+2OGQ9ZbUgIRe2pZSDiy
         V+a3z24efIbKXg4oQJ9XVQP2XAB0n4YNbWL6mzVJLoRA+28/mO4FRA+DYjFIHSB6zfNk
         9X4b+XW9OyuTNQ6Qsp3eCdSsm8q10lMsBKJRLKPgPiuehhjL/dJC9h3+oibO2cINNocf
         VgQQ==
X-Gm-Message-State: AOJu0YwlzpIqbO34SlAXvTfQLo1FRAQqrXaum6hjH57g9RfK5Nvab4uW
	o7RhUVE+9uwkgG/xx7UuTtFx1w+JuejjamBULzFS1fIFdEnCSLZBTtBusn2wuQ==
X-Gm-Gg: AY/fxX4B7EK8TafW4Sns+rDViPUQcAEAqyQMBaMBLno25QMzEc72CynAesG7k6qsXAX
	GMJ+sEALpkL7veDUFHsIJFu3OrLjhlp2lJYW/nlpLKWM0C9cTRU8KjuAGCAyDpsbdQtG9bLsNMP
	vCT/S1oNGuVNZhGSJB5BAzwpUr8zuAZmswM5KTu8MFBci9nf+apHcIHj8YckLlmDxq7svUtbLR4
	twdcqIcB+HR7LIWOkkuLQTA+5tT68rwsxnfNAzHjqhVIvulbPYSdNZPETvxrEpz8mw0NT7MZdaz
	hL0n6yZRD3JCahIlO/WT0/nmit3jUe7tEg9//9KtJA19XHFOBWvILIlJmz9Ohep/ZlBp3Iqg4GN
	26EEH6i3ILT3GsJZaYbkf0uR30NKX+im//qUufA66HT/djBfIGC/NzSZ6A9TTD/H8hE+IBZrJ2e
	Ms6woW7A==
X-Received: by 2002:a05:6a20:4322:b0:376:2a3e:e758 with SMTP id adf61e73a8af0-38dfe60629dmr5287398637.28.1768607787259;
        Fri, 16 Jan 2026 15:56:27 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2655e6sm2890850a12.16.2026.01.16.15.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:56:27 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH v1 0/3] fuse: clean up offset and page count calculations
Date: Fri, 16 Jan 2026 15:56:03 -0800
Message-ID: <20260116235606.2205801-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset aims to improve code clarity by using standard kernel helper
macros for common calculations:
 * DIV_ROUND_UP() for page count calculations
 * offset_in_folio() for large folio offset calculations
 * offset_in_page() for page offset calculations

These helpers improve readability and consistency with patterns used
elsewhere in the kernel. No functional changes intended.

This patchset is on top of Jingbo's patch in [1].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jefflexu@linux.alibaba.com/

Joanne Koong (3):
  fuse: use DIV_ROUND_UP() for page count calculations
  fuse: use offset_in_folio() for large folio offset calculations
  fuse: use offset_in_page() for page offset calculations

 fs/fuse/dev.c     | 14 +++++++-------
 fs/fuse/file.c    |  2 +-
 fs/fuse/readdir.c |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.47.3


