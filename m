Return-Path: <linux-fsdevel+bounces-79693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jDOYNVstrGmWmQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 14:51:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CBD22BFF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 14:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38A630210D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191082C21F1;
	Sat,  7 Mar 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzMEb7ph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAA3C2D
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772891478; cv=none; b=mQEHyebXz3Lt6ePJ+5kdjvVjTGzNlHJuLX1a083EW1pxMQw8ci1A4F1Y1Qz2jUo+Fj49ltYjCVB5nwWgU8QYOtqYBn7yRl/t3ngvUVMlf4XM835Wkkyq8aB2HafKIw0zuJsYu1yDGMYXQz/MKNTXnXWgeWLxvgoAY//+xR8mOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772891478; c=relaxed/simple;
	bh=VDtAP38eE/ShvdCu0BYJjNFnPSUBgHpooofOb/XkaoU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uvre/Dv+Gqab2etZPs0uKQyeD9JZ1JUsrskpb6reCDmmri2ilt6VMC4dJ9DaDmOpgNAc9V5wumQj5TpYvQvWh2hOyjoCJDx0ODQrPFMmAH0eTAdndbKl8Sa3jQwhpR4OaKP/VWz+gPSFTxlFDFhYhb+PH7LcqjEqnm8rpGg8UK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzMEb7ph; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772891476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZI6Lv2BreqiXgT/1Mtn9quglFf5aioVNGn4Hs7IrZM=;
	b=OzMEb7phgCZJykBwNZHHSR55mZy+iNu6A4t0MVvMnL+YtmxRHt4iVtBo6XP/eOqiuIAXkr
	6M5pXtZRDU1DL6sv5OuS4opSoCqUohJ9Ak9AwsYb4mG61raMUhC7nMP47iy8no5L+dffmS
	XqNYEqNoqg7hmixedx+EX/+p9EvBAmM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-umFDJX_VMk2IyFMRY3ayaQ-1; Sat,
 07 Mar 2026 08:51:14 -0500
X-MC-Unique: umFDJX_VMk2IyFMRY3ayaQ-1
X-Mimecast-MFC-AGG-ID: umFDJX_VMk2IyFMRY3ayaQ_1772891473
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2090119560B2;
	Sat,  7 Mar 2026 13:51:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8410E1956095;
	Sat,  7 Mar 2026 13:51:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <69aa75e2.050a0220.13f275.000f.GAE@google.com>
References: <69aa75e2.050a0220.13f275.000f.GAE@google.com>
To: syzbot <syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, Deepanshu Kartikey <kartikey406@gmail.com>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, pc@manguebit.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in netfs_limit_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <683929.1772891469.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Mar 2026 13:51:09 +0000
Message-ID: <683930.1772891469@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 27CBD22BFF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,manguebit.org,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-79693-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,9c058f0d63475adc97fd];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t c107785c7e8d

commit c4449647436e654c150cf5fdb70a64a9d02283a1
Author: Deepanshu Kartikey <kartikey406@gmail.com>
Date:   Sat Mar 7 14:30:41 2026 +0530

    netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
    =

    When a process crashes and the kernel writes a core dump to a 9P
    filesystem, __kernel_write() creates an ITER_KVEC iterator. This
    iterator reaches netfs_limit_iter() via netfs_unbuffered_write(), whic=
h
    only handles ITER_FOLIOQ, ITER_BVEC and ITER_XARRAY iterator types,
    hitting the BUG() for any other type.
    =

    Fix this by adding netfs_limit_kvec() following the same pattern as
    netfs_limit_bvec(), since both kvec and bvec are simple segment arrays
    with pointer and length fields. Dispatch it from netfs_limit_iter() wh=
en
    the iterator type is ITER_KVEC.
    =

    Fixes: cae932d3aee5 ("netfs: Add func to calculate pagecount/size-limi=
ted span of an iterator")
    Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3D9c058f0d63475adc97fd
    Tested-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
    Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 72a435e5fc6d..154a14bb2d7f 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -142,6 +142,47 @@ static size_t netfs_limit_bvec(const struct iov_iter =
*iter, size_t start_offset,
 	return min(span, max_size);
 }
 =

+/*
+ * Select the span of a kvec iterator we're going to use.  Limit it by bo=
th
+ * maximum size and maximum number of segments.  Returns the size of the =
span
+ * in bytes.
+ */
+static size_t netfs_limit_kvec(const struct iov_iter *iter, size_t start_=
offset,
+			       size_t max_size, size_t max_segs)
+{
+	const struct kvec *kvecs =3D iter->kvec;
+	unsigned int nkv =3D iter->nr_segs, ix =3D 0, nsegs =3D 0;
+	size_t len, span =3D 0, n =3D iter->count;
+	size_t skip =3D iter->iov_offset + start_offset;
+
+	if (WARN_ON(!iov_iter_is_kvec(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n =3D=3D 0)
+		return 0;
+
+	while (n && ix < nkv && skip) {
+		len =3D kvecs[ix].iov_len;
+		if (skip < len)
+			break;
+		skip -=3D len;
+		n -=3D len;
+		ix++;
+	}
+
+	while (n && ix < nkv) {
+		len =3D min3(n, kvecs[ix].iov_len - skip, max_size);
+		span +=3D len;
+		nsegs++;
+		ix++;
+		if (span >=3D max_size || nsegs >=3D max_segs)
+			break;
+		skip =3D 0;
+		n -=3D len;
+	}
+
+	return min(span, max_size);
+}
+
 /*
  * Select the span of an xarray iterator we're going to use.  Limit it by=
 both
  * maximum size and maximum number of segments.  It is assumed that segme=
nts
@@ -245,6 +286,8 @@ size_t netfs_limit_iter(const struct iov_iter *iter, s=
ize_t start_offset,
 		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
 	if (iov_iter_is_xarray(iter))
 		return netfs_limit_xarray(iter, start_offset, max_size, max_segs);
+	if (iov_iter_is_kvec(iter))
+		return netfs_limit_kvec(iter, start_offset, max_size, max_segs);
 	BUG();
 }
 EXPORT_SYMBOL(netfs_limit_iter);


