Return-Path: <linux-fsdevel+bounces-2627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF8C7E71EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 20:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB71C20908
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5A321A4;
	Thu,  9 Nov 2023 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJr0LV32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF4200DD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 19:08:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB53C13
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699556930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uLRQJON7Ac90EDnJlEoBuTyXHqH7isfPCOz8x1WkVk0=;
	b=VJr0LV32iB+BB95eage5MHb2dyl37+IL2/yu6j/9KDBrLa6b5FjVPQ9uAMDRQe66vsd9MA
	A5S9zIKc9nV3JvAKLNwRh3SRR7/IYef2CrzU0a9vpuNc7FX0w6Cp/BRjd79+loEFBNPlZD
	5qb/kBTyT8ZC5H3EHiPXiKV2J9lXWw8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-rEHXra9eOGScqRP2kSZytg-1; Thu,
 09 Nov 2023 14:08:47 -0500
X-MC-Unique: rEHXra9eOGScqRP2kSZytg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6E092815E24;
	Thu,  9 Nov 2023 19:08:46 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A66BE492BE7;
	Thu,  9 Nov 2023 19:08:45 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Abhi Das <adas@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: RESOLVE_CACHED final path component fix
Date: Thu,  9 Nov 2023 20:08:44 +0100
Message-ID: <20231109190844.2044940-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Jens,=0D
=0D
since your commit 99668f618062, applications can request cached lookups=0D
with the RESOLVE_CACHED openat2() flag.  When adding support for that in=0D
gfs2, we found that this causes the ->permission inode operation to be=0D
called with the MAY_NOT_BLOCK flag set for directories along the path,=0D
which is good, but the ->permission check on the final path component is=0D
missing that flag.  The filesystem will then sleep when it needs to read=0D
in the ACL, for example.=0D
=0D
This doesn't look like the intended RESOLVE_CACHED behavior.=0D
=0D
The file permission checks in path_openat() happen as follows:=0D
=0D
(1) link_path_walk() -> may_lookup() -> inode_permission() is called for=0D
each but the final path component. If the LOOKUP_RCU nameidata flag is=0D
set, may_lookup() passes the MAY_NOT_BLOCK flag on to=0D
inode_permission(), which passes it on to the permission inode=0D
operation.=0D
=0D
(2) do_open() -> may_open() -> inode_permission() is called for the=0D
final path component. The MAY_* flags passed to inode_permission() are=0D
computed by build_open_flags(), outside of do_open(), and passed down=0D
from there. The MAY_NOT_BLOCK flag doesn't get set.=0D
=0D
I think we can fix this in build_open_flags(), by setting the=0D
MAY_NOT_BLOCK flag when a RESOLVE_CACHED lookup is requested, right=0D
where RESOLVE_CACHED is mapped to LOOKUP_CACHED as well.=0D
=0D
Fixes: 99668f618062 ("fs: expose LOOKUP_CACHED through openat2() RESOLVE_CA=
CHED")=0D
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>=0D
=0D
diff --git a/fs/open.c b/fs/open.c=0D
index 98f6601fbac6..61311c9845bd 100644=0D
--- a/fs/open.c=0D
+++ b/fs/open.c=0D
@@ -1340,6 +1340,7 @@ inline int build_open_flags(const struct open_how *ho=
w, struct open_flags *op)=0D
 		if (flags & (O_TRUNC | O_CREAT | __O_TMPFILE))=0D
 			return -EAGAIN;=0D
 		lookup_flags |=3D LOOKUP_CACHED;=0D
+		op->acc_mode |=3D MAY_NOT_BLOCK;=0D
 	}=0D
 =0D
 	op->lookup_flags =3D lookup_flags;=0D


