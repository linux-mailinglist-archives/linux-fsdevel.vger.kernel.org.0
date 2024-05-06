Return-Path: <linux-fsdevel+bounces-18819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E28BCA0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC31C21033
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589301422D4;
	Mon,  6 May 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQXl4W/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256191422CA
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985496; cv=none; b=KB9mPtc/taVTPXHwN03qoC2Txw3GXZ9z0uuUsW7dWyC+rk96Js9iKT1gbUye53ga6JrDb8wjHJQW6CAqt4v+gJYi1jNw/pTEU8vIIY2RoH1hI8i7Vqry38cv1u6UeIKKZW6OP8aV3l6fP3zJ41PuDVsoK5Zlx/NoqoJCsDGZ+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985496; c=relaxed/simple;
	bh=zXD4uG0d7VL7thhhnSj6RgZn3W6NzV5zkQXwTee/F/Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B1KdvONsiSbjS2O9+VLfB0MsQSuI+HuKlBNDNyQqO0PxJnlJVJCGpnhFyqFpEPkko0jnjjJ/7FhsuRIY4ZX19u/QBPrYLaMg9twxSLOfUpVf3DYt1YPxcs3a7x0eg+wzZQty/Utptf2n2VvnPU6r5c5hQ5LD3CTFR0FcZuDL/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQXl4W/y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714985494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cjwsQqESFSzvvYF2Hsd+siFVp0pIuoP5b/kpWCm10Bw=;
	b=WQXl4W/y1OR+lyy9037BPYbuXplcUhbYBo99rPI/K2QJbWwDDvot7UZRR/NYGFMAWcj84Y
	o3uUXuRApecz58FXV5NB/V5kF9gYa9dUyrD48VgA1YCfVGB5AXEWCXPBXrJSK+bvRPAkEB
	1U5wY0iaQ3wfbpN9/8etKk0obmNmrS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-eViCJPYXM6K_A1rrpjJTuA-1; Mon, 06 May 2024 04:51:30 -0400
X-MC-Unique: eViCJPYXM6K_A1rrpjJTuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F08A38943A3;
	Mon,  6 May 2024 08:51:29 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F002200A390;
	Mon,  6 May 2024 08:51:29 +0000 (UTC)
Date: Mon, 6 May 2024 10:51:27 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux stable v2.40.1
Message-ID: <20240506085127.ywva7jnimovnnrlm@ws.net.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


The util-linux maintenance release v2.40.1 is now available at: 

  http://www.kernel.org/pub/linux/utils/util-linux/v2.40/
 
Feedback and bug reports, as always, are welcomed.

  Karel


util-linux v2.40.1 Release Notes
================================

Changes between v2.40 and v2.40.1
---------------------------------

README.licensing/flock:
   - Add MIT license mention  [Richard Purdie]
agetty:
   - Don't override TERM passed by the user  [Daan De Meyer]
   - fix resource leak  [Karel Zak]
   - make reload code more robust  [Karel Zak]
all_syscalls:
   - don't hardcode AWK invocation  [Thomas Weißschuh]
   - don't warn during cleanup  [Thomas Weißschuh]
   - fail if any step fails  [Thomas Weißschuh]
   - use sed to extract defines from headers  [Thomas Weißschuh]
autotools:
   - distribute pam_lastlog2/meson.build  [Thomas Weißschuh]
bcachefs:
   - Remove BCACHEFS_SB_MAX_SIZE & check  [Tony Asleson]
build-sys:
   - release++ (v2.40.1-rc1)  [Karel Zak]
cal:
   - use unsigned int to follow union with unsigned int  [Karel Zak]
docs:
   - add COPYING.MIT  [Karel Zak]
   - fix GPL name typo  [Karel Zak]
   - update AUTHORS file  [Karel Zak]
   - update v2.40.1-ReleaseNotes  [Karel Zak]
findmnt:
   - always zero-terminate SOURCES data  [Thomas Weißschuh]
   - revise the code for -I and -D option  [Masatake YAMATO]
fsck.minix:
   - fix possible overrun  [Karel Zak]
getopt:
   - remove free-before-exit  [Karel Zak]
hwclock:
   - free temporary variable before return  [Karel Zak]
   - initialize parser variables  [Karel Zak]
lastlog2:
   - begin descriptions of options with a lowercase letter  [Benno Schulenberg]
lib/pager:
libblkid:
   - Fix segfault when blkid.conf doesn't exist  [Karel Zak]
   - topology/ioctl  correctly handle kernel types  [Thomas Weißschuh]
   - topology/ioctl  simplify ioctl handling  [Thomas Weißschuh]
libfdisk:
   - add initializer to geometry  [Karel Zak]
libmount:
   - Fix access check for utab in context  [Karel Zak]
   - fix comment typo for mnt_fs_get_comment()  [Tianjia Zhang]
   - fix possible memory leak  [Karel Zak]
   - fix umount --read-only  [Karel Zak]
