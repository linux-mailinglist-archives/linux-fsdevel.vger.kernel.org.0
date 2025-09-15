Return-Path: <linux-fsdevel+bounces-61433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEBAB581DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FBD1AA5967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78227B4E8;
	Mon, 15 Sep 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="j7Kfrjvm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D4A2797AE;
	Mon, 15 Sep 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953132; cv=none; b=I0+cL9jlbXBcrip9O9BTdE7Fj25rJdmVacoSUaLtMC3i1VXH+pRySMxHRAfHP3wwyR/kgeB3ZbprRvwhhO17usKx1XU1bWP0LkrLoBFz52lROF2DdE1UjRMY2tTczkL3vOvSXMeaTYhbtt3ODz3PZTYuhck4C+BxBjWfI7Q0HI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953132; c=relaxed/simple;
	bh=fJDRk2Bdf81Gp496FGpX8GvGCt6gwfobFHAMxUT4pKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D6E240+YxXNX3NQUGoPdeE0XOuRQnMDlBXwLuetbFCYidEb27dmKgSMY5y6u1V2B/Yzy/V66SksJYkmxsalzHwJSC0nR7ziXQ+Dp8mtmxkSulWtVFV5FuK3cfT81/JO1Hhdi1pf5oEb5r7YCKnaY2F6TwFy7YzfW8w7hvIT1ChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=j7Kfrjvm; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1757953130; x=1789489130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N3NeNyamqVLa9+DQCyzsj2cOhr41ZZd2MWu/K0OO1HI=;
  b=j7KfrjvmRdp9obCrpQXNsmdhWJv88NNYyQptQTSwGTGxAPidBvzn5+6P
   9zTt+AqBOZYVw+divbWQiKGA0oGWNdPSzekwnweaKDb5jxp+FLMx2KRcW
   sWLcYURlp4h0S4zb3pGVOm8iGdF6HYCXXMQ2UR/KT/NINppCkelRUs9VW
   xZ/bmbJpYb403u/kKs5u3sxB04t31nvF7MGlpbPj4E07JXySKX4udcZBX
   PGNS9WMOkCZGIy8h7EDjV9rqXoGXWUqqb4tTpLT33gFHiStyJQNTfBCCl
   9UNxCa5gqwhAqKJNfQJU5dR5fVcj0f95SA0pBa4UMC5qMSvnczjrMhmQv
   Q==;
X-CSE-ConnectionGUID: ZcEgW1YvT0C2GF/FYjPcxw==
X-CSE-MsgGUID: IfTURVlRSXKEJ320dW9aJQ==
X-IronPort-AV: E=Sophos;i="6.18,266,1751241600"; 
   d="scan'208";a="2137065"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 16:18:40 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:25479]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.0.240:2525] with esmtp (Farcaster)
 id f857cdf3-c4a1-44e0-903b-97f2c9bca60f; Mon, 15 Sep 2025 16:18:40 +0000 (UTC)
