Return-Path: <linux-fsdevel+bounces-24906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE139466F2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 04:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516081F21CCA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 02:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2CF9E4;
	Sat,  3 Aug 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxVmMYEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FBBE4F
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722653708; cv=none; b=Cyt5dTCxvOS8bZBHRT2KRJoRLdB0U3sMQCIZXOkBkqKc3zPdKMBrAB9DkEaTitSosirQgMsyex5xPO5j2epG+bHHYPf5wGNoCKdyECah2zCwrsk9dNPYj0UhbqAZ5CfMBP8wsBEhMU5sIIMClMMTF9SG142iUX5EJluHfzBIKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722653708; c=relaxed/simple;
	bh=RIN8860VKrwG8pGn//fjYw1Ffx/DZsTnQ7DUTwCg1f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrr50REe7VE/FsoRKXYaZHp3+m9+rPImiVVTyW4rPx9B7Jyd6kJ6oLwcVs2QT6QbthCKjh0r0d8T4Tq9dR6XQZSqo5+lYyc6KHplSGNlkKoW8NrbWN2bP/EdyOv30inuw8r82lh6BLrb6CeznIvZfFQJ3rppwD98+oXB9vINWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxVmMYEc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722653705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F1wAfXnbDS38XwTTIr6+TPJ2ikyvkJ3Nuyw1zubgkCY=;
	b=IxVmMYEcPpem7RONPk5ef/ypYMzxGVuwb6u9McqQosf2OmVbet4X9L4mmuVSUYZfjxBBBj
	SkX5L3Jkmc3N8qPddy2/JmeL9swrDDhr/mNjAxV4OLfHmEZriZ6bv9NEOk7Qg+TmSgSNqT
	hG8hSlrD3OaelZLAQME0gVMmL0Ln3r4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-r25lBCQANJi1NK8s-9V8Hw-1; Fri,
 02 Aug 2024 22:55:00 -0400
X-MC-Unique: r25lBCQANJi1NK8s-9V8Hw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 973FD1955D56;
	Sat,  3 Aug 2024 02:54:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.14])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF27A19560AA;
	Sat,  3 Aug 2024 02:54:57 +0000 (UTC)
From: Joel Savitz <jsavitz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] file: remove outdated comment after close_fd()
Date: Fri,  2 Aug 2024 22:54:55 -0400
Message-ID: <20240803025455.239276-1-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org

The comment on EXPORT_SYMBOL(close_fd) was added in commit 2ca2a09d6215
("fs: add ksys_close() wrapper; remove in-kernel calls to sys_close()"),
before commit 8760c909f54a ("file: Rename __close_fd to close_fd and remove
the files parameter") gave the function its current name, however commit
1572bfdf21d4 ("file: Replace ksys_close with close_fd") removes the
referenced caller entirely, obsoleting this comment.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index a3b72aa64f11..cfc58b782bc4 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -676,7 +676,7 @@ int close_fd(unsigned fd)
 
 	return filp_close(file, files);
 }
-EXPORT_SYMBOL(close_fd); /* for ksys_close() */
+EXPORT_SYMBOL(close_fd);
 
 /**
  * last_fd - return last valid index into fd table
-- 
2.45.2


