Return-Path: <linux-fsdevel+bounces-49906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F2AC4FCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB216E3EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06233274659;
	Tue, 27 May 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V7XCdpZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D229A9
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352782; cv=none; b=t5nimtssd4jsCzn6s9Gf3LZ8OdnbkpGHZk8Mm90BzVCcVSL2VaYrGxFrzCkElxcZM+J2NxBWAj3rZJOXos0ukPr+16NXHytDSt0IHzL7DTqwIIEaiDy+XXyohcNbYHVy0bPXDqjznGVNE4aIVSbQHpxMR0bxskyj7CqKmvHpHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352782; c=relaxed/simple;
	bh=YLUcP0maf66EdADdsz4jA4+C73NFgQ5wvL5ln2WbgFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvWb1TPgc8o9H+kuFhNUrn7eY8n/CXbZmrgf1ahHuoxpQJUmVknx7YIBROn+1RYgaNX7CisShrVicYwys3CwURqiZQenTqgB7tTFz+T9lnU2yT/OyAqPunGoczz4F5xqKFOopBfSVBylBXjRBNCuf4b4Cst4VTLEpoRuX1if7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V7XCdpZh; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3dc8265b9b5so25888335ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748352778; x=1748957578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WG87KMRkQrRq2q8c460OVfDoM21mdAjMgk+63C+VnHU=;
        b=V7XCdpZh+t7asmi161tzvvy0xBk0+pVvlkq4U6khvySUWAFDq+f7w5cLZWGyGQfbmL
         CdRlPutpBlb9Z+ffGJ/nWmLC4GCyyA//xHNmFtXZzPnND3q/Ao0PAoOv/LW48Cl4nprU
         /VA86Jp57xC3epKPO43Sbpc+o3CeSO/cWjfHXG2FC4IbNn2eQ+MfO1MmqGMosPd6E5Iv
         G+ZhauhbOP8wE5OdIZVkKlYeGyU9XrL6dfjherjTJOQmHkh/gxThdo43kc1zhNbTg75g
         nhBJGntGt1zKXpK3TMObGp/pS2t1/PizzrGWZmHZ7G9PfwKEuFmfFp7MCT0sa1CLv8w0
         G1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352778; x=1748957578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WG87KMRkQrRq2q8c460OVfDoM21mdAjMgk+63C+VnHU=;
        b=D6Qzk7I6Rd0WCDWZwvvb4nYcXkQu316P8KYH/iYNUleqOCJaQ+bzvKwiqGFO+a2njX
         6JOQYZWyEZkIa84ye0LlNNVB2uZPuHsj0CPcCZtcsoyr+8Rv4XVn16Bre/RLE8B37nAK
         mq7LWhVBIAUHBM7Kiby31+IUq7cH+Rd0TiuCjGetTfl779BkG5bOkggBLuXPUkxc+dGs
         1HUbyN/jDFiEqbjPmM30f/flmXzg3LQuxEjnfYwsVuXGzqYSKvZsPtXKjWq8HqrlJL80
         9cN+uoQIhOxyLl7Tv/sPLNgF8WkoW2gyzEnDwbNuu78YFRhraeFklrRQZaSGARSmsaKP
         ds/Q==
X-Gm-Message-State: AOJu0YxXriRmGUtebXBhgJ4KMwcC7zDQVWRpABgCcll82p5xObbt/OWm
	N/pKUO0s0+gOV+/TCFDDoylO1p0TBR8UBNCWQTzwlS2PelurTo2ZvbQYhXJ3LtW9QDzoVPrjsB0
	wfasK
X-Gm-Gg: ASbGncvCR0uuXQ2VJ5vZz2ZLWOdKzmF5CKXieBzqFiu0QfT1KXWWcIERh2+UhvnoqWD
	G8knhYMClMojnRrpVUg9Ehigjzr2c0LH/9YvHIYuH5ThS7GOt+EhGlzO6Zd1GVQzRU+RH/zWUpR
	UOuZbYiHKIxvcLFYJcjEzWUvQg/ks2Gmwn19rjIQpnZCymIZz8r5p2R3ieuFIaZbu3lukRzdA53
	f62Jmk/MX4uUiJQllYV0hyrQBhzgoBT3wwto9bMElHsXV7tLdgPOiXURcnvSLQuN20pIddSQtei
	I2p52tK3d19rYsQH5WyEdcQZttxIMRjTEg3ceIVDZfVVe6e1CGOmQL93B55bDZDMGQ==
X-Google-Smtp-Source: AGHT+IEFPWdMCtvRjM/GocbW96jhJDI2wXrZmg0uizPuKNSIAFRagtKlnuDwuKcDC/EPbDI+EwAwgw==
X-Received: by 2002:a05:6e02:1847:b0:3dc:8b29:309d with SMTP id e9e14a558f8ab-3dc9b67fe52mr113934095ab.1.1748352778507;
        Tue, 27 May 2025 06:32:58 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8298d8a2sm37404315ab.18.2025.05.27.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:32:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	trondmy@hammerspace.com
Subject: [PATCHSET 0/5] dropbehind fixes and cleanups
Date: Tue, 27 May 2025 07:28:51 -0600
Message-ID: <20250527133255.452431-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

As per the thread here:

https://lore.kernel.org/linux-fsdevel/20250525083209.GS2023217@ZenIV/

there was an issue with the dropbehind support, and hence it got
reverted (effectively) for the 6.15 kernel release. The problem stems
from the fact that the folio can get redirtied and/or scheduled for
writeback after the initial dropbehind test, and before we have it
locked again for invalidation.

Patches 1+2 add a generic helper that both the read and write side can
use, and which checks for !dirty && !writeback before going ahead with
the invalidation. Patch 3 reverts the FOP_DONTCACHE disable, and patches
4 and 5 do a bit of cleanup work to further unify how the read and write
side handling works.

This can reasonably be considered a 2 part series, as 1-3 fix the issue
and could go to stable, while 4-5 just cleanup the code.

 include/linux/fs.h |  2 +-
 mm/filemap.c       | 39 ++++++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 16 deletions(-)

-- 
Jens Axboe


