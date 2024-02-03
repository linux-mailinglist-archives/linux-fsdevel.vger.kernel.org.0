Return-Path: <linux-fsdevel+bounces-10122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0984839F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 05:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBBB1F25625
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 04:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99355798;
	Sat,  3 Feb 2024 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q13cUmfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EBC175A7;
	Sat,  3 Feb 2024 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933966; cv=none; b=pg7lA0aIKjUxSwHkcbMqn491pdBJcA47UPfqyOai0cuy9yvo6bk7mbKvla3SH3hI9FLg5PAuex6AAkIGNi0HytnUH1aEWNov8dGySK5cycLi7DdfvrizTZyhbXKevO7sjukuqqu57RBzlbBTren3O0FVAZ33FqdkFL6PXiT5V8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933966; c=relaxed/simple;
	bh=RiXyXNhymkkvviQSNnwYpVOPEA0ydlZ/XETrFgRqA3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3kDUtweGSfTCZqn3HIgjKFDjzJ0pTd+zXzh0NiZWOOtujpQCfN8Tv/0KNAklvr2mreEqsYIWxqEe5Q9Tp4pNZB6aveVTJe21gv88Jn11GqnZvOCEeTHpaNidKq5MTE9UDmEpmNlAUQsoQze+GaMs5LgDTOXC9vnmnSwVvQz/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q13cUmfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBCAC433C7;
	Sat,  3 Feb 2024 04:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933966;
	bh=RiXyXNhymkkvviQSNnwYpVOPEA0ydlZ/XETrFgRqA3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q13cUmfeFf76O0pnMQ5O6jMsDrivHLJNZM0PiXNRwglNMRzrwfItDf1LYBgjvrj/f
	 lol9eMOtaZwbcQwu/Io+TQiY1HXICOo7VBNqdKWz69A8Z0jnr5wtTwo7Gaa3z7H5q6
	 pjIpSAgYpCFmOFQR2bBsvdf+Tj652+n4NUFS9ypQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Arjun Roy <arjunroy@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH 6.7 312/353] tcp: add sanity checks to rx zerocopy
Date: Fri,  2 Feb 2024 20:07:10 -0800
Message-ID: <20240203035413.711094580@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 577e4432f3ac810049cb7e6b71f4d96ec7c6e894 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7bce79beca2b..b30ef770a6cc 100644
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
2.43.0




