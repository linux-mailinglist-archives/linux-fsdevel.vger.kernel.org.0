Return-Path: <linux-fsdevel+bounces-42390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A827A41712
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 09:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC131896DE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C724166E;
	Mon, 24 Feb 2025 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="lByyWHai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38624168E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384882; cv=none; b=Q3snvr2rrXZbYaVSP+gLPxUdlibN0pvDkGB/iipVKn8FuuN+flOuw2HzV8mWAqzVN2Zjgk5Ez4adl255tW8rIz13qbRSdpF/rnUa3y3pVO+RO2nZFhDDSvdJclti631a7IqIoXBZe3G8EOpUHtP8/TtApltkjcrhIj5E/yYuctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384882; c=relaxed/simple;
	bh=oe2FyQpDi+XexZe/0gZrbR4F62iNxsAIMF/U5rlF8BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DEmixxZwncDdm58nrLtNbVuEshlAoUoSDYzFXdcbMtA48YHguAPiLI/dAg9iUMqPXmdGtiRnpkooncM3S1vI9T5NwhEnl6yz2dxjn+mGLyWaqet8gVgppD9ZDOevasI1RDnZsHA9Baqa53NQm2qC8F7WBszV6mFVP+G7LW8r/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=lByyWHai; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221050f3f00so89041425ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 00:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740384880; x=1740989680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n59C1mxnlqsVZDv+OXEoyoWE/LCHOE1N8E2Z0O569dM=;
        b=lByyWHaiC+WiEErxkPqA0M74SH9tASd9NyfWsYUjzIW3LkBcvIvQ9YNU4DI9Y/D9nU
         uZMKgmGPDKmdkFhr/eQ2lwWZAcc3QnXEi+LGVrlEBIQG22pK7/EljwlDAp7b11FyA7FO
         S3uQCVxRCJ9Khpesug7glVI5morIO/PFaw2XFX46LUbhOR7LwfuEmAp3WbH1XmDdeQP1
         kK0BBWKO7QFWc88Kvc7e1J7GHww50mU5ISjiGz2vlzu6rgfNp610OC9xwHUxQGPX2Q9k
         mrf3Sgb9W1Ij1VCpOJAq6T9uEXk/XCHMd1MlHXgH8kfhDtkUTGQmbLoSZNmEc2Wu5ufE
         j22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384880; x=1740989680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n59C1mxnlqsVZDv+OXEoyoWE/LCHOE1N8E2Z0O569dM=;
        b=ZoPas2hvAxdgm/Dp1Fk4ybDIZb6rkGufEzJfv7SjIXzwjB39+qr6sAkA+b6Mmceycy
         C9FS4WYWRG5JtVg4NC8ugdwvdCWW4k10MXkb09QtSnloA3azCqpuaHKg9o+v3ocmI32K
         ovgxzJaDQJu2YqIZaNaH0kbR8RHmYXXFKEVAL61kPDfKM/CzAOQSCZHrxHcxP15GMJhI
         KDSaD2zoQX6peEXH8yClzF/qWVNbTlRirQgJKMmSRGcCfM54kwtLHyV/6UHq+pSimvPl
         zUzQDJNMbWbSak99yq9/R7pUdGe6yclzeeCvIjo8XxJhSV//bwUx7oljBU8n54mKzDl2
         gw2A==
X-Forwarded-Encrypted: i=1; AJvYcCXb0PxpFfAztPFlmgPATvu7OZryxXpxV8EFKiiA+OFxJL12CMDxeJ4RCltt54jj4D8yaad1wwInCZTXpH0m@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHmtX4/70U4v61Nbl0QdvnzsNnyTLry7keGMs5YRaMV6c/8uZ
	pPKbhQIoKrePS9w7E+zSzOpxJF524dUIhiBG30bt8DNXFhyUeE6FljoARY5T8ZBVKyKHVZSpBqA
	DW0lJGx+Xfx7PK5d7QEXYk5yQOqmah8oWmnoVfzTNWuuzicr4eTDNJogKIyjF6xWSrScr9utZX4
	KA7O/PC/UkFxuBhg5KGAuM0zoI4JQ01aXMOP5Xyi/lIYptBatfrirZ7SCknLn6eUaN2awCgEBLM
	xbhhKkGudQKzaImsaZ8VvrrU91k6Ble4TtzZK4xxIxYbuPgg1eex1dWMnhYOPS/L68DqEbMQQpR
	KwlSWmKV+CGfx5ZrVmk8YmQKFvUq2sOohGuSwqmdwlrYesfgpw==
