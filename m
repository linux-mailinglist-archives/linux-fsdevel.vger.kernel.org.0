Return-Path: <linux-fsdevel+bounces-68793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E390C66639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D86084E685C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A85334B410;
	Mon, 17 Nov 2025 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="K4pKqDPp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411132ABC5;
	Mon, 17 Nov 2025 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417100; cv=none; b=JO17w18WcQW+OlIC7cAKqAVY3KkZYKr9zOUUpXQBBiNjZSoB8rk9wXE9qXPedJWIyyt5xeCO50heTcSmSne94Q/TxTsyPwsWM1A5+VXRIi2JJTJk00Xi3HwWe6yjP/67c6EwCOygr5SqnBmUhJF1ma7rApPp+x3Tuivg600ZFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417100; c=relaxed/simple;
	bh=fFMWlH69r8HpJVGV53gIEcoOwzgU0lKUHD3VLDlEcFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnj3U8SCW9F/YhNg2Bz5a6JGjv88zTzr0D9L43XxJYoFBcnqHUCNn2vsCYA2Cuxco/TEL+mmJt36jTtAbWZbLQV5qfGGrgWyhNTgWfpZq2aq4rmuna081qnFulyLCy7/TijBvweRE8jvf17X27Yo4oLDTc8nAAEXZsQpY8xSCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=K4pKqDPp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YbheTvDaLhIgSaMH09DWUPWaNZLIZj4gJqU2BhcofhA=; b=K4pKqDPpn8ieOd7dgDMMLcn6hP
	YNkd5iTaJ9jsJ6HthOi27ouRU1rNzpQpkIHQ1O6A2/2FiLiaAibHOmWkYp/AOXQgfxTiNakwk4VWN
	NcsWmqf5yGTRpDBy5+7fZnGgnhWR5lt0hFrBwOtoA+FJjR8GJRkDUlO881F4SvvLWjbrq9rxny92x
	mOXpWfdfvEiGES+7atowUfisqBHjBgAmRr9k8GpIHjJKa1c6uv45lHJl1qsk0q4U6ZanrchMFffNj
	5hTR+ZeOd97zj4pyRLctc6xo20wRCLS99xBAz8a0141JHzOjSTJAnPJLI14jnX1Xuq+5uvJGlYyD3
	ubOeBgsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL7LD-00000007KkO-3TmK;
	Mon, 17 Nov 2025 22:04:55 +0000
Date: Mon, 17 Nov 2025 22:04:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, ihor.solodrai@linux.dev,
	Chris Mason <clm@meta.com>
Subject: [PATCH 1/4] functionfs: don't abuse ffs_data_closed() on fs shutdown
Message-ID: <20251117220455.GA1745314@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
 <20251114074614.GY2441659@ZenIV>
 <2025111555-spoon-backslid-8d1f@gregkh>
 <20251117220415.GB2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117220415.GB2441659@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

ffs_data_closed() has a seriously confusing logics in it: in addition
to the normal "decrement a counter and do some work if it hits zero"
there's "... and if it has somehow become negative, do that" bit.

It's not a race, despite smelling rather fishy.  What really happens
is that in addition to "call that on close of files there, to match
the increments of counter on opens" there's one call in ->kill_sb().
Counter starts at 0 and never goes negative over the lifetime of
filesystem (or we have much worse problems everywhere - ->release()
call of some file somehow unpaired with successful ->open() of the
same).  At the filesystem shutdown it will be 0 or, again, we have
much worse problems - filesystem instance destroyed with files on it
still open.  In other words, at that call and at that call alone
the decrement would go from 0 to -1, hitting that chunk (and not
hitting the "if it hits 0" part).

So that check is a weirdly spelled "called from ffs_kill_sb()".
Just expand the call in the latter and kill the misplaced chunk
in ffs_data_closed().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/function/f_fs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 47cfbe41fdff..43926aca8a40 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2071,12 +2071,18 @@ static int ffs_fs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void ffs_data_reset(struct ffs_data *ffs);
+
 static void
 ffs_fs_kill_sb(struct super_block *sb)
 {
 	kill_litter_super(sb);
-	if (sb->s_fs_info)
-		ffs_data_closed(sb->s_fs_info);
+	if (sb->s_fs_info) {
+		struct ffs_data *ffs = sb->s_fs_info;
+		ffs->state = FFS_CLOSING;
+		ffs_data_reset(ffs);
+		ffs_data_put(ffs);
+	}
 }
 
 static struct file_system_type ffs_fs_type = {
@@ -2114,7 +2120,6 @@ static void functionfs_cleanup(void)
 /* ffs_data and ffs_function construction and destruction code **************/
 
 static void ffs_data_clear(struct ffs_data *ffs);
-static void ffs_data_reset(struct ffs_data *ffs);
 
 static void ffs_data_get(struct ffs_data *ffs)
 {
@@ -2171,11 +2176,6 @@ static void ffs_data_closed(struct ffs_data *ffs)
 			ffs_data_reset(ffs);
 		}
 	}
-	if (atomic_read(&ffs->opened) < 0) {
-		ffs->state = FFS_CLOSING;
-		ffs_data_reset(ffs);
-	}
-
 	ffs_data_put(ffs);
 }
 
-- 
2.47.3


