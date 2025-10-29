Return-Path: <linux-fsdevel+bounces-66355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE522C1CC08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FBE586F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B635470C;
	Wed, 29 Oct 2025 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qstw6GBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25A2F83BE;
	Wed, 29 Oct 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761320; cv=none; b=fezJ3ptepyU1oMSN954Z1rO6258PI/Q5tfR2/jDdoz80VHexBX1LPfpJT7wCVbvI6r2F2DbOanSS1h++f9A1vu7eAN2adLIo++ssL3aHGbQiS6EzNwfXTyL+n5dK4Zj0+6NptgfzN+Z+ri6o6MDhwxfcyUAQcueu7FRN2+TKjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761320; c=relaxed/simple;
	bh=3a6hJSaGrmh4VTyPvVaQviVW2k2fiU4d14sr77xDXLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baQBeKr2iwcmI+InahVymLDsExnL7TYt1N0w7cp2ua+8bp0DY5/W5QmwwiVQ1NLZG1AERuIgSZ/jfl0B9BgqnBGSBXvN9kycaHJg8BJlzoxDNyIgUws0y6E+T0XjKrDW0s/oiiFSjHe8u6atCD7jVZDLKmO3LXvmE+Hy114vbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qstw6GBW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IRO5/rJhd7y6qAbtBBfOnyjO73djps2jbwQIhCfiClo=; b=qstw6GBW0gz7l6/NIZ98+H0BuC
	LPcTpqbv6qZwuSaVXzFp5+8p3uItulr9RO1wyw6k1QzQVAfHUp/CtKNeZtDmZSm+sgFarRadUCpBK
	QZrzf7l+w0/cYrUWCRtQcOPwVpTXfR6WfE4DMsjuxuOQV+z0xqou2NBsCOGqqoMuLcuomyEM5NJXa
	RJQMFf1J+khB5G8o/qb4hoF8XxOYm1SETmvEkodR0rT9kGWkPtyAGI//REIRqkdUm4sCbPWkkDpIi
	qeQgTiYS1sVVgCHccSx1/k4oTcfdfgLL7bzYX5FyStzF5GG23KhpEBcGZmGVQXrQATbM/9H02+9/9
	Dy4tNtaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEAb5-0000000DNn5-15k7;
	Wed, 29 Oct 2025 18:08:35 +0000
Date: Wed, 29 Oct 2025 18:08:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251029180835.GT2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk>
 <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV>
 <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 10:34:51PM +0100, Ard Biesheuvel wrote:

> I'll let James respond to the specifics of your suggestion, but I'll
> just note that this code has a rather convoluted history, as we used
> to have two separate pseudo-filesystem drivers, up until a few years
> ago: the sysfs based 'efivars' and this efivarfs driver. Given that
> modifications in one needed to be visible in the other, they shared a
> linked list that shadowed the state of the underlying variable store.
> 'efivars' was removed years ago, but it was only recently that James
> replaced the linked list in this driver with the dentry cache as the
> shadow mechanism.

Hmm...  Another question about that code: is efivar_get_variable()
safe outside of efivar_lock()?

