Return-Path: <linux-fsdevel+bounces-50880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C7AD0A60
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A4E1895E32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E4F23F40D;
	Fri,  6 Jun 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flnoSdqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E223E35E;
	Fri,  6 Jun 2025 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253372; cv=none; b=gv/tmWn3QK5wUqDqnzEbIWYHNPyGIMaiCnCmoHvJVcp4ddO5MAqatAJhl5Gci8OU0p63i9VsZL6lCisOhHWTjyqMkjdWupz90bbhcSYmmkdz1Ws0secBlf5/6n1QPfU5ZpeHirYJ01GMojeOgA0wGwbnbQKwCvjIeeOVNfaUzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253372; c=relaxed/simple;
	bh=sIj7lyJv3B3YDEKC037wMg/HlXAB/T7ASc9qRIB4lp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrfSxMQ3UZIglycI6Jsw02Jg8qYLsDbUmCZ9qHtoyfXNouJkpvWj84qQVUclodhvHMfPBlOD99i5rLToh53bHVXmNRVH+NJJUDpDaBCCZAw3tEoPb+Psmi+lw/IM+KW5rjmS8GSTBdyICZLlhfD0+Wyeo2iqB4+fvdnmxzsqWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flnoSdqb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so2693035a91.0;
        Fri, 06 Jun 2025 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253370; x=1749858170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iTmzq+eATZiTVTcLM4VB4ir7DnL00WJko9zPHYM3A4=;
        b=flnoSdqb933eV1uJ9DTv2EASwHfHmLBvkIGqP3plJy+jiVK14pTrTjSOpuJgC97RYb
         ar4+6QAlpNSTEfqqBYjwrxuWoq6RcWt/uy9+YiU990VB5/rNHA5ojEG+y9b6KRNRp4V3
         cgP0Th8sEH9w2J5eOKDFsVn0HfvH1Yvx2hNzQo7rfK+Gb9OXn8kzQVz9uWyZ3czPA/QA
         qC2HlsaaWXqBABylzZnnIpyeKmnDxdlZCh/aipyU7LFs1iH23WAdpMDCrqmDsGC073rc
         zDRwulVPBw2zShoiQ5V0oU8ddjWPLGuRlrVYOWg3oE22WiO1SZ5U/uj0ZyjkhSyTdOJk
         mbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253370; x=1749858170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iTmzq+eATZiTVTcLM4VB4ir7DnL00WJko9zPHYM3A4=;
        b=t3bsFBv/7WXEYWsTwqeOPzGpRl1DFBRRcOrVtHx18qN89823DrqNGnIPWwXo9X6fGK
         OxiWTYiwqgT0eo4a0/DsuspmEyn7aMvqCMbxn/zkYewJHbNppeSRdgbLsL8ffuLu3Uiu
         qWNZtUxqtdvpYZ4d9ELSwAicvQcB+fd6p4UNlONoH8W6tyuzYB52eODhC1XIs0xBHM6I
         K2KYJ/aVhO3X8bjctUGY8K1FqaN1xc1E/iI4XP2FzPfOFfkzkEFA9H7nUhvVOXx+Ie/j
         9+TypPSJXWxUOlYGel87VYWBoR6+h/w9mjCPzvrSsOwZY+g7WHPQVxWnUnBGJYBuUVtO
         WwgA==
X-Forwarded-Encrypted: i=1; AJvYcCW4kdViY8Z1hRQ7uV1QCiOgoVC83NaPVR3jrDJuZoDCkl6Pu6ram8aeJ0r1w5LsNQoxw+lmn6P/nBwu@vger.kernel.org, AJvYcCX4hdFU2UZqBrDoaSmiaxqjcEapMs9U5dai4KSWAiZetJEjaLKzjDH4dqopXf8uyrNcH6tzjvm5SLrMsBk2@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/ayHSQsxCYp5JgjqHA/JzqTm3AO8n6HgTwm+W5ajTd8SCzxM
	+eSoPIdgkCdpN+UZNQJmn3cbxe4fhL36s0qdXnMbH9LsT0Gd5C2WEMfQRy4m1Q==
X-Gm-Gg: ASbGncuQSvzx2vRz81iUpMPfdAlKUiOk6BaliNA9LxqVUEjn/YbD8cZqpYB9fN6P5TP
	PSmCN71v5zdMUajSpHm8vEgh6wdlA2MSoWQOZ7ySWYyQkFiC9ryoiWiUDE/2jYKa/ICGgvMozwC
	9OPJCLRlH8mclo7G/yyAWMFWUNm5bSR6+UD8iPr9eV0K0aol5xdMrGFTSHtuzsqBQU9DFdowDKe
	oeh7GQ2PYZyBFpPheHsausMTypH9MUUlcFSOyxtFR1ijtF4EapamlMn3H898tX64TooFx1UzZY3
	Fx8EPhMc1rfVb7RXVfLis6UTIy1UwRH5tEOxKnX3XeFMrwydO4iFLKEi4g==
X-Google-Smtp-Source: AGHT+IE4kIqqxPK2Aknn4jWGVu5MtdnJT1C0Sq1+4yj+IrJSnB563XpqsS81uQV/FswKeNPPU8Gd9w==
X-Received: by 2002:a17:90b:2705:b0:311:a5ab:3d47 with SMTP id 98e67ed59e1d1-31349f2d7abmr7504677a91.1.1749253370247;
        Fri, 06 Jun 2025 16:42:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc731sm17656275ad.95.2025.06.06.16.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:49 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Date: Fri,  6 Jun 2025 16:37:57 -0700
Message-ID: <20250606233803.1421259-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new iomap type, IOMAP_IN_MEM, that represents data that resides in
memory and does not map to or depend on the block layer and is not
embedded inline in an inode. This will be used for example by filesystems
such as FUSE where the data is in memory or needs to be fetched from a
server and is not coupled with the block layer. This lets these
filesystems use some of the internal features in iomaps such as
granular dirty tracking for large folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/iomap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 68416b135151..dbbf217eb03f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -30,6 +30,7 @@ struct vm_fault;
 #define IOMAP_MAPPED	2	/* blocks allocated at @addr */
 #define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
 #define IOMAP_INLINE	4	/* data inline in the inode */
+#define IOMAP_IN_MEM	5       /* data in memory, does not map to blocks */
 
 /*
  * Flags reported by the file system from iomap_begin:
-- 
2.47.1


