Return-Path: <linux-fsdevel+bounces-44978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F4A6FD66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8233D7A8B2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5326A0D3;
	Tue, 25 Mar 2025 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz9tM3Jy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716625BABA;
	Tue, 25 Mar 2025 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905292; cv=none; b=PB0PfrEdgTKft4MW+bs5nvIdfjFMHre0I7VuPTucnAjiEG73HicuDcq5PFF3fwo3PIc6850qLzKICcxcFx9Sm4jUM33VgRoR8VZpeFBtxQH/IPQap3CSy5xDFvghqFLL4ev67Iki2nCGTbeEfq8zWbrYlajyqNQ1PEHz3BkvIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905292; c=relaxed/simple;
	bh=2jJgyb4FoTTfcF3Budy1LUhXG9H2Y2tw1xz71PydyxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hke3DK61uio4zxsiA60dCTf2RDhYqnzRk7gqoFU2bGLzp3gYhw6YQBOHhbU2762xB2uVdYNDHRpdz61gtq3+LKn6AnxMZtyREuarNFLSkoqlSrgoHPnut9LNejXPmw4NVy49h7/1VpmoZRim4BmhU6QVbIyF+YP/oFq6ymmoXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz9tM3Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA472C4CEE4;
	Tue, 25 Mar 2025 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905292;
	bh=2jJgyb4FoTTfcF3Budy1LUhXG9H2Y2tw1xz71PydyxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gz9tM3JywmMT22uwAGn8qB+80WAYV3v7Tgh0B3cb9T/BoswxR3T/k//AbqcuWEKLF
	 L4edD2clUau1Rpi1qbdeJXdbmBWHEi+zr+K+bY+S5OVJT+Z7Ij8LqPN4+oB1wJmn4L
	 TwL4dvh9smbkloOkN5N7/q5+M1EhCXtMHNIajyoIJo/07VkhxeQQZJKSQHjYyaQ+Fa
	 KHrViSi3S5tb9gQhPdFzLrO7vlzHmaGxIcQIxVasrFiSnuiKC9ZY2mJKzPZPtsmO7E
	 gi4u3P8cxdVd4W23j785rOpnmEAPzxlKxOy5Pd/d9VTUepXHGjCRYsCE81kr/SXvGT
	 b+Gh+GEiotvJg==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 20/43] rv64ilp32_abi: drivers/perf: Adapt xlen_t of sbiret
Date: Tue, 25 Mar 2025 08:16:01 -0400
Message-Id: <20250325121624.523258-21-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Because rv64ilp32_abi change the sbiret struct,

from:
struct sbiret {
        long error;
        long value;
};

to:
struct sbiret {
        xlen_t error;
        xlen_t value;
};

So, use a cast long to prevent compile warning.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 drivers/perf/riscv_pmu_sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 698de8ddf895..e2c4d1bcbc7c 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -638,7 +638,7 @@ static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
 	/* Free up the snapshot area memory and fall back to SBI PMU calls without snapshot */
 	if (ret.error) {
 		if (ret.error != SBI_ERR_NOT_SUPPORTED)
-			pr_warn("pmu snapshot setup failed with error %ld\n", ret.error);
+			pr_warn("pmu snapshot setup failed with error %ld\n", (long)ret.error);
 		return sbi_err_map_linux_errno(ret.error);
 	}
 
@@ -679,7 +679,7 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
 				val |= ((u64)ret.value << 32);
 			else
 				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %ld\n",
-					  ret.error);
+					  (long)ret.error);
 		}
 	} else {
 		val = riscv_pmu_ctr_read_csr(info.csr);
-- 
2.40.1


