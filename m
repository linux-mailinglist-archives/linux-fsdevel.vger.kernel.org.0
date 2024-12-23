Return-Path: <linux-fsdevel+bounces-38077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78E9FB63C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 22:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8808616595B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A681D79A0;
	Mon, 23 Dec 2024 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nfyqbR/8";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nfyqbR/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FC1D63FF;
	Mon, 23 Dec 2024 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734989988; cv=none; b=iUhiqA9LNPFPJFA66NRBI59yfoI3ZJBaKzN4c9jR8vEd+NIwyQhgbwHASL3s1ch93d1BrhsmdDSFbiGaZLkNI3nOxKYUu8cjNgpoSdKXW90C1/2j+gKbkAuPaFz8QXlJNY9n7jUvX3QRVK34EIzk2zH20WLWnE5L9K+/OJOUs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734989988; c=relaxed/simple;
	bh=h0pak05jLoVvp4UQDBwN672ZOYd3FmeL0WOSciwVwRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGDkGmknazx6NOAMcwMP5/+dWFYaozbyPR86tOk2MhicU6mO38c4F5RMR+uPfCWPkqyO38NeVBFYDR2CxUcZQcGi4N0eGGFL+l2VQ5v3Lrm6hZfd6/QbpNYdQsf27/tb18lT04xln2cyqI+5pIl6lBFyMIQ9lawAP3oxpZgti9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=nfyqbR/8; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=nfyqbR/8; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734989986;
	bh=h0pak05jLoVvp4UQDBwN672ZOYd3FmeL0WOSciwVwRg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=nfyqbR/8C/kZmOrTm7Pm9XQAZA0EAjAp4kcCtA5XPS7abhn4PAXEBTEfFM1Icu7PZ
	 7hjRuAPREfw8fuZTBFdy1ZcYDzLCNOQ57oQgcNdxYEfAuznufYGAYyWVkKa4Mhto7V
	 vWRVIvwy38gQeM+O+QO7S9YzUQvgebeihs5D5kzs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 73B6C1280AB2;
	Mon, 23 Dec 2024 16:39:46 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xvrNZepH1qML; Mon, 23 Dec 2024 16:39:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734989986;
	bh=h0pak05jLoVvp4UQDBwN672ZOYd3FmeL0WOSciwVwRg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=nfyqbR/8C/kZmOrTm7Pm9XQAZA0EAjAp4kcCtA5XPS7abhn4PAXEBTEfFM1Icu7PZ
	 7hjRuAPREfw8fuZTBFdy1ZcYDzLCNOQ57oQgcNdxYEfAuznufYGAYyWVkKa4Mhto7V
	 vWRVIvwy38gQeM+O+QO7S9YzUQvgebeihs5D5kzs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 974501280659;
	Mon, 23 Dec 2024 16:39:45 -0500 (EST)
Message-ID: <793f60131186f66f49945100fd54ad1702faa3b2.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr
	 <jk@ozlabs.org>
Date: Mon, 23 Dec 2024 16:39:44 -0500
In-Reply-To: <20241223200513.GO1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
	 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
	 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
	 <20241223200513.GO1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-12-23 at 20:05 +0000, Al Viro wrote:
> On Mon, Dec 23, 2024 at 02:52:12PM -0500, James Bottomley wrote:
> >  
> > +static int efivarfs_file_release(struct inode *inode, struct file
> > *file)
> > +{
> > +       inode_lock(inode);
> > +       if (i_size_read(inode) == 0 && !d_unhashed(file-
> > >f_path.dentry)) {
> > +               drop_nlink(inode);
> > +               d_delete(file->f_path.dentry);
> > +               dput(file->f_path.dentry);
> > +       }
> > +       inode_unlock(inode);
> > +       return 0;
> > +}
> 
> This is wrong; so's existing logics for removal from write().  Think
> what happens if you open the sucker, have something bound on top of
> it and do that deleting write().

Shouldn't the bind have taken a dentry reference? in which case we'll
just drop the dentry but it won't be the final put, so it will still
hang around.

> Let me look into that area...

Thanks; as you say, delete from write has been around for over a decade
in this filesystem.  We can defer the delete, but it has to happen
somewhere if a write causes an EFI variable to be removed.

Regards,

James



