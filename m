Return-Path: <linux-fsdevel+bounces-72556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9100CFB4DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 23:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47FAD3020CF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF362F25EB;
	Tue,  6 Jan 2026 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A19Ypdaq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527F41C63
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740287; cv=none; b=idt4R5xxhzlz+ju1VqSz5hUX7F93p3n9C539FE/AvxgzjlTFjlIEWvnsOQu63vVC9GdBLatF0dKb+CTQxYiw7tcDyzMltXhPjDJDztJKbGmgXAW6VUA6XdDRa9L+4J7cITiWeQhhUfn1gTZ9T9NcDWUsbUr6p62ToFpCavDHWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740287; c=relaxed/simple;
	bh=FBSAdrJuSHYp8a3YsIbBRZd3C83eAdDNhH1Rby2AUss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZDbgGYIkozK0Lwgz0qg8p0KrZMKMwqUOR1jtZdskhb/1xYlklaSRhrDZcqkpX9iL5mCoZ85aBw8g1erFHeVA2cH+0ChlRRc/l69b/5CotQo0udA74g/pX3o8IEpFMkqZK4b6xvgcqSvlwd2cKRAt/F3luWHgn90QpjtULzMdAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A19Ypdaq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=44keKZ9ZsFvsH0+e6QQR1BG01AuMEbT1Xr48EFlkfEE=; b=A19YpdaqK4qCuhbFywAoHiQc3E
	uN6eDyqhHz3z9GIw72G94zyR7Hhu7QolH3EK9EwreFN4nbfH8Vos9Tdm/ZgM7U+iJX1CQTAxyW2P1
	4hF0OOycniZHFymwUtH2s7EKDhGXcyODK/6/mCaddzBsIK+xIhn3QrENrvJ/skhlx1UEalqWQtiP5
	+9kA6X78OBieJJRFGref0U6teFOZbquCECbA6bfzxAPbdF2EWGikVbgNcX0EvhlDkgbx6YPXpbnLW
	tlHz9i3Z2mm1CZrYowOJ0wJ+ig+l57Upqe4MQh512PKBta2H1bTU0D/k/DbfN4s15dgZMZ9iSX8/Z
	ykK+SjgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vdG1F-0000000GVt0-2OQa;
	Tue, 06 Jan 2026 22:59:17 +0000
Date: Tue, 6 Jan 2026 22:59:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Message-ID: <20260106225917.GL1712166@ZenIV>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <20260104072743.GI1712166@ZenIV>
 <20260104074145.GJ1712166@ZenIV>
 <20260106-verpachten-antrag-5b610d1ec4d0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106-verpachten-antrag-5b610d1ec4d0@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 06, 2026 at 11:07:32PM +0100, Christian Brauner wrote:

> 
> Afaict, FS_IMMUTABLE_FL can be cleared by a sufficiently privileged
> process breaking the promise that this is a permanently immutable
> rootfs.

Not on ramfs:

int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
                     struct file_kattr *fa)
{
        struct inode *inode = d_inode(dentry);
        struct file_kattr old_ma = {};
        int err;
 
        if (!inode->i_op->fileattr_set)
                return -ENOIOCTLCMD;

and that's it, priveleges do not matter.

