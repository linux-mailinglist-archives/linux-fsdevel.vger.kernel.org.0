Return-Path: <linux-fsdevel+bounces-56-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CE7C52DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946B2282760
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008B1EA9D;
	Wed, 11 Oct 2023 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLXiu0po"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFCF1EA71
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 12:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706D1C433C8;
	Wed, 11 Oct 2023 12:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697026021;
	bh=tFhppGBYTVfoR/zH2jQ+I6wGMyiIAXE50U79NiRo1VQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jLXiu0pou11TygVzRDl7l1fwebKf+vHNYXg87148WJCYZnR6hTAtWzlSmFpo6pE1k
	 UbjulokydwTHv2jWkjlclUkhDjl7Wfg8UskAqwmXr/3KYSkyOAN0YZ9UEWyyFQTJDF
	 cQ7cNeiI4+A20T+DJ8sz5rO3hxCMOBznBdCSu5RiB05EPmWl2mgQvvNUPx371k05Yq
	 j53pWDqVbUrX/0kyFWwSbFGil/k7tacRKkwmjTkYZcMRjEKoxRGGhRxnlJ6FYLoB3j
	 dYopGrNHlJW15BqtHe6l1YJ2PTzIjCv2cAr1bW+mgGrylTUJTul3dAeRdSSlJVMlrJ
	 0k9a4rREVQhDg==
Message-ID: <87c8dc9d4734e6e2a0250531bc08140880b4523d.camel@kernel.org>
Subject: Re: [bug report] libceph: add new iov_iter-based ceph_msg_data_type
 and ceph_osd_data_type
From: Jeff Layton <jlayton@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Date: Wed, 11 Oct 2023 08:06:59 -0400
In-Reply-To: <c5a75561-b6c7-4217-9e70-4b3212fd05f8@moroto.mountain>
References: <c5a75561-b6c7-4217-9e70-4b3212fd05f8@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-11 at 12:50 +0300, Dan Carpenter wrote:
> Hello Jeff Layton,
>=20
> To be honest, I'm not sure why I am only seeing this now.  These
> warnings are hard to analyse because they involve such a long call tree.
> Anyway, hopefully it's not too complicated for you since you know the
> code.
>=20
> The patch dee0c5f83460: "libceph: add new iov_iter-based
> ceph_msg_data_type and ceph_osd_data_type" from Jul 1, 2022
> (linux-next), leads to the following Smatch static checker warning:
>=20
> 	lib/iov_iter.c:905 want_pages_array()
> 	warn: sleeping in atomic context
>=20
> lib/iov_iter.c
>     896 static int want_pages_array(struct page ***res, size_t size,
>     897                             size_t start, unsigned int maxpages)
>     898 {
>     899         unsigned int count =3D DIV_ROUND_UP(size + start, PAGE_SI=
ZE);
>     900=20
>     901         if (count > maxpages)
>     902                 count =3D maxpages;
>     903         WARN_ON(!count);        // caller should've prevented tha=
t
>     904         if (!*res) {
> --> 905                 *res =3D kvmalloc_array(count, sizeof(struct page=
 *), GFP_KERNEL);
>     906                 if (!*res)
>     907                         return 0;
>     908         }
>     909         return count;
>     910 }
>=20
>=20
> prep_next_sparse_read() <- disables preempt
> -> advance_cursor()
>    -> ceph_msg_data_next()
>       -> ceph_msg_data_iter_next()
>          -> iov_iter_get_pages2()
>             -> __iov_iter_get_pages_alloc()
>                -> want_pages_array()
>=20
> The prep_next_sparse_read() functions hold the spin_lock(&o->o_requests_l=
ock);
> lock so it can't sleep.  But iov_iter_get_pages2() seems like a sleeping
> operation.
>=20
>=20

I think this is a false alarm, but I'd appreciate a sanity check:

iov_iter_get_pages2 has this:

	BUG_ON(!pages);

...which should ensure that *res won't be NULL when want_pages_array is
called. That said, this seems like kind of a fragile thing to rely on.
Should we do something to make this a bit less subtle?
--=20
Jeff Layton <jlayton@kernel.org>

