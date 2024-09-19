Return-Path: <linux-fsdevel+bounces-29704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5C197C819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 12:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3261F2A34D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8779A19B5BB;
	Thu, 19 Sep 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcPrI6NB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEFA18E04D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742463; cv=none; b=nd8SBWgLIUMfU843uOQs0SwYc2SOhU+wOfL7HRYIy5uLe3kmZqSR7HsBx7ODDuyfYn9C3OtYAUdfHbzqMtkU188fqoqmioj6TwH6eawmSIiH+oUJpvNeoEnrnGNZq14NiA1aTkzsZOjEq4vZCJJM89edFVtJomyzOq526h1iOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742463; c=relaxed/simple;
	bh=iSdB96//uOYNetxOBLT39OE78EZTh4JQ1vmKYkFcepo=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=tG9ExKFXcC6rOQDmuxH/tp+CFUG+IwHHvtkTb3tEpRTFgX+n4i7P7r2IJjLVdGoTVaamIKu/fRtPGZ1bnxjXKQyirN+NwUBMTeYqPDbwQiTnN0zPTI9ukEL8i0UpI39+qE3OKn48FS2ddOtCkItHWeM53owtCH8/p/R/mP4VwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcPrI6NB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726742459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VcvHdf5Pmtgf7/MQNxfdvUPCsOw52+fwh9xXqYx7hPg=;
	b=LcPrI6NBkh53jbD4oGOHLinRmeJZF2+6CQatQb2HIy7FNwOSJVJEBYFF6XLQaMcD8NNSkr
	Y3kfVdEubV59JTFywqHfwf8qvuKendV78Q+JSN7dsjuGhYqjJD/bizvl6fYWkYnCQH5Tju
	V376RdITzJJUGLIf2IN0izBwAFPAWTs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-Wj0fOkpxPSa41HX4PpiQXg-1; Thu,
 19 Sep 2024 06:40:56 -0400
X-MC-Unique: Wj0fOkpxPSa41HX4PpiQXg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC0291935852;
	Thu, 19 Sep 2024 10:40:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79398196CAD2;
	Thu, 19 Sep 2024 10:40:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix setting of the server responding flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2614632.1726742450.1@warthog.procyon.org.uk>
Date: Thu, 19 Sep 2024 11:40:50 +0100
Message-ID: <2614633.1726742450@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In afs_wait_for_operation(), we set transcribe the call responded flag to
the server record that we used after doing the fileserver iteration loop -
but it's possible to exit the loop having had a response from the server
that we've discarded (e.g. it returned an abort or we started receiving
data, but the call didn't complete).

This means that op->server might be NULL, but we don't check that before
attempting to set the server flag.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Fixes: 98f9fda2057b ("afs: Fold the afs_addr_cursor struct in")
---
 fs/afs/fs_operation.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 3546b087e791..f9602c9a3257 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -197,13 +197,12 @@ void afs_wait_for_operation(struct afs_operation *op)
 			op->call_abort_code = op->call->abort_code;
 			op->call_error = op->call->error;
 			op->call_responded = op->call->responded;
+			if (op->call_responded)
+				set_bit(AFS_SERVER_FL_RESPONDING, &op->server->flags);
 			afs_put_call(op->call);
 		}
 	}
 
-	if (op->call_responded)
-		set_bit(AFS_SERVER_FL_RESPONDING, &op->server->flags);
-
 	if (!afs_op_error(op)) {
 		_debug("success");
 		op->ops->success(op);