X-Gm-Gg: ASbGncvqI0ZNEaZUWJpa+JhMd5d9kAkv2aRJszlphc5Fjg9IewPli+IubSO90lZZqjL
	905CnCRo/4y38ppjEXYbhwP4qHqsysGh/mQo/Zg2XCJ+WT+lAHa79La0Pp90YozBHOoTJAQ/8Ok
	AfKXDabC26vqLPSOGbFqLG01n+gX0k1vW6pgKXGdfJ4wZ8bUQWBFROPKbvS1o7wOtwtC1vQLc1Y
	EZyafeSIa53ab7ikJ+Fwtg6rgyemEq1ibIRfsj61sr5/9qxoFNwWSszWyeIZ7tNaDyYR/5sqqZ8
	e+E57l5H8VB8wDUEUjueNOP3WK3eFg==
X-Google-Smtp-Source: AGHT+IGZML+QeMBAJSjHG5iq0A0nDtnil2LVDOPQzKcK170nIopsu8yPUqb4/J1ur3vn2QrKyGEe6w==
X-Received: by 2002:a05:6a20:7f85:b0:1ee:d6ff:5acd with SMTP id adf61e73a8af0-1eef3c568e9mr25167734637.6.1740384880406;
        Mon, 24 Feb 2025 00:14:40 -0800 (PST)
Received: from localhost.localdomain ([2a09:bac5:7a2:24be::3a9:82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm10280324a12.51.2025.02.24.00.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:14:39 -0800 (PST)
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
To: linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>,
	hch@lst.de,
	willy@infradead.org,
	"Raphael S. Carvalho" <raphaelsc@scylladb.com>
Subject: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
Date: Mon, 24 Feb 2025 05:13:28 -0300
Message-ID: <20250224081328.18090-1-raphaelsc@scylladb.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

original report:
https://lore.kernel.org/all/CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com/T/

When doing buffered writes with FGP_NOWAIT, under memory pressure, the system
returned ENOMEM despite there being plenty of available memory, to be reclaimed
from page cache. The user space used io_uring interface, which in turn submits
I/O with FGP_NOWAIT (the fast path).

retsnoop pointed to iomap_get_folio:

00:34:16.180612 -> 00:34:16.180651 TID/PID 253786/253721
(reactor-1/combined_tests):

                    entry_SYSCALL_64_after_hwframe+0x76
                    do_syscall_64+0x82
                    __do_sys_io_uring_enter+0x265
                    io_submit_sqes+0x209
                    io_issue_sqe+0x5b
                    io_write+0xdd
                    xfs_file_buffered_write+0x84
                    iomap_file_buffered_write+0x1a6
    32us [-ENOMEM]  iomap_write_begin+0x408
iter=&{.inode=0xffff8c67aa031138,.len=4096,.flags=33,.iomap={.addr=0xffffffffffffffff,.length=4096,.type=1,.flags=3,.bdev=0x…
pos=0 len=4096 foliop=0xffffb32c296b7b80
!    4us [-ENOMEM]  iomap_get_folio
iter=&{.inode=0xffff8c67aa031138,.len=4096,.flags=33,.iomap={.addr=0xffffffffffffffff,.length=4096,.type=1,.flags=3,.bdev=0x…
pos=0 len=4096

This is likely a regression caused by 66dabbb65d67 ("mm: return an ERR_PTR
from __filemap_get_folio"), which moved error handling from
io_map_get_folio() to __filemap_get_folio(), but broke FGP_NOWAIT handling, so
ENOMEM is being escaped to user space. Had it correctly returned -EAGAIN with
NOWAIT, either io_uring or user space itself would be able to retry the
request.
It's not enough to patch io_uring since the iomap interface is the one
responsible for it, and pwritev2(RWF_NOWAIT) and AIO interfaces must return
the proper error too.

The patch was tested with scylladb test suite (its original reproducer), and
the tests all pass now when memory is pressured.

Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
Signed-off-by: Raphael S. Carvalho <raphaelsc@scylladb.com>
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..d7646e73f481 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1986,8 +1986,12 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		if (err == -EEXIST)
 			goto repeat;
-		if (err)
+		if (err) {
+			/* Prevents -ENOMEM from escaping to user space with FGP_NOWAIT */
+			if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
+				err = -EAGAIN;
 			return ERR_PTR(err);
+		}
 		/*
 		 * filemap_add_folio locks the page, and for mmap
 		 * we expect an unlocked page.
-- 
2.48.1


