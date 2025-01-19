Return-Path: <linux-fsdevel+bounces-39625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DFA162FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 17:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BF41885BD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7061DF742;
	Sun, 19 Jan 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mu3JlJFI";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mu3JlJFI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1343AA4;
	Sun, 19 Jan 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737305288; cv=none; b=E6ox60uJKdTnvfNzLKSA5dnHkYgKr9Y2LkmGkFDKG7t4weKABpYZuZLgA62/bN11ga1jFu8I2nvQfNsqahTNvhqfy1WyRV6DwSrBaiWJ7BZjA2XJKuud29+0ZBlJFlrk9WBGdWIy4PTIZS2JTpLu0o1M0tkQU8ssmgcrIp/oeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737305288; c=relaxed/simple;
	bh=hsc5a//KCPL1drE3q1XVxFNAiJEy7ocG5Snu3OciNHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nnUd8eOZdVD3YZAu6haJZwe7SiP0tgdz5V31/KPfZdcIsct0xpv4Ftj0juu2LTLyD+jckhtW0p89K1BJTCFeSMPYuFxzD68tzmxOeWUBQRqiaS+FXfjO/ZjOlmp9MDRv631ElQWbUpdDoXDkprLR5LQyAgkvkR8O4hcsxTqvSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mu3JlJFI; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mu3JlJFI; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737305285;
	bh=hsc5a//KCPL1drE3q1XVxFNAiJEy7ocG5Snu3OciNHY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=mu3JlJFIgp15/W8Gz6aa3uXDl1OmYRN5LoUeyz5l83ITNe6Ev1n78w7mWSM+1Kq3Q
	 7gNFPKK6o4PoopXPnOmchKwozHMCW1Gx7UF/sIC45v1LE4wRJs3PKnwSWeIIGBZzTq
	 i4LHChzyFIYpFeX7xyLFRApdSsOP16E2iYlgN0yk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id AA77D12862DE;
	Sun, 19 Jan 2025 11:48:05 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id BjfnjoMWshUp; Sun, 19 Jan 2025 11:48:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737305285;
	bh=hsc5a//KCPL1drE3q1XVxFNAiJEy7ocG5Snu3OciNHY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=mu3JlJFIgp15/W8Gz6aa3uXDl1OmYRN5LoUeyz5l83ITNe6Ev1n78w7mWSM+1Kq3Q
	 7gNFPKK6o4PoopXPnOmchKwozHMCW1Gx7UF/sIC45v1LE4wRJs3PKnwSWeIIGBZzTq
	 i4LHChzyFIYpFeX7xyLFRApdSsOP16E2iYlgN0yk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E07361280A8B;
	Sun, 19 Jan 2025 11:48:04 -0500 (EST)
Message-ID: <e4e0dc96752c33c6ff0e07165467c35a350b23c5.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/2] efivarfs: prevent setting of zero size on the
 inodes in the cache
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Jeremy Kerr
	 <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro
	 <viro@zeniv.linux.org.uk>
Date: Sun, 19 Jan 2025 11:48:03 -0500
In-Reply-To: <CAMj1kXEQVJ6kqGFqXT9sqdNX9Juc7CiWa-4q+J7D=YucFimrqA@mail.gmail.com>
References: <20250119145941.22094-1-James.Bottomley@HansenPartnership.com>
	 <20250119145941.22094-2-James.Bottomley@HansenPartnership.com>
	 <CAMj1kXEQVJ6kqGFqXT9sqdNX9Juc7CiWa-4q+J7D=YucFimrqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2025-01-19 at 17:32 +0100, Ard Biesheuvel wrote:
> On Sun, 19 Jan 2025 at 16:00, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > Current efivarfs uses simple_setattr which allows the setting of
> > any
> > size in the inode cache.  This is wrong because a zero size file is
> > used to indicate an "uncommitted" variable, so by simple means of
> > truncating the file (as root) any variable may be turned to look
> > like
> > it's uncommitted.  Fix by adding an efivarfs_setattr routine which
> > does not allow updating of the cached inode size (which now only
> > comes
> > from the underlying variable).
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > ---
> >  fs/efivarfs/inode.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> > index ec23da8405ff..a4a6587ecd2e 100644
> > --- a/fs/efivarfs/inode.c
> > +++ b/fs/efivarfs/inode.c
> > @@ -187,7 +187,24 @@ efivarfs_fileattr_set(struct mnt_idmap *idmap,
> >         return 0;
> >  }
> > 
> > +/* copy of simple_setattr except that it doesn't do i_size updates
> > */
> > +static int efivarfs_setattr(struct mnt_idmap *idmap, struct dentry
> > *dentry,
> > +                  struct iattr *iattr)
> > +{
> > +       struct inode *inode = d_inode(dentry);
> > +       int error;
> > +
> > +       error = setattr_prepare(idmap, dentry, iattr);
> > +       if (error)
> > +               return error;
> > +
> > +       setattr_copy(idmap, inode, iattr);
> > +       mark_inode_dirty(inode);
> > +       return 0;
> > +}
> > +
> >  static const struct inode_operations
> > efivarfs_file_inode_operations = {
> >         .fileattr_get = efivarfs_fileattr_get,
> >         .fileattr_set = efivarfs_fileattr_set,
> > +       .setattr      = efivarfs_setattr,
> >  };
> 
> Is it sufficient to just ignore inode size changes?

Yes, as far as my testing goes.

>  Should we complain about this instead?

I don't think so because every variable write (at least from the shell)
tends to start off with a truncation so we'd get a lot of spurious
complaints.

Regards,

James


