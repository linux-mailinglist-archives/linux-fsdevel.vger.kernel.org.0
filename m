Return-Path: <linux-fsdevel+bounces-38732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B44A07627
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEDF18890A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7A218842;
	Thu,  9 Jan 2025 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6flxd3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA0218589
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427253; cv=none; b=Qj3VgfUR5o00sfAYPYLJkgAJqyb/L4fzt5tJb/iWHh+zfzUvltVAyDXm9MZB4+l7xCi1svqXjAbL+OTVl8Pm/8rwgSzjSrlFlgTS7tTRk7UxfVX7BwHODFItPYZQLdUUxUC4KKO9WOEYlzxqJgfOC/h5QNyFbgUX6pnGMY4ln8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427253; c=relaxed/simple;
	bh=WkXqH9m84hk5LZzHYWQLVyWzGXw1gtIN8eD7dZ8yf1U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QzU6ld3ccIfr9AmFrA2L74H0bu64ZfHHrrMOnfuAl6l3Uxa+wp3LRDIh5XZlrgeXtfXx7CZ/boDqSqZnGCrADnsCvKtvwChMECeatbjBW41FSvGAjojO0E4xkdlNmphHZf0wFHjY0awmS7bvKYSdGvaI5uZzxEDM/ue1SLx3Qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6flxd3c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736427249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iBR63E9h30xxM2CgdGQf9OIfW6h47zTl4m2HgHgcZXw=;
	b=F6flxd3ccfuCEAwYYQq9opdNvxg12vrbgDAdBWFXTBQt5k0PvF7Fh9RbATCQGI2bvXYQbB
	S2c9aRTDEc2Z4UFvzjuyR1iFHnBchpYHf7hbD7/ZptktE/bhCNUm5X0g9H23Q+uuy0vaRb
	rxieD1x5x2JwdpMWY45W/pFl9mnoFoc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-5Y1kg_7rO7yrzLKMn7aKNQ-1; Thu,
 09 Jan 2025 07:54:03 -0500
X-MC-Unique: 5Y1kg_7rO7yrzLKMn7aKNQ-1
X-Mimecast-MFC-AGG-ID: 5Y1kg_7rO7yrzLKMn7aKNQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F8D9195604F;
	Thu,  9 Jan 2025 12:54:02 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE1F31954B24;
	Thu,  9 Jan 2025 12:53:59 +0000 (UTC)
Date: Thu, 9 Jan 2025 13:53:56 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.40.3
Message-ID: <xw6eivqjw6nc75sbejmi3nkbfssmakkrwpbjpfqtwwbpqxmb4f@rmyrm5gnizln>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The util-linux stable maintenance release v2.40.3 is now available at
      
  http://www.kernel.org/pub/linux/utils/util-linux/v2.40/
      
Feedback and bug reports, as always, are welcomed.
 
  Karel



util-linux v2.40.3 Release Notes
================================

Changes between v2.40.2 and v2.40.3
-----------------------------------

agetty:
   - Prevent cursor escape  [Stanislav Brabec]
   - add "systemd" to --version output  [Karel Zak]
   - fix ambiguous ‘else’ [-Werror=dangling-else]  [Karel Zak]
audit-arch.h:
   - add defines for m68k, sh  [Chris Hofstaedtler]
autotools:
   - Check for BPF_OBJ_NAME_LEN (required by lsfd)  [Karel Zak]
   - add --disable-enosys, check for linux/audit.h  [Karel Zak]
   - add Libs.private to uuid.pc  [Karel Zak]
   - allow enabling dmesg with --disable-all-programs  [Henrik Lindström]
   - allow enabling lsblk with --disable-all-programs  [Henrik Lindström]
   - check for sys/vfs.h and linux/bpf.h  [Karel Zak]
   - fix securedir and pam_lastlog2 install  [Karel Zak]
bash-completion:
   - add `--pty` and `--no-pty` options for `su` and `runuser`  [Christoph Anton Mitterer]
   - complete `--user` only for `runuser`, not for `su`  [Christoph Anton Mitterer]
