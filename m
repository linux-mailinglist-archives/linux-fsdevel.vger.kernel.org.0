Return-Path: <linux-fsdevel+bounces-64150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF9EBDAD7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EF974E574E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822FB302750;
	Tue, 14 Oct 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX66bqz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25224DCE6;
	Tue, 14 Oct 2025 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464336; cv=none; b=JxmawfY7WuuJ+fgpb0CDZcJH4sohROyKoYAtI+rP8vdzClUVP0QsHZdaDBTlvhYPMXqpIa/RQC8sea5EXPANynDNPevB4nOqkVMgfX07mMZbmZmSydKZyV3bVDPCYFbhqTqSJOexRnS8vje6lzc0zo2owoDYJZcnaQXmR3mW9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464336; c=relaxed/simple;
	bh=GVdXnKSzFxC1fusf6WmdE8ZRuGvCFvTlScHIB6DDkSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JeE6Q5eTY+oLkvNGeS2ggPOtGa24B/N9GqegHMJ3q/qTHl0Qhy6sowxLH8YYRYcJq7L3sQ67OSaONM6+eJL8i3BVMBLlJqJ9RBtX9mMzoLLl5Fe5HyJTkNzJJyghTrP6rAnM3i+szE8uvSpBrxo37uJZXTeGxZSCSLNtCHdP/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX66bqz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66430C4CEE7;
	Tue, 14 Oct 2025 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760464335;
	bh=GVdXnKSzFxC1fusf6WmdE8ZRuGvCFvTlScHIB6DDkSQ=;
	h=Date:From:To:Cc:Subject:From;
	b=EX66bqz3LCrk7qT3cBb1T22aApDn8VSKyFoPU70HqIhOfow7M3AMIskIcYbOfonHc
	 AhTTn1w1QgbVAukW+n5HUfqFdtZXgHebnQBdfprpAUl/fc9VyGuQa9MHogjRV0pLJI
	 dg+pUPCReF6yINar28kgy0SuoW8rzxdAaQa4cheIyNtHi03/GTl4XvP/BjwRG5zqQa
	 ZXo0VenEAT86IqxhhiqOcGRefG+9NgsvhUGtdPaymhxdvQcg+3Bow+wBcung0drNnL
	 cwaKWwB/BHafig81SxnqIAMgZmFSML42uN3R+EUdGRshV4dM27mdALAORtVhijkeRH
	 pCFiC4XoVaGAw==
Date: Tue, 14 Oct 2025 10:52:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: kirill@shutemov.name, akpm@linux-foundation.org
Cc: linux-mm <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <20251014175214.GW6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there,

On 6.18-rc1, generic/749[1] running on XFS with an 8k fsblock size fails
with the following:

--- /run/fstests/bin/tests/generic/749.out	2025-07-15 14:45:15.170416031 -0700
+++ /var/tmp/fstests/generic/749.out.bad	2025-10-13 17:48:53.079872054 -0700
@@ -1,2 +1,10 @@
 QA output created by 749
+Expected SIGBUS when mmap() reading beyond page boundary
+Expected SIGBUS when mmap() writing beyond page boundary
+Expected SIGBUS when mmap() reading beyond page boundary
+Expected SIGBUS when mmap() writing beyond page boundary
+Expected SIGBUS when mmap() reading beyond page boundary
+Expected SIGBUS when mmap() writing beyond page boundary
+Expected SIGBUS when mmap() reading beyond page boundary
+Expected SIGBUS when mmap() writing beyond page boundary
 Silence is golden

This test creates small files of various sizes, maps the EOF block, and
checks that you can read and write to the mmap'd page up to (but not
beyond) the next page boundary.

For 8k fsblock filesystems on x86, the pagecache creates a single 8k
folio to cache the entire fsblock containing EOF.  If EOF is in the
first 4096 bytes of that 8k fsblock, then it should be possible to do a
mmap read/write of the first 4k, but not the second 4k.  Memory accesses
to the second 4096 bytes should produce a SIGBUS.

I think the changes introduced in the two patches:

 * mm/fault: Try to map the entire file folio in finish_fault()
 * mm/filemap: Map entire large folio faultaround

break that SIGBUS behavior by mapping the entire 8k folio into the
process.

Reverting thes two patches on an 6.18-rc1 kernel makes the regression go
away, but only by clumsily reverting to the 6.17 behavior where the
pagecache touched each base page of a large folio instead of doing
something to the whole folio at once.  I don't know what would be a good
solution, since you only need to do page-at-a-time for the EOF page, but
there's not really a good way to coordinate with i_size updates.

Did your testing also demonstrate this regression?

--D

[1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/749?h=for-next

