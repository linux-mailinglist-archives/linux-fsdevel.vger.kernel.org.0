Return-Path: <linux-fsdevel+bounces-73598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67380D1C809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 05:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7559E3110A86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 04:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A08329E65;
	Wed, 14 Jan 2026 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GMgTl0Aq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788002EA731;
	Wed, 14 Jan 2026 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768365165; cv=none; b=PAHIoyQWOpR+pUWw0SRz/nzY4MGDJkw4ZUzxS0n46AM+uoCDxqd1w3+wlwORPnlbmSgkaq2V251Nbv2wqVz//dZY7vJQLKta6jXbYNdCWQW12B4wQW8KAxTOzTa6NgsmFay6ZYXg34bu+s2506kihby+sCTnO8b383nQgasln8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768365165; c=relaxed/simple;
	bh=3bqQoNek4pRxFqezsA2+g8zptv+Ik6YnPNJcq2bN3XM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K4gJaBHnJhDZVDmn5meOXCVX1SoPo/PtQsAlQdqdSgWPd5Wd5HUFIq6plzBP7mFHnAxCI6YiXzaNVcL6fxp7NCadaNDMlwqihxTUT+pl+eGb5W4SBGwtyEOle5vmlH9recXf8CbPR5cgCHk9G7uu6lpBvYNUcvKY10e73d60HI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GMgTl0Aq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PGZcLNgD2fLtRQC4vTg/9LPDYxs+kOJKJt/oECjLmSQ=; b=GMgTl0AqzoP4xsQQ5nlvusBqYw
	WNFHaxEgjT2CHbBr/vWX/PNgMb0EY0srxkSkS4VmQsiylvyR7IuAGFrtXN0Suwo2evNjgMam0UgWn
	ZWo4qUWKR3UWvjigItXSbxXMfF7UAiJRUXZqlI63x3HksaxE8XkGAEOtVXDF6jmqNy/TVEZb4YYcE
	DPb2sDH8712VJVH+32nEg+9ckLtt8Uw4OWSbosjC3pLWZYgMO1UYInzcZK9X30TjfLzL+HWXxMoi2
	1wjnED3VRSm5f2i4jsVifVTb9IJjRopufbxckKNcEFOvJHcR8AJPlFfNvgFOmXfzd+gimOVmM1U8C
	HE1+8QGg==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfsYO-0057lT-OX; Wed, 14 Jan 2026 05:32:20 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/3] fs: Support btrfs cloned images and overlayfs
Date: Wed, 14 Jan 2026 01:31:40 -0300
Message-Id: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC0cZ2kC/x3MTQqAIBBA4avIrBM0+oGuEiHhjDYEFlpRhHdPW
 n6L915IFJkSDOKFSBcn3kKBrgTYZQ6eJGMx1KrulNaNPLbwrNLTYZDTas6TUTqFTd8S6l5ZKOU
 eyfH9X8cp5w8GaC2xZQAAAA==
X-Change-ID: 20260114-tonyk-get_disk_uuid-f0d475ed170c
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Hi everyone,

As I reported some time ago, btrfs cloned images support and overlayfs
"index" check don't get along together[1]. Every time the same image
cloned is mounted, btrfs assigns a new random UUID for it to avoid
clashing with the exist UUID. This UUID is then used by overlayfs origin
check, to avoid reusing the same directory for a different filesystem.
Remounting the same filesystem in the same directory is supported, but
the different random UUIDs will make the check fail.

In an attempt to solve this, I reused export_operations::get_uuid() for
this purpose, to get the "real" UUID of a image, regardless of the
random UUID being exposed to userspace. overlayfs then use this UUID
internally for the origin check, and the remounting finally works.

I understand that not everyone is happy about repurposing get_uuid() for
that, but I'm totally open for going in another direction for solving
this problem not only for the combination of btrfs+overlayfs, but for
any filesytem that have similar issues with random UUIDs.

Using `btrfstune -m` or similar to change the cloned image UUID doesn't
work for the SteamOS use case, as we, well... use the UUIDs to identify
unmounted images and check if they are the same.

This series is based on top of another series[2], that should be available
at vfs-7.0.misc by now.

Thanks!

[1] https://lore.kernel.org/lkml/20251014015707.129013-1-andrealmeid@igalia.com/
[2] https://lore.kernel.org/lkml/20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com/

---
André Almeida (3):
      exportfs: Rename get_uuid() to get_disk_uuid()
      btrfs: Implement get_disk_uuid()
      ovl: Use real disk UUID for origin file handles

 fs/btrfs/export.c        | 20 ++++++++++++++++++++
 fs/nfsd/blocklayout.c    |  2 +-
 fs/nfsd/nfs4layouts.c    |  2 +-
 fs/overlayfs/copy_up.c   | 22 ++++++++++++++++++++--
 fs/xfs/xfs_export.c      |  2 +-
 fs/xfs/xfs_pnfs.c        |  2 +-
 fs/xfs/xfs_pnfs.h        |  2 +-
 include/linux/exportfs.h |  8 +++++---
 8 files changed, 50 insertions(+), 10 deletions(-)
---
base-commit: 336cebc7376296b2c25cf8433ff62b71fe929b0d
change-id: 20260114-tonyk-get_disk_uuid-f0d475ed170c

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


