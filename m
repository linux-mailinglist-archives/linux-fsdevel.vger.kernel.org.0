Return-Path: <linux-fsdevel+bounces-76769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFA5IHh8imk4LAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:31:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD95B1159FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40F3E301DBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D81F37D3;
	Tue, 10 Feb 2026 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPfyplyr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A5916F0FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683500; cv=none; b=E2TwkmLYcvmIuJyHBzhyfk9txFVu2YFpEsaVJMZHe9ll6lq8qFZWAKpe7NT24wWntyOeVI1fabr66uZF8aoBqBzuopLlLkSQVi3uZ6j7bwAVu9FcsOwyPtiSJJ4z6PfNeuKDXQmVxuAbYPUKUERQRXcfnryOJvDLA8FvFFjg3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683500; c=relaxed/simple;
	bh=0rnW1e3mgUZ3/RiF61ly1xawFx9g0UsBaYdm29750JM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qi+tAGUV5YSERGBrcuHAjXrzWMW0Yp+J1Rau69aTl8ngsN91yYogRmc+VK57+xJB76MXDjWUMDkqRF1faKo+p1aKqwOk938EbzkDOkySvdPeVtv/YnBhT1KgcQPWYAx9oAo5RqIwF+vTiv8nd5ddU9/5sNOtLOyvgcLaNlKqV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPfyplyr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a9042df9a2so18843855ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683499; x=1771288299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef6vu232B3wAWTpryVQF4g7jkfTjdk2p/VIFGFi0HDE=;
        b=fPfyplyr9R9jM1E/UdnHc8jT5lYKLF6AQCoytiZ7lRqbFObiYWYeQcRzi+0cYqSeYD
         W1wgKb0s4QR7PX7cnvGszhkbY6c3P28IsG6lhzp7yMgIkHaGGGv8jVvKtV0ddV2lldyq
         EJOYOWGnS8Gdkda09w5wc4ODC+IRY4UnCwAO6AhRi8Z6DuiPEX1b4LirjwQ7cNJRPwlq
         eTl4qzbn9xPCY20ViyOFQsPe/je+yUWTTMswIzfeoQcdCDBQjTHzgUe5f/Lt5glPkpHV
         NSfAsIDayYHC3wlUm3VKya8RK30yD6AonwhFKbSU5+3HCAnpH8tJo8NTiHHCzKNLwn5L
         TdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683499; x=1771288299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef6vu232B3wAWTpryVQF4g7jkfTjdk2p/VIFGFi0HDE=;
        b=UYfbhPVMFSb0OwuF+KMPIoHXS320mDHfVzU33wF3i6dWqNJh70gDmCgxYIlqd+Jv4y
         Za2HJWhAVRSGZnRtV1DGRWmz5Dw076WJPV8s37xd3jzBVQmOOJ0G4nyK/MRRtv+ZQCtl
         PxFyplG/Sf6VL7f9g+vu1knotslL18Aub7vsM8aZT4z5FGG5M8SGYpAH9Rkpq0YpfZpq
         7xcznYzoEC0DUdd4GZoOasrM1KiM86Rb/YwL0nFMR4OSlrqy+nTNVZMXFUBcANDd8UdS
         wDhozQQlU7XvsBKsT/0Gw3I0B5hSjDuDWNlqA/CQMBEdiLQB2EaQA0UwiXydjRRkv7/H
         ozGA==
X-Forwarded-Encrypted: i=1; AJvYcCVhR6jANVD8wagsPMsmzSdCbBnqrSmXRa/PsGw4w7zDzAWhweyslcpu1tIrtJcHQAeI8KucXva50oiOCU9Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxPokFI+HRWyHj8tgzb3Auaz0R84zPVRH0NN4Cf1lbPXMSZ5K3M
	lzhX0FRovDFhp0wZZv/GCxzJu6WwPkUyLPP45V4K2YUdraZQMRv5o59P
