Return-Path: <linux-fsdevel+bounces-38098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E69FBE19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 14:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA218869D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE51DE3AD;
	Tue, 24 Dec 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="p8QGvG4K";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="p8QGvG4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3A1DE2DC;
	Tue, 24 Dec 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045673; cv=none; b=fsCtG+gNYDPVpJvYjF2bB2Hxm4sonA9Wjrgs/S6rO2Pp+4JEsicexDcxZq8wC1i3F/2aFcANI77tdjdwKLCZPJVSeISTeghqjy0WYlteJE843znJzPrFHo0B1pSOhyKkLaGFxkHrfIDwm95IkHa/4GD9G4MnlwLRtXqpOqvPrPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045673; c=relaxed/simple;
	bh=n84+6xWU0uogUdj8ByX8UIibexG/2zROUe0yTaKdnm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YnfI6+RT3v7qlfdKEw2BhP2QFfCH0ZwkWD0PAg/8P0jlEcXsJoUB4WqeXURC/Y1JoS+7lLVOvyVNRpDgQjelSxwRWVJLt4+LfoGJ3uu5qAYjStHMrdksJS139tvkbIJbw/YAmUdQ6/JdvYN3eyttQ/c51IQCqtx97wxqFgOrbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=p8QGvG4K; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=p8QGvG4K; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1735045670;
	bh=n84+6xWU0uogUdj8ByX8UIibexG/2zROUe0yTaKdnm0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=p8QGvG4K6nBej8b68CHiOZZNHrpNt5YWamE1A7sVPHKPMAIN+PzTha/VcFJbK84At
	 LrOXDGHOVSwX0dck3c6ImaSnL8jo8eWlPwXPHsKjbtCndxSyK2dfwZo9WPNGPDTNSR
	 qbN6EK9pkDtggpoEKQGNG+r/b0+OTETipYgiv5o8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9F5631281383;
	Tue, 24 Dec 2024 08:07:50 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id JAl_eYcWDTPq; Tue, 24 Dec 2024 08:07:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1735045670;
	bh=n84+6xWU0uogUdj8ByX8UIibexG/2zROUe0yTaKdnm0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=p8QGvG4K6nBej8b68CHiOZZNHrpNt5YWamE1A7sVPHKPMAIN+PzTha/VcFJbK84At
	 LrOXDGHOVSwX0dck3c6ImaSnL8jo8eWlPwXPHsKjbtCndxSyK2dfwZo9WPNGPDTNSR
	 qbN6EK9pkDtggpoEKQGNG+r/b0+OTETipYgiv5o8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E01401280EDD;
	Tue, 24 Dec 2024 08:07:49 -0500 (EST)
Message-ID: <25eadec2e46a5f0d452fd1b3d4902f67aeb39360.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr
	 <jk@ozlabs.org>
Date: Tue, 24 Dec 2024 08:07:47 -0500
In-Reply-To: <20241224044414.GR1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
	 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
	 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
	 <20241223200513.GO1977892@ZenIV>
	 <72a3f304b895084a1da0a8a326690a57fce541b7.camel@HansenPartnership.com>
	 <20241223231218.GQ1977892@ZenIV>
	 <41df6ecc304101b688f4b23040859d6b21ed15d8.camel@HansenPartnership.com>
	 <20241224044414.GR1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-12-24 at 04:44 +0000, Al Viro wrote:
> On Mon, Dec 23, 2024 at 11:04:58PM -0500, James Bottomley wrote:
> 
> > +static int efivarfs_file_release(struct inode *inode, struct file
> > *file)
> > +{
> > +       if (i_size_read(inode) == 0)
> > +               simple_recursive_removal(file->f_path.dentry,
> > NULL);
> > +
> > +       return 0;
> > +}
> 
> What happens if you have
> 
>         fd = creat(name, 0700);
>         fd2 = open(name, O_RDONLY);
>         close(fd2);
>         write(fd, "barf", 4);
> 
> or, better yet, if open()/close() pair happens in an unrelated thread
> poking around?

According to my tests you get -EIO to the last write.  I could be glib
and point out that a write of "barf" would return EINVAL anyway, but
assuming it's correctly formatted, you'll get -EIO from the d_unhashed
check before the variable gets created.  If you want to check this
yourself, useful writes that will create a variable are:

echo 0700000054|xxd -r -p > name

And to delete it:

echo 07000000|xxd -r -p > name

You can check your above scenario from a shell with

{ sleep 10; echo 0700000054|xxd -r -p; } > name &
cat name  

> I mean, having that logics in ->release() feels very awkward...
> 
> For that matter, what about
>         fd = creat(name, 0700);
>         fd2 = open(name, O_RDWR);
>         close(fd);
>         write(fd2, "barf", 4);

Same thing: -EIO to last write.

> I'm not asking about the implementation; what behaviour do you want
> to see in userland?

Given the fact that very few things actually manipulate efi variables
and when they do they perform open/write/close in quick succession to
set or remove variables, I think the above behaviour is consistent with
the use and gets rid of the ghost files problem and won't cause any
additional issues.  On the other hand the most intuitive thing would be
to remove zero length files on last close, not first, so if you have a
thought on how to do that easily, I'm all ears.

Regards,

James


