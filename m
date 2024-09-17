Return-Path: <linux-fsdevel+bounces-29561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9DB97AC76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EEA28D637
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884D15383A;
	Tue, 17 Sep 2024 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5kjjArb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBD153808
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559680; cv=none; b=bgy0mIo5SvapvX05wB03EF25S/DNCj1eEwbOX9GMKzvEs+fsG6P9b4fn4TTpXZ8mVjDM2WiK3K0mVssjgNOUwa7zyDjIbH0cR6q6Pj9NmmNijcgZ4xzf1KI0wL9lTGI25GzCZCwRj1InpDPayWZOWVqAlTWN5/ZiG6SWT5sN7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559680; c=relaxed/simple;
	bh=lhFZXlll59tKQPd51vvfW24mGo4UK5xcEDeJAGNp2xM=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=r39GmPgEXCDRxQUOtmxrgSn6fSby0VYRkY7WxSx3E36ZXclUm/me8RQ5r+3+2iAd4n5mQfYMzZfEFaIsSrEHfn0/1beGbzzCDPuL8NFmN+HoDohCkOqih9u+KwTwPSuzACrAVUQ0uQAeFsw0btQCP1In5PYJDywKfrxrjmiI+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5kjjArb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726559677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5b27nr/SPZQcntuLJn+/QlhMwOaGHH4g8fVeuv0vl08=;
	b=g5kjjArb5+uwSIyJaDUB7QjaX6FDyIf8hx/w/jLB7fpcJwarJ9iMpTkLqNLpAnmucBoINk
	6mqYGmVG+e0vqWcIxHBxIPwSStHZPPkwUn1wUYxakKT1rpp4tXE6vI4t1wQdauc/TIYclQ
	WA9XdrkcDOMc4ZYlpqiDA+YmNiE0Pgw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-q1suRQZIOkqY5JEvP-PdiQ-1; Tue,
 17 Sep 2024 03:54:34 -0400
X-MC-Unique: q1suRQZIOkqY5JEvP-PdiQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7BA61955EB2;
	Tue, 17 Sep 2024 07:54:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85D5F1956088;
	Tue, 17 Sep 2024 07:54:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>,
    Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, kernel test robot <oliver.sang@intel.com>,
    Jeff Layton <jlayton@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs, cifs: Fix mtime/ctime update for mmapped writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2106016.1726559668.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Sep 2024 08:54:28 +0100
Message-ID: <2106017.1726559668@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime and
ctime need to be written back on close, got taken over by netfs as
NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer to
set it.

The flag gets set correctly on buffered writes, but doesn't get set by
netfs_page_mkwrite(), leading to occasional failures in generic/080 and
generic/215.

Fix this by setting the flag in netfs_page_mkwrite().

Fixes: 73425800ac94 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_in=
ode")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang@in=
tel.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index d7eae597e54d..b3910dfcb56d 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -552,6 +552,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, st=
ruct netfs_group *netfs_gr
 		trace_netfs_folio(folio, netfs_folio_trace_mkwrite);
 	netfs_set_group(folio, netfs_group);
 	file_update_time(file);
+	set_bit(NETFS_ICTX_MODIFIED_ATTR, &ictx->flags);
 	if (ictx->ops->post_modify)
 		ictx->ops->post_modify(inode);
 	ret =3D VM_FAULT_LOCKED;


