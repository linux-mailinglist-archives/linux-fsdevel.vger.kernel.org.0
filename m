Return-Path: <linux-fsdevel+bounces-71277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BBBCBC4A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC4D300E16E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDA924677D;
	Mon, 15 Dec 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6dR8qBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101D3FFD
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765767916; cv=none; b=al5WFQB0NC3dp5PnzueQr8RYt6dpNTdnqU9TJ5AZrmU+Hp6o6Pcd7In6IKQGE/yjmC4d1xNevUcYyD8hXPpGWZDHS4tWQkCZ4MarnQET0BF5II+6bcoFkZXq14W4r6QZJ9VAsFRUcEcpQ/4MLNUCj8PnhWWoLY1N0WHdGqIh0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765767916; c=relaxed/simple;
	bh=g8FVms4VncapiBHywfgsts5vQa+1lh2OyHkG+GRkKr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RRgfCPASJ3K5XDHkdR6bCtc0lNMSptVHew1Mrl0ShXpmSr04HNi6Bs1oTIRpqd/ZhzLI38m76BywMNHnCw/XZafIgQA0p35M+5j4WFJHgShvAlxu1Sd2goy8f7Fp/s03BUM0ZmirHn/wCmXeSAW/pOwWxN1PKLx+FseDvIDZo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6dR8qBy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so2351502b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765767915; x=1766372715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zXXpU/9CotrtWEEiG98xKEab5CXEiDdNLNXM5TNCU28=;
        b=c6dR8qByAH0ibKyWiZuKlWy7QATnlpejXRSURuAlOcncMm+I6H9cJZ+SpWGh0vEPTZ
         jn4T0Xr8uU13MHJpEyUIMmc5kzRyqsIXwoat8R4CN2YdiylSCaknJYHp/purm78ZciMa
         JHSffZ8wQeV9Jbt5lCwdHG913HZX02RGgrnMtpNF6BLQYKuJ7sbffWn8FtZijjVYsp1U
         4A707KrXDzQwgzfKx2bRAf94lEopi/rutB6yk25nvovoB+9ivHbfm+JH+X+HV3yIYJSF
         uT33FrREVV8nfS9dYszpXhkuZ288ipwtKoh6m9dhTYYJTUmEcJrkX1Z9v+ai2UARiIMT
         wcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765767915; x=1766372715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXXpU/9CotrtWEEiG98xKEab5CXEiDdNLNXM5TNCU28=;
        b=AxnDNF/8PNj+PcOiiogybfq5Drf3HIgP2tfq+OYBsd9VvwEvfHUs59MqM8VBKWypiE
         VqyJF8hmIcSCH1jJ3/ElZSRnabXaBrqUnyQWtkgDOgdUX4cmR84NjHcd5/tP2I4wpcG/
         cN0Jlxo5SLAlQSmyW4K4MB7W3/gPGcsy+nCkQyijZYSDUqCmb0SwfbB7YVZoKE+FdTFt
         DRMTT3tIjdDCG552HAmkiuzRi9lnydoecVHgtOlJY8U99sPCU1AQ3P1n+iu0FIxVBdvP
         kD5Ku1XzIxR98yKqSai9ajIa5zX2AxshZR9sBPeeg/elnHOqgyheWoNFyuoyXwWu9pls
         M11w==
X-Forwarded-Encrypted: i=1; AJvYcCVy4DIKsh5jUKqipcwIGVHkNmjdkWFWWXSeweuqUc0uGDr+1QdrsXglc5Njsjcy23j1JcCXUGBy0NE4hnU/@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZWeYRX3DBLpV5mLnrW2gyNS4wwM/xlLwA0PVq1fXlqTU5qwQ
	S/PXFDdkx3h+/WokRuz/FEj1vysmZNXbXUOJ48eRYOWtCZCuInL70QmE
X-Gm-Gg: AY/fxX5Px4mDjMTA1Q04vPbNnYTk/PaJUUUWDzpS0pI5Tdn+tCt9RkNRvk8QbqKyMwg
	SSeVjgKWx5KseoKnQkbf+8G38T93AUaUU3mNDvsxYR1Ajuq8dZDpaJaMtM0Zx3a3P7Vt53G+0ac
	zWgkkz1uIumx117BDe2zbVjBwnLLduBE2dsm1TEuSGcNR8qz+hHlfxZiZp2MvVgcv2E2tYwzfUD
	YmdA/Ca6TS8hwqO+xSW5TGqF7+Y4PISiiFQjBnP6sX5lXG8ptRZWeHmG7cFGkGrQWMs2OnAdLRt
	hx8LYWIho4iWKfdur8WQ+eTgmS4cCt9XWTSDZHv5FYdCT3reXMUzegy2hY5Itd0uBMcpUmOkTrI
	jqXfxUbkuwK67I2WLkEPNeGjd8jbeBknliY72DldZxmSBX8cRfzaVJzfyudZRkuyCAcFn+KFIya
	zKjGZ2DrXJtHwRdq77Xw==
X-Google-Smtp-Source: AGHT+IEhG+s7Qdn4IqoxJXommoVwYHiYpBqW2Ql1hw6PgOHtDqOeuQwZ9k+xUgSbT5iSjK3nvYGa2g==
X-Received: by 2002:a05:6a00:4502:b0:7b9:ef46:ec61 with SMTP id d2e1a72fcca58-7f667b26cffmr7887410b3a.26.1765767914706;
        Sun, 14 Dec 2025 19:05:14 -0800 (PST)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c27733edsm11076298b3a.20.2025.12.14.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:05:13 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net,
	carnil@debian.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()
Date: Sun, 14 Dec 2025 19:00:42 -0800
Message-ID: <20251215030043.1431306-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch reverts fuse back to its original behavior of sync being a no-op.

This fixes the userspace regression reported by Athul and J. upstream in
[1][2] where if there is a bug in a fuse server that causes the server to
never complete writeback, it will make wait_sb_inodes() wait forever.

Thanks,
Joanne

[1] https://lore.kernel.org/regressions/CAJnrk1ZjQ8W8NzojsvJPRXiv9TuYPNdj8Ye7=Cgkj=iV_i8EaA@mail.gmail.com/T/#t
[2] https://lore.kernel.org/linux-fsdevel/aT7JRqhUvZvfUQlV@eldamar.lan/

Changelog:
v1: https://lore.kernel.org/linux-mm/20251120184211.2379439-1-joannelkoong@gmail.com/
* Change AS_WRITEBACK_MAY_HANG to AS_NO_DATA_INTEGRITY and keep
  AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM as is.

Joanne Koong (1):
  fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()

 fs/fs-writeback.c       |  3 ++-
 fs/fuse/file.c          |  4 +++-
 include/linux/pagemap.h | 11 +++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.47.3


