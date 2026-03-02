Return-Path: <linux-fsdevel+bounces-79077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIyQIOoGpmkzJAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:53:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72271E43C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06EC830FED6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990034750F;
	Mon,  2 Mar 2026 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="K774BcWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6yrkfvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF5248880;
	Mon,  2 Mar 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486409; cv=none; b=NtOgyOCxQIjS4sYYjggKlWlnauVsEvX8L8yjTaB5mBxeeUf+Ts2o9UMOmT3OWuu5UulWOSEaDt3cHZfXWfZebfFnv7H7TB5dkZ21Tdj/b6Ss7bIF8scPRWlFbpXJjS9bLkqW555aGVBKERXNQe9dtsR26IUwWJ2HMxRfP34M/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486409; c=relaxed/simple;
	bh=uA8nHfeG7w4XCOPnDIAAVXTEAjdJZ0w1mWX1Bo58SyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKI1uC1/5hYAwVo0w7+4aXwhVQqwfc6d+YWX9Anmo/GSqrFUJMI39ydbn+0KJ8sWDdQxsvQkW5w2kWpEpISGP6IFgTyYA8R3H0Na8TsB4Vz/5PJoKASlIb8jraVQGJA5iZPvuorfSlmA85R5pQa7PgKSb8KaVSENcvJEDbf4NWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=K774BcWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6yrkfvE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 810CA7A027A;
	Mon,  2 Mar 2026 16:20:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Mar 2026 16:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772486406;
	 x=1772572806; bh=63SKAdqerFk8wLjKdS/2fvB6fRbTXWtYSVKRF2ljskI=; b=
	K774BcWcSnsldM4xtUlAPRs+DDh/GK74yhJYv5gqSYi13Pxqmujad+3uOjCYHKuh
	eKoez77/388Osj69vPq46Wci7ANxa1fpSZIyojp6i6IhGlYnLzxYd4z3/XbmMK0c
	B5Yjk1eZT7SlmUFpdDJHUW40Jqw4hCBlO3XTYHBHsRbzgg425dJUk+mhfQKNXkEQ
	3fZs1EfswbLwo1uPhXrxSyrMB14vFVJzfuta/irUdu0HjSTDu2a97cldGtxDeN1I
	riOvwY5EsEJPSmC5zlpeILAgMu9QQhWY5CIhr8rN4T0E6qXlUrniJg9R0N7HM34+
	umERgcBLdNIpb8Ie8eSuIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772486406; x=
	1772572806; bh=63SKAdqerFk8wLjKdS/2fvB6fRbTXWtYSVKRF2ljskI=; b=n
	6yrkfvEIxnyz33veXUjZIV6mBTObkptlQyPHJxygrfBGWby4EbAq9PuYOVfiZa+j
	PaRGdASSrvX+GogvdN9OLIHOKPYfByDboS2LHmgA8neInicbSv4jh2dvR4rtKgaK
	ihTJWlPOoq4eE3sxAp6uadp9mLUl3MIdJV/Yz2TysQeFdjq9HQtTMw90RO6W2sUR
	WPRgbG7vFuW8bdFpOa9ffNy/VEVmOh9XuFTV0vbfgJaJ412l0evBqaIL8IG/EkvK
	5JPNXbZarChGzoCfiuWKifYRWBjIbDx8m3CZUX5NqChj6iZaKGiqS88x/0GjaJ9Z
	4eYuGcMmWASvIYQ+oQ8cw==
X-ME-Sender: <xms:Bf-lacaZwxl6sA2en-XtlymtViO8X9zvZwjj3KcOgxmOynMrN9E5rw>
    <xme:Bf-laSV8KLoXEeMXCAnqdRa3AyscxNO-UGPvU1Us-MvmVvqtgiL4_h5vSJRV04YV-
    VtvQiL-xEod6_PXB5sjz2s2DhKOJ5xfo6hyQkeulFaGJlE1JECF>
X-ME-Received: <xmr:Bf-laV-Q6jifoOwezkFB_o60xY0tnWYJbUr08Tc7lnpVI2Pu0_j05oPpRd9Z4AGhBz69XMQ8EW797rooFL-PJQhObZ2NetGU6Srm6qX8pKgUpN8Ntg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgguih
    hnghesuggunhdrtghomh
X-ME-Proxy: <xmx:Bf-lab_W9nETJsfPI9ExCSWVTP22Hcbc7jivROurvGsot1jlUdk6JQ>
    <xmx:Bf-laVTlYNCHxjS41wLM5hnM8TflGEHokziT0H3BPM8j40j51jFIwg>
    <xmx:Bf-lafeKapdo1KfoxGA2Ogj1rh1fUJc5CNHXHwsPm_DzuKQkqAQSAA>
    <xmx:Bf-laZDpn8YqFTARTZYKAe8uFaujuDfF5ufwTSPmELG8YaydmiJMcA>
    <xmx:Bv-laTKYLk6i7MdQWTAHgmx1iyr_5C0G9_bU4-foZWD0BfNU_DrNmYsF>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 16:20:03 -0500 (EST)
Message-ID: <e57c91ac-09b1-4e28-9a92-d721dc314dfd@bsbernd.com>
Date: Mon, 2 Mar 2026 22:19:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: invalidate the page cache after direct write
To: Miklos Szeredi <miklos@szeredi.hu>, Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com,
 linux-kernel@vger.kernel.org, Cheng Ding <cding@ddn.com>