chcpu(8):
   - Document CPU deconfiguring behavior  [Mete Durlu]
   - Fix typo  [Mete Durlu]
ci:
   - bump coveralls compiler version to gcc 13  [Karel Zak]
doc:
   - fsck.8.adoc - fix email typo  [Geoffrey Casper]
docs:
   - update AUTHORS file  [Karel Zak]
fdisk:
   - (man) improve --sector-size description  [Karel Zak]
   - fix SGI boot file prompt  [mr-bronson]
   - fix fdisk_sgi_set_bootfile return value  [mr-bronson]
   - fix sgi_check_bootfile name size minimum  [mr-bronson]
   - fix sgi_menu_cb return value  [mr-bronson]
fincore:
   - Use correct syscall number for cachestat on alpha  [John Paul Adrian Glaubitz]
fstab.5 mount:
   - fstab.5 mount.8 add note about field separator  [Karel Zak]
hardlink:
   - fix memory corruption (size calculation)  [Karel Zak]
   - hardlink.1 directory|file is mandatory  [наб]
hwclock:
   - Remove ioperm declare as it causes nested extern declare warning  [Zhaoming Luo]
lib/env:
   - fix env_list_setenv() for strings without '='  [Karel Zak]
libblkid:
   - (exfat) validate fields used by prober  [Thomas Weißschuh]
   - (gpt) use blkid_probe_verify_csum() for partition array checksum  [Thomas Weißschuh]
   - add FSLASTBLOCK for swaparea  [Karel Zak]
   - bitlocker add image for Windows 7+ BitLocker  [Victor Westerhuis]
   - bitlocker fix version on big-endian systems  [Victor Westerhuis]
   - improve portability  [Yang Kun]
libfdisk:
   - make sure libblkid uses the same sector size  [Karel Zak]
libmount:
   - exec mount helpers with posixly correct argument order  [nilfsuser5678]
   - extract common error handling function  [John Keeping]
   - propagate first error of multiple filesystem types  [John Keeping]
libmount/context_mount:
   - fix argument number comments  [nilfsuser5678]
logger:
   - correctly format tv_usec  [Thomas Weißschuh]
lscpu:
   - Skip aarch64 decode path for rest of the architectures  [Pratik R. Sampat]
   - make code more readable  [Karel Zak]
lslocks:
   - remove deadcode [coverity scan]  [Karel Zak]
lsns:
   - ignore ESRCH errors reported when accessing files under /proc  [Masatake YAMATO]
man pages:
   - document `--user` option for `runuser`  [Christoph Anton Mitterer]
   - use `user` rather than `username`  [Christoph Anton Mitterer]
meson:
   - check for BPF_OBJ_NAME_LEN and linux/bpf.h  [Karel Zak]
mkswap:
   - set selinux label also when creating file  [Zbigniew Jędrzejewski-Szmek]
more:
   - make sure we have data on stderr  [Karel Zak]
nsenter:
   - support empty environ[]  [Karel Zak]
partx:
   - Fix example in man page  [Michal Suchanek]
po:
   - merge changes  [Karel Zak]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update ja.po (from translationproject.org)  [Hideki Yoshida]
   - update pt_BR.po (from translationproject.org)  [Rafael Fontenelle]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
   - update zh_CN.po (from translationproject.org)  [Mingye Wang (Artoria2e5)]
po-man:
   - add missing langs to po4a.cfg  [Karel Zak]
   - fix typo, update .gitignore  [Karel Zak]
   - merge changes  [Karel Zak]
   - update fr.po (from translationproject.org)  [Frédéric Marchal]
   - update pt_BR.po (from translationproject.org)  [Rafael Fontenelle]
tests:
   - fdisk/bsd Update expected output for alpha  [John Paul Adrian Glaubitz]
umount, losetup:
   - Document loop destroy behavior  [Stanislav Brabec]
uuidd:
   - fix /var/lib/libuuid mode uuidd-tmpfiles.conf  [Karel Zak]
   - fix typo in tmpfiles.conf  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


