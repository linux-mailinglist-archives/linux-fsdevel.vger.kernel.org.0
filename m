Return-Path: <linux-fsdevel+bounces-2713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1517E7A70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF321C20DAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FFA10967;
	Fri, 10 Nov 2023 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U+TV4QmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCD1094C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 09:06:41 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B3AFAC;
	Fri, 10 Nov 2023 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aAA3dG3KqldTpNWyLJbx7Ihw915hKmwBjd6hcd38rpo=;
	t=1699607200; x=1700816800; b=U+TV4QmHX9inmiakgvsXStLBoJG5IjvkhQp86rF9jRCEiS7
	hwjlpSO1PK6on3C9ETbajn73FFlIAdMQjeKP3Hz3hH6JS6jnOyjO8JIruu1Azk2f7O9gk+O9zU0v6
	o6jcpNJ+7pH4Dohfp1jNF0H9MT8kqDPQOCzmRb2THqYNKA/DCzHknRuqIxYojOXgfgKUu/OB4kieG
	PP2mXmAhrlvjuAksMzozk0Bc2WeKhxd4MNNdy4L6vQWB1Ne98PWorkR0aBHlbNPQ33pbdYQZVvmhe
	K/IhoTWbwkN4Nqdow5BeLXE5kjZnTYvZtygmpfM3p6Kpl84XrIQoH5aiX3QRUpbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1NTI-00000002u7Q-0SQI;
	Fri, 10 Nov 2023 10:06:36 +0100
Message-ID: <5cffded318675a981779194a73d97b274338b7d1.camel@sipsolutions.net>
Subject: Re: [PATCH] debugfs: only clean up d_fsdata for d_is_reg()
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Rafael J.
	Wysocki" <rafael@kernel.org>, Nicolai Stange <nicstange@gmail.com>
Date: Fri, 10 Nov 2023 10:06:34 +0100
In-Reply-To: <2023111055-gratitude-prance-6074@gregkh>
References: 
	<20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
	 <2023111055-gratitude-prance-6074@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2023-11-10 at 04:56 +0100, Greg Kroah-Hartman wrote:
> >=20
> > Also check in debugfs_file_get() that it gets only called
> > on regular files, just to make things clearer.
> >=20
> > +++ b/fs/debugfs/file.c
> > @@ -84,6 +84,9 @@ int debugfs_file_get(struct dentry *dentry)
> >  	struct debugfs_fsdata *fsd;
> >  	void *d_fsd;
> > =20
> > +	if (WARN_ON(!d_is_reg(dentry)))
> > +		return -EINVAL;
>=20
> Note, the huge majority of Linux systems in the world run with "panic on
> warn" enabled, so if this is something that could actually happen,
> please just handle it and return the error, don't throw up a WARN()
> splat as that will reboot the system, causing you to have grumpy users.
>=20

Well, given the use of the d_fsdata, without this check you would get a
crash a few lines down in the code because:

1. if you call it with an automount dentry, the pointer is a function
   pointer and you can't increment a refcount in .text memory

2. if you call it with any other kind of entry other than regular, the
   pointer is NULL and you can't increment a refcount at just over NULL
   either

I would think this cannot happen in the current kernel now, so the check
is more (a) a sign to readers to show the intent of the function, and
(b) a help for future users of debugfs to tell them in easier terms when
they got it wrong. It just seemed nicer to not crash in weird ways (or
corrupt .text if you don't have read-only text, but is that still a
thing anywhere?) than crashing with strange errors (especially in 1.).

But hey, I can just as well remove it.

Note that the other part of the patch here is wrong anyway though, so
this patch isn't any good. I posted the replacement here:
https://lore.kernel.org/lkml/20231109222251.9e54cb55c700.I64fe5615568e87f9a=
e2d7fb2ac4e5fa96924cb50@changeid/

johannes

