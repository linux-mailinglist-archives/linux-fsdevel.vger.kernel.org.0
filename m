Return-Path: <linux-fsdevel+bounces-46890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58224A95F1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84854177195
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B3239567;
	Tue, 22 Apr 2025 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPJ89rt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24C238C31;
	Tue, 22 Apr 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306410; cv=none; b=tAcpsXUSonF5R5zcYwgQ+IasAYVDPNHwmqEe9miW3dabVN1j4C2G/uUFCqfQ2Bhuu9uYKtSIaOydLAISo+m7Q79JmnyMcQirS8DIFXqpda0moYhWS5Bnd6wEihVu/Jsg1GQ9SIO5riLooipPJV+9RW7vvZyFfkynCxXq/Cqy5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306410; c=relaxed/simple;
	bh=qUBVDgrrLi3yE8NeOTL0RJBzce75/+0w26+iXhu5pbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtvewn+Jtj3oMWTg/Zv/Chcms3eu33kea3OLskr4G0ZisnJ/jd7gnFbBxNanitoh/QnAcQ0y5sLzHM6ZMKb7lb06uINu3y5iqUtY3ei2GqENjYer/UuVZeBTs3ayMZCnAf8fXlc0RuX5eZfL7nEZUGfeh5+ltxkyJ+08yPFfYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPJ89rt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235CBC4CEE9;
	Tue, 22 Apr 2025 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745306410;
	bh=qUBVDgrrLi3yE8NeOTL0RJBzce75/+0w26+iXhu5pbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPJ89rt/qZ53eNF9sh7a5FPZUbugWhnhJOPiEadEE/g+syqi2HZWvsfq/eRhb94yM
	 2lZ49vgZKGMVMXHYrmuxurqXM0gO2YKZjvmhpVRLXzl72KIISswe1fVpr01w0zHUjx
	 OoPxkw/AI2XMjKCcHazNZK8nvlQaQcE4PZJhw4eC9rM77T7Dq0sjVELIhscDhQ7a9X
	 FSIHPMPxvwTnELOvuz18v6Eq8oprRLVx307T7CNXfZboyJQRMfmRt77Mu+CT58s4qP
	 2/mtKLrHgrd/2ufhicyw5EbotbtZrvuGpYlHpGZ+tRB/5K55t+GxmaUVSVLcd9XMQ/
	 xQzNs8bj1cCRg==
Date: Tue, 22 Apr 2025 09:19:58 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, aarcange@redhat.com, 
	linux-man@vger.kernel.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <cbppxyb7pe3yhmru226db5zt3v67sxsvfzjvg4jn62gzltutbl@vipuebrhjgpj>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-3-surenb@google.com>
 <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local>
 <rns3bplwlxhdkueowpehtrej6avjbmh6mauwl33pfvr4qptmlg@swctg52xpyya>
 <CAJuCfpFjx2NB8X8zVSGyrcaOfwMApZRfGfuia3ERBKj0XaPgaw@mail.gmail.com>
 <CAJuCfpHpdAn6yNVq1HXqO0qspj6DLb4qa_QufT+Z9RLTTa-N9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwk5znj7d37gjxbi"
Content-Disposition: inline
In-Reply-To: <CAJuCfpHpdAn6yNVq1HXqO0qspj6DLb4qa_QufT+Z9RLTTa-N9Q@mail.gmail.com>


--hwk5znj7d37gjxbi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, aarcange@redhat.com, 
	linux-man@vger.kernel.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-3-surenb@google.com>
 <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local>
 <rns3bplwlxhdkueowpehtrej6avjbmh6mauwl33pfvr4qptmlg@swctg52xpyya>
 <CAJuCfpFjx2NB8X8zVSGyrcaOfwMApZRfGfuia3ERBKj0XaPgaw@mail.gmail.com>
 <CAJuCfpHpdAn6yNVq1HXqO0qspj6DLb4qa_QufT+Z9RLTTa-N9Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJuCfpHpdAn6yNVq1HXqO0qspj6DLb4qa_QufT+Z9RLTTa-N9Q@mail.gmail.com>

