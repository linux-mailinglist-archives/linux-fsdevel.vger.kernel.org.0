Return-Path: <linux-fsdevel+bounces-41086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9765AA2AB71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 15:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32ABF3AB821
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02091624C2;
	Thu,  6 Feb 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDkjfouy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4472136352
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852250; cv=none; b=BJx8VNzhu+UTa/yAQqFQzK14z/nCSgO4jN9srjaIRxxkbY2fdCsXIB7UHvh8LJryPke9gKmLAr0M30HhsyOyGIuPKXxuKCgzmkUShS9nYPMBRtxoSe1rh3ieHK/FEcjFtInuWio/hfE2XXy6h7S8Xo+kupNyGvXmtu89Lfs+41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852250; c=relaxed/simple;
	bh=WdipNZI3y5wwEW1WPJkKmfPilkJ7iVaBxEPNzdzmX4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK994UcfiBOktxu+JRMcKK/MxNE4qtcIE9qJ3BFvMY2JScuUY4N74+mt3HkcZIdg7K9RiGhoyIzhHyKpbitn0ueQXWpg1TwuB9S7gImBCG2RzugX4EPFB9INIYFoMnfrznOp1WXLPbeSmcAvUESixwU/mm9u1eVRRZKAEKLgYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDkjfouy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738852246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WdipNZI3y5wwEW1WPJkKmfPilkJ7iVaBxEPNzdzmX4E=;
	b=CDkjfouyt5dauUvfIC7ViNGjW3fTIMDVyTCX3dsHs8Z5w4RfUfCxD+D5wQsK8l1cmH2SXN
	0PHJPqTyne8Bmrr7LAmkIQccLhQ6aZwBgP3jzT8lmE3eTqGUXUJSD7kSh575dlDvoxt275
	Bt6yi//cS5ogLeqN+q+v78ujJUn5+so=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-jpp1Wx5AN3GqEECzTVdKQg-1; Thu,
 06 Feb 2025 09:30:43 -0500
X-MC-Unique: jpp1Wx5AN3GqEECzTVdKQg-1
X-Mimecast-MFC-AGG-ID: jpp1Wx5AN3GqEECzTVdKQg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAACC1956086;
	Thu,  6 Feb 2025 14:30:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.145])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D97B1800878;
	Thu,  6 Feb 2025 14:30:33 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:30:32 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net,
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
	loongarch@lists.linux.dev, Hanna Czenczek <hreitz@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v6 01/26] fuse: Fix dax truncate/punch_hole fault path
Message-ID: <20250206143032.GA400591@fedora>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <bfae590045c7fc37b7ccef10b9cec318012979fd.1736488799.git-series.apopple@nvidia.com>
 <Z6NhkR8ZEso4F-Wx@redhat.com>
 <67a3fde7da328_2d2c2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <Z6S7A-51SdPco_3Z@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dVdFjdbROmPA0Gp+"
Content-Disposition: inline
In-Reply-To: <Z6S7A-51SdPco_3Z@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--dVdFjdbROmPA0Gp+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2025 at 08:37:07AM -0500, Vivek Goyal wrote:
> And then there are challenges at QEMU level. virtiofsd needs additional
> vhost-user commands to implement DAX and these never went upstream in
> QEMU. I hope these challenges are sorted at some point of time.

Albert Esteve has been working on QEMU support:
https://lore.kernel.org/qemu-devel/20240912145335.129447-1-aesteve@redhat.com/

He has a viable solution. I think the remaining issue is how to best
structure the memory regions. The reason for slow progress is not
because it can't be done, it's probably just because this is a
background task.

Please discuss with Albert if QEMU support is urgent.

Stefan

--dVdFjdbROmPA0Gp+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmekx4gACgkQnKSrs4Gr
c8jOKwf/ZukZTp1v1Bj1iqbpAm6HBWN90Y4JWmyzZGuKRqLAwN8AyiIJ6Ms1fx+v
WJLR47NztCQ3sDtsTQT1814wwXSpJlPguLu6isoWbCGpUwAZZk3JTpHNBofs7IKj
04NWFZ9B2tOVgirm8OMtsVVJwzQhvQc7YtMhdB9naCzqcdC7ynKp6mLH9bd7Q+Ze
K9CwEFtKcTm9Ge+t3U0E3Q7MI2D55far3KPi84MpfI9oEu6l0MOzzmKjaOBq9+wy
XXZCisxWbGLZtfbY2BAQxTUhKq9TTXgeQm/Ti/SzsVLf/Qd7nrEkG1v51xs5HCnR
FMQhDw7oBmFsGs5S/Qywvta1pcaYwg==
=JZcT
-----END PGP SIGNATURE-----

--dVdFjdbROmPA0Gp+--


