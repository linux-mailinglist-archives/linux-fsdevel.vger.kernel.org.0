Return-Path: <linux-fsdevel+bounces-49307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D47ABA5FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 00:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927C91BC7EED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5A280305;
	Fri, 16 May 2025 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCcH1Pmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6C280011
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747435094; cv=none; b=RxHd/otu/sh9gnu/vqJ+rWZ5zlKMNFi7hiJhd5ZhNpHZfBYG9pvkRBwpnvCSmePl2DHjSpXGUP6xKMwPc+haZ4ypuXZQvKkY0/QlxWI/YxVKZxd1QODSnSrP61d2XQgX81hO6DX1Xt/AeWyFZuH4KvPZTa1NSfvuMC7dCkv2zoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747435094; c=relaxed/simple;
	bh=pBTFc+3Zv98uZHsk2V1qM8sRTzR8wvQArvBZWqbUo5Y=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=D7RRu+Xx/YLtvmvJxt5EZIvkUU3LsudeB5LHCkExzomREEKHysUqlQ3coVueo1snAyqLRZZvNy1ADMHHcIN1crQfXL4XlGQWdvCVrIL5oz1y8CFAuESeiuV1Hrtj+RPgoK3zY7zuGlBXw+SaJv/cu+naiVZNNjk4Q1ry7VcBVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCcH1Pmg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747435089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knR8VDb1IumT6u7RrqbALTgfooWBtkP6TS/+WVFSTeQ=;
	b=TCcH1PmgwO2gLKcqjL/YudUBiqCS9BMTxeLnibQ65CrbFRqGczGB/r7dL1BYnnGeNdqnNE
	ebNHBxaHpSyQT9r/fk6tck89Y9Jv/P6NgT/imSOP/8DRkd/EyWOFvmFRLHO5b0v9qC88Fd
	uspVFuvNOg5qnoNXN5LTq3B61EAirKw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-K9yMwR7jPauK67Fxc3sMJw-1; Fri,
 16 May 2025 18:38:03 -0400
X-MC-Unique: K9yMwR7jPauK67Fxc3sMJw-1
X-Mimecast-MFC-AGG-ID: K9yMwR7jPauK67Fxc3sMJw_1747435082
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A61471800771;
	Fri, 16 May 2025 22:38:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EEBB195608D;
	Fri, 16 May 2025 22:38:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6824951b.a00a0220.104b28.000d.GAE@google.com>
References: <6824951b.a00a0220.104b28.000d.GAE@google.com>
To: syzbot <syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-out-of-bounds Read in iov_iter_revert
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2705413.1747435079.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 May 2025 23:37:59 +0100
Message-ID: <2705414.1747435079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t v6.15-rc6

commit 4f771b49180c404f518c686cdff749ff81f3cc77
Author: David Howells <dhowells@redhat.com>
Date:   Fri May 16 23:35:25 2025 +0100

    netfs: Fix oops in write-retry from mis-resetting the subreq iterator

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index f75e0e8c02cf..9d1d8a8bab72 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -39,9 +39,10 @@ static void netfs_retry_write_stream(struct netfs_io_re=
quest *wreq,
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				struct iov_iter source =3D subreq->io_iter;
+				struct iov_iter source;
 =

-				iov_iter_revert(&source, subreq->len - source.count);
+				netfs_reset_iter(subreq);
+				source =3D subreq->io_iter;
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 				netfs_reissue_write(stream, subreq, &source);
 			}


