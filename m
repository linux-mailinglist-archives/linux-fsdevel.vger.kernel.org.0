Return-Path: <linux-fsdevel+bounces-70978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DBCAE0AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FB60300A216
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC30A2D5432;
	Mon,  8 Dec 2025 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asGJ7onH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAKGpK8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830361E98E3
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220695; cv=none; b=Id9uJmeHfh0bDDM96MYaPfuH35Cvt4ieJjc6esoVmML/R/1bySwXVBaz4qy6sNrauQvOBhIGk6HieQEKs6OcmON+bQf3sZ+N23aMXt0RIyn0SuOXGHuqbVOSnYVEOOWShYpqq4AIDEE1xKi9t3QYACwtxryFVrUPHeK9+Yll6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220695; c=relaxed/simple;
	bh=IjMXIvAWoi6XeLEgxUx0Oepme8GMKFwrSkN4saSkwMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXDB7V160lKpGygq6K3NUkFSKDltG/NcYbWXfQw9rDGBSjTPTrEIA4dfDDQ5gSlz8KJ03To8zYVNY3HAU3dXdRZqPeP7AL5Go7dgYRedFKpHETgt4b17bmVvBOiIGhw1R/eUdvn6O5FURe/HQ33wV0KMtesEhF4ND36UaVSUbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asGJ7onH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAKGpK8N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765220692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xF77s5EIcs0pFYKpiAgo+6DSRM9rfh1uhjncv2O4WTI=;
	b=asGJ7onHbWikQU0gBA8dPTa8PGYhw+mqlDoEVLVj5mZu9Cr1PsjxEflECnnzWo3GKA1bi+
	YW6mvTld9O9XSr3J0smvsITMuuSN7WwZ1WhtrQOZa+vei+qNJNGfT902rI1Jb23PaEHjeC
	bsCZg8oabInDFv87p54fe4imKYFH7mg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-B1dixxFTOQOsR0i14YcSQg-1; Mon, 08 Dec 2025 14:04:41 -0500
X-MC-Unique: B1dixxFTOQOsR0i14YcSQg-1
X-Mimecast-MFC-AGG-ID: B1dixxFTOQOsR0i14YcSQg_1765220680
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so8061780b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 11:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765220680; x=1765825480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xF77s5EIcs0pFYKpiAgo+6DSRM9rfh1uhjncv2O4WTI=;
        b=PAKGpK8NJPBRe8iVOJLBagMO5DF0w4livBabQVJhA0I3r8znM2JWaRak9Y4CltFWCF
         Yd2yTJ5L0nLfBCCALZcAERXBIFD1YIjQq6qVcgO9gIzMsGc3ulOdrAGHNRiqoujBCXHG
         w/sTaZ/GWGNHLfYqMQv9tp8smVpMEOEerliCYm+nN4PgzrlrETa+qPcO6JSi2vL+mZGs
         kdbAD90ZX0qNuR/q/ItJHzzL6OdEYmzV9tIyzgfrSCf65oPa60LAJnMbHORac34s8LYD
         416ESX9fprQ1wxV1qPHDV3KAq6sLTatcM1LsEGsKDd3jvWUCIgqPlRcZlVyjzfhmO7Af
         FPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765220680; x=1765825480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF77s5EIcs0pFYKpiAgo+6DSRM9rfh1uhjncv2O4WTI=;
        b=MQ1tqdEl5jdnUJW4HWvxR1MgQb1Zw8An7jtlAbFNGATCXwNRLg2AXOTusJqXTAp1xh
         Hzif1hdxYhMbvfJ7tiJbyJvvpOSJPp8eZY3u3FHTel3W3w1Qh2q8Pux1E6yHJhfZ6YB6
         RYRv+nWKl3DBRIFo4JbDJowUP+6tpfbzWdq/b1PawQiq4kwKCXOU65l3E8gtbjsSS0zk
         Zu3G+IsJIhuwGVVl3TIthjMw/0ylawyKKdEsqHEeQBztNC0yZOdLjbQZPg4E90Qh2e4+
         Hx3GRsa4txojCb7kUWcmooUblpQntrz+X857N7wq0HS78p0cjasT8fGu9VCS3MlrtJlp
         +eOg==
