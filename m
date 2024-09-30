Return-Path: <linux-fsdevel+bounces-30344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ECA98A147
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557041C2106F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9C18E04A;
	Mon, 30 Sep 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey6FQ4ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5218CBF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697566; cv=none; b=gvw/WHHNR926khmsEwT8lTwZgHWcnRbl0RUQ47pn3aIoiDQwFwFedI/nKyXfJlgYIobtWurkFSH5hTbywGpegQVe/g6vuc21jlrMY3/nLcFw1Xcnxst89SF5BmwFdfrA1NlJQKl8tR7LHcCg3779szYuLAMRsi6PX3CcQXPNHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697566; c=relaxed/simple;
	bh=aR8fuX0sS/gP3baIn1zrYghBAN/naNyugogMmnjaR9E=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=R5LqnTi8ycYqR7X29da8vuAPHfIRJPOSCD92pofifTAR54co9ObbvYmapEeouyqQzXKMWhCLZS6mZ2kCftVPXuXE4LxGkLTwH65bUylifYdfOlQY7uF7snz1L051L7qAKAzK+zsc+nW+TtwaRoprV9Zd9hYgevDbTcEHeFnJcmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey6FQ4ug; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727697563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p89utsEeZ8Hq5QclqXs3qm169w5HW3XznuekAkHcl9E=;
	b=ey6FQ4ugi305A+2m5NomzG9m9QVYTvb0J7ATp3397l4LJJr25ZSymwF7n4iK8zE2/+9Lt9
	px1ggJglEHbpOCNr6Sbj6I+MWmUAVtEj5JmJrTd1ltUFFBtSmPrmXVlDMLjc9gLbmk8Dgj
	WHFNDb9dFO0EcZBTvnvb/g3B+4QUIi8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-l80_EacyPOW-ZeIoWvgOkg-1; Mon,
 30 Sep 2024 07:59:20 -0400
X-MC-Unique: l80_EacyPOW-ZeIoWvgOkg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71FE41953941;
	Mon, 30 Sep 2024 11:59:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E97881955DC7;
	Mon, 30 Sep 2024 11:59:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix the netfs_folio tracepoint to handle NULL mapping
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2917422.1727697556.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 12:59:16 +0100
Message-ID: <2917423.1727697556@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix the netfs_folio tracepoint to handle folios that have a NULL mapping
pointer.  In such a case, just substitute a zero inode number.

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for bu=
ffered write")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/trace/events/netfs.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 76bd42a96815..1d7c52821e55 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -448,7 +448,8 @@ TRACE_EVENT(netfs_folio,
 			     ),
 =

 	    TP_fast_assign(
-		    __entry->ino =3D folio->mapping->host->i_ino;
+		    struct address_space *__m =3D READ_ONCE(folio->mapping);
+		    __entry->ino =3D __m ? __m->host->i_ino : 0;
 		    __entry->why =3D why;
 		    __entry->index =3D folio_index(folio);
 		    __entry->nr =3D folio_nr_pages(folio);


