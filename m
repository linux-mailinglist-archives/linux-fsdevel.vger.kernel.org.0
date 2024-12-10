Return-Path: <linux-fsdevel+bounces-36880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07149EA5F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 03:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CC6284C0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 02:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5371D799D;
	Tue, 10 Dec 2024 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YtbeaSU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A61B4229;
	Tue, 10 Dec 2024 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798730; cv=none; b=q9Z8cYGBY8Q2W9k/bNv3QsgUSkArEfE/VErz2dRSP6iwZVI6q1LaHijQKYXu9+a062ZJQszSCBuf+YQXiUbXoLZxSc6draG0nTczhbVmn8jBjlbZwO7+e3NPsIPC7pGBmJgy6Q1o+w4zWxyNudEx2AaYsK5f2C6crIqjp4fqDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798730; c=relaxed/simple;
	bh=4OwGRIsAsELT2KkbNk0CcAhnJ9osdPgFeUzJ/VsW5BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF5J0NvfZuw1hSkA/ON5AQ0xlBCuXR4CsHSwBg1isekJpSbETKG/q04Ie0eU0DUVFBtXXblPeSNxVdmrOn2OKObmPsZC7HJjCN7lS5DRh8PxcdjIAbP/P1MhYN88c+PvL7uX9DDZG1Qr8UMJXpKGe+agpOyN0CkHzdtBfvUE1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YtbeaSU0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BhwYJY1CGSlUeKZ2NE5SQ1F5sUN54CqODRx6RFLPBa4=; b=YtbeaSU0GkTNS9RGFdA1IsqWqE
	8LGN0U/oT+x8blxpbeZ0JoJb6Rq9p8N4c7iHEMn18VJZ69l5wbT/rM1zo2V+jUFlty84PGtbnUuW9
	X5nSRpykQo1cOk2dDWaI694Zdfx1l3jS141BRkdGel8xK0HXcMapEx09OcDHGra+ASujh1cY5U09u
	7JnEovMzEknbhykC6MoG7PB4FtxVDpaHbctWrzSRzv/wYcm0vC330V9iVgeoGXR8h21QullXrikeh
	YlOSARDcxv5o8rOwGAYs1FSsSEVz1WZUuq/Ug9Cdsh3C1+4eThbKNLK0P9F8Brx4/DZ3Gqq+IHpTc
	FbUPBPFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKqFX-00000006lOc-3K17;
	Tue, 10 Dec 2024 02:45:23 +0000
Date: Tue, 10 Dec 2024 02:45:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241210024523.GD3387508@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV>
 <20241209222854.GB3387508@ZenIV>
 <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
 <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
 <20241209231237.GC3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209231237.GC3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 09, 2024 at 11:12:37PM +0000, Al Viro wrote:
> 
> Actually, grepping for DNAME_INLINE_LEN brings some interesting hits:
> drivers/net/ieee802154/adf7242.c:1165:  char debugfs_dir_name[DNAME_INLINE_LEN + 1];
> 	cargo-culted, AFAICS; would be better off with a constant of their own.
> 
> fs/ext4/fast_commit.c:326:              fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> fs/ext4/fast_commit.c:452:      if (dentry->d_name.len > DNAME_INLINE_LEN) {
> fs/ext4/fast_commit.c:1332:                     fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> fs/ext4/fast_commit.h:113:      unsigned char fcd_iname[DNAME_INLINE_LEN];      /* Dirent name string */
> 	Looks like that might want struct name_snapshot, along with
> {take,release}_dentry_name_snapshot().

See viro/vfs.git#work.dcache.  I've thrown ext4/fast_commit conversion
into the end of that pile.  NOTE: that stuff obviously needs profiling.
It does survive light testing (boot/ltp/xfstests), but review and more
testing (including serious profiling) is obviously needed.

Patches in followups...

