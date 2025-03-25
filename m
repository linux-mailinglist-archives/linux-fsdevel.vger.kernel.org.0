Return-Path: <linux-fsdevel+bounces-44930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0113CA6E7A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 01:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DAA18961D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF613632B;
	Tue, 25 Mar 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="B997oXMX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E615219E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863204; cv=none; b=jQ/+JajRplOWtXYLPcmc6fGoGmUUNg9vOK8MW0F5WDXO5rJHVYGZeDXEvKdp5+cdgunlsqHhxH6AG9P+6JswGAOd38w3e+29ke9s4tzLwJJ2vTTeO6PwKVpfCiH7w1eaxnjkgJC5vt34WkWW1rOUGBZmncm60ps3yGQ17iKrQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863204; c=relaxed/simple;
	bh=YmiJCHpeul6qXEqMxxyq8HehugGU2vdhVXwWmQyHNaQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EH7NwZH5HXBnbKSsUr9rYJ0lG3AuygkLR/VRJocvInXHsmHl6v86K8shO2GCqk5T0jb3v4HkrFTCNDzbGCdbKm6QDHUFm17gAkYzORkZkZY7yyeHMQtpWWTYHHr5dUDH4XvvY5JD0gRerwfMOcelkdXz6BaBH/teyzmmun13SZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=B997oXMX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227cf12df27so21516075ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742863202; x=1743468002; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lisoG7XSWdz3GActuZShSN8qveSgs1+QoWbLvI2Yugo=;
        b=B997oXMXct3s7IPD7dx0UB3qqbr11DZkckM+43t7DO4c6I7jLoMUpnSocEnhx5pkcn
         AyOQJ5kmBA7zcynhh80sVOYOdsPjmayJcrhkEy+9IrbzSzS9wu7ka607dWvCN2uSHlWz
         zsgQMUfETvhhydhhBtQGypWWJofwh4M9p7Guy/vvF0/MJeBmBJOHnFqcFlF5aPAB192b
         La1zohrZdGP3AEWIbpABJWkanoSyuqekHV23NrGhZnF+38Uv280nTdX1RVm7adhb1RLi
         x7AFg/t9HqXTReqV0eI0AUT3JHGy9+PLpEqK3KatoDaRwukg2v5S9YCMpK7fqBUX74TM
         bTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863202; x=1743468002;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lisoG7XSWdz3GActuZShSN8qveSgs1+QoWbLvI2Yugo=;
        b=ATRp2zwGszlz0MH5cAjFAg+AN/DFmQlu3jBASHSL80RkkcFhywGyIvP/OX7+gM/WHn
         swvB2WOr8a6luk7wjbBPs8RzGVtcPQVo73NTVZJT5cUyrJQ3ZHZyr+K3IPw222ZahfJ8
         lbDvKfRSDCiGu1vcpsnboL0O1Fkzrcpgqfaoad3teyhBJyaquaKfseHwiPnjX1nN0UHK
         0Bndw6Kyz6Yz8vJCCr4BXbcJxWUYwwRqfHD7fqnaApG8A4ZQZKUHHFEt6ApDw3PecBh6
         Sl37RMm9UqE2a0rVYTbjNOCz2WbbXOU8ENcoEVACJQChGJ4Oe0mHl/Joq6Zeua2WsMx0
         nMow==
X-Gm-Message-State: AOJu0YySkhY9hOl4Ssj0fblsRTCuwuQZ53DSW+qilYtPFvdpAG9epC24
	l/Q/9J6r1Wc5KDoL6LGawQtIIhrqSXPOLtfHERf2Dot6b427FwhwfPVx44HNYFpsVS84hCULASR
	R
X-Gm-Gg: ASbGncvDKCiNllXrLWVtvf+e91ZiEJBeiPG3z8ha1Df2TNJRA7D3MdynrK8MyDRmI1q
	5P+ai+v6OSwG6pnytQrPDn/raAWzg5kzhJDca7srqh3vwmThTyqX89cKzRP3KVNn9QAxlU8FZxz
	1h8ubYfek9z3bznnnhP0aXVEpfOnmbjD/BvrIkk8I/cQ1GY1mDH2hzY6bsuM6Pb91fosqk7xwKz
	QKcHCwbLePx3RuGmX4mzToSal2VY/6D7sFH+Kcu3K92bVMcPNjjRi66iIxTZL3AcOzmt+pu9Zoo
	jA5s9FhWEqniUB5OCuA7Wkx541AM0sy/SNyKa09+UARGZBGDvAhm+yLKVO+Ua/+c63G/UyUNn8O
	AF90JkVNBi4i9+ZiBv1JQ0Hl7u91+H6A=
X-Google-Smtp-Source: AGHT+IFMSillMEbL25Z0gLmlJ/A6beMRt6CQx3WJPUGfJeZ/lJAVVxNgYvhyVEbv/Z2RFtXJAJABYA==
X-Received: by 2002:a17:902:d58f:b0:21f:40de:ae4e with SMTP id d9443c01a7336-2278069841dmr230003115ad.9.1742863201626;
        Mon, 24 Mar 2025 17:40:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45f45sm77356055ad.87.2025.03.24.17.40.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:40:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1twsKk-0000000HUgy-1JLj
	for linux-fsdevel@vger.kernel.org;
	Tue, 25 Mar 2025 11:39:58 +1100
Date: Tue, 25 Mar 2025 11:39:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Subject: [6.15-rc0 LBS(?) regression] XFS mount hangs in set_blocksize()
Message-ID: <Z-H7XjrAlknSR2Ie@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

Just saw this on a test run after upgrading to a current TOT kernel
+ linux-xfs/for-next. A mount being run from check-parallel hungs
with this stack trace:

 task:mount           state:D stack:13064 pid:4005317 tgid:4005317 ppid:3498345 task_flags:0x400100 flags:0x00004002
 Call Trace:
  <TASK>
  __schedule+0x63b/0xad0
  schedule+0x6d/0xf0
  io_schedule+0x48/0x70
  folio_wait_bit_common+0x180/0x290
  __folio_lock+0x17/0x20
  truncate_inode_pages_range+0x364/0x3e0
  truncate_inode_pages+0x15/0x20
  set_blocksize+0x193/0x1b0
  xfs_setsize_buftarg+0x24/0x60
  xfs_setup_devices+0x1d/0xd0
  xfs_fs_fill_super+0x350/0x870
  get_tree_bdev_flags+0x121/0x1a0
  get_tree_bdev+0x10/0x20
  xfs_fs_get_tree+0x15/0x20
  vfs_get_tree+0x28/0xe0
  vfs_cmd_create+0x5f/0xd0
  vfs_fsconfig_locked+0x50/0x130
  __se_sys_fsconfig+0x34b/0x3d0
  __x64_sys_fsconfig+0x25/0x30
  x64_sys_call+0x3c3/0x2f70
  do_syscall_64+0x68/0x130
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

This has come from xfs/032 which is testing all supported sector and
block sizes on XFS, so it is likely exercising LBS functionality at
both the block device and filesystem layers. I haven't seen this in
6.14 at all, so it happening within a couple of test runs on a
current TOT implies a regression introduced in the current merge
window.

This doesn't fail every time it is run, but I'm reporting this on
the first failure so I don't yet know how frequently it happens yet.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

