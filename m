Return-Path: <linux-fsdevel+bounces-8871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDEA83BEEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E5CB2709E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F41CD01;
	Thu, 25 Jan 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUcqBvVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94C1CAAC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178801; cv=none; b=s1Qs3K0Vv5/FdRexPEgTpF5QynlIUzJkQYnbUvy5JYNwlJjBXstgVeqm4qbZALEqCJZNOFcU9xh8l8mUDNgdDzP9PXdJtOtxgVm//oO8aDWm2BhadYDLSQv1yXcNpvdZD3c9F425MZvRXqX0sICjiXUtmwDF6Spg4uSse4FtjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178801; c=relaxed/simple;
	bh=LCQTw6ZdRDF8AYm9OcpxBYpEr8+8nOOYi+KPo+/iL18=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TLWc3+nIhBhGrHcOucr0gzDtE9O2s1dMa6Wodp5d7kk8tFRwJKNrViHzdNoqkYxwttJc7BtD033AAphR3BgSY1IkZylHpuyfYXq2wlEkGFBY3w6yGJzdkdeo54rpm6f67BhhAd6ZQI8472WQIB7BIbcCdw390fIKAr9vazPUI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUcqBvVW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-600273598c1so59521207b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 02:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706178799; x=1706783599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tK1N/y0pyiaECWG1J0mgrmuRxERsUOnz7LlHhi7NqOo=;
        b=gUcqBvVWW39sayZsS//A5tle+jRFQnneMjtbu/6g0iNOyNuPg1IqZD4Ub0vm1HeCc/
         Lg8Fb6HM7qbMPCfs8dLbqdUcf775wOca+FyMbbToWWqNNGPE/pnc1tJ1C2DKv+9PzdQy
         5pniXxPQtMEfRPbPfTqjp/yw/CS2WvFO6htn0sCizSLqs2FkedNboFasi2OZ1sOEzlSX
         HneCFWNye+DcrJE/sojdk2woFpgZskFBI0IeS+Tl5FCVGMj3apElEO4vUxHv37bc99CL
         2DkIMhfQaxLBbOSnOuBMvgWUwec78lGpF9IN/sgfdiGMHKiInaEVlDSTGrXSLlGrog29
         98VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706178799; x=1706783599;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tK1N/y0pyiaECWG1J0mgrmuRxERsUOnz7LlHhi7NqOo=;
        b=GGmo40RsRZxiAteV3abkXPgFjNFVEilxeC4TSNBFgjQmnqNYGI1+8YGsjLDybkiupE
         4NRFn/iw50HPBQyNVnZvvkQI9wcZTSb2hrfv2LLMpDOpzIqlYn8LCysBgyniLB00/PqL
         szAYWFk7EBXXY3jAXQulHTLKqS5ja1Zmm2wk05wEjb9IWErrxhmv3f7WSUCtY79N7WJc
         80fFl7h8AaIdOyklQpQ0Ubs2ur6gs5MqHVYFfBYUS5wYDHyFae8aY16eRsUCuPz1DTGF
         Zo0DmZA3w8V7ec7nZnLclUAqsda/SiTWs3qlNaJCb5Bs19xYPljS+MgkiDG2X7Lt88t5
         C49g==
X-Gm-Message-State: AOJu0Ywh6Tq10yhJHtedePmpcr1suiKN+OvB/w81b6nb7qDHS3JiaubG
	P7ZaarXYiuSVB7CzX9jZiW7vMece+T0wBYKF2ll+HtL1figq9TRlFag+zlp3B5tiJ/2q9UF8NTU
	PMol06ObY5A==
X-Google-Smtp-Source: AGHT+IHrhjnyBqaXd5hU0kooD2xPoRGYqEfhBzinKtDpI6JwUNc0nENP8L7NSP3YoFXiuyanIAtZsdL4yxF5VQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1610:b0:dbc:3003:a135 with SMTP
 id bw16-20020a056902161000b00dbc3003a135mr393537ybb.13.1706178799137; Thu, 25
 Jan 2024 02:33:19 -0800 (PST)
Date: Thu, 25 Jan 2024 10:33:17 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125103317.2334989-1-edumazet@google.com>
Subject: [PATCH net] tcp: add sanity checks to rx zerocopy
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, ZhangPeng <zhangpeng362@huawei.com>, 
	Arjun Roy <arjunroy@google.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

TCP rx zerocopy intent is to map pages initially allocated
from NIC drivers, not pages owned by a fs.

This patch adds to can_map_frag() these additional checks:

- Page must not be a compound one.
- page->mapping must be NULL.

This fixes the panic reported by ZhangPeng.

syzbot was able to loopback packets built with sendfile(),
mapping pages owned by an ext4 file to TCP rx zerocopy.

r3 = socket$inet_tcp(0x2, 0x1, 0x0)
mmap(&(0x7f0000ff9000/0x4000)=nil, 0x4000, 0x0, 0x12, r3, 0x0)
r4 = socket$inet_tcp(0x2, 0x1, 0x0)
bind$inet(r4, &(0x7f0000000000)={0x2, 0x4e24, @multicast1}, 0x10)
connect$inet(r4, &(0x7f00000006c0)={0x2, 0x4e24, @empty}, 0x10)
r5 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
    0x181e42, 0x0)
fallocate(r5, 0x0, 0x0, 0x85b8)
sendfile(r4, r5, 0x0, 0x8ba0)
getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
    &(0x7f00000001c0)={&(0x7f0000ffb000/0x3000)=nil, 0x3000, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=0x40)
r6 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
    0x181e42, 0x0)

Fixes: 93ab6cc69162 ("tcp: implement mmap() for zero copy receive")
Link: https://lore.kernel.org/netdev/5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com/T/
Reported-and-bisected-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
---
 net/ipv4/tcp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a1c6de385ccef91fe3c3e072ac5d2a20f0394a2b..7e2481b9eae1b791e1ec65f39efa41837a9fcbd3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1786,7 +1786,17 @@ static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
 
 static bool can_map_frag(const skb_frag_t *frag)
 {
-	return skb_frag_size(frag) == PAGE_SIZE && !skb_frag_off(frag);
+	struct page *page;
+
+	if (skb_frag_size(frag) != PAGE_SIZE || skb_frag_off(frag))
+		return false;
+
+	page = skb_frag_page(frag);
+
+	if (PageCompound(page) || page->mapping)
+		return false;
+
+	return true;
 }
 
 static int find_next_mappable_frag(const skb_frag_t *frag,
-- 
2.43.0.429.g432eaa2c6b-goog


