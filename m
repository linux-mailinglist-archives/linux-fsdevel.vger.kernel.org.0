Return-Path: <linux-fsdevel+bounces-24407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CBC93F09F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88231F22CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0913DBB7;
	Mon, 29 Jul 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="i38KA+6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D5768FD;
	Mon, 29 Jul 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244221; cv=none; b=P6B8+zs8wX6xDqvNJf4P6kv2AZi5oPIO1o31AzGvhP+gI2JRP8ULJj3DLhneu1KjedQQsmO2qFIkhh1ozm1qb8J1aBxc14nOTBcngkF+zZ2TyxbAWzW1wYKbrZDOL/azOwcic1V3AYpSzUl60na69PVRJ4wpCtKDR7FzNAxnBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244221; c=relaxed/simple;
	bh=BmiWqbDDtGLB3udRWihfX0ZZoQZkION2o8SQ0QfjZ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv4mSN35MHnq7U0PU/xmS4Yxiuq8U7YntxW7r9ZbDAKXkVMlGftd1UT25F6zmD4aVBbhM27XsioQc5XyKVA1OUQmpiiMFTqgfLpNeDG0WugoH5pAcC/Oc/ULyNOmYbiUT7hHSb/Qey3As4s8nZLePqxLbCvj3tAa+FdEfDJ/CtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=i38KA+6s; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WXXcv5nM9z9sV3;
	Mon, 29 Jul 2024 11:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722244207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9SqaCRWdjk6eAWW49mlmFKMZLcH9AU3/OOUjjAumnM=;
	b=i38KA+6sJEbkTInWVKl7HEA+cCuzBKxugWqU0B5GSojrejT6ARSeDkgj+3FS51RnpyJCqK
	KwrPhmrIB/eFN0TkzM0RMo6bt7rCuHaVuc8ya0/+4c71NfMSRqAwDS8ws7IpNVEHE1Hwav
	s1s70uyeeZzrRZZZY5uueSpMSBhwR+dXIdM8XH+NmxiaeaxY/eAbA/MBkEnQQiKdTl11cW
	uSF4Z+JrEopesL4mkYZtmiwIhwCnfNXec48+cebJGTj7mrrXryzGaX/iTMMY3f++Bqu3ZX
	AQkMyztb+hnTCsfrbTpGLBMfy7j4Oglbnd+HU9H8iH6nAz7zHzCzC+6jtnNF1w==
Date: Mon, 29 Jul 2024 19:09:56 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <20240729.085339-ebony.subplot.isolated.pops-b8estyg9vB9Q@cyphar.com>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jsd7iz5jisukyam5"
Content-Disposition: inline
In-Reply-To: <874j88sn4d.fsf@oldenburg.str.redhat.com>


--jsd7iz5jisukyam5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-29, Florian Weimer <fweimer@redhat.com> wrote:
> It was pointed out to me that inode numbers on Linux are no longer
> expected to be unique per file system, even for local file systems.
> Applications sometimes need to check if two (open) files are the same.
> For example, a program may want to use a temporary file if is invoked
> with input and output files referring to the same file.

Based on the discussions we had at LSF/MM, I believe the "correct" way
now is to do

  name_to_handle_at(fd, "", ..., AT_EMPTY_PATH|AT_HANDLE_FID)

and then use the fhandle as the key to compare inodes. AT_HANDLE_FID is
needed for filesystems that don't support decoding file handles, and was
added in Linux 6.6[1]. However, I think this inode issue is only
relevant for btree filesystems, and I think both btrfs and bcachefs both
support decoding fhandles so this should work on fairly old kernels
without issue (though I haven't checked).

Lennart suggested there should be a way to get this information from
statx(2) so that you can get this new inode identifier without doing a
bunch of extra syscalls to verify that inode didn't change between the
two syscalls. I have a patchset for this, but I suspect it's too ugly
(we can't return the full file handle so we need to hash it). I'll send
an RFC later this week or next.

[1]: commit 96b2b072ee62 ("exportfs: allow exporting non-decodeable file ha=
ndles to userspace")

> How can we check for this?  The POSIX way is to compare st_ino and
> st_dev in stat output, but if inode numbers are not unique, that will
> result in files falsely being reported as identical.  It's harmless in
> the temporary file case, but it in other scenarios, it may result in
> data loss.

(Another problem is that st_dev can be different for the same mount due
to subvolumes.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--jsd7iz5jisukyam5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZqdcZAAKCRAol/rSt+lE
b9O+AQD15ugTB+YnzeUcXPNkM1xWKdFiap7ldvh21lZv4FeL5AEAxFeM/gbmUMLQ
fYiOKB6lLxZLSVX8IjFmedhKTdgj1wA=
=uVP8
-----END PGP SIGNATURE-----

--jsd7iz5jisukyam5--

