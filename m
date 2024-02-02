Return-Path: <linux-fsdevel+bounces-9964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3114484692F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 08:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA6B282F4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 07:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96282179A6;
	Fri,  2 Feb 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sEsgcANs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09717995
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858489; cv=none; b=QOcOHnL6Ee/HQrHdCP1CwMdEH1qr4J9vjl6RSiH/Mu6zMsp8ogh5AZuoo8NfUCNHqUY2zkLPf4FSNDzl8hMz5hMIdOn88sR7UaCj3Zf2VKr17TA+ZgC+llnGryP18SSHDVtpNMohxnUeKrT8lQZbR/hdavRUs6f8SADOqOB7/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858489; c=relaxed/simple;
	bh=No754Jz1QHm6Yj+taJGvUjVB50odVD/JInOlQcvkHhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iVmyeJPNX/4bZUqlyhhIWdZtVjQ6h1z4isKMfdY8LRFpYgb9rm49RJtBJtDLkeWSd0Oyp5B0mz61Lf0PD3P0yQL2QE+VYBBeJYTSgMdlRIzN8RGItl5X5cdEEGW4BVnp8fTQZqj6MqsPg2i5wazYrVx3zPepk3YPoKFFB3+FlFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sEsgcANs; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706858487; x=1738394487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=No754Jz1QHm6Yj+taJGvUjVB50odVD/JInOlQcvkHhI=;
  b=sEsgcANsn3tOQVIg9GOdxqREQOzqxetm56BfG913iIlOm25sjY44FOPg
   KnCmML1KXz5h7BZQUug4Y4Hc/Bf9CHPduq3x38L/dpb6sAMDWIplrRM0K
   +edzPtDq2Y66EKm6wvpOxDTjKb+OzN4Zo7s7Li6FbCwtqM+wsTSEWwtxn
   m4KFapdHMeJLN90ZqIjYCkAgTyjmZk+aoGEc0fRJ+nG6fZ96gC4D48Hbi
   QsW1iguAo3gGAzjWjGxBnUzijRyIOWbnm3b0adAMsNuX/Csjb1wY86OLo
   7ZzAmZof6nD+4gddLGUlZDKtsRPrBEmRjmOe9I1SMVPOzUmPvSfNDUGPx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="149854678"
X-IronPort-AV: E=Sophos;i="6.05,237,1701097200"; 
   d="scan'208";a="149854678"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 16:21:17 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B26CD77C61
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:21:14 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E376A10713D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:21:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E57210208
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:21:13 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6E7361A006A;
	Fri,  2 Feb 2024 15:21:12 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] __fs_parse: Correct a documentation comment
Date: Fri,  2 Feb 2024 15:20:42 +0800
Message-Id: <20240202072042.906-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28158.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28158.006
X-TMASE-Result: 10--10.344400-10.000000
X-TMASE-MatchedRID: m5YRaeAMZa4kinkyECdW8wrcxrzwsv5u3hng3KTHeTZffSkyb6LPSL8F
	Hrw7frluf146W0iUu2vJzjbZ5a3RIMQmX0k7dptp5CghTisABMwxLxDYO3UlDJsoi2XrUn/J8m+
	hzBStansUGm4zriL0oQtuKBGekqUpI/NGWt0UYPDQJJl8Ww/Uptojs3ztqI6udeTbGD6ltEtXB1
	RACvqmQ7UAzM040TIQ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Commit 7f5d38141e30 ("new primitive: __fs_parse()")
taking p_log instead of fs_context.

So, update that comment to refer to p_log instead

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/fs_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index edb3712dcfa5..a4d6ca0b8971 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -83,8 +83,8 @@ static const struct fs_parameter_spec *fs_lookup_key(
 }
 
 /*
- * fs_parse - Parse a filesystem configuration parameter
- * @fc: The filesystem context to log errors through.
+ * __fs_parse - Parse a filesystem configuration parameter
+ * @log: The filesystem context to log errors through.
  * @desc: The parameter description to use.
  * @param: The parameter.
  * @result: Where to place the result of the parse
-- 
2.39.1


