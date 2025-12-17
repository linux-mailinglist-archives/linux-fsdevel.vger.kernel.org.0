Return-Path: <linux-fsdevel+bounces-71544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C4CC6CEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FC443014B68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0DD33A9F5;
	Wed, 17 Dec 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CgayGKYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560E277CAF;
	Wed, 17 Dec 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963954; cv=none; b=Gpdb3N3fnacw6ghNvQqF7eUjmRlL87G3V0Db8E4nzna73j0XvQsQMh/O+3LAUDiYmcqKtAuUPmqHfHn4jETgdQw3ZLTQdk5G4ZbLlbyo1+TjOfilrxIA8pEEWiTWieOFO6PxEW07etYVhohW4TFcX2V1sn00Z0gTWCgEv4ZQMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963954; c=relaxed/simple;
	bh=KyoC+pudxxoZpV7wiAjEu6TR0l2sabhO7wdrxD9wPRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlqjG7v3R3kNxAmJAwutzssMaEcQ1TEvdHwUYXMXeM2EdNwI+wrMX/YqxTMldfssAwIAJlKhTMHy6T8t0aDcUuIpOiOC41myjCbhUmn6DFgkIVSswBHvVnaT18n7CvwwPhGNx6NMkfuU3SsQrWIBApw0iyWUssCRLolrBd05EJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CgayGKYf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cq7HwqeMuvTEC7Hd21VRpnlBiGrqeLC7/+/NXfHhqYQ=; b=CgayGKYfpf42r2Mtelac0XbEDM
	5Fx1PdkMt4nu/lhy9sfHNLgqwruWHuHGNC9CAIWou/6qqrZVRThoPjRY6/qhJGogu4kM4ndubB6Aa
	yd3EQhgRSDTI2IccBqsxctBTk08BR8UN9ap3L7p0gJbZyRluOr8k53whJZMHK6f5NFz3TCW8oQAmq
	j/Wt1zSk57bszbTZ2CdC4A6DBswzN65sk4i0TcUfW4PMwOvEGTTECq55V1QgwqTGa7O7jA3aOyqT8
	S5qNeox9r+0WhhAhGfsXnCXSAmTSTwIrcpJr/ZGN4Hws1leKuc1RRANjEnK3pq/2zqVuSpoOJxCwI
	IFzVxMhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVntW-00000006Pz2-3FDd;
	Wed, 17 Dec 2025 09:32:30 +0000
Date: Wed, 17 Dec 2025 01:32:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: NFS dentry caching regression? was Re: [GIT PULL] Please pull NFS
 client updates for Linux 6.19
Message-ID: <aUJ4rjyAOW3EWC-k@infradead.org>
References: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

the merge of this branch causes NFS lookup operation to shoot up a lot
for me.  And with merge I mean merge - both parent of the merge on their
own are fine.

With the script below that simulates running python scripts with lots
of imports that was created to benchmark delegation performance, the
number of lookups in the measurement period shoots up from 4 to about
410000, which is a bit suboptimal.  I have no idea how this could
happen, but it must be related to some sort of pathname lookup changes
I guess.  Other operations looks roughly the same.

---
#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <NFS_MOUNT_PATH>"
    exit 1
fi

NFS_MOUNT="$1"
WARMUP_FILE_COUNT="8000"
RUNS=200
MODULE_COUNT=200
SAVEFILE="/tmp/nfsstat.bak"

echo "=== NFS delegation benchmark ==="
echo "NFS mount:          $NFS_MOUNT"
echo "Warmup file count:  $WARMUP_FILE_COUNT"
echo "Number of runs:     $RUNS"
echo "Module count:       $MODULE_COUNT"
echo


################################################################################
# Step 1: Create temporary directory on NFS
################################################################################
TEST_DIR=$(mktemp -d "$NFS_MOUNT/test_deleg_bench.XXXXXX")
MODULE_DIR="$TEST_DIR/pymods"
mkdir -p "$MODULE_DIR/delegtest"
MODDIR_INIT="$MODULE_DIR/delegtest/__init__.py"

cat > "$MODDIR_INIT" <<EOF
import os
import glob

file_paths = glob.glob(os.path.join(os.path.dirname(__file__), "*.py"))

__all__ = [
    os.path.basename(f)[:-3] 
    for f in file_paths 
    if os.path.isfile(f) and not f.endswith("__init__.py")
]
EOF

echo "[1] Creating $WARMUP_FILE_COUNT tiny files to accumulate delegations..."
mkdir -p "$TEST_DIR/fill"
for i in $(seq 1 "$WARMUP_FILE_COUNT"); do
    echo "f$i" > "$TEST_DIR/fill/file_$i"
done

echo "[1] Warmup delegation files created."

################################################################################
# Step 2: Create many tiny Python modules to exercise import workload
################################################################################
echo "[2] Creating $MODULE_COUNT dummy python modules..."
for i in $(seq 1 "$MODULE_COUNT"); do
    echo "x = $i" > "$MODULE_DIR/delegtest/mod$i.py"
done
#umount -o remount $NFS_MOUNT

# Python snippet:
# repeatedly import all modN modules; measure iterations completed
BENCH_SCRIPT="$TEST_DIR/bench.py"

cat > "$BENCH_SCRIPT" <<EOF
import sys

sys.path.insert(0, "$MODULE_DIR")

from delegtest import *
EOF

################################################################################
# Step 3: Pre-benchmark NFS client counters
################################################################################
echo "[3] Capturing baseline NFS client stats..."
sync $NFS_MOUNT
#mount -o remount $NFS_MOUNT
cp /proc/net/rpc/nfs $SAVEFILE

################################################################################
# Step 4: Run Python benchmark
################################################################################
echo "[4] Running Python import benchmark..."

time {
for i in $(seq 1 "$RUNS"); do
    python3 "$BENCH_SCRIPT"
done
}

################################################################################
# Step 5: Produce NFS client delta report
################################################################################
echo
echo "=== NFS client DELTA REPORT ==="
echo

nfsstat -c -S $SAVEFILE  -l
rm -f $SAVEFILE

echo
echo "Test directory:       $TEST_DIR"
echo
echo "=== Done ==="

