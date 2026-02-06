Return-Path: <linux-fsdevel+bounces-76653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBI5KOd1hmn/NQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 00:14:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F96D104132
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 00:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6E96302C915
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 23:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F386310771;
	Fri,  6 Feb 2026 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="dBp2sgfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47030DECE
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770419520; cv=none; b=NmHkXEys8XfevQTT925uSeMGAjMmJF4GJFjzrl3vrEC5gHpBzOEdz2Vmwj2ezAsnHFs72Kfb25OYSXVihHBh1eVU18dRqqJdTk+ezjQuSFK00l5wVjhUCSHdKS5Zq7cgUfAaCE4HKLKDevkpZBOziYWku1RPM5AWQj8VZIymblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770419520; c=relaxed/simple;
	bh=HwCiQKBr1l8qErO+AnbnOKw1B8rJaaUXHoNycvszu/4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=chzPEhEXmXMuR4akitm21sPK4P2vyIYCuXI0K1rXAIJU6VBagq8S0X13WFAsoGEqR2Awz6987mJhiz5EHhyNB5QpfAX0Ksd0p6QN3dKsCn7teoIB3uFX6lvHS5xbsSgGrAg6Jd594WRTjYu4smRtHZbYuPGiaK/Zx22+pseP3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=dBp2sgfC; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7962119ff2bso10005677b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 15:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770419519; x=1771024319; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EK4lJKm8MZRir94kuvkykqLCkd6A+nnJySS1P9S3TnQ=;
        b=dBp2sgfCRsNE1k87n+qeBYRBNHaqY31D3Jp5LtgNV+WWXgqUzHVHIzvOX7THfbOzfE
         hpRZO5TnUK9GrH/H9THgDGJt3Flq9+EdLOZr8awJQ0mWpXPt3TAe5WyO0JUpBWpNgMjc
         x1Q/yPjODZBEJVZI5p/4xlbRvr924WFoo+IQrs2owqSpY9O3zj3DChn2LHv2B7lE7pM0
         OEU+GoLrvrRPym9nLZcmqrAFMob9SvNpaMwSCaBieUwIeYHVm6EfrY8P8Dnv4l7K1sJ1
         ez807CK9mf/YhLk1Zdhu0/bT9xEe3BdMSoeu8lZp8OFmCQRXBz/UXXASabb+0aXNXNB6
         vPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770419519; x=1771024319;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK4lJKm8MZRir94kuvkykqLCkd6A+nnJySS1P9S3TnQ=;
        b=mKBoTBpU0KHc7tq3CNPtKBWefDl27mpDYAOfpOGnnJZAk7W4DNzgfA72JhPGqhwx1o
         AeZukmiYIdu7+PSyoQ/U4eimiczAFGY2afobywwWY/k21/fQpomhU/4gqhzG9I23UTYY
         Yfm7lri2o/bAn7Qa2M+tvDL5JwAa8HBz2r8etvxJW6Q5MqaAEGRfbGcbRegOw2p9sbKD
         k+YgXditYFNNt57umdzau4LjaYeW92wPYCZB2UVaR4wpF685H75K1ty0kv6Jfyv63XXC
         tCOwbwY0hy3s6qTq8xiAIphrFDlRNwcgRhYe00BDcAoliEf+heDu5HrXe++syKnxp2ii
         zPqg==
X-Forwarded-Encrypted: i=1; AJvYcCW3uDkUgMXL5NKz+Zlrx+is8U4oASeit+99sq1rYnV9jj/wd+XV6q0GNGF7TVRIXjqUCPsWx/E650JvNDQv@vger.kernel.org
X-Gm-Message-State: AOJu0YywaW0JwO/6WhM0K/k9vkqJcMyPwUTwAR4OHh2hQvI9rJ4+XN62
	y8ghCi/E9sKDpJrqhfIWwJgHkLRaYgqXrko51Lf4uVMCmoAqT4oRu0NnspAOLuK+Seg=
