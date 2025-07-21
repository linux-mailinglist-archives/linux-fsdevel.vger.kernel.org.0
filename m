Return-Path: <linux-fsdevel+bounces-55600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CFB0C642
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51B53AF69D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468522DBF48;
	Mon, 21 Jul 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQPBnadA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88932DAFB4
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108025; cv=none; b=tyWmOPTB1Be8+FEL/fJ2xdL8hnnkoqRMtZfhdBIhct5dH79Hu9teMhr+fanpFL36SlCz46jp+OXeR5iXOxJSoZfLN1FexHULcHdD6HBQvA0qYsD2zAcRklY8NKG0DYI04FH+SeyQjremnYTacdf4VQy5d0RC6UIxk1xLe6CXE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108025; c=relaxed/simple;
	bh=efBq7vf1c8cQ0Qt9MyxkLjbSytZJeIINxUd2n7hz4NU=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=jk9Fp2hLLKrtIay1/j3/sS5Ip3No+odxNAh/2XLqMk73s8ryynGooKf6P0Fz5l4zOv0vRI9XxFOGW2SOaNPBgWxfQ54oM67i1sYo1MCzx2UjhgGKvUbDz99kqAkiq/4R++IE6DEaI8hS6QP4w+th979s71u0+5tUqTC/G+Bjlmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQPBnadA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753108022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iFMnKsvEYMHwCVd1R/SIsbNwtIiMnz2MuIXYFopFTFc=;
	b=PQPBnadAnadncrjXzXZ2FECX63SxO7CnUaY7qeuD89ltkSHu2cNDguzjfor1RK3j5tgOSD
	zZOFg7luM4ud3ehZ/lG3znrvUCi6/0JGiafRlbgLzuUSdQzVVO6h4tBbl7WmOnVT/irLLO
	XCtoaglZxAYRJ2JsBlcqQtzfVJkWaaA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-brfPhodPPQyDd3WyLKfRmg-1; Mon,
 21 Jul 2025 10:26:56 -0400
X-MC-Unique: brfPhodPPQyDd3WyLKfRmg-1
X-Mimecast-MFC-AGG-ID: brfPhodPPQyDd3WyLKfRmg_1753108015
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB764180048E;
	Mon, 21 Jul 2025 14:26:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E786A180049D;
	Mon, 21 Jul 2025 14:26:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com,
    syzbot+5c042fbab0b292c98fc6@syzkaller.appspotmail.com,
    Edward Adam Davis <eadavis@qq.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Set vllist to NULL if addr parsing fails
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4119364.1753108011.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Jul 2025 15:26:51 +0100
Message-ID: <4119365.1753108011@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Edward Adam Davis <eadavis@qq.com>

syzbot reported a bug in in afs_put_vlserverlist.

  kAFS: bad VL server IP address
  BUG: unable to handle page fault for address: fffffffffffffffa
  ...
  Oops: Oops: 0002 [#1] SMP KASAN PTI
  ...
  RIP: 0010:refcount_dec_and_test include/linux/refcount.h:450 [inline]
  RIP: 0010:afs_put_vlserverlist+0x3a/0x220 fs/afs/vl_list.c:67
  ...
  Call Trace:
   <TASK>
   afs_alloc_cell fs/afs/cell.c:218 [inline]
   afs_lookup_cell+0x12a5/0x1680 fs/afs/cell.c:264
   afs_cell_init+0x17a/0x380 fs/afs/cell.c:386
   afs_proc_rootcell_write+0x21f/0x290 fs/afs/proc.c:247
   proc_simple_write+0x114/0x1b0 fs/proc/generic.c:825
   pde_write fs/proc/inode.c:330 [inline]
   proc_reg_write+0x23d/0x330 fs/proc/inode.c:342
   vfs_write+0x25c/0x1180 fs/read_write.c:682
   ksys_write+0x12a/0x240 fs/read_write.c:736
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Because afs_parse_text_addrs() parses incorrectly, its return value -EINVA=
L
is assigned to vllist, which results in -EINVAL being used as the vllist
address when afs_put_vlserverlist() is executed.

Set the vllist value to NULL when a parsing error occurs to avoid this
issue.

Fixes: e2c2cb8ef07a ("afs: Simplify cell record handling")
Reported-by: syzbot+5c042fbab0b292c98fc6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D5c042fbab0b292c98fc6
Tested-by: syzbot+5c042fbab0b292c98fc6@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/cell.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 0168bbf53fe0..f31359922e98 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -177,6 +177,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net =
*net,
 					      VL_SERVICE, AFS_VL_PORT);
 		if (IS_ERR(vllist)) {
 			ret =3D PTR_ERR(vllist);
+			vllist =3D NULL;
 			goto parse_failed;
 		}
 =


