Return-Path: <linux-fsdevel+bounces-71882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E6CD7571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FC48300197F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226D235029B;
	Mon, 22 Dec 2025 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STKlWSN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190634F27E
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442733; cv=none; b=crk4fO9A8Gg4Ik4Rpnis9uD4QM3YnvDj0+lO8PX0CYp8SueT2Vcyc2d7yJsdyisL7RSyH6ACjQEnzAHITIDWnV/aLIWKMhAIY+mvL2/wy/ISYUy+18BKqMvB2iKlA9XJAhK97Q23ovrcjy7C6dCX8xYvGtHi94p93ALd/34P2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442733; c=relaxed/simple;
	bh=PNws5mwnRbKQce0nmr0F4ETiz1tK1EcaNaka93kF5D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKNDkWb/P0o8NJAQxXbEKFZWAt3ddgIZ8NH/8MOZUu310QH6YviAhH0Kzcd2/fnPiCm/kLah5rqbAh6JL6whEU8jSjQxc/A2wHXJUl9sj+f0bmIcqaXMQnOWITZwL5JLz+R0yCQPdtydrROdE781eTUEfVZ72NvoIUnfP1x+7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STKlWSN6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qX9dROQiP6/aMUr6ukkKfXCExfdWHH3TQJBkk4RJM7o=;
	b=STKlWSN6zv8rLdhZ3ToeRBBdqyBVa7q2xZKyqgA6rqqe4nRFMB7SCp8s6r/F4/hTApctsL
	ZRQ5xFlC9CQGLHrOoYbu6UDvuuTbBYbkMgjilz9B368M3vkevdbP2/B1IAjuLR8HzEqnaI
	ZX64aecWR8mav2lLOdgD2y3X/kVKQAs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-BmeE_gLFPwmSOHBErFEanA-1; Mon,
 22 Dec 2025 17:32:09 -0500
X-MC-Unique: BmeE_gLFPwmSOHBErFEanA-1
X-Mimecast-MFC-AGG-ID: BmeE_gLFPwmSOHBErFEanA_1766442728
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A3FF195608D;
	Mon, 22 Dec 2025 22:32:08 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51AF8180049F;
	Mon, 22 Dec 2025 22:32:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 37/37] cifs: SMB1 split: Make BCC accessors conditional
Date: Mon, 22 Dec 2025 22:30:02 +0000
Message-ID: <20251222223006.1075635-38-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Make the BCC accessor functions conditional.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/smb1proto.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index 5ccca02841a8..0c622b5d2555 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -300,8 +300,6 @@ compare_mid(__u16 mid, const struct smb_hdr *smb)
 	return mid == le16_to_cpu(smb->Mid);
 }
 
-#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
-
 #define GETU16(var)  (*((__u16 *)var))	/* BB check for endian issues */
 #define GETU32(var)  (*((__u32 *)var))	/* BB check for endian issues */
 
@@ -333,4 +331,6 @@ put_bcc(__u16 count, struct smb_hdr *hdr)
 	put_unaligned_le16(count, bc_ptr);
 }
 
+#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
+
 #endif /* _SMB1PROTO_H */


