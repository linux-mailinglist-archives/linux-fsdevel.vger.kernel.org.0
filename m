Return-Path: <linux-fsdevel+bounces-46317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B5A86DAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 16:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02313189B2F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5E1EA7CF;
	Sat, 12 Apr 2025 14:21:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DB1581F8;
	Sat, 12 Apr 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467714; cv=none; b=jJcZ1oaluEqESbornvsdPZmVEBeEQm0nBIiOTnkdwBLnHiGGUE1Pf1gDH8YNvcdj6GsmO1m0YVMjqVoz2vZQf616E1F78zJstTAp39FwEzAHtYjNLk04E/mvaVLPJkUpovSua2YGZILc2aoB6IsuBlQepjWTkX2zEbCBlFmjrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467714; c=relaxed/simple;
	bh=l373vlT6AMSMRn8u5U5+ng6JketZRF6vF9pVWEl5U5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Leg2sz/5oIaiNVdahIwicpmJAn2VPKxM75GfR+q4/QeaEjtGM/HUyu34pRc7otmLtqh4lYS/kKf+j1da6wtZdlvTsmun1ejk4/hokKXHbvUIQHXdgq1HkKdy20Gwzfs6tcQRG46sRqEAjvPvmgCZiT6W7OMvgBELRJzhIhvmyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 53CELT12035924;
	Sat, 12 Apr 2025 23:21:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 53CELSZJ035919
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Apr 2025 23:21:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c9014d1e-c569-4a7a-aa68-d7c32e51d436@I-love.SAKURA.ne.jp>
Date: Sat, 12 Apr 2025 23:21:25 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix false warning in inode_to_wb
To: Andreas Gruenbacher <agruenba@redhat.com>, cgroups@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Rafael Aquini <aquini@redhat.com>,
        gfs2@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250411173848.3755912-1-agruenba@redhat.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250411173848.3755912-1-agruenba@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

Please add

  Reported-by: syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com
  Closes: https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7

to both patches.

Also,

  -static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
  +static inline struct bdi_writeback *inode_to_wb(struct inode *inode)

change is not needed.


