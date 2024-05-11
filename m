Return-Path: <linux-fsdevel+bounces-19302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1ED8C2FA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 07:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5BC283E8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DE4653C;
	Sat, 11 May 2024 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Q2+Le2JP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA61802
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715404696; cv=none; b=FHkKTmeDDYm4vr0MC/7QiHfc5NU2H8eNaXZ7qQ9ZOrvPmJns+KJ8zD5DsqQa+DjkEuHhcLZcPj0gL+2VjKO6wxyi2Bl9O6OBpIQAivZX6r/bqtwQfsmWpP0rCsEGXBrLjX+8RmKlUohbprgjzS6knzZ/2A9I73hkHJAp4Jaco9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715404696; c=relaxed/simple;
	bh=/RPxFGBSqLww9As2WU1/MfB0TprU7XXjX3O2+8SluRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU69yv7Lh0X/0ExVHHmCceZ52EZl1XImoPZE4e7Kc5eZlAuD9emIAShyoqcxCNncEPIFKfJeZPwdFCHU/PHl+/iUK55hjtkyvfu6b/c3F+BlIFjgQ52Z82A3KSYerPKnHitTre3bmJ0HzB2v12iq87NVdhllMJSIRaWXPGMR48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Q2+Le2JP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q4gBTfjzU09eCgB2OaabXWWrDVP+2gWh6xciB+TkkYo=; b=Q2+Le2JPmwqp6bGdez9fD4neuA
	DUKjvjnzHTWsW8Q6Po6sJ2LfiBdWA9Yh0Ni4nbbUMlNHzYrmYhxP4rfxbtHl2VsWQPCaY/5QujH/Q
	7fgBLHHqUiYa3QnA+ME/NSzfofWH5HemFd36sX2mMSxFFXXSFLuzVoc+72B1lq9jkR4uMM/EAFg9Z
	2yLSrZFD552zKceAv9IgylgyloOzh0YrTFbxYO2ppx4QZBpp7ZyJxCRgwmJLTZYOEATyo5pkhzuwb
	vBtaIrzi+teSTa47NBu0ChQOBmhRCxtfPmQNPhyMq5Y1Ifc8KFgp/BxCF7sXFba5mviy6iTK2Ll62
	JoKqDsKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5f7X-003Iw6-2C;
	Sat, 11 May 2024 05:18:07 +0000
Date: Sat, 11 May 2024 06:18:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>,
	Colin Walters <walters@verbum.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
Message-ID: <20240511051807.GA2118490@ZenIV>
References: <20240511022729.35144-1-laoar.shao@gmail.com>
 <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <20240511033619.GZ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511033619.GZ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 11, 2024 at 04:36:19AM +0100, Al Viro wrote:

> Said that, I seriously suspect that there are loads where it would become
> painful.  unlink() + creat() is _not_ a rare sequence, and this would
> shove an extra negative lookup into each of those.
> 
> I would like to see the details on original posters' setup.  Note that
> successful rmdir() evicts all children, so that it would seem that their
> arseloads of negative dentries come from a bunch of unlinks in surviving
> directories.
> 
> It would be interesting to see if using something like
> 	mkdir graveyard
> 	rename victim over there, then unlink in new place
> 	rename next victim over there, then unlink in new place
> 	....
> 	rmdir graveyard
> would change the situation with memory pressure - it would trigger
> eviction of all those negatives at controlled point(s) (rmdir).
> I'm not saying that it's a good mitigation, but it would get more
> details on that memory pressure.

BTW, how about adding to do_vfs_ioctl() something like
	case FS_IOC_FORGET:
		shrink_dcache_parent(file->f_path.dentry);
		return 0;
possibly with option for dropping only negatives?

Even in the minimal form it would allow userland to force eviction
in given directory tree, without disrupting things anywhere else.
That's a trivial (completely untested) patch, really -

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d5abfdf0f22..342bb71cf76c 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -878,6 +878,12 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FS_IOC_GETFSSYSFSPATH:
 		return ioctl_get_fs_sysfs_path(filp, argp);
 
+	case FS_IOC_FORGET:
+		if (arg != 0)	// only 0 for now
+			break;
+		shrink_dcache_parent(filp->f_path.dentry);
+		return 0;
+
 	default:
 		if (S_ISREG(inode->i_mode))
 			return file_ioctl(filp, cmd, argp);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 45e4e64fd664..143129510289 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -222,6 +222,7 @@ struct fsxattr {
 
 #define	FS_IOC_GETFLAGS			_IOR('f', 1, long)
 #define	FS_IOC_SETFLAGS			_IOW('f', 2, long)
+#define	FS_IOC_FORGET			_IOW('f', 255, int)
 #define	FS_IOC_GETVERSION		_IOR('v', 1, long)
 #define	FS_IOC_SETVERSION		_IOW('v', 2, long)
 #define FS_IOC_FIEMAP			_IOWR('f', 11, struct fiemap)

