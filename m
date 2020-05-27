Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7431E4E8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgE0Tt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 15:49:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6834 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0Ttz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 15:49:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecec4100001>; Wed, 27 May 2020 12:48:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 May 2020 12:49:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 May 2020 12:49:55 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 19:49:55 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 May 2020 19:49:55 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.87.74]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecec462000e>; Wed, 27 May 2020 12:49:55 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] mm/gup: update pin_user_pages.rst for "case 3" (mmu notifiers)
Date:   Wed, 27 May 2020 12:49:53 -0700
Message-ID: <20200527194953.11130-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590608912; bh=+JO9SzIVC7F8gI8jTFzEl6QoxL/thoNHpxziO/PBuik=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=RbHn4yG2kSWbcFxzxdHvbZj23GM1l2XQ9OV43KKqB5pYAAx0dqZbie/A8Lqe7iA8N
         D3Xv3j5Dm16ONLL0bFQGcsZX3X4x3NSRsWwXzknqY5esUouiyjwcd+WKX6bK0z6bKX
         tZtbIaYr6XyQwN2CqThSIgUKjVbBXz6zPp/kZYHVvhMmqCDVtvxfowJXSBcWsNsDqW
         hVMwcZZQhRR1I3NPHeiEdBXN5rXNrcT26/g12MndJ67DRV7Zu3sjBM/mvEGn/48Kif
         af4BZjhcPZeI6WEHMUpqJ7u/rJpAGCQXIpF5RdLZ/7xEwHgAyHYet9n5rrzvxrOVRS
         mwUAVRtqviZqg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update case 3 so that it covers the use of mmu notifiers, for
hardware that does, or does not have replayable page faults.

Also, elaborate case 4 slightly, as it was quite cryptic.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst | 33 +++++++++++++----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 2e939ff10b86..4675b04e8829 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -148,23 +148,28 @@ NOTE: Some pages, such as DAX pages, cannot be pinned=
 with longterm pins. That's
 because DAX pages do not have a separate page cache, and so "pinning" impl=
ies
 locking down file system blocks, which is not (yet) supported in that way.
=20
-CASE 3: Hardware with page faulting support
--------------------------------------------
-Here, a well-written driver doesn't normally need to pin pages at all. How=
ever,
-if the driver does choose to do so, it can register MMU notifiers for the =
range,
-and will be called back upon invalidation. Either way (avoiding page pinni=
ng, or
-using MMU notifiers to unpin upon request), there is proper synchronizatio=
n with
-both filesystem and mm (page_mkclean(), munmap(), etc).
-
-Therefore, neither flag needs to be set.
-
-In this case, ideally, neither get_user_pages() nor pin_user_pages() shoul=
d be
-called. Instead, the software should be written so that it does not pin pa=
ges.
-This allows mm and filesystems to operate more efficiently and reliably.
+CASE 3: MMU notifier registration, with or without page faulting hardware
+-------------------------------------------------------------------------
+Device drivers can pin pages via get_user_pages*(), and register for mmu
+notifier callbacks for the memory range. Then, upon receiving a notifier
+"invalidate range" callback , stop the device from using the range, and un=
pin
+the pages. There may be other possible schemes, such as for example explic=
itly
+synchronizing against pending IO, that accomplish approximately the same t=
hing.
+
+Or, if the hardware supports replayable page faults, then the device drive=
r can
+avoid pinning entirely (this is ideal), as follows: register for mmu notif=
ier
+callbacks as above, but instead of stopping the device and unpinning in th=
e
+callback, simply remove the range from the device's page tables.
+
+Either way, as long as the driver unpins the pages upon mmu notifier callb=
ack,
+then there is proper synchronization with both filesystem and mm
+(page_mkclean(), munmap(), etc). Therefore, neither flag needs to be set.
=20
 CASE 4: Pinning for struct page manipulation only
 -------------------------------------------------
-Here, normal GUP calls are sufficient, so neither flag needs to be set.
+If only struct page data (as opposed to the actual memory contents that a =
page
+is tracking) is affected, then normal GUP calls are sufficient, and neithe=
r flag
+needs to be set.
=20
 page_maybe_dma_pinned(): the whole point of pinning
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
--=20
2.26.2

