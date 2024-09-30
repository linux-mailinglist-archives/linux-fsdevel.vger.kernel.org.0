Return-Path: <linux-fsdevel+bounces-30415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7419798ADC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 22:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CBD281814
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3911A0B0F;
	Mon, 30 Sep 2024 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjCpkozf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C544131E2D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727015; cv=none; b=pMPgWmbFTS9+nFzc413i8VIetF5CN0nAgdZ2dHgzzLNNYImc/5Pn5pZOuEyDlroC8WO0CJrhVu9Pii2WDQDWO1EGvMXRKR0MIYMIR55MK/N4ZsiLcr0rPbKQrTMZXvVPlzQMqAiyplrjrEsOhUDuEeeMZBcxVVbFkuha2IdpWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727015; c=relaxed/simple;
	bh=zOQ6Hs0/cVGtqjjJFkZB7pBKk5JKlQcCKDTL+hZmyNU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=u6fveH7c9kJ8qd1Laxf3kBNmFebW7oknzx929W4e/fem5e4j8E/nRbXeTzdQBa+vqt/udaHOeBm14tU4PZ6qO1/Cc0+7RxLAfI5CSjJvkAV2Ilp7TuqIgK83XqN6zk/gWDXAz5o+CR5GM7vtpK8bHzcecBzyi7HaXxkqf0YMSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjCpkozf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPKn2Kv6qjDNm6/HF2s7vGlTGGGWG6HMQFjCEB8xiMU=;
	b=SjCpkozfsUprRiR7oFACup0lECgKstrhzn5HRRq91MhAwO5mkk2aAHem4G5S+jTQT4FFWk
	aBDZI8rK0B8OdqxJDnjSv+bT4Lb70g66O7pkONml7Zr4HrfVcq6Jt1MV27ZIfNGceWnWLV
	vEv3ZMSRB2i5Hgp2sIK8YCLSJg0vEq8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-5azF9J-mOqmL2byezmZePw-1; Mon,
 30 Sep 2024 16:10:07 -0400
X-MC-Unique: 5azF9J-mOqmL2byezmZePw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E4C719626EF;
	Mon, 30 Sep 2024 20:10:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 943993003E4D;
	Mon, 30 Sep 2024 20:10:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
References: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
To: Omar Sandoval <osandov@osandov.com>,
    Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com,
    v9fs@lists.linux.dev, Manu Bretelle <chantr4@gmail.com>,
    Eduard Zingerman <eddyz87@gmail.com>,
    Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3011075.1727727002.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 21:10:02 +0100
Message-ID: <3011076.1727727002@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Omar Sandoval <osandov@osandov.com> wrote:

> From: Omar Sandoval <osandov@fb.com>
> =

> iter_folioq_get_pages() decides to advance to the next folioq slot when
> it has reached the end of the current folio. However, it is checking
> offset, which is the beginning of the current part, instead of
> iov_offset, which is adjusted to the end of the current part, so it
> doesn't advance the slot when it's supposed to. As a result, on the next
> iteration, we'll use the same folio with an out-of-bounds offset and
> return an unrelated page.
> =

> This manifested as various crashes and other failures in 9pfs in drgn's
> VM testing setup and BPF CI.
> =

> Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to h=
andle a sequence of folios")
> Link: https://lore.kernel.org/linux-fsdevel/20240923183432.1876750-1-cha=
ntr4@gmail.com/
> Tested-by: Manu Bretelle <chantr4@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Thanks for finding that!  That would explain why I didn't see it with afs =
or
cifs - both of those pass the iterator directly to the socket rather than
pulling the pages out of it.  I'm not sure how I managed to do things like=
 run
xfstests to completion and git clone and build a kernel without encounteri=
ng
the bug.

Christian: Can you add this to vfs.fixes and tag it:

Acked-by: David Howells <dhowells@redhat.com>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>


