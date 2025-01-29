Return-Path: <linux-fsdevel+bounces-40290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A3A21E08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 14:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CDE3A1F84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722C13D531;
	Wed, 29 Jan 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQpz/mp1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775EC13D503
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158073; cv=none; b=Uhjox7V7yeqDGVa2lWWZTNAP0yhfkwYUmGcSX3GrSom/kcasMrGeytSzkxXO952e3ujI4S8ALYwYW/ifN+M1pLMbo6Bf/s+YhCOfUFABimwi8Pjq6HX5UVkY/3Zm3vMVyiFCot48msqbfxqy7GB1ZOQUY9lHRs9oATISFY7JHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158073; c=relaxed/simple;
	bh=Hmy2h/RQBJGsVFoqp33HXs1PGtScqlV+6GcL6hp15ZI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pn1yhjI6exfkFXPxZGa93ystZb1CkVmQqHXHLKSHjaFUtRMC2uYoqpXpk4bb8qTBthbnRdIdnbXGYdQM7JyqTSsIT0Io1dSSxGvauYBd/Z//PodY4puIeoylzHNOSwHyOtI7E02JJoiG3v9fgKO3sKRyHd6c/X70vOhTt6rlD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQpz/mp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738158070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEydovlz9452mAE+2oUUYU+VK4Hl0tPiC6+UK0BfnP0=;
	b=RQpz/mp1wxjnFuBXy3dEkHQ9fosXnFNLmjcndSIaMtKuR2k0iuu7nTNqPmLZGBz6+CgGpu
	SSjWXtTpxOtYOaSXVn4zPleyrbyF1uHvf61kFWisr2QV+f4qY4gMwxMWonQGu+6f+7nmjI
	n3DXLNhUNkePAJqktnPbkUQdPs99tvc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-LUe8S46yOjul1e-_vAhrfA-1; Wed,
 29 Jan 2025 08:41:08 -0500
X-MC-Unique: LUe8S46yOjul1e-_vAhrfA-1
X-Mimecast-MFC-AGG-ID: LUe8S46yOjul1e-_vAhrfA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D593C18009CD;
	Wed, 29 Jan 2025 13:41:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB2B519560A3;
	Wed, 29 Jan 2025 13:41:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <dbf086dc3113448cb4efaeee144ad01d39d83ea3.camel@ibm.com>
References: <dbf086dc3113448cb4efaeee144ad01d39d83ea3.camel@ibm.com> <d81a04646f76e0b65cd1e075ab3d410c4b9c3876.camel@ibm.com> <3469649.1738083455@warthog.procyon.org.uk> <3406497.1738080815@warthog.procyon.org.uk> <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com> <20250117035044.23309-1-slava@dubeyko.com> <988267.1737365634@warthog.procyon.org.uk> <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com> <3532744.1738094469@warthog.procyon.org.uk> <3541166.1738103654@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "idryomov@gmail.com" <idryomov@gmail.com>,
    Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3669135.1738158062.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jan 2025 13:41:02 +0000
Message-ID: <3669136.1738158062@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > Do you want me to push a branch with my tracepoints that I'm using som=
ewhere
> > that you can grab it?
> =

> Sounds good! Maybe it can help me. :)

Take a look at:

   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/

The "ceph-folio" branch has Willy's folio conversion patches plus a tracin=
g
patch plus a patch that's an unsuccessful attempt by me to fix the hang I =
was
seeing.

The tracepoint I'm using (netfs_folio) takes a folio pointer, so it was ea=
sier
to do it on top of Willy's patches.

The "netfs-crypto" branch are my patches to implement content crypto in
netfslib.  I've tested them to some extent with AFS, but the test code I h=
ave
in AFS only supports crypto of files where the file is an exact multiple o=
f
page size as AFS doesn't support any sort of xattr and so I can't store th=
e
real EOF pointer so simply.

The "ceph-iter" branch are my patches on top of a merge of those two
(excluding the debugging patches) to try and convert ceph to fully using
netfslib and to pass an iterator all the way down to the socket, aiming to
reduce the number of data types to basically two.

David