X-Farcaster-Flow-ID: f857cdf3-c4a1-44e0-903b-97f2c9bca60f
Received: from EX19D022EUC004.ant.amazon.com (10.252.51.159) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 16:18:39 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC004.ant.amazon.com (10.252.51.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 16:18:39 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.020; Mon, 15 Sep 2025 16:18:39 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "willy@infradead.org" <willy@infradead.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"jack@suse.cz" <jack@suse.cz>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jthoughton@google.com"
	<jthoughton@google.com>, "tabba@google.com" <tabba@google.com>,
	"vannapurve@google.com" <vannapurve@google.com>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring,
 Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [RFC PATCH v6 2/2] userfaulfd: add minor mode for guestmem
Thread-Topic: [RFC PATCH v6 2/2] userfaulfd: add minor mode for guestmem
Thread-Index: AQHcJlxlJ76MA28SOEel205dRdsXkA==
Date: Mon, 15 Sep 2025 16:18:39 +0000
Message-ID: <20250915161815.40729-3-kalyazin@amazon.com>
References: <20250915161815.40729-1-kalyazin@amazon.com>
In-Reply-To: <20250915161815.40729-1-kalyazin@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Nikita Kalyazin <kalyazin@amazon.com>=0A=
=0A=
UserfaultFD support in guestmem enables use cases like restoring a=0A=
guest_memfd-backed VM from a memory snapshot in Firecracker [1] where an=0A=
external process is responsible for supplying the content of the guest=0A=
memory or live migration of guest_memfd-backed VMs.=0A=
=0A=
[1] https://github.com/firecracker-microvm/firecracker/blob/main/docs/snaps=
hotting/handling-page-faults-on-snapshot-resume.md=0A=
=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 Documentation/admin-guide/mm/userfaultfd.rst |  4 +++-=0A=
 fs/userfaultfd.c                             |  3 ++-=0A=
 include/linux/userfaultfd_k.h                |  8 +++++---=0A=
 include/uapi/linux/userfaultfd.h             |  8 +++++++-=0A=
 mm/userfaultfd.c                             | 14 +++++++++++---=0A=
 5 files changed, 28 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/a=
dmin-guide/mm/userfaultfd.rst=0A=
index e5cc8848dcb3..ca8c5954ffdb 100644=0A=
--- a/Documentation/admin-guide/mm/userfaultfd.rst=0A=
+++ b/Documentation/admin-guide/mm/userfaultfd.rst=0A=
@@ -111,7 +111,9 @@ events, except page fault notifications, may be generat=
ed:=0A=
 - ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports=0A=
   ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory=
=0A=
   areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating=
=0A=
-  support for shmem virtual memory areas.=0A=
+  support for shmem virtual memory areas. ``UFFD_FEATURE_MINOR_GUESTMEM``=
=0A=
+  is the analogous feature indicating support for guestmem-backed memory=
=0A=
+  areas.=0A=
 =0A=
 - ``UFFD_FEATURE_MOVE`` indicates that the kernel supports moving an=0A=
   existing page contents from userspace.=0A=
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c=0A=
index 54c6cc7fe9c6..e4e80f1072a6 100644=0A=
--- a/fs/userfaultfd.c=0A=
+++ b/fs/userfaultfd.c=0A=
@@ -1978,7 +1978,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ct=
x,=0A=
 	uffdio_api.features =3D UFFD_API_FEATURES;=0A=
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=0A=
 	uffdio_api.features &=3D=0A=
-		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);=0A=
+		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM |=0A=
+		  UFFD_FEATURE_MINOR_GUESTMEM);=0A=
 #endif=0A=
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP=0A=
 	uffdio_api.features &=3D ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;=0A=
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h=
=0A=
index c0e716aec26a..37bd4e71b611 100644=0A=
--- a/include/linux/userfaultfd_k.h=0A=
+++ b/include/linux/userfaultfd_k.h=0A=
@@ -14,6 +14,7 @@=0A=
 #include <linux/userfaultfd.h> /* linux/include/uapi/linux/userfaultfd.h *=
/=0A=
 =0A=
 #include <linux/fcntl.h>=0A=
+#include <linux/guestmem.h>=0A=
 #include <linux/mm.h>=0A=
 #include <linux/swap.h>=0A=
 #include <linux/swapops.h>=0A=
@@ -218,7 +219,8 @@ static inline bool vma_can_userfault(struct vm_area_str=
uct *vma,=0A=
 		return false;=0A=
 =0A=
 	if ((vm_flags & VM_UFFD_MINOR) &&=0A=
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))=0A=
+	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma) &&=0A=
+		!guestmem_vma_is_guestmem(vma)))=0A=
 		return false;=0A=
 =0A=
 	/*=0A=
@@ -238,9 +240,9 @@ static inline bool vma_can_userfault(struct vm_area_str=
uct *vma,=0A=
 		return false;=0A=
 #endif=0A=
 =0A=
-	/* By default, allow any of anon|shmem|hugetlb */=0A=
+	/* By default, allow any of anon|shmem|hugetlb|guestmem */=0A=
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||=0A=
-	    vma_is_shmem(vma);=0A=
+	    vma_is_shmem(vma) || guestmem_vma_is_guestmem(vma);=0A=
 }=0A=
 =0A=
 static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct =
