Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57FFA970AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 06:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfHUEEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 00:04:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18789 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfHUEEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:04:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5cc2ad0000>; Tue, 20 Aug 2019 21:03:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 20 Aug 2019 21:03:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 20 Aug 2019 21:03:57 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 04:03:57 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 04:03:56 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Aug 2019 04:03:56 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5cc2ac0000>; Tue, 20 Aug 2019 21:03:56 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Andy Whitcroft" <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        "Gilad Ben-Yossef" <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>
Subject: [PATCH 1/4] checkpatch: revert broken NOTIFIER_HEAD check
Date:   Tue, 20 Aug 2019 21:03:52 -0700
Message-ID: <20190821040355.19566-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566360237; bh=b0DVOtsBG53vqmQyIWzNnfUqAU65Pon9C8BrFwFcc1M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=RCYmMjup+49b/+zlM0P/oVeE+gZMo0wjyYY2EUAhT1rekOgnfipguhjJHZ7SBUwr+
         pA8/CDo2+IUJmyYtpK8ZnPHRk2seQr5lND0QkjR1ZMaqCQbH262dqNVO+054zFEbK8
         uT1cXvR2T/upHLCdRwlLnU0fef5Fv5lcInQ5Cfysp8XIKy+z4tGs9wj2VtdkhKSfYf
         k7b+QtXH4UP+aWWme7vPSCeQi5BYwUuyup4McTAZ90K3ZlxcpxwdEdVIYvsR97Tpu5
         7QZCtVVMikBs3kYXP0ChmL0Bf1c2nZv8olUfiEi1ld5I/1Fk38nFdgtANUfGh9Pioz
         BJhhcSmhgBkLg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit 1a47005dd5aa ("checkpatch: add *_NOTIFIER_HEAD as var
definition") causes the following warning when run on some
patches:

Unescaped left brace in regex is passed through in regex;
marked by < --HERE in m/(?:
...
   [238 lines of appalling perl output, mercifully not included]
...
)/ at ./scripts/checkpatch.pl line 3889.

This is broken, so revert it until a better solution is found.

Fixes: 1a47005dd5aa ("checkpatch: add *_NOTIFIER_HEAD as var
definition")

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Ofir Drang <ofir.drang@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 scripts/checkpatch.pl | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5c00151cdee8..284eb4bd84aa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3891,7 +3891,6 @@ sub process {
 				^.DEFINE_$Ident\(\Q$name\E\)|
 				^.DECLARE_$Ident\(\Q$name\E\)|
 				^.LIST_HEAD\(\Q$name\E\)|
-				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
 				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
 				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=3D|\[|\()
 			    )/x) {
--=20
2.22.1

