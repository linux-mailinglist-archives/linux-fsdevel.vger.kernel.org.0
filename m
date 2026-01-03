Return-Path: <linux-fsdevel+bounces-72346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A91CF02EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 17:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D07301FC32
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2430C61B;
	Sat,  3 Jan 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="gZMA/+AF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJg9uxpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132EA219E8;
	Sat,  3 Jan 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767458832; cv=none; b=TuXWQm5BCxxef/nBkKVef92sn1/wOF9574GszGcl3nWpgdruzFLGe03z87yjrKvS5kbjEI6LstJimKrtgvZOy313HR004SGBVZHizkSAiDxtdihQloE6ls3YrnMyE5BaYyYYiQMQtBpNptweYPv1Q3xgtYEFdgTeoaiAL+bXI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767458832; c=relaxed/simple;
	bh=5zzZg4ftP/RDwNwvb8ntptCgZesOs3J8ST89Ao1+EqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXUWvmkbeGQp6G3wN55rbrdILaxHMo8/1jf69qk+V4pcPiqChovN2NvaRyWe8kWwVP6zOgVLANOXe6yaXjTlaCsYxl2/dvhcWBwREg59rk2KYLPAHNZmRP6mDUHatMQhmd7CwPBNCW0zRnuhY9B1HbnalqQxnlHyk/BdJ/y6Jag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=gZMA/+AF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJg9uxpQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 32871EC00E1;
	Sat,  3 Jan 2026 11:47:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 03 Jan 2026 11:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767458829;
	 x=1767545229; bh=WTUOQQm6UsxqaMpDq0CQ4OAYNUWJGIRIM81h92+zEJg=; b=
	gZMA/+AFqFHGcTcoA7ZJH7mrW38gQfniFt4fiGTx/vTYWJxssKBgFQXWcoTazqR7
	HSqRCC+4aXygPHsxplk1Lfg4iNubNiUXafTTafpmgN2ZDwqGTSY96xjlv1hZ+s2R
	mLP4iTL5+Z0WE0Plr7tklGIApVV/o0E5CIdvniblA528Y7HzrD9biOyFNdWGcNaQ
	UTIqekYWXNCpRM0OgqFLJI8kAf/1L3tbTKo/VhplNx3qvsk8HkAXerCxuwc34IfI
	WlzoSRh5wssMsKWkzLpIO1hW9gQ6PBXwOLfuSdIKahihYz0hjC6qyaJ0kTu7Rho9
	78xCF2cSqc0+fcqHRf7YIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767458829; x=
	1767545229; bh=WTUOQQm6UsxqaMpDq0CQ4OAYNUWJGIRIM81h92+zEJg=; b=d
	Jg9uxpQsI9ZFgpjkTp7jpIX3rQH63dCa2LJ5oECrg44EKo3KWsc1LbwmRMEqTe06
	1HE4cl3Efk45BROJK9faPP+pQ4AY4zRzj2Shtzf+OY8tPZ+85R6iji30jT5KSnZj
	hadLo4FmT2T8LAeTmS0Vn7C4RFMUGUyUiML8tZrlvp7wErZDp1WtXZxkg3fveOFB
	XndZ0CDbXaNthGXRWJhnX1bkxrvVOkK/CptiJh9NCEJ/88SbO5EUxrquCYDpn3Du
	AF5Z8Bu3mmvyIVLLQPiwqjzSzoCXPyRRkY79v+IOtomxJg1gBg8TIuhmloVff5tm
	AvtVMUFss1yO04QrXsdog==
X-ME-Sender: <xms:DEhZaUJA7dwqPk3adjIAhOIZjz--hj-MpdqrFdj7iXZAOfEQSo7UtA>
    <xme:DEhZadcXhZVvc--cn9i0wxN-27Wy7c0J92BxUcbRXT235IjgrdNOoApKKuoEWITKt
    TGOnT-64btCDUsdaurxXnDOW7xu4AsWYPIoefEsRA_gZ-hcW2O92w>
