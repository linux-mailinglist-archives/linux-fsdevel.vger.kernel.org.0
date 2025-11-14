Return-Path: <linux-fsdevel+bounces-68527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A7EC5E26C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 17:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B837A387A55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976033D6D8;
	Fri, 14 Nov 2025 15:35:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA932C95D
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134520; cv=none; b=FS9tc51jgvjd5zfY8af0hFpkyfuSVidNgbphhitDaxEa24ZuMJ7OXIiE8CE910ZpAi2tRyyrdIxAzpjFVYijLIbTTYyjhPZ/uTpiK99xwg2FMKFOQ+slMQjxh1h/oq3vCn7l6UKhXDGOQk+2kGewBAbD3pJ7wmX67zVm6tB2Sas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134520; c=relaxed/simple;
	bh=vZXmjbR2uNAQJmrA3mkG+YKA2NTfnuSkAR3RfzLI6uk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=d7OArq/+6acPHWph6AbgwjkBJnEKvXNufpvWXKloAIxTyQn0pCmrDcB1jvRqnEM8GEkCiU5/oduwTxId+NDvJNVVCFj93L7dZh1cUY+ZT5QQObHzuwULwVw8lcr4Z68C/SBUe61bcFT070IzAkLm9qmd2VAQNjNwYI6B3Ai9X0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5AEFZ6w5060593;
	Sat, 15 Nov 2025 00:35:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5AEFZ6xo060589
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Nov 2025 00:35:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <125c234e-9ffb-4372-bcc4-3a1fbc93825b@I-love.SAKURA.ne.jp>
Date: Sat, 15 Nov 2025 00:35:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: Verify inode mode when loading from disk
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <10028383-1d85-402a-a390-3639e49a9b52@I-love.SAKURA.ne.jp>
 <bfad42ac8e1710e26329b7f1f816199cb1cf0c88.camel@dubeyko.com>
 <d089dcbd-0db2-48a1-86b0-0df3589de9cc@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <d089dcbd-0db2-48a1-86b0-0df3589de9cc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp

Ping?

Now that BFS got
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.fixes&id=34ab4c75588c07cca12884f2bf6b0347c7a13872 ,
HFS+ became the last filesystem that has not come to an answer.

On 2025/10/08 20:21, Tetsuo Handa wrote:
>> As far as I can see, we operate by inode->i_mode here. But if inode
>> mode has been corrupted on disk, then we assigned wrong value before.
>> And HFS+ has hfsplus_get_perms() method that assigns perms->mode to
>> inode->i_mode. So, I think we need to rework hfsplus_get_perms() for
>> checking the correctness of inode mode before assigning it to inode->
>> i_mode.
> 
> Then, can you give us an authoritative explanation, with historical part
> fully understood?

