Return-Path: <linux-fsdevel+bounces-32646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6999AC764
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A755283AF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 10:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579419F42C;
	Wed, 23 Oct 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctM1Qwb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D219E802
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678040; cv=none; b=WcGlJ8+2VgEi9rw0P5gSXu0n7vmFlhaIewZi9QCvokAFtmoSFITHWPyhjTSHNgTmOVVSPkdPxR4BOeqswwMPhqe7Oeoj4XSBuPv6GDhY+z/tpxVJciuPRopKLW0YGYGPcPpmWKKbwoKSUWjkir6DotorACd4sb0AWmEQpyTfle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678040; c=relaxed/simple;
	bh=dIqW7VR7PmEya3kIt5lSd5sawvrvBRm6Jrdnx5D+U1A=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CLdS8ST8I74tCCKumHcbWO2IP9IcqrTI6iqrLS3/cwJgCK/IOhyHeF76zKSlu18g5O4vas26W+EvLYoQTLPwEFtv+W0AcZs+GExVO6ND9myvkAH6B/3t1uzXNjlBJgWCEZcKIQUgL9tHJWDMpbMi1FeCTvt+gzSCF8DBtn2JqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctM1Qwb6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729678037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/WtSaKWH3FTu6tLjpEhrwPjxJr0g/mj3hklyiYjcAM=;
	b=ctM1Qwb6EqMUpyJ4n3baFIytZvmtyZc5nr2mmg/1WpW6/i2Dx/STG6kcHhBDEyHy/KmPr4
	23JZRyy+FBttbUAqhN7w0RL9r8mm//yJNzxaqn5Y/RAfXADuMTecyPQz4+daGn1QZZucCU
	SmskPODEKAE99D333YOZ7/jnRUXk6G0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-vp2PjErsNRCKjXgydoBt0Q-1; Wed,
 23 Oct 2024 06:07:14 -0400
X-MC-Unique: vp2PjErsNRCKjXgydoBt0Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AEF31955F42;
	Wed, 23 Oct 2024 10:07:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D179A1956056;
	Wed, 23 Oct 2024 10:07:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZxFQw4OI9rrc7UYc@Antony2201.local>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local> <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me> <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info> <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me> <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
To: Antony Antony <antony@phenome.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Sedat Dilek <sedat.dilek@gmail.com>,
    Maximilian Bosch <maximilian@mbosch.me>, regressions@lists.linux.dev,
    v9fs@lists.linux.dev, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3327437.1729678025.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Oct 2024 11:07:05 +0100
Message-ID: <3327438.1729678025@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Antony,

I think the attached should fix it properly rather than working around it =
as
the previous patch did.  If you could give it a whirl?

Thanks,
David
---
commit 68dddbfdf45e8f176cc8556a3db69af24dfb8519
Author: David Howells <dhowells@redhat.com>
Date:   Wed Oct 23 10:24:12 2024 +0100

    iov_iter: Fix iov_iter_get_pages*() for folio_queue
    =

    p9_get_mapped_pages() uses iov_iter_get_pages_alloc2() to extract page=
s
    from an iterator when performing a zero-copy request and under some
    circumstances, this crashes with odd page errors[1], for example, I se=
e:
    =

        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn=
:0xbcf0
        flags: 0x2000000000000000(zone=3D1)
        ...
        page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_cou=
nt(folio) + 127u <=3D 127u))
        ------------[ cut here ]------------
        kernel BUG at include/linux/mm.h:1444!
    =

    This is because, unlike in iov_iter_extract_folioq_pages(), the
    iter_folioq_get_pages() helper function doesn't skip the current folio=
 when
    iov_offset points to the end of it, but rather extracts the next page
    beyond the end of the folio and adds it to the list.  Reading will the=
n
    clobber the contents of this page, leading to system corruption, and i=
f the
    page is not in use, put_page() may try to clean up the unused page.
    =

    This can be worked around by copying the iterator before each extracti=
on[2]
    and using iov_iter_advance() on the original as the advance function s=
teps
    over the page we're at the end of.
    =

    Fix this by skipping the page extraction if we're at the end of the fo=
lio.
    =

    This was reproduced in the ktest environment[3] by forcing 9p to use t=
he
    fscache caching mode and then reading a file through 9p.
    =

    Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to=
 handle a sequence of folios")
    Reported-by: Antony Antony <antony@phenome.org>
    Closes: https://lore.kernel.org/r/ZxFQw4OI9rrc7UYc@Antony2201.local/
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Eric Van Hensbergen <ericvh@kernel.org>
    cc: Latchesar Ionkov <lucho@ionkov.net>
    cc: Dominique Martinet <asmadeus@codewreck.org>
    cc: Christian Schoenebeck <linux_oss@crudebyte.com>
    cc: v9fs@lists.linux.dev
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org
    Link: https://lore.kernel.org/r/ZxFEi1Tod43pD6JC@moon.secunet.de/ [1]
    Link: https://lore.kernel.org/r/2299159.1729543103@warthog.procyon.org=
.uk/ [2]
    Link: https://github.com/koverstreet/ktest.git [3]

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1abb32c0da50..cc4b5541eef8 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1021,15 +1021,18 @@ static ssize_t iter_folioq_get_pages(struct iov_it=
er *iter,
 		size_t offset =3D iov_offset, fsize =3D folioq_folio_size(folioq, slot)=
;
 		size_t part =3D PAGE_SIZE - offset % PAGE_SIZE;
 =

-		part =3D umin(part, umin(maxsize - extracted, fsize - offset));
-		count -=3D part;
-		iov_offset +=3D part;
-		extracted +=3D part;
-
-		*pages =3D folio_page(folio, offset / PAGE_SIZE);
-		get_page(*pages);
-		pages++;
-		maxpages--;
+		if (offset < fsize) {
+			part =3D umin(part, umin(maxsize - extracted, fsize - offset));
+			count -=3D part;
+			iov_offset +=3D part;
+			extracted +=3D part;
+
+			*pages =3D folio_page(folio, offset / PAGE_SIZE);
+			get_page(*pages);
+			pages++;
+			maxpages--;
+		}
+
 		if (maxpages =3D=3D 0 || extracted >=3D maxsize)
 			break;
 =


