Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9255F8385
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJHF6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 01:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJHF5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5654E86F8E;
        Fri,  7 Oct 2022 22:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2DE960FEC;
        Sat,  8 Oct 2022 05:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4455EC433C1;
        Sat,  8 Oct 2022 05:55:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iL2WBHAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665208558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFw1PDaF7vwI6ygcu0DeOPE0MQ7RJ09ks5VrNfUJxEw=;
        b=iL2WBHAs/z73fe4l3t3tt9S94G4/S07MVxQOYLRGauydkaVKTvQOXE7dg4Qd/62nS/3psX
        N71QrowqWYJhQl/gV+1C6UJws69qkeQsB8xUhidPhFar2KHqEi9tLnCAIbpFrvz3RzSdfU
        66mVfXYvHHXPYayNhJophce+95+M6Gc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 64fa8d9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 8 Oct 2022 05:55:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Airlie <airlied@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Huacai Chen <chenhuacai@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Graf <tgraf@suug.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, netdev@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v5 6/7] treewide: use get_random_bytes when possible
Date:   Fri,  7 Oct 2022 23:53:58 -0600
Message-Id: <20221008055359.286426-7-Jason@zx2c4.com>
In-Reply-To: <20221008055359.286426-1-Jason@zx2c4.com>
References: <20221008055359.286426-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The prandom_bytes() function has been a deprecated inline wrapper around
get_random_bytes() for several releases now, and compiles down to the
exact same code. Replace the deprecated wrapper with a direct call to
the real function. This was done as a basic find and replace.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu> # powerpc
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/powerpc/crypto/crc-vpmsum_test.c       |  2 +-
 block/blk-crypto-fallback.c                 |  2 +-
 crypto/async_tx/raid6test.c                 |  2 +-
 drivers/dma/dmatest.c                       |  2 +-
 drivers/mtd/nand/raw/nandsim.c              |  2 +-
 drivers/mtd/tests/mtd_nandecctest.c         |  2 +-
 drivers/mtd/tests/speedtest.c               |  2 +-
 drivers/mtd/tests/stresstest.c              |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c   |  2 +-
 drivers/net/ethernet/rocker/rocker_main.c   |  2 +-
 drivers/net/wireguard/selftest/allowedips.c | 12 ++++++------
 fs/ubifs/debug.c                            |  2 +-
 kernel/kcsan/selftest.c                     |  2 +-
 lib/random32.c                              |  2 +-
 lib/test_objagg.c                           |  2 +-
 lib/uuid.c                                  |  2 +-
 net/ipv4/route.c                            |  2 +-
 net/mac80211/rc80211_minstrel_ht.c          |  2 +-
 net/sched/sch_pie.c                         |  2 +-
 19 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/crypto/crc-vpmsum_test.c b/arch/powerpc/crypto/crc-vpmsum_test.c
index c1c1ef9457fb..273c527868db 100644
--- a/arch/powerpc/crypto/crc-vpmsum_test.c
+++ b/arch/powerpc/crypto/crc-vpmsum_test.c
@@ -82,7 +82,7 @@ static int __init crc_test_init(void)
 
 			if (len <= offset)
 				continue;
-			prandom_bytes(data, len);
+			get_random_bytes(data, len);
 			len -= offset;
 
 			crypto_shash_update(crct10dif_shash, data+offset, len);
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 621abd1b0e4d..ad9844c5b40c 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -539,7 +539,7 @@ static int blk_crypto_fallback_init(void)
 	if (blk_crypto_fallback_inited)
 		return 0;
 
-	prandom_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
+	get_random_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
 
 	err = bioset_init(&crypto_bio_split, 64, 0, 0);
 	if (err)
diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
index c9d218e53bcb..f74505f2baf0 100644
--- a/crypto/async_tx/raid6test.c
+++ b/crypto/async_tx/raid6test.c
@@ -37,7 +37,7 @@ static void makedata(int disks)
 	int i;
 
 	for (i = 0; i < disks; i++) {
-		prandom_bytes(page_address(data[i]), PAGE_SIZE);
+		get_random_bytes(page_address(data[i]), PAGE_SIZE);
 		dataptrs[i] = data[i];
 		dataoffs[i] = 0;
 	}
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 9fe2ae794316..ffe621695e47 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -312,7 +312,7 @@ static unsigned long dmatest_random(void)
 {
 	unsigned long buf;
 
-	prandom_bytes(&buf, sizeof(buf));
+	get_random_bytes(&buf, sizeof(buf));
 	return buf;
 }
 
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 4bdaf4aa7007..c941a5a41ea6 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1393,7 +1393,7 @@ static int ns_do_read_error(struct nandsim *ns, int num)
 	unsigned int page_no = ns->regs.row;
 
 	if (ns_read_error(page_no)) {
-		prandom_bytes(ns->buf.byte, num);
+		get_random_bytes(ns->buf.byte, num);
 		NS_WARN("simulating read error in page %u\n", page_no);
 		return 1;
 	}
