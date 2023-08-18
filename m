Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42083780B4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376423AbjHRLk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376411AbjHRLk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D572723
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692358779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3mAd5RT0ADcqFGH0+/dpnTAdMm0BF37Gb+TptEBEak=;
        b=GZzJ2j/n63KCQN2j/1r3l71OsU37PspvK/+j6MAekGh91lox7fsWfPAVjqSOrJPaUKfpLp
        MLuIu+UZ0v2t7Rd/FYEfIw1M9gvBIqAYE50zdQnKShbdVbUz6dLUyXs/ToTz2Be3nj5v28
        sqn4FPUU8RDFrcoDeeDLb6LjxVXrQC8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-J945iaf8NySVe-PFItRz9Q-1; Fri, 18 Aug 2023 07:39:36 -0400
X-MC-Unique: J945iaf8NySVe-PFItRz9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F40C29A9CB3;
        Fri, 18 Aug 2023 11:39:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54FA2492C13;
        Fri, 18 Aug 2023 11:39:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
References: <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com> <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com> <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com> <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1748218.1692358772.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 18 Aug 2023 12:39:32 +0100
Message-ID: <1748219.1692358772@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Would it make sense to always check for MCE in _copy_from_iter() and alway=
s
return a short transfer if we encounter one?  It looks pretty cheap in ter=
ms
of code size as the exception table stuff handles it, so we don't need to =
do
anything in the normal path.

I guess this would change the handling of memory errors and DAX errors.

David
---
iov_iter: Always handle MCE in _copy_to_iter()

(incomplete)

---
 arch/x86/include/asm/mce.h |   22 ++++++++++++++++++++++
 fs/coredump.c              |    1 -
 include/linux/uio.h        |   16 ----------------
 lib/iov_iter.c             |   17 +++++------------
 4 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 180b1cbfcc4e..ee3ff090360d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -353,4 +353,26 @@ static inline void mce_hygon_feature_init(struct cpui=
nfo_x86 *c)	{ return mce_am
 =

 unsigned long copy_mc_fragile_handle_tail(char *to, char *from, unsigned =
len);
 =

+static __always_inline __must_check
+unsigned long memcpy_mc(void *to, const void *from, unsigned long len)
+{
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	/*
+	 * If CPU has FSRM feature, use 'rep movs'.
+	 * Otherwise, use rep_movs_alternative.
+	 */
+	asm volatile(
+		"1:\n\t"
+		ALTERNATIVE("rep movsb",
+			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
+		"2:\n"
+		_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_DEFAULT_MCE_SAFE)
+		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
+		: : "memory", "rax", "r8", "r9", "r10", "r11");
+#else
+	return memcpy(to, from, len);
+#endif
+	return len;
+}
+
 #endif /* _ASM_X86_MCE_H */
diff --git a/fs/coredump.c b/fs/coredump.c
index 9d235fa14ab9..ad54102a5e14 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -884,7 +884,6 @@ static int dump_emit_page(struct coredump_params *cprm=
, struct page *page)
 	pos =3D file->f_pos;
 	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
-	iov_iter_set_copy_mc(&iter);
 	n =3D __kernel_write_iter(cprm->file, &iter, &pos);
 	if (n !=3D PAGE_SIZE)
 		return 0;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 42bce38a8e87..73078ba297b7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -40,7 +40,6 @@ struct iov_iter_state {
 =

 struct iov_iter {
 	u8 iter_type;
-	bool copy_mc;
 	bool nofault;
 	bool data_source;
 	bool user_backed;
@@ -252,22 +251,8 @@ size_t _copy_from_iter_flushcache(void *addr, size_t =
bytes, struct iov_iter *i);
 =

 #ifdef CONFIG_ARCH_HAS_COPY_MC
 size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *=
i);
-static inline void iov_iter_set_copy_mc(struct iov_iter *i)
-{
-	i->copy_mc =3D true;
-}
-
-static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
-{
-	return i->copy_mc;
-}
 #else
 #define _copy_mc_to_iter _copy_to_iter
-static inline void iov_iter_set_copy_mc(struct iov_iter *i) { }
-static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
-{
-	return false;
-}
 #endif
 =

 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
@@ -382,7 +367,6 @@ static inline void iov_iter_ubuf(struct iov_iter *i, u=
nsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i =3D (struct iov_iter) {
 		.iter_type =3D ITER_UBUF,
-		.copy_mc =3D false,
 		.user_backed =3D true,
 		.data_source =3D direction,
 		.ubuf =3D buf,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d282fd4d348f..887d9cb9be4e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -14,6 +14,7 @@
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
 #include <linux/iov_iter.h>
+#include <asm/mce.h>
 =

 static __always_inline
 size_t copy_to_user_iter(void __user *iter_to, size_t progress,
@@ -168,7 +169,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int di=
rection,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i =3D (struct iov_iter) {
 		.iter_type =3D ITER_IOVEC,
-		.copy_mc =3D false,
 		.nofault =3D false,
 		.user_backed =3D true,
 		.data_source =3D direction,
@@ -254,14 +254,11 @@ size_t _copy_mc_to_iter(const void *addr, size_t byt=
es, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 =

-static size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
-				  size_t len, void *to, void *priv2)
+static __always_inline
+size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
+			   size_t len, void *to, void *priv2)
 {
-	struct iov_iter *iter =3D priv2;
-
-	if (iov_iter_is_copy_mc(iter))
-		return copy_mc_to_kernel(to + progress, iter_from, len);
-	return memcpy_from_iter(iter_from, progress, len, to, priv2);
+	return memcpy_mc(to + progress, iter_from, len);
 }
 =

 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
@@ -632,7 +629,6 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int di=
rection,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i =3D (struct iov_iter){
 		.iter_type =3D ITER_KVEC,
-		.copy_mc =3D false,
 		.data_source =3D direction,
 		.kvec =3D kvec,
 		.nr_segs =3D nr_segs,
@@ -649,7 +645,6 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int di=
rection,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i =3D (struct iov_iter){
 		.iter_type =3D ITER_BVEC,
-		.copy_mc =3D false,
 		.data_source =3D direction,
 		.bvec =3D bvec,
 		.nr_segs =3D nr_segs,
@@ -678,7 +673,6 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int =
direction,
 	BUG_ON(direction & ~1);
 	*i =3D (struct iov_iter) {
 		.iter_type =3D ITER_XARRAY,
-		.copy_mc =3D false,
 		.data_source =3D direction,
 		.xarray =3D xarray,
 		.xarray_start =3D start,
@@ -702,7 +696,6 @@ void iov_iter_discard(struct iov_iter *i, unsigned int=
 direction, size_t count)
 	BUG_ON(direction !=3D READ);
 	*i =3D (struct iov_iter){
 		.iter_type =3D ITER_DISCARD,
-		.copy_mc =3D false,
 		.data_source =3D false,
 		.count =3D count,
 		.iov_offset =3D 0

