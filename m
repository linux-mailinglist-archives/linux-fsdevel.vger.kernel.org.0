Return-Path: <linux-fsdevel+bounces-25450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E468A94C505
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5412DB20AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F51487DF;
	Thu,  8 Aug 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1HDE2Hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C893398E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143776; cv=none; b=tDLfu9aU21QcoVc9YdOdw+SPvfVgfeujsaP3Ve1VxGE6qrXgvahg3x+tVoOzIoEv5KpRf3EIbRw9ZdiAVlwYxappIuZa8MUDVcPqQ2hgYwbJYqSG5oiKCoMtHxb/X5V8N+kffBAhP5l/B1AIYi7PTpgXAmKjZKLEkdpvH8lU9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143776; c=relaxed/simple;
	bh=q9RYaDrZLKqkC2rUVIGdDxk9ghQE7O7/Jbbnh/Aydqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZW3yXbwZ/HAZzITlpMUuQZzHqNcThAKkZc4I/oTTtUYjS7hN/pww0w2R8od8kkWz3nw3BHaC8tzODrhzTkxs+kZ37eBTii8OAuOTlzwh0QFRpea02Y5W+jimUXUWI5mQ1X8Dxi0Uk18Y1Z5H9EzCvCmtv8QwZNrd8S9Ywa+jjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1HDE2Hh; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66526e430e0so12278457b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723143773; x=1723748573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i09jCuNAfDb1iOrnIct8vBIBCFNvRPAXPNqXHWgGcd0=;
        b=V1HDE2Hhjl15PTjbDgkXpZtMupeNHnVkUF/jDf7yf8HPkfoLxX2cbmIgOt9IUAlne/
         lgG1j4g20U5Pi/O+mDLJ7Y/6jxLXkV8F1M3t59uQpgW9HvNbvjbCcPoNGluetwc4hQxO
         qxfZgB8uPqIcuzXCYajlHUJt5SLlzysDX6DSxYsADWV9dUdWRxXgC7OEIUZfOYPb6hrl
         zx8EvBmXHY/ztROvYpKZZ49Y7eW824IClAENHFWfsGU0aMVwyZkNY2xatu20LVyisIT8
         cgtYZMhQFadJYPD08Fi0169ZHNiRLZYHZ6jj7qX0TY8cvCRcplb+HqfLySWYttqZ73rp
         tjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143773; x=1723748573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i09jCuNAfDb1iOrnIct8vBIBCFNvRPAXPNqXHWgGcd0=;
        b=jVuvTK1da+DvyH9FToHs8BWUZs5hR1su8webX6NsMiYY/FdVAzgvuidCfBFhI9il07
         kYY3/nHj+zT8RQ2/Ax0CXICF1kWaCzjkYRUQiRW0+8ENk4f2M1OtFP4OBst1CmP1qtUU
         dFQZoIC21nWY+JeaGti405xa8C7AaIL3ELT5jpydjgw0bETJeI5S0WZdCDFoi30At++e
         /3GBKBbYG6/+yhan/3HGEx++cfzXy1CMsj2E6CfvZAUxrs5BthGvrMrBsrfc2HkBJ3gU
         0miJgeVQxQmp+2kj5uoh3fHyaESMkVirYQXzIJ+l5v6ldxgdkzbhvR+M7GxeI5cSZ34R
         e9eA==
X-Forwarded-Encrypted: i=1; AJvYcCWQM7Khs9s0k+2gwsw1D74c6xnvonE+vGaAjR+c1LI8O8x49VRMcafK/87BrUnBc5OE3K1UYbqP6y/C6Rm5czDE43o9oo4BjcFtGdhpYQ==
X-Gm-Message-State: AOJu0YziQ3u+wND/HrlPgdnjWjfJPxF0Xjo6SzudB9N3nPGnSdPhB8fF
	ixI6wntT+KrDOLT096fa6Tq4CRNFsTfmfrqKCtFd07GiD3xDU3Lq
X-Google-Smtp-Source: AGHT+IGAFNVFpKXPNcQWlHKr5L/Y20wzzQ9SELPUQggquloVQGDKFO0ZbkdaWWSXteFXWDwv4Fu4+A==
X-Received: by 2002:a05:690c:480d:b0:64a:4161:4f91 with SMTP id 00721157ae682-69bf7ff1bafmr28569197b3.14.1723143773459;
        Thu, 08 Aug 2024 12:02:53 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b4b2csm24174797b3.132.2024.08.08.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:02:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v3 0/2] fuse: add timeout option for requests
Date: Thu,  8 Aug 2024 12:01:08 -0700
Message-ID: <20240808190110.3188039-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or take
too long to reply to a request. Currently there is no upper bound on
how long a request may take, which may be frustrating to users who get
stuck waiting for a request to complete.

This patchset adds a timeout option for requests and two dynamically
configurable fuse sysctls "default_request_timeout" and "max_request_timeout"
for controlling/enforcing timeout behavior system-wide.

Existing fuse servers will not be affected unless they explicitly opt into the
timeout.

v2: https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoong@gmail.com/
Changes from v2:
- Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
- Disarm timer in error handling for fatal interrupt (Yafang)
- Clean up do_fuse_request_end (Jingbo)
- Add timer for notify retrieve requests 
- Fix kernel test robot errors for #define no-op functions

v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
Changes from v1:
- Add timeout for background requests
- Handle resend race condition
- Add sysctls


Joanne Koong (2):
  fuse: add optional kernel-enforced timeout for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst |  17 ++
 fs/fuse/Makefile                        |   2 +-
 fs/fuse/dev.c                           | 197 +++++++++++++++++++++++-
 fs/fuse/fuse_i.h                        |  30 ++++
 fs/fuse/inode.c                         |  24 +++
 fs/fuse/sysctl.c                        |  42 +++++
 6 files changed, 303 insertions(+), 9 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

-- 
2.43.5


