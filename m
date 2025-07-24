Return-Path: <linux-fsdevel+bounces-55954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E3B10E79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F25DAC6534
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B72EA461;
	Thu, 24 Jul 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ppoOmU2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BA2C15B4;
	Thu, 24 Jul 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370227; cv=none; b=m7BE3+My+lyXGJ++i4N2d86VPp7hdQ95THsHd+1DILr/DZDqvaStzVg2WIHpaqwPBZNwttMsw4gpwj6Ewf+5EGrE1R2PcpK6KTVADD28NzIDHhi5VeumGWCJdWsMrKzp0SWXIIh590BBL7T/OGAE7FOiMApJ3jwBK4k6/SKmssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370227; c=relaxed/simple;
	bh=uJzdGUBtBgVW8BdZUFfCCfm2zVes30Z48ZK35qOdPZE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IX75Aq4D5036+B7oP1+i6btaKBGu5l1fGnx7NIzSpZPWHnu9wqq2SYIu/aD20s6D/NVfXabyTEUO6EnlkuQt3Tw3gPqSQvai2P4UHVPaL6P8o9ZhvOy8W4pU6HdYmOuGOV8sAgc9T1FnK91BoiUw+c1RGcdrJBobsiYwNo68w90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ppoOmU2x; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753370213; bh=6bvvqlpAyY79RK+sigJVkCZdDmBjNUAbhE8K4FBSbPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ppoOmU2xW5RZ8arwjhi0lN/+FOoKoWDdCcF/IEw4kD/BRz9rMuqNtmPnPMnaSkmbv
	 HH1WwuxrOae7lqcTtL1hmZ9kukgdIlYVDiLPcIc22iWrrqJ9t5C6x3JC1KNO8gqiMU
	 MX7hRHyRDAqkjnRouqmRwD+EyTj2qXV8139zV0bo=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 2199CEA2; Thu, 24 Jul 2025 23:08:25 +0800
X-QQ-mid: xmsmtpt1753369705tlfk7bzra
Message-ID: <tencent_DFFF86C192DEC64EC99B6EF96EDE4C986706@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahYieLnHxjb3blod5K9WyF3LD6sJikRBWE38rp70KalLI+36X4I/
	 OVuAuNnVMb8BUXKgrqz6MhkWNpYVQB9YLb0qIWp2T0kM+fElAypjLcHnDaxzsST5ioQogU8yiiY2
	 rEXdecgYQmB9CJe1odmAtLspa4TOR4RIxiCEJ/GPQ6kOYsvxiXZNnsQwCEPqORBxludN+F1dRHwk
	 relicG3ZMZxVm90S8yz6tKseIDscVHmldg3BUQGft+npH4r548lPKaq/bB95zRMTluM74x4Ddz8u
	 SzIlARX0d8pk7Dh3n4RUmh5e+E8W5xu+6Lg5v9jOgKX87S60aiK3SSC1XmlP4XKaVhiCRBOiP41m
	 ooEa6MpYlvQAbQow6FFVXeBIXpCUaxrxssOUOW+VgQ12DoDDhjOJ+tJ/xL2NcDZOojQ/mZ3DfG5X
	 2CJNDdyJ7VDgidfiDcVW0zmTOExIPbtv975D3bIWeam7LlRCRFDq5h6Ivskz0qzEizF95um3sthU
	 egtcfK+ZOeJvx8BhRiuN+23Y6BaFQos/s5xf30NVdRj/kd+p8i2TZfOO+F6bZZpHfvJzBbL0zN5N
	 Pj6JcNS9thMnxbgcSuOAYaQSGs6iFtdknV6bxFrPZ9R3qJ8GR7Am3bVsgIiCLvXtWDeGAipGQ3xz
	 GKSt47kCk0pl8TazJDs2a4tNhtC2fTUHlDnds7N7FJ4imhB0+6M148/SMViOBYQ7ceobnSaD65Bz
	 J3yPT/6W1na48i7sUXeWA0EzZllPQ8u+znBMz8L8EukV7foI/gVBY5UikYxrnhn5LWhkX4UepYF1
	 UZnuWHZ6gmaVhwQk9ZCizT8QE53tumU2pIUD+UAqOL08KV7uCfEV76SN+5CcVyeA+Mp75PE2iZsH
	 Ye1PYRgFkHmHXEwNrwZ0vX1UluWCpErn1gQf+bC/HaYctmHErQmHfsTNtKsocsTGbSVCbs93txWB
	 okSW+hJ/R+fknxcWm8XSvJKVa5IC0IhBsB3y0+0HklxYHSSbBGgOgPXsej2ZOS
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfs: Prevent the use of bnodes without entries
Date: Thu, 24 Jul 2025 23:08:26 +0800
X-OQ-MSGID: <20250724150825.763872-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68811963.050a0220.248954.0005.GAE@google.com>
References: <68811963.050a0220.248954.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the number of entries in the bnode is 0, the bnode is considered
invalid.

Reported-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=41ba9c82bce8d7101765
Tested-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfs/bfind.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..1d6f2bbafa7a 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -133,6 +133,8 @@ int hfs_brec_find(struct hfs_find_data *fd)
 			goto invalid;
 		if (bnode->type != (--height ? HFS_NODE_INDEX : HFS_NODE_LEAF))
 			goto invalid;
+		if (!bnode->num_recs)
+			goto invalid;
 		bnode->parent = parent;
 
 		res = __hfs_brec_find(bnode, fd);
-- 
2.43.0


