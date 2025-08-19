Return-Path: <linux-fsdevel+bounces-58319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15948B2C874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821185641C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53FA2868AD;
	Tue, 19 Aug 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBeDAK/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677E275AF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617269; cv=none; b=X7OvQtY5Y21qFmpKfT+99cYyKbxlLiJjTut6DQVoAlmuvhjzD+nB8JalMTAYosQDGlA3cRxhd1LN3nsKdNzmrQ9QN6UrrBSxMvcCHQLeZm4r1XLO9fe2Mb5yOH4G9C8wHc7D2JXonTejCELlg6L79EiFv8EIgZ4Dbd8vsP4i2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617269; c=relaxed/simple;
	bh=DCYZlwnE4o4mAMqqWM8IObFLQHnKgFfq0UR0RkjtI+k=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=iCxtYHrKHyBy3o8IILl3urmVQDk3Np1to53StEIvg+EXW0pw+i5joM2kMTZL/rN9ttcuJxlGrUx83TtsPdD+JJ9CnpUW9Jc916nT6QEJzzsjG318K1Bk/96xGyQJej5j/DCI8k0mcdkNpcGmVQ5TlLxZeSWe6iBzOC1Vs03FKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBeDAK/y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755617263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u33GPzTf0Y6X5C/J4UkpcoeZDurx+dDSDRDqaezIuhw=;
	b=SBeDAK/y5GGRwWYcR2RoyB1F80AEIlhu5slDHTrIPJZAnPJN39ur6ZbWYFcZyJ5X6uVPNv
	nGkxSs0fhh9Q2GLDwnppO15gjnISY4+EnbATcVnkTvGEiUftlpGiE5mYhddoTXCsO6pHlD
	uANQI1b0SeFnFpMHhBMDBUMnKLSlP0A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-mbmbiZVcM_uTK08YJzvqig-1; Tue,
 19 Aug 2025 11:27:41 -0400
X-MC-Unique: mbmbiZVcM_uTK08YJzvqig-1
X-Mimecast-MFC-AGG-ID: mbmbiZVcM_uTK08YJzvqig_1755617260
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED5881800346;
	Tue, 19 Aug 2025 15:27:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.132])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2F1D180047F;
	Tue, 19 Aug 2025 15:27:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] cifs: Fix oops due to uninitialised variable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1977958.1755617256.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Aug 2025 16:27:36 +0100
Message-ID: <1977959.1755617256@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix smb3_init_transform_rq() to initialise buffer to NULL before calling
netfs_alloc_folioq_buffer() as netfs assumes it can append to the buffer i=
t
is given.  Setting it to NULL means it should start a fresh buffer, but th=
e
value is currently undefined.

Fixes: a2906d3316fc ("cifs: Switch crypto buffer to use a folio_queue rath=
er than an xarray")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2ops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ad8947434b71..cd0c9b5a35c3 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4487,7 +4487,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *serve=
r, int num_rqst,
 	for (int i =3D 1; i < num_rqst; i++) {
 		struct smb_rqst *old =3D &old_rq[i - 1];
 		struct smb_rqst *new =3D &new_rq[i];
-		struct folio_queue *buffer;
+		struct folio_queue *buffer =3D NULL;
 		size_t size =3D iov_iter_count(&old->rq_iter);
 =

 		orig_len +=3D smb_rqst_len(server, old);


