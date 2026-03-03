Return-Path: <linux-fsdevel+bounces-79101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPlxEdtNpmlCNwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 03:56:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A95601E8421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 03:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EC323038F05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477337B007;
	Tue,  3 Mar 2026 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wXARC7jM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE272F851;
	Tue,  3 Mar 2026 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506579; cv=none; b=H6coNFSQg1dsDLGCg4gJf1S1XJvKSL02ikhmZuaVna9TfLaJHRaCYjkeSYsR2IrR4qhJO/5d1VHBFhmyK0WLTxFasc7GO4KoIkKbzIfANmqBTR5atvXSrMlpUAxIflqs5cbKgHfts3mZSUMtud5eay+tgIJIPpUD9KyC2S3OpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506579; c=relaxed/simple;
	bh=p29Ts/uQiLNRaNqbZCttMVOgOGYb9T+C+5LvWrq8KF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT4u4kOvZAC55HlX/+1TbTccjbcTdwn7vJrh/kKbJsWoSRphdwSDFPVsni0trGLzftwvOJ5XjGYdHCgvAMa5KGpnaz1gTd5vOsgz3ZIhheoXh4jG1nzo9Rkw20Jw35dzuEp6btgXp2ouStbCY7VJ9IDj+wp0JxPuJORp02+Z53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wXARC7jM; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772506573; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0kZUN0VL57Cyttda3xmQnVN1rtw05kxUs7xfZwCM9f0=;
	b=wXARC7jMoXFlM73sJMxc7f3o0i6qARs76qH1pcbzt9NQsfXuXY48ydQ+iHJiZoONDvkWeNyer8fS6Of5UGQx7jryxxHrl7ARze43XnHryIYS4dv1VfyNDaGBioN6dr8c91f5eoiF5NDU7TfJLZUk7QIhhDtyuJN8qtyjZjeDi3s=
Received: from 30.221.146.213(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X-8AdhS_1772506572 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 10:56:13 +0800
Message-ID: <a1a7c175-65d2-4015-9669-93702ce64ffd@linux.alibaba.com>
Date: Tue, 3 Mar 2026 10:56:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: invalidate the page cache after direct write
To: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com,
 linux-kernel@vger.kernel.org, Cheng Ding <cding@ddn.com>
References: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
 <CAJfpegtS+rX37qLVPW+Ciso_+yqjTqGKNnvSacpd7HdniGXjAQ@mail.gmail.com>
 <f7903a99-c8c3-4dd6-8ec4-a1b1da8f20e0@bsbernd.com>
 <e57c91ac-09b1-4e28-9a92-d721dc314dfd@bsbernd.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <e57c91ac-09b1-4e28-9a92-d721dc314dfd@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A95601E8421
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79101-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email]
X-Rspamd-Action: no action

Hi Bernd,

Thanks for reporting it!