X-ME-Received: <xmr:DEhZab8fwA8AW7cysSS05lY-_bYYcci35rLeqQkoyro8r_zcQpNZA8gXLJ-D2UXftaz12CcgvEf5QmsVoYa0IdsghlpvXQroGFOpSfY8Ac6GRUjXig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelvddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepteeigfekgfetgeelvdejieeuheffhfejkeejgfehjeejjeegueduhefgleeg
    vedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnuges
    sghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhroh
    hnihigrdguvgdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:DEhZaSo9l8YDYBb0Ru-KG475HUIo8kIjSuvf7ACl2Mp1ZrXS7Ct1ag>
    <xmx:DEhZaYA9GUwNEUnmBSHR8NIViH1LmepZcTp9r4w_Y8mnOVqh7jhdTA>
    <xmx:DEhZacwzzsQLY8eI9_k_fOCnPrYuSVvVe-5cIxqp-523-ipGBqlDAQ>
    <xmx:DEhZad0xqaFJJSzxjeIeFOX3Uj-Y83PkPrk-YlL9ot1x_MJJw--zlQ>
    <xmx:DUhZaZl0LwtUHP5XlmxkOteqhRX8CPLcnl5aceFcDkwPgo2jYxfqei1P>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 11:47:07 -0500 (EST)
Message-ID: <65531518-b889-46b8-8e1e-09e626222a4a@bsbernd.com>
Date: Sat, 3 Jan 2026 17:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: David Laight <david.laight.linux@gmail.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <20260103141025.2651dbbd@pumpkin>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260103141025.2651dbbd@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/3/26 15:10, David Laight wrote:
> On Fri, 2 Jan 2026 23:27:16 +0100
> Bernd Schubert <bernd@bsbernd.com> wrote:
> 
>> On 12/30/25 13:10, Thomas Weißschuh wrote:
>>> Using libc types and headers from the UAPI headers is problematic as it
>>> introduces a dependency on a full C toolchain.
>>>
>>> Use the fixed-width integer types provided by the UAPI headers instead.
>>> To keep compatibility with non-Linux platforms, add a stdint.h fallback.
>>>
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> ---
>>> Changes in v2:
>>> - Fix structure member alignments
>>> - Keep compatibility with non-Linux platforms
>>> - Link to v1: https://lore.kernel.org/r/20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de
>>> ---
>>>  include/uapi/linux/fuse.h | 626 +++++++++++++++++++++++-----------------------
>>>  1 file changed, 319 insertions(+), 307 deletions(-)  
>>
>> I tested this and it breaks libfuse compilation
>>
>> https://github.com/libfuse/libfuse/pull/1410
>>
>> Any chance you could test libfuse compilation for v3? Easiest way is to
>> copy it to <libfuse>/include/fuse_kernel.h and then create PR. That
>> includes a BSD test.
>>
>>
>> libfuse3.so.3.19.0.p/fuse_uring.c.o -c
>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
>> format specifies type 'unsigned long' but the argument has type '__u64'
>> (aka 'unsigned long long') [-Werror,-Wformat]
>>   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
>> ", result=%d\n",
>>       |                                                       ~~~~~~~~~
>>   197 |                          out->unique, ent_in_out->payload_sz);
>>       |                          ^~~~~~~~~~~
>> 1 error generated.
>>
>>
>> I can certainly work it around in libfuse by adding a cast, IMHO,
>> PRIu64 is the right format.
> 
> Or use 'unsigned long long' for the 64bit values and %llu for the format.
> I'm pretty sure that works for all reasonable modern architectures.
> 
> You might still want to use the fuse_[us][8|16|32|64] names but they
> can be defined directly as char/short/int/long long.

Well, what speaks against to it like I have done? A few more lines of
code, but even unlikely arch issues are excluded.

Thanks,
Bernd

