Return-Path: <linux-fsdevel+bounces-39624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DEA162FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 17:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D11885BAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B41DF742;
	Sun, 19 Jan 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G9sWZc80";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G9sWZc80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A336C2F2F;
	Sun, 19 Jan 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737305185; cv=none; b=UOhN3upfKr0mJNT/afOz2JoJDbCXlfROmvx5RWIBpEWLgIeNK4FkSVU6TL0SjKQaLXvuTrI1mzKj0jCwprOOciEHl6xoj7BA7dlE+ODTdnMdtsvdVcGWfdnjjhtfxrBxN70QnmfTJP9fezy0NCewAHb04+WbPa4YJJMv/tIp19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737305185; c=relaxed/simple;
	bh=R/NuF2YwiumBvKQEZ8D9s1/tgGBYS5ddQ2KtHIoyhBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5+f2Aj09tWCwl32jbCU/zEBL+OxnsbqlEWqxhKvEpuykSwOEfrXzfru1f/ssQqKKtVYy5Sl0s+AncMz3TeGw06ulFDfEHEt8o18C5wKV2ngDk4y5UGFGmXk0DqnG4Ltwhmlvu0mJeHJHKMBjlMxCrwQnNpZlJL2i1BH4h+Lnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=G9sWZc80; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=G9sWZc80; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737305182;
	bh=R/NuF2YwiumBvKQEZ8D9s1/tgGBYS5ddQ2KtHIoyhBI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=G9sWZc80z6Ui5ScXWVzWU1gOLPPit67x5Lrhv7Iavc0xm2gyODmPqh/yeD0tIdYoW
	 QPytFnvybWyJ+z01JP105lwohBo+OjKU+4Ixlebr20Bm/ouuJ4BRPCMlx7qdknC3fe
	 ns5KrY/KWYp+uVQtGr2bkFcUkIAkzPhX4K4CfN+o=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C31BA12862DE;
	Sun, 19 Jan 2025 11:46:22 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id RA34Ly765NEc; Sun, 19 Jan 2025 11:46:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737305182;
	bh=R/NuF2YwiumBvKQEZ8D9s1/tgGBYS5ddQ2KtHIoyhBI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=G9sWZc80z6Ui5ScXWVzWU1gOLPPit67x5Lrhv7Iavc0xm2gyODmPqh/yeD0tIdYoW
	 QPytFnvybWyJ+z01JP105lwohBo+OjKU+4Ixlebr20Bm/ouuJ4BRPCMlx7qdknC3fe
	 ns5KrY/KWYp+uVQtGr2bkFcUkIAkzPhX4K4CfN+o=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DFCFC12862E3;
	Sun, 19 Jan 2025 11:46:21 -0500 (EST)
Message-ID: <dc93654ecfad51c1ffa7d9a8570185122090201d.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 4/6] efivarfs: move freeing of variable entry into
 evict_inode
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>, Christian Brauner
	 <brauner@kernel.org>
Date: Sun, 19 Jan 2025 11:46:19 -0500
In-Reply-To: <CAMj1kXEXKxgKNUoYW-sW_NqegcqG21Q0Rsdg0JQPwunBiR5mQQ@mail.gmail.com>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
	 <20250116183643.GI1977892@ZenIV>
	 <0b770a342780510f1cd82a506bc67124752b170c.camel@HansenPartnership.com>
	 <ae267db4fe60f564c6aa0400dd2a7eef4fe9db18.camel@HansenPartnership.com>
	 <CAMj1kXGH4o50xfb_Rv3-gHxq_s2OeSWOpa9CaSf7v5vSrC9eDg@mail.gmail.com>
	 <45d245a9db73f3c41f31626a675d6356704198ef.camel@HansenPartnership.com>
	 <CAMj1kXEXKxgKNUoYW-sW_NqegcqG21Q0Rsdg0JQPwunBiR5mQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2025-01-19 at 17:31 +0100, Ard Biesheuvel wrote:
> On Sun, 19 Jan 2025 at 15:57, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Sun, 2025-01-19 at 15:50 +0100, Ard Biesheuvel wrote:
> > > On Thu, 16 Jan 2025 at 23:13, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > 
> > > > On Thu, 2025-01-16 at 14:05 -0500, James Bottomley wrote:
> > > > > On Thu, 2025-01-16 at 18:36 +0000, Al Viro wrote:
> > > > > > On Mon, Jan 06, 2025 at 06:35:23PM -0800, James Bottomley
> > > > > > wrote:
> > > > > > > Make the inodes the default management vehicle for struct
> > > > > > > efivar_entry, so they are now all freed automatically if
> > > > > > > the file is removed and on unmount in
> > > > > > > kill_litter_super(). Remove the now superfluous iterator
> > > > > > > to free the entries after kill_litter_super().
> > > > > > > 
> > > > > > > Also fixes a bug where some entry freeing was missing
> > > > > > > causing efivarfs to leak memory.
> > > > > > 
> > > > > > Umm...  I'd rather coallocate struct inode and struct
> > > > > > efivar_entry; that way once you get rid of the list you
> > > > > > don't need - evict_inode() anymore.
> > > > > > 
> > > > > > It's pretty easy - see e.g.
> > > > > > https://lore.kernel.org/all/20250112080705.141166-1-viro@zeniv.linux.org.uk/
> > > > > > for recent example of such conversion.
> > > > > 
> > > > > OK, I can do that.  Although I think since the number of
> > > > > variables is usually around 150, it would probably be
> > > > > overkill to give it its own inode cache allocator.
> > > > 
> > > > OK, this is what I've got.  As you can see from the diffstat
> > > > it's about 10 lines more than the previous; mostly because of
> > > > the new allocation routine, the fact that the root inode has to
> > > > be special cased for the list and the guid has to be parsed in
> > > > efivarfs_create before we have the inode.
> > > > 
> > > 
> > > That looks straight-forward enough.
> > > 
> > > Can you send this as a proper patch? Or would you prefer me to
> > > squash this into the one that is already queued up?
> > 
> > Sure; I've got a slightly different version because after talking
> > with Al he thinks it's OK still to put a pointer to the
> > efivar_entry in i_private, which means less disruption.  But there
> > is enough disruption that the whole of the series needs redoing to
> > avoid conflicts.
> > 
> > > I'm fine with either, but note that I'd still like to target
> > > v6.14 with this.
> > 
> > Great, but I'm afraid the fix for the zero size problem also could
> > do with being a precursor which is making the timing pretty tight.
> > 
> 
> OK, I'll queue up your v3 about I won't send it out with the initial
> pull request, so we can make up our minds later.
> 
> I take it the setattr series is intended for merging straight away?

Yes, it could be treated as a bug fix, although since only root could
truncate an EFI variable in a normal installation, it's not a huge
issue.

Regards,

James


