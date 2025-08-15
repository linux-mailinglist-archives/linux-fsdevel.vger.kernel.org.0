Return-Path: <linux-fsdevel+bounces-58060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF3DB288D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741D0580021
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65B2836B4;
	Fri, 15 Aug 2025 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uRWXZv75"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224B165F16
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301008; cv=none; b=TbEcIZZtGMNfTnsguWB/R25g9AMSDKkmmEHCG6QxFCI9+tlSin/LiPW6BlGfOmjJq9tznbwDZQGpajfusnsZ3nGhkkdN3ojY8XugmaaR9tdC6hfVhwWxk1S4F1wmwguqQJHORSt2BC9YPPBT0cpGgG73EbbfRYfa7mEZNLp/uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301008; c=relaxed/simple;
	bh=zFT3eQZswYMFK+2qFbKdmTIrMA5FaOTMd5ngb1gUdQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBRmpmRwNIaGNY1cDALIMEy42VD4X3p/LAyAKLxffLVQ8duxzYWZv6rW875K1h+asYS+nQgvhnqCA93PIkEN4LYB3oLjIa2zvNVWWMeAerIbMZcQrHJULGbfyKeVHkgVG13hxFt5GVO49msKoxF/7iMBGZ32fTaMtF4tOPcSenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uRWXZv75; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qdV/DM4FuFqZnRzYX/70SeHDWA1sVBYk5ZLA3LM4Y6M=; b=uRWXZv75nFNq+wayqhpz93S917
	EM5jNxNhjZJJlwhmeFvYSLwIr1TemrH5OLoYuRY8qIB+7gyF5HZ7W8wUDgYRCcFag13FHqxtouapu
	iudlIrax8PpG6blBJ6GrHafOppxR1d4UfNHKTEn3ZNROiC6FI9L37lkvblhunK/1xqKWYAflaFUzy
	k44rcJB+KmDYJFIaTmc+H83LqWMt6WDNw70/NUQBat16Ib7rbAmla1il0vpJn416wfdZncN7NPodx
	dVoe3h6knZkslH5mjW8k/MgK/zctcd4i3NHGsym14RUC/wtEozZa58eCx8zgVsZyriKmLIQv8MaDX
	R/E2JREg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un3yX-00000008uYX-2Ogv;
	Fri, 15 Aug 2025 23:36:45 +0000
Date: Sat, 16 Aug 2025 00:36:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@google.com>,
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: [PATCH 4/4] change_mnt_propagation(): calculate propagation source
 only if we'll need it
Message-ID: <20250815233645.GD2117906@ZenIV>
References: <20250815233316.GS222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815233316.GS222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

We only need it when mount in question was sending events downstream (then
recepients need to switch to new master) or the mount is being turned into
slave (then we need a new master for it).

That wouldn't be a big deal, except that it causes quite a bit of work
when umount_tree() is taking a large peer group out.  Adding a trivial
"don't bother calling propagation_source() unless we are going to use
its results" logics improves the things quite a bit.

We are still doing unnecessary work on bulk removals from propagation graph,
but the full solution for that will have to wait for the next merge window.

Fixes: 955336e204ab "do_make_slave(): choose new master sanely"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 1c789f88b3d2..6f7d02f3fa98 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -111,7 +111,8 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		return;
 	}
 	if (IS_MNT_SHARED(mnt)) {
-		m = propagation_source(mnt);
+		if (type == MS_SLAVE || !hlist_empty(&mnt->mnt_slave_list))
+			m = propagation_source(mnt);
 		if (list_empty(&mnt->mnt_share)) {
 			mnt_release_group_id(mnt);
 		} else {
-- 
2.47.2