*vma)=0A=
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaul=
tfd.h=0A=
index 2841e4ea8f2c..0fe9fbd29772 100644=0A=
--- a/include/uapi/linux/userfaultfd.h=0A=
+++ b/include/uapi/linux/userfaultfd.h=0A=
@@ -42,7 +42,8 @@=0A=
 			   UFFD_FEATURE_WP_UNPOPULATED |	\=0A=
 			   UFFD_FEATURE_POISON |		\=0A=
 			   UFFD_FEATURE_WP_ASYNC |		\=0A=
-			   UFFD_FEATURE_MOVE)=0A=
+			   UFFD_FEATURE_MOVE |			\=0A=
+			   UFFD_FEATURE_MINOR_GUESTMEM)=0A=
 #define UFFD_API_IOCTLS				\=0A=
 	((__u64)1 << _UFFDIO_REGISTER |		\=0A=
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\=0A=
@@ -230,6 +231,10 @@ struct uffdio_api {=0A=
 	 *=0A=
 	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an=0A=
 	 * existing page contents from userspace.=0A=
+	 *=0A=
+	 * UFFD_FEATURE_MINOR_GUESTMEM indicates the same support as=0A=
+	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for guestmem-backed pages=0A=
+	 * instead.=0A=
 	 */=0A=
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)=0A=
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)=0A=
@@ -248,6 +253,7 @@ struct uffdio_api {=0A=
 #define UFFD_FEATURE_POISON			(1<<14)=0A=
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)=0A=
 #define UFFD_FEATURE_MOVE			(1<<16)=0A=
+#define UFFD_FEATURE_MINOR_GUESTMEM		(1<<17)=0A=
 	__u64 features;=0A=
 =0A=
 	__u64 ioctls;=0A=
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c=0A=
index 45e6290e2e8b..304e5d7dbb70 100644=0A=
--- a/mm/userfaultfd.c=0A=
+++ b/mm/userfaultfd.c=0A=
@@ -388,7 +388,14 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,=
=0A=
 	struct page *page;=0A=
 	int ret;=0A=
 =0A=
-	ret =3D shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);=0A=
+	if (guestmem_vma_is_guestmem(dst_vma)) {=0A=
+		ret =3D 0;=0A=
+		folio =3D guestmem_grab_folio(inode->i_mapping, pgoff);=0A=
+		if (IS_ERR(folio))=0A=
+			ret =3D PTR_ERR(folio);=0A=
+	} else {=0A=
+		ret =3D shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);=0A=
+	}=0A=
 	/* Our caller expects us to return -EFAULT if we failed to find folio */=
=0A=
 	if (ret =3D=3D -ENOENT)=0A=
 		ret =3D -EFAULT;=0A=
@@ -766,9 +773,10 @@ static __always_inline ssize_t mfill_atomic(struct use=
rfaultfd_ctx *ctx,=0A=
 		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,=0A=
 					     src_start, len, flags);=0A=
 =0A=
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))=0A=
+	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma)=0A=
+	    && !guestmem_vma_is_guestmem(dst_vma))=0A=
 		goto out_unlock;=0A=
-	if (!vma_is_shmem(dst_vma) &&=0A=
+	if (!vma_is_shmem(dst_vma) && !guestmem_vma_is_guestmem(dst_vma) &&=0A=
 	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))=0A=
 		goto out_unlock;=0A=
 =0A=
-- =0A=
2.50.1=0A=
=0A=

