Return-Path: <linux-fsdevel+bounces-51155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8ACAD34B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 13:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2ED18968C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6DF225A50;
	Tue, 10 Jun 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BklAdfMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BEE188CB1
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554133; cv=none; b=VjzDAjKpfsGaTri9n/pkQhofEoJp27axmDvhMrwDf8SikBjIIb4CUKeUITiq4ZCbIje+9XFuZNFK21GnMRmKGz0S/aRCxXpdeag3CdS+qA6j3XYp/zDQBM9xNd3V0ZDfftUeTXItqDBs85iC+wGOGY8NAwHbaE93uoVr+aTxwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554133; c=relaxed/simple;
	bh=6O7TowWrW8RNsfaxEJIVwT/zpwPDOK3ZMQ5Kpq5kBeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAYB3IFpUqgYo4iJshxFn/1NRreLBbrJo1WN6bynhkgSdQ3yWBdoTvjYTbPxYOEV6kFIPqnjX/ECG2wFavWvET2rBrej+nrTVkxIJwexEEd6GCZqJgVbOstQSSQbFfDa0txKeFmtv4P7tXHyFsbOpcRPB2xYQ8kGSzfL60L5SbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BklAdfMP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749554127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/NrHc0np9+RIheS43BkzhBXkoojAIRywKDBap8+J70M=;
	b=BklAdfMP0SD/bUPWgBVgRzj+BfxvDSe7EKPlAUJCoEdlP9lOVC2SmJtA1+SQ7LCXXHeoJt
	QnJFqKpRYEAJ1sUnHO7jzf7zhLRVGtELG6Yku+JnMuc4RMClygGgM5qsACR36J3J9bgXAS
	GIcMztsk9sc+B6MSuEeMXKyqdi54Kcw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-1P4oCbMhMRmzfBRS41ztCg-1; Tue, 10 Jun 2025 07:15:26 -0400
X-MC-Unique: 1P4oCbMhMRmzfBRS41ztCg-1
X-Mimecast-MFC-AGG-ID: 1P4oCbMhMRmzfBRS41ztCg_1749554125
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so3492368f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 04:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554125; x=1750158925;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/NrHc0np9+RIheS43BkzhBXkoojAIRywKDBap8+J70M=;
        b=HfM+j/o3mL461NGXGBSrRiHnAxn9MYXeQhiWrsq3+3jFd8Gt3pKci8P85t7X4Up/i+
         y/7d4JonR8sE4ZRrliLWqgb7it6NM3GIvK8KYvfhlzEFZ46XMgQRucSBnuFB3Ace6EKk
         OS/WLgknyFzh2uN3Hm96jHNhwGhcUV4Ow2RUcktv+rGhMryVyMvjGDF7cwJS2CI0i1YP
         uuBafrdfJJQOjdPsFDsfznoBuKaGRj6T4fTnctNUhyiKIRBGR8yr+7zXHjMGWJX9XVV/
         rOa8ZeqpqVIQWV9d3vZNIDpy5OlfE4+Vf8Ku/HdTLDri30QIbYa5TznZPixUDlSXe/c+
         d+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX9xb9Rr8FYoNn08rDyU05Pq/WUaab5uW85PAzot1PZOPkNmpTUgcZmRFONxwjUCkSnsz0E8CDDq0D5XLve@vger.kernel.org
X-Gm-Message-State: AOJu0YwivNPHiYpCD1DBZuC9yTYfGWd5yLIZhcGtudGSaq0rhPYRGwj+
	rC0HhOrc5OJirc3+ZtyOT75gQD18ptY+QmqPIX139TYIt8xjLAkHwN33U8wq/wlg4e+pzzdPh10
	zwVkpPWePxIo60b7ACEDKdfvBz+5piFOPUWXzGKh6Y4VH1KKvOAJtoKdUTqjUrTQVNgk=
X-Gm-Gg: ASbGnctF2h6TXlDGLN3p3FxCyZK8+lEikLlAewlLgwU2F/U3YHmmVQIZKqWfwQPFu8D
	oodIm322ExgZ7y6OLlhtzQ/2Hde2BCz8/NcQojqf6A5xQsz09hlrgQqFDXsIT+Cu7fv+/fvSyCd
	6b32ODEuVL8rlmR3uq51AAeMhc4pFlZqkytzECl5w8SiAheShmzRUzdwrY3tEPef8Oc30h/chDS
	XX1VD0YeDljSSJ7QwLsY08TPtWZ67r9llzXXswR6Zwj2OGxl5yQCKFP0JW+e9ktGnHXk9sjfhJW
	fLvwDAgMfcURMZb5RksC785cn8VPs80vKsQOL58bT/H97S8L1dZzn4E=
X-Received: by 2002:a05:6000:250f:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3a531cf3622mr13074029f8f.58.1749554125285;
        Tue, 10 Jun 2025 04:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb7TpoI7QavnirWX2bw2oFs44j+xInfEFt55r8S38W/c8SoW7I3riRWPjYc5yrnZ1Xev10nA==
X-Received: by 2002:a05:6000:250f:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3a531cf3622mr13074011f8f.58.1749554124861;
        Tue, 10 Jun 2025 04:15:24 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209ce132csm138205255e9.12.2025.06.10.04.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 04:15:24 -0700 (PDT)
Message-ID: <c08c2f5f-2607-42d3-8d68-4ea99c2d7e72@redhat.com>
Date: Tue, 10 Jun 2025 13:15:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /proc/pid/smaps: add mo info for vma in NOMMU system
To: Andrew Morton <akpm@linux-foundation.org>,
 wangfushuai <wangfushuai@baidu.com>
Cc: andrii@kernel.org, osalvador@suse.de, Liam.Howlett@Oracle.com,
 christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250607165335.87054-1-wangfushuai@baidu.com>
 <20250607141857.40b912e164b8211b6d62eafd@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250607141857.40b912e164b8211b6d62eafd@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.25 23:18, Andrew Morton wrote:
> On Sun, 8 Jun 2025 00:53:35 +0800 wangfushuai <wangfushuai@baidu.com> wrote:
> 
>> Add mo in /proc/[pid]/smaps to indicate vma is marked VM_MAYOVERLAY,
>> which means the file mapping may overlay in NOMMU system.
>>
>> ...
>>
>> Fixes: b6b7a8faf05c ("mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings")
> 
> In what sense does this "fix" b6b7a8faf05c?  Which, after all, said "no
> functional change intended".
> 
> It does appear to be an improvement to the NOMMU user interface.
> However it is non-backward-compatible - perhaps there's existing
> userspace which is looking for "um" and which now needs to be changed
> to look for "mo".

Very likely no. Nobody should be caring about this kernel-internal thing.

But let's read the doc:

"Note that there is no guarantee that every flag and associated mnemonic 
will be present in all further kernel releases. Things get changed, the 
flags may be vanished or the reverse -- new added. Interpretation of 
their meaning might change in future as well. So each consumer of these 
flags has to follow each specific kernel version for the exact semantic."

So nobody should be relying on any of that, but the doc goes on

"
This file is only present if the CONFIG_MMU kernel configuration option 
is enabled.
"

Huh?

$ grep "task_mmu" fs/proc/Makefile
CFLAGS_task_mmu.o       += -Wno-override-init
proc-$(CONFIG_MMU)      := task_mmu.o

NAK

-- 
Cheers,

David / dhildenb


