Return-Path: <linux-fsdevel+bounces-67693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52CC47472
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 273E7348F36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B18313542;
	Mon, 10 Nov 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI+qUF/v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877D31280E
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785778; cv=none; b=q/Yk9MN72RvdYRG/psZmRKx7qiRXH98uyIM/RN7D7SWu7jhQ8X+j5oF5ztOFj5zdWE4JbICq5LqniBDxsSd6/8zKlPoPCXLlhD6q5iDdS5ZtavdvvncEKra8yP/2XPnsFAPcDS/H/ocaYYHMv1WJ40hexCSq1xmFThA4mA9lPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785778; c=relaxed/simple;
	bh=YYJDGhYEE+IE3sRD8B2vXjob2uf0ya/UBo8KW6w42aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEGlmR11e7H5lGAgTFtFaOB2gl9AcmpHUNCqwNM8F7CldfW5o3IMSj1gb3RS3S8beSBswuxD498sLTrh3n7+b2KRLXNnZrpAhRjfTrkaIZCfvtDj08kvACqCjzLkSt4Ztq+3BY1oNaLv+u4aodsAB/vIbMKnk06kXAFlsLrearg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI+qUF/v; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340c2dfc1daso492446a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762785776; x=1763390576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNzjHQ+WrDJMGz6phMHSxuZiXquRr8z8joipRN7J12Y=;
        b=gI+qUF/vJOGu8cgQAHAdvr0MQUCq8PSqAnUdMHgj4YNxP01V/pBIgU1RtZNYx98+tp
         s0ZBcbZ8G+CwftNj3/XToPhfTd/xvO4YrhWNqKuz/YSXWV22owFCdYhoQwpeQ319AKsH
         xi0cSUYZTeNsZOO+BF44Os5IxeHFLRpqoJmHuN2pufk7Ed4o1lur9js/6B/4lyJK9zNF
         2Min407wl+whzzON7bwlCAyQkBJlKkH9P0Sn3rra1tzJs1alq4q2v9oIMlYh33PyAP1P
         T1qR4gFn7f78UpzdsSzvtepOZ5nLy/NeocFDepx/WSKtVqeeT9CX8Q980phUPfQJKOUz
         pHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785776; x=1763390576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNzjHQ+WrDJMGz6phMHSxuZiXquRr8z8joipRN7J12Y=;
        b=g6y2BXUNf3WThul83W2a0JH0WDnncs3jR8YTQS7Rdjg9FoPNPTxW1uT35QdXr0usk1
         FD5otJsjL38cl81mnBzFNw3yGab7IJBteqS7qSPLmFt8A83rtA3eiSnxrrNwe5WAiJnD
         e3ABwUW/4l+MxZTOvkjcfn6pso3fHDLealpS/00tNLkwS3lGbk1C4/GyD0GSubWQIqLT
         oaxeebTpYzelW6J4MmXh4M8btYN/DzA0fAMs1mOR4/dFe6UvjVSATs6IFPVwFIqpqktj
         gylMqS8vTgB7h/V0jZg/rPxIsF0ljF4LU/5c2j02pm19R2a25nS9lcsUI2yAC5uS1rsy
         rIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPk4P03U4SpXqfLDFzL07/DaqO8M/al0CZl9c98ng/V5Q0E697Yv0rYgtTadVBYyh9dqY2JBTdUfRxStjo@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJkBU6oaKvwmXpg+r9noCT9kMUQsZL/mfOs5yV9ymHyjHXokJ
	/+MvAensVZOzjFIbuX0M0eMLIAxYrPJRl0FMji3Ztj4XqbWzIAR1SloC
X-Gm-Gg: ASbGnctfVecAUwa3SzYNFvqjR1D/lLN2xpazLGlKa1aiXszn94r40Gdx6WlZsJZAPIw
	rRXf1FwlrWO6nbTykeaek0uidGapmSmZwwIQ2hfmG7elF6ACwgHbC7X0duw9RnXoRRwU64sJ42+
	0v2By9kWgePpsVYnbQW+30W0DdkSwU4dA1J1E6MsqWI3SkyYWDRTDCJBIVyNSCmoacoosWaMmDi
	X5ZPsJ1DNkDywkePnvmAuNqo3xyL68FcRpM7XRv3+OrOyZBOsPDXiryickEXJwXWC3tmlqVPaYP
	PD5OYYjzAnTs0bLfB5eS4cN3Dz3snQn+di2RaYrKo53dfxGF4p0Jy3roPfwTr9V4HxK5Q5/SoTQ
	NVL65JVsVAKdFeu2t2lvtzWki4VbX4Jy6HGxlt5YI6nnrlCaaLeIi2vFA6LLq7+smR3M5H2pUPc
	bn93b6NjW8FPuT0RrPYS+gRNSLOc6O
X-Google-Smtp-Source: AGHT+IFLIvfvzBAOLg54kuvXq8pVBAwIGNRWPiBHJBuAsnmvQ5Ms9Se5CcOXXisu3gJm6vu1H+yXVg==
X-Received: by 2002:a17:90b:1b44:b0:340:aa74:c2a6 with SMTP id 98e67ed59e1d1-3436cbbec71mr5653917a91.6.1762785776489;
        Mon, 10 Nov 2025 06:42:56 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343abec3836sm2163308a91.18.2025.11.10.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:42:56 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Jesper Juhl <jesperjuhl76@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH v2 0/2] uapi/samples: guard renameat2 flag macros
Date: Mon, 10 Nov 2025 23:42:30 +0900
Message-ID: <20251110144232.3765169-1-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including `<linux/fcntl.h>` after libc headers leaves the renameat2 flag
macros stuck with libc's values, and our sample code in turn redefines
them when it includes the uapi header.  This little series makes the
uapi header resilient to prior definitions and ensures the sample drops
any libc remnants before pulling in the kernel constants.

Changes since v1 (based on feedback from David Laight):
- uapi change now checks the macro values and undefines mismatches
- sample code always undefines the macros up front and documents why

Link: https://lore.kernel.org/all/20251109071304.2415982-1-nogunix@gmail.com/

Masaharu Noguchi (2):
  uapi: fcntl: guard AT_RENAME_* aliases
  samples: vfs: avoid libc AT_RENAME_* redefinitions

 include/uapi/linux/fcntl.h | 15 ++++++++++++++-
 samples/vfs/test-statx.c   |  9 +++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)


base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.51.1

