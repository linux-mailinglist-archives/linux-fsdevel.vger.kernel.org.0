Return-Path: <linux-fsdevel+bounces-26950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7A95D465
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931B31C226AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85119307B;
	Fri, 23 Aug 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Xrty0Hnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8DB1925BD;
	Fri, 23 Aug 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434434; cv=none; b=HHhQiGaS+WmcSEJIbB6O83735JE3w3ewNodPPe1BHa734eVvdD0MaaZZSIrDJZSowzbWd+smCBO4LOUo1UtySnqLo+1BUlPY9KU216iTzIJFcZzDPm0qBgInfMc3mWCNSK0P5RSbqEiMuL+S1tSPeR3gXqGzVXtbbHLdIc0B470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434434; c=relaxed/simple;
	bh=SOVQqgNqJtR/+1Gf55+3TQb+lOiY3C7sFKejcvIlGt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O8FPPT2Obb/D268xqufXaBvfoFgYstFFQsRLRvZ3VAzn3WqE7yofXbtSGCYZQv3o4xqJlIC5GEpvV1d47/IH/hALtPEb5U8H8CR9ZHXD1+VzpOoTzwyN16I/qlJypkrR27cSguXjJ88sNJO8k7Mna9mwCHq9SScZGZQKFiR7/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Xrty0Hnc; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SxyIC5tFq6AtUq6R3df3UAsAHokn3gBbCFeE0EbVRo8=; b=Xrty0Hnc0QheTY7+MW9JDReDc1
	lgyN0AvuKVbjlkbjEtNp0FHvW4At/7wR2mkF/aShDa0OJpQjpAqK7xv4cTtSb1qtoOHGrov2C1vmg
	NNbLrVQtqHzd2CCGTtmzNInAOiTDeHuPWcNteHD96t83+XbRdQ9R1NNtm6LWBjCrKVyNJq4FIHtjb
	GSjk/uE7JMGiCbsGbDIqu+wvDSn4AeC5/IYp2tvuYYnsOyZg0dj7UES9hYOW9wWna5FnbTXHswPab
	g65joXcwN4RvGEPse9A7GGv6FMU2ZucgMVt/f9m7ejBAMTj0yQcQ8Hk1n9dSQfPjsmxjsq2BPn7wW
	5LnIAJXQ==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1shYAM-0048Ww-1V; Fri, 23 Aug 2024 19:33:37 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	krisman@kernel.org,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/5] tmpfs: Add case-insesitive support for tmpfs
Date: Fri, 23 Aug 2024 14:33:27 -0300
Message-ID: <20240823173332.281211-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series is based on [0].

This patchset adds support for case-insesitive file names lookups in tmpfs. The
main difference from other casefold filesystems is that tmpfs has no information
on disk, just on RAM, so we can't use mkfs to create a case-insensitive tmpfs.
For this implementation, I opted to have a mount option for casefolding. The
rest of the patchset follows a similar approach as ext4 and f2fs.

* Use case (from the original cover letter)

The use case for this feature is similar to the use case for ext4, to
better support compatibility layers (like Wine), particularly in
combination with sandboxing/container tools (like Flatpak). Those
containerization tools can share a subset of the host filesystem with an
application. In the container, the root directory and any parent
directories required for a shared directory are on tmpfs, with the
shared directories bind-mounted into the container's view of the
filesystem.

If the host filesystem is using case-insensitive directories, then the
application can do lookups inside those directories in a
case-insensitive way, without this needing to be implemented in
user-space. However, if the host is only sharing a subset of a
case-insensitive directory with the application, then the parent
directories of the mount point will be part of the container's root
tmpfs. When the application tries to do case-insensitive lookups of
those parent directories on a case-sensitive tmpfs, the lookup will
fail.

For example, if /srv/games is a case-insensitive directory on the host,
then applications will expect /srv/games/Steam/Half-Life and
/srv/games/steam/half-life to be interchangeable; but if the
container framework is only sharing /srv/games/Steam/Half-Life and
/srv/games/Steam/Portal (and not the rest of /srv/games) with the
container, with /srv, /srv/games and /srv/games/Steam as part of the
container's tmpfs root, then making /srv/games a case-insensitive
directory inside the container would be necessary to meet that
expectation.

* Testing

I send a patch for xfstests to enable the casefold test (generic/556) for tmpfs.[1]
The test succeed.

You can test this patchset using:

  sudo mount -t tmpfs -o casefold=utf8-12.1.0 tmpfs mnt/

And making a dir case-insesitive:

  mkdir mnt/dir
  chattr +F mnt/dir

[0] https://lore.kernel.org/linux-fsdevel/20210323195941.69720-1-andrealmeid@collabora.com/
[1] https://lore.kernel.org/fstests/20240823173008.280917-1-andrealmeid@igalia.com/

André Almeida (5):
  tmpfs: Add casefold lookup support
  tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs
  tmpfs: Create casefold mount options
  tmpfs: Expose filesystem features via sysfs
  docs: tmpfs: Add casefold options

 Documentation/filesystems/tmpfs.rst |  37 +++++
 include/linux/shmem_fs.h            |   7 +-
 mm/shmem.c                          | 205 ++++++++++++++++++++++++++--
 3 files changed, 238 insertions(+), 11 deletions(-)

-- 
2.46.0


