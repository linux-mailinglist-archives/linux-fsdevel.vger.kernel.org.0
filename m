Return-Path: <linux-fsdevel+bounces-49168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95520AB8E00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF333B454F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0C25C6EA;
	Thu, 15 May 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qCH8gG+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BD258CD8;
	Thu, 15 May 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330832; cv=pass; b=YHP2kn4rF74CtQH61+dWvDhp12/V2YtdcVcXDSXL8vL0H1aXhMbdoLwZ7jJoyVxF4dHQUYnzn133NxN7nL3yRKe1Vk/WcMBnX3hnU9qR69AXOzittVEMs9CYh9KEtgYJm0GQdJo3XBtT9AeC6q5U6KJaTS41LKXWe9yCI8zQIHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330832; c=relaxed/simple;
	bh=nIQGRX6UAtGnH+6wMi7KPiX9z3GVkhYEGLi9WOg8CGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsfYfIe9+sSHPTB915sdBm1l0fX63o3K9vxb3AdfTElVv+0RDIuBsQdmjiLuqv95WKiyHrI+4P7rIpsRdxt4BltW1r42Wbfcgfp2NnvmqI3Ltwr8FM7lVPGUvlwu+GFB6ItMDYjEd3GTayvMi7qvS5/9lomdMybNsGu9ilTqwsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qCH8gG+U; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3DF1225138;
	Thu, 15 May 2025 17:40:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.119.71.126])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C12902515B;
	Thu, 15 May 2025 17:40:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1747330823; a=rsa-sha256;
	cv=none;
	b=39M/fkEUYW5OXjo7JxwHwRPyxRqAFYswUUvjnidFL0vkorQIlDu2Rzw7lqt0W4rhtQjawO
	+MBIUgZg+ES1szvVAT7DD5ziJNLNo9XnhxgH6p11zqhxiHX8RlVdVdw/hTT9Jv+1OLvYnB
	Xi3N5C5KzieFrYdQa3C5rlQ9jjfmrZpBoMpGu+o0kgII8OxystDpkDIWjKEg+xh5UOrBqY
	Ww0XMaLaHmYryMRI0WXPAh96Dc2vKNo79VHL02D+FuZayV9egfq9qvy5vE8Pa7imLs690l
	idalcmWO3vCIx2iTsHEt+V25dvcTZJ5Wl1G1So2XVjcTIB+jceOrYZwYPw0lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1747330823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wwgNvKmxgKM/DoKzTas8oxSOF7Xy+ypxu8y3KI5VZHU=;
	b=F88/CLAV7s+0/Bi61JW3UBu8OLFF0L4xGuY4ZLM5aoB5C+2UUsCg4iqO+4gCO+OeyPZjcA
	1gMgM0POLy2659Dubr+Y4mmkNjK4LM7BG7bo6zXBqocrrMc6hA0bcpM1+j5Epo4J5igWN+
	n7UHyikDdQK1jW53PYU+rw0ZwPGoHLIo0cumDqaWZx3DpEjTL7CIXx/J7ZEgPM3pxLdRTD
	OnAZi0yRcRGJjapFLhNCzXP2SROhB2zvw1wHNOytmoLn8Y9Dg8ZSMdJLQoWM/zbiz5/uBk
	IemGVFtB/doNkSmwbdibZ86jnC9am3/BuVCwQtbvtM2lbXA7QfwknV6DUaEiig==
ARC-Authentication-Results: i=1;
	rspamd-57f676fcfb-gcktm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Scare-Zesty: 71f35adf4cefdf28_1747330824122_2458218250
X-MC-Loop-Signature: 1747330824122:1993011062
X-MC-Ingress-Time: 1747330824122
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.71.126 (trex/7.0.3);
	Thu, 15 May 2025 17:40:24 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4ZyyCq0r8pz6x;
	Thu, 15 May 2025 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1747330823;
	bh=wwgNvKmxgKM/DoKzTas8oxSOF7Xy+ypxu8y3KI5VZHU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=qCH8gG+UrfkQHLT/ItnCsdJzsrkMYFRuQxjDMbhGyLslquz6nqRkUKU8HdCdGx7/7
	 MtHcGcrSi7F1QsGZ9/28QxLqGLarKVtm/MBRj4vOUNrJHtMCoKazxYqTr50PLRl5Y1
	 VI+fL/wv7DlKMWaHR4hBz7oq/inbxh/Dtc2hfIApg6TVisfFaAeFoY9FDJsgdzKDFO
	 IcEw1zfLq32jn3fcPXbj+9MjFPg+KUPuWBn9PludqsuxeqBMk2TE2knOv7MkY79k+q
	 mF3lB+NeAQMO0F0xibHf0BuLEy8F7ovoIPgKyVKBz8ZvODEMq6wqwkJZ0oylPEX7bJ
	 mD0Oxbo1bVCJA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: brauner@kernel.org
Cc: jack@suse.cz,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	dave@stgolabs.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] fs/buffer: optimize discard_buffer()
Date: Thu, 15 May 2025 10:39:25 -0700
Message-Id: <20250515173925.147823-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250515173925.147823-1-dave@stgolabs.net>
References: <20250515173925.147823-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While invalidating, the clearing of the bits in discard_buffer()
is done in one fully ordered CAS operation. In the past this was
done via individual clear_bit(), until e7470ee89f0 (fs: buffer:
do not use unnecessary atomic operations when discarding buffers).
This implies that there were never strong ordering requirements
outside of being serialized by the buffer lock.

As such relax the ordering for archs that can benefit. Further,
the implied ordering in buffer_unlock() makes current cmpxchg
implied barrier redundant due to release semantics. And while in
theory the unlock could be part of the bulk clearing, it is
best to leave it explicit, but without the double barriers.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 210b43574a10..f0fc78910abf 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1616,8 +1616,8 @@ static void discard_buffer(struct buffer_head * bh)
 	bh->b_bdev = NULL;
 	b_state = READ_ONCE(bh->b_state);
 	do {
-	} while (!try_cmpxchg(&bh->b_state, &b_state,
-			      b_state & ~BUFFER_FLAGS_DISCARD));
+	} while (!try_cmpxchg_relaxed(&bh->b_state, &b_state,
+				      b_state & ~BUFFER_FLAGS_DISCARD));
 	unlock_buffer(bh);
 }
 
-- 
2.39.5


