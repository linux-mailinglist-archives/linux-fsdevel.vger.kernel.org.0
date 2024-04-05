Return-Path: <linux-fsdevel+bounces-16210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A489A26B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419B51C21B5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A1171656;
	Fri,  5 Apr 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="arE4UiGD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5717164E;
	Fri,  5 Apr 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334226; cv=none; b=T1YlEj7b0DtsDWLDq/1QSGArdO3Nx+Ym/RwPt7RESauZAeShm66CdZmDmfZ4mnbVL7Vjiy9VoWEHf2ZjzT1a5Nifw+QJbwzD/ilwIpV32mdJtfn3gxXMo0oB+X8dAdOCC3RsMJqv/OyYJNe3rA6hwM9iGopCurjvHsadK4Ja4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334226; c=relaxed/simple;
	bh=yQwnPJwEQYu9fX0Y+AyQBdUHzuvzjDribddGeoztlJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5mmJn+8JEE8epqXwsRofGdFhvAmkJsQGqiZ8LQeGyTpoR7BUHMNeh+wEd0xbWnxFdSDa2qMMLwA07I2ocEp0oSL5b2SGS4Yq8kvJV1GW9mwCxusFMuwEJPprQVPr0FEUlQL2n62wFPp4NZjc5WVUsscwCajnq6i0yA6ST40pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=arE4UiGD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=arvQmQUbCzmXxGsLUTemBamkFbcSe28YZx+4in1OsC4=; b=arE4UiGDJMHJCOuYz0k/QMkQpd
	v5AAkhjF4BWEFyeh6KI3mtA8rKUqooynRdqNRaLPKKWDlvmhrR0165RWL32l0xtyi/aAG4Q8xPn1E
	KRfhmzT3rLn6Ski9UFu5pGAydobawe96V9+Rnp157aFiD5XAkPckSbrV7+zJfZObVH+RZ8GrVjs1m
	cXh+ToZ2kDa5iKHhYJUXwlAvz1MFFMIbhxHG714ZGoBfw5tUMtHpv1McTIjqJazr7y2x5qiA/H/JN
	nazBYFKbT5AYqPCznOXEE9Ye8wUDJLIzvs8Y4xq3J8vQ5Vvt9Hq0TJVqbgyLasKpsaHDn3chfyI8K
	TiYzPNvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsmLl-006V3K-2H;
	Fri, 05 Apr 2024 16:23:33 +0000
Date: Fri, 5 Apr 2024 17:23:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com, tj@kernel.org,
	valesini@yandex-team.ru
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240405162333.GU538574@ZenIV>
References: <CAOQ4uxhm5m9CvX0y2RcJGuP=vryZLp9M+tS6vH1o_9BGUqxrvg@mail.gmail.com>
 <00000000000039026a06155b3a12@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000039026a06155b3a12@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 05, 2024 at 08:37:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:

WTF?  The patch is

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e9df2f87072c6..8502ef68459b9 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -636,11 +636,18 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	 * each file a separate locking class.  Let's differentiate on
 	 * whether the file has mmap or not for now.
 	 *
-	 * Both paths of the branch look the same.  They're supposed to
+	 * For similar reasons, writable and readonly files are given different
+	 * lockdep key, because the writable file /sys/power/resume may call vfs
+	 * lookup helpers for arbitrary paths and readonly files can be read by
+	 * overlayfs from vfs helpers when sysfs is a lower layer of overalyfs.
+	 *
+	 * All three cases look the same.  They're supposed to
 	 * look that way and give @of->mutex different static lockdep keys.
 	 */
 	if (has_mmap)
 		mutex_init(&of->mutex);
+	else if (file->f_mode & FMODE_WRITE)
+		mutex_init(&of->mutex);
 	else
 		mutex_init(&of->mutex);
 
How could it possibly trigger boot failure?  Test the parent, perhaps?

