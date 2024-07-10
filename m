Return-Path: <linux-fsdevel+bounces-23522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF22892DB58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 23:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7197E281F3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84F12CD88;
	Wed, 10 Jul 2024 21:57:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483E3D556;
	Wed, 10 Jul 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648647; cv=none; b=mdmPRycde4b9KoZ/RHAgm1JcSwCaUbVTTtIQDeHmRvMnBcHmSnKqOTne94UKU4w7zsjayRrJwhj+NaLROGxYMU5BqFcmpcSqT+u7U3on5LlqxFfKKw69eizfgYA+Ecm6CfzS4XDhQgVzZkeNw5zmNYs92YOxVNP25hHauex0beo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648647; c=relaxed/simple;
	bh=sjBWqb0bVT2gDJ1EQqCo79D2OjzIHkiqtKnG9vgSq90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXTqIPP8s36OUcRGqYlbwpuoyEhOrkH7PY3LG2DHHbIleuhKORzfM7Nd1Q3lfk2hOzPziIjM7X0wnFZHo8lcjFVTZwgvmqOTHbRULe0ObokU4TYqYgmMBk5DAhJTsZ4F75tXsFRjla7bKxyTwOrl3pDRhtOtUtXwLFRiygCyQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basealt.ru; spf=pass smtp.mailfrom=basealt.ru; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basealt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basealt.ru
Received: by air.basealt.ru (Postfix, from userid 490)
	id AD6D82F20249; Wed, 10 Jul 2024 21:57:19 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.102] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id A925C2F2023F;
	Wed, 10 Jul 2024 21:57:18 +0000 (UTC)
Message-ID: <cd942b65-b6d7-0e0f-be4d-c3b950ee008f@basealt.ru>
Date: Thu, 11 Jul 2024 00:57:17 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH fs/bfs 1/2] bfs: fix null-ptr-deref in bfs_move_block
To: Markus Elfring <Markus.Elfring@web.de>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, dutyrok@altlinux.org,
 linux-fsdevel@vger.kernel.org, lvc-patches@linuxtesting.org
References: <20240710191118.40431-2-kovalev@altlinux.org>
 <8fd93c4e-3324-49b6-a77c-ea9986bc3033@web.de>
Content-Language: en-US
From: =?UTF-8?B?0JLQsNGB0LjQu9C40Lkg0JrQvtCy0LDQu9C10LI=?=
 <kovalevvv@basealt.ru>
In-Reply-To: <8fd93c4e-3324-49b6-a77c-ea9986bc3033@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

10.07.2024 23:09, Markus Elfring wrote:
>> Add a check to ensure 'sb_getblk' did not return NULL before copying data.
> 
> Wording suggestion:
>                          that a sb_getblk() call
> 
> 
> How do you think about to use a summary phrase like
> “Prevent null pointer dereference in bfs_move_block()”?

Ok, I'll change it in the next version:

bfs: prevent null pointer dereference in bfs_move_block()

Add a check to ensure that a sb_getblk() call did not return NULL before 
copying data.

> 
> …
>> +++ b/fs/bfs/file.c
>> @@ -35,16 +35,22 @@ static int bfs_move_block(unsigned long from, unsigned long to,
>>   					struct super_block *sb)
>>   {
>>   	struct buffer_head *bh, *new;
>> +	int err;
> 
> Can a statement (like the following) become more appropriate for such
> a function implementation?
> 
> 	int ret = 0;

Yes, thank you.

> 
> Regards,
> Markus
-- 
Regards,
Vasiliy Kovalev

