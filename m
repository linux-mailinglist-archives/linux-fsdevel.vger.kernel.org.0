Return-Path: <linux-fsdevel+bounces-68742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F175CC64B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 111B24E904A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818F336EFB;
	Mon, 17 Nov 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6MALg+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214F3321D0;
	Mon, 17 Nov 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390746; cv=none; b=Z7DaMabbZRhCQjsyXml9xQUqEx2n06FOQKnmRMAiTvJG4yIh1PmeKBS8g+9HvZRssT9AHMHBsmmwrPFH35vKzIl11kF9fj46Dwt+s6xlBl7eIfTEdsU6BUlOyCAzJjIyCtb5UCnih4Z75mrKEaJwd68kUEf8+4w/ayCLh6WfX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390746; c=relaxed/simple;
	bh=/K5e1poZgeueHnAzrmxtpqrdShGcHhMy8Vl6QQkoEyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkHKWZDRfx16L1XR09Bc/EHslKUpRVusRRcFOuKL0PZrk3WNRX5gzh7D55NQ0020oEfdMttE/3GjfA+3YkCfy3BpM63mkhS6mrQPQQl2/u7taIJ59hXC23vasDjnJ44qp+YaLZ3WkavfYRlmwet0UJfq3yzvM29BWVaD4pU8p+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6MALg+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF9BC19422;
	Mon, 17 Nov 2025 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763390745;
	bh=/K5e1poZgeueHnAzrmxtpqrdShGcHhMy8Vl6QQkoEyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6MALg+vu/1y36ZDBRYpFR9kNBTDl1/iAfZ0OoKLBEBf0BrAn0stvqtwwAR1P2OVU
	 f9ZUDTWEV4g2d27WchRSFdz2uTaXpe21if3rVsirbM9dEPcXj9pNBB+UjGts7c8V+b
	 o1Z41iiP9RYXoql+7GeZZpdGS5K5JwCnzE8tPJ2hVi3SCbx1/vCY9ALyoF5wI6GzTP
	 k3uRL5Bcdqv0OYJ1JJtCOZBIbixGOoa+3JZNhYjrindaLS9FFqwflaOXHMRwWYZ6Ic
	 uZi+G13poTVmghJheuQMWf53Hs+Fw2Nhmvc76g8HuRgrC3bCD/Erk6KBJiylMAxpHj
	 ponaRyy+0kcWQ==
From: Sasha Levin <sashal@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 5.10.y] fsdax: mark the iomap argument to dax_iomap_sector as const
Date: Mon, 17 Nov 2025 09:45:42 -0500
Message-ID: <20251117144542.3872352-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109114703.16554-1-farbere@amazon.com>
References: <20251109114703.16554-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: fsdax: mark the iomap argument to dax_iomap_sector as const
Queue: 5.10

Thanks for the backport!

