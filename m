Return-Path: <linux-fsdevel+bounces-52426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC963AE3285
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D42188CD15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C04021765E;
	Sun, 22 Jun 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="K+Us3lUU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13172AEFD
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750629104; cv=none; b=jU8PUnR98qc5KoHllE604i8Qu+9c1taQ6eg1+CrQdqKBTY+/Y0RHFqJoHf9d93/0BQ+CsKRx98v++CGgpokLzZnmuWeV25col7HqAb//e4KBaYJXP1V8Id3dgN2uMypjC9Px2XKwQg7d4cBmBM1m6FsBcDp1p4UaYna9Rt4PtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750629104; c=relaxed/simple;
	bh=WjwI8pTi1rtycTgLJqnpOrsQYa6C7vMLshzK41jAYng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DzMRvmekU+1buobXWr8DoYspXZRe8xW8VSgQ6GX9aw9bp74DeWzrKFbLgHGkiUMowp9Itk8Im3Wzji3RWX6PLV+9P2rZzSCRfa94UHHeaEiz5Qz3rTMBfoShRZHx78KHH2DmrHf5K2uFFGFVPqE42xNERP5PkGH1Qdfbumi8wdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=K+Us3lUU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9JBeOs7ibWufFvJU0XCdltpEV+8nK6qVuajfwxyjDXI=; b=K+Us3lUUdtTnxrotL7zqTGwIti
	iHHxU1TiOv+mXHPZtNWLGPyJUNTppr71ao5MnsaSmXPQiluVevE90ABNfrbPbaC30K1taeQ7uLUd/
	PkyvUUFJIIo65KuYgDAdXCgrcHFKPVfi2vxWR6QByKTum9uycKoHweR9kLSfCfOO42XaWBnWQRbSm
	+pe4Yiei6TRWeG56egUdG9PmLbvzyAGoLPds7zJBPq67GFKDCTjZbLm31rs+L61MYxmEYIb5P0ti0
	EgPxbCBsakK0K1OOQfHEWaD5r5fvpeqWBv5YgLqzc0bwtZGv782FvID/BMtVWVOuKv+WxvXd0BIie
	pL0q0yqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSbE-000000009PM-0Ldy;
	Sun, 22 Jun 2025 21:51:40 +0000
Date: Sun, 22 Jun 2025 22:51:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>, linux-fsdevel@vger.kernel.org
Subject: interesting breakage in ltp fanotify10
Message-ID: <20250622215140.GX1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	LTP 6763a3650734 "syscalls/fanotify10: Add test cases for evictable
ignore mark" has an interesting effect on boxen where FANOTIFY is not
enabled.  The thing is, tst_brk() ends up calling ->cleanup().  See the
problem?
	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
is executed, even though
	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
	/* Set high priority for evicting inodes */
	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
hadn't been.

	Result: fanotify10 on such kernel configs ends up zeroing
/proc/sys/vm/vfs_cache_pressure.  How much does it confuse the rest of
LTP is an interesting question; it *does* have a fun effect on subsequent
xfstests run - generic/622 gets confused.  No other failures get reported
by xfstests, for whatever little it's worth...

	Arguably, there's an xfstests bug as well - since generic/622
depends upon vfs_cache_pressure being non-zero, it ought to set it
to something sane.

