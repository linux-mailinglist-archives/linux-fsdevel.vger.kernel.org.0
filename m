Return-Path: <linux-fsdevel+bounces-62368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798E5B8F5FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F155189FC05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58872F7477;
	Mon, 22 Sep 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bu8KXftl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF922F0C6E
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527877; cv=none; b=Cy/DKGLu7y2cO7fUgU9MsQvUJbFsyDZK5Rp4UMm9muJJgma593qr+cWa4PUNkdWGQnJtley4f/kTkFIC4hVbOj3WhDY7Y9oBtIaPXxS00MfXBHWgy+TFsyQUKy+F59GSgwGVuTuphY45i6UUjpm6zsJzrxp3ydtX17NVH2pM78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527877; c=relaxed/simple;
	bh=z22lo+Sx0EHZpjam8qqB/oYPmRH+xQqLMr6BUeu2yhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ik2vjskpsGn49CEuCkfcp6XI9x4mFXwhmiXhCoBBMNCybFm2O2T9IZw45rXdjrchdwzBU7uR9NuH/tuhIwxv0fnKtfv/jWuBO9iHsXJt12IDPL5sDXRZkakJJuyR9x1TeAHdkV3p3qsekf8THpk48922R55bD3wBSao0TXQ9eP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bu8KXftl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758527874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+s5hco+l/6O5Jum665AcKyXnxSxFI2cgMRrfhyjJ+7Y=;
	b=bu8KXftlA7SgVJ8Af08LZDtmcjm0d781JgRfUHg037brTgipsMSAToqp1wfK6vC2c0LxVn
	tpt4KU+QVE/7iJNzMmc02HXrewMffToorKL8zI8GX5dBQkX2YUDuzPp307i3ytFkiyC7lZ
	+c8vXJTt1bmNBfnG4CcV3t3m7CEZ3ME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-QzINwYQzNSSqK_e7RlN_XA-1; Mon, 22 Sep 2025 03:57:52 -0400
X-MC-Unique: QzINwYQzNSSqK_e7RlN_XA-1
X-Mimecast-MFC-AGG-ID: QzINwYQzNSSqK_e7RlN_XA_1758527871
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45e05ff0b36so4179455e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 00:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758527871; x=1759132671;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+s5hco+l/6O5Jum665AcKyXnxSxFI2cgMRrfhyjJ+7Y=;
        b=iaD9/9cu5snYjMpcTP9A5Ts99k8HNrJCygCAjnJ0bLLSYzmDmKfQ+ME6Pl4XrV48HO
         Fpu8bpb96q0Lh28X0TSx+YA5y9x0wtie1F6s+r8KaEsIJQuSoGfW023FchQJ81LKcoK5
         3IKlMtOWnng9hdzuapMEdLJvwigQ31Oe2YDrkD00gWBXDy/t0wN/nx0xQqsZp2wT6nbU
         aTRqlESogsYpayZ0F1JNXUk7h/wZEBOptUTSad7EPE/wPx4ZTj1ti4SMh93rZl+V97rg
         xw+j726l+iKIBlTlHkDxpDZN/gf8xnOmFo+ldngXPLc49/2UtdNjuue59Nmcb819MvQh
         /o/Q==
X-Gm-Message-State: AOJu0YzBdkW/XVDUXtt4NNsfiVHMKs6KoM/hd0tss9NbhHL0Aus7ZwtK
	WVWJhFNcPcBzjp6IDwNc8lrws9h2ywBe6CA4zfvK4+8M5SY/JclW8qEppytpRdAPTQcOSSnpJy3
	IPZofEA/jS5u7jmzFKG5gPHeP2XYYE2jlYY5t5lpjyKL6dZQ5M0mkKGGyl2IwgnuJQ4M=
X-Gm-Gg: ASbGncuDLDs40rdeWIWMGYWTjkZ2HLNHc0AvSpZBTLimf8tQmT5rw8AV7Q7V6lRNDPV
	W7tFjC7b8zEoJekENHVlmJo7CFfmIXCrzM5eCyCWTKy97aa5tv+Iue6pvgoZ5mbMdV7zgIZMPHE
	+4ItZp92bIY+LwMdAKIGMR3OUweInpu+9Sh4QOX2D79BNrI/FYWBtBkJ83MoenPZGMWRPxqY/pu
	TaT0R+j1cEVtNvnaQ1NEQCR1R8MjimMuGFwNewCIEqZGiS66Ni9pqqhJ1BIBNYqKCrpa5xfvF9P
	k68aU3rwUewQcC5jPLqRteB7QzntaTMqWRGy6QvHcMFDzGILilYtXV3jre8n1bl1WNjw+8A3MVP
	Z5fRFsCp7t/LTvttwyIrZF5niYYbljwRgin3xPllI2sqjFYih7NlqyIDmSBwOMD8=
X-Received: by 2002:a05:600c:a208:b0:45d:e4d6:a7db with SMTP id 5b1f17b1804b1-464f79beba7mr83846395e9.5.1758527870859;
        Mon, 22 Sep 2025 00:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYtl6dMrscq08hXmNwVy+KDBLBadcgkwMR1AxFYVI10XhNR4OhAm0eqD+UkX6mimt30arIhQ==
