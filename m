Return-Path: <linux-fsdevel+bounces-10430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87684B0CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F37A1C21B6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7642A12D14A;
	Tue,  6 Feb 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlC2veuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BB12BF3C
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210691; cv=none; b=gF+01GFz8Wowt8mTMrwEsSUTtwyGVxVqcjMPPy/wV5qkTfLIQlkJRx30p1lD4V2RPRrG2aICGoZ2VcwrFRI2JVPFiNlevMQ3LeVKKv418BLcQjbflJDywg7jAP0UBdmW4xXmek7i2Xw1KsabXqMoG+WD+IV89jeJVNG0lP4oaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210691; c=relaxed/simple;
	bh=rfF/2hEZvke0SrtkyH4eMd943eOFLhj786txrpm8IRc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tTKTvBRiBVZ6pFCE+t2qENUZojH7pyS8O5tXIPiS1irkNF7hpY1MDfOfhHOUau1czHg5RVhnOFvm7WYrzmtuoaeS/fTz50iDdzH9qFxGR+6Ja8gXeXmYLH5ADOKDrjNtqwEgOZXbl6bR/tO5bj7/s1LTJ0NEmRhwrbdDCyPEJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rlC2veuO; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4b978e5e240so2172402e0c.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 01:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707210689; x=1707815489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dt8kqDOU/E24oKSolewG5gpnabtVYYG3lPQtya8JjLk=;
        b=rlC2veuOyWZQRcKxlt7MC1NjBYmpD+03HNQNRlVPH/rXxhZE2Tpkw8yitNkN1wlF1Y
         aX09qW9wd8/QTG41QQcd8rE+MZColHBD8VssWkG0zu9TsvXozH1UhiYP1sYN2lAdSd0p
         gngYBDfRLTE5UlMGjxLPR/OJcLfrFiUTH+DyDEYz/wGHjkCJPbv+o5roM6CIe9ZmE2QP
         Bzbyberz0WZc11UfasTJ8rhuzuVl+VjfjBU3o6xOPkwA70eH/WiUxxkW5jJK+J87jHTT
         YYvdobpSk6lENCcIcIpHPxNQPphk1+ev/pr3x1DgiU40HQu8GWWCk3K9qXk76gl8/XxQ
         BjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210689; x=1707815489;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dt8kqDOU/E24oKSolewG5gpnabtVYYG3lPQtya8JjLk=;
        b=C//vfu7hOZRsRE1VThoSUPaPcPbGSsrfZXNVNxEygrgJfqZLGB4S+IMhdedYXT0bz/
         CB8aFSlN1IX2Uo47Zf/JIc5+FLVab8YuF/gmogEyxE4wqLwDbJkn+8LOeLyPC4jMUyc7
         QFrkD9gu8u0g6O787mEmEfsVamZiW0iAcOfiE/9MwYAvdM6H0fIH/MZRnYxU81NMtpJM
         bOCXRQiVDyceekjqGPe89DTYNEWMOoYdSZ3jzomL472rzNS+zSf8utxUUL++1ezaM+5u
         KVIeoVwIeUqCdHYXO2/crxquhLTsPQ9oAkIhXjgOXKVbSFWJtgO3wNoTCWasb34Ghw3w
         S5og==
X-Gm-Message-State: AOJu0Yzq1ww2B3000DHsYR+0moBPQdQHRHJ7bFL8Rv/eGB9phyA6Lsw9
	wxHznfL0HlZUuuxcVa9f53Qax+OtXdgJzeHNragIbvNYB5Min7zu7LsffK+Lpmu5Ws8Iool23E2
	o4UVGHL7tITkVADjKOnvTFkTjei0vfMihPmRKrw==
X-Google-Smtp-Source: AGHT+IF6WWYrlBchEW0hvYZVNUtoLNY60FaTDcfmV9bCAdemD+s2jyOnG/4mz1rNqY28ZHvSjRzTK9XeDR3BEloMUHA=
X-Received: by 2002:ac5:c64f:0:b0:4c0:1a5c:9185 with SMTP id
 j15-20020ac5c64f000000b004c01a5c9185mr1828685vkl.4.1707210689106; Tue, 06 Feb
 2024 01:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 6 Feb 2024 14:41:17 +0530
Message-ID: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
Subject: next: /dev/root: Can't open blockdev
To: linux-block <linux-block@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

All qemu's mount rootfs failed on Linux next-20230206 tag due to the following
kernel crash.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Crash log:
---------
<3>[    3.257960] /dev/root: Can't open blockdev
<4>[    3.258940] VFS: Cannot open root device "/dev/sda" or
unknown-block(8,0): error -16
<4>[    3.259704] Please append a correct "root=" boot option; here
are the available partitions:
<4>[    3.261088] 0800         2500336 sda
<4>[    3.261186]  driver: sd
<4>[    3.262260] 0b00         1048575 sr0
<4>[    3.262409]  driver: sr
<3>[    3.263022] List of all bdev filesystems:
<3>[    3.263553]  ext3
<3>[    3.263708]  ext2
<3>[    3.263994]  ext4
<3>[    3.264160]  vfat
<3>[    3.264419]  msdos
<3>[    3.264589]  iso9660
<3>[    3.264773]
<0>[    3.265665] Kernel panic - not syncing: VFS: Unable to mount
root fs on unknown-block(8,0)
<4>[    3.266991] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
6.8.0-rc3-next-20240206 #1
<4>[    3.267593] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
<4>[    3.268937] Call Trace:
<4>[    3.269316]  <TASK>
<4>[    3.270113]  dump_stack_lvl+0x71/0xb0
<4>[    3.271837]  dump_stack+0x14/0x20
<4>[    3.272128]  panic+0x12f/0x2f0
<4>[    3.272812]  ? _printk+0x5d/0x80
<4>[    3.273097]  mount_root_generic+0x26e/0x2b0
<4>[    3.273941]  mount_block_root+0x3f/0x50
<4>[    3.274212]  mount_root+0x60/0x80
<4>[    3.274610]  prepare_namespace+0x7a/0xb0
<4>[    3.276008]  kernel_init_freeable+0x137/0x180
<4>[    3.276285]  ? __pfx_kernel_init+0x10/0x10
<4>[    3.276563]  kernel_init+0x1e/0x1a0
<4>[    3.276837]  ret_from_fork+0x45/0x50
<4>[    3.277319]  ? __pfx_kernel_init+0x10/0x10
<4>[    3.278176]  ret_from_fork_asm+0x1a/0x30
<4>[    3.278560]  </TASK>
<0>[    3.280750] Kernel Offset: 0x1a800000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
<0>[    3.281985] ---[ end Kernel panic - not syncing: VFS: Unable to
mount root fs on unknown-block(8,0) ]---


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240206/testrun/22547673/suite/log-parser-test/test/check-kernel-panic/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240206/testrun/22547673/suite/log-parser-test/tests/

--
Linaro LKFT
https://lkft.linaro.org

