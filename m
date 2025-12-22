Return-Path: <linux-fsdevel+bounces-71875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310ECD7531
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73C56301B802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FDF34E240;
	Mon, 22 Dec 2025 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h019AxMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA534DB59
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442711; cv=none; b=IXYrUCCMwQHvGF2/3JLNIu6kjy2wGFv11yCviJlu44gozPU/O4Vn2BvJBMKfsiwFGKEoDXPhhSdD1GVbFL1j4LYXUaUtGWgSfYfIdfhWdpo7h7eKPAHTIvXCdUQ8KkD/6FNYvorWdphYFKLiZv/w2gxdt8vz2W7HMAH0maBmMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442711; c=relaxed/simple;
	bh=ybKHMmdoxq6/p5OMzGFC0Z4xqaE0RZ7LtY0MDuMnhDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EilhoYSviyzIiKyOxFd+c3QSgiojgVTpOj+cDM5d7LkIjIzv4KR2qlMuKnd+PKpTshnSHMBPFEvKWUQh0/J4/P27Ri/5VP8B1KkVjHlDCegbIChCzIHTL5KyJpLdAYWxCGX1eXaNo9bq6EdJTCZnFObl1uvrPsPatwKoEXr+lY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h019AxMY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YGWiwoglUBmNMMiAdKk3lZFrQ4VD7fmxoQNMg4AWBc=;
	b=h019AxMYPk1Sgt9x6GBU573jawGxDGNjU+L9OWhh8lM6ngMhQRHuAWtauFDL6zTRFz+VWM
	82E1zJNElxunllDLR0w0lhiGdghqt+1O5ygafDN15/Xe17hDPFgFyuOh0XrDwQ1nFkSUIq
	2LexPGLTb7dMrkpQOARUagjNE4To+X4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-WuEiNoE4OniOQGn22D6Zjw-1; Mon,
 22 Dec 2025 17:31:46 -0500
X-MC-Unique: WuEiNoE4OniOQGn22D6Zjw-1
X-Mimecast-MFC-AGG-ID: WuEiNoE4OniOQGn22D6Zjw_1766442705
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5F6519560A5;
	Mon, 22 Dec 2025 22:31:45 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E983119560AB;
	Mon, 22 Dec 2025 22:31:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 30/37] cifs: SMB1 split: Move inline funcs
Date: Mon, 22 Dec 2025 22:29:55 +0000
Message-ID: <20251222223006.1075635-31-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move some SMB1-specific inline funcs to smb1proto.h.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifsglob.h  | 12 ------------
 fs/smb/client/smb1proto.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 2cbaf3f32e8e..ae37fb2dc535 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -949,18 +949,6 @@ revert_current_mid_from_hdr(struct TCP_Server_Info *server,
 	return revert_current_mid(server, num > 0 ? num : 1);
 }
 
-static inline __u16
-get_mid(const struct smb_hdr *smb)
-{
-	return le16_to_cpu(smb->Mid);
-}
-
-static inline bool
-compare_mid(__u16 mid, const struct smb_hdr *smb)
-{
-	return mid == le16_to_cpu(smb->Mid);
-}
-
 /*
  * When the server supports very large reads and writes via POSIX extensions,
  * we can allow up to 2^24-1, minus the size of a READ/WRITE_AND_X header, not
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index eaf317a53b76..abbc3db11743 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -243,6 +243,18 @@ int checkSMB(char *buf, unsigned int pdu_len, unsigned int total_read,
 	     struct TCP_Server_Info *server);
 
 
+static inline __u16
+get_mid(const struct smb_hdr *smb)
+{
+	return le16_to_cpu(smb->Mid);
+}
+
+static inline bool
+compare_mid(__u16 mid, const struct smb_hdr *smb)
+{
+	return mid == le16_to_cpu(smb->Mid);
+}
+
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 
 #define GETU16(var)  (*((__u16 *)var))	/* BB check for endian issues */


