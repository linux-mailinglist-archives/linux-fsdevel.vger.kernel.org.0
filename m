Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666BE359C73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhDIK7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 06:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233586AbhDIK7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617965958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANug4vbnIvWDaNTv8U2FRsQziGYv+4TJdFchOpNm0wI=;
        b=WTZrbOM1ZmUZGGwCih5zhtkT2c5Nl62xMyvDHdHpLOSGbUhP1ebnXcSZIlGacbp7ccS6fS
        WnP14X7yvkuv0lBiGibOKKNIvKcahrCaqpFQoFaeVHxS2iboJb0wJZwKzrZi7OTFFBvL8S
        71xIVqyaMnTZ6asa2ucdW8/bkyw4+NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-uRDoahl6No2zN7lOMrChuw-1; Fri, 09 Apr 2021 06:59:14 -0400
X-MC-Unique: uRDoahl6No2zN7lOMrChuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66D219611A0;
        Fri,  9 Apr 2021 10:59:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65D2260BE5;
        Fri,  9 Apr 2021 10:59:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 1/3] Make the generic bitops return bool
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, willy@infradead.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        dhowells@redhat.com, jlayton@kernel.org, hch@lst.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 09 Apr 2021 11:59:01 +0100
Message-ID: <161796594154.350846.1787112929938233401.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
References: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the generic bitops return bool when returning the value of a tested
bit.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Akinobu Mita <akinobu.mita@gmail.com>
cc: Arnd Bergmann <arnd@arndb.de>
cc: Will Deacon <will@kernel.org>
---

 include/asm-generic/bitops/atomic.h     |    6 +++---
 include/asm-generic/bitops/le.h         |   10 +++++-----
 include/asm-generic/bitops/lock.h       |    4 ++--
 include/asm-generic/bitops/non-atomic.h |    8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index 0e7316a86240..9b05e8634c09 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -29,7 +29,7 @@ static __always_inline void change_bit(unsigned int nr, volatile unsigned long *
 	atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
-static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *p)
+static inline bool test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
@@ -42,7 +42,7 @@ static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 	return !!(old & mask);
 }
 
-static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
+static inline bool test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
@@ -55,7 +55,7 @@ static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 	return !!(old & mask);
 }
 
-static inline int test_and_change_bit(unsigned int nr, volatile unsigned long *p)
+static inline bool test_and_change_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 188d3eba3ace..33355cf288f6 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -50,7 +50,7 @@ extern unsigned long find_next_bit_le(const void *addr,
 #error "Please fix <asm/byteorder.h>"
 #endif
 
-static inline int test_bit_le(int nr, const void *addr)
+static inline bool test_bit_le(int nr, const void *addr)
 {
 	return test_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
@@ -75,22 +75,22 @@ static inline void __clear_bit_le(int nr, void *addr)
 	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
 
-static inline int test_and_set_bit_le(int nr, void *addr)
+static inline bool test_and_set_bit_le(int nr, void *addr)
 {
 	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
 
-static inline int test_and_clear_bit_le(int nr, void *addr)
+static inline bool test_and_clear_bit_le(int nr, void *addr)
 {
 	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
 
-static inline int __test_and_set_bit_le(int nr, void *addr)
+static inline bool __test_and_set_bit_le(int nr, void *addr)
 {
 	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
 
-static inline int __test_and_clear_bit_le(int nr, void *addr)
+static inline bool __test_and_clear_bit_le(int nr, void *addr)
 {
 	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
 }
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 3ae021368f48..0e6acd059a59 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -15,8 +15,8 @@
  * the returned value is 0.
  * It can be used to implement bit locks.
  */
-static inline int test_and_set_bit_lock(unsigned int nr,
-					volatile unsigned long *p)
+static inline bool test_and_set_bit_lock(unsigned int nr,
+					 volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index 7e10c4b50c5d..7d916f677be3 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -55,7 +55,7 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline bool __test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -74,7 +74,7 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline bool __test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -85,7 +85,7 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr,
+static inline bool __test_and_change_bit(int nr,
 					    volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
@@ -101,7 +101,7 @@ static inline int __test_and_change_bit(int nr,
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline int test_bit(int nr, const volatile unsigned long *addr)
+static inline bool test_bit(int nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }


