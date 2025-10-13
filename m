Return-Path: <linux-fsdevel+bounces-63934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA6FBD1FBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 852E14ED3B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555162F28F7;
	Mon, 13 Oct 2025 08:18:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com [101.71.155.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A22E8DFE;
	Mon, 13 Oct 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343533; cv=none; b=fJ6XmdNisgKsfBshY26r5VUg8qnSX0/uPiZvRWULPzvrnHk4XZgT2VBN+l2UkZOvkvBpinyR33nBqSE2y3kjO5YuZBvcQbnySrYASth1OZUbRO4cUsnNjsPZQYRdluVOy+EElapfVy7r3pLQxp15RThmhFOg+1c8hrGIBEvWCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343533; c=relaxed/simple;
	bh=qphfDqWdBhdaHU7xGqiaEpSTwPrgSCHIq1QcZtQ6iaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rq1dyqihFa+FWq5/L3MlSbQB1yYsWJKv4aw5YbWr9myHMIevuwEY8XKzLOtkdKxo9mCWms5d1fLF0R1uSslaCsY87IlKy671YvJ28oK+6U4jhRu0jSlzI7Sn37XPMiaEli/HscGgubPgOSz4SOllx+zc+rFl0OJXLbMtomr+tNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=101.71.155.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.18] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 116f3f6a0;
	Mon, 13 Oct 2025 11:42:39 +0800 (GMT+08:00)
Message-ID: <49645a87-b785-4538-8615-ff5b4a36d605@easystack.cn>
Date: Mon, 13 Oct 2025 11:42:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pidfs: fix ERR_PTR dereference in pidfd_info()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20251011072927.342302-1-zhen.ni@easystack.cn>
 <5asnajyk3d4c66fnpmodybc7rrprhvw4jy2chrihnlcgylu5uf@hfcw24zm2w7k>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <5asnajyk3d4c66fnpmodybc7rrprhvw4jy2chrihnlcgylu5uf@hfcw24zm2w7k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99dba9c2ec0229kunme7785e8125c24d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTklLVklMTEgaGElCHkpJSlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVCQklOS1VKS0tVSk
	JLQlkG


在 2025/10/11 17:24, Mateusz Guzik 写道:
> 
> Is that something you ran into or perhaps you are going off of reading
> the code?
> 
> The only way that I see to get here requires a file with
> pidfs_file_operations, so AFAICS this shouuld never trigger.
> 
> In the worst case perhaps this can WARN_ON?
> 
> 

Thanks for the review.

I did not hit this in real testing, but only inferred the potential 
issue from reading the code context. After taking another look at the 
call paths into pidfd_info(), I agree this is indeed an over-defensive 
check and not actually reachable.

I'll drop this patch. Thanks for the clarification.

Zhen

