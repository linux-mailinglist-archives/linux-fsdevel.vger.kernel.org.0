Return-Path: <linux-fsdevel+bounces-13834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB287456C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 02:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00605284227
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 01:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560DF4A22;
	Thu,  7 Mar 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiH6G+ET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606A17F0;
	Thu,  7 Mar 2024 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773497; cv=none; b=uvfw3GApyP/mc6p5Dmqhj079op7XM5Z3Ryr4xNmtNUSIC5wiWoE4Dngy4gSHcC5MnVJfFJLF2npLb3VQifSYAnfPKVPcA5+wHlwhA/8vL82StD7L3v72Qk2/wDSQ01o3xazLAz04BIAw6RbHwbc0vo3hU18zVOJJ0fVg1iBS01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773497; c=relaxed/simple;
	bh=KRNYnI2A/lUFgun5k7wE4UrYIdybMwijj6R/qDSCeZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB6+3YMe0d81/AbDB9yVI1g/Cp511dbRDHHTHZr7F+6ZBIN2WR//nyvFX1GW+zcQ1EY6WFcRQLR+aKy+krn9txCEvqGmls4eJKAcRLPWnN7rt3shkpcTVxGS9Mkx1vOEYsW0A47yvDqcuIrZBTCh9vgA5SIuRryR9Na4x0ZW97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiH6G+ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B37C433F1;
	Thu,  7 Mar 2024 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709773497;
	bh=KRNYnI2A/lUFgun5k7wE4UrYIdybMwijj6R/qDSCeZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZiH6G+ETOyZM0VO7hul+UjqZ0cYMlFKz+QsJhq3ppKDKymEUXtDnBLms4P7OCsC2M
	 5sUs/ok9+Ksl4YgYSKgO7CEjCVpchJJXXYE9rSym7HaIJplf6NDjspxxs3rIR+X4io
	 c7SOh5NfSnUypMyoRfXH2Rmi284It9KRuhEr8Yg2Djrbk5wa3JW21Y2pLjsU7Gdfwx
	 ISIJC9idx9S2Q5cEKgCvC6+qv5ge8F0byi1sTF9479I6p5rql+vXlT0pUWZ5LFN3oU
	 uchyWcXWEidmNjniEptrGgPjucWdG6FhYpWjaQss5S34drn9FYgBtjQJYDW8cGIr91
	 /SOUdWPc7iBew==
Message-ID: <b0c76d40-7cd0-46da-b4fb-1ee3f9fdd0e1@kernel.org>
Date: Thu, 7 Mar 2024 09:04:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-fsdevel@vger.kernel.org
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
 <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/4 11:53, Gao Xiang wrote:
> syzbot reports a KMSAN reproducer [1] which generates a crafted
> filesystem image and causes IMA to read uninitialized page cache.
> 
> Later, (rq->outputsize > rq->inputsize) will be formally supported
> after either large uncompressed pclusters (> block size) or big
> lclusters are landed.  However, currently there is no way to generate
> such filesystems by using mkfs.erofs.
> 
> Thus, let's mark this condition as unsupported for now.
> 
> [1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com
> 
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
> Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

