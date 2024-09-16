Return-Path: <linux-fsdevel+bounces-29470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ED197A318
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6F428640E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACDC15748A;
	Mon, 16 Sep 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdskVsLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76A156257
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494626; cv=none; b=JVJoas+XuZI57ODVLrn0uJ12CBZJJl3lBA4+TYvQBUxDPBpLuKMFxowBFKMjLuPbTEnVCXjqK/TH/Bj1TjmXCR5/BIUfhemS01cITe4jeX9X1ZEnNX7q5y1bKSpyCY2W/XlxdDgaT70pdNxz4eQWGs4wPvyFBq/FmzYXDMfMcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494626; c=relaxed/simple;
	bh=3G6nNUn1bMKAqYxa+NGBPYz7gridnax2Iqq1Mfv1v34=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OF6tFN//ZHDdClR0PJs9mIS8/17PUwT+KXHhJ5zxkdbfPV+uKbH/3uTSC31LZsizmizr0urCcp/4lqpsnom9jzuiL2eiOVrEysJ8NWo/EoRowh+hqZCnl5Gxf4YUMgK/Xsajj9sIsRftd8HZQf4Nxgd2G9BZSr21YANgkdM/yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdskVsLc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726494623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bceaz3QXs0DKbabxrfpiWtFXiUoEB+2UhAh7kLlHFog=;
	b=DdskVsLcknLX1eelCFH+S1Erbd0Zi/DB5aC/8gzaDXYg+AtBBvnOLhWnlVSQCoD4TT1ed/
	8SVg9eTilSKTERxKe7kvLw68VntUj0lAOKHtXSPWdPMLgw6eaOuj5n4jKpMHt2dmyeGtBv
	jkjDR2/XOvKlm4SrPlrGJ7l42IcDeAU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-ok2uxF2SM2Kr6B62Z9z6NQ-1; Mon,
 16 Sep 2024 09:50:20 -0400
X-MC-Unique: ok2uxF2SM2Kr6B62Z9z6NQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55BF91955E9F;
	Mon, 16 Sep 2024 13:50:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E1021956086;
	Mon, 16 Sep 2024 13:50:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
References: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com> <20240913-vfs-netfs-39ef6f974061@brauner>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Steve French <stfrench@microsoft.com>
Subject: [PATCH] cifs: Fix cifs readv callback merge resolution issue
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1947792.1726494616.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Sep 2024 14:50:16 +0100
Message-ID: <1947793.1726494616@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fix an upstream merge resolution issue[1].  Prior to the netfs read
healpers, the SMB1 asynchronous read callback, cifs_readv_worker()
performed the cleanup for the operation in the network message processing
loop, potentially slowing down the processing of incoming SMB messages.

With commit a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the sam=
e
way as SMB2/3"), this was moved to a worker thread (as is done in the
SMB2/3 transport variant).  However, the "was_async" argument to
netfs_subreq_terminated (which was originally incorrectly "false" got
flipped to "true" - which was then incorrect because, being in a kernel
thread, it's not in an async context).

This got corrected in the sample merge[2], but Linus, not unreasonably,
switched it back to its previous value.

Note that this value tells netfslib whether or not it can run sleepable
stuff or stuff that takes a long time, such as retries and cleanups, in th=
e
calling thread, or whether it should offload to a worker thread.

Fix this so that it is "false".  The callback to netfslib in both SMB1 and
SMB2/3 now gets offloaded from the network message thread to a separate
worker thread and thus it's fine to do the slow work in this thread.

Fixes: 35219bc5c71f ("Merge tag 'vfs-6.12.netfs' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/vfs/vfs")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/CAHk-=3Dwjr8fxk20-wx=3D63mZruW1LTvBvAKya1G=
Q1EhyzXb-okMA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/linux-fsdevel/20240913-vfs-netfs-39ef6f97406=
1@brauner/ [2]
---
 fs/smb/client/cifssmb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d81da161d3ed..7f3b37120a21 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1266,7 +1266,7 @@ static void cifs_readv_worker(struct work_struct *wo=
rk)
 	struct cifs_io_subrequest *rdata =3D
 		container_of(work, struct cifs_io_subrequest, subreq.work);
 =

-	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, true);
+	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
 }
 =

 static void


