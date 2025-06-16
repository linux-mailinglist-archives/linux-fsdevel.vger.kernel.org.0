Return-Path: <linux-fsdevel+bounces-51729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988FADAEB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF72171995
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6329CB48;
	Mon, 16 Jun 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sl05z9rs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644871DFE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073766; cv=none; b=R0p+rgUIhYY20kMXjxYu8CjsiRlOYviaz/fC17CSE+kq2lg6J24dI/jA58Mut65JIpjjaqhjZxezR2t9rQYVK8ykEhoIdz/8GkNamN+zPt7nzCWNGr5d/6dlIUCpVSTHtvXGQDrRsDRdJSeYxuQWfd3LMzTfr9k6da35H32k4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073766; c=relaxed/simple;
	bh=cH1mdebi7kDJEeg0Wb5HT6Owhw8PFAmNDyCQqE/rqOc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=OAIzyvvOoqtEvYnUIx08kJ72/DSToUGMRcIURQIhWwTOPD7N62c/diqSJBpd41Gijy7vz6Rq62e8QkaENb4uXNvLnwc671GQI+SyMv+VCkyHsxjTpL7g4FkG+P/1Ir9dcUYHXDG1z96kqe9TBJ86ZUNamzxQnQUmPm2Koo3lFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sl05z9rs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750073763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nf0+ogMmdaKGYBzbk4mOB841JGfIQ7imOaaevAHK9Zk=;
	b=Sl05z9rspMe7tnPN9X7vjKunWxB2IeLwLhx3G2lgjPLK3eTIgE7qx18nw4F62mIGMxQIDX
	ePJgsjQ/ppEV5c+XXEoibXNjqRitumqXuSqbRgdvPI8cnYjy4lrBgvFj8rHxNqgx5vtRXX
	0UOL4pwk7z+VCLQnG+dHV549Jb+hnDs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-CcDyKh_qNOe3bhhPj8MzuQ-1; Mon,
 16 Jun 2025 07:36:02 -0400
X-MC-Unique: CcDyKh_qNOe3bhhPj8MzuQ-1
X-Mimecast-MFC-AGG-ID: CcDyKh_qNOe3bhhPj8MzuQ_1750073761
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B02DF1800368;
	Mon, 16 Jun 2025 11:36:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9B91195608F;
	Mon, 16 Jun 2025 11:35:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix hang due to missing case in final DIO read result collection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <583791.1750073757.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 12:35:57 +0100
Message-ID: <583792.1750073757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When doing a DIO read, if the subrequests we issue fail and cause the
request PAUSE flag to be set to put a pause on subrequest generation, we
may complete collection of the subrequests (possibly discarding them) prio=
r
to the ALL_QUEUED flags being set.

In such a case, netfs_read_collection() doesn't see ALL_QUEUED being set
after netfs_collect_read_results() returns and will just return to the app
(the collector can be seen unpausing the generator in the trace log).

The subrequest generator can then set ALL_QUEUED and the app thread reache=
s
netfs_wait_for_request().  This causes netfs_collect_in_app() to be called
to see if we're done yet, but there's missing case here.

netfs_collect_in_app() will see that a thread is active and set inactive t=
o
false, but won't see any subrequests in the read stream, and so won't set
need_collect to true.  The function will then just return 0, indicating
that the caller should just sleep until further activity (which won't be
forthcoming) occurs.

Fix this by making netfs_collect_in_app() check to see if an active thread
is complete - i.e. that ALL_QUEUED is set and the subrequests list is empt=
y
- and to skip the sleep return path.  The collector will then be called
which will clear the request IN_PROGRESS flag, allowing the app to
progress.

Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the wait=
queue used")
Reported-by: Steve French <sfrench@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 43b67a28a8fa..1966dfba285e 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -381,7 +381,7 @@ void netfs_wait_for_in_progress_stream(struct netfs_io=
_request *rreq,
 static int netfs_collect_in_app(struct netfs_io_request *rreq,
 				bool (*collector)(struct netfs_io_request *rreq))
 {
-	bool need_collect =3D false, inactive =3D true;
+	bool need_collect =3D false, inactive =3D true, done =3D true;
 =

 	for (int i =3D 0; i < NR_IO_STREAMS; i++) {
 		struct netfs_io_subrequest *subreq;
@@ -400,9 +400,11 @@ static int netfs_collect_in_app(struct netfs_io_reque=
st *rreq,
 			need_collect =3D true;
 			break;
 		}
+		if (subreq || test_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags))
+			done =3D false;
 	}
 =

-	if (!need_collect && !inactive)
+	if (!need_collect && !inactive && !done)
 		return 0; /* Sleep */
 =

 	__set_current_state(TASK_RUNNING);


