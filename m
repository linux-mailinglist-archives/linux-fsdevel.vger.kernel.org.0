Return-Path: <linux-fsdevel+bounces-46102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C504A8299D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38145178510
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4A2676C1;
	Wed,  9 Apr 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qJFa6PuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2A264603;
	Wed,  9 Apr 2025 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210860; cv=none; b=Vo/vsDhasHP5oao5ZsVKlOAap+zX10Il6oSOVJ6AHy9YfQqmyWv5Tfnx8w6AoCGJlih8NubaIFPHM+pXb6H6D4mVIcSgAWDB/fcCPnPKigwyOGvldukksrA6HdkF55QWAyFsAS090JU6E7B1y3pAw3sDmdQIrdDr7YODJHDOxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210860; c=relaxed/simple;
	bh=GiipiJO8p0lYp7crpmIzr6VfZgHQAs666AOVaoGECtI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dH0sB3agNr5+LvEQ5NA2Zpl5oVUxlA5tZnEAz3LRunh/IEirHjXkyJjyyWycFymxRqunjqRiDqphjq0Gh5QL6D/gOTNTBuDtZtJd/8+ZzcOjneIta5JZM5wmSK71ee6Z+fIqGVZVG/2dKxaUAliMfcVd0AI11sjZqT61dSapME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qJFa6PuU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5CEaKRGjI93msX9Jpav0RJs0AF+4W1KNPIEqhLX+xL8=; b=qJFa6PuUEn+FsEOzPd5dYyyudZ
	mmaekCRwe4uNtClXDtrgH2TxjVpbypNdWckvd6JDOiyT6RhgiwuGvu2x+c0FDTiDMph7oX86F+c1T
	sinfHUOiwq3ctZbH2FumjFe2HddlJF60SYAG8FoDzzhHyiVUchZktMEIa5d8Me8FU8oeksmzOf+w8
	78pxNkN37GaBUGTlUhV2YRVArp4GuAYS+n+oOT0THCgLOmj92qnV4+Be2fGUMSuUZ74EyOE2YuKBx
	/vPb3Wou80NCsvseilCnW+2+8oKNR/tfGiq/tcnUvMhtQgmF8fiP+AhWung7bqh46LxcXLbjegAwQ
	DCLPapTg==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u2Wv0-00EBVR-Vi; Wed, 09 Apr 2025 17:00:47 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/3] ovl: Enable support for casefold filesystems
Date: Wed, 09 Apr 2025 12:00:40 -0300
Message-Id: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJiL9mcC/x3MQQqAIBBA0avIrBMslLCrRAvJsYZCQ0OS8O5Jy
 7f4/4WEkTDBxF6ImClR8A19x2Ddjd+Qk22GQQxKSKH5HXw5eMgYT1Nc4kr3TqG0UowGWnVFdPT
 8x3mp9QM2JJNpYQAAAA==
X-Change-ID: 20250409-tonyk-overlayfs-591f5e4d407a
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Hi all,

We would like to support the usage of casefold filesystems with
overlayfs. This patchset do some of the work needed for that, but I'm
sure there are more places that need to be tweaked so please share your
feedback for this work.

* Implementation

The most obvious place that required change was the strncmp() inside of
ovl_cache_entry_find(), that I managed to convert to use d_same_name(),
that will then call the generic_ci_d_compare function if it's set for
the dentry. There are more strncmp() around ovl, but I would rather hear
feedback about this approach first than already implementing this around
the code.

* Testing

I used tmpfs to create a small ovl like this:

sudo mount -t tmpfs -o casefold tmpfs mnt/
cd mnt/
mkdir dir
chattr +F dir
cd dir/
mkdir upper lower
mkdir lower/A lower/b lower/c
mkdir upper/a upper/b upper/d
mkdir merged work
sudo mount -t overlay overlay -olowerdir=lower,upperdir=upper,workdir=work, merged
ls /tmp/mnt/dir/merged/
a  b  c  d

And ovl is respecting the equivalent names. `a` points to a merged dir
between `A` and `a`, but giving that upperdir has a lowercase `a`, this
is the name displayed here.

Thanks,
	André

---
André Almeida (3):
      ovl: Make ovl_cache_entry_find support casefold
      ovl: Make ovl_dentry_weird() accept casefold dentries
      ovl: Enable support for casefold filesystems

 fs/overlayfs/namei.c     | 11 ++++++-----
 fs/overlayfs/overlayfs.h |  2 +-
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/params.c    |  5 +++--
 fs/overlayfs/readdir.c   | 32 +++++++++++++++++++++-----------
 fs/overlayfs/util.c      | 12 +++++++-----
 6 files changed, 39 insertions(+), 24 deletions(-)
---
base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
change-id: 20250409-tonyk-overlayfs-591f5e4d407a

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


