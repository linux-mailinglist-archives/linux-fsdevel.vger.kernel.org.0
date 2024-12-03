Return-Path: <linux-fsdevel+bounces-36369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE899E2A03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB84B64B82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E231FA84A;
	Tue,  3 Dec 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOm5RBU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF71F9437
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244642; cv=none; b=llPLskD7vNNK7hLn5kC5S/nfl+/DWA2qnvuFMWwwicPrilbDv0fxUKzt+5HgtgONxBe8ghm2dwnMUoHbjmm6kzOPNJ8Cl9qdl6EWfWcP+EaVIdEkqjP+YHsmyhBeM0e0qxv0eh0xH7NI8iQQYyTr/lJQjO7ulK4BrgxOmtF07u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244642; c=relaxed/simple;
	bh=U/kZg6wRRAGFaUyq3MwugoqyLVhimU1xugPQde6x/+U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=TMoEPldQoP5CxVzJmsdIgv6Jf/HYgtR3+w7EiKSJlYoUKC9F4JDQcJaO8Mz/9c7U8SN/TvSRlsqsCICBcjbx9sefUU9SyVUV/famW2cT03iB0Nj/Z1BkJ4O9yuyN8O3AXMXiFBSlvbnKl59s3xO/60EYQ9OP80YzTaY+Hry3k6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOm5RBU3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733244639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/kZg6wRRAGFaUyq3MwugoqyLVhimU1xugPQde6x/+U=;
	b=KOm5RBU3R9xv+4NCbHnxg/GBPr0u4kA5bf6IdaaR7PcD/03pQya3a5AiYNScLrRKdAYClS
	5edh6T3sF6oIf7KKu1abZwiTEre4UqoKMQYkGlBz6gyMRJ+vfKF50V8//e0sghyMZ4/8me
	tJj+zgRqBzt9SYcZ5l6YlZExITPtLI4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-ZaPuXlSMM0KYIhsLt3rKvg-1; Tue,
 03 Dec 2024 11:50:36 -0500
X-MC-Unique: ZaPuXlSMM0KYIhsLt3rKvg-1
X-Mimecast-MFC-AGG-ID: ZaPuXlSMM0KYIhsLt3rKvg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0BF71944DDF;
	Tue,  3 Dec 2024 16:50:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA9A030000DF;
	Tue,  3 Dec 2024 16:50:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <674ded0b.050a0220.48a03.0027.GAE@google.com>
References: <674ded0b.050a0220.48a03.0027.GAE@google.com>
To: syzbot <syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, asmadeus@codewreck.org, bharathsm@microsoft.com,
    brauner@kernel.org, ericvh@kernel.org, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com,
    lucho@ionkov.net, marc.dionne@auristor.com,
    mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
    netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com,
    rostedt@goodmis.org, samba-technical@lists.samba.org,
    sfrench@samba.org, sprasad@microsoft.com,
    syzkaller-bugs@googlegroups.com, tom@talpey.com,
    v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] WARNING in netfs_retry_reads (2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <589148.1733244622.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Dec 2024 16:50:22 +0000
Message-ID: <589149.1733244622@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git netfs-writeback


