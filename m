Return-Path: <linux-fsdevel+bounces-48492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6AAAFF9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 17:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8973BC51F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F4A279902;
	Thu,  8 May 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CntjSvC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB0278E7A
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719585; cv=none; b=jfW12fAENNhojwj4lkjTuA2maD0vyXtMcU4lUanb72NIWIxUEPQQ0fQN7uuespmz4i5ANoX4UtxB8xrj5cQscXk7VyYN1zmmjsJc0Ph2OiCGrPXi54zWC0OMEz/iN9vUuEiod32uTxo4++BJ5YlS4x8BT9FfHH5uBgkCn3+xSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719585; c=relaxed/simple;
	bh=oyPKrPzEz8IXuzhjz15r1q7vzRNGOoeEX99uk0kVEwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0H+U0w3+JyH6Du0EzFjfpBs8eHCk1pZKoG88brD4/hBd70/LhrHWezsvI0BBMOoDKpJ4yD5Ab8mQWhADG6AebIjdwHzWpArtEheit9/37UVeiddBeCWUOJ+WTVYJ2uBku8tfeedAe7mP/O2CSmen6AxEQ4lnWQWNftZE6/Lv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CntjSvC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746719582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqHE1wVlzBEjIT1tkHqJbdWcqFR55QD5dBEYaUNTC8w=;
	b=CntjSvC5+TJ0+BHNmKBPPtjyHIphBrBba93sbHXYL0c+SU08krfaEGNdozV9DWqn+uHsGS
	6mP5lDLlexvIuqnRiPaHwnDjlLpBNuey2dSKKNEY2YiJ1EfhLK7uBUvmrjnXKYHMl7ZZz8
	PsJhUfaLP9uJWKbzdt15PaWkrTpghEc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-joLW8741MEeHvcvCKOj6Lw-1; Thu, 08 May 2025 11:53:01 -0400
X-MC-Unique: joLW8741MEeHvcvCKOj6Lw-1
X-Mimecast-MFC-AGG-ID: joLW8741MEeHvcvCKOj6Lw_1746719580
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8610d7ec4d3so166102939f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 08:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746719580; x=1747324380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqHE1wVlzBEjIT1tkHqJbdWcqFR55QD5dBEYaUNTC8w=;
        b=RaDE0/+Fd53cI6ULVAn5OWcImJGj7Wtc7CAopbb/ugcEG/UFR3Q0K5mRik2BnAVuy8
         MYxWcywNJrEayl78jNXYwdt0vwJGA8RAg4ShGfy4kS6hQ6XYNxn5OmQwO5s08A9w+NYO
         Om0irGzB1r2BxHbxFRFdC4P3Ds7JmHYPgVBSqLgPXmbBQixhSn1S9yTV6mz7WaDjkiX9
         MBpYBpq8uiswurQ4F/nzgZhpX53BexvvyB/UAQ2oX7y2ac1fhpulTZ3hUwiLtxyCibyv
         qc34BSe1yDi4T9OmU+rQuAhArItqgLaLl07ZH1kBycYa5vqGb9tYdmHapW9EIIk4yIfr
         e27g==
X-Gm-Message-State: AOJu0YxoRYABykQfkmtCWjnwghwSvl/5FC3tvAKLl4dhTL8XHGW7+8z4
	SXS1ChQa9YHPM2h+mARezdQjXe5X5txo2X4PNo/2Z2ucODbHoBwaQ5l8lo6QgtIcQpaW7VSo+Un
	1xaNe6NK6I1pfWFVCw8t3teojgSCasoQsQG1ZZJhnqRSbK26yt9QaPQXeWnqoiH0=
X-Gm-Gg: ASbGncv/GS2Ffi0wh6b3vF3OFPhPpyafsXCt3ej8WPD1dfOIvY3iYXdGP/rQLKYpUOR
	4S3fUP3xrntx8ve45g/2D9Po4x7iHmOBWRTqT2B0MO9OJJI06lEF8Ula6XKb4aJ+e1ZRATym+c/
	yR6FzuibRSIbTjpvLUheUXeeHLoxp1NVhTv0EEKteuSuESOZ/MuXysc5Wf5hHzYg+xJM3G3r0/e
	s77FZLWisFpgXaxNPutReCZF8C8JDax2KXp5FBvo9InwFGMrgZZNxy9CqCdZPZLL75NdPhTOKMX
	fKw9Pc+wdVb+SEGnK0gOdHV7MaZi09gSD0k1d/Sa3v9qkX3Yyw==
X-Received: by 2002:a05:6602:2c08:b0:85b:3f06:1fd4 with SMTP id ca18e2360f4ac-86763606cb8mr24779539f.9.1746719580335;
        Thu, 08 May 2025 08:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxJfZlvicAxlrpONM77R2Vd2izM8sSdfo59tv8nxUPrpakE2FaQQ2SxHE2KMbrtncMtJ8M2Q==
