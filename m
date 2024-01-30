Return-Path: <linux-fsdevel+bounces-9535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300E3842680
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 14:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851F3B23281
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE446D1D5;
	Tue, 30 Jan 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFU7CFNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9C6BB32;
	Tue, 30 Jan 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622831; cv=none; b=ApjgnNSD3PkQrQq5y4rR0erBWeWjo/xhAzIJiT4tbTZ4+xovmZY/0/5P65vXa4JtKeJnvwQQlDtV/GyNN2Z8bHnOCJYGc7bCnvnkFzZXOZEwPbvJb8DGUSrUk3ZgdR7vrVaxjTsz/CQCTIXZCEQO14OFQ9D4WKsRjmnerxe/Jcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622831; c=relaxed/simple;
	bh=Rbw0bjfu1YktFDI3J38DN6TV3tsl1n6Ebrxsm9br8vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIIiysiDSG2SKcR1eb1bJqZ28HtBzfiriuAnW7cjwkH7us+FCNCBVER8NfBanZjsDE815aKigtTIl+gSrJC6HDTZ+eP0luOd83RRCt+nYDCRg0VFZ8Q4vYOGuciqa9csmw4UFLL+UYV1/9+rCl1MwF7t0f/gFrMJ1ivY6ud+98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFU7CFNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFFFC433C7;
	Tue, 30 Jan 2024 13:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706622830;
	bh=Rbw0bjfu1YktFDI3J38DN6TV3tsl1n6Ebrxsm9br8vc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OFU7CFNorhBVGsTPusWn+2sB59iM24W5vkZAelhW2wpuZbetl9L3u54yCOub2dJNr
	 4tR1g6rPlZAcL3IbMmvOpicB5iUYFwNPTt3zuEXOuckwfjU4q92d9YbEJU4W/+vJg0
	 yT4sbK1J2OlRyJyPWINGU8yABBlFPqvJHesziCxX2i9Dg/pdNyYVISyPtXOocB6K8P
	 HhTsWJKCHgBOBKZWmKHpUr9kdTuYLufJ3J0qIQW8kucynqyYgc1WrPtZCaLsT0O5J/
	 4CEC8NxeW5fU0wNp3GsuuaZD0/Dw/oLlo0Ci4Zd0/7wqV8Rj5gGG+pYi5PVYUjug57
	 3OJbAaIpsws4Q==
Message-ID: <b8be6eb7-05de-49a0-bdc0-b4d16dfe2966@kernel.org>
Date: Tue, 30 Jan 2024 22:53:45 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 1/1] block: introduce content activity based ioprio
Content-Language: en-US
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Niklas Cassel <niklas.cassel@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 steve.kang@unisoc.com
References: <20240130084207.3760518-1-zhaoyang.huang@unisoc.com>
 <aa307901-d20a-4301-8774-97287d7192e9@kernel.org>
 <CAGWkznFG003aQ3-XAzdmGev7FP6x5pvp=xS8Z9sZknUHZEGHow@mail.gmail.com>
 <a538044b-5fc2-4259-9cad-3fc67feaae6d@kernel.org>
 <CAGWkznHk2GBrpc6w1az5Q59xj5BoVNrCoD4c=BQ4Jqe2QmkoVg@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAGWkznHk2GBrpc6w1az5Q59xj5BoVNrCoD4c=BQ4Jqe2QmkoVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/24 22:28, Zhaoyang Huang wrote:
>> That information does not belong to the ioprio. And which scheduler acts on a
>> number of pages anyway ? The scheduler sees requests and BIOs. It can determine
>> the number of pages they have if that is an information it needs to make
>> scheduling decisison. Using ioprio to pass that information down is a dirty hack.
> No. IO scheduler acts on IOPRIO_CLASS which is transferred from the
> page's activity by the current method. I will implement another
> version of iterating pages before submit_bio and feed back to the list

Then why are you modifying the ioprio user API to add the 7 bits of activity ?
If the scheduler only needs the priority class, then only set that and do not
touch the user facing API.

-- 
Damien Le Moal
Western Digital Research