X-Gm-Gg: AZuq6aKLnIphJAzludqb8Y2c0Ew8rZZfUNdUp/LUjYZyDRJsFfYwkTbfCzIOt6xw9BI
	yklE+0qf5ldEcQrwg4v9GeyeWNFQC3zhJmBTikZpURD9u/O5XIAf+quDTHoL2MNoRshTBMp03Nd
	qJ0fg7MmuOV4rq9Nvfk8lJaTXjkjlxGQZ3u8ejCM5JLIgFOq75Ea8WF2q1TXs3ugvxHuYjsVMqy
	+fAQF54tX35ntcGcCdDsPu/LOpkLP13KhpwVX990Wtev/4sE5O70b9lMAWUdcDF97j0Fv623l+5
	eT/dnc5iyXLnmTsoXUaneMlaahFwdWEPW/49a3wGo2/6tP8d4N3uKc4JObF6XPmSuMBSnivMQxK
	j3X2fiVcBTTm/TSx9ZrvNhikbO5PWPVN5lVVlnlNdmxBTgwZOkhHdIIOJVEnc43IOHKp/+IpCsd
	6b1lHdvPygLg7ayfPUY13ppRB2HhMo2++sZO0R0TUR8fFrZizu/9MsoO95qHdtMQ9YMarxmvlzW
	t8hsMH6H/eDFsrk4MToesuhbSlgtpYABw/VJsc9VPRmHpFt
X-Received: by 2002:a05:690c:6b07:b0:788:247f:3648 with SMTP id 00721157ae682-7952ab6e0f1mr42201867b3.66.1770419518880;
        Fri, 06 Feb 2026 15:11:58 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:75f3:9d3b:8caa:fd01? ([2600:1700:6476:1430:75f3:9d3b:8caa:fd01])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a1dced4sm33915287b3.31.2026.02.06.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 15:11:58 -0800 (PST)
Message-ID: <651b71ac0e0015dc230e94368f07fca8098ec8a1.camel@dubeyko.com>
Subject: [GIT PULL] nilfs2 changes for 7.0-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Edward Adam Davis
	 <eadavis@qq.com>, Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 06 Feb 2026 15:11:56 -0800
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,qq.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76653-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dubeyko.com];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F96D104132
X-Rspamd-Action: no action

Hello Linus,

This pull request contains one fix in NILFS2 logic
and fix of kernel-doc warnings.

Edward Adam Davis has fixed the syzbot reported issue
in nilfs_sufile_trim_fs() logic. When a user executes
the FITRIM command, an underflow can occur when
calculating nblocks if end_block is too small.
This ultimately leads to the block layer function
__blkdev_issue_discard() taking an excessively long time to
process the bio chain, and the ns_segctor_sem lock remains
held for a long period. This prevents other tasks from
acquiring the ns_segctor_sem lock, resulting in the hang
reported by syzbot

Randy Dunlap eliminated 40+ kernel-doc warnings in
nilfs2_ondisk.h by converting all of the struct member
comments to kernel-doc comments.

Ryusuke Konishi eliminated kernel-doc warnings in nilfs2_api.h.

The following changes since commit
8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/nilfs2.git
tags/nilfs2-v7.0-tag1

for you to fetch changes up to
6fd8a09f48d6fee184207f4e15e939898a3947f9:

  nilfs2: fix missing struct keywords in nilfs2_api.h kernel-doc (2025-
12-22 15:45:29 -0800)

----------------------------------------------------------------
nilfs2 updates for v7.0

- nilfs2: fix missing struct keywords in nilfs2_api.h kernel-doc
- nilfs2: convert nilfs_super_block to kernel-doc
- nilfs2: Fix potential block overflow that cause system hang

----------------------------------------------------------------
Edward Adam Davis (1):
      nilfs2: Fix potential block overflow that cause system hang

Randy Dunlap (1):
      nilfs2: convert nilfs_super_block to kernel-doc

Ryusuke Konishi (1):
      nilfs2: fix missing struct keywords in nilfs2_api.h kernel-doc

 fs/nilfs2/sufile.c                 |   4 +
 include/uapi/linux/nilfs2_api.h    |   4 +-
 include/uapi/linux/nilfs2_ondisk.h | 163 ++++++++++++++++++++++-------
--------
 3 files changed, 103 insertions(+), 68 deletions(-)

