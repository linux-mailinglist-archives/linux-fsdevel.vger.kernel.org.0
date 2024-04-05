Return-Path: <linux-fsdevel+bounces-16192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9D899DE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 15:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3B31C22F37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5C16D338;
	Fri,  5 Apr 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bsHKARNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BA1370;
	Fri,  5 Apr 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322141; cv=none; b=EGWBeY+40seOkJK0XNq4BzwKS4masOYHxcYt4APePFBmADx3fg8Cw8bGxyaj0GU7bVuByKOXn4zeHIhIwB27BppKQbyJPNfk/PsG2Zoq0rXZHzRB96CfjIGk7JJ+VcYFYV4O8iuA3XdHKAJ5vNW+I13JHnbZmJrz3XKjtZ/WNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322141; c=relaxed/simple;
	bh=0qxne+41P4xydT7YiBxh6DYcIOjLCZo3g8yosL1RhTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxo5VE4w0gcjylfHkCwk/GHgVZn4j5sa/eBtlAmQbdxk/u1BXCzNxlc3eTGWzdV/VkTrjsVbdzQ4ak0pM5TU6uEC52VpM6rv2Z3qOekKsphW5q4BeCTCITCPpb1GmvMRwfPB6KaX6BuTNEfZA8/MaSqKGZVOAdHfyyJfO+qAEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bsHKARNq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712322138;
	bh=0qxne+41P4xydT7YiBxh6DYcIOjLCZo3g8yosL1RhTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bsHKARNqS+OHF4+T+1kHOH7GHkI35avfbG9C1FlCEbDEK3uZ9zafaM3qj+HhJ8lep
	 3DK6D0WttksR1tAoEAoxuhE3LzCnZVDVsgkma3uQbhk9fG0RbTc85fqxAxUV0TJrqR
	 qcKC6IVIdzhNqOKFwXuaBoQ7ZZfzlz0NO+Zaz6pm6JbmNi5+o8UtudjHZ+aYwQvquC
	 kfLMQF4/0MZlKRwnmuw7nWdT+FiPNjBNF3EtUw8VfKyMjPPgMWNQyRjH4IFK4WBFQx
	 MoOHhF0gIIcYbc/nS8+62EPxPNMNd7TnKtUs+ItmLESFUTGLpEADRTESvaMpoTRMKP
	 QaNifUJP3N1lQ==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82AA9378200D;
	Fri,  5 Apr 2024 13:02:16 +0000 (UTC)
Message-ID: <ec3a3946-d6d6-40e1-8645-34b258d8b507@collabora.com>
Date: Fri, 5 Apr 2024 16:02:15 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Cache insensitive cleanup for ext4/f2fs
To: Matthew Wilcox <willy@infradead.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, krisman@suse.de, ebiggers@kernel.org
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <Zg_sF1uPG4gdnJxI@casper.infradead.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <Zg_sF1uPG4gdnJxI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 15:18, Matthew Wilcox wrote:
> On Fri, Apr 05, 2024 at 03:13:23PM +0300, Eugen Hristev wrote:
>> Hello,
>>
>> I am trying to respin the series here :
>> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> The subject here is "Cache insensitive cleanup for ext4/f2fs".
> Cache insensitive means something entirely different
> https://en.wikipedia.org/wiki/Cache-oblivious_algorithm
> 
> I suspect you mean "Case insensitive".

You are correct, I apologize for the typo.

> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com


