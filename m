Return-Path: <linux-fsdevel+bounces-79681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCquN0XTq2mshAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 08:27:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7E22A99B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 08:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2E89302A18B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9421CB640;
	Sat,  7 Mar 2026 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg2DwvaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5425368972
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868413; cv=none; b=hLK2Q/9i/f6viaLdz459jFkdBh/4xZ0IKsd4ZTArauT+oiM62iR8n7HssBJ+pgO+Q75OK6eVyfuQ8/o1c6Sra3AfLyBloWenWZoAGhbn8yiXh5uVulWhybd/N4Nru3pLVIn8x54JvIEb5TqqIPCbryREqU+FhPr9krtmLIZ6Dl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868413; c=relaxed/simple;
	bh=CZBo56vAiijt9ljba/FRXjd848V8Psje8zj7FhMYElQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=qF5FMsm8yIm/dbY1q3cU3mc3Cz0Mt+WZSU8C/loppjGTh6ZGnUh0VrHrAHtcZr7HoSXUIQ2fabFVtrWa+Cc8G0f/etDgxgvTzdtn4ThEPVhzvtEYX2Ayyb8O25+C6ptO3JkPW5ww32WsfCRkzha2jYLWH1PK5fBtMUtYc8z8bOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xg2DwvaD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772868409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEsPSV+2TI7csiZYbt7+qSwIqSMdwZHkJYhnl4qV0Xk=;
	b=Xg2DwvaDHHx6YmlnwVqCwDhdcs8k58eL13Q3CCCrA1Sm+CG1dTr3I2J1Cz/YCY+rHgfVGd
	ngbqtW4D1FKOv3MlRCchPZnqZwdYy9KA0qBpjycaA/cxRI/3dTFC+Q24U47KtkN9gjKQvT
	jJMYeWkBZyIP4NagKkS+XiYFEahrhWg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-sDRjS14VPmiAvSRWfsjoUg-1; Sat,
 07 Mar 2026 02:26:46 -0500
X-MC-Unique: sDRjS14VPmiAvSRWfsjoUg-1
X-Mimecast-MFC-AGG-ID: sDRjS14VPmiAvSRWfsjoUg_1772868404
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80A411956089;
	Sat,  7 Mar 2026 07:26:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBA313003E9F;
	Sat,  7 Mar 2026 07:26:41 +0000 (UTC)
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
Content-ID: <675768.1772868400.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Mar 2026 07:26:40 +0000
Message-ID: <675769.1772868400@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 64E7E22A99B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,manguebit.org,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-79681-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,warthog.procyon.org.uk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

commit eb8299de8f603a6d7acf50e534c87ac1adeb3060
Author: Deepanshu Kartikey <kartikey406@gmail.com>
Date:   Sat Mar 7 10:09:47 2026 +0530

    netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on ret=
ry
    =

    When a write subrequest is marked NETFS_SREQ_NEED_RETRY, the retry pat=
h
    in netfs_unbuffered_write() unconditionally calls stream->prepare_writ=
e()
    without checking if it is NULL.
    =

    Filesystems such as 9P do not set the prepare_write operation, so
    stream->prepare_write remains NULL. When get_user_pages() fails with
    -EFAULT and the subrequest is flagged for retry, this results in a NUL=
L
    pointer dereference at fs/netfs/direct_write.c:189.
    =

    Fix this by mirroring the pattern already used in write_retry.c: if
    stream->prepare_write is NULL, skip renegotiation and directly reissue
    the subrequest via netfs_reissue_write(), which handles iterator reset=
,
    IN_PROGRESS flag, stats update and reissue internally.
    =

    Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch sub=
requests in strict sequence")
    Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3D7227db0fbac9f348dba0
    Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index dd1451bf7543..4d9760e36c11 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -186,10 +186,18 @@ static int netfs_unbuffered_write(struct netfs_io_re=
quest *wreq)
 		stream->sreq_max_segs	=3D INT_MAX;
 =

 		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-		stream->prepare_write(subreq);
 =

-		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-		netfs_stat(&netfs_n_wh_retry_write_subreq);
+		if (stream->prepare_write) {
+			stream->prepare_write(subreq);
+			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+			netfs_stat(&netfs_n_wh_retry_write_subreq);
+		} else {
+			struct iov_iter source;
+
+			netfs_reset_iter(subreq);
+			source =3D subreq->io_iter;
+			netfs_reissue_write(stream, subreq, &source);
+		}
 	}
 =

 	netfs_unbuffered_write_done(wreq);


