Return-Path: <linux-fsdevel+bounces-40861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC7A27FE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C5F1887CA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4B29A9;
	Wed,  5 Feb 2025 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="BLYuSqA2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E337160
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713803; cv=none; b=PKRN2hezyCal8iBR+0eGPfVGuheEwVyRHlPEagluGWBYuRZXIkYgD3oK3xZTVTEj/8QdlDl3Dj0OMBGzFMVfEYEM2je76iy0N4JdIVw/T7kxoGsYvMLPPJcNFICd09yqJJAOcKBU+pSD3YyauPPx8dTSM9Re67YMjGbUQkwWbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713803; c=relaxed/simple;
	bh=ixl7ahAl4oMNhD6gpgqBEifAw7bPZagK2y8eV75KGM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9A4EyI2wjlr6Vfe8S5IxHR5msjkT/++Y4rcMU3z9gNZm6oCpJuC/vBRYFsyV9NhLDkVeRcV41cIm23C8mMdKF+9TwFloGpEHXPdSg+i5ouus6xTRn72SUi5cbUvtnHLQiKt4vRoQ6vaTIK1xqoInBJHB1k+leKp27W8dCel2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=BLYuSqA2; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fa3714d4bbso2758199eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 16:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1738713800; x=1739318600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MyZU/vc53X8rNmbLu1lnkOpnySbfnmZzmZEGSFD8U1U=;
        b=BLYuSqA2j/KJ4WH7BQ9w4LoFU/lVD1Jc1iASl8STB8a6+EfG7Q49vDghckoLOEY8Xv
         6oAsBJ90KoWPeUKRvUooCFVgD+OJIa3QMMZzL4rdNHI5A3dW0RPfu1FD+LHhG/dRa2Cl
         DfY9I4VQKglaSvJ2rHxGZ1nuXQUWGUohWS6JidJwosu/y03iwRwMRPh8/FHBZ2BKDsV6
         V9W3YlaFyuAeU21f7MFSpSOFkhH5kIWHz5xp9gEiJV6vZwLMsfvnTnfT6e3in7cKQ0yV
         3B0s6bS0Fy7ZcJVmYraL2P859JxP6TL+5+Z5lv3luwAb5M8uCgrVsk73Jpm974HRIJcB
         rg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738713800; x=1739318600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyZU/vc53X8rNmbLu1lnkOpnySbfnmZzmZEGSFD8U1U=;
        b=XcGmupDsa3C44xoSFv9l7K3Q2YHll73SoUcdAciUgW2otZF3hzwqg8HqCIDD75Uk4g
         fBG9QmZU3glb68ciH/jwrLf0IbqHfodt4CspWaYc4x5ZPsFHYjopHRCu1tfMR2+voZxG
         9LV4Boce+6TpMQo72iAeQRPEVHOeDswHnbR5oCMwkLhVo2pFLQLk1lTSWy5xMAjeDGh/
         Kchl3RXJLQ+KMRKy79voXQiM7OUWgSiUZzcdoZkZbS7t+V6vfJp2JVMk7uuLyvGYnnhr
         i9XRtl5Li/XlehtfdyE/cfyRuPC5rAui79bHp5RJqoaWKx7UyC1OU9KTjhfM/C63kbIL
         OYcA==
X-Forwarded-Encrypted: i=1; AJvYcCU/p3L+cgbEeT2tpWjUuJ0fTQMn2z7xi5aahQgymVuTUpc9DCiGWnjaCxwIvvuOUopEvzTTvJ8COOIyUZZm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Eidb7drwmGthxxDcSF7Kx3WzNiHusVrjwR1MZ1w7+Z+1hPXF
	N8Sg1kenj+USc+t1M+FM5EQQxpiihRGXS5ly00/CDFFq+Q/WRFB1o6TLygb2hKOukpd1qddbV3h
	8BaaL7cVp
X-Gm-Gg: ASbGnct3vx6e9IJ4U0SbxaFbvReci5s+04JjDovFiGy8rAWGNiMwvXVu0C4V4ooA7De
	E9BQzlr9IkSxBIa9QVDMpL8C0XK60rr4pv5tu/Pjzh23fSEB3lW5Cxb+vljctwHBNUDWZWUHhWp
	r4ewcft9AGLjscD7hpn5FTsb8DuTp4MlPBGNUeNWzMhII8NzKI720TJCUAkipxdgUFMRtEG0ZEm
	Xi57qHYcN9SAx9md7ODG1wndGs+SK/TVOMPcsOwTLlTmdWyZ99V9GAlrFDgOO2gRpIdkzN1frTD
	AGUOkZODbgOrhtoRsDzY4taeSmsbqHUO