Hi Suren,

On Mon, Apr 21, 2025 at 08:58:22PM -0700, Suren Baghdasaryan wrote:
> > > Please re-send including linux-man@ in CC, as specified in
> > > <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CON=
TRIBUTING>
> >
> > Thanks for the reference. Will post the documentation update later toda=
y.
>=20
> Was planning to post today but I'm a bit rusty with the syntax.
> Will try to send it out tomorrow

No problem.

> after verifying the results.

For verifying, you might want to try diffman-git(1).  It's provided in
the man-pages repo.  If the version of the man-pages package provided by
your distro is >=3D6.10, you may already have it in your system, and if
not, you can find it as <src/bin/diffman-git> in the repo.
It's documented in a manual page in the same repo, of course.

I don't know if you know about the build system, which also checks a few
common issues in the pages.  You can check <CONTRIBUTING.d/lint>.
TL;DR:

	$ make -R -j8 -k lint-man build-all check;

(You can ignore anything that's not about the page you're modifying.  At
 the moment, I see a few issues that I'll need to investigate in a few
 pages.  For seeing a clean list of what's failing, you can ignore
 stderr; see below.)

	$ make -R -j24 -k lint-man build-all check 2>/dev/null
	TROFF		.tmp/man/man2/statx.2.cat.set
	TROFF		.tmp/man/man2const/KEYCTL_SETPERM.2const.html.set
	TROFF		.tmp/man/man2const/KEYCTL_SETPERM.2const.pdf.set
	TROFF		.tmp/man/man2const/KEYCTL_SETPERM.2const.ps.set
	GREP		.tmp/man/man2/pipe.2.check-catman.touch
	GREP		.tmp/man/man3/ctime.3.check-catman.touch
	GREP		.tmp/man/man7/landlock.7.check-catman.touch
	GREP		.tmp/man/man7/rtnetlink.7.check-catman.touch


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--hwk5znj7d37gjxbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgHQxgACgkQ64mZXMKQ
wqn5wQ//avin9I8qSE9aZyQnqceYjyYuR5Ao8l9niCBc84U36Ewo9nDvZTTPaRtj
NMpX9Ze0BDiIGzidz3L7v0LenSCngGCbERA9ysyOAfEe6MpUO4EQHRhAd8/XIMvK
k4uPZG0kWKAZ8Nvs6AfKTWwG4cNi6yMhHVKmO7EOCj8J911ofDXrvXCfdTqzVx0k
3sbJSWjXIJtB9KVAwVJPAii4jdqZNTMeLwNWswA7OoqR0yxcMVM2V+j20O9BPCaJ
gNwIL3mDqb3cSJ5xmKsS1p77RiiDBsMxQiy1O0yYEqoVvq22usQpH93OkpECBN3h
MqyYJRx2qYmF6daNjiwhPh1N1iRmK2sX8ghFOzfIHSMAuZL7v49VHEbHOSmKQWkp
HVUGOiky5IOGbwkVqE2dD1Dy3VP0KHlIVoZYhiURnxFtut4tLVw1Fn92GwYkyR9K
lsd4VTmBeshvWXbcOGF+DRj658I7mf99AtM6Jxg55yX6iEqE4kJaR079hjQcnPBq
CJyi0O+cxNtu8+AftF3V45CFj5GrkdjYD9d8FPjmDTO/OuImaZoTf7+/E6NO/Uyo
QSiTGwOachDATwJqAL5JkJIk9L05NZSahppo4HlzHzz5snKC4jbGPUxpZdVMkrCk
OfrS5/dVhGfG8SOYslhK3qbEdQnMZOh24I/Ju8qDlwTjQwc9jVE=
=3fxc
-----END PGP SIGNATURE-----

--hwk5znj7d37gjxbi--

