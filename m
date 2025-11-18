Return-Path: <linux-fsdevel+bounces-69021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9542C6BAC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C8B2829C43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D930BBBD;
	Tue, 18 Nov 2025 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="NZVdYLGk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824A30AD1A;
	Tue, 18 Nov 2025 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763499330; cv=pass; b=kfdL4n4ek/dBrua7qkKWWZDjS/9ttMhEN7XlUSmI/qqh9IdI8uvH3xpv817JCTxSkPEH2+SE8wvNDKavGg02sT0dzxclggr7SPG2KK2kf1Cg7zUHVv5hAed9bZsZ/nIPkEtYvEEXqYW6T7rTKaqaUoqzWgjEhznYja7w6/xfdcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763499330; c=relaxed/simple;
	bh=Xq4qDRmbDP+pVlr5sWlWyVhcZ3hM4CR/T+9UZ+6fnYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dATYBcf4uOe6AwMBkW+xwGUWzy1KwmBLpasqXX+mYEj8oivZbChTe73ukppVa0j9wY9OCHxFk4FEOhJfg05YFJkLN1b7mtfrLNTu1heKld6DjOqFaPrVYhBILPVQzYUwILFbaRpgQEiH4dSDXnc5arYAWUBXJAsjVoNtTo/elZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=NZVdYLGk; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4C5C36C0413;
	Tue, 18 Nov 2025 20:55:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (100-99-165-172.trex-nlb.outbound.svc.cluster.local [100.99.165.172])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B79F36C1475;
	Tue, 18 Nov 2025 20:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763499320;
	b=vJSme700mdiiCkTr6WKAQvEEuMaU0VweiVCs3VzoQ4Fh9AHXC90wuOzMN8z41RgmaTW2Vv
	tdm2EAe0B6ZBUlGxh/0R0keHDAOT3+vcxfFNhxXwWVCc3LZJ6mi2Xc28XSH/w7HSlNuwjE
	+Quph0Z0odbLARIHAMcP6ovNxqxGuxrv1nrmuMwx25cCGwT6XXP9IIAThH5xAEeAAzGCpT
	5u4Vc21QkjMZEA8ZmpfCi9NMLzxBYbcXlHb06a90LmREJuBD4mqzwrOVOfSLihijii2HKH
	BQKu6IAZFocRuAu4acgXnzgIrJbHoq6LAjaK7Zv9hD4j7kDOiNfQj8/2LSrySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763499320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=EL1AePT6eaN5str+b1C4iFrOYutDVihkRyucQoKhPmY=;
	b=7BAVa0O+Vs0JPodxdIFNOrPnq1/VXJGpQ0zkT4iJCRBy1nidlle1eRcoUy0YZ7/xtT3AHQ
	EAnSieAOM8KPIzsMOXDkeLbVCvbKKJ7sjkg2UZA5X4HHFLVrvVpxBEWj3KLpmRDvgocE4w
	fgtMiBmq170WahDN+po26s2sbZA4fG80Yf6VH7/7abnKWo58Ia2SstHsEcDl2QYz5QPIBJ
	54fpE+KZTHnAq8VDwwMO9cFkWa+9mvMMAW8ft8GeQLSWVhGnjvxVM+RH2sA+15C18zmjRQ
	8Lw3Kx1jbXGWNHwO2kHKvHkd5h5zB2Lt0fmv4ShfgqBrn5zOk/agIbqgIMubsw==
ARC-Authentication-Results: i=1;
	rspamd-5ffd6989c9-rtptl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Whispering: 48b075de3226c3fe_1763499321010_171570374
X-MC-Loop-Signature: 1763499321010:1474154271
X-MC-Ingress-Time: 1763499321009
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.165.172 (trex/7.1.3);
	Tue, 18 Nov 2025 20:55:21 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4d9xhS1fhCzyrB;
	Tue, 18 Nov 2025 12:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1763499320;
	bh=EL1AePT6eaN5str+b1C4iFrOYutDVihkRyucQoKhPmY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=NZVdYLGkqouc3HVSwoevbV7blur6NzPlnaVA8kOI6cYTGrsM9/h0VQJ9Ml/RraWxc
	 YOR5eLkGO3pEf1KQ73b4wl6h0tG6EAK1sQHhAh3Yg288TVk5AQd6mJUYSib4dlnP1/
	 vP7QCE3RYWKaYYiXBcqFjoqxdMAiruQ6jAxXBhArSHY6Yt2fR3OHbsDUWOymxTYQ3s
	 OjWWcjupv+4O7lSwlZA0uwQsw+gCUuhgaoL12fB/oN1y/P5DoLDE/VcV1dph0ngoX6
	 nGTxsaImhuLh2GbrV2LCyQXDS7ShaA7A5EyF1tdRVHvymv6mEA8XO6XYWV/Pfoq1pT
	 Y2hAMniIt9w0Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dhowells@redhat.com,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH] watch_queue: Use local kmem in post_one_notification()
Date: Tue, 18 Nov 2025 12:55:17 -0800
Message-Id: <20251118205517.1815431-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the now deprecated kmem_atomic() with kmem_local_page().

Optimize for the non-highmem cases and avoid disabling preemption and
pagefaults, the caller's context is atomic anyway, but that is irrelevant
to kmem. The memcpy itself does not require any such semantics and the
mapping would hold valid across context switches anyway. Further, highmem
is planned to to be removed[1].

[1] https://lore.kernel.org/all/4ff89b72-03ff-4447-9d21-dd6a5fe1550f@app.fastmail.com/
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/watch_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 7e45559521af..52f89f1137da 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -119,9 +119,9 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	offset = note % WATCH_QUEUE_NOTES_PER_PAGE * WATCH_QUEUE_NOTE_SIZE;
 	get_page(page);
 	len = n->info & WATCH_INFO_LENGTH;
-	p = kmap_atomic(page);
+	p = kmap_local_page(page);
 	memcpy(p + offset, n, len);
-	kunmap_atomic(p);
+	kunmap_local(p);
 
 	buf = pipe_buf(pipe, head);
 	buf->page = page;
-- 
2.39.5


