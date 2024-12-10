Return-Path: <linux-fsdevel+bounces-36971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F0D9EB833
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD4163860
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96923ED55;
	Tue, 10 Dec 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xGXC//7K";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="M3pKGpzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDD23ED42;
	Tue, 10 Dec 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851655; cv=none; b=NryJ5SSLmxaGbdN5GzJA4pFb8vElWXv+WHqT+jk40ScXGwscENw5vpgrQ3FHFRe6mY9VS6KgfhDcNfPBppWoCwlMHVSwFVxoaiiGikiLjYYjqaBwnPGiGnR066QVUmUUxJrRUGTxnUmKnG49SLgpX3rPGBv1p8Yf4qfjAWUK1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851655; c=relaxed/simple;
	bh=MO+sncWYlVkLbFiDDl/zuG8IlXLCai1nf/TBjl3LzkA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yx9WoenJPnDnYbyzaINR+5bNzNVrabpG2MtQCudMCB3HQa64PTiK0KbC4nt0OmwYdSHVayHkhtxs005ro++rYqu8qTzosVPT59ObDoUxKoKBiIwWJP/a6Jc+AmS0Jy7zXMZCerOg9c00DVSx0XI1EhkQdti+lbCt4XHSbNxQMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xGXC//7K; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=M3pKGpzs; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733851651;
	bh=MO+sncWYlVkLbFiDDl/zuG8IlXLCai1nf/TBjl3LzkA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=xGXC//7KPdhbQvoeGZ4SrNFdOpYYPnLdwguJlPuBkupC3XdJOBLlWkF5pM9/qAcBz
	 v3SeO69/eAafwqPUumxBPNHDoUJggDukkyAcBDOYEE6ZI8zlAU+99dZY2hQsX+FeFg
	 z37AdbtIEf68EnmxTNujvn6U8ZBsUWEqoBoLJalk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 231991286E02;
	Tue, 10 Dec 2024 12:27:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id V8fnDq5_Ej1q; Tue, 10 Dec 2024 12:27:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733851650;
	bh=MO+sncWYlVkLbFiDDl/zuG8IlXLCai1nf/TBjl3LzkA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=M3pKGpzsDwPXmxPzFrPeIRlLIzG2kX5i3EJ/R8dr5XE5RtoDFlI2A1FRSPBSMwNz9
	 AdywDEsMvQoYdQa0W2vsyuRGHjmpSOAR4qYeu9ysXFGfELcm282PBwrPZSJn6YLxbZ
	 XuDh77Jx84UPgU0EKqTbwvfCk21A8yd8mfLtv6Ic=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 044D61286D0B;
	Tue, 10 Dec 2024 12:27:29 -0500 (EST)
Message-ID: <cbb9303498007cc78ef80f84cbf029e4f84a9b96.camel@HansenPartnership.com>
Subject: Re: [PATCH 3/6] efivarfs: make variable_is_present use dcache lookup
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 10 Dec 2024 12:27:28 -0500
In-Reply-To: <CAAH4kHaDnzY_KWkRy+fGzxOh5b9oViSfSWZ4CcQSa8n3dF2v2A@mail.gmail.com>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-4-James.Bottomley@HansenPartnership.com>
	 <CAAH4kHaDnzY_KWkRy+fGzxOh5b9oViSfSWZ4CcQSa8n3dF2v2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-12-10 at 09:14 -0800, Dionna Amalie Glaze wrote:
> On Tue, Dec 10, 2024 at 9:03 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> 
> >  extern const struct file_operations efivarfs_file_operations;
> >  extern const struct inode_operations
> > efivarfs_dir_inode_operations;
> > @@ -64,4 +66,6 @@ extern struct inode *efivarfs_get_inode(struct
> > super_block *sb,
> >                         const struct inode *dir, int mode, dev_t
> > dev,
> >                         bool is_removable);
> > 
> > +
> > +
> 
> Unnecessary

I can remove the extra line.

> >  #endif /* EFIVAR_FS_INTERNAL_H */
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index b22441f7f7c6..dc3870ae784b 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -181,6 +181,26 @@ static struct dentry
> > *efivarfs_alloc_dentry(struct dentry *parent, char *name)
> >         return ERR_PTR(-ENOMEM);
> >  }
> > 
> > +bool efivarfs_variable_is_present(efi_char16_t *variable_name,
> > +                                 efi_guid_t *vendor, void *data)
> > +{
> > +       char *name = efivar_get_utf8name(variable_name, vendor);
> > +       struct super_block *sb = data;
> > +       struct dentry *dentry;
> > +       struct qstr qstr;
> > +
> > +       if (!name)
> > +               return true;
> 
> Why is this true? I understand the previous implementation would have
> hit a null dereference trying to calculate strsize1 on null, so this
> isn't worse, but if we considered its length to be 0, it would not be
> found.

Because for safety on failure we need to assume a collision.  kmalloc
failing will already have dropped an error message so adding another
here (particularly when the log will likely be filling up with these
because we're in a critical memory shortage situation) would seem to be
overkill.  The memory allocation will never fail ordinarily and if it
does the system will be degrading fast, so EFI filesystem variable
collision will be the least of the problem.

Regards,

James


