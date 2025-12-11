Return-Path: <linux-fsdevel+bounces-71108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C1CB5DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD3E3058457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A830FC09;
	Thu, 11 Dec 2025 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYyFisH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68D30DD09
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455522; cv=none; b=jmu1w5vJ/GsqzPz8ABkj7pb60JK+vMPzCe3YXGSgnc7t1AvVEx0o0ieoTuEa7JjV+/6V6KSrFwVgqOslsoKLxm/E1vJfMJ2YtOSt7svS0MeXM1umOubmP5gskwWEfIdfHdeuNETdcPO2kq5VoQ4M75rS0d598KVZm8bkZBMEaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455522; c=relaxed/simple;
	bh=zLWO5FyfEzMxfl05ySru/8Ox2dSgrAF7KO5fd5O/Q8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4BnJar9uG6ta2XmzTKJeGfmvgOkq0JI1R0HSL8uIXXJYnoQ/3vPDGBE6iz1C8j8PxpVYUZWdfWXhBp+Z8QxgYddqbGFNbpGl/9dU8kUKXfwtbC/jYcLWcAxaC+tKUtpysJp4i+xZtSxbab8x5yD/LkV5gtAOqNfPOfYdhtXrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYyFisH8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFALeYtPmFkPXwUUj8yBrwfdlJ1QvpuwMDYyDcDX4Lw=;
	b=KYyFisH8BAlHo91QEieQ4BLQhgXztEypamyxUbiLmlh+86h7A0JArdWGm5gTg7FYtq47rg
	ZHR1ZHrxhYxcJTzgwzbCM8mm9kfHd1u76J7cf579jZtrfSsulkuz8AXwPB+xNaAXQQ0ueE
	p9olZry88IGtslwfZ+n2iGbgv32Akbc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-4fR-R_d-OdyWfl5WJ5DfFA-1; Thu,
 11 Dec 2025 07:18:33 -0500
X-MC-Unique: 4fR-R_d-OdyWfl5WJ5DfFA-1
X-Mimecast-MFC-AGG-ID: 4fR-R_d-OdyWfl5WJ5DfFA_1765455512
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8635719560AF;
	Thu, 11 Dec 2025 12:18:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C02F61956056;
	Thu, 11 Dec 2025 12:18:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] cifs: Scripted clean up fs/smb/client/cifs_spnego.h
Date: Thu, 11 Dec 2025 12:17:06 +0000
Message-ID: <20251211121715.759074-14-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifs_spnego.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifs_spnego.h b/fs/smb/client/cifs_spnego.h
index e70929db3611..987768348624 100644
--- a/fs/smb/client/cifs_spnego.h
+++ b/fs/smb/client/cifs_spnego.h
@@ -28,7 +28,7 @@ struct cifs_spnego_msg {
 };
 
 extern struct key_type cifs_spnego_key_type;
-extern struct key *cifs_get_spnego_key(struct cifs_ses *sesInfo,
-				       struct TCP_Server_Info *server);
+struct key *cifs_get_spnego_key(struct cifs_ses *sesInfo,
+				struct TCP_Server_Info *server);
 
 #endif /* _CIFS_SPNEGO_H */