libsmartcols:
   - fix column reduction  [Karel Zak]
   - reset wrap after calculation  [Karel Zak]
libuuid:
   - (man) fix function declarations  [CismonX]
losetup:
   - losetup.8 Clarify --direct-io  [Colin Walters]
lsblk:
   - simplify SOURCES code  [Karel Zak]
lsclocks:
   - fix FD leak  [Karel Zak]
lsfd:
   - (man) fix license name  [Jakub Wilk]
   - add LSFD_DEBUG env var for debugging  [Masatake YAMATO]
lslocks:
   - don't abort gathering per-process information even if opening a /proc/[0-9]* fails  [Masatake YAMATO]
   - remove a unused local variable  [Masatake YAMATO]
lsns:
   - fix netns use  [Karel Zak]
   - report with warnx if a namespace related ioctl fails with ENOSYS  [Masatake YAMATO]
   - tolerate lsns_ioctl(fd, NS_GET_{PARENT,USERNS}) failing with ENOSYS  [Masatake YAMATO]
meson:
   - Add build-blkdiscard option  [Jordan Williams]
   - Add build-blkpr option  [Jordan Williams]
   - Add build-blkzone option  [Jordan Williams]
   - Add build-blockdev option  [Jordan Williams]
   - Add build-chcpu option  [Jordan Williams]
   - Add build-dmesg option  [Jordan Williams]
   - Add build-enosys option  [Jordan Williams]
   - Add build-fadvise option  [Jordan Williams]
   - Add build-fsfreeze option  [Jordan Williams]
   - Add build-ipcmk option  [Jordan Williams]
   - Add build-ldattach option  [Jordan Williams]
   - Add build-lsclocks option  [Jordan Williams]
   - Add build-lsfd option and make rt dependency optional  [Jordan Williams]
   - Add build-rtcwake option  [Jordan Williams]
   - Add build-script option  [Jordan Williams]
   - Add build-scriptlive option  [Jordan Williams]
   - Add build-setarch option  [Jordan Williams]
   - Add have_pty variable to check if pty is available  [Jordan Williams]
   - Add missing check for build-ipcrm option  [Jordan Williams]
   - Define _DARWIN_C_SOURCE on macOS as is done in Autotools  [Jordan Williams]
   - Don't define HAVE_ENVIRON_DECL when environ is unavailable  [Jordan Williams]
   - Fix build by default and install behavior for build-pipesz option  [Jordan Williams]
   - Fix false positive detection of mempcpy on macOS  [Jordan Williams]
   - Only build libmount when required  [Jordan Williams]
   - Only pick up the rt library once  [Jordan Williams]
   - Only require the crypt library when necessary  [Jordan Williams]
   - Only use the --version-script linker flag where it is supported  [Jordan Williams]
   - Remove libblkid dependency on libmount  [Jordan Williams]
   - Remove lingering mq_libs variable  [Jordan Williams]
   - Require pty for the su and runuser executables  [Jordan Williams]
   - Require the seminfo type for ipcmk, ipcrm, and ipcs  [Jordan Williams]
   - Use has_type instead of sizeof to detect cpu_set_t type  [Jordan Williams]
   - Use libblkid as a dependency  [Jordan Williams]
   - Use libmount as a dependency  [Jordan Williams]
   - respect c_args/CFLAGS when generating syscalls  [Karel Zak]
pam_lastlog2:
   - link against liblastlog  [Thomas Weißschuh]
po:
   - merge changes  [Karel Zak]
   - update cs.po (from translationproject.org)  [Petr Písař]
   - update fr.po (from translationproject.org)  [Frédéric Marchal]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update ja.po (from translationproject.org)  [Takeshi Hamasaki]
   - update ko.po (from translationproject.org)  [Seong-ho Cho]
   - update pl.po (from translationproject.org)  [Jakub Bogusz]
   - update ro.po (from translationproject.org)  [Remus-Gabriel Chelu]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
po-man:
   - merge changes  [Karel Zak]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update ko.po (from translationproject.org)  [Seong-ho Cho]
   - update ro.po (from translationproject.org)  [Remus-Gabriel Chelu]
strutils.h:
   - Include strings.h header for strncasecmp function  [Jordan Williams]
tests:
   - (lsfd  mkfds-multiplexing) skip if /proc/$pid/syscall is broken  [Masatake YAMATO]
   - (lsns  ioctl_ns) add more debug print  [Masatake YAMATO]
   - (lsns  ioctl_ns) record stdout/stderr for debugging the case  [Masatake YAMATO]
   - (test_mkfds  sockdiag) verify the recieved message to detect whether the socket is usable or not  [Masatake YAMATO]
textual:
   - fix some typos and inconsistencies in usage and error messages  [Benno Schulenberg]
wall:
   - check sysconf() returnvalue  [Karel Zak]
   - fix possible memory leak  [Karel Zak]
   - make sure unsigned variable not underflow  [Karel Zak]
xalloc.h:
   - Include stdio.h header for vasprintf function  [Jordan Williams]


