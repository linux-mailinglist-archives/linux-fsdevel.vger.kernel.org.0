Return-Path: <linux-fsdevel+bounces-48690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA458AB2E24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 05:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2327AACF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 03:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F61254869;
	Mon, 12 May 2025 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzmfymJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57102512C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747020734; cv=none; b=Q506umVtV+Ph75hw04AHeC7eJGrIvMfP7M0BLVKA1JBg0SVE6R7hBMaD5DhYcFq9iBBN1D1N2rVgLwyfqIuNOLLNtrLl+t6xnlLZdgohUtzYb8z9+zsrQ7RAXnCjWQ5mfgQPdhNljida+BB3VVDk/eIUHMoTuf7syDLYj9ozeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747020734; c=relaxed/simple;
	bh=JxOxpJ0i7h4ePB/814Pne03+XsTSBvsrKXA7Jf+vo4I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lkV+oIGnZoogHGQLJCJafeeoOLgecqH93bXrktZg65A/pI26NeyPzaSU4+YS9Pu0OBALvTdInfH2ln3jY7y6XPhqqVvo6/0HHw+QIGNZ7dSmqySKDwgJsisoL0rSW4PIoqMzQ3krqug4oP48qh9RVbY8brzdqclyNyv3ketmDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzmfymJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C893C4CEE4;
	Mon, 12 May 2025 03:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747020734;
	bh=JxOxpJ0i7h4ePB/814Pne03+XsTSBvsrKXA7Jf+vo4I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OzmfymJ1nyKj5+2xI8DN8rVPTZWCr2As/Bg1NxifzqRuPggy7JTcQePzSZu7/j6sO
	 C3XnYnj5M7pmHM/sTV5oHUYdCCIa6UkJlEbBxf+5XtNjkkBwlRUuEYG3Bqd1i0Jgo6
	 offAzjyBnl2Z1b9VnUJXX54RnDQ+TuJV0M6E5PvKBUg4EAr6RQPmPCQkRTzXaVwmTc
	 4olCLVfAVC3gfHWmxD+OMkJHR9pLn+FuBZXXP2URzwQyN3YLqbIfJuWNse5TJl1Lj3
	 CyXQw8ldXL31mtnt+9mzMmtduDE5pJg0JePhVItDuWrKc2eK3jBmC0M+wMCa/ySS8U
	 8djPsFQi3ExHg==
Message-ID: <44227298-bee2-4978-b785-715427c3cce5@kernel.org>
Date: Mon, 12 May 2025 11:32:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH V3 5/7] f2fs: separate the options parsing and options
 checking
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-6-sandeen@redhat.com>
 <61cc47ec-787a-4cad-b7c1-3248dafbea79@kernel.org>
 <7a2d79f3-d524-4dd3-afff-b6f658935151@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <7a2d79f3-d524-4dd3-afff-b6f658935151@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 23:52, Eric Sandeen wrote:
