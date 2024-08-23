Return-Path: <linux-fsdevel+bounces-26929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B18D95D2EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86528B23337
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C91194A4C;
	Fri, 23 Aug 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YesoxUeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E41946C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429580; cv=none; b=KAX/6pV8jftuGFx33AdpGNkJedkOcyc+mg7965+hELGC2qr1hAUQ9svFuAE0Yr7ip/Px1g0YWRK7xpWJI9c/XNFlPZePp6vxBQwTRrqnXy9H+M91SMz4YXQaB4GenFircX57rHK4HmAXi1GMfCQJmfzwfNGPDbgV/U8yjr5+Sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429580; c=relaxed/simple;
	bh=322L4Js8oYAVjx2uj/9TF8tJ9GbLwzzaYu3CG5Lh98w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIC3/reoc8oyoqBSDEhKL8VimIZINrBRo3MYgzvD+1I376KdB7JjXVSwY+QyMcYYjUlZ5rAnK5vwaCEJfb2WOlMjghnw03nHbmshM8O2ZG8ZEDyQIYSgUe7xwpO5uF3n8Dbfx4FXE6ju2LyvH/x6sHUOTRuYGDcroR990Z9em/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YesoxUeY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBChvUZyQ988u9TYFlpOvF0mis7ud805n023OENZupc=;
	b=YesoxUeYcrPLAIqw7/dK0mAtqn8BaIzhq9MadzAGfBJvnJKAP5vcPOkb/d4K4k849ACozh
	gHZnT+kgtNpG2FBrq4bL5Z6POzgHWLcegeFD3v2fFWjADkCA7LLXX4S4QFYVswluShYNQU
	Oz2j8/Px4/SffFc7CcLrHmL3lSezWTk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-HzxncWQrPICf3GrzTUMYmQ-1; Fri,
 23 Aug 2024 12:12:49 -0400
X-MC-Unique: HzxncWQrPICf3GrzTUMYmQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CFB61954B02;
	Fri, 23 Aug 2024 16:12:47 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 368AE19560A3;
	Fri, 23 Aug 2024 16:12:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 5/5] cifs: Fix credit handling
Date: Fri, 23 Aug 2024 17:12:06 +0100
Message-ID: <20240823161209.434705-6-dhowells@redhat.com>
In-Reply-To: <20240823161209.434705-1-dhowells@redhat.com>
References: <20240823161209.434705-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Fix some bits of credit handling:

 (1) Use the ->actual_len value rather than the total subrequest length in
     smb2_adjust_credits() so that we don't trip the error message that we
     don't have sufficient credits allocated in a retry.

 (2) Set wdata->actual_len in writes as smb2_adjust_credits() now expects to
     see it set.

 (3) Reset the in_flight_check flag on a retry as we're doing a new read.

 (4) Add a missing credit resubmission trace.

Fixes: 82d55e76bf2f ("cifs: Fix lack of credit renegotiation on read retry")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/file.c    | 9 +++++++++
 fs/smb/client/smb2ops.c | 2 +-
 fs/smb/client/trace.h   | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 493c16e7c4ab..b94802438c62 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -111,6 +111,7 @@ static void cifs_issue_write(struct netfs_io_subrequest *subreq)
 		goto fail;
 	}
 
+	wdata->actual_len = wdata->subreq.len;
 	rc = adjust_credits(wdata->server, wdata, cifs_trace_rw_credits_issue_write_adjust);
 	if (rc)
 		goto fail;
@@ -227,6 +228,14 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 						   &rdata->credits);
 		if (rc)
 			goto out;
+
+		rdata->credits.in_flight_check = 1;
+
+		trace_smb3_rw_credits(rdata->rreq->debug_id,
+				      rdata->subreq.debug_index,
+				      rdata->credits.value,
+				      server->credits, server->in_flight, 0,
+				      cifs_trace_rw_credits_read_resubmit);
 	}
 
 	if (req->cfile->invalidHandle) {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 20e674990760..5090088ba727 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -301,7 +301,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		    unsigned int /*enum smb3_rw_credits_trace*/ trace)
 {
 	struct cifs_credits *credits = &subreq->credits;
-	int new_val = DIV_ROUND_UP(subreq->subreq.len, SMB2_MAX_BUFFER_SIZE);
+	int new_val = DIV_ROUND_UP(subreq->actual_len, SMB2_MAX_BUFFER_SIZE);
 	int scredits, in_flight;
 
 	if (!credits->value || credits->value == new_val)
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 0f0c10c7ada7..8e9964001e2a 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -30,6 +30,7 @@
 	EM(cifs_trace_rw_credits_old_session,		"old-session") \
 	EM(cifs_trace_rw_credits_read_response_add,	"rd-resp-add") \
 	EM(cifs_trace_rw_credits_read_response_clear,	"rd-resp-clr") \
+	EM(cifs_trace_rw_credits_read_resubmit,		"rd-resubmit") \
 	EM(cifs_trace_rw_credits_read_submit,		"rd-submit  ") \
 	EM(cifs_trace_rw_credits_write_prepare,		"wr-prepare ") \
 	EM(cifs_trace_rw_credits_write_response_add,	"wr-resp-add") \


