Return-Path: <linux-fsdevel+bounces-62346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5057EB8E6AF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 23:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45814189C8B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07C2D0C7E;
	Sun, 21 Sep 2025 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D6eGh2zq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2652C234C;
	Sun, 21 Sep 2025 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490881; cv=none; b=AzFKCgwphWBN9wxkDs3pIjh9W1gJzEHDgo2ooFY3WQhMye3qHtrKY1ltsqmJQyuyOrdHAptPeKCwhgGVLYUfVJ+L0kKryoSIiWIRhZukJ2O05FvB6q91i/X2ukSwmaLi1vzSXJYSKOa3DtnKv8r7Ue5PTKbnjlQmCYfX2M4Y9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490881; c=relaxed/simple;
	bh=4/Lo9pc54dwz1pNAGHoD+qhE3kjyG3pGYOwUU9qclMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk4nBjABuln5JBk3oL/DE8k+HL21s4+6cm3pRqs9w/B1cixIO7AT5nGqlhGyI7LzbL2KvfDc32kp/8tH4O2NU/xIFu9xNts1/7y/cAzT9cv1TUtR93UmFwL+hKVBQSU3rtYR2nYRNGiIE8dy5GqTs2u/POWz79aeDqYbVevpZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D6eGh2zq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JuSledGVlsd1nGFIYeP2LeRxhY2XqQo+JLMJxEt7XQ0=; b=D6eGh2zqLszRWq9Eu232EFA+yr
	at+EdwGcFAeI++enkZQ0p1Qrs6uTONoHu0UQcAcmaECjh/cVHlkG4kvZDAEO9ZTfcpoNkGgg9SjGj
	b8UhNcTETW53GHDCxlHMXWKWyHmZesVVzhCCC0cLs3pys3XBgn0JW0hdGO85tojjUhqOcNIiIu1h8
	CO9IrCD6GyxU07TUSioZ+YF2alxoId9dI8pgcSbwMwKBS2Jhe36fbEgyW47XTofxeoGCcLyiNpMjU
	FB/AxH6uYInq2mp84uYnmO2nVaeqQpzBKsv1LMnaEhOEfSGq3zlBcAe0i3dMUakcOMDFUqccJELH4
	96qBOT4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Rny-00000003LSH-0ZAY;
	Sun, 21 Sep 2025 21:41:10 +0000
Date: Sun, 21 Sep 2025 22:41:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, kees@kernel.org,
	casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
	john.johansen@canonical.com
Subject: Re: [PATCH 31/39] convert selinuxfs
Message-ID: <20250921214110.GN39973@ZenIV>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk>
 <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 21, 2025 at 04:44:28PM -0400, Paul Moore wrote:
> > +       dput(dentry);
> > +       return dentry;  // borrowed
> >  }
> 
> Prefer C style comments on their own line:
> 
>   dput(dentry);
>   /* borrowed dentry */
>   return dentry;

Umm...  IMO that's more of an annotation along the lines of "fallthru"...

> > @@ -2079,15 +2088,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
> >                 goto err;
> >         }
> >
> > -       fsi->policycap_dir = sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
> > +       dentry = sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
> >                                           &fsi->last_ino);
> 
> I'd probably keep fsi->policycap_dir in this patch simply to limit the
> scope of this patch to just the DCACHE_PERSISTENT related changes, but
> I'm not going to make a big fuss about that.

Not hard to split that way.  Will do...


BTW, an unrelated question: does userland care about selinuxfs /null being
called that (and being on selinuxfs, for that matter)?  Same for the
apparmor's securityfs /apparmor/.null...

If nobody cares, I would rather add an internal-only filesystem with
root being a character device (1,3) and whatever markings selinux et.al.
need for it.  With open_devnull(creds) provided for selinux,
apparmor and whoever else wants to play with neutering descriptors
on exec...

