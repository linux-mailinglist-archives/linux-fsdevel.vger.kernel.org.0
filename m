Return-Path: <linux-fsdevel+bounces-21715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206EA908FAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B44ADB24919
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9EE1802DF;
	Fri, 14 Jun 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kp0vLtz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD717FAA4;
	Fri, 14 Jun 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381333; cv=none; b=TE9kg3rzaz7ebdqj3JJSvQSC4t7XN27kF1AhiscnIwJ+edoSKg3TDNpxNW2Ftdn5yPJ13fqgPR0tKcxoUbUHvKncw9AWARkeytmAQ6q5i9WWkr6gZKyqWyoZJuAWlJwVxyDdeJ4aFZoE70F4u/7xZEhJJ3cZkG5W7Q71JAhO1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381333; c=relaxed/simple;
	bh=sQjq5cGXIM+nx/P/Mig6SyDdYfM1cXqaGAJW8hcFpKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITSrx6R77KK6mprZbOWN4l/94KOZo5a8Vur3AlecLBwVfxKqJlRUfjqQJz3kjKJG5bCSNpYqf50bFWqEYJA/HvdCGIN8vgA3iN4IGdT006EaincXmFmGhh/CrUQitT/xhn9RVI3RRc6ieQQYmwVBxxf6i2TXr0TM8EPTcln+sMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kp0vLtz+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718381332; x=1749917332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sQjq5cGXIM+nx/P/Mig6SyDdYfM1cXqaGAJW8hcFpKI=;
  b=kp0vLtz+Ap3oPbgg7a7YmczDSSmbVADF+D1PDAJlo82rP7maxZzblaxh
   bvxAf+N0bGwHIL33W+mDjOHPhKon+iI8EkdL5DXJa+MWl9SFAodC2Zi2I
   0DzGm3CbdLq9ha2QZL6mmPXzjPQAK5VR04B+ywT+3tUnCaKaTyI5OETJs
   kyaATRy/2o74n4rZ4McVQGbDIP/9oj1UNA+N7rzfCbS7xXRFwT3iJXjDZ
   yYOWeXl4Hqbrt9xEDTTFsVWBsgydiEZbUswLWg8Q1R0J5UDICQn1IiDq1
   vI6eXtDJg6BvpsCic7iZVv5tcI9YWK53d0WplorsCF3WIdtyeCbj4GFNk
   Q==;
X-CSE-ConnectionGUID: dIWO97gJTJWuGQh36WuJRQ==
X-CSE-MsgGUID: e0xN0nQJRY2fn9ivid6Azg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15399364"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15399364"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:08:51 -0700
X-CSE-ConnectionGUID: T1J/wmeNRcmCOJl+EGfp1w==
X-CSE-MsgGUID: d9hRaR+GSBebOghidcSQJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="71741068"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jun 2024 09:08:48 -0700
From: Yu Ma <yu.ma@intel.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com,
	tim.c.chen@intel.com,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	yu.ma@intel.com
Subject: [PATCH 0/3] fs/file.c: optimize the critical section of
Date: Fri, 14 Jun 2024 12:34:13 -0400
Message-ID: <20240614163416.728752-1-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pts/blogbench-1.1.0 is a benchmark designed to replicate the
load of a real-world busy file server by multiple threads of
random reads, writes, and rewrites. When running default configuration
with multiple parallel threads, hot spin lock contention is observed
from alloc_fd(), file_closed_fd() and put_unused_fd() around file_lock.

These 3 patches are created to reduce the critical section of file_lock
in alloc_fd() and close_fd(). As a result, pts/blogbench-1.1.0 has been
improved by 32% for read and 15% for write with over 30% kernel cycles
reduced on ICX 160 cores configuration with v6.8-rc6.

Yu Ma (3):
  fs/file.c: add fast path in alloc_fd()
  fs/file.c: conditionally clear full_fds
  fs/file.c: move sanity_check from alloc_fd() to put_unused_fd()

 fs/file.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

-- 
2.43.0


