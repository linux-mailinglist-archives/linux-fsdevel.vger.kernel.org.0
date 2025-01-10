Return-Path: <linux-fsdevel+bounces-38873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FECA094AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2251188D651
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7C21147B;
	Fri, 10 Jan 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFssmNdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0E211279
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521760; cv=none; b=pPNgC/05YyKa4e/bXoIjTQYEBJdEaN068s+XxEq2KfcX8AElSIYLDYzGfnvxHMiTFkFWmZOTvqc2LGzT/mA0CtGQ9L4xpmBuL5Sj5j/kPMhHodvmJPOobqw7oDMeUrQUIa0Tr62Lfduf68FThVxHv2NOqK6UCIl3kQM6RUn0ltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521760; c=relaxed/simple;
	bh=/tt2KoJmJb6LnCSY+eGk3lyOFBtCD20hZHQAqwr/2nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jklYWauRBzUjPbvrgohGKsXdLJaJ55MkJLFlix+ENkFJvyH2noGgs4JbkwgvizaRoEB8lFnHBaPBpppUBEkFkVTiLbwlfG76xh/pf4gPpz02+H9eM9XsTWB+UBZ5s3phWXh9miqX+9DJNABLUdetl1HgEwyOL03RCkFrYbvXlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFssmNdE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736521756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ypvGRdgZwVj2WqOYaMhSleA4cB5rwgUPHAhiCPjwuhI=;
	b=cFssmNdE0bQJTnM+PS3eo8B38a9eIMuNKbZdiGOjvdrsvGQYg0HZmIEvbmLI/Es7mceOE1
	VRzwbZfUKyYGVCVfSua9gVh/UVQRCNnSAJLFyqIEeohBEspAFnXX+1XBiZYV6M1ZTjQFvy
	sO2+LAWOMXyNoU8MnRK4MEiXkeUyxkU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-PQrKxyn7PTOFepiKUKvmqQ-1; Fri, 10 Jan 2025 10:09:14 -0500
X-MC-Unique: PQrKxyn7PTOFepiKUKvmqQ-1
X-Mimecast-MFC-AGG-ID: PQrKxyn7PTOFepiKUKvmqQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso11663995e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 07:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736521754; x=1737126554;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypvGRdgZwVj2WqOYaMhSleA4cB5rwgUPHAhiCPjwuhI=;
        b=t60ZwHXHpuMiIZXABC1KTUndvLMrnFNSQMM5ON8lsfp4mQePpbdejixCnz5e6IWThg
         P1MuyS4yrJSmARBf8Vgc+zGvapoiwoIK8nKNYXCK/TkF2WPVz1HHMivW8QBUYCXneyay
         GizMyIx8k3HMzK8iY0vhjlBPQct1L/3irqZSxFmNLTBzJf38zjVTDsC08mMWiwdnV1tG
         28NN6KY/bEJH8wpwX54QI1utzsRof3nGvzmohDa//pbBv7Dm6a72r8IsIYoP3Q7HQYPo
         5Xnd5BL3EW3ZAwGEEnjIZKna8HbjstCRn032g/4qsaVerC13ukWfbjTgVY2klNffWPHa
         mteA==
X-Forwarded-Encrypted: i=1; AJvYcCVuMToNTO1JsnbIjD8tOEC3X7U+QVUla1lfk8Fkc7wGsXF9eViN5yMcCfNLXGVhPduuUvWakm/q1YhPvAO7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg23Z9W2r0IRepAH/Pls6VrvegIxdnJ/6xXB9txSTpuv6FdX7p
	E6bGUa3U/KYh84ZPHs9kvtpCMcDMIrNhhl8DSrWLvCTalELvnrZrgkC0pTeb5Y/uCKBYaVEwLKR
	or0yz3S/GPqjUkC43ixzmFtKbVtFc/NHFUeKNyiBlQFTSM9QdtmjAKy4P111K1U0=
