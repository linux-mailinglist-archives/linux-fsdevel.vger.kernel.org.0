Return-Path: <linux-fsdevel+bounces-59725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E97B3D4D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 21:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B1718972B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA8276048;
	Sun, 31 Aug 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="dAY6LYb0";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="HpGD2Xko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA821A7264
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667889; cv=none; b=j+9UqJ4V9usMLKzhve22QyLtluTPeQxRsZ0rR13yy+qYfEGMbsl+vQCik6xhVnyax1k7ERJX8WIRLUdBTdZLa3BHFw0s/Zks1EV0kPFpelou7YJWicRHJ80Rc/kl7Gv0CrtO3m/J3C+77iOoHrf0kvfkqiRMcwh5s2LCLOUQ9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667889; c=relaxed/simple;
	bh=KneoWpxXGFhvxupsexdJXwJWsXpS5UsqWVZ1XconUfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRNh3knzTElLCWs22uS+V3lSeEO+DN3wG4KKWtpZ8lywrvhhk/vlDS7PBddTd4mepl7MIdtUtUdjweeM24ezVwM9xmKeLjGAOLoHOT9L8HceTVbSD7QGyZzeQ+atMIOTHoUKGkHnh27/bIjyln7GT691HvHl3jdQnQQc52Zqquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=dAY6LYb0 reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=HpGD2Xko; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668786; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=fjKbadbZ2hBFy0VfkFE4ZYB0g9U3OWHoNFKBHGHXGes=; b=dAY6LYb0aSvXTMb48L6W4CKBwZ
	m8T/Y7RuhDXhQw/0HBm24ACtHTN2Y0sQu6RgzWBmIFkBtL4tbieE+FH75C0PlgLR0empmYwd02bTu
	rHEcmbTE5CtrEIZ6fcKomuFI8KV2jM6uPzhWquvpX72seMEJbpNGNRWSRG9JhgrjUnIy6jGen29JE
	2/vEpZYPlh3ZxBxqJzZ5V+991dClhWdjzkrugOdgXYkNL6QfyOmd5AA4YHrZvZDaE/szkx6Dygs0c
	2uv9X0Mphnvlo2yQn9jGAwT1zmPmQQKWdXRCwWw3aeBSAuIDudizM73dbejxu5MKNCruPkhK4UbzS
	z0V/BWpg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667886; h=from : subject
 : to : message-id : date;
 bh=fjKbadbZ2hBFy0VfkFE4ZYB0g9U3OWHoNFKBHGHXGes=;
 b=HpGD2XkoaKMmoVd4yDieG1koxOl/DzN6WV6ktDCnRddcy1G0O1qyur4yBRLEsmAQQMsRb
 NywCXIE36XrbIhHVobl+wI81JKWnMJWMY7zS6Woe1h3xKiGbNjs0jtrcdu4WNIyOmKvKq1B
 MGIuxzunjgxAMu/eYVQnG4fqz4DgTE8a2Qb4IL9txEQO23n2tpjSE3yB4TgcFpFUroPDvyt
 adHofNaR0qDFQid0p2c23pd84KTGFvcr1L06rPDlWAybXyAvtBpF0TbwBfYLWgP/WBetOuE
 WfW2LDNb2WJuZUv/2lpZnv2eVyqTxVUx8AHtneCv+jXTg3nVkWyYPjay4cVw==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYp-TRk4DY-U4; Sun, 31 Aug 2025 19:17:55 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYp-4o5NDgrhYew-mlAi; Sun, 31 Aug 2025 19:17:55 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 0/5] 9p: Performance improvements for build workloads
Date: Sun, 31 Aug 2025 21:03:38 +0200
Message-ID: <cover.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: hOLsvNSmcRLw.Hiz-l1ONYegm.7jk3Hw-Z03E
Feedback-ID: 510616m:510616apGKSTK:510616sDeqWC-WNQ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

This patchset introduces several performance optimizations for the 9p
filesystem when used with cache=loose option (exclusive or read only
mounts). These improvements particularly target workloads with frequent
lookups of non-existent paths and repeated symlink resolutions.

The very state of the art benchmark consisting of cloning a fresh
hostap repository and building hostapd and wpa_supplicant for hwsim
tests (cd tests/hwsim; time ./build.sh) in a VM running on a 9pfs rootfs
(with trans=virtio,cache=loose options) has been used to test those
optimizations impact.

For reference, the build takes 0m56.492s on my laptop natively while it
completes in 2m18.702sec on the VM. This represents a significant
performance penalty considering running the same build on a VM using a
virtiofs rootfs (with "--cache always" virtiofsd option) takes around
1m32.141s. This patchset aims to bring the 9pfs build time close to
that of virtiofs, rather than the native host time, as a realistic
expectation.

This first two patches in this series focus on keeping negative dentries
in the cache, ensuring that subsequent lookups for paths known to not
exist do not require redundant 9P RPC calls. This optimization reduces
the time needed for the compiler to search for header files across known
locations. These two patches introduce a new mount option, ndentrytmo,
which specifies the number of ms to keep the dentry in the cache. Using
ndentrytmo=-1 (keeping the negative dentry indifinetly) shrunk build
time to 1m46.198s.

The third patch extends page cache usage to symlinks by allowing
p9_client_readlink() results to be cached. Resolving symlink is
apparently something done quite frequently during the build process and
avoiding the cost of a 9P RPC call round trip for already known symlinks
helps reduce the build time to 1m26.602s, outperforming the virtiofs
setup.

The last two patches are only here to attribute time spent waiting
for server responses during a 9P RPC call to I/0 wait time in system
metrics.

Here is summary of the different hostapd/wpa_supplicant build times:

  - Baseline (no patch): 2m18.702s
  - negative dentry caching (patches 1-2): 1m46.198s (23% improvement)
  - Above + symlink caching (patches 1-3): 1m26.302s (an additional 18%
    improvement, 37% in total)

With this ~37% performance gain, 9pfs with cache=loose can compete with
virtiofs for (at least) this specific scenario. Although this benchmark
is not the most typical, I do think that these caching optimizations
could benefit a wide range of other workflows as well.

Further investigation may be needed to address the remaining gap with
native build performance. Using the last two patches it appears there is
still a fair amount of time spent waiting for I/O, though. This could be
related to the two systematic RPC calls made when opening a file (one to
clone the fid and another one to open the file). Maybe reusing fids or
openned files could potentially reduce client/server transactions and
bring performance even closer to native levels ? But that are just
random thoughs I haven't dig enough yet.

Any feedbacks on this approach would be welcomed,

Thanks.

Best regards,

-- 
Remi

Remi Pommarel (5):
  9p: Cache negative dentries for lookup performance
  9p: Introduce option for negative dentry cache retention time
  9p: Enable symlink caching in page cache
  wait: Introduce io_wait_event_killable()
  9p: Track 9P RPC waiting time as IO

 fs/9p/fid.c            |  11 +++--
 fs/9p/v9fs.c           |  16 +++++-
 fs/9p/v9fs.h           |   3 ++
 fs/9p/v9fs_vfs.h       |  15 ++++++
 fs/9p/vfs_dentry.c     | 109 +++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c      |  14 ++++--
 fs/9p/vfs_inode_dotl.c |  94 +++++++++++++++++++++++++++++++----
 include/linux/wait.h   |  15 ++++++
 net/9p/client.c        |   4 +-
 9 files changed, 244 insertions(+), 37 deletions(-)

-- 
2.50.1


