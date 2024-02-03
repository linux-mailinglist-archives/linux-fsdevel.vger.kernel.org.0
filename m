Return-Path: <linux-fsdevel+bounces-10118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277FC8480E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 05:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2071C21B03
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 04:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F141A29A;
	Sat,  3 Feb 2024 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F+q33Dq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DE10A1C;
	Sat,  3 Feb 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933458; cv=none; b=HkCr+IFP0OEsp3/OcRzJlObM6/4O7jSMJbCfUEq8r+4pruOEhLiGVhQmpZm1onqnNPMwpuoKyPPS2KrahwZR+zonHHlPwLKxA2gjUd4f5pWQ74hzJ6lZjflCsyvRVcBlvDo9fNUDhYNPkQFWOhDOTNFonvrv8NYEB5SRw/Db8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933458; c=relaxed/simple;
	bh=fMuJl4YD1Nm9Gs9AvL1fpNaEyP6uV5S3bqYHkKOBKsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfnyV9sHIZER/Sz6CDUjyf6ZdsVkDy8mYydBvqpUpM4Vyx7QbhCMQvdQMjEiZ2vmlrwBNqNHreOcxtVtNnNETzcm19I6YBROy0SpfytVMFZLVANUpSX1dcArJdoBLr9erL/N4JRhnpnoPHeiN0QMFclf3GY7ffx1zGSyBTAWiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F+q33Dq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A6CC43390;
	Sat,  3 Feb 2024 04:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933457;
	bh=fMuJl4YD1Nm9Gs9AvL1fpNaEyP6uV5S3bqYHkKOBKsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+q33Dq1pS2QdhPUGxZn21xX3xpswGyY8ieDXj1zBPvywSsrPrYU3f3pr1iT6o7+O
	 u14XeMC8mGs2hlmdIQbRljiG6EtcEzJ2/W3s2uxalkbONuOHz5xxLI3vbA7FInQauo
	 Zd/oM56J/51KE4SdnTQXtTEuNFbkyR1fNXfgN3p8=
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
Subject: [PATCH 6.1 194/219] tcp: add sanity checks to rx zerocopy
Date: Fri,  2 Feb 2024 20:06:07 -0800
Message-ID: <20240203035344.297241145@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 90e24c3f6557..86e7695d91ad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1934,7 +1934,17 @@ static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
 
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




