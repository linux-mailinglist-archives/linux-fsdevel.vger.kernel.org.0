Return-Path: <linux-fsdevel+bounces-49171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A45AAB8E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734C0A03C95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1225A347;
	Thu, 15 May 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="aCNVo9La"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7A15A864;
	Thu, 15 May 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331997; cv=pass; b=J8phrlQzIRmD/hpW9UH0EdMbO3D4d4PXsQjXvqPLflEeYXpiCoYBaYtlp1uzh29OyLwpLvXeOvs3PLi3iWZm+Oet88ZfTHM8xij47Tv8RGJTIaxHlPhAuJGkHspI66MyVS6F4rOPMpRkIfUZ6HKlDQzZrh+5sKd2YHqPxj5QWYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331997; c=relaxed/simple;
	bh=amDHGlMvSjEKVQALOHFxFuvQdoY8pqyKAAITgnMH6lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aWFFu/iTJ10wGXou4vF+uN9XdB7yX9vuczND9qBB4moXqjN6BBki+1iPSIXoMtfmfTD8LKJWqNCZmnXNaWdMk1Ceorj8/KoAuMLxNzSwQ7HCVS88ajgQuF1hYniHj617FibO0rByWXadJBmfiuhhZe3U9ozyAjRTowF1f5GD2FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=aCNVo9La; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 704928A3B93;
	Thu, 15 May 2025 17:40:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.119.71.126])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 84EB88A468D;
	Thu, 15 May 2025 17:40:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1747330820; a=rsa-sha256;
	cv=none;
	b=wWTJDaUMKrOnyvsfNX6xivzkT3I3l5veYmhUNrgfWZg6iRMQ1Ftglwe/cvN9RXf+6YYYQh
	9hEbHMMlwPXLmXaXTgoa+TKiZnDMKVjeYgtxI+JHHaRrwF5jsGJHdurKAothpiEoRGaWc6
	h4aMOSN4z3bQuTad/jIWVFYpasUxBIJekU2oj3HOwUBxQfO5/ep7ZHcsvl7jYXjseRouKO
	FDLoTuG2kD6GFqMqHgwqqSaOeX4uYKSjxdcDwKbnIwTK3YpP2lffARzCwA0lSOo9vRwEzO
	eA+krXJ9kWjEfxJri/v9kRndObmVqpTB4V85YiAnx3tnjag7wTCp7/UboOkV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1747330820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=RO1/5CPxbmfPbTpKNGGih4Jezta7YcyTJ8AJ0pYn4ks=;
	b=w4gjDkF4mp955wh0ar8UtDB7HEX+AzExBTkkLJGBxM/nh6RibAcv4eithQgDHZVUZSzfJC
	40IT6rODUYyeS/pkJVfeMQZB5ShV+yOCNTwUDecUG4dD/zmFLpCvHdp7OrZFB1Uw4rK8ET
	2ZcktZ/Uq+VPlzIMbT2BjvgDY9aS70iMAD5TdzgTRh14DFr0NrCQnzXAchfRIRMECjd1L7
	SKRCrIMJ69NqAzxb8U8OusFXB7O5wEUHPea/NQsf+hUqZRgQ0QFL18U55nMuQVJ8W8VrlP
	rGWk9nFNZgQ6UPZFPhar+V2iRcA2qoU7d/9wSkc7bV4of3G7bJZAJfERsO9tRg==
ARC-Authentication-Results: i=1;
	rspamd-57f676fcfb-98zpx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trade-Juvenile: 7d6c232025689071_1747330820964_1279636720
X-MC-Loop-Signature: 1747330820964:286410917
X-MC-Ingress-Time: 1747330820964
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.71.126 (trex/7.0.3);
	Thu, 15 May 2025 17:40:20 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4ZyyCl3LLWzCS;
	Thu, 15 May 2025 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1747330820;
	bh=RO1/5CPxbmfPbTpKNGGih4Jezta7YcyTJ8AJ0pYn4ks=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=aCNVo9LaG4taBiGlGTWHkm1bZpRrSl+0N58MQBg0P9tA7hz68WCiJDT2frz2lf1TM
	 +njXu62rg3UA8SAlaub7kB8KPV4mzoSh7uFgZtsRGOW2u7pP5tWIVHiPm+LtxI4fRT
	 ervs0TS2nchKq0hirYwoznKXAFcnTBwxkf1DnE6tKuREiawt4fedUYRLAq44q82l/R
	 mZdfRBH3fuD5CxZ/JPB4XgyQadFEog6x2Dp1tqnzEGTJYEreHbru2/4XDbwp8FgJ8f
	 5wZcYTh+ZvsNg8C/9b/pLdwFPfOsLR8rYNoti1YKUlLlSzVO04Fa/8qT/hemdo0Dl1
	 1HrMAOL3Uir+g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: brauner@kernel.org
Cc: jack@suse.cz,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	dave@stgolabs.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/4] fs/buffer: misc optimizations
Date: Thu, 15 May 2025 10:39:21 -0700
Message-Id: <20250515173925.147823-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Four small patches - the first could be sent to Linus for v6.15 considering
it is a missing nonblocking lookup conversion in the getblk slowpath I
had missed. The other two patches are small optimizations found while reading
the code, and one rocket science cleanup patch.

Thanks!

Davidlohr Bueso (4):
  fs/buffer: use sleeping lookup in __getblk_slowpath()
  fs/buffer: avoid redundant lookup in getblk slowpath
  fs/buffer: remove superfluous statements
  fs/buffer: optimize discard_buffer()

 fs/buffer.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--
2.39.5


