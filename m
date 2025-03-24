Return-Path: <linux-fsdevel+bounces-44923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1204A6E5E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C993A8790
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F21DEFE0;
	Mon, 24 Mar 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pdos1A81"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337C15E96
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853142; cv=none; b=sibgVdJBaN7Q/4T5eHpKcGbNdudzxdDJb3Mt+u7z4YPYorXMdRJuQ1x6vr9UmOCPF3wkuayCLG8LQir6ak1B2tX96Av55Sv7EV42rVPEXHQqKOS5Dg3mAOHQreKX3XrBfpSj77RTKkIlQI9/eLfJX/fuRkUamYwGS/Y+oMwdXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853142; c=relaxed/simple;
	bh=2b6d11BTLWXb+NZKp0BLl80FllNeqCXaNf2cs9pKaU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QRfXCvkg8RDNvUAv03SRPhrHTQ/ws+KVmr44SskOzy2dssD/rxuFWg2SYpi9CHpISFHTReqs7HDtPy2euTP2AfUqie/bi43xvQyvEKDFTrCowQXD06wZOpANsxzXg6DQLKK05PkNsUQMmS6tBh+2kNXMPu0FYBlXUKDeic4SyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pdos1A81; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=R0bLLOVTVlI8+N1KNf+PyM1T+YtLnMln6IDv9OEq3Hc=; b=pdos1A81mGVPcToONOIOf4T+EP
	Ly31CEEzgSMkXyf9UTjBf1NdC0TMK5hecsqGC7iFo+f41+7M4l3rWWb/5H6k2fQ2mn/fDLZDbXz9j
	AGo9HuDFvSLv8F6/WkE5tV1m/Yk9vp6FRCV+ceHY77Or7Nv3qEsIKw2ZO9nXM5/Wsua2TUJdkQhZj
	hAIGTRIOAs6wfUsDpbbK3dxhkSqFr7hVlhUllzYQSg9BWAP3zad7Yg7q2EhmrzrGP7l2Rtsppbajq
	zxLVbvH/rEbWOuoZasmhAbs4CCrkM1OkyJef7q9VFYCVpYg+oYTtatp35D2cKybVRFpFI84lzac/a
	OhjmZM6g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1twpiR-00000006zoX-4BG2;
	Mon, 24 Mar 2025 21:52:16 +0000
Date: Mon, 24 Mar 2025 21:52:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Subject: [RFC] weird use of dget_parent() in xfs_filestream_get_parent()
Message-ID: <20250324215215.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Function in question:

static struct xfs_inode *
xfs_filestream_get_parent(
        struct xfs_inode        *ip)
{
        struct inode            *inode = VFS_I(ip), *dir = NULL;
        struct dentry           *dentry, *parent;

        dentry = d_find_alias(inode);
        if (!dentry)
                goto out;

        parent = dget_parent(dentry);
        if (!parent)
                goto out_dput;

        dir = igrab(d_inode(parent));
        dput(parent);

out_dput:
        dput(dentry);
out:
        return dir ? XFS_I(dir) : NULL;
}

1) dget_parent(dentry) never returns NULL; if you have IS_ROOT(dentry) you
get an equivalent of dget(dentry).  What do you want returned in that
case?

2) why bother with dget_parent() in the first place?  What's wrong with
	spin_lock(&dentry->d_lock); // stabilizes ->d_parent
        dir = igrab(dentry->d_parent->d_inode);
	spin_unlock(&dentry->d_lock);

or, if you intended NULL for root, 
	spin_lock(&dentry->d_lock); // stabilizes ->d_parent
	if (!IS_ROOT(dentry))
		dir = igrab(dentry->d_parent->d_inode);
	spin_unlock(&dentry->d_lock);


Is there anything subtle I'm missing here?

