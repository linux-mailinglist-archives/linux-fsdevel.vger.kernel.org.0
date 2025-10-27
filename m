Return-Path: <linux-fsdevel+bounces-65712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC72C0E27E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 14:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1019188619B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627232F6171;
	Mon, 27 Oct 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKWGj6CP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14823BCFD
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572861; cv=none; b=s097ADqWOWPDltEWJLkq1BQz1Y64lAePZTcJ5Vi6BKYiK6XSn+qaekcA/FZpCkM2VJtb0UQPi4CNo6+YfCtK2Ql87y7rfDXeaN+/H9kiinY23cUPSiiWsI9aHurPJZK8VKuSvm8SUo1a8IkNSEFsA4ajzvmcR4jZZS1NEdSWEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572861; c=relaxed/simple;
	bh=LOkZFXZ3ZELJ35KG0nvYUexkDEzKnAuOzNylQjxm22Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMgjesg9Wza7LbPSlIXKaiP81reLOURYjRyrwllN6RxgeOe1AwXMZbkJi4ByomGaj/f5tEC7eVbGPfaETGKQg5Q8ftJRe57devYrOeJGjKP46UeIy7qsvYcPQje3DfgqwaSbO3OrSWvJ5xS1po960T8rumpfGQNixb0NfAMyi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKWGj6CP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761572858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlMGVCW3NO++j4IeyaSGAHEC2AmkaTuwxwXk983vVMs=;
	b=aKWGj6CPMDtSdQ5yozd4wdnISjiuTkm9dpNY+PZ8v1fTCQDa/kfMAXKy1L91xurVBomd4R
	5saSJPwbgC1V6wmlhfTZbM1NzfSofpUDEoJeHF8LmChTrgnoEcpwuBdxTJ9JcWgMf/96EM
	JI3BUoDooHqjXoHptf41iiyI/znEIlQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-GHNye4dHP9-514ujb-r4-w-1; Mon,
 27 Oct 2025 09:47:35 -0400
X-MC-Unique: GHNye4dHP9-514ujb-r4-w-1
X-Mimecast-MFC-AGG-ID: GHNye4dHP9-514ujb-r4-w_1761572854
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79C8319539A3;
	Mon, 27 Oct 2025 13:47:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 592AD1955F01;
	Mon, 27 Oct 2025 13:47:32 +0000 (UTC)
Date: Mon, 27 Oct 2025 09:47:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: mgurtovoy@nvidia.com, izach@nvidia.com, smalin@nvidia.com,
	vgoyal@redhat.com, miklos@szeredi.hu, eperezma@redhat.com,
	mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, alok.a.tiwarilinux@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-fs: fix incorrect check for fsvq->kobj
Message-ID: <20251027134731.GA11774@fedora>
References: <20251027104658.1668537-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irdcpZZIdkIBl6wD"
Content-Disposition: inline
In-Reply-To: <20251027104658.1668537-1-alok.a.tiwari@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--irdcpZZIdkIBl6wD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 03:46:47AM -0700, Alok Tiwari wrote:
> In virtio_fs_add_queues_sysfs(), the code incorrectly checks fs->mqs_kobj
> after calling kobject_create_and_add(). Change the check to fsvq->kobj
> (fs->mqs_kobj -> fsvq->kobj) to ensure the per-queue kobject is
> successfully created.
>=20
> Fixes: 87cbdc396a31 ("virtio_fs: add sysfs entries for queue information")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--irdcpZZIdkIBl6wD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj/d/IACgkQnKSrs4Gr
c8g4VQgAqhNd1hjJGhM4ivPxRFday+L3RXLtrGjXhYmGDNNkN8OQX47mOjkUSJue
4bzETLFsBBzj1qXzmfLxCAv5W/6YmNArHk7Z1AuNWi30E3Jf15CNz0pdrba27qAE
9Ggmr/mI3Jo3vad4fnIN+jHgMDkPh2j+IKq700pdS7BZZZGsayc2uSje8zYyunXj
pAa0dpxtwaW/HmL4D1skL9q46GeupsN87xjkjnzolm2RwtzyljHMgxYrvFqB9DPG
//k2Hje8HUY8n9sXt2mQvxeayl1mbjJjfYb8eXsHxQwQb3JvuV82gDpa8jW465eT
xbmwVYW9XpQuE1O4RxuCnz4X+y2IRA==
=Og4O
-----END PGP SIGNATURE-----

--irdcpZZIdkIBl6wD--


