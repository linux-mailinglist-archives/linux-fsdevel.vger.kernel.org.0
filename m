Return-Path: <linux-fsdevel+bounces-48494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1FAAFFCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A859A00745
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58127A139;
	Thu,  8 May 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cwiai2VL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60A209F45
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719954; cv=none; b=GIZWASWvWDwhsmqzAW/6GepkStu1ipPeaTlde35UvMkvQeZ0LsHnz3++nG+LUPkWCrMOBBvgpPzYi5XgnaY/RRb+2Uj1wLNHnelCJFLnPbtVS6FJzDzeWYxjVlOVZ+aUvCO2JXbU6iRu8MIB2TFwWvYdHpChflGDj0oAMN+GZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719954; c=relaxed/simple;
	bh=7hHA80AfbXXd9eQ2u2rayBbOZ/VrsdwJOZRSL7eMmTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhNi76M51t359m7PXStZ1BziwFctaOWySzP+Yhft7hMdatkP7YWgvDvXPNq17/FYUrhSiWlk6P4J4Lls2WxIu6LkMwu3YS9ZxOY2IKWA+geUz3RQdMW1MOmVVyjhPq5yvlCeCQKpDWnF5an8g7kPl0BYNFlYCh3jw3W6yfekV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cwiai2VL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746719951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cauju83yaqo1jWa3h/GqWUhPfOlx5r6qLpMTuNwXk4Y=;
	b=Cwiai2VLprVZBreoF+0nuMucaLUaf1hBOLr7IFwXJ+d1AReI1qQUo5I/xX0XiP37wZksyv
	3MI2/q/hPTCKd30r8WvAU0LcgNsDSwPMt8PlKUpbfn4Pe14eMsOJxoRYUb7j+nVoXNMawP
	jEaB3V++3cfiHhYNKaFp6RI2OvKWrv8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-HjB27JIOO9aHZQ0UsTaE3g-1; Thu, 08 May 2025 11:59:10 -0400
X-MC-Unique: HjB27JIOO9aHZQ0UsTaE3g-1
X-Mimecast-MFC-AGG-ID: HjB27JIOO9aHZQ0UsTaE3g_1746719950
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b5a7981ccso93862939f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 08:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746719949; x=1747324749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cauju83yaqo1jWa3h/GqWUhPfOlx5r6qLpMTuNwXk4Y=;
        b=uscaxnTcqRNmc7X7iPWT18vROQQZ7fAJpfR4dyzggk1FkQc0G14hkhgONCMuuUb7dS
         yvw1r2Q0OOG+2OOvRVEaqp+PiIZQoS6JmnaZgEgjN52ruq61kVohjQdm/E7QafCS2zok
         cHrNC4y+h8E/u9rl+Mh9PP9rWXvXojA8ZqG7MZzGZDYKoFZrG8woYuZl+uNIWrJmO3RH
         HJJ1ETZpwpZK7fCWn4fgFoP2SWfEh3CxXxmXpy0+qfI2jO1DpSdnEHCENggqOyoaD9fN
         Yev1rqdoDK1Fpi1e+oNw+35BP71NN3u6oj7UNdc13NpwnDm+o5JDIqLxVgm8N5xoEolh
         7Qfg==
X-Gm-Message-State: AOJu0Yxd9XbJR7+tuAoIod893AnGmRYi1sNtM2THSYiuPDdwOu9O0uuz
	8582ih+2mIi/maywQUThhDKnv1PHRYTi7OdH5iJK80Y2kjtg33ra685wKJ3N86HR6uRE9zaQ+B9
	+S7PlKAULPQL/fVh8N7B7SSTgeLZ59zNCM/mQuWm5c0MqlsyW4cceZ3MNuSBd0yYe032ItMMEkw
	==
X-Gm-Gg: ASbGncv3WExzYAEuuyaUj/UEnHfXkpcFaM1rR/4WBNFybNkM/MLpvGjZS+FljZfk3aT
	JOmgakBFg+zrvJrPnyTWlLKw1pAlwYkS2tVR1CyXw+Mr/0TBdKXRrQSrBtk16ck46ykmYWR6rbL
	uVWoX+6MCEa3Nit6NSVpJDeyRbuqYf92OmMpflJAu2nVf+JK7U9ORXiwGxeoGiq/ErTC1LhKbb4
	c7Q3I/EFsmnVq9IKAqjot5Uxae9yTiqEOWPHlAESK73Crt8wE03yjF+I8U6zEnodaEgSkzniMxh
	W98Un+93rmT06CKWJ+MfO0h7iARZNveN8eXNyE68A/4TF0xUjg==
