Return-Path: <linux-fsdevel+bounces-78956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGSYKSXlpWlLHwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 20:29:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7BE1DED36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 20:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1B41304707D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 19:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563633876C1;
	Mon,  2 Mar 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="mxCAxHAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Wtimbo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3292DF151;
	Mon,  2 Mar 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479766; cv=none; b=aCiEF/uxAA9DGPxAUoaCyqEct3WLqbpTfjbPEVosUlJ0tUhvf+gb5udlCfiPQFYD464yPzGzFU8o5ywj2RQ38pUQ1D2hDZp/zDt5ukfi+6zdcXQNc78mmpi9ikuidO5gBQHz20tm/++3uFeYBHnsRB18GVOvK/qx3Nc5Et3TcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479766; c=relaxed/simple;
	bh=ZocXTXd/Bc7Ub9E+8mzixpKvbXMd0Ck15fMa1RuE3NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjM5vgtsxi0NUVK7vWAhnLFG1Bw8PWgnoE6ZikMgFXeOYeqTMR4WDAACjRrKtszrdDRmh5F7B7llJf/ApNdry7VZbMwpyqMiU5rECDGyq1TA5lre1+EWT0ow7h9QJVs/m9hJXXlXOWJUnt/5/stMiLRiTyDTpR+Ndl+4iSXNs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=mxCAxHAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1Wtimbo/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6EF5E7A01BF;
	Mon,  2 Mar 2026 14:29:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 14:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772479763;
	 x=1772566163; bh=yNxk1mBpeCI3MHqDZSR7nuO1y4oX59lUGlaVVu6pa/o=; b=
	mxCAxHAb1q1wYEj5u4LvRaadeC5sa6+Wmpnv8FbA5RTTCt2/Md7L2rVaB9Tg4bY1
	zKXiTz7YdoAMulDTf056oUYhTGVma6206qNMQXiOgIe9hIM0tUm9nUhjCWxFyIAp
	uBv8J9UUlS43nBFmcT4E6AbgLt/y+NkGY2I+/RDaib4jynHUEqK/MaAIbby9ebmY
	k/gMMrEKKh2PYts7AFWUWfamBkvG9/lUe4jVUjClx7Iax8gVhfG1LO00IH37i6qW
	LEBe+fFrY3QXj7/6oz3lhVg8voSsjxIyIzL4FKL51Zo3HUXw+q5S0TLoOigIBZsa
	AQVuwkod1evp+/zPx/Hxgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772479763; x=
	1772566163; bh=yNxk1mBpeCI3MHqDZSR7nuO1y4oX59lUGlaVVu6pa/o=; b=1
	Wtimbo/oM3cWXaevmuYouPJMjrHMCR+oPZI6O7kaDlC7RIj10EhoTGiYXr/WPo2e
	61hoLbBhs9ORdqiGpO/mEV+l3NpgiCWO3eMLwGVPP9rHFfD/gmAFjiZt/aEjX0/t
	O+DF5tOEqwwJBOwxz7U6ITEvWLG1Y0RTHLh7t+MEAKOgBby6nGh/KevOrqf84Q4X
	lULuYvzAnLkC4oBHHDOykA6QAyqeH5g5eehpgKV+Nc6r+ormWJh6MOrVIxW97sr2
	vK2NGnst4BaQJ4v2nWDKQsqk6g9vNgvctc+HAKkR7kwfnUlcsi2i8uma5O9NhKA1
	PDroubBFuPoBQBHRjVxBQ==
X-ME-Sender: <xms:EuWlabXbGxeqVEqxhVZyc4e7qUi6l8KFEKOghurOogy6k18qaFdW4w>
    <xme:EuWlaehITe42iDSc7LL9tlDuTIhX3083CksCEpK1e4ZpB6ZYTPSrsrmOvPDLTV2wm
    25lf5KlYIG-8yNRT5lhd60LnERrIaoIPCiUL139dKn2V9ar1DMl>
X-ME-Received: <xmr:EuWlaWbxUFqa1Ovkg4tmmMxBJsFd1T6-xL-h4LzJEWU4XkjFKITj61IvXHn418ANR6D3UMFspjKN9VCWci2N-7vCRZiAfqZox99C0-WuKbEp_35Wug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekhedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:EuWlabpwLipGKGpvNyvIQAnp9wRfAgtGlCy82C-KEc89Xpw_wOUsfg>
    <xmx:EuWlaTP3yNF5RsW6x69SgeAOdSvZEEoDp1xASs2EuZfIIHDRWSagwQ>
    <xmx:EuWlaeqAXIwN-RTawycBVG9wYhXMXswWBZ8hFwqrAmgaTo5C8AFWwA>
    <xmx:EuWlaQf0oeoAvMm7AOkEv-J1pREjo29Rfbvpg8n6Yl2O4tXDJhPmRA>
    <xmx:E-WlabgmK30vm0hTS9bG6Qki-QSRumUEMNexp6M3hiyQsubnSkCmVZWz>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 14:29:21 -0500 (EST)