References: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
 <CAJfpegtS+rX37qLVPW+Ciso_+yqjTqGKNnvSacpd7HdniGXjAQ@mail.gmail.com>
 <f7903a99-c8c3-4dd6-8ec4-a1b1da8f20e0@bsbernd.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <f7903a99-c8c3-4dd6-8ec4-a1b1da8f20e0@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D72271E43C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79077-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email,bsbernd.com:dkim,bsbernd.com:mid]
X-Rspamd-Action: no action



On 3/2/26 20:29, Bernd Schubert wrote:
> 
> 
> On 2/27/26 16:09, Miklos Szeredi wrote:
>> On Sun, 11 Jan 2026 at 08:37, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>> This fixes xfstests generic/451 (for both O_DIRECT and FOPEN_DIRECT_IO
>>> direct write).
>>>
>>> Commit b359af8275a9 ("fuse: Invalidate the page cache after
>>> FOPEN_DIRECT_IO write") tries to fix the similar issue for
>>> FOPEN_DIRECT_IO write, which can be reproduced by xfstests generic/209.
>>> It only fixes the issue for synchronous direct write, while omitting
>>> the case for asynchronous direct write (exactly targeted by
>>> generic/451).
>>>
>>> While for O_DIRECT direct write, it's somewhat more complicated.  For
>>> synchronous direct write, generic_file_direct_write() will invalidate
>>> the page cache after the write, and thus it can pass generic/209.  While
>>> for asynchronous direct write, the invalidation in
>>> generic_file_direct_write() is bypassed since the invalidation shall be
>>> done when the asynchronous IO completes.  This is omitted in FUSE and
>>> generic/451 fails whereby.
>>>
>>> Fix this by conveying the invalidation for both synchronous and
>>> asynchronous write.
>>>
>>> - with FOPEN_DIRECT_IO
>>>   - sync write,  invalidate in fuse_send_write()
>>>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
>>>                  fuse_send_write() otherwise
>>> - without FOPEN_DIRECT_IO
>>>   - sync write,  invalidate in generic_file_direct_write()
>>>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
>>>                  generic_file_direct_write() otherwise
>>>
>>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>
>> Applied, thanks.
>>
> 
> Hi Miklos,
> 
> just back from a week off and we got a QA report last week. This commit
> leads to a deadlock. Is there a chance you can revert and not send it
> to Linus yet? 
> 
> [Wed Feb 25 07:14:29 2026] INFO: task clt_reactor_3:49041 blocked for more than 122 seconds.
> [Wed Feb 25 07:14:29 2026]       Tainted: G           OE      6.8.0-79-generic #79-Ubuntu
> [Wed Feb 25 07:14:29 2026] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Wed Feb 25 07:14:29 2026] task:clt_reactor_3   state:D stack:0     pid:49041 tgid:49014 ppid:1      flags:0x00000006
> [Wed Feb 25 07:14:29 2026] Call Trace:
> [Wed Feb 25 07:14:29 2026] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Wed Feb 25 07:14:29 2026] task:clt_reactor_3   state:D stack:0     pid:49041 tgid:49014 ppid:1      flags:0x00000006
> [Wed Feb 25 07:14:29 2026] Call Trace:
> [Wed Feb 25 07:14:29 2026]  <TASK>
> [Wed Feb 25 07:14:29 2026]  __schedule+0x27c/0x6b0
> [Wed Feb 25 07:14:29 2026]  schedule+0x33/0x110
> [Wed Feb 25 07:14:29 2026]  io_schedule+0x46/0x80
> [Wed Feb 25 07:14:29 2026]  folio_wait_bit_common+0x136/0x330
> [Wed Feb 25 07:14:29 2026]  __folio_lock+0x17/0x30
> [Wed Feb 25 07:14:29 2026]  invalidate_inode_pages2_range+0x1d2/0x4f0
> [Wed Feb 25 07:14:29 2026]  fuse_aio_complete+0x258/0x270 [fuse]
> [Wed Feb 25 07:14:29 2026]  fuse_aio_complete_req+0x87/0xd0 [fuse]
> [Wed Feb 25 07:14:29 2026]  fuse_request_end+0x18e/0x200 [fuse]
> [Wed Feb 25 07:14:29 2026]  fuse_uring_req_end+0x87/0xd0 [fuse]
> [Wed Feb 25 07:14:29 2026]  fuse_uring_cmd+0x241/0xf20 [fuse]
> [Wed Feb 25 07:14:29 2026]  io_uring_cmd+0x9f/0x140
> [Wed Feb 25 07:14:29 2026]  io_issue_sqe+0x193/0x410
> [Wed Feb 25 07:14:29 2026]  io_submit_sqes+0x128/0x3e0
> [Wed Feb 25 07:14:29 2026]  __do_sys_io_uring_enter+0x2ea/0x490
> [Wed Feb 25 07:14:29 2026]  __x64_sys_io_uring_enter+0x22/0x40
> 
> 
> Issue is that invalidate_inode_pages2_range() might trigger another
> write to the same core (in our case a reactor / coroutine) and
> then deadlocks.
> Cheng suggests to offload that into a worker queue, but FOPEN_DIRECT_IO
> code starts to get complex - I'm more inclined to get back to my patches
> from about 3 years ago that the unified the DIO handlers and let it go
> through the normal vfs handlers.
> 

Hmm, maybe in the short term maybe the better solution is to update the
patch (not posted to the list) that Cheng made and to use
i_sb->s_dio_done_wq similar to what iomap_dio_bio_end_io() does.

