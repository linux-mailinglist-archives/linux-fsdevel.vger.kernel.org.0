Return-Path: <linux-fsdevel+bounces-44380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 889CBA680DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA3A7A4AC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467C206F04;
	Tue, 18 Mar 2025 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ikKD40mE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC9209677;
	Tue, 18 Mar 2025 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341510; cv=none; b=jjE5Oc4Ew3NelYa2rZ8OA+d1ReisgrylmG8ssziD0lfwyepkuC8JzNvTu06pUuSPh9JjbFIamnSeiSLMK5WJY/WDXwXXqA7achcAYOWQkqvCSYZNWo/0VSfHl95+/eKdWA304XgotOITSacAXi4JVUgxOmpSnWRZkE7BG+8S46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341510; c=relaxed/simple;
	bh=JGEW5En0spsK+qioi/VgL3Fsb4SXZg/2HDGfbAmp5F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brmfE+NmJWwlfKPzgfr0xFXsTXp4js6vz4cYbYZ1Nsawpfgu4zFj4XlxEJk1dB2P1XTWSsFyvzoS2b9ZXLGD5Fs/jru3jUfxfyl9oBo16gkkcSgV1r9Eg9Mk4iXHPiP2v2cCqMWgqSiAoWe8E79A3mgcekihp1kKC8kAK3mV4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ikKD40mE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qub+wuCERDJRI+/4NwsOUFn7xvjjWzxr1pC9JJhxxAc=; b=ikKD40mEFbekgfKZ9OxcymMwWI
	p67KyLcSVJGZ4cJ0hBVJWNH+Sp8+tY6W+DLRZrwq04IFZd6Pvs5pdZLfubPkNOjgz7q/oKeO5xAss
	1YiTF5ursYBekbdOzs51jXSCef1CgyxTBBLnY3W7NZ2UmjAjwdfMEikXR5xTwN48rGuau1rqzduVs
	6Y0OaocXugLDzH1wZT45RwTdCUihFm4WvocaeCTcb6nfsHXLmDiQGsvo5JjKdqw6bFu+bXfx6LAl7
	84mYs8fEXA4X06at89CcUPXbRrrFNycRyShW9Azrb5lTVlkMKXDX6ypfZ2cCu4NpZF2j3r45PP6Fb
	E4AfZAnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tugcL-0000000HHwx-1EHq;
	Tue, 18 Mar 2025 23:45:05 +0000
Date: Tue, 18 Mar 2025 23:45:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/3] create simple libfs directory iterator and make
 efivarfs use it
Message-ID: <20250318234505.GY2023217@ZenIV>
References: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 18, 2025 at 03:41:08PM -0400, James Bottomley wrote:
> [Note this is built on top of the previous patch to populate path.mnt]
> 
> This turned out to be much simpler than I feared.  The first patch
> breaks out the core of the current dcache_readdir() into an internal
> function with a callback (there should be no functional change).  The
> second adds a new API, simple_iterate_call(), which loops over the
> dentries in the next level and executes a callback for each one and
> the third which removes all the efivarfs superblock and mnt crud and
> replaces it with this simple callback interface.  I think the
> diffstats of the third patch demonstrate how much nicer it is for us:

I suspect that you are making it too generic for its own good.

dcache_readdir() needs to cope with the situation when there are
fuckloads of opened-and-unliked files in there.  That's why we
play those games with cursors under if (need_resched()) there.
That's not the case for efivarfs.  There you really want just
"grab a reference to the next positive, drop the reference we
were given" and that's it.

IOW, find_next_child() instead of scan_positives().  Export that
and it becomes just a simple loop -
	child = NULL;
	while ((child = find_next_child(parent, child)) != NULL) {
		struct inode *inode = d_inode(child);
		struct efivar_entry *entry = efivar_entry(inode);

		err = efivar_entry_size(entry, &size);

		inode_lock(inode);
		i_size_write(inode, err ? 0 : size + sizeof(__u32));
		inode_unlock(inode);

		if (err)
			simple_recursive_removal(child, NULL);
	}
and that's it.  No callbacks, no cursors, no iterators - just an
export of helper already there.

