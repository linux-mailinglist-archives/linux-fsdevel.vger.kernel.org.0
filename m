Return-Path: <linux-fsdevel+bounces-78817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F/2GmWromlF4wQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:46:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79B1C17C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF3C303FA8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366923E334;
	Sat, 28 Feb 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="ShmhUxN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743E1CF8B
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268384; cv=none; b=BPNqU2vUwQcPSk71VZdzzEYFl4UBsPqn0sLC38Iqcubql6PsC9SnxTJ0nHhKq8zm8iZummegMAvYxq/xizd5sY0zjVC8yjBnJqa6Uofy/L9k7F8TzeNWR1oAqtngCJZfSSb8lzGGR+UKrmBc94Z8CHKzbhYk5uUFEC+QTwfH2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268384; c=relaxed/simple;
	bh=ld8KadDRfBZGFb0G39s8O0CKoTR3NE4Xb12cXigqkgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mneAvFSLpL8zi6x2z/IKPRiDotcUDNfgJFTA7Q7TiyZSOrOcB8vh1WZLapnN5Yk0cfzJCLH/mC0NEw+Mkf+PD/siWdOppBbbPUO+VPVn19okw4sO3QlcI9lhbCR5BsBVmyCOQATIwDLJBbFdtWE2wJOApjfoUf56n6WFTXfh7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=ShmhUxN4; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 9F3B91D49A;
	Sat, 28 Feb 2026 08:46:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 9F3B91D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772268382; bh=ld8KadDRfBZGFb0G39s8O0CKoTR3NE4Xb12cXigqkgU=;
	h=From:To:Cc:Subject:Date:From;
	b=ShmhUxN42AUTzszCu4pCzSfGxDIaiO7noPA1opvVynGyxkbd2bCPpSaHiYtwHzQYE
	 dfQe3jJeOFipivrTjvoGRckUdSM1CtMMl+zO3byOY8DFbdXhyj2nHodPVPyYfTgWu2
	 ZEVQF83TFujaa+olYjC8TkDKLjT8RwL/neuEFHvM=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id mmLrFF2romnWyQUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 28 Feb 2026 08:46:21 +0000
From: David Timber <dxdt@dev.snart.me>
To: linux-fsdevel@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 0/1] exfat: Valid Data Length(VDL) ioctl
Date: Sat, 28 Feb 2026 17:46:06 +0900
Message-ID: <20260228084610.487048-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
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
	DMARC_POLICY_ALLOW(-0.50)[dev.snart.me,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dev.snart.me:s=00];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78817-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dxdt@dev.snart.me,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dev.snart.me:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev.snart.me:mid,dev.snart.me:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF79B1C17C4
X-Rspamd-Action: no action

To remedy the problems outlines in the commit 1f2b2a3f submitted
previously, I implemented two new ioctls for reading and manipulating
the VDL of files in exFAT fs. For usage example, please review the
link attached.

Link: https://github.com/dxdxdt/exfatprogs/commit/50dc6605216c2dfd30ffcb4f359126b916360d6f

chdosattr and lsdosattr commands are analogous to lsattr and chattr
commands from e2fsprogs. Below is sample output of lsdosattr.

	$ lsdosattr
	----d-        32768            0 .
	------     67108864            = ./full-file
	r-----        32768            = ./readonly
	-h----        32768            = ./hidden
	--s---        32768            = ./system-file
	-h---a      2097152            = ./hidden-archived
	----d-        32768            = ./dir
	------   3221225472   1073741824 ./vdl-a
	------   1073741824         4100 ./vdl-b

where '=' denotes that the VDL is same as isize, '*' denotes no kernel
support(ioctl returned ENOTTY).

Some notable examples of chdosattr usage as follows.

	chdosattr +a   file  # add ARCHIVE to the attribute bitset
	chdosattr -h   file  # clear HIDDEN from the attribute bitset
	chdosattr =ra  file  # set to RO|ARCHIVE
	chdosattr = -R dir   # clear all attributes recursively

Manipulation of the SYSTEM attribute bit is subject to restrictions
already in place within the kernel.

I understand VDL manipulation poses a risk so I decided to submit the
code patch first before doing some documentation work. I'd happily
accept the rejection to the idea of EXFAT_IOC_SET_VALID_DATA.

Further work

NTFS also incorporates DOS attributes and VDL for backward
compatibility in legacy systems albeit NTFS is a sparse-capable
filesystem. For future works, it might be in our interest to implement
the ioctls in the NTFS as well.

Despite the fact that `FAT_IOCTL_*_ATTRIBUTES` ioctls have been
available for a long time now, most userspace programs(most notably
Wine) still rely on the write permission bit to control ATTR_RO. The
only way to control the other attributes(ARCHIVED and HIDDEN) is
through the ioctl.

The VDL ioctl only requires CAP_SYS_ADMIN. For an added layer of
security, perhaps a new SELinux boolean, say
`allow_fat_set_valid_data_ioctl`, should be added.

David Timber (1):
  exfat: Valid Data Length(VDL) ioctl

 fs/exfat/file.c            | 93 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/exfat.h | 10 +++-
 2 files changed, 102 insertions(+), 1 deletion(-)

-- 
2.53.0.1.ga224b40d3f.dirty


