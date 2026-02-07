Return-Path: <linux-fsdevel+bounces-76659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGnDGc2Ghmn7OQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 01:26:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB571044A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C48303AB55
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 00:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB991F1534;
	Sat,  7 Feb 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="AhZASGPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C41E5B95
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Feb 2026 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770423981; cv=none; b=drLF2CQLmt5U3TGScsJjMH4vo3kC5Z+iodWRJtqn5StJWcHBiyrCvyp5GBoqZLLQpcT+4n8UOpqX53nC5JjaTc41BL/8/kiRr3Bupw/YXYnoVfF6z8+Qq1dSI5gvy2pApcRM8ZK2efUskKoHzybDYr8WbIZHZDkPUVTVmQIKo6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770423981; c=relaxed/simple;
	bh=5LZ9rRT+gJAX6ofQUfMC19pc0lXduhthUakvfkjOXT8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=dcv2yfR7FeetW8NJg/e8pLlWMkdJ7/SyEKvL3TDAtlwdB//CpsbHk+k6nZazsk0Fsbg/MrokUCyUwDIW2gj6t0y2uNdr5E5nfgNntNn5p3UVAeOMoIXk8TkFIopNmcSHFdSA5TMeT4MVgI1osvK47Qraghe7gYCm5QQlx1oLXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=AhZASGPU; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-649b22e5894so3346987d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 16:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770423980; x=1771028780; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifyTmBsI3eX5sucZ5uPdFf0FlyB+ROKDdS6v5wWJ3Jo=;
        b=AhZASGPU7rD3EW3tg1sWgTycRYw/ixnmRZzEHY26XsQG4VeDvx3NrhkwVpAZP8a160
         DyA1kVxHzfwNVnv0Znf/J+qD2GtH+Ixp9MqEYxBO87EvJK/FhB2hG0cUuAS8Wh+hGMv9
         IBKJFkHl3hA5wIlPhCInp2daV8DF6+uldRNSHLZJZTyc72DPbyi+bbHM9S+yA17eN0eT
         bhK6d6697k0b3HTDs4zZPGGIpk61m1htmd3Lrgv5GkCj8BqTQj77h47sRf97jR85YLz+
         dHDsYUZ6WFxVyk9NhwtBo7Y5855JhLQN72/tITBnYUOfAyjgwiyjFGNSD4BsTyeR2Pt/
         XuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770423980; x=1771028780;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifyTmBsI3eX5sucZ5uPdFf0FlyB+ROKDdS6v5wWJ3Jo=;
        b=Vq8NrfOvWxd7DlnCnF6aA9pbZTf6vk5Jt58m3L8sCgieqcZfmvDxbFrkMGL+NWNYsY
         D/841jiGNl9bM0NgKhnc9QDLcFQu7SZx6S7u8XL02r0XsGVDrMua8oMcc3Ex2UaB1bV4
         D0pX2I8rDYtUTrPT1iDHJNTr6B2q57hIX9qCRR/GFHAyVyXfv8n0/SnUs5mNZwqH1YL2
         hbkKgfTle8HfzJ8cGqagZJyL+uZ5IbO8sqOoB2V1HDOrOzlZvbh0eXkTMRRZqZ3q0pQh
         JrfcHv1HR9RFvkM+cqg4yTARPD5xGbIzKKDgOTHmb8yYiElXifm9AoAIACL+V5cEqJM8
         NirQ==
X-Gm-Message-State: AOJu0YySHh24FuGEKvDmlZn8Wr8vkPmlPwrJQbG1LWswj1FeZxkl2lzm
	gt2ZcMR7F+swQuRxb7AHcZg36l/x84pzfaZV35SXuAGsC9MnKdXQA+J9t0ZNPKODGMM=
X-Gm-Gg: AZuq6aJPuTMi5eFk5gDXrUXf1YoqPxm239gU9TU9b+rFeOhsTgWbIQNzX3+i2BC8Bw2
	QcBfE4ZvRkap1Wq4Xo5ldSvOhViyTAWom7v5pDghbjhKwyzAKm85+eKC5V585/zho6o0XqZDYNx
	/JQ2pMkquyvLiMpdPPl+KWTa38BXb+3DLQrwVUMcWAApl9xkJl97fOhRMP1ON4mR/a+5CgMgW/v
	0GMoNWfUMpkHdtqvy0YKFGfxhtrWwFn3xsI2yUVJybN7FENVHhMlLVtPj8U8VkQ+9nSFN/wpdbV
	iYUpfyUP57gxj1MdzpYSy9FpbYGbloD3jPagS9lYz+O2Pf74E8opCGZDl0Z3NH+LOQYJKGzxMtL
	NgxxH82KsnTCiAMDWXklxYS79UyjRbJA2Gf8RlIW4TGglGLbgJknDx1ih74jORJlBZ9Ihs/amHU
	gu5kuaPuWKwd+f1j0w85yhAbQPGQJZhzTInjTgNrHQtUlXnhdQql0g81BK+lmzM6QeV9fPnIMsy
	cpDyUohfyoCrBu8aPKng3W2ywWK3uJkyek9rVLon3nsqXDMnYK+Eb6Fm9k=
