Return-Path: <linux-fsdevel+bounces-68858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D60C6785C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 706AB4F047A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA42F6939;
	Tue, 18 Nov 2025 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BapOXWjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF421E3DE5;
	Tue, 18 Nov 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442980; cv=none; b=aaS27J5e1juebb3Cp3n0rENjULKoQcVk0i0s4tmmTE1leivO+Pf6SF+jORlHboDnFYopzSWl7NafQM2eWgiUZ4/bal8suku8lxgvkcERpI6Yw7GqqmYmeqCkE5BuRvka4DaL7cz2XayBO3CFhVU60jt72uJF8bUSea5+rFFNsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442980; c=relaxed/simple;
	bh=dCgCvctHMZn/4pdh746UkJPY6JB/tha65QwZkN9yA6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8S56QtmvKxQpEG1Ko+xAH/pliWS9O7pEWPucBadyXqM+qh95O7HnVQVjKv9FyDalOJhkGFLrQiNzawhPvhJQyxQLh/YNY3qzdHzFCKJ8yi7Vy2uyyJHjuL992RewybPBzrYe9WDNkgaC+n6DtCHX8Lhx2JMptMf3ZTXPpfpcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BapOXWjG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4iwuLyMN17JmghA7oE4FXYqqV44QgzYixBKeo+FLe7E=; b=BapOXWjGs2VkVmavXIaruV9LIv
	fif5sNmvyXkkdrDgGBqvJe+gDqebM9jIRxp8VYwkQif2zT7dd60tH6gnsbnKJeM80HoeSo8cV3S/J
	7cvPXxsjHToUl2jyND5pdDnRqaqtmtee59nhp5aprgpMxQ49CNkCGicip3k3PR8jUsIkblO/bI4AM
	FcZG/9n0w2l0fF1uIyvfPbBmcvlR1gvM0n4aSfF2z+EJTtM5gBvSDcBVlz+eaYrnZbMLIYqc+tCHW
	WlzE5x5ZPhulvSTyNPvpiHrztKiIo4U5K/NsolyfyXElZgmK57FrofPikDQX4EEONIKZdExG+oCeI
	/m1h14/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4X-0000000GETR-0lJW;
	Tue, 18 Nov 2025 05:16:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org,
	clm@meta.com
Subject: [PATCH v4 38/54] functionfs: need to cancel ->reset_work in ->kill_sb()
Date: Tue, 18 Nov 2025 05:15:47 +0000
Message-ID: <20251118051604.3868588-39-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... otherwise we just might free ffs with ffs->reset_work
still on queue.  That needs to be done after ffs_data_reset() -
that's the cutoff point for configfs accesses (serialized
on gadget_info->lock), which is where the schedule_work()
would come from.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/function/f_fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 0bcff49e1f11..27860fc0fd7d 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2081,6 +2081,9 @@ ffs_fs_kill_sb(struct super_block *sb)
 		struct ffs_data *ffs = sb->s_fs_info;
 		ffs->state = FFS_CLOSING;
 		ffs_data_reset(ffs);
+		// no configfs accesses from that point on,
+		// so no further schedule_work() is possible
+		cancel_work_sync(&ffs->reset_work);
 		ffs_data_put(ffs);
 	}
 }
-- 
2.47.3


