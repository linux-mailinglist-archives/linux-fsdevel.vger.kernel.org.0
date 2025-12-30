Return-Path: <linux-fsdevel+bounces-72257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C8CEACC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 23:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C77A30245EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE57724DCE2;
	Tue, 30 Dec 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uzf2M0ZB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnbGGsGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD63A1E9C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134734; cv=none; b=tyYQdiXrqkHqq/pfk9zFQAQ4GGAcrb9db2AZgfgdHKfu+c89HidyDlR9ga8r11IHal9dlgM7NOaI8/nVp9/fqyIp0tF8mdEpfUYMeF6raeWIgDPRxr3Tq7bpI6s5WQfMY35QkWa58UzSzrRsvwJr7+l9Gg9T7jDGfT+lHuOfaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134734; c=relaxed/simple;
	bh=eDvWa2VJe9lB6ijY6V2CsFsjFWajd38whDgN/+2Ttfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AExdlkYWdWKK6lgVvCRdUHKf3RYvqNDPG569wlrejRGCkQwGfnSbR1wYyg7by6xqY+K6uchiua2t7uKu0ZmtYi4SROoXWSrWPuSNXrKYRdGWpo1KMjxHYx+dj9b2rqpY4QYZKTR5Swcqw8LUgzcLBAFNzZdRA4oj0wpB5/RaBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uzf2M0ZB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnbGGsGY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767134730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SJyXv/bGprmgznxb/DfZxykKGqJjlUpVS8LQMq/sY4=;
	b=Uzf2M0ZB2SIAC0qjPW2Lrt2Mf3DeULk40X1KT4fbEJYm4hSSWDSpajFsbRkwhkxcVUv3rp
	sriEL628LHbuGwo97He4BZQUGcB0T+VU59P1x4eXAwAhImRFv1l7x+vHFHaWE3u9c7ok4e
	IXK4m5pHn9MOcayCmXO7LPlbOJwyvdU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-k9d3G0wxNRefTUcka7vprg-1; Tue, 30 Dec 2025 17:45:29 -0500
X-MC-Unique: k9d3G0wxNRefTUcka7vprg-1
X-Mimecast-MFC-AGG-ID: k9d3G0wxNRefTUcka7vprg_1767134729
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee0488e746so226153651cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 14:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767134729; x=1767739529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SJyXv/bGprmgznxb/DfZxykKGqJjlUpVS8LQMq/sY4=;
        b=YnbGGsGYQSDm6Tu8SzRVQ3C1Ob0U8r6l/W8gQ4HxGgL6IV1TzF7ydr3QkQaKBu4xn2
         b+C319KZUDRVk0FMYtOh5+u2GxYyAYz8azFWEzgvJlUUt+OYGiLg+Tkvk42PNbtSwM3J
         CTarfCkzCjXAgeBTcuR978DQon0l0H2Uf60+z0eDsqDdDP+pv1tXTy2aIE/kvf8ewvBV
         9ENuWbsKNrkWbUCmwm/6lj13QBpvdI0ZkkgCT/yasuXqtCRiBFChbezCaO+cft7cuucz
         U6MK4Izfqn1MY3MZoWi/YtOU7Ie3gW4vXXIlOjeChM6IxouOJutkNuinjS6toI0ya0fW
         voeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767134729; x=1767739529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SJyXv/bGprmgznxb/DfZxykKGqJjlUpVS8LQMq/sY4=;
        b=eoG8g5jBT0jYaHH0pPjezojtJxyw2sm3pKrJqVMv/7BswjYQiahYMtVh1HJChgSlKM
         kF0fR2za37bpKN/8E+unJVd9a9hRRhzltfGOVDmOvvba68Lkaa9n1URWn7J62Hud08Kv
         o5EHRn1lEJPVr3m1Z6YwJ0EySRA61tws9VF9ir3TL3alavfklTNMqEqHoKQwfFPbvG4a
         Qjs6B79ZEZ4S/pNyK89u9wkqhiIkXpysDLB3DCE814AI4fjd/RuDVKkFE6J/Lg9bqwDo
         CvBJsK9s5oW4IdFnR+rMYxIxDpx66Jk//ptFXpEE3NsCKGn3LWt0FZxdOZ8uYDa9lav7
         v7WA==
X-Gm-Message-State: AOJu0Yz1JcIDXgsKTIOEosOCuASOQydxmBMnm5yIK4hVQLEz+653apuF
	+u55g16HxcXiSn6hN3O7RR+czjRXiSnQIPragxgYiZ0QQTA37AcuvbJpmQq7KazPfDadjrxJeZC
	X+nLBaGoDxHQ4unmVGhz8nC5TVt9ZXwsf0nsEKIpC061GaKA8CSXbMoFglYCHXjrfcSo=
