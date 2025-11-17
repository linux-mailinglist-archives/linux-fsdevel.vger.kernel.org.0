Return-Path: <linux-fsdevel+bounces-68795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA4C6666C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 31F9D299E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573B34C141;
	Mon, 17 Nov 2025 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pqNWxOKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D93446CF;
	Mon, 17 Nov 2025 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417173; cv=none; b=Vk102emLgUtJtcqbskaxhRlsnhp3Cja7CO+KNI3Ka160GzmRrhgyTM2QT6Sm4qEP9Q30vwERtphgn05NCZCIyfxdTxRPm/YLyF8mBj1oC6EaT6uHhYPesCwaJLJllM9Dk7wSMrcyTDWeqOTFWbMyIr3/0CqpwKhwqiEbHfSuE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417173; c=relaxed/simple;
	bh=vSOvabJpv63YuuT2dnekYBScJkKsi1ah4m6Y6/eXR+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUVM/9IhCyo9enU/ySq6oSc/BGa9rtpHUdHMrv2YDWFTrEk1c+9VWGJjXLwxV+PXZbshjputgD+dnTLTgtHgHjthccLHeNWfQEkpkjM5AcIFrcWiQUaOwjRRRMrMX292isjpx0chZCPwbdiOF80XJadjYQvhgrZ2K4bPgEDABPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pqNWxOKL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cWu60E9A6eXyK8hzFZrjRSDEhFiIM1wWoXt1TAJWCcw=; b=pqNWxOKL+lbKRWfwobdUpl+/CV
	FcB+NN4AnY+inY4vDZGGcMrdUGyeqhRm7MfkvQuub3rnJfDwBilzKnvLWSwotdOFmy7j9ZACrxOah
	bI+DiB2vEhxdAsNCrUqPAcG+4DnBsP4tTJsXlbNqbm4xhcmuZDcb4Xv2P9y/KmD/wK1zeAYOZCAnc
	M+7iRmhBwl+iF9VqgMjyYbEp48RREHAm09kCiAeBo5irXFHK83o47/cHAXqVvTI1NvdDqD4DdbzgO
	Mme0uqmBRdU1Piy6uk54hLooqG0LNlg6hm0MiXcK+rUE3cQx0+SOKw0v2SRLNhld45JqeQ6WL3lJb
	Sp9BIcFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL7MP-00000007MQ0-1yLf;
	Mon, 17 Nov 2025 22:06:09 +0000
Date: Mon, 17 Nov 2025 22:06:09 +0000
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
Subject: [PATCH 3/4] functionfs: need to cancel ->reset_work in ->kill_sb()
Message-ID: <20251117220609.GC1745314@ZenIV>
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

... otherwise we just might free ffs with ffs->reset_work
still on queue.  That needs to be done after ffs_data_reset() -
that's the cutoff point for configfs accesses (serialized
on gadget_info->lock), which is where the schedule_work()
would come from.

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