X-Forwarded-Encrypted: i=1; AJvYcCVKqseACX1d4MsKz5Qh0/bqAzBg+0myT4aADK5hdfzZ/2WkhU70cf9vgU5ElkHe7Wz15zT9Cdc01ewlzix/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+CqvgHhusAU8DjzGxWv5LM9k9j8jPbIjF4SZG9vUQkhl5F9hn
	rkcikoHCtRXACuaCrp9N+uQZe5v2ngOIgyR5VqNCBf8e7D2qHKda02JwiuLkbg8y6VL5M4ftyvu
	pjA7Z7PlmxQLmNtDfh1Ye0r7h0YWQRzIWk2B5Cwkb9qbOo+bv2try6dIELMeG0/xhpw==
X-Gm-Gg: ASbGncsYaHERYylJwRjH8tbm6DHkACfYhxJiHFzBCFbKt4U83Uf1hntH4ATZuOowR5Z
	2qp1A4LxZaPUqU+5IWzjRMkXTABSaGPdFWoDI7/dwEmPIYDSViw3XP885g99WNWiq5FN+tTGDu1
	8BcbIDCtpD2n760vGSXhcOmdQEMUIOV7waIAznJ+lx8ixjl/b/tzNa9vWGhcY4W5o6a0AcCxIYW
	HjjUAdPuIPXyN5VKRzgvZ8+8LfYOS9ofE82Q8sPrr7HR8jv80V+HKDD8QD+NycOeWYIBv9vsdA/
	0fZURM4aEB+9KKQDI5HXLBXl+ser9EMVxWt472a2y4KXG92fLdHZWaZdVD0IOKpw03K6ahIhIbv
	U1ZQSZNhsAE/vJw2A3xd8rPJHCSZv0BjMjUvi9A==
X-Received: by 2002:a05:6a00:a256:b0:7b2:2d85:ae6e with SMTP id d2e1a72fcca58-7e8c1661812mr8017263b3a.12.1765220680026;
        Mon, 08 Dec 2025 11:04:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETR63z6lgWIYauKnGqR+nIlXaUyKmf3AysXIO96uJ5MtZ+oE030fEEOpOwNFljILUP/AFD0g==
X-Received: by 2002:a05:6a00:a256:b0:7b2:2d85:ae6e with SMTP id d2e1a72fcca58-7e8c1661812mr8017238b3a.12.1765220679598;
        Mon, 08 Dec 2025 11:04:39 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:335a:59cd:dd80:b6bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e7f42a43basm9128555b3a.2.2025.12.08.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:04:39 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH v2] fs: add NULL check in drop_buffers() to prevent null-ptr-deref
Date: Tue,  9 Dec 2025 00:33:07 +0530
Message-ID: <20251208190306.518502-2-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drop_buffers() dereferences the buffer_head pointer returned by
folio_buffers() without checking for NULL. This leads to a null pointer
dereference when called from try_to_free_buffers() on a folio with no
buffers attached. This happens when filemap_release_folio() is called on
a folio belonging to a mapping with AS_RELEASE_ALWAYS set but without
release_folio address_space operation defined. In such case,
folio_needs_release() returns true because of AS_RELEASE_ALWAYS flag,
the folio has no private buffer data, causing the try_to_free_buffers()
with a folio that has no buffers.

Adding NULL check for the buffer_head pointer and return false early if
no buffers are attached to the folio.

Reported-by: syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e07658f51ca22ab65b4e
Fixes: 6439476311a6 ("fs: Convert drop_buffers() to use a folio")
Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
---
 fs/buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..fa5de0cdf540 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2893,6 +2893,10 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
 	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh;
 
+	/* In cases of folio without buffer_head*/
+	if (!head)
+		return false;
+
 	bh = head;
 	do {
 		if (buffer_busy(bh))
-- 
2.52.0


