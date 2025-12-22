Return-Path: <linux-fsdevel+bounces-71865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C2CD758F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4D4C30819FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7BF34AAED;
	Mon, 22 Dec 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fbgjnvnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83034A79A
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442677; cv=none; b=HIhHfM24ps2mz5pRGL6FBLNXGPZVQLwKx/M8PGnd3ruT/p2zbDRZ7xyygsd+Rjvt2iDz2iHb81x3vgWTA6h0YSkvSmCE7hHGuO44OYT9vHMxuT8BEaSqDY6FH0GXKcDWX+ZNVFrKJzqfJ4qU/dMZwapP4+NV9rg2w9TgZOUcH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442677; c=relaxed/simple;
	bh=imb2YF+OUmVmE2KMegnh4Yvp1omQxmj6tAAzek2xzk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kD7PwpYifs348bkIToSUwkgvemHZiLL+NpuijHwf1X8+YBKvj/K/UUnRN8iXf86qYto8ZN6vCRcMvZghdy9gn6qA4YuWJ9S2mICy06uS1OLVjp9zDidJHFbJwg3j4fD0RazNif3+6jiA7iwqVfDKqbpyjjjJfI8iYI5Fmij7wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fbgjnvnl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJOPJnHZMSkotFj749V2K5gMSGhnu2n1N2tvafR4Ntc=;
	b=Fbgjnvnl6tlXGz4695nH2TKqOnWFpLXmI3GsW2aVSnjAYYQeHXfy3Ktj5ec/OtFUxyHxdY
	vNCaflCLFBmJLQXudvFDJTrdupry1atxkn5at2ym+of4OfsNycLVgyyWRJmfHtPHZ1kQ1H
	fFW6+huFAm6ti+43O9PlDUKe+Ob21TU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-9_BPZSygOeaQqmBYx8bJ4A-1; Mon,
 22 Dec 2025 17:31:11 -0500
X-MC-Unique: 9_BPZSygOeaQqmBYx8bJ4A-1
X-Mimecast-MFC-AGG-ID: 9_BPZSygOeaQqmBYx8bJ4A_1766442670
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A16CF1956094;
	Mon, 22 Dec 2025 22:31:10 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E209B30001A2;
	Mon, 22 Dec 2025 22:31:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/37] cifs: SMB1 split: Rename cifstransport.c
Date: Mon, 22 Dec 2025 22:29:44 +0000
Message-ID: <20251222223006.1075635-20-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Rename cifstransport.c to smb1transport.c in order to give consistent names
SMB1-specific files.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/Makefile                             | 5 ++++-
 fs/smb/client/{cifstransport.c => smb1transport.c} | 0
 2 files changed, 4 insertions(+), 1 deletion(-)
 rename fs/smb/client/{cifstransport.c => smb1transport.c} (100%)

diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
index 4c97b31a25c2..9754b4776df8 100644
--- a/fs/smb/client/Makefile
+++ b/fs/smb/client/Makefile
@@ -32,6 +32,9 @@ cifs-$(CONFIG_CIFS_SMB_DIRECT) += smbdirect.o
 
 cifs-$(CONFIG_CIFS_ROOT) += cifsroot.o
 
-cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += smb1ops.o cifssmb.o cifstransport.o
+cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += \
+	cifssmb.o \
+	smb1ops.o \
+	smb1transport.o
 
 cifs-$(CONFIG_CIFS_COMPRESSION) += compress.o compress/lz77.o
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/smb1transport.c
similarity index 100%
rename from fs/smb/client/cifstransport.c
rename to fs/smb/client/smb1transport.c


