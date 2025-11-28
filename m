Return-Path: <linux-fsdevel+bounces-70144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92BC92594
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 15:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52A124E1A8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33414329C72;
	Fri, 28 Nov 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+81eIja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC0E19AD90
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764340870; cv=none; b=ml7WST8s0++lwMeZoiRlldkVs8cTaYY2FYKX0hFAiwsfAo3NMlUWVkc2OvDgY5ALdm1AvNenWgYCU2uN/eGQIUx9SjzjWmt2IUQEZGhtWQPAEB36Y/iTzHI5JUb9cg9lfu3NepYof5+PRjKpr7rTqVLeB2sC78kDeJ1pWoN3VW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764340870; c=relaxed/simple;
	bh=YiCXa/gTWlwoFZYY7VWOXyNDoQMkwRyt2rAHvg9j0ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWOIJlnLJYtVwmhB1NcRgIcMlXD/QE7j/vSPOmdyotki7mPpZCE7wq5QP2kI3g0kDTdjvjVggauXnpigD71pWxkPud9Y8CYrEmwQYoseK4gZ6XfWuCqxeQ484KbAlfeYhUkszLlb9owMFDUJ3oBze6k3iXtyBx1+rzEE5XqG1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+81eIja; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-594330147efso1912869e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764340867; x=1764945667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9ZJ0WABz8zA/HIRl6+j40HXO4xcZdxgPrJAX3BYADI=;
        b=X+81eIjamMEpCpZlBkIes5OzGFtZjBoJDKU8zdhbK06si844PWKz4hKwHtLqNe0O32
         jR/sRe4qxLOPVjV6pmrAEvNRAuZvCBkqVjz4Intv91zyrjWM6qAGWCC5ZmnCIxMEzUCW
         JDfKRjpkGYgTUudQz2Txam+hyuYYzVDh0za4Lp9IipmBt4+4y3CNFq/cR2dDyuQkJZ5a
         K7lsA7wVrTquBJBOT29ZTXYxXwmsDT+8nwjolPqYPHMdVMarBqUZpKxEjLtyb5H+TlTo
         YTtC9Azfy/fqGZEZcl6wAVUF+6cidRRWcaIFK9cxiIRB4VY1WIO+XTO5EdscNOOz4DOT
         OmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764340867; x=1764945667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9ZJ0WABz8zA/HIRl6+j40HXO4xcZdxgPrJAX3BYADI=;
        b=qbqHXbRYdpO2vPU+jEOznFD41UcSqDusPYeEq4raRNjPoFEskWVKQ1QCxfNI9NxKWN
         LGLhSQqGXAg2m/qfgW4DY1zDVJSq4uDVNqvKJlw8kSHWGcLEKgM4PTaOcp4J1218ReqR
         zfIxeXHoXxkcn0USqmzkRfkFpjUjUDI1ffszUJ2XQy9RVqyW6EPxb2X36adTDXM2IfL0
         jty4k6ijelj5yz2wSqjgN9HF6P0rzIFQ0HJdSjtFNCr0/ZL42rupveqgwTXUkKJP6BAG
         7sLV8iLLqPqcnOpkpKQ4TUOxPy9O1jp4xHWEHOTbQav3Pd8JsNIp7slyDuSYx/N8dAjY
         ekiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZm0XipoAsTZUh1ZutYeJJHLghTX9COkHTcYcBReGO6lZRWJCfBEkRpqNdPqNxhb1FhXVT/bnKP1IUZqvU@vger.kernel.org
X-Gm-Message-State: AOJu0YwabXG3TUSSQ8QICXO5IUmCfEwp/6TR+MxPKvYLL/1W5Qs0gbgW
	iMvVgSFQTOa0uI2C55FDj+apJ5/VtSYm3Vu+8PFmfoHtPrRfTjuVjZ2fEsCLbYK9YBhUfw==
X-Gm-Gg: ASbGncs8ZL11xWZPlmH5i9qknMKw6OpLTjU4AFHO+2wTBqImYY3u8d8RHzqUeNqMoZz
	B4qsB127V211lmnqw8Nkjr84VW28zOHGNMmXY0TxCYLk26zfOo7YVqaFCQtuhmoxAX5VW319Nya
	9a6veVDQMuXllPx+GBpwr94PFRU73XuE+xMFhAGlkAyEZHcHec40J1I/RuGbyMR8veBu7DiNKsG
	kSF7/PWPPxgSUn45IZ0jO+qlFnyJor8qyBXcSclQzxkJHeKakJaiq9VLJBQgvek1cffxeYHsjMO
	IglXz7P+9VdY6ylC46l5bsfVB9a/HXuiLtqMyUf0xJ1yXuhk5KfnHdat7FrEgKeqLW4/LdGcwdl
	ZgDposqpej6A9hxYx2vD8ZVgaShXETmkOxBu73L6z1YIc1Yp07gKFQumWwXec6TX7j2moEpXMUN
	V0en2jrfaxwsyWsk9vTlB3kjDGs3xhrU6lQXbW8HxNxfNACe48r1tkhKJq
