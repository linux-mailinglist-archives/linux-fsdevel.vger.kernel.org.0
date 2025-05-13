Return-Path: <linux-fsdevel+bounces-48889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF379AB54E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C046318839DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA11E2920B9;
	Tue, 13 May 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="C+rU7Uyx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A8C292080;
	Tue, 13 May 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139706; cv=none; b=YIPjQ5o606Oa0tdjQmbzu5PDlWItsaq4M8m9LyI6EGzMtx17KfFHpjwuFcslJ6pfJKEDsN+1NCADFkz9BSc2oFBa632C/lkox+spka/rI1XJ/wFIbKu69413dZx4AsZOkfmrhVf1Bzqm5MZsXu2LvWz0J+SWdZEIbRHsH/WIA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139706; c=relaxed/simple;
	bh=ALZ1Y7eqeIWSLtwlNHJDTVrJdqlFq8VngIWKMheXNFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GIrolWYNIAQS0SAg4BiX4QgVHea2d79CapBSRg/ZoXkx4AM9nLWFoqdBig8UNKrYp6JnzlQFBEIsajScvDQukzbkT+HH6PIPb+JBKr0jwWb5VehgTxAY5Ji76XPwZIrl06zXu0SUyid9qKKDiv3jJmTL4bS720lLLqpRXbYcAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=C+rU7Uyx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AChJjkRKBoBFtHqem4qBYNs6qVLL45ojY4c6NPKMb9o=; b=C+rU7Uyxy0fy+XvPUi/b9wBSH6
	f1Oaq+JFoZ2kEvKBzeOGCfjDNTnBW5a59B3zdZrOthZUeT429bWEjQBlzWvj0+T9PhglztIC8ap6s
	6zxt9HA2gkZ4MeMpCMr5dEkhu7vizKzZzcvj9iGpcnwrSryfSNoCkOTRa1mJs32s8l4c+sK0YZsuX
	YydMsc6m0WdsWBnRMAMO6gECsuEjQpKetgBXN0S8A+eGe+crRgvQdNY43fTK/qnvGQXaWhUz+PsgE
	igQS5oXPY9XRNbM6Abn69gvsFfQLvjinPX/Ocntl49AdxGiemwVb6GAMQ7unbobB2LqI3ULflJ4da
	puEG9+IQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uEol6-007b70-8h; Tue, 13 May 2025 14:34:53 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2] fuse: add optional workqueue to periodically
 invalidate expired dentries
In-Reply-To: <CAJfpeguD6jR7AQ=BWs-nKyT4ZV4d35KLM9UPZNzMd-SkcngmzQ@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 13 May 2025 11:56:02 +0200")
References: <20250415133801.28923-1-luis@igalia.com>
	<CAJfpeguD6jR7AQ=BWs-nKyT4ZV4d35KLM9UPZNzMd-SkcngmzQ@mail.gmail.com>
Date: Tue, 13 May 2025 13:34:47 +0100
Message-ID: <87tt5o7kpk.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

On Tue, May 13 2025, Miklos Szeredi wrote:

> On Tue, 15 Apr 2025 at 15:38, Luis Henriques <luis@igalia.com> wrote:
>
>> +inval_wq=3DN
>> +  Enable a workqueue that will periodically invalidate dentries that
>> +  have expired.  'N' is a value in seconds and has to be bigger than
>> +  5 seconds.
>> +
>
> I don't think a mount option is needed.  Perhaps a module option knob
> instead is sufficient?

Sure, that should do the trick.  It'll still be set to zero by default
(i.e. no periodic invalidation), and it won't be possible to tune it per
mount.  Which is probably the right thing to do.

>> +static void fuse_dentry_tree_add_node(struct dentry *dentry)
>> +{
>> +       struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
>> +       struct dentry_node *dn, *cur;
>> +       struct rb_node **p, *parent =3D NULL;
>> +       bool start_work =3D false;
>> +
>> +       if (!fc->inval_wq)
>> +               return;
>> +
>> +       dn =3D kmalloc(sizeof(*dn), GFP_KERNEL);
>> +       if (!dn)
>> +               return;
>> +       dn->dentry =3D dget(dentry);
>
> A dentry ref without a vfsmount ref is generally bad idea.
>
> Instead of acquiring a ref, the lifetime of dn should be tied to that
> of the dentry (hook into ->d_prune).
>
> So just put the rb_node in fuse_dentry and get rid of the "#if
> BITS_PER_LONG >=3D 64" optimization.

OK, this probably makes more sense.  I'll have a closer look at the
details, but it seems to be a better option.  Thanks a lot for the
suggestion.  I'll work on that for v3.

Cheers,
--=20
Lu=C3=ADs