diff --git a/drivers/mtd/tests/mtd_nandecctest.c b/drivers/mtd/tests/mtd_nandecctest.c
index 1c7201b0f372..440988562cfd 100644
--- a/drivers/mtd/tests/mtd_nandecctest.c
+++ b/drivers/mtd/tests/mtd_nandecctest.c
@@ -266,7 +266,7 @@ static int nand_ecc_test_run(const size_t size)
 		goto error;
 	}
 
-	prandom_bytes(correct_data, size);
+	get_random_bytes(correct_data, size);
 	ecc_sw_hamming_calculate(correct_data, size, correct_ecc, sm_order);
 	for (i = 0; i < ARRAY_SIZE(nand_ecc_test); i++) {
 		nand_ecc_test[i].prepare(error_data, error_ecc,
diff --git a/drivers/mtd/tests/speedtest.c b/drivers/mtd/tests/speedtest.c
index c9ec7086bfa1..075bce32caa5 100644
--- a/drivers/mtd/tests/speedtest.c
+++ b/drivers/mtd/tests/speedtest.c
@@ -223,7 +223,7 @@ static int __init mtd_speedtest_init(void)
 	if (!iobuf)
 		goto out;
 
-	prandom_bytes(iobuf, mtd->erasesize);
+	get_random_bytes(iobuf, mtd->erasesize);
 
 	bbt = kzalloc(ebcnt, GFP_KERNEL);
 	if (!bbt)
diff --git a/drivers/mtd/tests/stresstest.c b/drivers/mtd/tests/stresstest.c
index d2faaca7f19d..75b6ddc5dc4d 100644
--- a/drivers/mtd/tests/stresstest.c
+++ b/drivers/mtd/tests/stresstest.c
@@ -183,7 +183,7 @@ static int __init mtd_stresstest_init(void)
 		goto out;
 	for (i = 0; i < ebcnt; i++)
 		offsets[i] = mtd->erasesize;
-	prandom_bytes(writebuf, bufsize);
+	get_random_bytes(writebuf, bufsize);
 
 	bbt = kzalloc(ebcnt, GFP_KERNEL);
 	if (!bbt)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 96da0ba3d507..354953df46a1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3874,7 +3874,7 @@ static void bnxt_init_vnics(struct bnxt *bp)
 
 		if (bp->vnic_info[i].rss_hash_key) {
 			if (i == 0)
-				prandom_bytes(vnic->rss_hash_key,
+				get_random_bytes(vnic->rss_hash_key,
 					      HW_HASH_KEY_SIZE);
 			else
 				memcpy(vnic->rss_hash_key,
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 8c3bbafabb07..cd4488efe0a4 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -224,7 +224,7 @@ static int rocker_dma_test_offset(const struct rocker *rocker,
 	if (err)
 		goto unmap;
 
-	prandom_bytes(buf, ROCKER_TEST_DMA_BUF_SIZE);
+	get_random_bytes(buf, ROCKER_TEST_DMA_BUF_SIZE);
 	for (i = 0; i < ROCKER_TEST_DMA_BUF_SIZE; i++)
 		expect[i] = ~buf[i];
 	err = rocker_dma_test_one(rocker, wait, ROCKER_TEST_DMA_CTRL_INVERT,
diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index dd897c0740a2..19eac00b2381 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -284,7 +284,7 @@ static __init bool randomized_test(void)
 	mutex_lock(&mutex);
 
 	for (i = 0; i < NUM_RAND_ROUTES; ++i) {
-		prandom_bytes(ip, 4);
+		get_random_bytes(ip, 4);
 		cidr = prandom_u32_max(32) + 1;
 		peer = peers[prandom_u32_max(NUM_PEERS)];
 		if (wg_allowedips_insert_v4(&t, (struct in_addr *)ip, cidr,
@@ -299,7 +299,7 @@ static __init bool randomized_test(void)
 		}
 		for (j = 0; j < NUM_MUTATED_ROUTES; ++j) {
 			memcpy(mutated, ip, 4);
-			prandom_bytes(mutate_mask, 4);
+			get_random_bytes(mutate_mask, 4);
 			mutate_amount = prandom_u32_max(32);
 			for (k = 0; k < mutate_amount / 8; ++k)
 				mutate_mask[k] = 0xff;
@@ -328,7 +328,7 @@ static __init bool randomized_test(void)
 	}
 
 	for (i = 0; i < NUM_RAND_ROUTES; ++i) {
-		prandom_bytes(ip, 16);
+		get_random_bytes(ip, 16);
 		cidr = prandom_u32_max(128) + 1;
 		peer = peers[prandom_u32_max(NUM_PEERS)];
 		if (wg_allowedips_insert_v6(&t, (struct in6_addr *)ip, cidr,
@@ -343,7 +343,7 @@ static __init bool randomized_test(void)
 		}
 		for (j = 0; j < NUM_MUTATED_ROUTES; ++j) {
 			memcpy(mutated, ip, 16);
-			prandom_bytes(mutate_mask, 16);
+			get_random_bytes(mutate_mask, 16);
 			mutate_amount = prandom_u32_max(128);
 			for (k = 0; k < mutate_amount / 8; ++k)
 				mutate_mask[k] = 0xff;
@@ -381,13 +381,13 @@ static __init bool randomized_test(void)
 
 	for (j = 0;; ++j) {
 		for (i = 0; i < NUM_QUERIES; ++i) {
-			prandom_bytes(ip, 4);
+			get_random_bytes(ip, 4);
 			if (lookup(t.root4, 32, ip) != horrible_allowedips_lookup_v4(&h, (struct in_addr *)ip)) {
 				horrible_allowedips_lookup_v4(&h, (struct in_addr *)ip);
 				pr_err("allowedips random v4 self-test: FAIL\n");
 				goto free;
 			}
-			prandom_bytes(ip, 16);
+			get_random_bytes(ip, 16);
 			if (lookup(t.root6, 128, ip) != horrible_allowedips_lookup_v6(&h, (struct in6_addr *)ip)) {
 				pr_err("allowedips random v6 self-test: FAIL\n");
 				goto free;
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index f4d3b568aa64..3f128b9fdfbb 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2581,7 +2581,7 @@ static int corrupt_data(const struct ubifs_info *c, const void *buf,
 	if (ffs)
 		memset(p + from, 0xFF, to - from);
 	else
-		prandom_bytes(p + from, to - from);
+		get_random_bytes(p + from, to - from);
 
 	return to;
 }
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 58b94deae5c0..00cdf8fa5693 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -46,7 +46,7 @@ static bool __init test_encode_decode(void)
 		unsigned long addr;
 		size_t verif_size;
 
-		prandom_bytes(&addr, sizeof(addr));
+		get_random_bytes(&addr, sizeof(addr));
 		if (addr < PAGE_SIZE)
 			addr = PAGE_SIZE;
 
diff --git a/lib/random32.c b/lib/random32.c
index d4f19e1a69d4..32060b852668 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -69,7 +69,7 @@ EXPORT_SYMBOL(prandom_u32_state);
  *	@bytes: the requested number of bytes
  *
  *	This is used for pseudo-randomness with no outside seeding.
- *	For more random results, use prandom_bytes().
+ *	For more random results, use get_random_bytes().
  */
 void prandom_bytes_state(struct rnd_state *state, void *buf, size_t bytes)
 {
diff --git a/lib/test_objagg.c b/lib/test_objagg.c
index da137939a410..c0c957c50635 100644
--- a/lib/test_objagg.c
+++ b/lib/test_objagg.c
@@ -157,7 +157,7 @@ static int test_nodelta_obj_get(struct world *world, struct objagg *objagg,
 	int err;
 
 	if (should_create_root)
-		prandom_bytes(world->next_root_buf,
+		get_random_bytes(world->next_root_buf,
 			      sizeof(world->next_root_buf));
 
 	objagg_obj = world_obj_get(world, objagg, key_id);
diff --git a/lib/uuid.c b/lib/uuid.c
index 562d53977cab..e309b4c5be3d 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(generate_random_guid);
 
 static void __uuid_gen_common(__u8 b[16])
 {
-	prandom_bytes(b, 16);
+	get_random_bytes(b, 16);
 	/* reversion 0b10 */
 	b[8] = (b[8] & 0x3F) | 0x80;
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1a37a07c7163..cd1fa9f70f1a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3719,7 +3719,7 @@ int __init ip_rt_init(void)
 
 	ip_idents = idents_hash;
 
-	prandom_bytes(ip_idents, (ip_idents_mask + 1) * sizeof(*ip_idents));
+	get_random_bytes(ip_idents, (ip_idents_mask + 1) * sizeof(*ip_idents));
 
 	ip_tstamps = idents_hash + (ip_idents_mask + 1) * sizeof(*ip_idents);
 
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 5f27e6746762..39fb4e2d141a 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -2033,7 +2033,7 @@ static void __init init_sample_table(void)
 
 	memset(sample_table, 0xff, sizeof(sample_table));
 	for (col = 0; col < SAMPLE_COLUMNS; col++) {
-		prandom_bytes(rnd, sizeof(rnd));
+		get_random_bytes(rnd, sizeof(rnd));
 		for (i = 0; i < MCS_GROUP_RATES; i++) {
 			new_idx = (i + rnd[i]) % MCS_GROUP_RATES;
 			while (sample_table[col][new_idx] != 0xff)
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 5a457ff61acd..66b2b23e8cd1 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -72,7 +72,7 @@ bool pie_drop_early(struct Qdisc *sch, struct pie_params *params,
 	if (vars->accu_prob >= (MAX_PROB / 2) * 17)
 		return true;
 
-	prandom_bytes(&rnd, 8);
+	get_random_bytes(&rnd, 8);
 	if ((rnd >> BITS_PER_BYTE) < local_prob) {
 		vars->accu_prob = 0;
 		return true;
-- 
2.37.3

