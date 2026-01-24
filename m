Return-Path: <linux-fsdevel+bounces-75333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPRvDvwUdGk32AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:40:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872B7BBD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A041301681A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04B1DD525;
	Sat, 24 Jan 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="J4B8UQ0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E661917FB;
	Sat, 24 Jan 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215223; cv=none; b=rosBl1ysiwubZvrPdPnuhIZ1W9rxHQ/EDhXuz+xg/ilJ4yaR86hJKGz5u9NLP4V+KyAUY+FYNXZqEnf/oiiYgROlp43DZj7ybsSrNCGXnqdtp0DKlul59ZQuFoxifbFCZ0fTEzMgp+8ck4FQJwMlooSyQ+XOjWOuKl8+eF32BK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215223; c=relaxed/simple;
	bh=lgFDGoil/S4e6TphR+ODflB3R3L114zDDaEaNQFnKvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0jl3CtP2ENt2MecY9GWjxHcHNiSqygyq1YA1c6t1qCkkpsczXxBNv/CcB3hJapvc0kG5pi7nnsG7HYDWWDh0V4EstLp0MonO2dcpOYJrzTqAiPzDjrEEYagcY/dMBFePj+9ObhsFcPBqB/fp3Pm/OIsnvgNiPrkE7DnWGKf7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=J4B8UQ0r; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60O0dnvV1194278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 23 Jan 2026 16:39:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60O0dnvV1194278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1769215198;
	bh=i7ujYxCFrLguHA+dUxfztGa5YKkkTOuh+D/kjJzgoLg=;
	h=From:To:Cc:Subject:Date:From;
	b=J4B8UQ0r26yfKD4kQlgmsA4P3s0OovcEiRw4cw0sYKi+JoFIjhxccSlCOCWFgGG5E
	 9acFFCZ/lPGAhFpPu0LAJ7A9FO4VSxFjY1+efAfEXH8SI3VjM61V88gi0Vy8Tvv2bh
	 L0QynTJqDaTV+EqKSO3AOI4kVHYRNtaX0+PmkEyAmDCac8O6C8mJpIB7yWAxvVc4WQ
	 5RmfJRYWZgVFAzoqX5cCYIXJHAFDZosTIU9RzIgsknRVMV1cgDJpoadac/egH/feYr
	 Gmi0weIkaJvpSBqGwd/FvN3alkscgWFvttWUmTChj4/fgpKH3p1teI9IEr9osQOezM
	 Gt+dp3HSBYs0Q==
From: "H. Peter Anvin" <hpa@zytor.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        systemd-devel@lists.freedesktop.org
Subject: [PATCH 0/3] Add the ability to mount filesystems during initramfs expansion
Date: Fri, 23 Jan 2026 16:39:33 -0800
Message-ID: <20260124003939.426931-1-hpa@zytor.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2025122301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75333-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[zytor.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5872B7BBD4
X-Rspamd-Action: no action

At Plumber's 2024, Lennart Poettering of the systemd project requested
the ability to overmount the rootfs with a separate tmpfs before
initramfs expansion, so the populated tmpfs can be unmounted.

This patchset takes this request and goes one step further: it allows
(mostly) arbitrary filesystems mounts during initramfs processing.

This is done by having the initramfs expansion code detect the special
filename "!!!MOUNT!!!" which is then parsed into a simplified
fstab-type mount specification and the directory in which the
!!!MOUNT!!! entry is used as the mount point.

This specific method was chosen for the following reasons:

1. This information is specific to the expectations of the initramfs;
   therefore using kernel command line options is not
   appropriate. This way the information is fully contained within the
   initramfs itself.
2. The sequence !!! is already special in cpio, due to the "TRAILER!!!"
   entries.
3. The filename "!!!MOUNT!!!" will typically be sorted first, which
   means using standard find+cpio tools to create the initramfs still
   work.
4. Similarly, standard cpio can still expand the initramfs.
5. If run on a legacy kernel, the !!!MOUNT!!! file is created, which
   is easy to detect in the initramfs code which can then activate
   some fallback code.
6. It allows for multiple filesystems to be mounted, possibly of
   different types and in different locations, e.g. the initramfs can
   get started with /dev, /proc, and /sys already booted.

The patches are:

    1/3: fs/init: move creating the mount data_page into init_mount()
    2/3: initramfs: support mounting filesystems during initramfs expansion
    3/3: Documentation/initramfs: document mount points in initramfs

--- 
 .../driver-api/early-userspace/buffer-format.rst   | 60 +++++++++++++-
 fs/init.c                                          | 23 +++++-
 include/linux/init_syscalls.h                      |  3 +-
 init/do_mounts.c                                   | 17 +---
 init/initramfs.c                                   | 95 +++++++++++++++++++++-
 5 files changed, 175 insertions(+), 23 deletions(-)

