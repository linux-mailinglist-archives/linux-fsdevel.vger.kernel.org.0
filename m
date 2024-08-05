Return-Path: <linux-fsdevel+bounces-24987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B52E947881
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B800B1C20D9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B515573B;
	Mon,  5 Aug 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j04t36xV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CF154BF8;
	Mon,  5 Aug 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850583; cv=none; b=opYu9kZjLtrTqJV5eEnuzKVD9VDpnPoiKwFfvdf12CPFmZWiyE35uFkTcfS6R8NSPnpgA9ivnBkQBU0rJoF6nYU4cYHfvDByEj9xgIft8lVB7AnSCqLbwG5QAeZm9alTDAVceFqgAkNAVTm0OW2jTPSfTLfBwmn8aDdamYkGAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850583; c=relaxed/simple;
	bh=aId4i3+f2oT9WZCHDhoMCMyZw/EFhFEq6i9DKsHg5xU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3+1yDjDZm6sy1z60bQxs1OS+3gwOkOSrCsKY9DbySs44IypaDjRIA7nSTS4iomdHjgDnmTDYHNrLhjeyhDgVsF4B5zPFZlx21iKsL5iLGOCME+YoMkoDejCbd2tipp+xJwRhnP37eLusVP2lLxXQ2PQIuk5PY2kPcVp9wZvdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=j04t36xV; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850582; x=1754386582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xIwlsPdKypNAzAdQV72OSHi8d6jH55QygowoOsRKvhI=;
  b=j04t36xVSDhserkIsv3/6bC9mLu2kZXjJh5IGXYB8c1/5CTHKz3Yom3B
   KRRa6lV4W8Hgzj5Da4J7mP9VHx5j/sOh2GpSA9jMPoF14J6NhfdqgVlAL
   DjVjgv3OGcp/jaCi5qIaq4xUOt2FXq3wt8z2pEkX1yJ7VMpfRqSOQngfu
   A=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="672011613"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:36:20 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:42749]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.69:2525] with esmtp (Farcaster)
 id 9c651255-34c7-4aea-a776-f6d2f5be7b32; Mon, 5 Aug 2024 09:36:18 +0000 (UTC)
X-Farcaster-Flow-ID: 9c651255-34c7-4aea-a776-f6d2f5be7b32
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:36:17 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:36:08 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: James Gowans <jgowans@amazon.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Steve Sistare <steven.sistare@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Anthony
 Yznaga" <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, <linux-fsdevel@vger.kernel.org>, Usama Arif
	<usama.arif@bytedance.com>, <kvm@vger.kernel.org>, Alexander Graf
	<graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant
	<pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Subject: [PATCH 10/10] MAINTAINERS: Add maintainers for guestmemfs
Date: Mon, 5 Aug 2024 11:32:45 +0200
Message-ID: <20240805093245.889357-11-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805093245.889357-1-jgowans@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1028eceb59ca..e9c841bb18ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9412,6 +9412,14 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp.git
 F:	drivers/net/gtp.c
 
+GUESTMEMFS
+M:	James Gowans <jgowans@amazon.com>
+M:	Alex Graf <graf@amazon.de>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	Documentation/filesystems/guestmemfs.rst
+F:	fs/guestmemfs/
+
 GUID PARTITION TABLE (GPT)
 M:	Davidlohr Bueso <dave@stgolabs.net>
 L:	linux-efi@vger.kernel.org
-- 
2.34.1


