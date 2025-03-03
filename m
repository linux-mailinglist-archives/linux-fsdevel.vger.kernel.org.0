Return-Path: <linux-fsdevel+bounces-42924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1F8A4BBA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 11:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBD01892F9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC3B1F1818;
	Mon,  3 Mar 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="isXIj482"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E81E570E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996385; cv=none; b=SweVcr+2XWU2LbAXlB/gS6E8yoIHEB7vN8tMMCl3xZeRXWe4L92MW0b/qd6GfBwrn/T9VfvimqzO7O1eJllQo6mKLXOPQXvsRXXekva2yYEks7O7s3TIINJEU1gPqEPdsp6qONyyaDlLxyy5afDxfZglqgxbKDD2h5M7+CpN34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996385; c=relaxed/simple;
	bh=ryNGzalrzD3yX/2mks/XBFD5n9Vg95McjnPEOR5SisE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dl7Qm2PQpwy+bbvHW8BXQx7hPP2wLX2qimz5xkpVBBwc1OoutoPk6BcrTiTrJBaSfK8Aj9t4122uLG3JnCLN0uaJLY9ssGO6uI8LrSHOo7ZP8XNnhLyog0o+OnArtstb/LbVqtqm2QY1WYJACP/D7rvOB4RJNmadHbUS7L/BW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=isXIj482; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2235908a30aso55315845ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 02:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1740996384; x=1741601184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2xvnbw0JuGYZ3kMUPAj9qebO9ot86k6LgdKqU+QHZM=;
        b=isXIj482IUNa3GnhIwZTd95MvDzCI0mSIjaXet8n36kTNkUp7DCuv7i0T7Js9p4F9x
         r7vNnVx95BAmNWQ28tY5Uhw1PtdUJfJT+375bENLF9TaCVj/AmfNbpSrwD6gvCQzpbqV
         nHeliuOyzA3VcZUHFBUccRjuLhdqz6AMT9qQwzo4j0oV6p1+HqsOSx/RdIDLBIM0sV3r
         bQ/JmZD/zyeiC0NEOln+eQ/QG9hK2EqL78z6k3YqIAW3arkrL8ML4GhtWY10trZfgBEG
         Zul27zfcFx/TZYpmQOVasePvoT8BX2VvefyBCfVMAAJwAwr0GTrrKrVhbUCuQQHPLRed
         AYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996384; x=1741601184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2xvnbw0JuGYZ3kMUPAj9qebO9ot86k6LgdKqU+QHZM=;
        b=sQeW81LR99ikzMKonGcaX2iJnXCiys4n7wkg/v6+SNPOWUa3WsNNkmGzSgJWY6JZjE
         6vkKb4nzY/DM14iC8bY06LI6b87a9E6wJF0KhSNSMuvq0rLph9It64Xq8ZAZ/WT30Ldd
         rdOrwwBP6YCjdxnSNgRCMlckzGfF/XqM3upUskFeAXDFr48k80vg6b5cBkgMj1gEghCk
         bE09jRaarJOOEVDR962yvzKQjYcXfkrQ+QYm3cEIWBAtooLRwLQU+ML/ypkntQSqqsGH
         MKg+W04PlVpgzN+jIrcIFGPdc/SLhTGYCXqwtdUu9WuAePcfUfBGm97jaKi4hSxqhTHg
         jKyw==
X-Forwarded-Encrypted: i=1; AJvYcCVtZQqjzIBK+fAqLFAtwYUQ5hwBn4gRgnS5zr2JIOUWiXEwNbAevZ906LOXgB6ee00wDTMI4q3oJn7bnyDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFu/6yeGggirI8St9vlijv2L6SZ2Uc8vCIhYqSECzOW/XhP8e
	J+gQbAHA3v/KfwwWAFT2U8p0Ck7KVTGu7fmY1YdTQgQz4LZy+DLzOPJlwhe6rfYYQAZkQ8BEdW6
	2
X-Gm-Gg: ASbGncuTwQTul8NkyYGEXjn32U8vnF0VBzxRlo1ss4BAML39mUEPNLU26SilNRYpeea
	XGOP14RxI4bNhXbdkVR5HWn89zYccwm0LtkIXFeSp717TunCutlJ20CBlQhoSC4krlxEQp4/aP0
	RsGvdtASOw4vo8O8rfOXnWJvuCMHPzNHk3f2s7MKgZHjGKM41oCE8hU6QE6sREqvBsKjPBD782o
	vTCpfkg6FnUbh6+WA/Gno7ipauS3xqT/RW+zUVhsuJegtgTBXnkGnKhmsbxIKJVLP9qW8sdNzD8
	Pn55Js0MxTVxiYmk/iRfjgjq0xFWUA==
X-Google-Smtp-Source: AGHT+IHEynmWuf/VC/tNMisellPQ0994Vlxa4c8xxDyclOEyECs3a2rUWIXx0layqxHXPQw7tF9mhw==
X-Received: by 2002:a17:903:2ca:b0:216:725c:a12c with SMTP id d9443c01a7336-22368f612dbmr196639065ad.9.1740996383883;
        Mon, 03 Mar 2025 02:06:23 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350537b47sm74397275ad.251.2025.03.03.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:06:22 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	jack@suse.cz,
	brauner@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH RESEND 0/2] Fix calculations in trace_balance_dirty_pages() for cgwb
Date: Mon,  3 Mar 2025 18:06:15 +0800
Message-Id: <20250303100617.223677-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In my experiment, I found that the output of trace_balance_dirty_pages()
in the cgroup writeback scenario was strange because
trace_balance_dirty_pages() always uses global_wb_domain.dirty_limit for
related calculations instead of the dirty_limit of the corresponding
memcg's wb_domain.

The basic idea of the fix is to store the hard dirty limit value computed
in wb_position_ratio() into struct dirty_throttle_control and use it for
calculations in trace_balance_dirty_pages().

Tang Yizhou (2):
  writeback: Let trace_balance_dirty_pages() take struct dtc as
    parameter
  writeback: Fix calculations in trace_balance_dirty_pages() for cgwb

 include/linux/writeback.h        | 24 +++++++++++++++++++++
 include/trace/events/writeback.h | 33 ++++++++++++----------------
 mm/page-writeback.c              | 37 +++-----------------------------
 3 files changed, 41 insertions(+), 53 deletions(-)

-- 
2.25.1