Message-ID: <f7903a99-c8c3-4dd6-8ec4-a1b1da8f20e0@bsbernd.com>
Date: Mon, 2 Mar 2026 20:29:19 +0100
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
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegtS+rX37qLVPW+Ciso_+yqjTqGKNnvSacpd7HdniGXjAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CD7BE1DED36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-78956-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ddn.com:email,messagingengine.com:dkim,bsbernd.com:dkim,bsbernd.com:mid]
X-Rspamd-Action: no action



On 2/27/26 16:09, Miklos Szeredi wrote:
> On Sun, 11 Jan 2026 at 08:37, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> This fixes xfstests generic/451 (for both O_DIRECT and FOPEN_DIRECT_IO
>> direct write).
>>
>> Commit b359af8275a9 ("fuse: Invalidate the page cache after
>> FOPEN_DIRECT_IO write") tries to fix the similar issue for
>> FOPEN_DIRECT_IO write, which can be reproduced by xfstests generic/209.
>> It only fixes the issue for synchronous direct write, while omitting
>> the case for asynchronous direct write (exactly targeted by
>> generic/451).
>>
>> While for O_DIRECT direct write, it's somewhat more complicated.  For
>> synchronous direct write, generic_file_direct_write() will invalidate
>> the page cache after the write, and thus it can pass generic/209.  While
>> for asynchronous direct write, the invalidation in
>> generic_file_direct_write() is bypassed since the invalidation shall be
>> done when the asynchronous IO completes.  This is omitted in FUSE and
>> generic/451 fails whereby.
>>
>> Fix this by conveying the invalidation for both synchronous and
>> asynchronous write.
>>
>> - with FOPEN_DIRECT_IO
>>   - sync write,  invalidate in fuse_send_write()
>>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
>>                  fuse_send_write() otherwise
>> - without FOPEN_DIRECT_IO
>>   - sync write,  invalidate in generic_file_direct_write()
>>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
>>                  generic_file_direct_write() otherwise
>>
>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Applied, thanks.
> 

Hi Miklos,

just back from a week off and we got a QA report last week. This commit
leads to a deadlock. Is there a chance you can revert and not send it
to Linus yet? 

[Wed Feb 25 07:14:29 2026] INFO: task clt_reactor_3:49041 blocked for more than 122 seconds.
[Wed Feb 25 07:14:29 2026]       Tainted: G           OE      6.8.0-79-generic #79-Ubuntu
[Wed Feb 25 07:14:29 2026] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Wed Feb 25 07:14:29 2026] task:clt_reactor_3   state:D stack:0     pid:49041 tgid:49014 ppid:1      flags:0x00000006
[Wed Feb 25 07:14:29 2026] Call Trace:
[Wed Feb 25 07:14:29 2026] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Wed Feb 25 07:14:29 2026] task:clt_reactor_3   state:D stack:0     pid:49041 tgid:49014 ppid:1      flags:0x00000006
[Wed Feb 25 07:14:29 2026] Call Trace:
[Wed Feb 25 07:14:29 2026]  <TASK>
[Wed Feb 25 07:14:29 2026]  __schedule+0x27c/0x6b0
[Wed Feb 25 07:14:29 2026]  schedule+0x33/0x110
[Wed Feb 25 07:14:29 2026]  io_schedule+0x46/0x80
[Wed Feb 25 07:14:29 2026]  folio_wait_bit_common+0x136/0x330
[Wed Feb 25 07:14:29 2026]  __folio_lock+0x17/0x30
[Wed Feb 25 07:14:29 2026]  invalidate_inode_pages2_range+0x1d2/0x4f0
[Wed Feb 25 07:14:29 2026]  fuse_aio_complete+0x258/0x270 [fuse]
[Wed Feb 25 07:14:29 2026]  fuse_aio_complete_req+0x87/0xd0 [fuse]
[Wed Feb 25 07:14:29 2026]  fuse_request_end+0x18e/0x200 [fuse]
[Wed Feb 25 07:14:29 2026]  fuse_uring_req_end+0x87/0xd0 [fuse]
[Wed Feb 25 07:14:29 2026]  fuse_uring_cmd+0x241/0xf20 [fuse]
[Wed Feb 25 07:14:29 2026]  io_uring_cmd+0x9f/0x140
[Wed Feb 25 07:14:29 2026]  io_issue_sqe+0x193/0x410
[Wed Feb 25 07:14:29 2026]  io_submit_sqes+0x128/0x3e0
[Wed Feb 25 07:14:29 2026]  __do_sys_io_uring_enter+0x2ea/0x490
[Wed Feb 25 07:14:29 2026]  __x64_sys_io_uring_enter+0x22/0x40


Issue is that invalidate_inode_pages2_range() might trigger another
write to the same core (in our case a reactor / coroutine) and
then deadlocks.
Cheng suggests to offload that into a worker queue, but FOPEN_DIRECT_IO
code starts to get complex - I'm more inclined to get back to my patches
from about 3 years ago that the unified the DIO handlers and let it go
through the normal vfs handlers.


Thanks,
Bernd

