Return-Path: <linux-fsdevel+bounces-56785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E6EB1B8E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E19D3BC684
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AA217F2E;
	Tue,  5 Aug 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTfkSCC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A322AD14
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413416; cv=none; b=jAbLJO7jCo93p+IgutSirgzJKg1Lj2OdkFfysgdBVQdx3Ry5AgxVY6RV3VBUEMhR4tw5XjikLAfBvY6//OerSb2u27peIicvzD2AcMSggfnP9opW9OnULYLK73OlM1Wxx94Ttr2eXMywFk3zA5nhffYVVlPrpA9oMU/HmwF7lHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413416; c=relaxed/simple;
	bh=Kh56pL20T7H5zlhh9Vn7vZ2/KCtiWdU2V/izuigl+nM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ueuoQi0+3VQ8KepCgF3kj01QyZ5bu0qN0UI7O9d96Sx/rmW+ulWzPbJGwjGvhuECr1Mh9ZZADkL/QHF3y/7fDAG/3hFGocTcE8u/wtcyqgdCI8O16XGefc1ncG4e9f+xKpXJzuLTXsccYXjWNOWIHuI8p/I8S87haoukOr8hZm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTfkSCC5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754413413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbVVoGaAB5mP5RybMnrtLIB1JKz2+YRNMZHEyFUTSmw=;
	b=cTfkSCC5kvsANOJX+UYcPqpSlBuTWtNoTfLAK9V6FkRYbPgKP9eKq+zwTV8os1YuIMIPz6
	fat/ZR6APt1nPRISR7Wtmb0sZcaGWpQuP5NKrq49xJKH3HHPFAG2bUgXXek0p2LQ08UJj2
	1fILTAiLlZBy3dICkUBKLZ1rjIXCXBc=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-WLwzhkWbOUKNKLItuKXm0g-1; Tue, 05 Aug 2025 13:03:32 -0400
X-MC-Unique: WLwzhkWbOUKNKLItuKXm0g-1
X-Mimecast-MFC-AGG-ID: WLwzhkWbOUKNKLItuKXm0g_1754413412
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-30b7d09bb58so4100055fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 10:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754413411; x=1755018211;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbVVoGaAB5mP5RybMnrtLIB1JKz2+YRNMZHEyFUTSmw=;
        b=HKiv25VwHbyJqTp8njXuxi4cpmeE23KC73WLYu+6EIpVY4mMCxWJ83X7HcGUGtKZTk
         QJ0ByWON15JBu9UsdK7QHesNYFspxhIoOhI5y5z2M+uPc3IPupkLlLBw4nPEti6JFyki
         RY6Ye7SXidHDzUvRhRhd89kQoanxFL2iHs4rr+f9078CPqnkuDCJTeiqLKJVWjxkS+o4
         iuvUEJIGh/AXeQyBotA89kwCiy9BiZ6HGbOeV70yB0eNthDWW9rnVhZvtM/VV6odNku2
         LdjSrbgXVdKgwehTzLK+EeJ47qXIwgZ5Eb+CG5H+5o15mFTo4sXX5Zp2CgHnERSfcPvM
         8Zcg==
X-Forwarded-Encrypted: i=1; AJvYcCWYgdTpB0BNauCuQ44gl4qG0hKgIiBjC4JhZJF7XYMEzgAdbCshBgkzqYaQ7UFaEp5s8oqZqaS8jtPO1651@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AVnkNDAqsN49hF8j6YK0+dlHcc4BfnMbC74T+DcwIVIC3GPY
	2yB0PdGccQ1Hdb2YTMSdWpMr/vyelTV4GBNzn6uW74TGXRzKoe4MgU7Q1D08GdtQdJUkOPdEoFd
	lDXslasCQvdTmv/tq0sOrPXB2Ivmb9R8RIuPRNOFhHDjpUBC7xCMrr0lPhE531BVFPs39mY7ir2
	dSFw==
X-Gm-Gg: ASbGncvsAtBLIi3eTZLn8cp7wAIrLhkmUBDrqHY+/lkO7w9p3zRwdQS77BIKdzbRz3P
	0D/WO90KHecNQ17yUKTIMfpOoVMPeznZ3MD1t8P+KU4cXD/WRorz9P63WnGUxPge+wCztmd2Bbv
	tS4tDxU4KR5CuJQZuHHdpxZWbBCgvQist2KeeTK0OCxdmMH8l72KlUOb0x8MpN+cu+1d23FXXzX
	jsOMYYJXsAjz6gdNaNcslBbZcG53PhOccBoV3BKGIFvdq3dvUnfnOZLROr8AIcyxYFh8AEB/odc
	OBQ4F4LWaheiP86Pn1607JmZTb30dk2G
X-Received: by 2002:a05:6871:2317:b0:2f3:4720:f7ca with SMTP id 586e51a60fabf-30b67628183mr8873980fac.2.1754413411377;
        Tue, 05 Aug 2025 10:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc+1OdQM+G/winnp5rPILb3JTMTlJWC5iVwWvIxlu/QYRJKW6ClokbBNAn1HhCL44Xbq8bxQ==
X-Received: by 2002:a05:6871:2317:b0:2f3:4720:f7ca with SMTP id 586e51a60fabf-30b67628183mr8873915fac.2.1754413410937;
        Tue, 05 Aug 2025 10:03:30 -0700 (PDT)
Received: from [10.2.0.2] ([146.70.8.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-742fa231cefsm434274a34.45.2025.08.05.10.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 10:03:30 -0700 (PDT)
Message-ID: <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
Date: Tue, 5 Aug 2025 12:03:28 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: fix mount options not being applied
From: Eric Sandeen <sandeen@redhat.com>
To: Charalampos Mitrodimas <charmitro@posteo.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
Content-Language: en-US
In-Reply-To: <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 12:22 PM, Eric Sandeen wrote:
> On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
>> Mount options (uid, gid, mode) are silently ignored when debugfs is
>> mounted. This is a regression introduced during the conversion to the
>> new mount API.
>>
>> When the mount API conversion was done, the line that sets
>> sb->s_fs_info to the parsed options was removed. This causes
>> debugfs_apply_options() to operate on a NULL pointer.
>>
>> As an example, with the bug the "mode" mount option is ignored:
>>
>>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>>   $ mount | grep debugfs_test
>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>>   $ ls -ld /tmp/debugfs_test
>>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
> 
> Argh. So, this looks a lot like the issue that got fixed for tracefs in:
> 
> e4d32142d1de tracing: Fix tracefs mount options
> 
> Let me look at this; tracefs & debugfs are quite similar, so perhaps
> keeping the fix consistent would make sense as well but I'll dig
> into it a bit more.

So, yes - a fix following the pattern of e4d32142d1de does seem to resolve
this issue.

However, I think we might be playing whack-a-mole here (fixing one fs at a time,
when the problem is systemic) among filesystems that use get_tree_single()
and have configurable options. For example, pstore:

# umount /sys/fs/pstore 

# mount -t pstore -o kmsg_bytes=65536 none /sys/fs/pstore
# mount | grep pstore
none on /sys/fs/pstore type pstore (rw,relatime,seclabel)

# mount -o remount,kmsg_bytes=65536 /sys/fs/pstore
# mount | grep pstore
none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=65536)
#

I think gadgetfs most likely has the same problem but I'm not yet sure
how to test that.

I have no real objection to merging your patch, though I like the
consistency of following e4d32142d1de a bit more. But I think we should
find a graceful solution so that any filesystem using get_tree_single
can avoid this pitfall, if possible.

-Eric


