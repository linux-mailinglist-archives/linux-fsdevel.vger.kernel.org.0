Return-Path: <linux-fsdevel+bounces-38875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A4A094DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6C63A7498
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F36210F65;
	Fri, 10 Jan 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXqnSaeG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACF20B80D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522316; cv=none; b=qNOG9lXEKroB1vXZ7zA0DlUQL79MFGbn0hCAvVaNh/64Xk29+fzVfEfkPpbpJy/3cRqg62SL1T41Wo/d0sL848Av0SKQGsIk0bluaYCp2TG4DcuRCCzH9HL/khwFIykmMYqtkYnGgRL5HXrxsM2Xe/UGEzfL47vqNIttci1bDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522316; c=relaxed/simple;
	bh=Hrjcgp/DWVbhELd7eMDYYmduqmn7vPiLer1gG4QF/Rc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=U2Rq+NFZblCqUjC6Vs5ub7OuwQI8cKtXSBLkUqLNub74JVeI23DevLgdOWIaBu1CLkTwPIMcw5mPMkX3V2TUYLtpnPSlF1FM1MKsIDyMvNZOIyhqSoxQy5CGBMhmnLm1tg+QNB4xb/IU1Habf8U3G1c0NioJfJDdoQ38exVgx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXqnSaeG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736522313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GnulKGri+q2L98Ox6/qj2+8sbzNTdv0kAItYj+74kRI=;
	b=MXqnSaeG5UKvlbev2UmvMYBEZSs1S0hqUvbYrSrxxcdo0d2wbG4vbMmAyHNdYpZ65qRs9F
	QBA67iTACfUsXtmUb+MWImJiXDmAhCGogX5RG+wKe72EUFd7quioCY3Ac7T4xHnDHrSQeW
	7c7pxBaM6ES/Mg6M8TKAbhq03f9JEn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-zaDlL4fENkSLUjELzxlX_w-1; Fri, 10 Jan 2025 10:18:31 -0500
X-MC-Unique: zaDlL4fENkSLUjELzxlX_w-1
X-Mimecast-MFC-AGG-ID: zaDlL4fENkSLUjELzxlX_w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso18878105e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 07:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736522310; x=1737127110;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnulKGri+q2L98Ox6/qj2+8sbzNTdv0kAItYj+74kRI=;
        b=pzwWTJ6nO05sDyGuWqNIlWqXodkt6RRuQ1PnZS6LixiXlOn1CDowe+Kp5aJY7yvfD5
         JfhjL80IQTESbhsEyRKQjtN8axOym2w5AqVTUpqTlMbL027DsCWZAoWWNkIQ4au92Cse
         rqVTpIiFKCM53XscwnYWUbhpEVwV+1EJAjt1hotGFLd46dbckmYa0aIlG3Qa2JomQ/1R
         H3gKckVyAmF4ZaJGHd0CvNoiceAFlGZUkoSAZe8n+ZeJ4/ecanjtrVi/xzhE12yPkUdf
         5DAM2uOAviWBNaqfiXo3k7CrQQKl09CNaBdyl7O0mnOG7O2uNy9At7VxQi83GSZfDCdW
         l5+g==
X-Forwarded-Encrypted: i=1; AJvYcCVv0IychmJXAS5cEzkDrtXOGsIbITqqqCIWIurPqfp3ArANk7YWe0tLJ7zLRqwPebGuOFk9JiGCDouPQ6cD@vger.kernel.org
X-Gm-Message-State: AOJu0YybkvzBhFfrhy+atCPyKskmZECXSbn6ZN3lhjM8+DdptK+H6mcW
	IWBsvsWZGiPROTxHzNm0EReyoLe5PIbwaGdpjRymuPejDqdjhfs+3yxlZhIyUMbol3hzX0xg3lj
	T9Ut2Rs03y9d98kf0ugI0x10c4RXO7s2jOorzkwj5hvn54mCxGvH0DHdblS6W8Fg=
X-Gm-Gg: ASbGncvRhMpfywEuigpVpFKvPUJOzGRyTpSU7Ph1mIx6xK6cEqzwBm5a6VycXflU4Bd
	6EKRav5SHecfhKs9d0k55T0kTr3usvW+DSNkEypoPJjSNDcDWGiqXSDNNNjVtxMCgO5gDm48FI6
	WJFyKpeJIW7xREcmbwBm9cW75unSnhS9GqkeZZPwcMZgUmqJrNFkpuLGVcWiY9kw1qH9yl451ft
	40IWroWstkwJeNrSr6QAQg2NHU0rXdzNE7EKDqFNBC8pQjoNoBdADjV/n13kR5CPR4TWp4ZipS2
	iM/kvcvA++SyV5iNVfNtpLWNL6t1N3mf1UPx1Sfshx+IjKrM8O3B5Scw2phxTrR5FCtG6dyMV5C
	SYDm25uYC