> On 5/8/25 3:13 AM, Chao Yu wrote:
>> On 4/24/25 01:08, Eric Sandeen wrote:
>>> From: Hongbo Li <lihongbo22@huawei.com>
> 
> ...
> 
>>> +	if (ctx->qname_mask) {
>>> +		for (i = 0; i < MAXQUOTAS; i++) {
>>> +			if (!(ctx->qname_mask & (1 << i)))
>>> +				continue;
>>> +
>>> +			old_qname = F2FS_OPTION(sbi).s_qf_names[i];
>>> +			new_qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
>>> +			if (quota_turnon &&
>>> +				!!old_qname != !!new_qname)
>>> +				goto err_jquota_change;
>>> +
>>> +			if (old_qname) {
>>> +				if (strcmp(old_qname, new_qname) == 0) {
>>> +					ctx->qname_mask &= ~(1 << i);
>>
>> Needs to free and nully F2FS_CTX_INFO(ctx).s_qf_names[i]?
>>
> 
> I will have to look into this. If s_qf_names are used/applied, they get
> transferred to the sbi in f2fs_apply_quota_options and are freed in the
> normal course of the fiesystem lifetime, i.e at unmount in f2fs_put_super.
> That's the normal non-error lifecycle of the strings.
> 
> If they do not get transferred to the sbi in f2fs_apply_quota_options, they
> remain on the ctx, and should get freed in f2fs_fc_free:
> 
>         for (i = 0; i < MAXQUOTAS; i++)
>                 kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
> 
> It is possible to free them before f2fs_fc_free of course and that might
> be an inconsistency in this function, because we do that in the other case
> in the check_consistency function:
> 
>                         if (quota_feature) {
>                                 f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
>                                 ctx->qname_mask &= ~(1 << i);
>                                 kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
>                                 F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
>                         }

Yes, I noticed such inconsistency, and I'm wondering why we handle ctx.s_qf_names
w/ different ways.

			if (quota_feature) {
				f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
				ctx->qname_mask &= ~(1 << i);
				kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
				F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
			}

For "quota_feature is on" case, as opt.s_qf_names is NULL, so if it doesn't
nully ctx.s_qf_names, it will fail below check which is not as expected. So
I doubt it should be handled separately.

	/* Make sure we don't mix old and new quota format */
	usr_qf_name = F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
			F2FS_CTX_INFO(ctx).s_qf_names[USRQUOTA];
	grp_qf_name = F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
			F2FS_CTX_INFO(ctx).s_qf_names[GRPQUOTA];
	prj_qf_name = F2FS_OPTION(sbi).s_qf_names[PRJQUOTA] ||
			F2FS_CTX_INFO(ctx).s_qf_names[PRJQUOTA];
	usrquota = test_opt(sbi, USRQUOTA) ||
			ctx_test_opt(ctx, F2FS_MOUNT_USRQUOTA);
	grpquota = test_opt(sbi, GRPQUOTA) ||
			ctx_test_opt(ctx, F2FS_MOUNT_GRPQUOTA);
	prjquota = test_opt(sbi, PRJQUOTA) ||
			ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA);

	if (usr_qf_name) {
		ctx_clear_opt(ctx, F2FS_MOUNT_USRQUOTA);
		usrquota = false;
	}
	if (grp_qf_name) {
		ctx_clear_opt(ctx, F2FS_MOUNT_GRPQUOTA);
		grpquota = false;
	}
	if (prj_qf_name) {
		ctx_clear_opt(ctx, F2FS_MOUNT_PRJQUOTA);
		prjquota = false;
	}
	if (usr_qf_name || grp_qf_name || prj_qf_name) {
		if (grpquota || usrquota || prjquota) {
			f2fs_err(sbi, "old and new quota format mixing");
			return -EINVAL;
		}
		if (!(ctx->spec_mask & F2FS_SPEC_jqfmt ||
				F2FS_OPTION(sbi).s_jquota_fmt)) {
			f2fs_err(sbi, "journaled quota format not specified");
			return -EINVAL;
		}
	}

> 
> I'll have to look at it a bit more. But this is modeled on ext4's
> ext4_check_quota_consistency(), and it does not do any freeing in that
> function; it leaves freeing in error cases to when the fc / ctx gets freed.
> 
> But tl;dr: I think we can remove the kfree and "= NULL" in this function,
> and defer the freeing in the error case.
> 
>>> +
>>> +static inline void clear_compression_spec(struct f2fs_fs_context *ctx)
>>> +{
>>> +	ctx->spec_mask &= ~(F2FS_SPEC_compress_algorithm
>>> +						| F2FS_SPEC_compress_log_size
>>> +						| F2FS_SPEC_compress_extension
>>> +						| F2FS_SPEC_nocompress_extension
>>> +						| F2FS_SPEC_compress_chksum
>>> +						| F2FS_SPEC_compress_mode);
>>
>> How about add a macro to include all compression macros, and use it to clean
>> up above codes?
> 
> That's a good idea and probably easy enough to do without rebase pain.
>  
>>> +
>>> +	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
>>> +				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
>>> +				F2FS_CTX_INFO(ctx).extensions,
>>> +				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
>>> +		f2fs_err(sbi, "invalid compress or nocompress extension");
>>
>> Can you please describe what is detailed confliction in the log? e.g. new
>> noext conflicts w/ new ext...
> 
> Hmm, let me think about this. I had not noticed it was calling 
> f2fs_test_compress_extension 3 times, I wonder if there is a better option.
> I need to understand this approach better. Maybe Hongbo has thoughts.

Maybe:

f2fs_err(sbi, "new noextensions conflicts w/ new extensions");

> 
>>> +		return -EINVAL;
>>> +	}
>>> +	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
>>> +				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
>>> +				F2FS_OPTION(sbi).extensions,
>>> +				F2FS_OPTION(sbi).compress_ext_cnt)) {
>>> +		f2fs_err(sbi, "invalid compress or nocompress extension");

f2fs_err(sbi, "new noextensions conflicts w/ old extensions");

>>
>> Ditto,
>>
>>> +		return -EINVAL;
>>> +	}
>>> +	if (f2fs_test_compress_extension(F2FS_OPTION(sbi).noextensions,
>>> +				F2FS_OPTION(sbi).nocompress_ext_cnt,
>>> +				F2FS_CTX_INFO(ctx).extensions,
>>> +				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
>>> +		f2fs_err(sbi, "invalid compress or nocompress extension");

f2fs_err(sbi, "new extensions conflicts w/ old noextensions");

Then, user may get enough hint from log to update conflicted {no,}extensions
for mount.

Thanks,

>>
>> Ditto,
> 
> thanks,
> -Eric
> 