X-Google-Smtp-Source: AGHT+IF14s2ebYWvUrNXnPVtHlswt83W9rlwJ5uNu6oFydj9Vz3g1CgGQ+Qp5/2AyXb3dREGnQfNBQ==
X-Received: by 2002:a05:6820:290f:b0:5fa:5c7d:db42 with SMTP id 006d021491bc7-5fc47790ac4mr776356eaf.0.1738713799833;
        Tue, 04 Feb 2025 16:03:19 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:d53:ebfc:fe83:43f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617eb64csm3666413a34.37.2025.02.04.16.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:03:18 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH 0/4] ceph: fix generic/421 test failure
Date: Tue,  4 Feb 2025 16:02:45 -0800
Message-ID: <20250205000249.123054-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The generic/421 fails to finish because of the issue:

Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.894678] INFO: task kworker/u48:0:11 blocked for more than 122 seconds.
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.895403] Not tainted 6.13.0-rc5+ #1
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.895867] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.896633] task:kworker/u48:0 state:D stack:0 pid:11 tgid:11 ppid:2 flags:0x00004000
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.896641] Workqueue: writeback wb_workfn (flush-ceph-24)
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897614] Call Trace:
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897620] <TASK>
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897629] __schedule+0x443/0x16b0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897637] schedule+0x2b/0x140
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897640] io_schedule+0x4c/0x80
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897643] folio_wait_bit_common+0x11b/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897646] ? _raw_spin_unlock_irq+0xe/0x50
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897652] ? __pfx_wake_page_function+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897655] __folio_lock+0x17/0x30
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897658] ceph_writepages_start+0xca9/0x1fb0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897663] ? fsnotify_remove_queued_event+0x2f/0x40
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897668] do_writepages+0xd2/0x240
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897672] __writeback_single_inode+0x44/0x350
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897675] writeback_sb_inodes+0x25c/0x550
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897680] wb_writeback+0x89/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897683] ? finish_task_switch.isra.0+0x97/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897687] wb_workfn+0xb5/0x410
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897689] process_one_work+0x188/0x3d0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897692] worker_thread+0x2b5/0x3c0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897694] ? __pfx_worker_thread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897696] kthread+0xe1/0x120
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897699] ? __pfx_kthread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897701] ret_from_fork+0x43/0x70
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897705] ? __pfx_kthread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897707] ret_from_fork_asm+0x1a/0x30
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897711] </TASK>

There are several issues here:
(1) ceph_kill_sb() doesn't wait ending of flushing
all dirty folios/pages because of racy nature of
mdsc->stopping_blockers. As a result, mdsc->stopping
becomes CEPH_MDSC_STOPPING_FLUSHED too early.
(2) The ceph_inc_osd_stopping_blocker(fsc->mdsc) fails
to increment mdsc->stopping_blockers. Finally,
already locked folios/pages are never been unlocked
and the logic tries to lock the same page second time.
(3) The folio_batch with found dirty pages by
filemap_get_folios_tag() is not processed properly.
And this is why some number of dirty pages simply never
processed and we have dirty folios/pages after unmount
anyway.

This patchset is refactoring the ceph_writepages_start()
method and it fixes the issues by means of:
(1) introducing dirty_folios counter and flush_end_wq
waiting queue in struct ceph_mds_client;
(2) ceph_dirty_folio() increments the dirty_folios
counter;
(3) writepages_finish() decrements the dirty_folios
counter and wake up all waiters on the queue
if dirty_folios counter is equal or lesser than zero;
(4) adding in ceph_kill_sb() method the logic of
checking the value of dirty_folios counter and
waiting if it is bigger than zero;
(5) adding ceph_inc_osd_stopping_blocker() call in the
beginning of the ceph_writepages_start() and
ceph_dec_osd_stopping_blocker() at the end of
the ceph_writepages_start() with the goal to resolve
the racy nature of mdsc->stopping_blockers.

sudo ./check generic/421
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-testing-0001 6.13.0+ #137 SMP PREEMPT_DYNAMIC Mon Feb  3 20:30:08 UTC 2025
MKFS_OPTIONS  -- 127.0.0.1:40551:/scratch
MOUNT_OPTIONS -- -o name=fs,secret=<secret>,ms_mode=crc,nowsync,copyfrom 127.0.0.1:40551:/scratch /mnt/scratch

generic/421 7s ...  4s
Ran: generic/421
Passed all 1 tests

Viacheslav Dubeyko (4):
  ceph: extend ceph_writeback_ctl for ceph_writepages_start()
    refactoring
  ceph: introduce ceph_process_folio_batch() method
  ceph: introduce ceph_submit_write() method
  ceph: fix generic/421 test failure

 fs/ceph/addr.c       | 1110 +++++++++++++++++++++++++++---------------
 fs/ceph/mds_client.c |    2 +
 fs/ceph/mds_client.h |    3 +
 fs/ceph/super.c      |   11 +
 4 files changed, 746 insertions(+), 380 deletions(-)

-- 
2.48.0


