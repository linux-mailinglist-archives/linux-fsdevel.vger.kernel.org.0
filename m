Return-Path: <linux-fsdevel+bounces-16080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E05897B8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A841C26F35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 22:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90047156C51;
	Wed,  3 Apr 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TKiN3enC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D5156966;
	Wed,  3 Apr 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182935; cv=none; b=HFDU8GkEKIcncV1G1y7LmwazkAegep7DaxbwZCIua19hBvhe88v9sxb2jsgGQczDbYUm8ewWLBwTRahpaenhOfT/PGfnAXRalUeI7J5btt46m3bwxuHguDb0AkrKVZtNQPUfz5hEzRDdJ7M1vdhuQJXkhMoh6b2wltmGIXzTMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182935; c=relaxed/simple;
	bh=lRXKv8S1N/Sb8QDRVkZH5o2ueko8OCT7uZmrGJAAG6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL8ketNiAA7eP2oOaYICYbnF/Pgv0nu2/tVDyLxgwRSZWwkWlEYfYWBG0I1PVmHFM2QkWoJ7dKTKNhSCZ0IM0AsKkgpnQOKbvA/DDj9K/MajB0DpS+o7GgiSdMAWKWq5W1RoaqVtbloXJCJ34IAoYzXDcG9L4TQ/m/O3Giojn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TKiN3enC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lKTHvXKGTsV+tX6aUCiyv6Vo691FyZts8/uGP/UQFRw=; b=TKiN3enC1YTFFL4KXPEO/xna/h
	imGC6S7z1wcjYi8uk29qLdEvzzmZXfcUSOzP+sPiDsrSj07t899F/JRh2xbgy25bjLA1uoLfbDzZL
	jhXSNbHYfG19fyau62kCf2qCWqvrbJlpdFSTzTTwPv4m+ipZbRP/YAuMf6H8wquNYoUcWyV9rLo5n
	SckCIHxavTqy94/mN1aRdCDXtqgxCne9Jb0ahuNeDjAIJkuvxmKpqCbG0d+h5VqM6+Ydfhf2JXVFl
	xjjcbQNL79Kuhlc6ORc4zcz3p61JeoJaJHaI1OuQP4o4+a8HPdaSXnJeIhJT89qZyJAWRNUMZzqY0
	GnGyILsA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rs8zO-005Awt-2F;
	Wed, 03 Apr 2024 22:21:50 +0000
Date: Wed, 3 Apr 2024 23:21:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: brauner@kernel.org, jack@suse.cz, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-integrity@vger.kernel.org, pc@manguebit.com,
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Steve French <smfrench@gmail.com>
Subject: Re: [RESEND][PATCH v3] security: Place security_path_post_mknod()
 where the original IMA call was
Message-ID: <20240403222150.GL538574@ZenIV>
References: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 03, 2024 at 11:07:49AM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 08abce60d63f ("security: Introduce path_post_mknod hook")
> introduced security_path_post_mknod(), to replace the IMA-specific call to
> ima_post_path_mknod().
> 
> For symmetry with security_path_mknod(), security_path_post_mknod() was
> called after a successful mknod operation, for any file type, rather than
> only for regular files at the time there was the IMA call.
> 
> However, as reported by VFS maintainers, successful mknod operation does
> not mean that the dentry always has an inode attached to it (for example,
> not for FIFOs on a SAMBA mount).
> 
> If that condition happens, the kernel crashes when
> security_path_post_mknod() attempts to verify if the inode associated to
> the dentry is private.
> 
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.
> 
> Reported-by: Steve French <smfrench@gmail.com>
> Closes: https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: 08abce60d63f ("security: Introduce path_post_mknod hook")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

LGTM...

