Return-Path: <linux-fsdevel+bounces-15591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2D89069E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC761C310ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C05E13777E;
	Thu, 28 Mar 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwdwjXwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AB13775B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645217; cv=none; b=u9rbtm+Cyi9fZw1Kqi7FZCYjG4rh1X0hD39mPNTPHgzm9vsYQaQuqXZcjGKVeO7B8nASfuAiuqz5RqZ90HDJQ+RmYb3eC/NlruPHrS0421IrrgSFlEmeGFUaQGRXcZHok/jYhfGDg61MTxiJ1CYSf6hDfTvyDl2y0XHE4w2jZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645217; c=relaxed/simple;
	bh=a7ZDTPEmZI5vb0iw+H7BOuZ7gMj6e/DdhQq/AVsEQy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE1rhil2QExLLEVEHj3oiPssvgID/NJAQwNcGtpf1Tf5Tv2tMOhB82v/g2bVMqXQMwYgh9/fH4y4wl3K7mfyLAnOvrTEm3Wd71VdnKdoPrz35C6+OYmaXa7I9vqEDR36Dh/L3wvG49Hcwvw5k5bPNrRAFodKVjD+oHH83su+Yvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwdwjXwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CntTp3Jyu1WRS7BeCEXY9WjviKzEFkeTql7WaUHGCEY=;
	b=EwdwjXwpU8MiAtCjj5sF+GKuKT6mLIStAzMv0brFevubg0lhU2tOAFatIMI/ZhVDQ6ms/U
	xBmBum7+xXEDo81pOisVRDsuCk4NsLgMt2Y7xdw/FrPj7LpqOTWrK3WplJVdf6gkjYq5N0
	MbXeu5fKjoB7YtqoLZgW0A22qWyu7tw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-WeYapp8YNLeeFBVwym_fhQ-1; Thu, 28 Mar 2024 13:00:06 -0400
X-MC-Unique: WeYapp8YNLeeFBVwym_fhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68888101A56C;
	Thu, 28 Mar 2024 17:00:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8565E1121306;
	Thu, 28 Mar 2024 17:00:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v6 09/15] cifs: Make add_credits_and_wake_if() clear deducted credits
Date: Thu, 28 Mar 2024 16:58:00 +0000
Message-ID: <20240328165845.2782259-10-dhowells@redhat.com>
In-Reply-To: <20240328165845.2782259-1-dhowells@redhat.com>
References: <20240328165845.2782259-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Make add_credits_and_wake_if() clear the amount of credits in the
cifs_credits struct after it has returned them to the overall counter.
This allows add_credits_and_wake_if() to be called multiple times during
the error handling and cleanup without accidentally returning the credits
again and again.

Note that the wake_up() in add_credits_and_wake_if() may also be
superfluous as ->add_credits() also does a wake on the request_q.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 057a7933b175..704f526a9e81 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -881,11 +881,12 @@ add_credits(struct TCP_Server_Info *server, const struct cifs_credits *credits,
 
 static inline void
 add_credits_and_wake_if(struct TCP_Server_Info *server,
-			const struct cifs_credits *credits, const int optype)
+			struct cifs_credits *credits, const int optype)
 {
 	if (credits->value) {
 		server->ops->add_credits(server, credits, optype);
 		wake_up(&server->request_q);
+		credits->value = 0;
 	}
 }
 


