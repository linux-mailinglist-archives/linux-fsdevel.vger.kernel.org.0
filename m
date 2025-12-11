Return-Path: <linux-fsdevel+bounces-71109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F0CB5DD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D436E3072E09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8223101A9;
	Thu, 11 Dec 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UebIOHx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC330DED5
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455527; cv=none; b=L1fS/EgAi6SomP22gyOC1QHwf0wJxkt3gAiBA1L3NFAvCJVOU/NaV1I03t8g0+lRB/PUr6NDUs/EmSqSsm3IoIDwwI7qoIfxDbuEMSHBgcte8jRz55KKYxe53g9jBOqQA/Ey01bHo/03zSZmI7jpyEpU2Ntgu3OXwSqL7m5qn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455527; c=relaxed/simple;
	bh=RwYUerJ4hJmzwuH1LlZyqEcdJj9Pt2Fovq5QE2M9JM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3I4yuKrKQN/UcCm5R0ZpyBkN2CepMl+qmP0yCCAMoP+GUV3BYSCqORwwJwDREj1eHq/GqXFYB/1qPpB7sqr0wy2tRYHhZdNItLNGocmYbxPkfVujYsJEcQjViJ5GvCwong6PBJ/v3xiIeYsiQI7TyuQcBPTO8ioMuMCdhdbU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UebIOHx/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfVyyD1PexB1d/N6d8HS6nBZO+yvtrhFLe6ajtg+Ako=;
	b=UebIOHx/oM+qzZTeehMkuAyvfFSi3WM5dQSUgOh1UqeVC9kTBMai/60VOzPyVbSy7FbAG/
	eHaofLPJeegiHJ0eziSsTm7kLZiJq2cRDcu/q4GEQnomX/+vYv1Fowp2VpNAY2x+TZxsJi
	mFl1F1bYnOtP6j4yueXPJyxwZ7SyiLc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-qWgjAMYnNKi2LJjyakcflg-1; Thu,
 11 Dec 2025 07:18:36 -0500
X-MC-Unique: qWgjAMYnNKi2LJjyakcflg-1
X-Mimecast-MFC-AGG-ID: qWgjAMYnNKi2LJjyakcflg_1765455515
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8B57195FCDC;
	Thu, 11 Dec 2025 12:18:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0E24180035F;
	Thu, 11 Dec 2025 12:18:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] cifs: Scripted clean up fs/smb/client/compress.h
Date: Thu, 11 Dec 2025 12:17:07 +0000
Message-ID: <20251211121715.759074-15-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/compress.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/compress.h b/fs/smb/client/compress.h
index 63aea32fbe92..2679baca129b 100644
--- a/fs/smb/client/compress.h
+++ b/fs/smb/client/compress.h
@@ -30,7 +30,8 @@
 typedef int (*compress_send_fn)(struct TCP_Server_Info *, int, struct smb_rqst *);
 
 
-int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn);
+int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq,
+		 compress_send_fn send_fn);
 bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq);
 
 /*


