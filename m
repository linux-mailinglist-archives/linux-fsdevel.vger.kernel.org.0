Return-Path: <linux-fsdevel+bounces-48794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11589AB49B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 04:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A1719E7464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 02:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3637199FD0;
	Tue, 13 May 2025 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6QR3mg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108672A1CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104485; cv=none; b=N5I+lFaNDS5cBRBdmOmJqOqX0DLE/oUwLqtbKQJEqwqOC1nr6DvmohIFXtAOVo7KYgqZC6AvaH53B/5ksqHJ3PFWkd68LCOc7+mT9RFHiaQ1Zaa45DVWP1VqpyFj08eIUy2BrZLB6GU8+NA3KIzvzd4Y+8vOIxmjoF76xBgFiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104485; c=relaxed/simple;
	bh=rkT2mGhAdwV2TR/RvKtH3Yt0BAey1v915RRP1Se4YIs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hYL6G+IfHE2byO+ipd4MgMu8+O8DhMuqOGW9VUOVJA7UOjLXwKCKORT9e9nmyoJsuXipz8t1vGJpQP8/syRwf6xJAsV/d62FuGx+/k1CO0CPfihkJme7bb9Kb1mvQ5WwRLomMdcq2YH1Kd37qhNHKfsD4UFFOisFIUmmu+meDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6QR3mg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C679C4CEEE;
	Tue, 13 May 2025 02:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747104484;
	bh=rkT2mGhAdwV2TR/RvKtH3Yt0BAey1v915RRP1Se4YIs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=S6QR3mg6ObG0Is8VsnRB7zhIQIdGq78MoVJEKxQMyWNBJ3N2a9t/Q/puA2+5g2CUX
	 QjKsTblwNViiarIPFDChNpVlBJkdrG6mDHKuTnwg+wbSM59zQV8KiZGK71X8F6+vwt
	 EhKh08IKlYjzFsf/FCFWU36l7vcNLAeOfTFZXLt/oRA/30dWso7k1PjWEgmR2cvvQK
	 EWhw+DLiY75GRPKoEbLwiZ0PiXYuDzvuU9hIlrne+HIpzU72p0LGWCNyORMLz8hKc+
	 s5qZ5s+Lp7UNji/1by6zQ3HRurbrIT/jiZ/wbvvrhEI5bFI0HwC6mQW7PGD1CoiJGI
	 EyhiQwSaCucmA==
Message-ID: <fb54f933-1669-4e89-8b85-9b88030a68d2@kernel.org>
Date: Tue, 13 May 2025 10:48:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, lihongbo22@huawei.com,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 7/7] f2fs: switch to the new mount api
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-8-sandeen@redhat.com>
 <b56964c2-ad30-4501-a7fd-1c0b41c407e9@kernel.org>
 <763bed71-1f44-4622-a9a0-d200f0418183@redhat.com>
 <74704f7c-135e-4614-b805-404da6195930@kernel.org>
 <3fe6be01-b9bf-4e26-b3f6-32dafe0a8162@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <3fe6be01-b9bf-4e26-b3f6-32dafe0a8162@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 10:19, Eric Sandeen wrote:
> On 5/11/25 10:43 PM, Chao Yu wrote:
>> On 5/8/25 23:59, Eric Sandeen wrote:
>>> On 5/8/25 4:19 AM, Chao Yu wrote:
>>>>> @@ -2645,21 +2603,11 @@ static int f2fs_remount(struct
>>>>> super_block *sb, int *flags, char *data)
>>>>>
>>>>> default_options(sbi, true);
>>>>>
>>>>> -	memset(&fc, 0, sizeof(fc)); -	memset(&ctx, 0, sizeof(ctx)); 
>>>>> -	fc.fs_private = &ctx; -	fc.purpose =
>>>>> FS_CONTEXT_FOR_RECONFIGURE; - -	/* parse mount options */ -
>>>>> err = parse_options(&fc, data); -	if (err) -		goto
>>>>> restore_opts;
>>>> There is a retry flow during f2fs_fill_super(), I intenionally
>>>> inject a fault into f2fs_fill_super() to trigger the retry flow,
>>>> it turns out that mount option may be missed w/ below testcase:
>>>
>>> I never did understand that retry logic (introduced in ed2e621a95d
>>> long ago). What errors does it expect to be able to retry, with
>>> success?
>>
>> IIRC, it will retry mount if there is recovery failure due to
>> inconsistent metadata.
> 
> Sure, I just wonder what would cause inconsistent metadata to become consistent
> after 1 retry ...

I don't remember, Jaegeuk, do you remember?

Thanks,

> 
>>>
>>> Anyway ...
>>>
>>> Can you show me (as a patch) exactly what you did to trigger the
>>> retry, just so we are looking at the same thing?
>>
>> You can try this?
> 
> Ok, thanks!
> -Eric
> 
>> --- fs/f2fs/super.c | 6 ++++++ 1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
>> 0ee783224953..10f0e66059f8 100644 --- a/fs/f2fs/super.c +++ b/fs/
>> f2fs/super.c @@ -5066,6 +5066,12 @@ static int
>> f2fs_fill_super(struct super_block *sb, struct fs_context *fc) goto
>> reset_checkpoint; }
>>
>> +	if (retry_cnt) { +		err = -EIO; +		skip_recovery = true; +		goto
>> free_meta; +	} + /* recover fsynced data */ if (!test_opt(sbi,
>> DISABLE_ROLL_FORWARD) && !test_opt(sbi, NORECOVERY)) {
> 


