Return-Path: <linux-fsdevel+bounces-74432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70472D3A4D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 11:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67C5E3028D7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C502FDC52;
	Mon, 19 Jan 2026 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJ9Wggzd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25732D1911;
	Mon, 19 Jan 2026 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818154; cv=none; b=QWE7UPimXukLVD6jng+OsnSBM5cC3OVi+mtdYI7AaPEuOfv4w1uYjn35igYPFnEHzYflNn8fkybZUIWLzOYrUh66PB4L3m1RJRzqjmzyAsJ/vO6egO3yRxhV+Hq4kjN4+44dTD+G8PaYczhW+7VohsCW3AWBm3iQJGkIl04dC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818154; c=relaxed/simple;
	bh=w9DEPC0wNb3JyBIssTILIglxHqB65HK5X12f/ozmJ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip3FkiAFz1qmL2fw040JTZ61ZAmYwe17o7YPnsqufpQEjbBOTwSO+q+Ev0Gt1YXptBjK8yOK639ofnnIqIhv68O+FFHcvec9lx2cPDe4VAd7Vc626X4bjQ0yZke8PAbRxAvcdsGrEc8saRnMJKfOc3FW7ikDMaFti2Wnmv2+LxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJ9Wggzd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768818152; x=1800354152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w9DEPC0wNb3JyBIssTILIglxHqB65HK5X12f/ozmJ8Q=;
  b=KJ9WggzdNFg9yTWB4rf8CfQOz5DCvg4QSM8EMSIZD6WtDYningrOA2+x
   2aPgeIZMS7b1jfEJ2UCTF4JHO3WHAy3qEqoFKTa87KEw8IyIPLH/PWe7v
   +VOze8YtGx2J1oIxc0TZ2kghHiMl6QNma7Nvvz5J+evHycS3dNWvHZ4zu
   gby8/74fgtZ15uoGY/shxrJOKNvv97DRe92p3GMGkujnWL66Dttv1h2Dv
   tJgJ995nWJydTkvnrUA/aGsrjRHEvmzAW/Khcej8rXjFy9bGQo+WqrvEE
   4V8Bz8ueqYFfCIW4U8h/HsYGfCtZpXXtXSI6OSqdWqbjn99Yc23LlGsi1
   A==;
X-CSE-ConnectionGUID: uAMppOc7RLeqbgKke0MnPQ==
X-CSE-MsgGUID: 1sLoIanbTZGHz192lMRZJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="81469779"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="81469779"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 02:22:32 -0800
X-CSE-ConnectionGUID: 96O6kVZPSJ2/mkBRj6UKTA==
X-CSE-MsgGUID: zBVrWg+/SESBp98w+Tn+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="228769596"
Received: from linux-pnp-server-15.sh.intel.com ([10.239.177.153])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jan 2026 02:22:28 -0800
From: Zhiguo Zhou <zhiguo.zhou@intel.com>
To: zhiguo.zhou@intel.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	gang.deng@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	vbabka@suse.cz,
	willy@infradead.org
Subject: [PATCH v2 0/2] mm/readahead: Changes since v1
Date: Mon, 19 Jan 2026 18:38:08 +0800
Message-ID: <20260119103808.923966-1-zhiguo.zhou@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119100301.922922-1-zhiguo.zhou@intel.com>
References: <20260119100301.922922-1-zhiguo.zhou@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Changes since v1:
- Fixed lockdep_assert_held() usage (now passes &xa_lock)

Sorry for missing this in the v2 cover letter.

Thanks,
Zhiguo


