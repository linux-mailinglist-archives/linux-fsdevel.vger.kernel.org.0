Return-Path: <linux-fsdevel+bounces-29595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6B97B38C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 19:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391551F24B8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BB186613;
	Tue, 17 Sep 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbYWNzHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CB7A13A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726594268; cv=none; b=lnzBDH1ICC0xydwbPnOVe9OFQ63yQSVvlYJ7XAE1oUs+YQbt2PAscUIUZg7CwjLuhyV3GDz/YMB+HXgc0FCsv9m7yUh9I2zwxWdkrvHOSPWstVDayje0dQEDAbiiDObNOFZQXp/nZjfeOXcisRCzB28VjUSk/yTpcZvxPyHU9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726594268; c=relaxed/simple;
	bh=tGYWR8/WN0m/AzKpQT7y+opcbunbNdg82+K/XE3Uq8M=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=lifC6mS7aAex+/RUQm043Z1Tsypc8Aj48HDxaUwrLH4lFCPOCvKUOrokoLGLaKY4VZav2UCKHeRKTRGGakL3zAvZ4APGnu9mAddlyPoZz2ZJCZXmrVCLk5dAYi/OYGxZtgtCM24qYnSdOcOabsx+qHE84uKDSufsJWB3DhlOmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbYWNzHW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726594264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+Q1TBMKNjej+bpAWrl6GV0oWbucsyD8OkToLXYmdYQ=;
	b=SbYWNzHWFQ0O64B0SdHA2FgCSlABB+FzKyqlmM+RqZLtT5a9uB18buMSaNazS76htc1SFr
	txWhO2e2QJTPhBB22Uz8ZpPowleqr8nIrI4S18GgnomU5cymM/8dXuSfnbIA390sLIJvlu
	OwpyOFGfrDl6X/1lfq5KUOOnLgyKtCk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-FysxpM_vNkG8aBj0T1ezlA-1; Tue,
 17 Sep 2024 13:31:00 -0400
X-MC-Unique: FysxpM_vNkG8aBj0T1ezlA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB83E1944AA8;
	Tue, 17 Sep 2024 17:30:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0B4C1956086;
	Tue, 17 Sep 2024 17:30:55 +0000 (UTC)
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
Subject: [PATCH] cifs: Fix reversion of the iter in cifs_readv_receive().
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2280666.1726594254.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Sep 2024 18:30:54 +0100
Message-ID: <2280667.1726594254@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

cifs_read_iter_from_socket() copies the iterator that's passed in for the
socket to modify as and if it will, and then advances the original iterato=
r
by the amount sent.  However, both callers revert the advancement (althoug=
h
receive_encrypted_read() zeros beyond the iterator first).  The problem is=
,
though, that cifs_readv_receive() reverts by the original length, not the
amount transmitted which can cause an oops in iov_iter_revert().

Fix this by:

 (1) Remove the iov_iter_advance() from cifs_read_iter_from_socket().

 (2) Remove the iov_iter_revert() from both callers.  This fixes the bug i=
n
     cifs_readv_receive().

 (3) In receive_encrypted_read(), if we didn't get back as much data as th=
e
     buffer will hold, copy the iterator, advance the copy and use the cop=
y
     to drive iov_iter_zero().

As a bonus, this gets rid of some unnecessary processing.

This was triggered by generic/074 with the "-o sign" mount option.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/connect.c   |    6 +-----
 fs/smb/client/smb2ops.c   |    9 ++++++---
 fs/smb/client/transport.c |    3 ---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 5375b0c1dfb9..06c16b0ce3e8 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -811,13 +811,9 @@ cifs_read_iter_from_socket(struct TCP_Server_Info *se=
rver, struct iov_iter *iter
 			   unsigned int to_read)
 {
 	struct msghdr smb_msg =3D { .msg_iter =3D *iter };
-	int ret;
 =

 	iov_iter_truncate(&smb_msg.msg_iter, to_read);
-	ret =3D cifs_readv_from_socket(server, &smb_msg);
-	if (ret > 0)
-		iov_iter_advance(iter, ret);
-	return ret;
+	return cifs_readv_from_socket(server, &smb_msg);
 }
 =

 static bool
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 159a063de6dd..5550d5237b22 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4869,9 +4869,12 @@ receive_encrypted_read(struct TCP_Server_Info *serv=
er, struct mid_q_entry **mid,
 		goto discard_data;
 =

 	server->total_read +=3D rc;
-	if (rc < len)
-		iov_iter_zero(len - rc, &iter);
-	iov_iter_revert(&iter, len);
+	if (rc < len) {
+		struct iov_iter tmp =3D iter;
+
+		iov_iter_advance(&tmp, rc);
+		iov_iter_zero(len - rc, &tmp);
+	}
 	iov_iter_truncate(&iter, dw->len);
 =

 	rc =3D cifs_discard_remaining_data(server);
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 6e68aaf5bd20..abf966f6ff0a 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1813,11 +1813,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, =
struct mid_q_entry *mid)
 		length =3D data_len; /* An RDMA read is already done. */
 	else
 #endif
-	{
 		length =3D cifs_read_iter_from_socket(server, &rdata->subreq.io_iter,
 						    data_len);
-		iov_iter_revert(&rdata->subreq.io_iter, data_len);
-	}
 	if (length > 0)
 		rdata->got_bytes +=3D length;
 	server->total_read +=3D length;


