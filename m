Return-Path: <linux-fsdevel+bounces-4022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71987FB8C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 12:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B4A282BFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ADA4EB50;
	Tue, 28 Nov 2023 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XDONWV8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4548CD45
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 03:00:22 -0800 (PST)
Message-ID: <6cabaa42-c366-4928-8294-ad261dae0043@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701169221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvcyg4szTb7G/K461C+40gz8EkgFmlMmQb3ja5PYzBA=;
	b=XDONWV8NJC+c5v7IbeGMStXtx1LoYSM5QxxpY48OJsae5eo2InuIzp1RXvU0yd/DZgtNyU
	/VzjNlWo4AUClHh0KCXt6HcVI1dqQr+3/kR42NmS/Yg3qI4nUE9chbSfCzU8Gyzn9wy2ik
	1PDd1dt5thYDxIQXcnKc4EtCZ/Fupt4=
Date: Tue, 28 Nov 2023 12:00:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 11/11] blksnap: prevents using devices with data
 integrity or inline encryption
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
Cc: axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Sergei Shtepa <sergei.shtepa@veeam.com>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-12-sergei.shtepa@linux.dev>
 <20231127224719.GD1463@sol.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sergei Shtepa <sergei.shtepa@linux.dev>
In-Reply-To: <20231127224719.GD1463@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/27/23 23:47, Eric Biggers wrote:
> On Fri, Nov 24, 2023 at 05:59:33PM +0100, Sergei Shtepa wrote:
>> There is an opinion that the use of the blksnap module may violate the
>> security of encrypted data. The difference storage file may be located
>> on an unreliable disk or even network storage. 
> I think this misses the point slightly.  The main problem is that blksnap writes
> data in plaintext that is supposed to be encrypted, as indicated by the bio
> having an encryption context.  That's just what it does, at least based on the
> last patchset; it's not just "an opinion".  See
> https://lore.kernel.org/linux-block/20a5802d-424d-588a-c497-1d1236c52880@veeam.com/

Thanks Eric. Perhaps I formulated the thought inaccurately. The point is that
blksnap should not be compatible with blk-crypto. Changes in version 6 do not
allow to take a snapshot with a device on which the encryption context is
detected. Additionally, protection is implemented in the bio handling code.
For bio with bi_crypt_context, the COW algorithm is not executed.
> 
>> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
>> +	if (bio->bi_crypt_context) {
>> +		pr_err_once("Hardware inline encryption is not supported\n");
>> +		diff_area_set_corrupted(tracker->diff_area, -EPERM);
>> +		return false;
>> +	}
>> +#endif
> The error message for ->bi_crypt_context being set should say
> "Inline encryption", not "Hardware inline encryption".  The submitter of the bio
> may have intended to use blk-crypto-fallback.

I was looking at the blk-crypto-fallback code. I tested the work in this case.
Encryption is performed before the bio gets to the block layer. So, the filter
receives cloned bios with already encrypted data. Therefore, the text of the
message is correct.

But I haven't tested the code on a device where hardware inline encryption is
available. I would be glad if anyone could help with this.
> 
> Anyway, this patch is better than ignoring the problem.  It's worth noting,
> though, that this patch does not prevent blksnap from being set up on a block
> device on which blk-crypto-fallback is already being used (or will be used).
> When that happens, I/O will suddenly start failing.  For usability reasons,
> ideally that would be prevented somehow.

I didn't observe any failures during testing. It's just that the snapshot
image shows files with encrypted names and data. Backup in this case is
useless. Unfortunately, there is no way to detect a blk-crypto-fallback on
the block device filter level.

Maybe my tests aren't enough. The next step I think would be great to add
new tests to xfstests.