X-Gm-Gg: ASbGncsYEKFoFkGANVgCVN3VcVe7rlsLL/wT9Br7/iPAvLUea1jPEIh6i+cS1S6ALFi
	nU7e0ulfYpfnKVsb10wjtQLuXVGoBl4mx7bP5WvcohxvSgZdd8IcdD2+ZDi2yzRYfPS9t44PKVM
	4GMV2mlQ7uJKh+7ZEKc2nQM3fbXLLpzKtb4TgDhKEYKc1ChxnPa7edjl/FccGFgiLMqWr3P9oan
	+mtFnrdRZ2y05luyG7DGmCni2a9R8mN98xS3L1JrNtIqQdUBSKwCUczg1CqEfS8mSEZP1BwoW+Q
	Sv7s0uAOBNmGTxosTg0teSvCibxnArvB7sPqkkRnAT0r8sVbHzEJ4lb1RlNKmSwEDdcaJ2GqKaA
	Sbsy51TAH
X-Received: by 2002:a05:600c:19c9:b0:434:f953:eed with SMTP id 5b1f17b1804b1-436e2707babmr116155395e9.30.1736521753564;
        Fri, 10 Jan 2025 07:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC6cono0cIot12KGJCVumBmhiK4fJF087MizgfzrlJY8WZcJuQF5D1nxHo6GKDac5VAQCuEw==
X-Received: by 2002:a05:600c:19c9:b0:434:f953:eed with SMTP id 5b1f17b1804b1-436e2707babmr116154885e9.30.1736521753179;
        Fri, 10 Jan 2025 07:09:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89dfesm89795335e9.32.2025.01.10.07.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:09:12 -0800 (PST)
Message-ID: <500b62d9-8e09-4838-9817-1e2e2216dcdd@redhat.com>
Date: Fri, 10 Jan 2025 16:09:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] kernel BUG in kpagecount_read
To: syzbot <syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67812fbd.050a0220.d0267.0030.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <67812fbd.050a0220.d0267.0030.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 15:33, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c061cf420ded Merge tag 'trace-v6.13-rc3' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ee22df980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
> dashboard link: https://syzkaller.appspot.com/bug?extid=3d7dc5eaba6b932f8535
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/565ec42c1d1a/disk-c061cf42.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/142d1c3a6f99/vmlinux-c061cf42.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b21efab0a38b/bzImage-c061cf42.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com
> 
>   __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6883
>   napi_poll net/core/dev.c:6952 [inline]
>   net_rx_action+0xa94/0x1010 net/core/dev.c:7074
>   handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
>   __do_softirq kernel/softirq.c:595 [inline]
>   invoke_softirq kernel/softirq.c:435 [inline]
>   __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
>   common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
>   asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
> ------------[ cut here ]------------
> kernel BUG at ./include/linux/mm.h:1221!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 11868 Comm: syz.3.1633 Tainted: G     U             6.13.0-rc3-syzkaller-00062-gc061cf420ded #0
> Tainted: [U]=USER
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
> RIP: 0010:folio_entire_mapcount include/linux/mm.h:1221 [inline]
> RIP: 0010:folio_precise_page_mapcount fs/proc/internal.h:172 [inline]
> RIP: 0010:kpagecount_read+0x477/0x570 fs/proc/page.c:71
> Code: 31 ff 49 29 c4 48 8b 44 24 08 4c 01 20 e8 41 77 61 ff eb 92 e8 ca 74 61 ff 48 8b 3c 24 48 c7 c6 20 eb 61 8b e8 6a 34 a8 ff 90 <0f> 0b 4c 89 ff e8 ef de c3 ff e9 5a ff ff ff e8 a5 74 61 ff 48 8b

Kind of known (at least to me :) ).

We race with splitting the large folio and end up in
	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

We could take a speculative reference on the folio to prevent the 
concurrent split ... but I am not really sure it is worth it.

-- 
Cheers,

David / dhildenb


