Return-Path: <linux-fsdevel+bounces-71859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EDACD759E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4733098317
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C111F33F8D4;
	Mon, 22 Dec 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfJi+xfV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C133F375
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442658; cv=none; b=T0n2vh33tK5w41HmnV7ryZapACICMwPkPIE/VeGMbJzStuwH94kc4+/szUHQWr/WGrFYn6P6wCPnVPtieyKRKStrG8hHgoslB9uAKl3kTEbSdHgTidwLfPAjL1PgO0IGTDHU7H7gtRtuTosJM2gKATOy2M3oxU26+rdACpNdi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442658; c=relaxed/simple;
	bh=zLWO5FyfEzMxfl05ySru/8Ox2dSgrAF7KO5fd5O/Q8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIQ+sxJ3e2PFdpjxOpTj5WxaMDmIqouzszv4EY5RsAcbwCGgIv8CqmA9TYFF0NtxVzQY9Of3xd9eJ6EvAS5elBtNDy0MboCDcc/8HldNTrLZziwtYKMfuZgS1SD0YNkrottQmyZRMv3AVMrOSbQgkz57cdhkU5bQ79bnH9lfa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfJi+xfV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFALeYtPmFkPXwUUj8yBrwfdlJ1QvpuwMDYyDcDX4Lw=;
	b=UfJi+xfVhsZhVnfuswZiZLHlV3Rcj9FPzltEl0sLrmItaz+VDi2tu1h+63BNa6t/yIoHef
	DsUejqKLvZN2aK8cPLTop1C27avfwGbK5KiBajw2A18SnfQ//PT4W3idf3kjs6+seBtfOf
	cmhJZsjOnYXZwpWStcgZEWADu1N38nA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-kSfxxyG0POm6ZgPdd6nlMQ-1; Mon,
 22 Dec 2025 17:30:50 -0500
X-MC-Unique: kSfxxyG0POm6ZgPdd6nlMQ-1
X-Mimecast-MFC-AGG-ID: kSfxxyG0POm6ZgPdd6nlMQ_1766442649
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 416371956088;
	Mon, 22 Dec 2025 22:30:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7844219560B4;
	Mon, 22 Dec 2025 22:30:47 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/37] cifs: Scripted clean up fs/smb/client/cifs_spnego.h
Date: Mon, 22 Dec 2025 22:29:37 +0000
Message-ID: <20251222223006.1075635-13-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


