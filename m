Return-Path: <linux-fsdevel+bounces-54024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B344AFA282
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 03:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CB319217C4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2663470830;
	Sun,  6 Jul 2025 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nCc6432T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00C11CA9
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751765211; cv=none; b=I1YIh042Toc4IjlyAAkeS+rsBo0ewgtpuYdjURFj59qsOvkMJqd5loWJJ9sYdZfq1wMtlL4lHcgEFj50LWzsMGxpcsmKjlpZvYBvMjtrwTkIAvJw/k2tTLAv/8axxpArM4Ueg+nIX9scmno7a/CrV4tHMcIfrwmV93VTmftm9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751765211; c=relaxed/simple;
	bh=fi+3/D7ITScfBWSECA2z7jNrB4zx4mdDxqddIvks/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsZrp3oqogSimwFKIb5tcdHuyNnJ/321wuc7rb4I+oWMTVqjpYTWj7FlcNTvMvtTCyBG/Gik/14gK52ZzlEff0gJfHRH7izH1IPofvW8T1NLqz1V0+WZyfTxSFX1BMYKotudiG/9rUVQZZajMmnO99gajaIsCfYyPOu8Jk2T6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nCc6432T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vPhc/3z6FBnI6+KLsoHMNDBR8cYhjBrMsQWLlaQY8Os=; b=nCc6432TvSIx3BcbsVA9h0r8+6
	2w5XNghn9fVBz0tsljw4DIe8W6sE+suoGMTRj7BIBmuXDX2MuLf1qqrLafVVJ4qeJtQ9ej29nmUEi
	BquA9uehq92p+qguZe/qChAiBKK2iaYPNO5C+SzVlQxSZWE7QG84vk8WjEtp+pv/LCQdLupiUPzO3
	Hky0budUYeh7MzQceJtVFW6I2bxRqnLi1mh/nHsAbkPVFlk/nYjY16t0LaukAxTnUf7Z/NnBDDTu2
	+U05Cf5IV/LbD0pGJTdAOK64TH+fmSkrx1BKeIj40IUa2UXXxR7eq/+2izHhjd3hcvw+dBMHPsMtP
	d7XfZEOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYE9V-00000006rym-2UsH;
	Sun, 06 Jul 2025 01:26:45 +0000
Date: Sun, 6 Jul 2025 02:26:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] fix a mount write count leak in ksmbd_vfs_kern_path_locked()
 (was Re: [RFC] MNT_WRITE_HOLD mess)
Message-ID: <20250706012645.GB1880847@ZenIV>
References: <20250704194414.GR1880847@ZenIV>
 <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
 <20250704202337.GT1880847@ZenIV>
 <20250705000114.GU1880847@ZenIV>
 <20250705185359.GZ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705185359.GZ1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

If the call of ksmbd_vfs_lock_parent() fails, we drop the parent_path
references and return an error.  We need to drop the write access we
just got on parent_path->mnt before we drop the mount reference - callers
assume that ksmbd_vfs_kern_path_locked() returns with mount write
access grabbed if and only if it has returned 0.

Fixes: 864fb5d37163 "ksmbd: fix possible deadlock in smb2_open"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 0f3aad12e495..d3437f6644e3 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1282,6 +1282,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 
 		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
 		if (err) {
+			mnt_drop_write(parent_path->mnt);
 			path_put(path);
 			path_put(parent_path);
 		}