On 3/3/26 5:19 AM, Bernd Schubert wrote:
> 
> 
> On 3/2/26 20:29, Bernd Schubert wrote:
>>
>>
>> On 2/27/26 16:09, Miklos Szeredi wrote:
>>> On Sun, 11 Jan 2026 at 08:37, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>> This fixes xfstests generic/451 (for both O_DIRECT and FOPEN_DIRECT_IO
>>>> direct write).
>>>>
>>>> Commit b359af8275a9 ("fuse: Invalidate the page cache after
>>>> FOPEN_DIRECT_IO write") tries to fix the similar issue for
>>>> FOPEN_DIRECT_IO write, which can be reproduced by xfstests generic/209.
>>>> It only fixes the issue for synchronous direct write, while omitting
>>>> the case for asynchronous direct write (exactly targeted by
>>>> generic/451).
>>>>
>>>> While for O_DIRECT direct write, it's somewhat more complicated.  For
>>>> synchronous direct write, generic_file_direct_write() will invalidate
>>>> the page cache after the write, and thus it can pass generic/209.  While
>>>> for asynchronous direct write, the invalidation in
>>>> generic_file_direct_write() is bypassed since the invalidation shall be
>>>> done when the asynchronous IO completes.  This is omitted in FUSE and
>>>> generic/451 fails whereby.
>>>>
>>>> Fix this by conveying the invalidation for both synchronous and
>>>> asynchronous write.
>>>>
>>>> - with FOPEN_DIRECT_IO
>>>>   - sync write,  invalidate in fuse_send_write()
>>>>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
>>>>                  fuse_send_write() otherwise
>>>> - without FOPEN_DIRECT_IO
>>>>   - sync write,  invalidate in generic_file_direct_write()
>>>>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
>>>>                  generic_file_direct_write() otherwise
>>>>
>>>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
>>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>
>>> Applied, thanks.
>>>
>>
>> Hi Miklos,
>>
>> just back from a week off and we got a QA report last week. This commit
>> leads to a deadlock. Is there a chance you can revert and not send it
>> to Linus yet? 
>>
>> [Wed Feb 25 07:14:29 2026] INFO: task clt_reactor_3:49041 blocked for more than 122 seconds.
>> [Wed Feb 25 07:14:29 2026]       Tainted: G           OE      6.8.0-79-generic #79-Ubuntu
>> [Wed Feb 25 07:14:29 2026] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [Wed Feb 25 07:14:29 2026] task:clt_reactor_3   state:D stack:0     pid:49041 tgid:49014 ppid:1      flags:0x00000006
>> [Wed Feb 25 07:14:29 2026] Call Trace:
>> [Wed Feb 25 07:14:29 2026] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [Wed Feb 25 07:14:29 2026] task:clt_reactor_3   state:D stack:0     pid:49041 tgid:49014 ppid:1      flags:0x00000006
>> [Wed Feb 25 07:14:29 2026] Call Trace:
>> [Wed Feb 25 07:14:29 2026]  <TASK>
>> [Wed Feb 25 07:14:29 2026]  __schedule+0x27c/0x6b0
>> [Wed Feb 25 07:14:29 2026]  schedule+0x33/0x110
>> [Wed Feb 25 07:14:29 2026]  io_schedule+0x46/0x80
>> [Wed Feb 25 07:14:29 2026]  folio_wait_bit_common+0x136/0x330
>> [Wed Feb 25 07:14:29 2026]  __folio_lock+0x17/0x30
>> [Wed Feb 25 07:14:29 2026]  invalidate_inode_pages2_range+0x1d2/0x4f0
>> [Wed Feb 25 07:14:29 2026]  fuse_aio_complete+0x258/0x270 [fuse]
>> [Wed Feb 25 07:14:29 2026]  fuse_aio_complete_req+0x87/0xd0 [fuse]
>> [Wed Feb 25 07:14:29 2026]  fuse_request_end+0x18e/0x200 [fuse]
>> [Wed Feb 25 07:14:29 2026]  fuse_uring_req_end+0x87/0xd0 [fuse]
>> [Wed Feb 25 07:14:29 2026]  fuse_uring_cmd+0x241/0xf20 [fuse]
>> [Wed Feb 25 07:14:29 2026]  io_uring_cmd+0x9f/0x140
>> [Wed Feb 25 07:14:29 2026]  io_issue_sqe+0x193/0x410
>> [Wed Feb 25 07:14:29 2026]  io_submit_sqes+0x128/0x3e0
>> [Wed Feb 25 07:14:29 2026]  __do_sys_io_uring_enter+0x2ea/0x490
>> [Wed Feb 25 07:14:29 2026]  __x64_sys_io_uring_enter+0x22/0x40

I can reproduce it with xfstests generic/451 with io_uring enabled.


>>
>>
>> Issue is that invalidate_inode_pages2_range() might trigger another
>> write to the same core (in our case a reactor / coroutine) and
>> then deadlocks.
>> Cheng suggests to offload that into a worker queue, but FOPEN_DIRECT_IO
>> code starts to get complex - I'm more inclined to get back to my patches
>> from about 3 years ago that the unified the DIO handlers and let it go
>> through the normal vfs handlers.
>>
> 
> Hmm, maybe in the short term maybe the better solution is to update the
> patch (not posted to the list) that Cheng made and to use
> i_sb->s_dio_done_wq similar to what iomap_dio_bio_end_io() does.

Hi Bernd, would Cheng mind sending the patch out and I could help review
together :)

-- 
Thanks,
Jingbo


