Return-Path: <linux-fsdevel+bounces-16830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C903D8A3644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 21:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050D71C2210C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB6150995;
	Fri, 12 Apr 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvI8Pl+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5E14F9F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949747; cv=none; b=PHWzMtv6RJcTDTgTgcJbk72u9Tns9Mt/fVj8IKCNoT48ME01/NVqGeqt6/64QEQQA+aeKWkqD06eBC6Ja+LHhSWdVlJVL+ZhzwGEe3wN5gF0vGaoem0YZ9qN/Epjrn+GxuzC4l8Bp2kvSBRg3YiCn0zYH1uZW0fZhzXQ1dNXq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949747; c=relaxed/simple;
	bh=rJJDW6M/uVgQhjBMv5U9Y/+x8Home6Qs2tK4Mimp7eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+J7td7gEBHoDpDJXgPu9JS+Ui+6pFE+jDhZQ+4So9umKRhYHSvg+MNwSPYIGwbPMgfiJpTTzPjhn5mjTPPvoiylbrYM80BF3Dl1/IQ6Mnmu0SXe4yJtZnC4+W2lxK3msU48ArWarwCsSJ5O5xR+em4edFrciVK7qVZEGU6J2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvI8Pl+H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712949744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTlRjp+GLWBCq38BHZDRc8AYPNQSsRckMkxhoDVV6JE=;
	b=fvI8Pl+HfU0MnwCbbqQfYoL8grfhfkitFpEZhLp3yuYBj4pL9lFF3e/zY3hVoeJrPJ6UPq
	fRhr7C/6BrRRKUl4rht+aiokXYx94yc2dIwf+DpUqAw3fffMqUdqR16XmH+CnpVN5+7+3+
	i6Tb//WEkRcZu+E4LJAHimSUt9Z7ho8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-z3oD1CXXOCC78S8Ew5BmrQ-1; Fri, 12 Apr 2024 15:22:20 -0400
X-MC-Unique: z3oD1CXXOCC78S8Ew5BmrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0489E1049BC7;
	Fri, 12 Apr 2024 19:22:20 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.10.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 731062DD51;
	Fri, 12 Apr 2024 19:22:19 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: brauner@kernel.org
Cc: hpa@zytor.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH] Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
Date: Fri, 12 Apr 2024 15:22:17 -0400
Message-ID: <20240412192217.4172554-1-cmirabil@redhat.com>
In-Reply-To: <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
References: <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

this is a nitpic, but if you are going to touch the comment on
line 4654 I think you should fix the spelling mistake :^)
handlink -> hard link

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6d5b3f0d6ad3..9b806b108ed0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4651,7 +4651,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	 * To use null names we require CAP_DAC_READ_SEARCH or
 	 * that the open-time creds of the dfd matches current.
 	 * This ensures that not everyone will be able to create
-	 * handlink using the passed file descriptor.
+	 * hard links using the passed file descriptor.
 	 */
 	if (flags & AT_EMPTY_PATH)
 		how |= LOOKUP_LINKAT_EMPTY;
-- 
2.44.0


