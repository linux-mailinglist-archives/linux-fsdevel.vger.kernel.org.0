Return-Path: <linux-fsdevel+bounces-47307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00259A9BA59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 00:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826A99A0785
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF2288C8D;
	Thu, 24 Apr 2025 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fBtWwVeK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FE284667;
	Thu, 24 Apr 2025 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532016; cv=none; b=KQgZ6y9mmRSLBg8fvJu4T/ozK9NGmHvAxsADTSqd+pjcuE897Q+Mg7dSmQuszNJA3AZZcur9O0YCib0ObswUHH3ZEEs8LhWlb4wq9zoJRqkOR5sejp0qnGZJNkY5jFXNzc3MliPZBz8z82ByXhBSzufsMQzd7KV5Q0Otvpri378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532016; c=relaxed/simple;
	bh=a/wFP0xUnLGA+zM60c4z/FtF0A5FfD/mDoBmte12bWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EhZYf0EsiBnCZqB1cIVhju/3b4Jr4F2Zd5BkQz/lKM9Xpq1LUBELob557p9HSHs+4+ZyrxDOtZ1lcJmDOJjnga0/2QOTrtVf6VCv3vt9d0OpQmz7CBfhHuJc/NQuXGl/JKqXhLKJeRJ2EchMWnT2rCA2gMPh35XrXOjy0VNb8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fBtWwVeK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ffwIMD2NRdX6rwLrp+1FPuSdWtGY9X4PK864VNYjd9Y=; b=fBtWwVeKOi8hu501AMGlbzwOMO
	s4UhTitH6OYyhMC88W64c3iMXCf1T1JrPeI7B6HykDKMeYwXpLQOhX3AdjwOut9cNxgT+mujQhsFv
	xrhXZoLPD4hBXJKStZHaCpjJL4AveUVvWoEkewsIshSAhcHNYIZA1ijsDiPJYLuttE1fMdpLBy7Z4
	ELtUaXPapatQJ0NNSaKsXcin3IqInw48OVToct4wMPj5M03sVgzw5Rw/v+GTqol1TJG2rJZkYZMS2
	3bBEGLO+7NSE2sCImyLHaZyjLJNX6+iEeSjDFd41sncVNLmojsD9CbRphAuIdCPQmKbgwKLyZjrZa
	MBXUQ3qQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u84c7-00000001LtQ-2mJr;
	Thu, 24 Apr 2025 22:00:11 +0000
Date: Thu, 24 Apr 2025 23:00:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [WTF][landlock] d_is_negative(fd_file(f)->f_path.dentry) ???
Message-ID: <20250424220011.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>


static int get_path_from_fd(const s32 fd, struct path *const path)
{
...
        if ((fd_file(f)->f_op == &ruleset_fops) ||
            (fd_file(f)->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
            (fd_file(f)->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
            d_is_negative(fd_file(f)->f_path.dentry) ||
            IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry)))
                return -EBADFD;

	Folks, could somebody explain how exactly can an opened file
come to have a _negative_ dentry?  And if you have found a way for that
to happen, why didn't you report the arseloads of NULL pointer dereference
bugs that would expose, along with assorted memory corruptors, etc.?

	Normally I would just quietly rip the bogus check out, but on
the off-chance that somebody _has_ found a bug that would cause that,
I would prefer to check with those who had added the check in the first
place.

