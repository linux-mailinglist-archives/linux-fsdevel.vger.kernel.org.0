Return-Path: <linux-fsdevel+bounces-42529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4143A42EF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA4516F42D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C91DB55C;
	Mon, 24 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sRvDgVtv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA11DC997
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432058; cv=none; b=aSTy3py86RlTXyl/haY+kPkgvLUBys+Zed3KfgXWrFO8J9uoJASV+1wcg0PEjlBOaSA3xxyjTm27MUEEiwJYGGfzpH7bKWNTfI5wC7c2imXeBWYFaZID+4zg174S+wXC4dI9rvRjxofI2xayo0nkCaEED1hOOxCCGPM/RaGqZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432058; c=relaxed/simple;
	bh=LBHzn7RwOklAdFp3WzStKaRTJOCVYgwhY4tORFpR+A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPGEDDK6JqmV+AC7KPoExpd5k4AA6wo/AI5ASK18/LVw6uWrj+A0c8pbYX8XvGUGdBMFgSLbvDOoEbKBYKeViV3bW4XUBQFXjHhy0poM95HSYTnUsa5ZSFp3KecvzNKElQOgAxou6Erkb6I2prR1YGxmfwrwv1jZ0Xm8KW1CIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sRvDgVtv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oOQGNCemIs5zXD0VP/IqJ2UgtHWT3XXigibo/hkPmbw=; b=sRvDgVtvqOAz+GF13vTKP7jH84
	PdGRxcmQrgPHnOanfCOEoOdC2feSB38YLz2F+iNZQZKMTVYeV2Cr2HVN4KEYf9xiEnib3bAC8KR69
	DdnfwlsoMFO1H9GC847j6ysCwKPmBIEcsPRVM7cBXyt9OJsXyqsKoHJ5H4h0i8drmx/jZcEcLENiL
	RxFw5OYALGbaFbWbroF4dE3FPeQLyHhT/6GFa5EnuIZSC/PdIB7qzn0i0VGtOctdqKNk9lUevwO41
	RBwIPNGqZD9i5k9RmsDPJG5F5jPZCRq1vQiXAmjVKvdTkFXiD1UVyWehOtOQuLZ71UxvAV6v1YDi/
	ziqAPSWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsj-00000007MzG-2CyE;
	Mon, 24 Feb 2025 21:20:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 17/21] 9p: don't bother with always_delete_dentry
Date: Mon, 24 Feb 2025 21:20:47 +0000
Message-ID: <20250224212051.1756517-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

just set DCACHE_DONTCACHE for "don't cache" mounts...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_dentry.c | 1 -
 fs/9p/vfs_super.c  | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 5061f192eafd..04795508a795 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -127,7 +127,6 @@ const struct dentry_operations v9fs_cached_dentry_operations = {
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
-	.d_delete = always_delete_dentry,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
 	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 5c3dc3efb909..795c6388744c 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -134,10 +134,12 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	if (retval)
 		goto release_sb;
 
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		set_default_d_op(sb, &v9fs_cached_dentry_operations);
-	else
+	} else {
 		set_default_d_op(sb, &v9fs_dentry_operations);
+		sb->s_d_flags |= DCACHE_DONTCACHE;
+	}
 
 	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
-- 
2.39.5