X-Google-Smtp-Source: AGHT+IFgRxZMbnvG2mlcetIpPcII12g0inja9crdJSO7s3MSPIALUt1z3bE01YIbhTc2jfOsDHzEWg==
X-Received: by 2002:a05:6512:3d22:b0:594:2d64:bd0f with SMTP id 2adb3069b0e04-596a3ebf31bmr10723863e87.16.1764340866523;
        Fri, 28 Nov 2025 06:41:06 -0800 (PST)
Received: from cherrypc.astracloud.ru (109-252-18-135.nat.spd-mgts.ru. [109.252.18.135])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa43efcsm1269527e87.63.2025.11.28.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:41:06 -0800 (PST)
From: Nazar Kalashnikov <sivartiwe@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <sivartiwe@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jiufei Xue <jiufei.xue@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.10] fs: writeback: fix use-after-free in __mark_inode_dirty()
Date: Fri, 28 Nov 2025 17:41:19 +0300
Message-ID: <20251128144121.54603-1-sivartiwe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiufei Xue <jiufei.xue@samsung.com>

[ Upstream commit d02d2c98d25793902f65803ab853b592c7a96b29 ]

An use-after-free issue occurred when __mark_inode_dirty() get the
bdi_writeback that was in the progress of switching.

CPU: 1 PID: 562 Comm: systemd-random- Not tainted 6.6.56-gb4403bd46a8e #1
......
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mark_inode_dirty+0x124/0x418
lr : __mark_inode_dirty+0x118/0x418
sp : ffffffc08c9dbbc0
........
Call trace:
 __mark_inode_dirty+0x124/0x418
 generic_update_time+0x4c/0x60
 file_modified+0xcc/0xd0
 ext4_buffered_write_iter+0x58/0x124
 ext4_file_write_iter+0x54/0x704
 vfs_write+0x1c0/0x308
 ksys_write+0x74/0x10c
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x48/0x114
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x40/0xe4
 el0t_64_sync_handler+0x120/0x12c
 el0t_64_sync+0x194/0x198

Root cause is:

systemd-random-seed                         kworker
----------------------------------------------------------------------
___mark_inode_dirty                     inode_switch_wbs_work_fn

  spin_lock(&inode->i_lock);
  inode_attach_wb
  locked_inode_to_wb_and_lock_list
     get inode->i_wb
     spin_unlock(&inode->i_lock);
     spin_lock(&wb->list_lock)
  spin_lock(&inode->i_lock)
  inode_io_list_move_locked
  spin_unlock(&wb->list_lock)
  spin_unlock(&inode->i_lock)
                                    spin_lock(&old_wb->list_lock)
                                      inode_do_switch_wbs
                                        spin_lock(&inode->i_lock)
                                        inode->i_wb = new_wb
                                        spin_unlock(&inode->i_lock)
                                    spin_unlock(&old_wb->list_lock)
                                    wb_put_many(old_wb, nr_switched)
                                      cgwb_release
                                      old wb released
  wb_wakeup_delayed() accesses wb,
  then trigger the use-after-free
  issue

Fix this race condition by holding inode spinlock until
wb_wakeup_delayed() finished.

Signed-off-by: Jiufei Xue <jiufei.xue@samsung.com>
Link: https://lore.kernel.org/20250728100715.3863241-1-jiufei.xue@samsung.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
---
Backport fix for CVE-2025-39866
 fs/fs-writeback.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 045a3bd520ca..ba70508b405d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2326,9 +2326,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			wakeup_bdi = inode_io_list_move_locked(inode, wb,
 							       dirty_list);
 
-			spin_unlock(&wb->list_lock);
-			trace_writeback_dirty_inode_enqueue(inode);
-
 			/*
 			 * If this is the first dirty inode for this bdi,
 			 * we have to wake-up the corresponding bdi thread
@@ -2338,6 +2335,10 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (wakeup_bdi &&
 			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
 				wb_wakeup_delayed(wb);
+
+			spin_unlock(&wb->list_lock);
+			trace_writeback_dirty_inode_enqueue(inode);
+
 			return;
 		}
 	}
-- 
2.43.0