X-Received: by 2002:a05:6602:2c0d:b0:864:627a:3d85 with SMTP id ca18e2360f4ac-8676362d62emr22243739f.11.1746719949560;
        Thu, 08 May 2025 08:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEuEA4Zeb23Xh5HTz0dqMYHj7Mfu1sLQt4nv8y0s2IO/n20C2Rw5OQGwnbJqAQFZo/nXe6Bg==
X-Received: by 2002:a05:6602:2c0d:b0:864:627a:3d85 with SMTP id ca18e2360f4ac-8676362d62emr22241739f.11.1746719949230;
        Thu, 08 May 2025 08:59:09 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa226825c2sm15522173.132.2025.05.08.08.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:59:08 -0700 (PDT)
Message-ID: <763bed71-1f44-4622-a9a0-d200f0418183@redhat.com>
Date: Thu, 8 May 2025 10:59:08 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/7] f2fs: switch to the new mount api
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, lihongbo22@huawei.com
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-8-sandeen@redhat.com>
 <b56964c2-ad30-4501-a7fd-1c0b41c407e9@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <b56964c2-ad30-4501-a7fd-1c0b41c407e9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 4:19 AM, Chao Yu wrote:
>> @@ -2645,21 +2603,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>  
>>  	default_options(sbi, true);
>>  
>> -	memset(&fc, 0, sizeof(fc));
>> -	memset(&ctx, 0, sizeof(ctx));
>> -	fc.fs_private = &ctx;
>> -	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
>> -
>> -	/* parse mount options */
>> -	err = parse_options(&fc, data);
>> -	if (err)
>> -		goto restore_opts;
> There is a retry flow during f2fs_fill_super(), I intenionally inject a
> fault into f2fs_fill_super() to trigger the retry flow, it turns out that
> mount option may be missed w/ below testcase:

I never did understand that retry logic (introduced in ed2e621a95d long
ago). What errors does it expect to be able to retry, with success?

Anyway ...

Can you show me (as a patch) exactly what you did to trigger the retry,
just so we are looking at the same thing?

> - mkfs.f2fs -f -O encrypt /dev/vdb
> - mount -o test_dummy_encryption /dev/vdb /mnt/f2fs/
> : return success
> - dmesg -c
> 
> [   83.619982] f2fs_fill_super, retry_cnt:1
> [   83.620914] F2FS-fs (vdb): Test dummy encryption mode enabled
> [   83.668380] f2fs_fill_super, retry_cnt:0
> [   83.671601] F2FS-fs (vdb): Mounted with checkpoint version = 7a8dfca5
> 
> - mount|grep f2fs
> /dev/vdb on /mnt/f2fs type f2fs (rw,relatime,lazytime,background_gc=on,nogc_merge,
> discard,discard_unit=block,user_xattr,inline_xattr,acl,inline_data,inline_dentry,
> flush_merge,barrier,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,
> checkpoint_merge,fsync_mode=posix,memory=normal,errors=continue)
> 
> The reason may be it has cleared F2FS_CTX_INFO(ctx).dummy_enc_policy in
> f2fs_apply_test_dummy_encryption().
> 
> static void f2fs_apply_test_dummy_encryption(struct fs_context *fc,
> 					     struct super_block *sb)
> {
> 	struct f2fs_fs_context *ctx = fc->fs_private;
> 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> 
> 	if (!fscrypt_is_dummy_policy_set(&F2FS_CTX_INFO(ctx).dummy_enc_policy) ||
> 		/* if already set, it was already verified to be the same */
> 		fscrypt_is_dummy_policy_set(&F2FS_OPTION(sbi).dummy_enc_policy))
> 		return;
> 	F2FS_OPTION(sbi).dummy_enc_policy = F2FS_CTX_INFO(ctx).dummy_enc_policy;
> 	memset(&F2FS_CTX_INFO(ctx).dummy_enc_policy, 0,
> 		sizeof(F2FS_CTX_INFO(ctx).dummy_enc_policy));
> 	f2fs_warn(sbi, "Test dummy encryption mode enabled");
> }
> 
> Can we save old mount_info from sbi or ctx from fc, and try to recover it
> before we retry mount flow?

I'll have to take more time to understand this concern. But thanks for pointing
it out.

-Eric

> Thanks,


