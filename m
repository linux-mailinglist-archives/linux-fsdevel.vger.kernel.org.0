Return-Path: <linux-fsdevel+bounces-74304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91701D392E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 06:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE88B3010E75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5519C2580E1;
	Sun, 18 Jan 2026 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhffiqvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C01946C8
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768713605; cv=none; b=oGBjQWNa26Zq2w4oZAUhh1yWseRU+xdrlXX+7IuK92YXf1obKOAPrSrepDHkhIPDewusevNCPZ21Iifl5/82s5kQPef+4MSZbZY/sidO+zHJDy4CkgrqWp5OIOAwUbYSAmGpOYJCzyN6m3q9YSFVtCpYr6f/5C/pf1guAfqI5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768713605; c=relaxed/simple;
	bh=89AvlqLuM05wSy4slqJggmxC8KN+/ajqbIx7cT1bBWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbKRoVE7cfHi4W05wDp3J6wOtZKQGe7Lq8ArcZKvH04ZDg8DLk/fQOfih78+zjcUMzWl5VIPEP2AV/vAU6xRbSiFMIvN4jdiBsMJgGb3kM4Ly1xoCyF81fE/88nx9P79e4pDilKkuKrlYXHBQOv8o6Pj41mKlJPqftfEUitVxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhffiqvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C12DC2BCAF
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768713605;
	bh=89AvlqLuM05wSy4slqJggmxC8KN+/ajqbIx7cT1bBWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uhffiqvNgjTaG9857Np0oBMOH5pySEXHjodjTCVwZydoGlnjsKsSKDLLLC3V/P8ih
	 K49HtuTVN1anDkT4o6pDxmCJYxOvJ0HxX215+YGRmqiWOFjlEv3auuaSc9PKar/qFW
	 +SHwzXv/0YZI79Xqjc6Jj2aSV2NAxOSHvN49GEbLYYw6wJ6BYhbVj22sCnX3G1YXh5
	 YybCo0RGNUYbIQW3ZzgM5wUvTmXWw5CyYUmT8L08hZjN4SnV7LIle//JDEXbi+uO0E
	 Kj6MCc4fAmgPefCw1MU20TQZA/r56Uw7P1ilakaTb++phfb9EiCY++3Ad2bhiLbT33
	 Nq6olgs+tQdVQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so6236666a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 21:20:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrL3cOVzrnCd5hPT+HDjqjGat3B5Jhj/p7PD9nnIL4KHqi6OIdSRqzGD+LsZmVUEUInaJr9XQTh6vfng+d@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrffHbr9K8wmgRJOk46JgipEkeECh3g/vFCiVDRA5R4CKkchx
	jrducaBStWfsUMyD/W0rMDS0364Dufx+HjWJlZS+Rm8Mi5HbOMEkwwCUlbL1cCtD72vxSWhzjdk
	gJahSLLlwE0q/Z5tzxUHCXbto+ekIIHM=
X-Received: by 2002:a05:6402:42d3:b0:649:a63f:bea9 with SMTP id
 4fb4d7f45d1cf-65452ad109emr5943130a12.16.1768713603967; Sat, 17 Jan 2026
 21:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260116093348.GA22781@lst.de>
In-Reply-To: <20260116093348.GA22781@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 14:19:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9CXj5hZ2zoiyEgrBWA6NB1u2VrBEcOGCwCPCSZODzp6w@mail.gmail.com>
X-Gm-Features: AZwV_QhJalJuf0pW6rgRIvQOiEAkkiG_wdBx7vzCgXuWUuHf6hhq2F4dgLnQZEY
Message-ID: <CAKYAXd9CXj5hZ2zoiyEgrBWA6NB1u2VrBEcOGCwCPCSZODzp6w@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ntfs filesystem remake
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:34=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 11, 2026 at 11:03:30PM +0900, Namjae Jeon wrote:
> >    a. Pass more xfstests tests:
> >       ntfs passed 308 tests, significantly higher than ntfs3's 235.
> >       ntfs passed tests are a complete superset of the tests passed
> >       by ntfs3. ntfs implement fallocate, idmapped mount and permission=
,
> >       etc, resulting in a significantly high number of xfstests passing
> >       compared to ntfs3.
>
> I'm not sure how many tests are actually run for the ntfs variants
> because they lack features needed for many tests, but how many still
> fail with this, because with these numbers I suspect there's quite
> a few left. Do you have any good grasp why they are failing, i.e.
> assumptions in xfsteasts, or missing feature checks?
Regarding the xfstests results, many of the 'Not Run' cases are due to
fundamental differences in the NTFS architecture. For instance, NTFS
does not support certain advanced features like reflink, which causes
many tests to be skipped. Also, ntfs does not yet support journaling,
leading to failures in tests that assume journal-based consistency.
I am currently categorizing these failures to distinguish between
NTFS-inherent limitations and areas for future improvement. I will
provide a detailed breakdown and analysis of these test results in the
cover letter on next version.
>
> Also adding this here instead of for the various patches adding the code:
> there's a lot of problems with kerneldoc comments that make W=3D1 warns
> about.  I think a lot of those are because comments are formatted as
> kerneldoc when they should not.
Okay. I will fix it.
>
> Sparse also reports quite a lot of endianes/bitwise errors which need to
> be addressed.
Okay, I will fix it.

Thank you!
>

