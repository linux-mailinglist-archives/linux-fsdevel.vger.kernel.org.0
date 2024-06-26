Return-Path: <linux-fsdevel+bounces-22525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCF2918660
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EEC1C22176
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803A818E75D;
	Wed, 26 Jun 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ntiKi4gI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401C18E758
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417410; cv=none; b=UrTSLMZ0/BZGb1J8/ToG8dFxBo5pAKRXTZ1G1XM5ticrB1LRTdiNcK3eu07ecozGx7hJoPWE59/H/fkr112phkOVf4/fNi+cHIn5xFAQlCdoUp/e0yRPdAm7cJE1j5exkb9DLwKwM3UHryDLKXCCvDXtsdBg+94mTkRLh4XOWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417410; c=relaxed/simple;
	bh=dRmuUwdntKGZRs2g66Sht/s9k6ht1QwVqOYwO4aa7Nw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n+jUTQzpGMJIq4csE8F7ojM3yQU9Z4b5amCQ+3mNRsVtZnQh8iHCw7t4L0TxK8oLVFf3DCtsUYIE/kGzZ14YNuEBpYAorhed4haFMVejtLG98SD7kzENPVPqRXd7jNfmVndxntAjXBu+0Bp5TiKjlj0AS1FT4DOT8WBVI96ixBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ntiKi4gI; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4463b71d5b0so2199031cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719417408; x=1720022208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqtrRhJKCCtcDVtGOthUbHs3QGYwiUAnQ6hIsVz4c2I=;
        b=ntiKi4gIgKpeLC2CWmgBZWFdO6eok1Nk0TyKF4m0WRy9zsWZqf5djV0pvX8Yh9hzP1
         1nrnob45+Ew0Xe7AP9o19ek4aJjDITn212jqjd+mWsygYP0ur0Qz27nqQphsfD9JegM1
         /XNZGOXxZv6Nvd5jvVkqPKKMaYDJT0P1CY0zvfzUarKW7xe8382UE0n5Y9UhW+KeM8ja
         Ujmqu6iAVcW/YYLF8F5gvUcZb3JC7thAU3CwqaAb7aLlNmTZg3ijV8U6G947JLsfFc0Q
         pawp2hP4DziLrM/Y7wFCgVXz8Eh9VVurq3qyQKOqHjFDJ6Bj4dgf+F4KfJ3jED/Eavlb
         I2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719417408; x=1720022208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqtrRhJKCCtcDVtGOthUbHs3QGYwiUAnQ6hIsVz4c2I=;
        b=RczEbgmL/7R3Dqe2A2KEcWpa3gA0bbjcvDvRU4ZNE9ulRhOvGc4Oe6bSCJJjvZbx10
         ApcLwMgOv3S/OhIbZ8Np5qR1RzW3iS0+vjeV1o+EeWlQJIPcRKzE3v4JdBr1h6nHksrB
         c/OEsRoeXMN7zy9vah9QCRdNSR0x5Q7UFPOMfbkpep+wzDSrIiHaoYECPQdxfhTPEEwQ
         KIC+ZsDBBqmLYyZXHRQW/Neo+bmJozYUD7BiP3Ki7FbHktWNytmvCTBKRWJmadFCjwU9
         J8o8ReKJMefHTbYOWbhaf8rHm7KSezOW6urs/uLRx1Efp7V7VHBiMAnYSY/hwnyJgcOd
         F5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCV1BJTyB7DaGIhRHAXjL6D5639q/WpYOI5Gzg9jzyXZjBp7o8CUS9OUOUWV8bDecoynypzvgmuNj8xXKvcTJjVOibeLd+YFyaiezq4Oeg==
X-Gm-Message-State: AOJu0YzDSL8HptYdid2EpFlxTzKSFMesrBihPgbaX5fKIzNbuXQtxHWZ
	jPNqdpXJ4vPjbJY50j3bDYCysfCU4UFfqm5JQewbuEh3s9bEcU70/Y3cO05yT6c=
X-Google-Smtp-Source: AGHT+IEfzjTYlNIT4Oapcw0QXUvghcCOsOeLPr6suGKAWcbaL35dtyTTzr9HxyE7BQFzAlLV+Ki0XA==
X-Received: by 2002:a05:622a:607:b0:444:f9e0:9d90 with SMTP id d75a77b69052e-444f9e09fe5mr68138641cf.10.1719417408030;
        Wed, 26 Jun 2024 08:56:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4463871ec4asm3657001cf.23.2024.06.26.08.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:56:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v2 0/2] man-pages: add documentation for statmount/listmount
Date: Wed, 26 Jun 2024 11:56:06 -0400
Message-ID: <cover.1719417184.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V1: https://lore.kernel.org/linux-fsdevel/cover.1719341580.git.josef@toxicpanda.com/

v1->v2:
- Dropped the statx patch as Alejandro already took it (thanks!)
- Reworked everything to use semantic newlines
- Addressed all of the comments on the statmount.2 man page

I'm still unable to run anything other than make check, and if I do `make -t
lint-c-checkpatch` and then run make check lint build it fails almost
immediately on other unrelated things, so I think I'm too dumb to know how to
check these patches before I send them.  However I did my best to follow all of
the suggestions.  Thanks,

Josef

Josef Bacik (2):
  statmount.2: New page describing the statmount syscall
  listmount.2: New page describing the listmount syscall

 man/man2/listmount.2 | 114 +++++++++++++++++
 man/man2/statmount.2 | 289 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 403 insertions(+)
 create mode 100644 man/man2/listmount.2
 create mode 100644 man/man2/statmount.2

-- 
2.43.0


