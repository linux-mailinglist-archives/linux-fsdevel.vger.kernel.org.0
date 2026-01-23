Return-Path: <linux-fsdevel+bounces-75328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ETBIIELdGkQ1wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:00:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8987B923
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE4F53012CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1322DE702;
	Fri, 23 Jan 2026 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahJHZnn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50923182D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769212798; cv=none; b=plC/2ytrtvhokOtOZ3SQGTlOan2eYl0JX44kaYULmJTRKMaba11WWY7KPVcRtT4i23qTx2bUjuqX/+dOI8T7n22Hvc/Qh5KGX+Lh3QIaZUbPjCdBNr5BGoa82L6do7uLsjLyofFarZy+0GFsc0mRID9h1SbN4mne8WqPj2PNZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769212798; c=relaxed/simple;
	bh=VCQ13tUHabn1a8CYUANPuHS4delWNiuzcR7MAabHMik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mH9lDv/13xUAsv08CfTyEj7GBxZRDohabAaCx9dNkWsboH61KBTZnm9swz5Og0rYbc765MZKLuwKz7i7gIknKNPqevZVLn6y6FZjX7dJl5RrM4Bp3LBcXUYT7NntRl4lrYaesDaNleaaF330ksZjK8mshp1nwXwWKvJoWKJ0/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahJHZnn1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8231061d234so2116234b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 15:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769212796; x=1769817596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZcTtrop+c+0UXDchl7Gn/AnReUfUdZU0vP2N+Pirfs=;
        b=ahJHZnn1YsbjeQx/UWkOwllvN4L9cNU1aOloiEj4cNdnGxauOQw/FOUhqxPAWQMnZp
         gqtp89nvQ2rg2AHevGemnLQEhrnqgv1SUNJJ6ztT1QexHmIIH8aapDTU2nBE3iZ2HNbz
         lXe/F9L2XiZTxzNohrawCX5nGA/mRzWnW7ulhZgj0sGlHzuZoK4GGwPaONurgXw1GR96
         NS8cuoi7aeh1oduZeo/LJHljM3m+yBdgJH3w8OZOUlguOBCGdmow/whXfWoPYzCnea3k
         EbKpdZ+lEfBDsXNL2NlhML/4wq+okKKuXOs1V0zZfcR6Cd0ZGIqEHisfWnZp9gxRTCZZ
         MOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769212796; x=1769817596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZcTtrop+c+0UXDchl7Gn/AnReUfUdZU0vP2N+Pirfs=;
        b=gU81Ff9gZUyjVb1IEkwNHbvQ62nAcV6IoyEmLYnLIUvpDiD82aY3HXX9SUudRDHqVH
         ffjhRv7tm1RDI/+6hKlLWMLe0dNzx7UCMiQPKY/GcrvqrELybf4bbsMT4zjyxp0mI5sI
         vLHw8ZvR38CVHx7OIazQ9bneKXPKyKuz3/AHpoUpnYnnS/W+tl9M1S12lFh5ZcTkFLle
         W4CPdTLaXVCMzDC6lsCEV1t0SnlKHNVPpTd9q4v6WLQ70HD8XccRIoKGLW2mHu89eiHK
         KPP/M2DTqSIJR1iqSP3rR1c6jJqBoUMaERs4fVbnFLTkLswIoeim6w7yIsF6F8BaHinb
         R5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXb3Hl2wcBA31yUbGoHWzPYPgzT4fa7rMHbT0HAgkNcgC6kk0MqUjnJY2Rwvc4Bo9edBVQZLRrm+LAkHsFb@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxciGUjKs1S00C0t2kLcxrNGjw/62NRCdXU5h08HO6sUCt406
	sh6kpKCTbtHp11qKL/vTBuWTLHGlz+p0K255w5rvT9AmbzRi96Hj1CXt
X-Gm-Gg: AZuq6aLimVybjTdvMo/SfBgfZ6dA2xDcGtty9ECoBJAuqZRNyqsxY020XGxSW23fJCw
	I+JRJ7qhSLC27R+aGymOagqoAdFqkJ4/wDn63zlbW1kbPanIzzhvOIHhfyQX6fOIdJ4gIpZmm9H
	g+jpqxld5NNELwHQ/tiVtKvanxO0YZqGI6LnJH6GF5A56A2V2HUdIsB5oxt3wr9RpWGHurZYzH9
	hk1Ml9biHiSNMPf9s3wDTb6bIKrx4HTgfzeKO1GANHVLuprXuimqZdu1mQmDhd6iiAgUjQ7o1ru
	vUnpquDGHJfmG27dYj3oqH1/hk7nkvNt54DrV7XAqyQgwvslTXp3Z3eYSa3nEyWyWhuByzHj6x0
	516xoTdL/DK43qIjJr1gTry0CKw9VOwDOmlRmGFGtNmp4Dn+GZ9hWMoZK/afcgRh9svpkWXodms
	s03RVYSQ==
X-Received: by 2002:aa7:9065:0:b0:81f:adb3:21c7 with SMTP id d2e1a72fcca58-82317d38c07mr3859704b3a.22.1769212796262;
        Fri, 23 Jan 2026 15:59:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318648ff0sm3146219b3a.11.2026.01.23.15.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 15:59:55 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 0/1] iomap: fix invalid folio access after folio_end_read()
Date: Fri, 23 Jan 2026 15:56:16 -0800
Message-ID: <20260123235617.1026939-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-75328-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC8987B923
X-Rspamd-Action: no action

This patch is on top of Christian's vfs.fixes tree.

Changelog
---------
v3:
https://lore.kernel.org/linux-fsdevel/20260116200427.1016177-1-joannelkoong@gmail.com/
* Make commit message more descriptive (Christoph)
* Also remove "+1" bias (Matthew)
* Account for non-readahead reads as well (me)

v2:
https://lore.kernel.org/linux-fsdevel/20260116015452.757719-1-joannelkoong@gmail.com/
* Fix incorrect spacing (Matthew)
* Reword commit title and message (Matthew)

v1:
https://lore.kernel.org/linux-fsdevel/20260114180255.3043081-1-joannelkoong@gmail.com/
* Invalidate ctx->cur_folio instead of retaining readahead caller refcount (Matthew)

Joanne Koong (1):
  iomap: fix invalid folio access after folio_end_read()

 fs/iomap/buffered-io.c | 69 ++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

-- 
2.47.3


