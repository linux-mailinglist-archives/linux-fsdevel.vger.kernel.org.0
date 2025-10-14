Return-Path: <linux-fsdevel+bounces-64065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BED79BD707C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 03:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FA884EF976
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3D28FFFB;
	Tue, 14 Oct 2025 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e8XIkMoq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4426A1BE;
	Tue, 14 Oct 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407043; cv=none; b=NdLDzccF7UKdc2kVLz0MlLfsbG4mJbAiQyo3G5uXYS8hJ37ElgVMm0WbqBOe/rb7Hhk5uTolydUEou+hs1JMlBQG8kgN5m2DhMfJyU2XH71aPpUauZmOfVwPWL0s44gl+JMAHeDFDJX1gZJH7L4MLgHd3vivXJDebFgkkg7lZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407043; c=relaxed/simple;
	bh=Oqt/yBcgVx7BhuOQL+agsmlspuaZSb0JOxbtCNoMtrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omPHXK74fLSLKQkIYLqbbSKk6ADxUGJ7Ofv5MHYH/1RDQnDCsJnqevdNhlDVeyODNTGzNiD0FtGZOMllbffP7O/GhYvOaGxKLbwm5piRuCXhZ/S/D3kDdZrt92JlA/e79e/TBUfQFsBdxxBq2m93KqXZx36a3/YaiBpivfC4Tbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e8XIkMoq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZzTJJknKmouz2rKtG2H5KFU2eOelF6b82EBvZV3gFjw=; b=e8XIkMoq1FDMjpj1vGFBIIa+53
	ypOJ45hj/qZ6Q3fCBNwSpeao642MjEMIqyJ0iH75lAaEzDNQAyATCrgrvB29p/mo5kq3SxD02RDq6
	cPe33c94NZs1SNF3GCtBnGLo6G0C2uekPbqAIQBzvec+ERlWIbxyUxGyRgPcUgHP2wrXBGCf3z9ej
	czTP1zlhRR9yw+7gJKDVWxhwYTdNiRuOiF9Cen+QanuMr2iIhjaFdEr4HcyEZaXMb292mfCc0u5Au
	mPiM+9NpiyqYHj3lC/ID9DX55IAt9eN4B5sIUk52L82bLqvbwSf12mguOOsFzLAVSBGV9ylal2kDK
	tfptmNsw==;
Received: from [168.121.99.42] (helo=X1)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8UHq-009Bzy-8p; Tue, 14 Oct 2025 03:57:14 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Anand Jain <anand.jain@oracle.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl index=on
Date: Mon, 13 Oct 2025 22:57:06 -0300
Message-ID: <20251014015707.129013-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

When using overlayfs with the mount option index=on, the first time a directory is
used as upper dir, overlayfs stores in a xattr "overlay.origin" the UUID of the
filesystem being used in the layers. If the upper dir is reused, overlayfs
refuses to mount for a different filesystem, by comparing the UUID with what's
stored at overlay.origin, and it fails with "failed to verify upper root origin"
on dmesg. Remounting with the very same fs is supported and works fine.

However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
disk image with btrfs, a random UUID is assigned for the following disks each
time they are mounted, stored at temp_fsid and used across the kernel as the
disk UUID. `btrfs filesystem show` presents that. Calling statfs() however shows
the original (and duplicated) UUID for all disks.

This feature doesn't work well with overlayfs with index=on, as when the image
is mounted a second time, will get a different UUID and ovl will refuse to
mount, breaking the user expectation that using the same image should work. A
small script can be find in the end of this cover letter that illustrates this.

From this, I can think of some options:

- Use statfs() internally to always get the fsid, that is persistent. The patch
here illustrates that approach, but doesn't fully implement it.
- Create a new sb op, called get_uuid() so the filesystem returns what's
appropriated.
- Have a workaround in ovl for btrfs.
- Document this as unsupported, and userland needs to erase overlay.origin each
time it wants to remount.
- If ovl detects that temp_fsid and index are being used at the same time,
refuses to mount.

I'm not sure which one would be better here, so I would like to hear some ideas
on this.

Thanks!
	André

---

To reproduce:

mkdir -p dir1 dir2

fallocate -l 300m ./disk1.img
mkfs.btrfs -q -f ./disk1.img

# cloning the disks
cp disk1.img disk2.img
sudo mount -o loop ./disk1.img dir1
sudo mount -o loop ./disk2.img dir2

mkdir -p dir2/lower aux/upper aux/work

# this works
sudo mount -t overlay -o lowerdir=dir2/lower,upperdir=aux/upper,workdir=aux/work,userxattr none dir2/lower

sudo umount dir2/lower
sudo umount dir2

sudo mount -o loop ./disk2.img dir2

# this doesn't works
sudo mount -t overlay -o lowerdir=dir2/lower,upperdir=aux/upper,workdir=aux/work,userxattr none dir2/lower

André Almeida (1):
  ovl: Use fsid as unique identifier for trusted origin

 fs/overlayfs/copy_up.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.51.0


