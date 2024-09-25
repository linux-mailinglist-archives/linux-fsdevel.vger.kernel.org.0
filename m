Return-Path: <linux-fsdevel+bounces-30115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED569864EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DCA28C025
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DF71B3A;
	Wed, 25 Sep 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NbrkOdBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25019381AF;
	Wed, 25 Sep 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282139; cv=none; b=pqGFx/tRvXt6nYSASuNJ8nYOWYRQp1GdNq3uKE/LcfUadfE7KnssLUGFvpwV8TtOS1tGD4uMR89ILkZP/wTsTZy1DpiJeIdKzGB3Y+yC8LBQlLB6X0Xl3GFH0sK5v+QJwKvICFMhrHC/5oDlS3vyHajv9zXXUl5RxUB7YgQ19oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282139; c=relaxed/simple;
	bh=HMxBVux/FQvn7pBMChSCMMhWMsYbvTHrT3oR2wbLjA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePN0rpvTwQl0+yzFkcMynoRt/QSQAHV9bF3TxLawTE3zXSXxkaAj31sv0vbXisimLBm8XXt8dubrR3/fgwTYjVq2aQ81d7HfiVYwl6l5FCuPlJDQkrNh/59l3GbCArQlD7qbRZXOq18yrqs6KYommVxsksAOATbqylwPTt2aEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NbrkOdBZ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727282128; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E6ocSw4NWKlqHxKRP24Nwyb3i7XLZtOr82Y4AE+Iu6Q=;
	b=NbrkOdBZ24/y4whkZwn5YCaXeYH6TXhl0h2Kuyy3Z636t8CsZXZ2j1LENJ2FWDoeDAEBI4huVxVFHeDm38AiXcY09kW6z710Kn53l9I0EweGbvvZa1Bfk/jC/jjU/f3PZ0+Ya8+/w9UwrTxAA71dmItB9fYGH7/kQgizVr66nLo=
Received: from 30.244.99.85(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFkHUjQ_1727282125)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 00:35:27 +0800
Message-ID: <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
Date: Thu, 26 Sep 2024 00:35:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>, Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, Yiyang Wu <toolmanp@tlmp.cc>,
 rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ariel,

On 2024/9/25 23:48, Ariel Miculas wrote:

...

> I share the same opinions as Benno that we should try to use the
> existing filesystem abstractions, even if they are not yet upstream.
> Since erofs is a read-only filesystem and the Rust filesystem
> abstractions are also used by other two read-only filesystems (TarFS and
> PuzzleFS), it shouldn't be too difficult to adapt the erofs Rust code so
> that it also uses the existing filesystem abstractions. And if there is
> anything lacking, we can improve the existing generic APIs. This would
> also increase the chances of upstreaming them.

I've expressed my ideas about "TarFS" [1] and PuzzleFS already: since
I'm one of the EROFS authors, I should be responsible for this
long-term project as my own promise to the Linux community and makes
it serve for more Linux users (it has not been interrupted since 2017,
even I sacrificed almost all my leisure time because the EROFS project
isn't all my paid job, I need to maintain our internal kernel storage
stack too).

[1] https://lore.kernel.org/r/3a6314fc-7956-47f3-8727-9dc026f3f50e@linux.alibaba.com

Basically there should be some good reasons to upstream a new stuff to
Linux kernel, I believe it has no exception on the Rust side even it's
somewhat premature: please help compare to the prior arts in details.

And there are all thoughts for reference [2][3][4][5]:
[2] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2369872133
[3] https://github.com/opencontainers/image-spec/issues/1190#issuecomment-2138572683
[4] https://lore.kernel.org/linux-fsdevel/b9358e7c-8615-1b12-e35d-aae59bf6a467@linux.alibaba.com/
[5] https://lore.kernel.org/linux-fsdevel/20230609-nachrangig-handwagen-375405d3b9f1@brauner/

Here still, I do really want to collaborate with you on your
reasonable use cases.  But if you really want to do your upstream
attempt without even any comparsion, please go ahead because I
believe I can only express my own opinion, but I really don't
decide if your work is acceptable for the kernel.

> 
> I'm happy to help you if you decide to go down this route.

Again, the current VFS abstraction is totally incomplete and broken
[6].

I believe it should be driven by a full-featured read-write fs [7]
(even like a simple minix fs in pre-Linux 1.0 era) and EROFS will
use Rust in "fs/erofs" as the experiment, but I will definitely
polish the Rust version until it looks good before upstreaming.

I really don't want to be a repeater again.

[6] https://lwn.net/SubscriberLink/991062/9de8e9a466a3faf5
[7] https://lore.kernel.org/linux-fsdevel/ZZ3GeehAw%2F78gZJk@dread.disaster.area

Thanks,
Gao Xiang

> 
> Cheers,
> Ariel


