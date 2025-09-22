Return-Path: <linux-fsdevel+bounces-62390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D504CB9078B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BFE74E10C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C13054F2;
	Mon, 22 Sep 2025 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7Q2thkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F12773EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541709; cv=none; b=KSunW6R8cX4/cUhE131wrHfOtnVO1EFpLAABdUc7sA8HQGaHQZa3bfKNfSYPAf9JeRr/vlR+YJcajMHMcQHLwxELXsxz3hl50vtBvPmo8qYK9uu7K7AYiJXmXmBpHA6jcIcBNdXrNoJM5ylGQYxRcajgO+lhSfxeipj6Ubzhx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541709; c=relaxed/simple;
	bh=Pregwja20pPdeQ6hBFFCv6+ehyzfjlp1M6LIaaFG39c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FhocSVPLEG91UJYVQKskWVr9yuVSN/FpwEhNMYYQ9kWqadfThXDIFU9n6Nw0YZU7atDPCrR9k4qrj4jnuMumdMSpwsEY8G3Zq1pSPZdLhdf1ugf9j5aWvo/O1Ry4250o1avvqltvcYRiad32I20iMxBonbwnSHcbqZlQL5njqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7Q2thkq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758541706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B8RU7qUq3dY+e3f8Ehx10rzc/Ey4Gre7j1V3AC9ifV8=;
	b=J7Q2thkqocOGh85JNZjn8+CZ2AcaO06UZm1b9s66XjeaYksyI6HVZHWQv43J/LhRAYrkS7
	1wYd0uukVpZYq1hEVy8QPvzrHjxoCu3MWVArwscx0k5l/k445pvjBaMjMCm4vGkzKAVzMO
	tsKjhQpjNWkEAjlYTkFrHzkXx6vml3s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-TiU9SO8qPRKk6tiRbwKv8g-1; Mon,
 22 Sep 2025 07:48:23 -0400
X-MC-Unique: TiU9SO8qPRKk6tiRbwKv8g-1
X-Mimecast-MFC-AGG-ID: TiU9SO8qPRKk6tiRbwKv8g_1758541702
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5949D19560A2;
	Mon, 22 Sep 2025 11:48:22 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15AC31955F21;
	Mon, 22 Sep 2025 11:48:19 +0000 (UTC)
Date: Mon, 22 Sep 2025 13:48:16 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux stable v2.41.2
Message-ID: <cphv3swx7a3nqmzgxroyezzpxf2rrvfdxrbev55tm6ioeczki3@plvbxfgxkvl4>
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


The util-linux stable maintenance release v2.41.2 is now available at
      
  http://www.kernel.org/pub/linux/utils/util-linux/v2.41/
      
Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux 2.41.2 Release Notes
===============================

bash-completion:
    - fix function name of enosys completion (by Koichi Murase)
    - add choom and coresched (by Karel Zak)

blkid:
    - correct an erroneous error message (by Benno Schulenberg)

build-sys:
    - update release dates (by Karel Zak)

docs:
    - add v2.41.2-ReleaseNotes (by Karel Zak)

findmnt:
    - (usage) add a needed equals sign before an optional argument (by Benno Schulenberg)
    - add missing newline in --raw, --pair and --list output formats (by Christian Goeschel Ndjomouo)

fsck.cramfs:
    - check buffer size for memcpy() (by Karel Zak)

getopt:
    - document special symbols that should not be used as option characters (by cgoesche)

gitignore:
    - Ignore tests/diff/ and test/output/ (by Jesse Rosenstock)

hardlink:
    - (man) add note note about ULFILEEQ_DEBUG= (by Karel Zak)

include/mount-api-utils:
    - avoid using sys/mount.h (by Karel Zak)

libblkid:
    - Fix probe_ioctl_tp assigning BLKGETDISKSEQ as physical sector size (by Sam Fink)
    - (ext) reduce false positive (by 胡玮文)
    - improve UUID_SUB= description (by Karel Zak)

lib/color-names:
    - fix stupid bugs (by Karel Zak)
    - Fix color name canonicalization (by Karel Zak)

libfdisk:
    - (script) improve separator usage in named-fields dump (by Karel Zak)
    - (script) fix device name separator parsing (by Karel Zak)

liblastlog2:
    - markup fixes for man pages (by Mario Blättermann)

libmount:
    - don't report fsconfig errors with "nofail" (by Karel Zak)

lib/path:
    - avoid double free() for cpusets (by Karel Zak)

lib/strutils:
    - add ul_ prefix to strrep() and strrem() functions (by Karel Zak)
    - add ul_ prefix to split() function (by Karel Zak)
    - add ul_ prefix to strappend() functions (by Karel Zak)
    - add ul_ prefix to strconcat() functions (by Karel Zak)
    - add ul_ prefix to startswith() and endswith() (by Karel Zak)

lib/strv:
    - use ul_ prefix for strv functions (by Karel Zak)

logger:
    - fix buffer overflow when read stdin (by Karel Zak)
    - fix incorrect warning message when both --file and a message are specified (by Alexander Kappner)

lsblk:
    - fix possible use-after-free (by Karel Zak)
    - fix memory leak [coverity scan] (by Karel Zak)
    - use md as fallback TYPE when md/level empty (by codefiles)

lscpu:
    - New Arm C1 parts (by Jeremy Linton)
    - Add NVIDIA Olympus arm64 core (by Matthew R. Ochs)

man:
    - Fixed incorrect ipcrm options (by Prasanna Paithankar)
    - Replace RETURN VALUE with EXIT STATUS in section 1 (by Jesse Rosenstock)

mkfs.cramfs:
    - avoid uninitialized value [coverity scan] (by Karel Zak)

more:
    - temporarily ignore stdin when waiting for stderr (by Karel Zak)

po:
    - update uk.po (from translationproject.org) (by Yuri Chornoivan)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)
    - update pl.po (from translationproject.org) (by Jakub Bogusz)
    - update nl.po (from translationproject.org) (by Benno Schulenberg)
    - update ko.po (from translationproject.org) (by Seong-ho Cho)
    - update ja.po (from translationproject.org) (by YOSHIDA Hideki)
    - update hr.po (from translationproject.org) (by Božidar Putanec)
    - update fr.po (from translationproject.org) (by Frédéric Marchal)
    - update es.po (from translationproject.org) (by Antonio Ceballos Roa)
    - update de.po (from translationproject.org) (by Mario Blättermann)
    - update cs.po (from translationproject.org) (by Petr Písař)

po-man:
    - merge changes (by Karel Zak)
    - update uk.po (from translationproject.org) (by Yuri Chornoivan)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)
    - update pl.po (from translationproject.org) (by Michał Kułach)
    - update de.po (from translationproject.org) (by Mario Blättermann)
    - merge changes (by Karel Zak)
    - update es.po (from translationproject.org) (by Antonio Ceballos Roa)

rev:
    - add --zero option to --help output (by Christian Goeschel Ndjomouo)

setpriv:
    - Improve getgroups() Portability (by Karel Zak)

sfdisk:
    - reject spurious arguments for --reorder/--backup-pt-sectors (by Thomas Weißschuh)

tests:
    - add color names test (by Karel Zak)

tests/helpers/test_sigstate.c:
    - explicitly reset SIGINT to default action after trapping (by Hongxu Jia)

tools:
    - add git-version-next script release versioning (by Karel Zak)

zramctl:
    - ignore ENOENT when setting max_comp_streams (by Jiang XueQian)
    - fix MEM-USED column description (by Jérôme Poulin)

Misc:
    - Add missing ;; to -m case (#1) (by Nate Drake)