X-Gm-Gg: AZuq6aJa9rWuQvWjyJMRwQcgVvrElzGXAZOdsPQ1tTR/uYIGzZV6EVzOHKEFJc7Wf5G
	XcFJDYggK8bJOybgfDp2Zk6fK2zxuRKf3saQ4Qzep2J8ttWWN5BbBInyvmK/646hx3GRp004ldm
	tXuCsL7ZUuczvvCUzwV3nvhFc0sUhBZqMxghbWbekVLO1P0oeweJ9x0VWXBLDGZn7KqHe1ylWxr
	loJb0a72C7KCfbsViVG8RCqX9Jw9K92zi8fj6konpE3YivWL0D2uED1exvwZlfp1eF9J+LcTj3+
	NiHh1JYVS88RBbrfPnPEel3P3ueZ06ZeWSoG4kE6NYK2MBbxZcnQ+GoS8x4FhEJ/tRd9qTqwphn
	njHhYR8r2iyaB4nRMUthi84QYEPdaLmrMRse3FZ4fY1SEegy65USLbtbhBflvdKGRUkNtFM4Zkd
	k4CJIwyg==
X-Received: by 2002:a17:902:e5d2:b0:2aa:e568:164a with SMTP id d9443c01a7336-2aae5681896mr61730145ad.31.1770683499001;
        Mon, 09 Feb 2026 16:31:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c4d8dcsm122652175ad.9.2026.02.09.16.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:31:38 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	io-uring@vger.kernel.org
Cc: csander@purestorage.com,
	krisman@suse.de,
	bernd@bsbernd.com,
	hch@infradead.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 00/11] io_uring: add kernel-managed buffer rings
Date: Mon,  9 Feb 2026 16:28:41 -0800
Message-ID: <20260210002852.1394504-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76769-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD95B1159FD
X-Rspamd-Action: no action

Currently, io_uring buffer rings require the application to allocate and
manage the backing buffers. This series introduces kernel-managed buffer
rings, where the kernel allocates and manages the buffers on behalf of
the application.

This is split out from the fuse over io_uring series in [1], which needs the
kernel to own and manage buffers shared between the fuse server and the
kernel.

This series is on top of the for-next branch in Jens' io-uring tree. The
corresponding liburing changes are in [2] and will be submitted after the
changes in this patchset are accepted.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260116233044.1532965-1-joannelkoong@gmail.com/
[2] https://github.com/joannekoong/liburing/tree/kmbuf

Changelog
---------
Changes since [1]:
* add "if (bl)" check for recycling API (Bernd)
* check mul overflow, use GFP_USER, use PTR as return type (Christoph)
* fix bl->ring leak (me)

Joanne Koong (11):
  io_uring/kbuf: refactor io_register_pbuf_ring() logic into generic
    helpers
  io_uring/kbuf: rename io_unregister_pbuf_ring() to
    io_unregister_buf_ring()
  io_uring/kbuf: add support for kernel-managed buffer rings
  io_uring/kbuf: add mmap support for kernel-managed buffer rings
  io_uring/kbuf: support kernel-managed buffer rings in buffer selection
  io_uring/kbuf: add buffer ring pinning/unpinning
  io_uring/kbuf: add recycling for kernel managed buffer rings
  io_uring/kbuf: add io_uring_is_kmbuf_ring()
  io_uring/kbuf: export io_ring_buffer_select()
  io_uring/kbuf: return buffer id in buffer selection
  io_uring/cmd: set selected buffer index in __io_uring_cmd_done()

 include/linux/io_uring/cmd.h   |  53 ++++-
 include/linux/io_uring_types.h |  10 +-
 include/uapi/linux/io_uring.h  |  17 +-
 io_uring/kbuf.c                | 365 +++++++++++++++++++++++++++------
 io_uring/kbuf.h                |  19 +-
 io_uring/memmap.c              | 116 ++++++++++-
 io_uring/memmap.h              |   4 +
 io_uring/register.c            |   9 +-
 io_uring/uring_cmd.c           |   6 +-
 9 files changed, 526 insertions(+), 73 deletions(-)

-- 
2.47.3


