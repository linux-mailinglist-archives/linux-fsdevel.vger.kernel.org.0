Return-Path: <linux-fsdevel+bounces-37058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A09ECC31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 13:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE2C28295B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57A22912A;
	Wed, 11 Dec 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PZEQmSQ9";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RvF/YvFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4C229120;
	Wed, 11 Dec 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920756; cv=none; b=G1t9OiB+fjCqeVnnOBo++5m555Lh9L5HrD0669BUQaC55dT/YPTNtbQMIrYMRPbc/pxbQfT1U3ec9sokcWJNUD7BO81Hg35RFHggO06pm81X5UoxNP6gfHCtTg118jhr7l2lKtTzWxuTs8yuAgHxvkSQuc4dSykgU5bs09P2898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920756; c=relaxed/simple;
	bh=MGeGJkBE/DUZAyOavqGTBVaVgwpva4kxhtVY0X7JtpY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffH3j7QIgUFX+x+5e27BzWkRaVvTwYwXNwyWf8t6JpS2QY+W70NbVgp7Aj24GuUCG4aV4AFVfJ9ZtR40FXAvb+iwCoPLGCRW6+SuRwts0byyE3kqggL2q2/Nz8gvUj51l+faKU8nM7ca26AosIBERt2rxGgtvB8IX8k7GW1B4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=PZEQmSQ9; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=RvF/YvFd; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733920754;
	bh=MGeGJkBE/DUZAyOavqGTBVaVgwpva4kxhtVY0X7JtpY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=PZEQmSQ9HOLxAuV5w7AmoQDaID35GWC+Gno0kSZDzbDRTJc57wM1Jqafqw6hXoAob
	 A0JKraOo8Hx/Wul6+NuBnFMrIcM5mhzA8Dcazy/gl31RTG2gW8nUEsC/BpQv0CChmh
	 Uq+yjwuX69RZDqiFeS9R78vY013qLhLm8zQWawG0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1CBDF1280B72;
	Wed, 11 Dec 2024 07:39:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xa4rWMpl1qkm; Wed, 11 Dec 2024 07:39:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733920753;
	bh=MGeGJkBE/DUZAyOavqGTBVaVgwpva4kxhtVY0X7JtpY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=RvF/YvFd63OoihQZL+ncoL8d9uMUUulNYrn9pJjS3rrWo/V3WGoMkNDLZ167tyZGC
	 nQyAZCF/EpnfcYIwuxZ6jFPH8NSTKQRJD2vDzTr0pZTCpy2wGDPEguLO36HOnrPDFm
	 jgPL0oakUn3TwG7K46Hv1LMwR8ENNLadVSj6LFrc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6E9CB12809C0;
	Wed, 11 Dec 2024 07:39:13 -0500 (EST)
Message-ID: <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Dec 2024 07:39:11 -0500
In-Reply-To: <20241211-krabben-tresor-9f9c504e5bd7@brauner>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-12-11 at 12:16 +0100, Christian Brauner wrote:
> On Tue, Dec 10, 2024 at 12:02:24PM -0500, James Bottomley wrote:
[...]
> > +static int efivarfs_file_release(struct inode *inode, struct file
> > *file)
> > +{
> > +       if (i_size_read(inode) == 0) {
> > +               drop_nlink(inode);
> > +               d_delete(file->f_path.dentry);
> > +               dput(file->f_path.dentry);
> > +       }
> 
> Without wider context the dput() looks UAF-y as __fput() will do:
> 
> struct dentry *dentry = file->f_path.dentry;
> if (file->f_op->release)
>         file->f_op->release(inode, file);
> dput(dentry);
> 
> Is there an extra reference on file->f_path.dentry taken somewhere?

Heh, well, this is why I cc'd fsdevel to make sure I got all the fs
bits I used to be familiar with, but knowledge of which has atrophied,
correct.

I think it's paired with the extra dget() just after d_instantiate() in
fs/efivarfs/inode.c:efivarfs_create().  The reason being this is a
pseudo-filesystem so all the dentries representing objects have to be
born with a positive reference count to prevent them being reclaimed
under memory pressure.

Regards,

James


