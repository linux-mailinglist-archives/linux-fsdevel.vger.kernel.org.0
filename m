Return-Path: <linux-fsdevel+bounces-50539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1CBACD02B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911497A7E66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632DD225768;
	Tue,  3 Jun 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="M87ek/9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B026ACC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992690; cv=none; b=E3kraMHITvZ9hL/cCFxTWUUHby5GbVbjqPrSYqBut0/mDVcSruOHtTmCQSdSJH4qDkXKhkWGI26zGJG16X9tS+N8spwQlS8F8JxVlI2Dm/QCNof+YkQ7qiNnm+CGX98iUgIuJOfSBFTUQax7fVFD+yENKXjRNKbcwurLNw8l+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992690; c=relaxed/simple;
	bh=MSzDwI6OS8P7ElQZgFt85ZApsF/qPLH2mAZ10Sr9Y2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgT9MTtiyZ7dxhrSnWuEnFoqtw7EKiYZEBtdiGzx9C9sK4aKnyWtFQS5haSB31QcRNLc/Y1+Tz4APqvjfsfOQ4RgL8b3uVNcQw1uPoGh+reoLQxzPr/83llU0P25uftSFJT/J/PIHd5kf7WV//ijNAL1+KwaW2YrcEuRcOeD0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=M87ek/9s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZjD5VOCHfCos62husX8j5TXh/Le+1tMNVgAl85zhxtI=; b=M87ek/9s255hzTiDq1yObN5ow1
	Urfrdgdej7lf7xc/44dEwqZxjRPzu/9LDbyE28AWmCu7PKcIRq/qhG+y3NIUBeg81wBMoZWQB9EZz
	CrX/rxv0bsUwZYo0s1tnrKk8GxZ+albdDrP4JR3QT7HC15GN16YiQO26m0dlRSWRNvNBGFBiPjEak
	6wLPwfTCKrz4tou2NBNOSHlN5MQBMVlh0viZhd0tGEDXcjO439qEdDNqG+aSbivw7r9ytOllhQoaU
	3aCNG1Tb76zF/gjf+tNv2QzuH0iZLMRwkNSEbDAULFHTxJKTOGR+5hOEuUYtKO/ITgLihSxyzfEXB
	pr96aMkg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMatT-00000000cxk-12aS;
	Tue, 03 Jun 2025 23:18:07 +0000
Date: Wed, 4 Jun 2025 00:18:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/5] finish_automount(): don't leak MNT_LOCKED from parent to
 child
Message-ID: <20250603231807.GC145532@ZenIV>
References: <20250603231500.GC299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603231500.GC299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Intention for MNT_LOCKED had always been to protect the internal
mountpoints within a subtree that got copied across the userns boundary,
not the mountpoint that tree got attached to - after all, it _was_
exposed before the copying.

For roots of secondary copies that is enforced in attach_recursive_mnt() -
MNT_LOCKED is explicitly stripped for those.  For the root of primary
copy we are almost always guaranteed that MNT_LOCKED won't be there,
so attach_recursive_mnt() doesn't bother.  Unfortunately, one call
chain got overlooked - triggering e.g. NFS referral will have the
submount inherit the public flags from parent; that's fine for such
things as read-only, nosuid, etc., but not for MNT_LOCKED.

This is particularly pointless since the mount attached by finish_automount()
is usually expirable, which makes any protection granted by MNT_LOCKED
null and void; just wait for a while and that mount will go away on its own.

Include MNT_LOCKED into the set of flags to be ignored by do_add_mount() - it
really is an internal flag.

Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/mount.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mount.h b/include/linux/mount.h
index 6904ad33ee7a..1a3136e53eaa 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -65,7 +65,8 @@ enum mount_flags {
 	MNT_ATIME_MASK = MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME,
 
 	MNT_INTERNAL_FLAGS = MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL |
-			     MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED,
+			     MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED |
+			     MNT_LOCKED,
 };
 
 struct vfsmount {
-- 
2.39.5