X-Received: by 2002:a05:690c:39a:b0:786:7017:9511 with SMTP id 00721157ae682-7952aa6f2c0mr43082687b3.23.1770423980141;
        Fri, 06 Feb 2026 16:26:20 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:75f3:9d3b:8caa:fd01? ([2600:1700:6476:1430:75f3:9d3b:8caa:fd01])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a281c59sm35077527b3.49.2026.02.06.16.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 16:26:19 -0800 (PST)
Message-ID: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
Subject: [GIT PULL] hfs/hfsplus changes for 7.0-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, jkoolstra@xs4all.nl, 
	mehdi.benhadjkhelifa@gmail.com, shardul.b@mpiricsoftware.com, 
	penguin-kernel@I-love.SAKURA.ne.jp
Date: Fri, 06 Feb 2026 16:26:16 -0800
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
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,physik.fu-berlin.de,vivo.com,xs4all.nl,gmail.com,mpiricsoftware.com,I-love.SAKURA.ne.jp];
	DMARC_NA(0.00)[dubeyko.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76659-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: BAB571044A5
X-Rspamd-Action: no action

Hello Linus,

This pull request contains several fixes of syzbot reported
issues and HFS+ fixes of xfstests failures.

Jori Koolstra has fixed the syzbot reported issue of triggering
BUG_ON() in the case of corrupted superblock. This patch replaces
the BUG_ON() in multiple places with proper error handling and
resolves the syzbot reported bug.

Mehdi Ben Hadj Khelifa has fixed the syzbot reported issues in
mount logic of HFS/HFS+ file systems. When HFS/HFS+ were converted to
the new mount api a bug was introduced by changing the allocation
pattern of sb->s_fs_info. The memory leaks issue has been fixed
by these two patches.

Shardul Bankar suggested the nice fix in hfs_bnode_create() by
returning ERR_PTR(-EEXIST) instead of the node pointer when it's
already hashed and fix of avoiding the double unload_nls() on mount
failure.

Tetsuo Handa added logic of setting inode's mode as regular
file for the case of system inodes.

The rest patches fix issue of failures in generic/020,
generic/037, generic/062, generic/480, and generic/498
xfstests for the case of HFS+ file system. Currently,
only 30 xfstests' test-cases experience failures for HFS+
file system (initially, it was around 100 failed xfstests).

The following changes since commit
8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
tags/hfs-v7.0-tag1

for you to fetch changes up to
ebebb04baefdace1e0dc17f7779e5549063ca592:

  hfsplus: avoid double unload_nls() on mount failure (2026-02-06
15:20:00 -0800)

----------------------------------------------------------------
hfs/hfsplus updates for v7.0

- hfsplus: avoid double unload_nls() on mount failure
- hfsplus: fix warning issue in inode.c
- hfsplus: fix generic/062 xfstests failure
- hfsplus: fix generic/037 xfstests failure
- hfsplus: pretend special inodes as regular files
- hfsplus: return error when node already exists in hfs_bnode_create
- hfs: Replace BUG_ON with error handling for CNID count checks
- hfsplus: fix generic/020 xfstests failure
- hfsplus: fix volume corruption issue for generic/498
- hfsplus: fix volume corruption issue for generic/480
- hfsplus: ensure sb->s_fs_info is always cleaned up
- hfs: ensure sb->s_fs_info is always cleaned up

----------------------------------------------------------------
Jori Koolstra (1):
      hfs: Replace BUG_ON with error handling for CNID count checks

Mehdi Ben Hadj Khelifa (2):
      hfs: ensure sb->s_fs_info is always cleaned up
      hfsplus: ensure sb->s_fs_info is always cleaned up

Shardul Bankar (2):
      hfsplus: return error when node already exists in
hfs_bnode_create
      hfsplus: avoid double unload_nls() on mount failure

Tetsuo Handa (1):
      hfsplus: pretend special inodes as regular files

Viacheslav Dubeyko (6):
      hfsplus: fix volume corruption issue for generic/480
      hfsplus: fix volume corruption issue for generic/498
      hfsplus: fix generic/020 xfstests failure
      hfsplus: fix generic/037 xfstests failure
      hfsplus: fix generic/062 xfstests failure
      hfsplus: fix warning issue in inode.c

 fs/hfs/dir.c            |  15 +++-
 fs/hfs/hfs_fs.h         |   1 +
 fs/hfs/inode.c          |  30 ++++++--
 fs/hfs/mdb.c            |  66 ++++++++++-------
 fs/hfs/super.c          |  13 +++-
 fs/hfsplus/attributes.c | 189 +++++++++++++++++++++++++++++++++++-----
--------
 fs/hfsplus/bnode.c      |   2 +-
 fs/hfsplus/dir.c        |  46 +++++++++++-
 fs/hfsplus/hfsplus_fs.h |   3 +
 fs/hfsplus/inode.c      |  40 +++++++++-
 fs/hfsplus/super.c      |  20 +++--
 fs/hfsplus/xattr.c      | 104 +++++++++++++++++++-------
 12 files changed, 407 insertions(+), 122 deletions(-)

