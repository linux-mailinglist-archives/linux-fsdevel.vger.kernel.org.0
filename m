Return-Path: <linux-fsdevel+bounces-48381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A477EAADF4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD2A986574
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B17027A46F;
	Wed,  7 May 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1uhdeD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537E27A12A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621079; cv=none; b=iOu6vLalcNi0qBrWRuAiPUDATpqB4COckfRS4cob0rE9J8nLuzrliaeG5UIsF0r0+kOE81SRQ2LDCxgzG8+nngP9ntqsasLI4vmi5AC9QF6mzMF+qQiLdQstrOeeW6L6jv+q48ZrbaBtA//EuYrfjjCfxyoSdjLkj1YKQeX9jfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621079; c=relaxed/simple;
	bh=tFrfZ0rEZv9vM5/rihPfchjuieo3TFAlubbSr3BJlXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrN1/s2coEvQxC/J/6IhhtbblcuYvnawN2b6B+zUSsfXVl1SNi0jfibkWOb5qtJJ/O6FDrL0k2CwViEKgLCR8j9zg0VNSRXuMOKb+OwezxlpHfBKAb68BIjYEIHlDqc/fl3OFqERW7pAgkTdsxk1yEkqC53qSaX3NLVcoOIWnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1uhdeD7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746621077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYtdEZFWKmpC8xSomua+Eb/tpZI4qDTrOenLKiGUZTY=;
	b=D1uhdeD7kyAIDE+m+B3Z2M6pAqMvMo25IeNf+mC5j8Qn9yQ2Xl9qbA2eAyZbG3TRRdyApW
	NaPo+ze+tI+5YdmHXdnPk4Gm7ZoRMJTP9oZGvfde74CzXc89CClbTgPbZC0aDwU9yn9Dmq
	MKCBAESfz6+Hoyy2HKwjO8TeB1xdcrA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-fnfhohQgMaONYjZMPq8oDA-1; Wed, 07 May 2025 08:31:16 -0400
X-MC-Unique: fnfhohQgMaONYjZMPq8oDA-1
X-Mimecast-MFC-AGG-ID: fnfhohQgMaONYjZMPq8oDA_1746621075
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3da779063a3so1926605ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 05:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746621075; x=1747225875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYtdEZFWKmpC8xSomua+Eb/tpZI4qDTrOenLKiGUZTY=;
        b=TF/EJ3DgZM3B8ohJGd8WDutO85qUqDcmc6X2DfKSA55cUksWHv2qy4a4M7fk3m19OS
         NlRa5ZJEJA6GOuK3EgkL/iE58es+E7Y0OCFqMaMMQQNUgJNIOq+d/aWtZbEw0jmfNv3T
         60En6ImHgo+iysKTdH+nw8my/ZfGNUHvkvufYwFu/YMTL0f7HktF7JdV2T5SCopE0bxp
         or43fDr/JMZrttF7O/0tqWr6UYX5C/nrHj1QcmWpr74Y+qolm/J8+fe+QjO5hZnwFAB7
         gdn+COYjm5rzihWjn7WJ3Qds1NA5y4DnNT2SzTH2V8yKg8ma8wiFi7vXNCEvrBpSOyVr
         YZVg==
X-Gm-Message-State: AOJu0YzH1yzgmbq8V6Bb73C/lmOlYdqhZa4plqN7cN2zBoc5VfOF76az
	yUchl7ADsHkIG9Xq0SEtvpHLucIgFSsNcB6IRMKwuHNUY/RtuWGopKaGBICg0lG+GP2H3zucQ+S
	Sic5pDawhHzRMblwBzXZ7i62NbYPsoQPzygbSRygCcNsmmDeH3U3rueA0YLmClEPdCjlMFR+fyQ
	==
