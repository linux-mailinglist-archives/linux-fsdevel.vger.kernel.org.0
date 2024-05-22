Return-Path: <linux-fsdevel+bounces-19983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEC78CBC6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 09:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE151C2160D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640678002A;
	Wed, 22 May 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="WwyV/xR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D467FBA3;
	Wed, 22 May 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364382; cv=none; b=FLK2EZrTwA89kOXuFfZg7M7l7QFzFIW7hdPqn9c3fM3LUnAZ7ZKx4CKcA/4o9UKQJiS+S5nMDo/vsYhZ+b6LFQn2CR/WAgKZnrRXhSr/8tgJf2tCdk+tVgjVjwvIyru7AxubJVdk1sHaqQxWsp/Yni9TYAfk4VEizvMZHB+W3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364382; c=relaxed/simple;
	bh=7hh+JKNoOSYUXcr16/GBfPDuDDEZW0YlbjXrngNmoH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OohshTE6jkkqis6Nm2c8DU4JiXo0xpDGwT+XUQxkEPbrWH/ZlcirOS0b8FziU9sFCPwP/Mxm5s0/GAHrlh5dN+EYyg6oHABRKdNuI4VnWff/EAADHyupnExxMCVuH9d7Oal5M/eWaAm6+19EuI0wifAi/xjxDNcvT56lQ9EXWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=WwyV/xR4; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1716364381; x=1747900381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AIWEN8D6NjuFU1bmJszkWUHQ/Up5x+riI0D821zKlIY=;
  b=WwyV/xR4c75UOFx+GWT2T38o/ljVHJ5fchnxWh+NHsZDuOQ5zOExLujA
   RW09m+6KapekXKJ6Rz+EOM2AWvh5/D+fP7CVA2oMNYzZT3ZZjT0wA0xtm
   CkKFjcJV0FZsONrNgDtDUpOc1asPwPDlnboa/r3eiDKsWanQLOiF1qM1R
   33pYdwL1solHzWvy29DC3h5k5MkkoZMymGx4dTSFV2JSUUnRvedj2DszP
   zTZmgiIHMLgSvblXz93m43zmnh8+hePJtAqJkfJrcMW1YKXFbA/hEz4IR
   Ncs0sx/YsTaw/tqjGRYUuOAxid96sn57poiq0hSIfWqzQnv2x9yjzEdBG
   A==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:42:51 +0900
X-IronPort-AV: E=Sophos;i="6.08,179,1712588400"; 
   d="scan'208";a="415026695"
Received: from unknown (HELO OptiPlex-7080..) ([IPv6:2001:cf8:1:5f1:0:dddd:6fe5:f4d0])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 22 May 2024 16:42:51 +0900
From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sukrit.Bhatnagar@sony.com
Subject: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Date: Wed, 22 May 2024 16:46:56 +0900
Message-Id: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to use a swapfile for hibernation, I noticed that the suspend
process was failing when it tried to search for the swap to use for snapshot.
I had created the swapfile on ext4 and got the starting physical block offset
using the filefrag command.

Upon looking at the swap activation code, I realized that the iomap part is
doing some rounding up for the physical offset of the swapfile.
Then I checked the block size of the filesystem, which was actually set to
1KB by default in my environment.
(This was in buildroot, using the genimage utility to create the VM disk
partitions, filesystems etc.)

The block offset is rounded-up and stored in the swap extents metadata by
iomap code, but as the exact value is lost for 1KB-block filesystem, hibernate
cannot read back the swap header after it finishes writing data pages to swap.

Note that this is not a bug in my understanding. Both swapfile and hibernate
subsystems have the correct handling of this edge case, individually.

Another observation was that we need to rely on external commands, such as
filefrag for getting the swapfile offset value. This value can be conveniently
printed in dmesg output when doing swapon.

Sukrit Bhatnagar (2):
  iomap: swap: print warning for unaligned swapfile
  mm: swap: print starting physical block offset in swapon

 fs/iomap/swapfile.c | 10 ++++++++++
 mm/swapfile.c       |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.34.1