X-Received: by 2002:a05:6602:2c08:b0:85b:3f06:1fd4 with SMTP id ca18e2360f4ac-86763606cb8mr24776239f.9.1746719579980;
        Thu, 08 May 2025 08:52:59 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2251c01bsm18934173.57.2025.05.08.08.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:52:59 -0700 (PDT)
Message-ID: <7a2d79f3-d524-4dd3-afff-b6f658935151@redhat.com>
Date: Thu, 8 May 2025 10:52:58 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/7] f2fs: separate the options parsing and options
 checking
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, lihongbo22@huawei.com
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-6-sandeen@redhat.com>
 <61cc47ec-787a-4cad-b7c1-3248dafbea79@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <61cc47ec-787a-4cad-b7c1-3248dafbea79@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 3:13 AM, Chao Yu wrote:
> On 4/24/25 01:08, Eric Sandeen wrote:
>> From: Hongbo Li <lihongbo22@huawei.com>

...

>> +	if (ctx->qname_mask) {
>> +		for (i = 0; i < MAXQUOTAS; i++) {
>> +			if (!(ctx->qname_mask & (1 << i)))
>> +				continue;
>> +
>> +			old_qname = F2FS_OPTION(sbi).s_qf_names[i];
>> +			new_qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
>> +			if (quota_turnon &&
>> +				!!old_qname != !!new_qname)
>> +				goto err_jquota_change;
>> +
>> +			if (old_qname) {
>> +				if (strcmp(old_qname, new_qname) == 0) {
>> +					ctx->qname_mask &= ~(1 << i);
> 
> Needs to free and nully F2FS_CTX_INFO(ctx).s_qf_names[i]?
> 

I will have to look into this. If s_qf_names are used/applied, they get
transferred to the sbi in f2fs_apply_quota_options and are freed in the
normal course of the fiesystem lifetime, i.e at unmount in f2fs_put_super.
That's the normal non-error lifecycle of the strings.

If they do not get transferred to the sbi in f2fs_apply_quota_options, they
remain on the ctx, and should get freed in f2fs_fc_free:

        for (i = 0; i < MAXQUOTAS; i++)
                kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);

It is possible to free them before f2fs_fc_free of course and that might
be an inconsistency in this function, because we do that in the other case
in the check_consistency function:

                        if (quota_feature) {
                                f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
                                ctx->qname_mask &= ~(1 << i);
                                kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
                                F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
                        }

I'll have to look at it a bit more. But this is modeled on ext4's
ext4_check_quota_consistency(), and it does not do any freeing in that
function; it leaves freeing in error cases to when the fc / ctx gets freed.

But tl;dr: I think we can remove the kfree and "= NULL" in this function,
and defer the freeing in the error case.

>> +
>> +static inline void clear_compression_spec(struct f2fs_fs_context *ctx)
>> +{
>> +	ctx->spec_mask &= ~(F2FS_SPEC_compress_algorithm
>> +						| F2FS_SPEC_compress_log_size
>> +						| F2FS_SPEC_compress_extension
>> +						| F2FS_SPEC_nocompress_extension
>> +						| F2FS_SPEC_compress_chksum
>> +						| F2FS_SPEC_compress_mode);
> 
> How about add a macro to include all compression macros, and use it to clean
> up above codes?

That's a good idea and probably easy enough to do without rebase pain.
 
>> +
>> +	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
>> +				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
>> +				F2FS_CTX_INFO(ctx).extensions,
>> +				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
>> +		f2fs_err(sbi, "invalid compress or nocompress extension");
> 
> Can you please describe what is detailed confliction in the log? e.g. new
> noext conflicts w/ new ext...

Hmm, let me think about this. I had not noticed it was calling 
f2fs_test_compress_extension 3 times, I wonder if there is a better option.
I need to understand this approach better. Maybe Hongbo has thoughts.

>> +		return -EINVAL;
>> +	}
>> +	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
>> +				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
>> +				F2FS_OPTION(sbi).extensions,
>> +				F2FS_OPTION(sbi).compress_ext_cnt)) {
>> +		f2fs_err(sbi, "invalid compress or nocompress extension");
> 
> Ditto,
> 
>> +		return -EINVAL;
>> +	}
>> +	if (f2fs_test_compress_extension(F2FS_OPTION(sbi).noextensions,
>> +				F2FS_OPTION(sbi).nocompress_ext_cnt,
>> +				F2FS_CTX_INFO(ctx).extensions,
>> +				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
>> +		f2fs_err(sbi, "invalid compress or nocompress extension");
> 
> Ditto,

thanks,
-Eric


