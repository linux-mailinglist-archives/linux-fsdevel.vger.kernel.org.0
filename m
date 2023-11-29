Return-Path: <linux-fsdevel+bounces-4215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 195337FDD51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BA81F20FB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823D3B2BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F6RfF2Iv"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 07:22:31 PST
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B897DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:22:31 -0800 (PST)
Message-ID: <41cf7793-0816-461f-b8c6-82b3eb1cfeba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701270936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlMx2Flg5DmeD4yt+MqEfHfVk9utOQgr1QwsR6mQL1c=;
	b=F6RfF2IvG3WN3WPVfDoTbREVTJz7pTYKfDT6EEtzddlxGE+y+cGvbqILYhDXcyknmTHpkA
	eZT4FwRKGajVqXpoJgLpcCy/G2njcfe4vLIWyWZlvtM1A5rn25+bNhmxs10SStbPEC14Ge
	4xKO38UwjVArPYCNz01YmQjTgJradMc=
Date: Wed, 29 Nov 2023 16:15:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 11/11] blksnap: prevents using devices with data
 integrity or inline encryption
To: Eric Biggers <ebiggers@kernel.org>
Cc: axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Sergei Shtepa <sergei.shtepa@veeam.com>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-12-sergei.shtepa@linux.dev>
 <20231127224719.GD1463@sol.localdomain>
 <6cabaa42-c366-4928-8294-ad261dae0043@linux.dev>
 <20231128171823.GA1148@sol.localdomain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sergei Shtepa <sergei.shtepa@linux.dev>
In-Reply-To: <20231128171823.GA1148@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/28/23 18:18, Eric Biggers wrote:
> On Tue, Nov 28, 2023 at 12:00:17PM +0100, Sergei Shtepa wrote:
>> But I haven't tested the code on a device where hardware inline encryption is
>> available. I would be glad if anyone could help with this.
>>> Anyway, this patch is better than ignoring the problem.  It's worth noting,
>>> though, that this patch does not prevent blksnap from being set up on a block
>>> device on which blk-crypto-fallback is already being used (or will be used).
>>> When that happens, I/O will suddenly start failing.  For usability reasons,
>>> ideally that would be prevented somehow.
>> I didn't observe any failures during testing. It's just that the snapshot
>> image shows files with encrypted names and data. Backup in this case is
>> useless. Unfortunately, there is no way to detect a blk-crypto-fallback on
>> the block device filter level.
> Huh, I thought that this patch is supposed to exclude blk-crypto-fallback too.
> __submit_bio() calls bio->bi_bdev->bd_filter->ops->submit_bio(bio) before
> blk_crypto_bio_prep(), so doesn't your check of ->bi_crypt_context exclude
> blk-crypto-fallback?

Thank you, Eric. You're right.
The filter handle unencrypted data when using blk-crypto-fallback.
Indeed, the I/O unit has an encryption context.

And yes, the word "Hardware" is not necessary.
- pr_err_once("Hardware inline encryption is not supported\n");
+ pr_err_once("Inline encryption is not supported\n");

> 
> I think you're right that it might actually be fine to use blksnap with
> blk-crypto-fallback, provided that the encryption is done first.  I would like
> to see a proper explanation of that, though.  And we still have this patch which
> claims that it doesn't work, which is confusing.

I found a bug in my test. I was let down by the cache.
I redid the test and posted it.
Link: https://github.com/veeam/blksnap/blob/stable-v2.0/tests/8000-inline-encryption.sh

When the bi_crypt_context is detected in the write I/O unit, the snapshot
image is marked as corrupted. The COW algorithm is not executed.
The blksnap code does not allow data leakage.

For a disk with hardware encryption, a block device cannot be added to the
snapshot since the encryption context for the disk will be detected for it.
Unfortunately, it is impossible to detect the presence of a blk-crypto-fallback
when adding a block device to the snapshot.

So, I think that the patch fully ensures the confidentiality of data when
using inline encryption. However, it does not allow to perform a backup
for this case.

If we make a filter handling point in the __submit_bio() function after
calling blk_crypto_bio_prep(), then this will not change the situation for
the case of hardware encryption. But the filter will never know what the
blk-crypto-fallback is being used. I have no opinion whether it will be better.


