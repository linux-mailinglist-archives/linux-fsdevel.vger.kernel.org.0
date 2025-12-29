Return-Path: <linux-fsdevel+bounces-72150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8643BCE5FDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 07:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0EFF300E05D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 06:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3F627055D;
	Mon, 29 Dec 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TJZukidu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881DB1E0DCB;
	Mon, 29 Dec 2025 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766988192; cv=none; b=dPD9boZtBEu7ennOksYay1uTVmwWdvBQNd+Gu1VYqj/500fAxJ3V7P6zSY3vH/kwOX5gZ6OD5tEpKnaT8LSVm8TZ7UgxiIDN7d6muBP5ahM1MOuL0bHkj9W2ZZw2C+fRdl1m6044KJNzFXKqNkWDt9VtvCCpoYAcqBtJPwSTmis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766988192; c=relaxed/simple;
	bh=zoIw/uz794qTdcc6gO2aVWcS7e9lOrxJD2W9xF3+t6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jU3UQCge8oE11TSvv6ozNP1THEY43Ci9xt3pmuOtEHfLP5RI7snoQmEixGZnn/tDptkV+7qZsKDlkaRI1K60S9sSAJo+Cc7yP5bqDpnTZyMl8m2j1zGNjZxcuyzamUt7enixDhCVgyrp+ydA0h4CqlYUb7/Od1nrazQE4VuKnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TJZukidu; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766988184; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iJxH4OCOeFWtnjfeqweXLV+8mUFiFuonHFPczynW64Y=;
	b=TJZukiduog2HZ5g79flUvv2ixajEydNcAyfSyjI6U0y9ubTpJwm01QcjMuOkDzqA8T6pqFKE0uLtHcrW39lUJidP4vNCS1b7OYobSVP2SSNsZoXuGEdbZPfvvI61qeGBKrB8RWfcw2y2/6HQnB3dJP1LfaEYPCwUfcPz32o/MZM=
Received: from 30.221.148.222(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WvovS6L_1766988183 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 14:03:04 +0800
Message-ID: <be2abea2-3834-4029-ba76-e8b338e83415@linux.alibaba.com>
Date: Mon, 29 Dec 2025 14:03:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/2] fuse: compound commands
To: Horst Birthelmer <hbirthelmer@googlemail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>, syzbot@syzkaller.appspotmail.com
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Horst & Bernd,

On 12/24/25 6:13 AM, Horst Birthelmer wrote:
> In the discussion about open+getattr here [1] Bernd and Miklos talked
> about the need for a compound command in fuse that could send multiple
> commands to a fuse server.
>     
> Here's a propsal for exactly that compound command with an example
> (the mentioned open+getattr).
>     
> [1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/
> 

To achieve close-to-open, why not just invalidate the cached attr on
open so that the following access to the attr would trigger a new
FUSE_GETATTR request to fetch the latest attr from server?


-- 
Thanks,
Jingbo