X-Gm-Gg: ASbGnctMehOKpU8TVu1OUfhpi13OdFEoMSuw4I74yKWzxj9C1Wt8E8UjYQutjRO+zDK
	ugtqAVkw8eREL6I4SyHw+oEG2fU6k4jSWfCmN5Px7R2mY6xQbZIvLh7d7GgA5RUA32C2m5RNy+X
	c/5L7ufXUuMrkyZyYSuVTsNQiBYQv2eftfaLgnrny5k4zc4tTZZ0Web0b06bsYeQ0a1no3WMSD0
	+fIzGZCDvXKrB8o/XebMHpoovSxgs4y+Nd8/BXb0VqtajfxEstwHFv9bd6tERLNVxt21rTxP+EJ
	YQgNOkiZ4Dgdc8YdOcMLOFbZCIY6yblMo8nVNqUikJ0EUqIkLQpa
X-Received: by 2002:a05:6e02:3709:b0:3d8:975:b808 with SMTP id e9e14a558f8ab-3da738d8a98mr34022555ab.5.1746621075018;
        Wed, 07 May 2025 05:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQAiNI9kfVQqBa8xVioYNC5IOk9jOeCgJeTdIQHIoZgNy+sJuKSFYSQWdauJCP5LwEyafPSw==
X-Received: by 2002:a05:6e02:3709:b0:3d8:975:b808 with SMTP id e9e14a558f8ab-3da738d8a98mr34022095ab.5.1746621074663;
        Wed, 07 May 2025 05:31:14 -0700 (PDT)
Received: from [10.0.0.82] (75-168-235-180.mpls.qwest.net. [75.168.235.180])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f8a0c3df0bsm2372652173.73.2025.05.07.05.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 05:31:14 -0700 (PDT)
Message-ID: <db0c33f2-9fa0-4ee7-b5c9-e055fcc4d538@redhat.com>
Date: Wed, 7 May 2025 07:31:11 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] f2fs: move the option parser into handle_mount_opt
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, lihongbo22@huawei.com
References: <20250420154647.1233033-1-sandeen@redhat.com>
 <20250420154647.1233033-3-sandeen@redhat.com>
 <2e354373-9f00-4499-8812-bcb7f00a6dbc@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <2e354373-9f00-4499-8812-bcb7f00a6dbc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 6:26 AM, Chao Yu wrote:
> On 4/20/25 23:25, Eric Sandeen wrote:
>> From: Hongbo Li <lihongbo22@huawei.com>
>>
>> In handle_mount_opt, we use fs_parameter to parse each option.
>> However we're still using the old API to get the options string.
>> Using fsparams parse_options allows us to remove many of the Opt_
>> enums, so remove them.
>>
>> The checkpoint disable cap (or percent) involves rather complex
>> parsing; we retain the old match_table mechanism for this, which
>> handles it well.
>>
>> There are some changes about parsing options:
>>   1. For `active_logs`, `inline_xattr_size` and `fault_injection`,
>>      we use s32 type according the internal structure to record the
>>      option's value.
> 
> We'd better to use u32 type for these options, as they should never
> be negative.
> 
> Can you please update based on below patch?
> 
> https://lore.kernel.org/linux-f2fs-devel/20250507112425.939246-1-chao@kernel.org

Hi Chao - I agree that that patch makes sense, but maybe there is a timing
issue now? At the moment, there is a mix of signed and unsigned handling
for these options. I agree that the conversion series probably should have
left the parsing type as unsigned, but it was a mix internally, so it was
difficult to know for sure.

For your patch above, if it is to stand alone or be merged first, it 
should probably also change the current parsing to match_uint. (this would
also make it backportable to -stable kernels, if you want to).

Otherwise, I would suggest that if it is merged after the mount API series,
then your patch to clean up internal types could fix the (new mount API)
parsing from %s to %u at the same time?

Happy to do it either way but your patch should probably be internally
consistent, changing the parsing types at the same time.

(I suppose we could incorporate your patch into the mount API series too,
though it'd be a little strange to have a minor bugfix like this buried
in the series.)

Thanks,
-Eric