X-Received: by 2002:a05:600c:a208:b0:45d:e4d6:a7db with SMTP id 5b1f17b1804b1-464f79beba7mr83846155e9.5.1758527870417;
        Mon, 22 Sep 2025 00:57:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm255773735e9.12.2025.09.22.00.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 00:57:49 -0700 (PDT)
Message-ID: <17919309-4e13-4ca0-945f-82a2c71e24d2@redhat.com>
Date: Mon, 22 Sep 2025 09:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/task_mmu: check cur_buf for NULL
To: Jakub Acs <acsjakub@amazon.de>, Andrei Vagin <avagin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Suren Baghdasaryan <surenb@google.com>,
 Penglei Jiang <superman.xpt@gmail.com>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, stable@vger.kernel.org
References: <20250919142106.43527-1-acsjakub@amazon.de>
 <CANaxB-yAOhES6j6VJMDybAJJy8JEXM+ZB+ey4-=QVyLBeTYfrw@mail.gmail.com>
 <20250922072414.GA40409@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250922072414.GA40409@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.09.25 09:24, Jakub Acs wrote:
> On Fri, Sep 19, 2025 at 09:22:14AM -0700, Andrei Vagin wrote:
>> On Fri, Sep 19, 2025 at 7:21 AM Jakub Acs <acsjakub@amazon.de> wrote:
>>>
>>> When PAGEMAP_SCAN ioctl invoked with vec_len = 0 reaches
>>> pagemap_scan_backout_range(), kernel panics with null-ptr-deref:
>>>
>>> [   44.936808] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
>>> [   44.937797] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>>> [   44.938391] CPU: 1 UID: 0 PID: 2480 Comm: reproducer Not tainted 6.17.0-rc6 #22 PREEMPT(none)
>>> [   44.939062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>> [   44.939935] RIP: 0010:pagemap_scan_thp_entry.isra.0+0x741/0xa80
>>>
>>> <snip registers, unreliable trace>
>>>
>>> [   44.946828] Call Trace:
>>> [   44.947030]  <TASK>
>>> [   44.949219]  pagemap_scan_pmd_entry+0xec/0xfa0
>>> [   44.952593]  walk_pmd_range.isra.0+0x302/0x910
>>> [   44.954069]  walk_pud_range.isra.0+0x419/0x790
>>> [   44.954427]  walk_p4d_range+0x41e/0x620
>>> [   44.954743]  walk_pgd_range+0x31e/0x630
>>> [   44.955057]  __walk_page_range+0x160/0x670
>>> [   44.956883]  walk_page_range_mm+0x408/0x980
>>> [   44.958677]  walk_page_range+0x66/0x90
>>> [   44.958984]  do_pagemap_scan+0x28d/0x9c0
>>> [   44.961833]  do_pagemap_cmd+0x59/0x80
>>> [   44.962484]  __x64_sys_ioctl+0x18d/0x210
>>> [   44.962804]  do_syscall_64+0x5b/0x290
>>> [   44.963111]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> vec_len = 0 in pagemap_scan_init_bounce_buffer() means no buffers are
>>> allocated and p->vec_buf remains set to NULL.
>>>
>>> This breaks an assumption made later in pagemap_scan_backout_range(),
>>> that page_region is always allocated for p->vec_buf_index.
>>>
>>> Fix it by explicitly checking cur_buf for NULL before dereferencing.
>>>
>>> Other sites that might run into same deref-issue are already (directly
>>> or transitively) protected by checking p->vec_buf.
>>>
>>> Note:
>>>  From PAGEMAP_SCAN man page, it seems vec_len = 0 is valid when no output
>>> is requested and it's only the side effects caller is interested in,
>>> hence it passes check in pagemap_scan_get_args().
>>>
>>> This issue was found by syzkaller.
>>>
>>> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Cc: Jinjiang Tu <tujinjiang@huawei.com>
>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>> Cc: Penglei Jiang <superman.xpt@gmail.com>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Andrei Vagin <avagin@gmail.com>
>>> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> linux-kernel@vger.kernel.org
>>> linux-fsdevel@vger.kernel.org
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
>>>
>>> ---
>>>   fs/proc/task_mmu.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 29cca0e6d0ff..8c10a8135e74 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -2417,6 +2417,9 @@ static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
>>>   {
>>>          struct page_region *cur_buf = &p->vec_buf[p->vec_buf_index];
>>>
>>> +       if (!cur_buf)
>>
>> I think it is better to check !p->vec_buf. I know that vec_buf_index is
>> always 0 in this case, so there is no functional difference, but the
>> !p->vec_buf is more readable/obvious.

Yes, please check p->vec_buf like we do in pagemap_scan_output().

> 
> I chose (!cur_buf) because it is more 'paranoid' than !p->vec_buf,
> but happy to change that in v2. However, I noticed that the patch was
> already merged to mm-hotfixes-unstable in [1]. Should I still send the
> v2 with adjustment?

Feel free to send a quick fixup inline or resend the v2.

As long as it's not in -stable we can change it as we please.

-- 
Cheers

David / dhildenb