X-Received: by 2002:a05:600c:1c84:b0:434:e9ee:c2d with SMTP id 5b1f17b1804b1-436e26e2725mr92268995e9.26.1736522309962;
        Fri, 10 Jan 2025 07:18:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5NrUdWF2CMkxRLQHueBH2rNEN+UrHczd/nKMHwERII9+ZOBiGtNPVbp8d5beut7rPuN0Ukg==
X-Received: by 2002:a05:600c:1c84:b0:434:e9ee:c2d with SMTP id 5b1f17b1804b1-436e26e2725mr92268775e9.26.1736522309564;
        Fri, 10 Jan 2025 07:18:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d050sm4875102f8f.15.2025.01.10.07.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:18:29 -0800 (PST)
Message-ID: <6f2e8d0c-8940-4442-a023-477e5e8b9338@redhat.com>
Date: Fri, 10 Jan 2025 16:18:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] kernel BUG in kpagecount_read
From: David Hildenbrand <david@redhat.com>
To: syzbot <syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67812fbd.050a0220.d0267.0030.GAE@google.com>
 <500b62d9-8e09-4838-9817-1e2e2216dcdd@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <500b62d9-8e09-4838-9817-1e2e2216dcdd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 16:09, David Hildenbrand wrote:
> On 10.01.25 15:33, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    c061cf420ded Merge tag 'trace-v6.13-rc3' of git://git.kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11ee22df980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3d7dc5eaba6b932f8535
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/565ec42c1d1a/disk-c061cf42.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/142d1c3a6f99/vmlinux-c061cf42.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/b21efab0a38b/bzImage-c061cf42.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com
>>
>>    __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6883
>>    napi_poll net/core/dev.c:6952 [inline]
>>    net_rx_action+0xa94/0x1010 net/core/dev.c:7074
>>    handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
>>    __do_softirq kernel/softirq.c:595 [inline]
>>    invoke_softirq kernel/softirq.c:435 [inline]
>>    __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
>>    irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
>>    common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
>>    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
>> ------------[ cut here ]------------
>> kernel BUG at ./include/linux/mm.h:1221!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>> CPU: 1 UID: 0 PID: 11868 Comm: syz.3.1633 Tainted: G     U             6.13.0-rc3-syzkaller-00062-gc061cf420ded #0
>> Tainted: [U]=USER
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
>> RIP: 0010:folio_entire_mapcount include/linux/mm.h:1221 [inline]
>> RIP: 0010:folio_precise_page_mapcount fs/proc/internal.h:172 [inline]
>> RIP: 0010:kpagecount_read+0x477/0x570 fs/proc/page.c:71
>> Code: 31 ff 49 29 c4 48 8b 44 24 08 4c 01 20 e8 41 77 61 ff eb 92 e8 ca 74 61 ff 48 8b 3c 24 48 c7 c6 20 eb 61 8b e8 6a 34 a8 ff 90 <0f> 0b 4c 89 ff e8 ef de c3 ff e9 5a ff ff ff e8 a5 74 61 ff 48 8b
> 
> Kind of known (at least to me :) ).
> 
> We race with splitting the large folio and end up in
> 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> 
> We could take a speculative reference on the folio to prevent the
> concurrent split ... but I am not really sure it is worth it.
> 

The following should work:

diff --git a/fs/proc/page.c b/fs/proc/page.c
index a55f5acefa974..2868248ffccf6 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -67,10 +67,17 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
                  * memmaps that were actually initialized.
                  */
                 page = pfn_to_online_page(pfn);
-               if (page)
-                       mapcount = folio_precise_page_mapcount(page_folio(page),
-                                                              page);
+               if (!page)
+                       goto write_mapcount;
  
+               folio = page_folio(page);
+               if (!folio_try_get(folio))
+                       goto write_mapcount;
+               if (page_folio(page) == folio)
+                       mapcount = folio_precise_page_mapcount(folio, page);
+               folio_put(folio);
+
+write_mapcount:
                 if (put_user(mapcount, out)) {
                         ret = -EFAULT;
                         break;


In general, I dislike interfaces that can take references
on arbitrary folios. But well, at least this is only accessible to root.

-- 
Cheers,

David / dhildenb