X-Gm-Gg: AY/fxX7a/Lswl5CWVemsLHap6cKqJEgEMhCaFsF++jTMnMbopZ6yP8BTTGhsZkJzPGi
	9DLeS67K/nrTHkhkV+iiCItiohHeIk1D7pWB7YToSjzETy7qCV0PSyHq7dc9ZoVLMHmO+hu30w0
	QOyLRY5A/0wmtxGGrYBzJi1gCSvsVHWUwZjllF/3X0qztoY2lhVVsrXchrwWwNdntA0ZwtunRDj
	dK2YonxJ1+ryNMiuNSRGSGn2PFsYAOeCcIi3to41iVv+Xh9gCNtUAgvJLC2biVa9xyPbOVsSM8D
	IlixyKTNZPcjMAj4oBqms0FMXemNasGHdTYYEIjX83YRE8r9PcphqO9L+9BP5QNHTpRydsv+dTM
	FChJn30WAM4HalAXqBWhyLhhuVQvx/CfnqjduigKorE6MpRmR7+18
X-Received: by 2002:a05:622a:199d:b0:4f1:af84:387a with SMTP id d75a77b69052e-4f35f3a0267mr525795961cf.5.1767134728723;
        Tue, 30 Dec 2025 14:45:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/WUjGMG+vgFqxqR+gAUNbwR+a/ocaYU4UpFUbesLSCsG9fPvBLnEgNjci2CiKFig6Wxjpsg==
X-Received: by 2002:a05:622a:199d:b0:4f1:af84:387a with SMTP id d75a77b69052e-4f35f3a0267mr525795741cf.5.1767134728403;
        Tue, 30 Dec 2025 14:45:28 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac65344bsm250027921cf.28.2025.12.30.14.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 14:45:27 -0800 (PST)
Message-ID: <28f144f8-431d-4c3a-a362-56083bb77541@redhat.com>
Date: Tue, 30 Dec 2025 16:45:26 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: cache-align lock_class_keys in struct
 file_system_type
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>, lkp@intel.com, oe-lkp@lists.linux.dev,
 Alexander Viro <aviro@redhat.com>
References: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>
 <o6cnjqy4ivjqaj4n5xphstfnk5jznufaygwmfkm2gyixqgfump@7fc6c6h6d5if>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <o6cnjqy4ivjqaj4n5xphstfnk5jznufaygwmfkm2gyixqgfump@7fc6c6h6d5if>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/30/25 4:04 PM, Mateusz Guzik wrote:
> On Tue, Dec 30, 2025 at 03:07:10PM -0600, Eric Sandeen wrote:
>> LKP reported that one of their tests was failing to even boot with my
>> "old mount API code" removal patch. The test was booting an i386 kernel
>> under QEMU, with lockdep enabled. Rather than a functional failure, it
>> seemed to have been slowed to a crawl and eventually timed out.
>>
>> I narrowed the problem down to the removal of the ->mount op from
>> file_system_type, which changed structure alignment and seems to have
>> caused cacheline issues with this structure. Annotating the alignment
>> fixes the problem for me.
>>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202512230315.1717476b-lkp@intel.com
>> Fixes: 51a146e05 ("fs: Remove internal old mount API code")
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> RFC because I honestly don't understand why this should be so critical,
>> especially the structure was not explicitly (or even very well) aligned
>> before. I would welcome insights from folks who are smarter than me!
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 9949d253e5aa..b3d8cad15de1 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2279,7 +2279,7 @@ struct file_system_type {
>>  	struct file_system_type * next;
>>  	struct hlist_head fs_supers;
>>  
>> -	struct lock_class_key s_lock_key;
>> +	struct lock_class_key s_lock_key ____cacheline_aligned;
>>  	struct lock_class_key s_umount_key;
>>  	struct lock_class_key s_vfs_rename_key;
>>  	struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
>>
> 
> There is no way is about cacheline bouncing. According to the linked
> thread the test vm has only 2 vcpus:
>> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> Even if the vcpu count was in hundreds and the ping pong was a problem it
> still would not have prevented bootup.

Fair enough, it really didn't make sense to me.

> Instead something depends on the old layout for correctness.

If I add ->mount back to the /end/ of the structure, it boots fine again,
so I guess nothing is expecting specific offsets within the structure
at least.

(If I turn off lockdep in the kernel config, it boots fine again too,
FWIW.)

> By any chance is this type-punned somewhere?

I don't think so... 

> While I can't be bothered to investigate, I *suspect* the way to catch
> this would patch out all of the lock_class_key vars & uses and boot with
> KMSAN (or was it KASAN?). Or whatever mechanism which can tell the
> access is oob.

Can't do KASAN or KMSAN on i386, AFAIK. :(

I suppose I could try such things on x86_64 just in case something shows
up...

Thanks!

-Eric


